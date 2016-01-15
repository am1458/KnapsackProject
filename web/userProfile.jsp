<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Προφίλ Χρήστη</title>
                
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
        <link href="css/main.css" rel="stylesheet" type="text/css"/>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <%
            //allow access only if session exists
            String user = null;
            String firstname = null;
            String lastname = null;
            int role;
            if (session.getAttribute("user") == null) {
                response.sendRedirect("index.jsp");
            } else {
                firstname = (String)session.getAttribute("firstName");
                lastname = (String)session.getAttribute("lastName");
                user = (String) session.getAttribute("user");
                role = (int) session.getAttribute("role");
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
        
        <center><a href="KnapsackIndex.jsp"><h1>Electric Appliances (EA) Knapsack</h1></a></center>
        
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
        
        <center><table class = "table table-hover" border="1" style="width: 80%;text-align: center;">
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
        </table></center>
                        
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>
    </body>
</html>
