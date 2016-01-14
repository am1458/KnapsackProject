<%-- 
    Document   : userProfile
    Created on : Jan 14, 2016, 10:09:01 PM
    Author     : Themake
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Προφίλ Χρήστη</title>
    </head>
    <body>
        <%
            //allow access only if session exists
            String user = null;
            String firstname = null;
            String lastname = null;
            if (session.getAttribute("user") == null) {
                response.sendRedirect("index.jsp");
            } else {
                firstname = (String)session.getAttribute("firstName");
                lastname = (String)session.getAttribute("lastName");
                user = (String) session.getAttribute("user");
                session.setAttribute("user", user);
                session.setAttribute("firstName", firstname);
                session.setAttribute("lastName", lastname);
            }
            String userName = null;
            String sessionID = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("user")) {
                        userName = cookie.getValue();
                    }
                    if (cookie.getName().equals("JSESSIONID")) {
                        sessionID = cookie.getValue();
                    }
                }
            }
        %>
        
        <center><h1>Electric Appliances (EA) Knapsack</h1></center>
        
        <center>
        <table border="0" style="text-align: center; " cellspacing="0" cellpadding="0" width="100%">
            <td> <a href="userProfile.jsp">Προφίλ χρήστη</a> </td>
            <td> <a href="usersList.jsp">Εμφάνιση λίστας χρηστών</a> </td>
            <td> <%=user%> </td>
            <td> 
                <form action="Logout" method="post">
                    <input  id="logoutid" class="btn btn-primary" type="submit" value="Logout" >
                </form>
            </td>
        </table>
        </center>
            
        <hr>
        
        <table border="1" style="width: 100%;text-align: center;">
            <tr>
                <td>Όνομα</td>
                <td>Επώνυμο</td>
                <td>Όνομα Χρήστη</td>
            </tr>
            <tr>
                <td><%= firstname %></td>
                <td><%= lastname %></td>
                <td><%= user %></td>
            </tr>
        </table>
    </body>
</html>
