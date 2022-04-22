<%-- 
    Document   : photosSettings
    Created on : Mar 12, 2022, 7:23:47 AM
    Author     : Helias
--%>

<%@page import="osn.ProjectProperties"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="osn.DataBase"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.File"%>
<%
    String msg = request.getParameter("msg");
    msg = (msg == null ? "" : msg);

    String option = request.getParameter("option");
    option = (option == null ? "100" : option);

    String email = (String) session.getAttribute("email");
    String name = (String) session.getAttribute("name");

    if (email == null) {
        response.sendRedirect("index.jsp?msg=Unauthorized Access");
        return;
    }

    boolean adsProceed = false;
    boolean profilePic = true;
    String profilePicPath = "";
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
    </head>

    <body bgcolor="#011c92">

        <header class="head" id="headId">
            <div align="left" >
                <%
                    String notifications = "";
                    {
                        String query = "select * from profiles p where p.email='" + email.trim() + "' and p.siteType='"+ProjectProperties.siteName+"'";
                        System.out.println(query);

                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        ResultSet rsett = dbfunc.queryRecord(query);
                        boolean found = rsett.next();

                        if (found) {
                            profilePicPath = "HttpObjectDownload?email=" + email + "&option=1";
                            profilePic = true;     

                        } else {
                            notifications += "<a id='note' href='profileSettings.jsp'>Click Here To Set Profile</a><br />";
                            profilePic = false;
                        }
                    }                    
                %>




            </div>
            <div style="padding:.5% 0 0 .5% ;margin-left:.5%" >

                <div class="HeadingCc" id="HeadingId"  ><%=msg%>
                    <p>Welcome <%=name%>....</p>
                    <div style="text-align:right;margin-right:10px">  <a class="hf" href="welcome.jsp" >HOME</a>&nbsp;<a class="hf" href="logout.jsp" >LOGOUT</a> </div></div>
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
                        <h3><a href="#" class="hhf">Friends</a></h3>
                        <div>                            
                            <!--p><a href="friends.jsp?option=1" class="hf"  title="Friends">Add Friends</a></p-->                            
                            <p><a href="friends.jsp?option=2" class="hf"  title="Friends">View Friends</a></p>                            
                        </div>
                </div>
                <p>&nbsp;</p>
                <p align="center">&nbsp; </p>
            </div>
            <p>&nbsp;</p>
        </div>
        <div class="c_center" id="Id_center">
            <div class="wall" id="wall">
                <h1><%=name%>-Uploaded Photos</h1>
            </div>
            <div class="wallpot">
                <div id="Tabs1">
                    <ul>
                        <li><a href="#tabs-1">All Photos</a></li>
                        <!--li><a href="#tabs-2">Album</a></li-->
                    </ul>
                    <div id="tabs-1">
                        <%
                            {
                                String query = "select * from fileuploads where email='" + email.trim() + "' and filetype='Image' and siteType='"+ProjectProperties.siteName+"'";
                                System.out.println(query);

                                DataBase dbfunc = new DataBase();
                                dbfunc.createConnection();

                                ResultSet rset = dbfunc.queryRecord(query);

                                ResultSetMetaData rsmd = rset.getMetaData();
                                int numColumns = rsmd.getColumnCount();

                                String resultHtml = "";

                                resultHtml += "<font size='3'><table border=1>";
                                resultHtml += "<tr>";

                                for (int i = 1; i <= numColumns; i++) {
                                    // uncomment the following three lines and define bool least to initiate blocking those columns
                                    boolean notDisplay = false;
                                    notDisplay = (i == 1 || i == 2 || i == 6 || i == 7);
                                    if (!notDisplay) {
                                        if (i == 5) {
                                            resultHtml += "<td>FILE</td>";
                                        } else if (i == 8) {
                                            resultHtml += "<td>CHANGE STATUS</td>";
                                        }
                                        else if (i == 9) {
                                            resultHtml += "<td>TAG PIC</td>";
                                        }
                                        else {
                                            resultHtml += "<td>"+ rsmd.getColumnName(i).toUpperCase() + "</td>";
                                        }
                                    }
                                }
                                resultHtml += "</tr>";

                                boolean found = rset.next();
                                //out.println("<br><b>Sql Result</b>+"+query+"==>"+found);
                                if (found) {
                                    rset.last();
                                    int count = rset.getRow();
                                    int row = 0;
                                    rset.beforeFirst();
                                    while (rset.next()) {
                                        row++;
                                        resultHtml += "<tr>";
                                        for (int i = 1; i <= numColumns; i++) {
                                            // uncomment the following three lines and define bool least to initiate blocking those columns
                                            boolean notDisplay = false;
                                            notDisplay = (i == 1 || i == 2 || i == 6 || i == 7);
                                            if (!notDisplay) {
                                                if (i == 5) {
                                                    resultHtml += "<td><a href=\"ImageServlet?email=" + email + "&option=21&tid=" + rset.getString(1) + "\"><img src=\"ImageServlet?email=" + email + "&option=21&tid=" + rset.getString(1) + "\" width=\"160\" height=\"160\"  alt=\"\"/></a></td>";
                                                } else if (i == 8) {
                                                    String visibility = rset.getString(i).trim();
                                                    if (visibility.trim().equals("Y")) {
                                                        visibility = "<a href=\"revoke.jsp?tid=" + rset.getString(1) + "&page=photosSettings.jsp&visibility=N\">Private</a>";
                                                    }
                                                    if (visibility.trim().equals("N")) {
                                                        visibility = "<a href=\"revoke.jsp?tid=" + rset.getString(1) + "&page=photosSettings.jsp&visibility=Y\">Public</a>";
                                                    }
                                                    resultHtml += "<td>" + visibility + "</td>";
                                                }
                                                else if (i == 9) {
                                                    //resultHtml += "<td><a href=\"tagPic.jsp?email=" + email + "&option=1&sys=1&tid=" + rset.getString(1) + "\">Start Tagging(ES)</a><br /><a href=\"tagPic.jsp?email=" + email + "&option=1&sys=2&tid=" + rset.getString(1) + "\">Start Tagging(PS)</a><br /><a href=\"viewTagES.jsp?email=" + email + "&option=1&sys=1&tid=" + rset.getString(1) + "\">VIEW TAGS(ES)</a><br /><a href=\"viewTagPS.jsp?email=" + email + "&option=1&sys=2&tid=" + rset.getString(1) + "\">VIEW TAGS(PS)</a></td>";
                                                    resultHtml += "<td><a href=\"tagPic.jsp?email=" + email + "&option=1&sys=1&tid=" + rset.getString(1) + "\">Start Tagging</a><br /><a href=\"viewTagES.jsp?email=" + email + "&option=1&sys=1&tid=" + rset.getString(1) + "\">VIEW TAGS</a></td>";
                                                }
                                                else {
                                                    resultHtml += "<td>" + rset.getString(i) + "</td>";
                                                }
                                            }
                                        }
                                        resultHtml += "</tr>";
                                    }
                                    resultHtml += "</table></font>";
                                    out.println(resultHtml);
                                } else {
                                    out.println("No Images Uploaded Yet!");
                                }
                            }

                        %>

                    </div>
                    <!--div id="tabs-2">
                        <p>Album I:							     </p>
                        <p><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span></p>
                        <p><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span></p>
                        <p>Album  II: </p>
                        <p><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span></p>
                        <p><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span><span style="padding:20px;alignment-adjust:central"><img src="images/user.jpg" width="101" height="89"  alt=""/></span></p>
                        <p>&nbsp;</p>
                    </div-->
                </div>
                <p>&nbsp;</p>
                <p>&nbsp;</p>
                <p>&nbsp;</p>
                <p>&nbsp;</p>
                <p>&nbsp;</p>
                <p>&nbsp;</p>
                <p>&nbsp;</p>
                <p>&nbsp;	</p>
                <p>&nbsp;</p>
            </div>
            <p>&nbsp;</p>
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
        <div></div>
    </div>
    <footer class="cfooter" id="idfooter">All Rights Reserved @ 2022

    </footer>
</div>
<script type="text/javascript">
    $(function() {
        $( "#Accordion1" ).accordion({
            collapsible:true,
            icons:{header: "ui-icon-arrow-1-e", activeHeader: "ui-icon-minus"},
            heightStyle:"content",
            active:1
        }); 
    });
    $(function() {
        $( "#Button1" ).button({
            disabled:true
        }); 
    });
    $(function() {
        $( "#Accordion5" ).accordion({
            heightStyle:"content",
            icons:{header: "ui-icon-arrowthick-1-e"}
        }); 
    });
    $(function() {
        $( "#Button1" ).button(); 
    });
    $(function() {
        $( "#Tabs1" ).tabs(); 
    });
    $(function() {
        $( "#Button2" ).button(); 
    });
    $(function() {
        $( "#Button3" ).button(); 
    });
</script>
</body>
</html>

