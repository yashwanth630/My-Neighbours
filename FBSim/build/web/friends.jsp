<%@page import="osn.ProjectProperties"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="osn.DataBase"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.File"%>
<%
    String msg = request.getParameter("msg");
    msg = (msg == null ? "" : "<font size='2'>" + msg + "</font>");

    String option = request.getParameter("option");
    option = (option == null ? "100" : option);

    String email = (String) session.getAttribute("email");
    String name = (String) session.getAttribute("name");
    String zone = (String) session.getAttribute("zonal");

    if (email == null) {
        response.sendRedirect("index.jsp?msg=Unauthorized Access");
        return;
    }

    boolean adsProceed = false;
    boolean profilePic = true;
    String profilePicPath = "images/users/none.jpg";

    if (option.trim().equals("1")) {
%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Welcome</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link href="jQueryAssets/jquery.ui.core.min.css" rel="stylesheet" type="text/css">
        <link href="jQueryAssets/jquery.ui.theme.min.css" rel="stylesheet" type="text/css">
        <link href="jQueryAssets/jquery.ui.accordion.min.css" rel="stylesheet" type="text/css">
        <link href="jQueryAssets/jquery.ui.button.min.css" rel="stylesheet" type="text/css">
        <link href="jQueryAssets/jquery.ui.tabs.min.css" rel="stylesheet" type="text/css">
        <script src="jQueryAssets/jquery-1.8.3.min.js" type="text/javascript"></script>
        <script src="jQueryAssets/jquery-ui-1.9.2.accordion.custom.min.js" type="text/javascript"></script>
        <script src="jQueryAssets/jquery-ui-1.9.2.button.custom.min.js" type="text/javascript"></script>
        <script src="jQueryAssets/jquery-ui-1.9.2.tabs.custom.min.js" type="text/javascript"></script>
        <script src="JS/ajax.js" type="text/javascript"></script>

        <script language="javascript">
            function autoClick()
            {
                document.getElementById('friends').click();
            }
        </script>
    </head>

    <body bgcolor="#011c92" onload="autoClick()">

        <header class="head" id="headId">
        </div>
        <div style="padding:.5% 0 0 .5% ;margin-left:.5%" >

            <div class="HeadingCc" id="HeadingId"  ><%=msg%>
                <p>Welcome <%=name%>....</p>
                <div style="text-align:right;margin-right:10px">  <a class="hf" href="logout.jsp" > LOG OUT</a> </div></div>
        </div>

    </div>


</header>
<div style="padding:2px">
    <div class="c_barleft" id="Id_barleft">
        <div style="padding:20px;alignment-adjust:central" align="center">
            <%
                if (!profilePic) {
                    profilePicPath = "images/users/none.jpg";
                    out.println("<p><img src=\"" + profilePicPath + "\" width=\"150\" height=\"120\"  alt=\"\"/>");
                } else {
                    out.println("<p><img src=\"" + profilePicPath + "\" width=\"195\" height=\"240\"  alt=\"\"/>");
                }
            %>
            <label style="color:#FFF"> <a href="welcome.jsp" class="hf">Home</a></label>
            &nbsp;
            <label style="color:#FFF"   ><a href="logout.jsp" class="hf">Logout</a></label>
        </div>

        <div class="cleft_content" id="Idleft_content">


            <div id="Accordion1" style="text-decoration:none">
                <h3><a href="#" id="account" class="hhf">Account</a></h3>
                <div>
                    <p><a href="profileSettings.jsp"  class="hf" title="Edit Profile Settings">Edit Profile</a></p>                            

                    <p><a href="upload.jsp?option=1" class="hf" >Upload Profile Pic</a></p>
                </div>  
                <h3><a href="#" class="hhf" >Images</a></h3>
                <div>
                    <p><a href="photosSettings.jsp?option=2" class="hf"  title="Edit Uploaded Image Settings">Edit Uploaded Image Settings</a></p>                            
                    <p><a href="photos.jsp?option=2" class="hf"  title="View/Upload Images">View/Upload Images</a></p>                                                        
                    <p><a href="photos_private.jsp" class="hf"  title="Private Images">Private Images</a></p>
                    <p><a href="photos_public.jsp" class="hf" title="Public Images">Public Images</a></p>
                </div>
                <h3><a href="#" class="hhf">Neighbors</a></h3>
                <div>                            
                    <!--p><a href="friends.jsp?option=1" class="hf"  title="Friends">Add Neighbors</a></p-->                            
                    <p><a href="friends.jsp?option=2" class="hf"  title="Friends">View Neighbors</a></p>                            
                </div>                                                
            </div>
            <p>&nbsp;</p>
            <p align="center">&nbsp; </p>
        </div>
        <p>&nbsp;</p>
    </div>
    <div class="c_center" id="Id_center">
        <div class="wall" id="wall">            
            <font color="white" size="5">
            <table>
                <!--tr>
                        <th>Search By Zones</th>
                        <td>
                            <input type="hidden" id="usn" value="<%=email%>" />
                            <select class="myclass" id="zone" name="zone">
                                <option>Select A Zone</option>
                                <option>North-East London</option>
                                <option>South-East London</option>
                                <option>North-West London</option>
                                <option>South-West London</option>
                            </select>
                        </td>
                        <td>
                            <input type="button" style="font-size: 14px;height:30px; width:120px;background-color:rgb(0,153,255);" value="Search" onclick="tzFriends();" />
                        </td>
                    </tr-->
                <tr>
                    <th>Create Groups</th>
                    <td>                        
                        <input type="text" id="grpn" placeholder="Enter Group Name" />
                    </td>
                    <td>
                        <input type="button" style="font-size: 14px;height:30px; width:120px;background-color:rgb(0,153,255);" value="Create Group" onclick="createGrp();" />
                    </td>
                </tr>
                <tr>
                    <th></th>
                    <td>
                    </td>
                    <td>
                        <input type="button" style="font-size: 10px;height:30px; width:120px;background-color:rgb(0,153,255);" value="View My Zonal Groups" onclick="viewGroups();" />
                    </td>
                </tr>
            </table>  
            </font>            
        </div>
        <div class="wallpot">               
            <div id="Tabs1">
                <ul>
                    <li><a href="#tabs-1">Click Members To Add</a></li>
                    <li><a href="#tabs-2">Click Members To View Profiles</a></li>
                </ul>
                <div id="tabs-1">
                    <%
                        {
                            DataBase dbfunc = new DataBase();
                            dbfunc.createConnection();

                            //String query = "select u.email,u.firstname,u.lastname from users u,profiles p,profilesVisibility pv where p.email=u.email and pv.email=u.email";
                            String query = "select u.email,u.firstname,u.lastname from users u where u.showProfile=1 and u.email!='" + email.trim() + "' and u.siteType='" + ProjectProperties.siteName + "'";
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
                        }
                    %>

                </div>
                <div id="tabs-2">
                    <%
                        {
                            DataBase dbfunc = new DataBase();
                            dbfunc.createConnection();

                            //String query = "select u.email,u.firstname,u.lastname from users u,profiles p,profilesVisibility pv where p.email=u.email and pv.email=u.email";
                            String query = "select u.email,u.firstname,u.lastname from users u where u.showProfile=1 and u.email!='" + email.trim() + "' and u.siteType='" + ProjectProperties.siteName + "'";
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
                                                line += "<p><span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=2&friendMail=" + mail.trim() + "\"><img src=\"HttpObjectDownload?email=" + mail.trim() + "&option=1\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                                                continue;
                                            }
                                            if (row % 4 == 0) {
                                                line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=2&friendMail=" + mail.trim() + "\"><img src=\"HttpObjectDownload?email=" + mail.trim() + "&option=1\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span></p>";
                                                row = 0;
                                                continue;
                                            } else {
                                                line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=2&friendMail=" + mail.trim() + "\"><img src=\"HttpObjectDownload?email=" + mail.trim() + "&option=1\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                                                continue;
                                            }
                                        } else {
                                            row++;
                                            if (row == 1) {
                                                line += "<p><span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=2&friendMail=" + mail.trim() + "\"><img src=\"images/none.jpg\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                                                continue;
                                            }
                                            if (row % 4 == 0) {
                                                line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=2&friendMail=" + mail.trim() + "\"><img src=\"images/none.jpg\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span></p>";
                                                row = 0;
                                                continue;
                                            } else {
                                                line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=2&friendMail=" + mail.trim() + "\"><img src=\"images/none.jpg\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                                                continue;
                                            }
                                        }
                                    }
                                }
                                out.println(line);
                            } else {
                                out.println("No Members Found!!!");
                            }
                        }
                    %>
                </div>
            </div>            
        </div>        
        <font color="white" size="5">
        <div id="zsr" class="wallpot">

        </div>
        </font>      

    </div>
    <div class="c_barright" id="Id_barright" >
        <!-- add code-->
        <%
            if (adsProceed) {
                ///////////////////////////////////////
                String rootDirectory = getServletContext().getRealPath("");
                String subDirectory = "ads";

                File f = new File(rootDirectory);

                if (f.exists() && f.isDirectory()) {
                    rootDirectory = f.getAbsolutePath() + "\\" + subDirectory + "\\";
                }
                File adsRoot = new File(rootDirectory);
                ///////////////////////////////////////
                if (adsRoot.exists() && adsRoot.isDirectory()) {
                    File list[] = adsRoot.listFiles();
                    Collections.shuffle(Arrays.asList(list));
                    out.println("<div><font color=\"black\" size=\"5\">Ads</div>");
                    for (int i = 0; i < list.length; i++) {
                        out.println("<a href=\"\"><img src=\"ads/" + list[i].getName() + "\" style=\"border: 1px solid rgb(128, 128, 128);\" alt=\"Ad" + (i + 1) + "\" border=\"0\" /></a><br />");
                        if (i == 2) {
                            break;
                        }
                    }
                }

            }

        %>     
    </div>
    <div>Content for New Div Tag Goes Here</div>
</div>
<footer class="cfooter" id="idfooter">All Rights Reserved @ 2022

</footer>
</div>
<script type="text/javascript">
    $(function () {
        $("#Accordion1").accordion({
            collapsible: true,
            icons: {header: "ui-icon-arrow-1-e", activeHeader: "ui-icon-minus"},
            heightStyle: "content",
            active: 1
        });
    });
    $(function () {
        $("#Button1").button({
            disabled: true
        });
    });
    $(function () {
        $("#Accordion5").accordion({
            heightStyle: "content",
            icons: {header: "ui-icon-arrowthick-1-e"}
        });
    });
    $(function () {
        $("#Button1").button();
    });
    $(function () {
        $("#Tabs1").tabs();
    });
    $(function () {
        $("#Button2").button();
    });
    $(function () {
        $("#Button3").button();
    });
</script>
</body>
</html>
<%}%>

<%

    if (option.trim().equals("2")) {
%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Welcome</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link href="jQueryAssets/jquery.ui.core.min.css" rel="stylesheet" type="text/css">
        <link href="jQueryAssets/jquery.ui.theme.min.css" rel="stylesheet" type="text/css">
        <link href="jQueryAssets/jquery.ui.accordion.min.css" rel="stylesheet" type="text/css">
        <link href="jQueryAssets/jquery.ui.button.min.css" rel="stylesheet" type="text/css">
        <link href="jQueryAssets/jquery.ui.tabs.min.css" rel="stylesheet" type="text/css">
        <script src="jQueryAssets/jquery-1.8.3.min.js" type="text/javascript"></script>
        <script src="jQueryAssets/jquery-ui-1.9.2.accordion.custom.min.js" type="text/javascript"></script>
        <script src="jQueryAssets/jquery-ui-1.9.2.button.custom.min.js" type="text/javascript"></script>
        <script src="jQueryAssets/jquery-ui-1.9.2.tabs.custom.min.js" type="text/javascript"></script>
        <script src="JS/ajax.js" type="text/javascript"></script>

        <style>
            a:link {
                color: black;
                background-color: transparent;
                text-decoration: none;
            }

        </style>

        <script language="javascript">
    function autoClick()
    {
        document.getElementById('friends').click();
    }
        </script>
    </head>

    <body bgcolor="#011c92" onload="autoClick()">

        <header class="head" id="headId">            
            <div style="padding:.5% 0 0 .5% ;margin-left:.5%" >

                <div class="HeadingCc" id="HeadingId"  ><%=msg%>
                    <p>Welcome <%=name%>....</p>
                    <div style="text-align:right;margin-right:10px">  <a class="hf" href="logout.jsp" > LOG OUT</a> </div></div>
            </div>

        </div>


    </header>
    <div style="padding:2px">
        <div class="c_barleft" id="Id_barleft">
            <div style="padding:20px;alignment-adjust:central" align="center">
                <%
                    if (!profilePic) {
                        profilePicPath = "images/users/none.jpg";
                        out.println("<p><img src=\"" + profilePicPath + "\" width=\"150\" height=\"120\"  alt=\"\"/>");
                    } else {
                        out.println("<p><img src=\"" + profilePicPath + "\" width=\"195\" height=\"240\"  alt=\"\"/>");
                    }
                %>
                <label style="color:#FFF"> <a href="welcome.jsp" class="hf">Home</a></label>
                &nbsp;
                <label style="color:#FFF"   ><a href="logout.jsp" class="hf">Logout</a></label>
            </div>

            <div class="cleft_content" id="Idleft_content">


                <div id="Accordion1" style="text-decoration:none">
                    <h3><a href="#" id="account" class="hhf">Account</a></h3>
                    <div>
                        <p><a href="profileSettings.jsp"  class="hf" title="Edit Profile Settings">Edit Profile</a></p>                             <p><a href="profileVisibility.jsp" class="hf" title="Disable/Enable Profile">Disable/Enable Profile</a></p>
                        <p><a href="upload.jsp?option=1" class="hf" >Upload Profile Pic</a></p>
                    </div>                    
                    <h3><a href="#" id="friends" class="hhf">Neighbors</a></h3>
                    <div>                            
                        <!--p><a href="friends.jsp?option=1" class="hf"  title="Friends">Add Neighbors</a></p-->                            
                        <p><a href="friends.jsp?option=2" class="hf"  title="Friends">View Neighbors</a></p>                            
                    </div>
                </div>
                <p>&nbsp;</p>
                <p align="center">&nbsp; </p>
            </div>
            <p>&nbsp;</p>
        </div>
        <div class="c_center" id="Id_center">
            <div class="wall" id="wall">
                <font color="white" size="5">
                <table>
                    <!--tr>
                        <th>Search By Zones</th>
                        <td>
                            <input type="hidden" id="usn" value="<%=email%>" />
                            <select class="myclass" id="zone" name="zone">
                                <option>Select A Zone</option>
                                <option>North-East London</option>
                                <option>South-East London</option>
                                <option>North-West London</option>
                                <option>South-West London</option>
                            </select>
                        </td>
                        <td>
                            <input type="button" style="font-size: 14px;height:30px; width:120px;background-color:rgb(0,153,255);" value="Search" onclick="tzFriends();" />
                        </td>
                    </tr-->
                    <tr>
                        <th>Create Groups</th>
                        <td>                        
                            <input type="text" id="grpn" placeholder="Enter Group Name" />
                        </td>
                        <td>
                            <input type="button" style="font-size: 14px;height:30px; width:120px;background-color:rgb(0,153,255);" value="Create Group" onclick="createGrp();" />
                        </td>
                    </tr>
                    <tr>
                        <th></th>
                        <td>
                        </td>
                        <td>
                            <input type="button" style="font-size: 10px;height:30px; width:120px;background-color:rgb(0,153,255);" value="View My Zonal Groups" onclick="viewGroups();" />
                        </td>
                    </tr>
                </table>  
                </font>
            </div>
            <div class="wallpot">               
                <div id="Tabs1">
                    <ul>
                        <li><a href="#tabs-1">Click Members To View Profile</a></li>
                        <li><a href="#tabs-2">Click Members To View Wall</a></li>
                    </ul>
                    <div id="tabs-1">
                        <%
                            {
                                DataBase dbfunc = new DataBase();
                                dbfunc.createConnection();

                                //String query = "select u.email,u.firstname,u.lastname from users u,profiles p,profilesVisibility pv where p.email=u.email and pv.email=u.email";
                                String query = "select * from friends where email='" + email + "' and status='1' and siteType='" + ProjectProperties.siteName + "' and zonal='" + zone + "'";
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

                                        String mail = rset.getString("friendMail");

                                        //String query1 = "select p.email,p.ProfilePic,pv.email,pv.profilePic where p.email='"+mail.trim()+"' and pv.email='"+mail.trim()+"'";
                                        String query1 = "select * from users where email='" + mail + "' and showProfile=1 and siteType='" + ProjectProperties.siteName + "' and zonal='" + zone + "'";
                                        System.out.println(query1);

                                        DataBase dbfunc1 = new DataBase();
                                        dbfunc1.createConnection();
                                        ResultSet rset1 = dbfunc1.queryRecord(query1);
                                        boolean found1 = rset1.next();
                                        if (found1) {
                                            String fN = rset1.getString("firstname");
                                            String lN = rset1.getString("lastname");
                                            query1 = "select p.email,p.ProfilePic from profiles p where p.email='" + mail.trim() + "' and p.siteType='" + ProjectProperties.siteName + "'";
                                            System.out.println(query1);
                                            rset1 = dbfunc1.queryRecord(query1);
                                            boolean found2 = rset1.next();
                                            if (found2) {
                                                row++;
                                                if (row == 1) {
                                                    line += "<p><span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=3&friendMail=" + mail.trim() + "\"><img src=\"HttpObjectDownload?email=" + mail.trim() + "&option=1\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                                                    continue;
                                                }
                                                if (row % 4 == 0) {
                                                    line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=3&friendMail=" + mail.trim() + "\"><img src=\"HttpObjectDownload?email=" + mail.trim() + "&option=1\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span></p>";
                                                    row = 0;
                                                    continue;
                                                } else {
                                                    line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=3&friendMail=" + mail.trim() + "\"><img src=\"HttpObjectDownload?email=" + mail.trim() + "&option=1\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                                                    continue;
                                                }
                                            } else {
                                                row++;
                                                if (row == 1) {
                                                    line += "<p><span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=3&friendMail=" + mail.trim() + "\"><img src=\"images/none.jpg\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                                                    continue;
                                                }
                                                if (row % 4 == 0) {
                                                    line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=3&friendMail=" + mail.trim() + "\"><img src=\"images/none.jpg\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span></p>";
                                                    row = 0;
                                                    continue;
                                                } else {
                                                    line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=3&friendMail=" + mail.trim() + "\"><img src=\"images/none.jpg\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                                                    continue;
                                                }
                                            }
                                        }
                                    }
                                    out.println(line);
                                } else {
                                    out.println("No Members Found!!!");
                                }
                            }
                        %>

                    </div>
                    <div id="tabs-2">
                        <%
                            {
                                DataBase dbfunc = new DataBase();
                                dbfunc.createConnection();

                                //String query = "select u.email,u.firstname,u.lastname from users u,profiles p,profilesVisibility pv where p.email=u.email and pv.email=u.email";
                                String query = "select * from friends where email='" + email + "' and status='1' and siteType='" + ProjectProperties.siteName + "' and zonal='" + zone + "'";
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

                                        String mail = rset.getString("friendMail");

                                        //String query1 = "select p.email,p.ProfilePic,pv.email,pv.profilePic where p.email='"+mail.trim()+"' and pv.email='"+mail.trim()+"'";
                                        String query1 = "select * from users where email='" + mail + "' and showProfile=1 and siteType='" + ProjectProperties.siteName + "' and zonal='" + zone + "'";
                                        System.out.println(query1);

                                        DataBase dbfunc1 = new DataBase();
                                        dbfunc1.createConnection();
                                        ResultSet rset1 = dbfunc1.queryRecord(query1);
                                        boolean found1 = rset1.next();
                                        if (found1) {
                                            String fN = rset1.getString("firstname");
                                            String lN = rset1.getString("lastname");
                                            query1 = "select p.email,p.ProfilePic from profiles p where p.email='" + mail.trim() + "' and p.siteType='" + ProjectProperties.siteName + "'";
                                            System.out.println(query1);
                                            rset1 = dbfunc1.queryRecord(query1);
                                            boolean found2 = rset1.next();
                                            if (found2) {
                                                row++;
                                                if (row == 1) {
                                                    line += "<p><span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=4&friendMail=" + mail.trim() + "\"><img src=\"HttpObjectDownload?email=" + mail.trim() + "&option=1\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                                                    continue;
                                                }
                                                if (row % 4 == 0) {
                                                    line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=4&friendMail=" + mail.trim() + "\"><img src=\"HttpObjectDownload?email=" + mail.trim() + "&option=1\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span></p>";
                                                    row = 0;
                                                    continue;
                                                } else {
                                                    line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=4&friendMail=" + mail.trim() + "\"><img src=\"HttpObjectDownload?email=" + mail.trim() + "&option=1\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                                                    continue;
                                                }
                                            } else {
                                                row++;
                                                if (row == 1) {
                                                    line += "<p><span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=4&friendMail=" + mail.trim() + "\"><img src=\"images/none.jpg\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                                                    continue;
                                                }
                                                if (row % 4 == 0) {
                                                    line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=4&friendMail=" + mail.trim() + "\"><img src=\"images/none.jpg\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span></p>";
                                                    row = 0;
                                                    continue;
                                                } else {
                                                    line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=4&friendMail=" + mail.trim() + "\"><img src=\"images/none.jpg\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                                                    continue;
                                                }
                                            }
                                        }
                                    }
                                    out.println(line);
                                } else {
                                    out.println("No Members Found!!!");
                                }
                            }
                        %>

                    </div>
                </div>               
            </div>
            <font color="white" size="5">
            <div id="zsr" class="wallpot">

            </div>
            </font>
        </div>
        <div class="c_barright" id="Id_barright" >
            <!-- add code-->
            <%
                if (adsProceed) {
                    String absolutePath = getServletContext().getRealPath("ads");
                    File adsRoot = new File(absolutePath);
                    if (adsRoot.exists() && adsRoot.isDirectory()) {
                        File list[] = adsRoot.listFiles();
                        Collections.shuffle(Arrays.asList(list));
                        out.println("<div><font color=\"black\" size=\"5\">Ads</div>");
                        for (int i = 0; i < list.length; i++) {
                            out.println("<a href=\"\"><img src=\"ads/" + list[i].getName() + "\" style=\"border: 1px solid rgb(128, 128, 128);\" alt=\"Ad" + (i + 1) + "\" border=\"0\" /></a><br />");
                            if (i == 2) {
                                break;
                            }
                        }
                    }

                }

            %>     
        </div>
        <div></div>
    </div>
    <footer class="cfooter" id="idfooter">All Rights Reserved @ 2022

    </footer>
</div>
<script type="text/javascript">
    $(function () {
        $("#Accordion1").accordion({
            collapsible: true,
            icons: {header: "ui-icon-arrow-1-e", activeHeader: "ui-icon-minus"},
            heightStyle: "content",
            active: 1
        });
    });
    $(function () {
        $("#Button1").button({
            disabled: true
        });
    });
    $(function () {
        $("#Accordion5").accordion({
            heightStyle: "content",
            icons: {header: "ui-icon-arrowthick-1-e"}
        });
    });
    $(function () {
        $("#Button1").button();
    });
    $(function () {
        $("#Tabs1").tabs();
    });
    $(function () {
        $("#Button2").button();
    });
    $(function () {
        $("#Button3").button();
    });
</script>
</body>
</html>
<%}%>



