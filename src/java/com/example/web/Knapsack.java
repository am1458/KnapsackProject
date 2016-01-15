package com.example.web;

import com.uthldap.Uthldap;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Knapsack extends HttpServlet {
    //DATABASE DETAILS
    private static String DB = "jdbc:mysql://localhost:3306/www";
    private static String DBUSER = "www";
    private static String DBPSW = "123!@#";
    private String user;
    private String pass;
    private int role;
    private String firstName, lastName;
    private PrintWriter out;
    private HttpSession session;
    private RequestDispatcher view;
    private Connection conn = null;
    private Statement stmt = null;
    private ResultSet rs = null;
    
    @Override
    public void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {
        
        user = request.getParameter("username");
        pass = request.getParameter("password");
                
        Uthldap ldap = new Uthldap(user,pass);
        
        out = response.getWriter();
        //out.println(user + " " + pass);
        if(ldap.auth()) {
            
            user = (String)ldap.getAttribute("uid");
            firstName = (String)ldap.getAttribute("givenName");
            lastName = (String)ldap.getAttribute("sn");
            try {
                //Connecting to Database.
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(DB, DBUSER, DBPSW);
                stmt = conn.createStatement();
                
                //db query for current user 
                rs = stmt.executeQuery("SELECT * FROM profile WHERE username='" + user + "'");
                
                if (rs.next()) {
                    role = rs.getInt("Role");
                    rs.beforeFirst();
                    if (role != 0) {
                        // Login succesful, start session
                        session = request.getSession();
                        session.setAttribute("user", user);
                        session.setAttribute("role", role);
                        session.setAttribute("firstName", firstName);
                        session.setAttribute("lastName", lastName);
                        
                        //setting session to expiry in 30 mins
                        session.setMaxInactiveInterval(60 * 60);
                        Cookie userName = new Cookie("user", user);
                        userName.setMaxAge(60 * 60);
                        response.addCookie(userName);
                        
                        if (rs.next()) {
                            String id = rs.getString("ID");
                            String username = rs.getString("username");
                            int accounting = rs.getInt("accounting");
                            accounting++;
                            out.println("ID: " + id + " Login Counter: " + accounting + " Username: " + username);
                            PreparedStatement pstmt = conn.prepareStatement("UPDATE profile SET Accounting=? WHERE ID=?");
                            pstmt.setInt(1, accounting);
                            pstmt.setString(2, id);
                            boolean result = pstmt.execute();
                            if (!result) {
                                System.out.println("ERROR: Wrong Query");
                            }
                            
                            response.sendRedirect("KnapsackIndex.jsp");
                        }
                    } else {
                        out.println("You are a blocked user on our site!");
                        out.println("Please contact an administrator, to be able to login again!");
                    }
                } else {
                    //If user doesn't exist in my database, try to add him!
                    out.println("Adding user to database...");
                    /*Available Roles
                     - 0 => Disabled User    (User that we don't count his login or block him on our 
                                              site neither backend nor frontend).
                     - 1 => Simple User      (User that has only minor privilleges, only frontend).
                     - 2 => Administrator    (User that has full access to the backend & frontend).
                    */
                    
                    /*  Database fields:
                            ID, Role, Login_type, Accounting, username, firstName, lastName
                    */
                    String insertQuery = "INSERT INTO profile" +
                                         "(Role, Login_type, Accounting, username, firstName, lastName)" +
                                         "VALUES (?, ?, ?, ?, ?, ?)";
                    PreparedStatement pstmt = conn.prepareStatement(insertQuery);
                    pstmt.setInt(1, 1); //Default role for users
                    pstmt.setInt(2, 0); //Login_type = 0 for users from uth
                    pstmt.setInt(3, 1); //The number of times he has logged in
                    pstmt.setString(4, user); //User's username
                    pstmt.setString(5, firstName); //User's firstName attribute
                    pstmt.setString(6, lastName); //User's lastName attribute
                    
                    /*
                        execute: Returns true if there is a resultSet object, like select
                                 Returns false if the query is an updating one, like insert or update.
                                 Throws Exception if there is something wrong with the query.
                    */
                    boolean result = pstmt.execute();
                    
                    /*
                        if query is insert and it succeeds then add user correctly!
                    */
                    if (!result) {
                        out.println("User " + user + " was added successfully");
                        role = 1;
                        session = request.getSession();
                        session.setAttribute("user", user);
                        session.setAttribute("role", role);
                        session.setAttribute("firstName", firstName);
                        session.setAttribute("lastName", lastName);
                        
                        //setting session to expiry in 30 mins
                        session.setMaxInactiveInterval(60 * 60);
                        Cookie userName = new Cookie("user", user);
                        userName.setMaxAge(60 * 60);
                        response.addCookie(userName);     
                        
                        response.sendRedirect("KnapsackIndex.jsp");
                    }
                }
            } catch (SQLException sqle) {
                out.print("SQL Exception");
            } catch (ClassNotFoundException cnfe) {
                out.print("Class not found Exception");
            }
        } else {
            out.println("<html><body>Authetication failed</body></html>");
        }
    }
}