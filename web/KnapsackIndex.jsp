<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <!--Code: Ilias Flokas 1458 flokas@inf.uth.gr-->
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>EA - Knapsack</title>
        
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
        
        <center><h3>Επέλεξε από την παρακάτω λίστα ώρες λειτουργίας για όποιες ηλεκτρικές συσκευές σε αφορούνε:</h3></center>
        <center>
        <form action="result" method="POST">
            <hr>
            <table style="width: 50%" class = "table table-hover">
                <tr>
                    <td>Κουζίνα:</td>
                    <td>
                        <select name="stove">
                            <option value="0">0 ώρες</option>
                            <option value="1">1 ώρες</option>
                            <option value="2">2 ώρες</option>
                            <option value="3">3 ώρες</option>
                            <option value="4">4 ώρες</option>
                            <option value="5">5 ώρες</option>
                            <option value="6">6 ώρες</option>
                            <option value="7">7 ώρες</option>
                            <option value="8">8 ώρες</option>
                            <option value="9">9 ώρες</option>
                            <option value="10">10 ώρες</option>
                            <option value="11">11 ώρες</option>
                            <option value="12">12 ώρες</option>
                            <option value="13">13 ώρες</option>
                            <option value="14">14 ώρες</option>
                            <option value="15">15 ώρες</option>
                            <option value="16">16 ώρες</option>
                            <option value="17">17 ώρες</option>
                            <option value="18">18 ώρες</option>
                            <option value="19">19 ώρες</option>
                            <option value="20">20 ώρες</option>
                            <option value="21">21 ώρες</option>
                            <option value="22">22 ώρες</option>
                            <option value="23">23 ώρες</option>
                            <option value="24">24 ώρες</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Φούρνος:</td>
                    <td>
                        <select name="oven">
                            <option value="0">0 ώρες</option>
                            <option value="1">1 ώρες</option>
                            <option value="2">2 ώρες</option>
                            <option value="3">3 ώρες</option>
                            <option value="4">4 ώρες</option>
                            <option value="5">5 ώρες</option>
                            <option value="6">6 ώρες</option>
                            <option value="7">7 ώρες</option>
                            <option value="8">8 ώρες</option>
                            <option value="9">9 ώρες</option>
                            <option value="10">10 ώρες</option>
                            <option value="11">11 ώρες</option>
                            <option value="12">12 ώρες</option>
                            <option value="13">13 ώρες</option>
                            <option value="14">14 ώρες</option>
                            <option value="15">15 ώρες</option>
                            <option value="16">16 ώρες</option>
                            <option value="17">17 ώρες</option>
                            <option value="18">18 ώρες</option>
                            <option value="19">19 ώρες</option>
                            <option value="20">20 ώρες</option>
                            <option value="21">21 ώρες</option>
                            <option value="22">22 ώρες</option>
                            <option value="23">23 ώρες</option>
                            <option value="24">24 ώρες</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Απορροφητήρας:</td>
                    <td>
                        <select name="vent">
                            <option value="0">0 ώρες</option>
                            <option value="1">1 ώρες</option>
                            <option value="2">2 ώρες</option>
                            <option value="3">3 ώρες</option>
                            <option value="4">4 ώρες</option>
                            <option value="5">5 ώρες</option>
                            <option value="6">6 ώρες</option>
                            <option value="7">7 ώρες</option>
                            <option value="8">8 ώρες</option>
                            <option value="9">9 ώρες</option>
                            <option value="10">10 ώρες</option>
                            <option value="11">11 ώρες</option>
                            <option value="12">12 ώρες</option>
                            <option value="13">13 ώρες</option>
                            <option value="14">14 ώρες</option>
                            <option value="15">15 ώρες</option>
                            <option value="16">16 ώρες</option>
                            <option value="17">17 ώρες</option>
                            <option value="18">18 ώρες</option>
                            <option value="19">19 ώρες</option>
                            <option value="20">20 ώρες</option>
                            <option value="21">21 ώρες</option>
                            <option value="22">22 ώρες</option>
                            <option value="23">23 ώρες</option>
                            <option value="24">24 ώρες</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Πλυντήριο Πιάτων:</td>
                    <td>
                        <select name="dishWasher">
                            <option value="0">0 ώρες</option>
                            <option value="1">1 ώρες</option>
                            <option value="2">2 ώρες</option>
                            <option value="3">3 ώρες</option>
                            <option value="4">4 ώρες</option>
                            <option value="5">5 ώρες</option>
                            <option value="6">6 ώρες</option>
                            <option value="7">7 ώρες</option>
                            <option value="8">8 ώρες</option>
                            <option value="9">9 ώρες</option>
                            <option value="10">10 ώρες</option>
                            <option value="11">11 ώρες</option>
                            <option value="12">12 ώρες</option>
                            <option value="13">13 ώρες</option>
                            <option value="14">14 ώρες</option>
                            <option value="15">15 ώρες</option>
                            <option value="16">16 ώρες</option>
                            <option value="17">17 ώρες</option>
                            <option value="18">18 ώρες</option>
                            <option value="19">19 ώρες</option>
                            <option value="20">20 ώρες</option>
                            <option value="21">21 ώρες</option>
                            <option value="22">22 ώρες</option>
                            <option value="23">23 ώρες</option>
                            <option value="24">24 ώρες</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Φούρνος Μικροκυμάτων:</td>
                    <td>
                        <select name="microwave">
                            <option value="0">0 ώρες</option>
                            <option value="1">1 ώρες</option>
                            <option value="2">2 ώρες</option>
                            <option value="3">3 ώρες</option>
                            <option value="4">4 ώρες</option>
                            <option value="5">5 ώρες</option>
                            <option value="6">6 ώρες</option>
                            <option value="7">7 ώρες</option>
                            <option value="8">8 ώρες</option>
                            <option value="9">9 ώρες</option>
                            <option value="10">10 ώρες</option>
                            <option value="11">11 ώρες</option>
                            <option value="12">12 ώρες</option>
                            <option value="13">13 ώρες</option>
                            <option value="14">14 ώρες</option>
                            <option value="15">15 ώρες</option>
                            <option value="16">16 ώρες</option>
                            <option value="17">17 ώρες</option>
                            <option value="18">18 ώρες</option>
                            <option value="19">19 ώρες</option>
                            <option value="20">20 ώρες</option>
                            <option value="21">21 ώρες</option>
                            <option value="22">22 ώρες</option>
                            <option value="23">23 ώρες</option>
                            <option value="24">24 ώρες</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Μίξερ</td>
                    <td>
                        <select name="mixer">
                            <option value="0">0 ώρες</option>
                            <option value="1">1 ώρες</option>
                            <option value="2">2 ώρες</option>
                            <option value="3">3 ώρες</option>
                            <option value="4">4 ώρες</option>
                            <option value="5">5 ώρες</option>
                            <option value="6">6 ώρες</option>
                            <option value="7">7 ώρες</option>
                            <option value="8">8 ώρες</option>
                            <option value="9">9 ώρες</option>
                            <option value="10">10 ώρες</option>
                            <option value="11">11 ώρες</option>
                            <option value="12">12 ώρες</option>
                            <option value="13">13 ώρες</option>
                            <option value="14">14 ώρες</option>
                            <option value="15">15 ώρες</option>
                            <option value="16">16 ώρες</option>
                            <option value="17">17 ώρες</option>
                            <option value="18">18 ώρες</option>
                            <option value="19">19 ώρες</option>
                            <option value="20">20 ώρες</option>
                            <option value="21">21 ώρες</option>
                            <option value="22">22 ώρες</option>
                            <option value="23">23 ώρες</option>
                            <option value="24">24 ώρες</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Καφετιέρα:</td>
                    <td>
                        <select name="coffee">
                            <option value="0">0 ώρες</option>
                            <option value="1">1 ώρες</option>
                            <option value="2">2 ώρες</option>
                            <option value="3">3 ώρες</option>
                            <option value="4">4 ώρες</option>
                            <option value="5">5 ώρες</option>
                            <option value="6">6 ώρες</option>
                            <option value="7">7 ώρες</option>
                            <option value="8">8 ώρες</option>
                            <option value="9">9 ώρες</option>
                            <option value="10">10 ώρες</option>
                            <option value="11">11 ώρες</option>
                            <option value="12">12 ώρες</option>
                            <option value="13">13 ώρες</option>
                            <option value="14">14 ώρες</option>
                            <option value="15">15 ώρες</option>
                            <option value="16">16 ώρες</option>
                            <option value="17">17 ώρες</option>
                            <option value="18">18 ώρες</option>
                            <option value="19">19 ώρες</option>
                            <option value="20">20 ώρες</option>
                            <option value="21">21 ώρες</option>
                            <option value="22">22 ώρες</option>
                            <option value="23">23 ώρες</option>
                            <option value="24">24 ώρες</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Τοστιέρα:</td>
                    <td>
                        <select name="toaster">
                            <option value="0">0 ώρες</option>
                            <option value="1">1 ώρες</option>
                            <option value="2">2 ώρες</option>
                            <option value="3">3 ώρες</option>
                            <option value="4">4 ώρες</option>
                            <option value="5">5 ώρες</option>
                            <option value="6">6 ώρες</option>
                            <option value="7">7 ώρες</option>
                            <option value="8">8 ώρες</option>
                            <option value="9">9 ώρες</option>
                            <option value="10">10 ώρες</option>
                            <option value="11">11 ώρες</option>
                            <option value="12">12 ώρες</option>
                            <option value="13">13 ώρες</option>
                            <option value="14">14 ώρες</option>
                            <option value="15">15 ώρες</option>
                            <option value="16">16 ώρες</option>
                            <option value="17">17 ώρες</option>
                            <option value="18">18 ώρες</option>
                            <option value="19">19 ώρες</option>
                            <option value="20">20 ώρες</option>
                            <option value="21">21 ώρες</option>
                            <option value="22">22 ώρες</option>
                            <option value="23">23 ώρες</option>
                            <option value="24">24 ώρες</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Ηλεκτρικό Σκουπάκι:</td>
                    <td>
                        <select name="electricSweeper">
                            <option value="0">0 ώρες</option>
                            <option value="1">1 ώρες</option>
                            <option value="2">2 ώρες</option>
                            <option value="3">3 ώρες</option>
                            <option value="4">4 ώρες</option>
                            <option value="5">5 ώρες</option>
                            <option value="6">6 ώρες</option>
                            <option value="7">7 ώρες</option>
                            <option value="8">8 ώρες</option>
                            <option value="9">9 ώρες</option>
                            <option value="10">10 ώρες</option>
                            <option value="11">11 ώρες</option>
                            <option value="12">12 ώρες</option>
                            <option value="13">13 ώρες</option>
                            <option value="14">14 ώρες</option>
                            <option value="15">15 ώρες</option>
                            <option value="16">16 ώρες</option>
                            <option value="17">17 ώρες</option>
                            <option value="18">18 ώρες</option>
                            <option value="19">19 ώρες</option>
                            <option value="20">20 ώρες</option>
                            <option value="21">21 ώρες</option>
                            <option value="22">22 ώρες</option>
                            <option value="23">23 ώρες</option>
                            <option value="24">24 ώρες</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Ηλεκτρική Σκούπα:</td>
                    <td>
                        <select name="vacuumCleaner">
                            <option value="0">0 ώρες</option>
                            <option value="1">1 ώρες</option>
                            <option value="2">2 ώρες</option>
                            <option value="3">3 ώρες</option>
                            <option value="4">4 ώρες</option>
                            <option value="5">5 ώρες</option>
                            <option value="6">6 ώρες</option>
                            <option value="7">7 ώρες</option>
                            <option value="8">8 ώρες</option>
                            <option value="9">9 ώρες</option>
                            <option value="10">10 ώρες</option>
                            <option value="11">11 ώρες</option>
                            <option value="12">12 ώρες</option>
                            <option value="13">13 ώρες</option>
                            <option value="14">14 ώρες</option>
                            <option value="15">15 ώρες</option>
                            <option value="16">16 ώρες</option>
                            <option value="17">17 ώρες</option>
                            <option value="18">18 ώρες</option>
                            <option value="19">19 ώρες</option>
                            <option value="20">20 ώρες</option>
                            <option value="21">21 ώρες</option>
                            <option value="22">22 ώρες</option>
                            <option value="23">23 ώρες</option>
                            <option value="24">24 ώρες</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Βραστήρας:</td>
                    <td>
                        <select name="boiler">
                            <option value="0">0 ώρες</option>
                            <option value="1">1 ώρες</option>
                            <option value="2">2 ώρες</option>
                            <option value="3">3 ώρες</option>
                            <option value="4">4 ώρες</option>
                            <option value="5">5 ώρες</option>
                            <option value="6">6 ώρες</option>
                            <option value="7">7 ώρες</option>
                            <option value="8">8 ώρες</option>
                            <option value="9">9 ώρες</option>
                            <option value="10">10 ώρες</option>
                            <option value="11">11 ώρες</option>
                            <option value="12">12 ώρες</option>
                            <option value="13">13 ώρες</option>
                            <option value="14">14 ώρες</option>
                            <option value="15">15 ώρες</option>
                            <option value="16">16 ώρες</option>
                            <option value="17">17 ώρες</option>
                            <option value="18">18 ώρες</option>
                            <option value="19">19 ώρες</option>
                            <option value="20">20 ώρες</option>
                            <option value="21">21 ώρες</option>
                            <option value="22">22 ώρες</option>
                            <option value="23">23 ώρες</option>
                            <option value="24">24 ώρες</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Πλυντήριο:</td>
                    <td>
                        <select name="washingMachine">
                            <option value="0">0 ώρες</option>
                            <option value="1">1 ώρες</option>
                            <option value="2">2 ώρες</option>
                            <option value="3">3 ώρες</option>
                            <option value="4">4 ώρες</option>
                            <option value="5">5 ώρες</option>
                            <option value="6">6 ώρες</option>
                            <option value="7">7 ώρες</option>
                            <option value="8">8 ώρες</option>
                            <option value="9">9 ώρες</option>
                            <option value="10">10 ώρες</option>
                            <option value="11">11 ώρες</option>
                            <option value="12">12 ώρες</option>
                            <option value="13">13 ώρες</option>
                            <option value="14">14 ώρες</option>
                            <option value="15">15 ώρες</option>
                            <option value="16">16 ώρες</option>
                            <option value="17">17 ώρες</option>
                            <option value="18">18 ώρες</option>
                            <option value="19">19 ώρες</option>
                            <option value="20">20 ώρες</option>
                            <option value="21">21 ώρες</option>
                            <option value="22">22 ώρες</option>
                            <option value="23">23 ώρες</option>
                            <option value="24">24 ώρες</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Στεγνωτήριο:</td>
                    <td>
                        <select name="dryer">
                            <option value="0">0 ώρες</option>
                            <option value="1">1 ώρες</option>
                            <option value="2">2 ώρες</option>
                            <option value="3">3 ώρες</option>
                            <option value="4">4 ώρες</option>
                            <option value="5">5 ώρες</option>
                            <option value="6">6 ώρες</option>
                            <option value="7">7 ώρες</option>
                            <option value="8">8 ώρες</option>
                            <option value="9">9 ώρες</option>
                            <option value="10">10 ώρες</option>
                            <option value="11">11 ώρες</option>
                            <option value="12">12 ώρες</option>
                            <option value="13">13 ώρες</option>
                            <option value="14">14 ώρες</option>
                            <option value="15">15 ώρες</option>
                            <option value="16">16 ώρες</option>
                            <option value="17">17 ώρες</option>
                            <option value="18">18 ώρες</option>
                            <option value="19">19 ώρες</option>
                            <option value="20">20 ώρες</option>
                            <option value="21">21 ώρες</option>
                            <option value="22">22 ώρες</option>
                            <option value="23">23 ώρες</option>
                            <option value="24">24 ώρες</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Ψυγείο:</td>
                    <td>
                        <select name="fridge">
                            <option value="0">0 ώρες</option>
                            <option value="1">1 ώρες</option>
                            <option value="2">2 ώρες</option>
                            <option value="3">3 ώρες</option>
                            <option value="4">4 ώρες</option>
                            <option value="5">5 ώρες</option>
                            <option value="6">6 ώρες</option>
                            <option value="7">7 ώρες</option>
                            <option value="8">8 ώρες</option>
                            <option value="9">9 ώρες</option>
                            <option value="10">10 ώρες</option>
                            <option value="11">11 ώρες</option>
                            <option value="12">12 ώρες</option>
                            <option value="13">13 ώρες</option>
                            <option value="14">14 ώρες</option>
                            <option value="15">15 ώρες</option>
                            <option value="16">16 ώρες</option>
                            <option value="17">17 ώρες</option>
                            <option value="18">18 ώρες</option>
                            <option value="19">19 ώρες</option>
                            <option value="20">20 ώρες</option>
                            <option value="21">21 ώρες</option>
                            <option value="22">22 ώρες</option>
                            <option value="23">23 ώρες</option>
                            <option value="24">24 ώρες</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Κλιματιστικό:</td>
                    <td>
                        <select name="airCondition">
                            <option value="0">0 ώρες</option>
                            <option value="1">1 ώρες</option>
                            <option value="2">2 ώρες</option>
                            <option value="3">3 ώρες</option>
                            <option value="4">4 ώρες</option>
                            <option value="5">5 ώρες</option>
                            <option value="6">6 ώρες</option>
                            <option value="7">7 ώρες</option>
                            <option value="8">8 ώρες</option>
                            <option value="9">9 ώρες</option>
                            <option value="10">10 ώρες</option>
                            <option value="11">11 ώρες</option>
                            <option value="12">12 ώρες</option>
                            <option value="13">13 ώρες</option>
                            <option value="14">14 ώρες</option>
                            <option value="15">15 ώρες</option>
                            <option value="16">16 ώρες</option>
                            <option value="17">17 ώρες</option>
                            <option value="18">18 ώρες</option>
                            <option value="19">19 ώρες</option>
                            <option value="20">20 ώρες</option>
                            <option value="21">21 ώρες</option>
                            <option value="22">22 ώρες</option>
                            <option value="23">23 ώρες</option>
                            <option value="24">24 ώρες</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Καλοριφέρ:</td>
                    <td>
                        <select name="radiator">
                            <option value="0">0 ώρες</option>
                            <option value="1">1 ώρες</option>
                            <option value="2">2 ώρες</option>
                            <option value="3">3 ώρες</option>
                            <option value="4">4 ώρες</option>
                            <option value="5">5 ώρες</option>
                            <option value="6">6 ώρες</option>
                            <option value="7">7 ώρες</option>
                            <option value="8">8 ώρες</option>
                            <option value="9">9 ώρες</option>
                            <option value="10">10 ώρες</option>
                            <option value="11">11 ώρες</option>
                            <option value="12">12 ώρες</option>
                            <option value="13">13 ώρες</option>
                            <option value="14">14 ώρες</option>
                            <option value="15">15 ώρες</option>
                            <option value="16">16 ώρες</option>
                            <option value="17">17 ώρες</option>
                            <option value="18">18 ώρες</option>
                            <option value="19">19 ώρες</option>
                            <option value="20">20 ώρες</option>
                            <option value="21">21 ώρες</option>
                            <option value="22">22 ώρες</option>
                            <option value="23">23 ώρες</option>
                            <option value="24">24 ώρες</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input style="width:100%" type="text" placeholder="Max amount you are willing to pay." required="" name="maxMoney">
                    </td>
                </tr>
            </table>
            
            <hr>
            <input type="submit" value="Υπολογισμός">
            <input type="reset" value="Καθαρισμός Επιλογών">
            <br><br>
        </form>
        </center>
        
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>
    </body>
</html>
