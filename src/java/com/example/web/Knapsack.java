package com.example.web;

import com.uthldap.Uthldap;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
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
    private static final String DB = "jdbc:mysql://localhost:3306/knapsack";
    private static final String DBUSER = "ilias";
    private static final String DBPSW = "123!@#";
    private String user;
    private String pass;
    private PrintWriter out;
    private HttpSession session;
    private RequestDispatcher view;
    private String firstName, lastName;
    
    @Override
    public void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        //connect to database
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(DB, DBUSER, DBPSW);
        } catch (ClassNotFoundException | SQLException ex) {
            //Logger.getLogger(Authservlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        user = request.getParameter("username");
        pass = request.getParameter("password");
                
        Uthldap ldap = new Uthldap(user,pass);
        
        firstName = (String)ldap.getAttribute("givenName");
        lastName = (String)ldap.getAttribute("sn");
        
        out = response.getWriter();
        //out.println(user + " " + pass);
        if(ldap.auth()) {
            // Login succesful, start session
            session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("firstName", firstName);
            session.setAttribute("lastName", lastName);
            //out.print(firstName + " " + lastName);
            //session.setAttribute("role", role);

            //setting session to expiry in 30 mins
            session.setMaxInactiveInterval(60 * 60);
            Cookie userName = new Cookie("user", user);
            userName.setMaxAge(60 * 60);
            response.addCookie(userName);
            
            response.sendRedirect("KnapsackIndex.jsp");
            //view = request.getRequestDispatcher("KnapsackIndex.jsp");
            //view.forward(request, response);
        } else {
            out.println("<html><body>Authetication failed</body></html>");
        }
    }
}