<%@page import="osn.DataBase"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>

<%
    String msg = request.getParameter("msg");
    msg = (msg == null ? "" : msg);

    String email = (String) session.getAttribute("email");
    String name = (String) session.getAttribute("name");

    if (email == null) {
        response.sendRedirect("index.jsp?msg=Unauthorized Access");
        return;
    }

    boolean adsProceed = true;
    boolean profilePic = true;
    String profilePicPath = "";
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="refresh" content="20" />
        <title>Surveillance Report</title>
        <style type="text/css">
            body {
                font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
                color: #4f6b72;
                background: #E6EAE9;
            }

            a {
                color: #c75f3e;
            }

            #mytable {
                width: 700px;
                padding: 0;
                margin: 0;
            }

            caption {
                padding: 0 0 5px 0;
                width: 700px;	 
                font: italic 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
                text-align: right;
            }

            th {
                font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
                color: #4f6b72;
                border-right: 1px solid #C1DAD7;
                border-bottom: 1px solid #C1DAD7;
                border-top: 1px solid #C1DAD7;
                letter-spacing: 2px;
                text-transform: uppercase;
                text-align: left;
                padding: 6px 6px 6px 12px;
                background: #CAE8EA url(images/bg_header.jpg) no-repeat;
            }

            th.nobg {
                border-top: 0;
                border-left: 0;
                border-right: 1px solid #C1DAD7;
                background: none;
            }

            td {
                border-right: 1px solid #C1DAD7;
                border-bottom: 1px solid #C1DAD7;
                background: #fff;
                padding: 6px 6px 6px 12px;
                color: #4f6b72;
            }


            td.alt {
                background: #F5FAFA;
                color: #797268;
            }

            th.spec {
                border-left: 1px solid #C1DAD7;
                border-top: 0;
                background: #fff url(images/bullet1.gif) no-repeat;
                font: bold 10px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
            }

            th.specalt {
                border-left: 1px solid #C1DAD7;
                border-top: 0;
                background: #f5fafa url(images/bullet2.gif) no-repeat;
                font: bold 10px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
                color: #797268;
            }


        </style>
    </head>
    <body><center>
        <%

            ResultSet rset = null;
            Statement s = null;

            try {

                DataBase dbfunc = new DataBase();
                dbfunc.createConnection();

                String query = "select * from actionsmonitor where actioned='" + email.trim() + "' order by actionon desc";
                rset = dbfunc.queryRecord(query);

                ResultSetMetaData rsmd = rset.getMetaData();
                int numColumns = rsmd.getColumnCount();

                String resultHtml = "";

                resultHtml += "<table border=1><caption><h2><font color='red'>INSIDER ACTIONS CHART(Enhancement)</font></h2></caption><thead>";
                resultHtml += "<tr>";

                for (int i = 1; i <= numColumns; i++) {
                    String stylus = "";
                    if (i % 2 == 0) {
                        stylus = "specalt";
                    } else {
                        stylus = "spec";
                    }
                    resultHtml += "<div align=\"center\"><th scope=\"row\" class=\"" + stylus + "\">" + rsmd.getColumnName(i).toUpperCase() + "</th></div>";
                }
                resultHtml += "</tr></thead><tbody>";

                boolean found = rset.next();

                if (found) {
                    rset.last();
                    int count = rset.getRow();
                    int row = 0;
                    rset.beforeFirst();
                    while (rset.next()) {
                        row++;
                        if (row % 2 == 0) {

                            resultHtml += "<tr class='evenrow'>";
                            for (int i = 1; i <= numColumns; i++) {             
                                    resultHtml += "<div align=\"center\"><td scope=\"row\" class=\"specalt\">" + rset.getString(i) + "</td></div>";                                

                            }
                            resultHtml += "</tr>";
                        } else {
                            resultHtml += "<tr class='oddrow'>";
                            for (int i = 1; i <= numColumns; i++) {
                                    resultHtml += "<div align=\"center\"><td scope=\"row\" class=\"spec\">" + rset.getString(i) + "</td></div>";                                
                            }
                            resultHtml += "</tr>";
                        }
                    }                    
                    dbfunc.closeConnection();
                }
                out.println(resultHtml);
            } catch (Exception e) {
                out.println("<br /><b>Exception : " + e.toString() + "</b>");
            }

        %>
    </center></body>
</html>
