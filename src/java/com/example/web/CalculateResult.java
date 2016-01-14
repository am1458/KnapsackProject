package com.example.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CalculateResult  extends HttpServlet {
    private PrintWriter out;
    private int allZero;
    private double MAX_MONEY;
    private double remaining;
    private static final double KWHPRICE = 0.5;
    private static final int APPLIANCES_NUMBER = 16;
    private int[] eAHours = new int[APPLIANCES_NUMBER];
    private String[] eANames = new String[APPLIANCES_NUMBER];
    private int[] eAWatt = new int[APPLIANCES_NUMBER];
    private double[] eACost = new double[APPLIANCES_NUMBER];
    private HttpSession session;
    
    @Override
    public void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("text/html; charset=utf-8");
                
        out = response.getWriter();
        
        // ######################################################
        //Play with sessions & cookies
        //allow access only if session exists
        String user = null;
        session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("index.jsp");
        } else {
            user = (String) session.getAttribute("user");
            session.setAttribute("user", user);
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
        // ######################################################
        
        out.print("<center><h1>Electric Appliances (EA) Knapsack</h1></center>");
        
        out.print("<center>");
        out.print("<table border='0' style='text-align: center; ' cellspacing='0' cellpadding='0' width='100%'>");
            out.print("<td> <a href='#'>Προφίλ χρήστη</a> </td>");
            out.print("<td> <a href='usersList.jsp'>Εμφάνιση λίστας χρηστών</a> </td>");
            out.print("<td>" + user + "</td>");
            out.print("<td>"); 
                out.print("<form action='Logout' method='post'>");
                    out.print("<input  id='logoutid' class='btn btn-primary' type='submit' value='Logout' >");
                out.print("</form>");
            out.print("</td>");
        out.print("</table>");
        out.print("</center>");
        out.print("<hr>");
        
        try {
            MAX_MONEY = Double.parseDouble(request.getParameter("maxMoney"));
            remaining = MAX_MONEY;
        } catch(NumberFormatException e) {
            out.println("Expected Integer Value!");
            return;
        }
             
        // Array Variables Initialization
        //#######################################
        eAHours[0] = Integer.parseInt(request.getParameter("stove"));
        eAHours[1] = Integer.parseInt(request.getParameter("oven"));
        eAHours[2] = Integer.parseInt(request.getParameter("vent"));
        eAHours[3] = Integer.parseInt(request.getParameter("dishWasher"));
        eAHours[4] = Integer.parseInt(request.getParameter("microwave"));
        eAHours[5] = Integer.parseInt(request.getParameter("mixer"));
        eAHours[6] = Integer.parseInt(request.getParameter("coffee"));
        eAHours[7] = Integer.parseInt(request.getParameter("toaster"));
        eAHours[8] = Integer.parseInt(request.getParameter("electricSweeper"));
        eAHours[9] = Integer.parseInt(request.getParameter("vacuumCleaner"));
        eAHours[10] = Integer.parseInt(request.getParameter("boiler"));
        eAHours[11] = Integer.parseInt(request.getParameter("washingMachine"));
        eAHours[12] = Integer.parseInt(request.getParameter("dryer"));
        eAHours[13] = Integer.parseInt(request.getParameter("fridge"));
        eAHours[14] = Integer.parseInt(request.getParameter("airCondition"));
        eAHours[15] = Integer.parseInt(request.getParameter("radiator"));
        for (int i = 0; i < eAHours.length; i++) {
            if(eAHours[i] == 0) {
                allZero++;
            }
        }
        if(allZero == 16) {
            out.print("<center>"
                    + "<h1>"
                    + "Ξαναδοκίμασε αφού δώσεις ώρες λειτουργίας για τουλάχιστον μία συσκευή!"
                    + "</h1>"
                    + "</center>");
            out.print("<center>"
                    + "<a style='text-decoration:none;' href='KnapsackIndex.jsp'>"
                    + "Go Back"
                    + "</a>"
                    + "</center>");
            return;
        }
        //#######################################
        eANames[0] = "Κουζίνα";
        eANames[1] = "Φούρνος";
        eANames[2] = "Απορροφητήρας";
        eANames[3] = "Πλυντήριο Πιάτων";
        eANames[4] = "Φούρνος Μικροκυμάτων";
        eANames[5] = "Μίξερ";
        eANames[6] = "Καφετιέρα";
        eANames[7] = "Τοστιέρα";
        eANames[8] = "Ηλεκτρικό Σκουπάκι";
        eANames[9] = "Ηλεκτρική Σκούπα";
        eANames[10] = "Βραστήρας";
        eANames[11] = "Πλυντήριο";
        eANames[12] = "Στεγνωτήριο";
        eANames[13] = "Ψυγείο";
        eANames[14] = "Κλιματιστικό";
        eANames[15] = "Καλοριφέρ";
        //#######################################
        // Most of the values were taken 
        // from: http://www.wholesalesolar.com/solar-information/how-to-save-energy/power-table
        // and: http://www.energy.gov/energysaver/estimating-appliance-and-home-electronic-energy-use
        // also some google searches helped.
        eAWatt[0] = 4000;
        eAWatt[1] = 3000;
        eAWatt[2] = 80;
        eAWatt[3] = 330;
        eAWatt[4] = 1500;
        eAWatt[5] = 750;
        eAWatt[6] = 1000;
        eAWatt[7] = 1100;
        eAWatt[8] = 300;
        eAWatt[9] = 542;
        eAWatt[10] = 1500;
        eAWatt[11] = 700;
        eAWatt[12] = 3400;
        eAWatt[13] = 1300;
        eAWatt[14] = 5000;
        eAWatt[15] = 1500;
        //END of Initializations
        //Array Variable Calculations
        //###############################################
        eACost[0] = eAWatt[0]/1000D * eAHours[0] * KWHPRICE;
        eACost[1] = eAWatt[1]/1000D * eAHours[1] * KWHPRICE;
        eACost[2] = eAWatt[2]/1000D * eAHours[2] * KWHPRICE;
        eACost[3] = eAWatt[3]/1000D * eAHours[3] * KWHPRICE;
        eACost[4] = eAWatt[4]/1000D * eAHours[4] * KWHPRICE;
        eACost[5] = eAWatt[5]/1000D * eAHours[5] * KWHPRICE;
        eACost[6] = eAWatt[6]/1000D * eAHours[6] * KWHPRICE;
        eACost[7] = eAWatt[7]/1000D * eAHours[7] * KWHPRICE;
        eACost[8] = eAWatt[8]/1000D * eAHours[8] * KWHPRICE;
        eACost[9] = eAWatt[9]/1000D * eAHours[9] * KWHPRICE;
        eACost[10] = eAWatt[10]/1000D * eAHours[10] * KWHPRICE;
        eACost[11] = eAWatt[11]/1000D * eAHours[10] * KWHPRICE;
        eACost[12] = eAWatt[12]/1000D * eAHours[12] * KWHPRICE;
        eACost[13] = eAWatt[13]/1000D * eAHours[13] * KWHPRICE;
        eACost[14] = eAWatt[14]/1000D * eAHours[14] * KWHPRICE;
        eACost[15] = eAWatt[15]/1000D * eAHours[15] * KWHPRICE;
                
        //Test Print for QuickSort
        /*for (int i = 0; i <= APPLIANCES_NUMBER - 1; i++) {
            out.print(eANames[i] + ": " + eAHours[i] + " hours " + eAWatt[i] + " Watt " + eACost[i] + " Euro<br>");
        }*/
        quickSort(eACost, eAHours, eAWatt, eANames, 0, APPLIANCES_NUMBER - 1);
        /*out.print("<hr>");
        for (int i = 0; i <= APPLIANCES_NUMBER - 1; i++) {
            out.print(eANames[i] + ": " + eAHours[i] + " hours " + eAWatt[i] + " Watt " + eACost[i] + " Euro<br>");
        }*/
        
        // Knapsack Algorithm call here!
        Knapsack(eACost, eAHours, eAWatt, eANames);
    }
    
    // The Code for the quicksort below was taken from: 
    // http://stackoverflow.com/questions/2316555/quicksort-not-sorting
    // and was modified/extended to accept and sort 4 arrays instead of one.
    private void swapDouble (double[] a, int i, int j) {
        double t = a[i];
        a[i] = a[j];
        a[j] = t;
    }
    
    private void swapInt (int[] a, int i, int j) {
        int t = a[i];
        a[i] = a[j];
        a[j] = t;
    }
    
    private void swapString (String[] a, int i, int j) {
        String t = a[i];
        a[i] = a[j];
        a[j] = t;
    }
    
    private void quickSort (double[] cost, int[] hour, int[] watt, String[] names, int left, int right) {
        if (left < right) {
            int pivotIndex = (left+right)/2;
            int pos = partition(cost, hour, watt, names, left, right, pivotIndex);
            quickSort(cost, hour, watt, names, left, pos-1);
            quickSort(cost, hour, watt, names, pos+1, right);
        }
    }

    private int partition (double[] cost, int[] hour, int[] watt, String[] names, int left, int right, int pivotIndex) {
        swapDouble(cost, pivotIndex, right);
        swapInt(hour, pivotIndex, right);
        swapInt(watt, pivotIndex, right);
        swapString(names, pivotIndex, right);
        int pos = left;//represents boundary between small and large elements
        for(int i = left; i < right; i++) {
            if (cost[i] < cost[right]) {
                swapDouble(cost, i, pos);
                swapInt(hour, i, pos);
                swapInt(watt, i, pos);
                swapString(names, i, pos);
                pos++;
            }
        }
        swapDouble(cost, right, pos);
        swapInt(hour, right, pos);
        swapInt(watt, right, pos);
        swapString(names, right, pos);
        return pos;
    }
    
    // My Algorithm for Knapsack and other functions to improve coding.
    private void Knapsack(double[] cost, int[] hours, int[] watt, String[] names) {
        double [] fraction = new double[APPLIANCES_NUMBER];
        int numberOfAppliances = 0;
        double totalHours = 0.0;
        double totalCost = 0.0;
        ArrayList<Integer> wattList = new ArrayList<>();
        ArrayList<String> namesList = new ArrayList<>();
        ArrayList<Double> hoursList = new ArrayList<>();
                
        fraction = createFractionArray (cost);
        
        for (int i = 0; i <= APPLIANCES_NUMBER - 1; i++) {
            if (cost[i] != 0) {
                if (remaining - cost[i] > 0) {
                    numberOfAppliances++;
                    totalCost += cost[i];
                    totalHours += 1.0 * hours[i];
                    hoursList.add(1.0 * hours[i]);
                    remaining -= cost[i];
                } else if (remaining - cost[i] < 0) {
                    numberOfAppliances++;
                    totalCost += remaining;
                    totalHours += remaining * hours[i] / cost[i];
                    hoursList.add(remaining * hours[i] / cost[i]);
                    remaining = 0;
                } else {
                    break;
                }
                namesList.add(names[i]);
                wattList.add(watt[i]);
            } else {
                continue;
            }
        }
        
        printResultData(numberOfAppliances, namesList, wattList, hoursList, totalHours, totalCost);
    }
    
    private void printResultData(int numberOfAppliances, ArrayList<String> namesList, 
                                 ArrayList<Integer> wattList, ArrayList<Double> hoursList, 
                                 double totalHours, double totalCost) {
        out.print("<center>");
        out.print("Ο αριθμός συσκευών που σε συμφέρει να χρησιμοποιήσεις είναι: <b>" + numberOfAppliances + "</b><br>");
        out.print("Προτεινόμενες είναι οι: <br><br>");
        out.print("<table style='width:33%' border='1'>");
        out.println("<tr align='center'>"
                    + "<td> <b>Συσκευή</b></td>"
                    + "<td><b>Watt</b></td>"
                    + "<td><b>Ώρες</b></td>"
                    + "</tr>");
        for(int i = 0; i < namesList.size(); i++) {
            out.println("<tr>"
                    + "<td> <b>" +
                    namesList.get(i)
                    + "</b></td>"
                    + "<td><b>" +
                    wattList.get(i) + " Watt"
                    + "</b></td>"
                    + "<td><b>" +
                    hoursList.get(i) + " ώρες"
                    + "</b></td>"
                    + "</tr>");
        }
        out.print("</table><br>");
        out.print("Θα τις χρησιμοποιήσεις για <b>" + totalHours + "</b> ώρες <br>");
        out.print("Θα σου κοστίσουνε <b>" + totalCost + "</b> € <br>");  
        out.print("<br><br>");
        out.print("<a style='text-decoration:none;' href='KnapsackIndex.jsp'>Go Back</a>");
        out.print("</center>"); 
    }
    
    private double[] createFractionArray (double[] cost) {
        int zeroCounter = 0;
        //Θα παίξει ρόλο αν προστεθεί κάποια απόδοση στις συσκευές.
        double[] fraction = new double[APPLIANCES_NUMBER];
        
        for (int i = 0; i <= APPLIANCES_NUMBER - 1; i++) {
            if (cost[i] == 0) {
                zeroCounter++;
                fraction[APPLIANCES_NUMBER - 1 - i] = cost[i];
            } else {
                fraction[Math.abs(zeroCounter - i)] = 1.0 / cost[i];
            }
        }
        
        return (fraction);
    }
}