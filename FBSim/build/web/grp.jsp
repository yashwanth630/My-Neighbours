<%@page import="osn.ProjectProperties"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="osn.DataBase"%>
<%
    String option = request.getParameter("option");
    if (option.equals("1")) {
        String email = (String) session.getAttribute("email");
        String oname = (String) session.getAttribute("name");
        String name = (String) session.getAttribute("name");
        name = name.replace(".", "_");
        name = name + "_grps";
        String zone = (String) session.getAttribute("zonal");
        //zone = zone.replace("\\s", "_");    
        String group = request.getParameter("g");

        String query = "insert into userGroups(usid,groupName,zonal) values('" + name + "','" + group + "','" + zone + "')";
        String query3 = "insert into " + name + "(usid,uname,groupname,usertype,zonal,status) values('" + email + "','" + oname + "','" + group + "','admin','" + zone + "','1')";
        System.out.println(query);
        System.out.println(query3);

        try {
            DataBase dbfunc = new DataBase();
            dbfunc.createConnection();
            dbfunc.updateRecord(query);
            dbfunc.updateRecord(query3);
            dbfunc.closeConnection();
            out.println("<h1>Created Group '" + group + "' </h1>");
        } catch (Exception e) {
            out.println("<h1>" + e.toString() + "</h1>");
        }

    }

    if (option.equals("2")) {
        String email = (String) session.getAttribute("email");
        String oname = (String) session.getAttribute("name");
        String name = (String) session.getAttribute("name");
        name = name.replace(".", "_");
        name = name + "_grps";
        String zone = (String) session.getAttribute("zonal");

        DataBase dbfunc = new DataBase();
        dbfunc.createConnection();

        //String query = "select u.email,u.firstname,u.lastname from users u,profiles p,profilesVisibility pv where p.email=u.email and pv.email=u.email";
        String query = "select u.id,u.usid,u.groupName,u.zonal,u.dateofcreation from userGroups u where u.zonal='" + zone + "'";
        System.out.println(query);

        ResultSet rset = dbfunc.queryRecord(query);
        boolean found = rset.next();

        if (found) {
            rset.last();
            int count = rset.getRow();
            int row = 0;
            rset.beforeFirst();
            String html = "";
            html += "<table border='1'>";
            html += "<tr><th>Group</th><th>Created On</th><th>Created By</th><th>Action</th></tr>";
            while (rset.next()) {
                String gn = rset.getString("groupName");
                String creator = rset.getString("usid");
                String action = "";
                if (creator.equals(name)) {
                    creator = "You";
                    String tempq = "select * from friends where email='" + email + "' and status='1' and zonal='" + zone + "'";
                    System.out.println(tempq);
                    ResultSet rset2 = dbfunc.queryRecord(tempq);
                    boolean found2 = rset2.next();
                    if (found2) {
                        rset2.last();
                        int count2 = rset2.getRow();
                        int row2 = 0;
                        rset2.beforeFirst();
                        while (rset2.next()) {
                            String fromMail = rset2.getString("friendMail");
                            String tempq2 = "select t.usid from " + name + " t where t.usid='" + fromMail + "' and status='1' and groupname='" + gn + "' and zonal='" + zone + "' and usertype='user'";
                            System.out.println(tempq2);
                            ResultSet rset3 = dbfunc.queryRecord(tempq2);
                            boolean found3 = rset3.next();
                            if (found3) {
                                action += "<a href=''>"+fromMail+" Already Joined</a><br />";
                            } else {
                                action += "<a href='grp.jsp?option=4&ua=" + name + "&g=" + gn + "&u="+fromMail+"'>Join '"+fromMail+"' To This Group</a><br />";
                            }                            
                        }                        
                    }
                } else {
                    String tempq = "select t.usid from " + creator + " t where t.usid='" + email + "' and status='1' and groupname='" + gn + "' and zonal='" + zone + "'";
                    System.out.println(tempq);
                    ResultSet rset2 = dbfunc.queryRecord(tempq);
                    boolean found2 = rset2.next();
                    if (found2) {
                        action = "Already Joined";
                    } else {
                        action = null;
                    }
                    if (action == null) {
                        action = "<a href='grp.jsp?option=3&ua=" + creator + "&g=" + gn + "'>Join This Group</a>";
                    } else {
                        action = "Already Joined";// unjoin code                                                
                    }
                }
                html += "<tr><td>" + gn + "</td><td>" + rset.getString("dateofcreation") + "</td><td>" + creator + "</td><td>" + action + "</td></tr>";
            }
            html += "</table>";
            out.println(html);
        } else {
            out.println("<h1>No Groups In Your Zone</h1>");
        }
    }
    if (option.equals("3")) {
        String email = (String) session.getAttribute("email");
        String oname = (String) session.getAttribute("name");
        String name = (String) session.getAttribute("name");
        name = name.replace(".", "_");
        name = name + "_grps";
        String zone = (String) session.getAttribute("zonal");
        //zone = zone.replace("\\s", "_");    
        String group = request.getParameter("g");
        String table = request.getParameter("ua");

        String query3 = "insert into " + table + "(usid,uname,groupname,usertype,zonal,status) values('" + email + "','" + oname + "','" + group + "','user','" + zone + "','1')";
        System.out.println(query3);

        try {
            DataBase dbfunc = new DataBase();
            dbfunc.createConnection();
            dbfunc.updateRecord(query3);
            dbfunc.closeConnection();
            response.sendRedirect("friends.jsp?option=2&msg=Joined Group");
        } catch (Exception e) {
            response.sendRedirect("friends.jsp?option=2&msg=" + e.toString());
        }

    }
    if (option.equals("4")) {
        String email = request.getParameter("u");        
        String zone = (String) session.getAttribute("zonal");
        //zone = zone.replace("\\s", "_");    
        String group = request.getParameter("g");
        String table = request.getParameter("ua");

        String query3 = "insert into " + table + "(usid,uname,groupname,usertype,zonal,status) values('" + email + "','" + email + "','" + group + "','user','" + zone + "','1')";
        System.out.println(query3);

        try {
            DataBase dbfunc = new DataBase();
            dbfunc.createConnection();
            dbfunc.updateRecord(query3);
            dbfunc.closeConnection();
            response.sendRedirect("friends.jsp?option=2&msg=Joined Group");
        } catch (Exception e) {
            response.sendRedirect("friends.jsp?option=2&msg=" + e.toString());
        }

    }

%>