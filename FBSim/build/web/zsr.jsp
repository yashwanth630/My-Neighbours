<%@page import="osn.ProjectProperties"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="osn.DataBase"%>
<%
    String email = request.getParameter("un");
    String z = request.getParameter("z");

    DataBase dbfunc = new DataBase();
    dbfunc.createConnection();

    //String query = "select u.email,u.firstname,u.lastname from users u,profiles p,profilesVisibility pv where p.email=u.email and pv.email=u.email";
    String query = "select u.email,u.firstname,u.lastname from users u where u.showProfile=1 and zonal='"+z+"' and u.email!='" + email.trim() + "' and u.siteType='" + ProjectProperties.siteName + "'";
    System.out.println(query);

    ResultSet rset = dbfunc.queryRecord(query);
    boolean found = rset.next();

    if (found) {
        rset.last();
        int count = rset.getRow();
        int row = 0;
        String line = "";
        rset.beforeFirst();
        while (rset.next()) {

            String mail = rset.getString(1);
            String fN = rset.getString(2);
            String lN = rset.getString(3);

            //String query1 = "select p.email,p.ProfilePic,pv.email,pv.profilePic where p.email='"+mail.trim()+"' and pv.email='"+mail.trim()+"'";
            String query1 = "select * from friends where email='" + email + "' and friendMail='" + mail + "' and siteType='" + ProjectProperties.siteName + "'";
            System.out.println(query1);

            DataBase dbfunc1 = new DataBase();
            dbfunc1.createConnection();
            ResultSet rset1 = dbfunc1.queryRecord(query1);
            boolean found1 = rset1.next();
            if (!found1) {
                query1 = "select p.email,p.ProfilePic from profiles p where p.email='" + mail.trim() + "' and siteType='" + ProjectProperties.siteName + "'";
                System.out.println(query1);
                rset1 = dbfunc1.queryRecord(query1);
                boolean found2 = rset1.next();
                if (found2) {
                    row++;
                    if (row == 1) {
                        line += "<p><span style=\"padding:20px;alignment-adjust:central\"><a href=\"Operations?operation=2&page=friends.jsp&friendMail=" + mail.trim() + "\"><img src=\"HttpObjectDownload?email=" + mail.trim() + "&option=1\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                        continue;
                    }
                    if (row % 4 == 0) {
                        line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"Operations?operation=2&page=friends.jsp&friendMail=" + mail.trim() + "\"><img src=\"HttpObjectDownload?email=" + mail.trim() + "&option=1\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span></p>";
                        row = 0;
                        continue;
                    } else {
                        line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"Operations?operation=2&page=friends.jsp&friendMail=" + mail.trim() + "\"><img src=\"HttpObjectDownload?email=" + mail.trim() + "&option=1\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                        continue;
                    }
                } else {
                    row++;
                    if (row == 1) {
                        line += "<p><span style=\"padding:20px;alignment-adjust:central\"><a href=\"Operations?operation=2&page=friends.jsp&friendMail=" + mail.trim() + "\"><img src=\"images/none.jpg\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                        continue;
                    }
                    if (row % 4 == 0) {
                        line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"Operations?operation=2&page=friends.jsp&friendMail=" + mail.trim() + "\"><img src=\"images/none.jpg\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span></p>";
                        row = 0;
                        continue;
                    } else {
                        line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"Operations?operation=2&page=friends.jsp&friendMail=" + mail.trim() + "\"><img src=\"images/none.jpg\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                        continue;
                    }
                }
            }
        }
        out.println(line);
    } else {
        out.println("No Members Found!!!");
    }

%>