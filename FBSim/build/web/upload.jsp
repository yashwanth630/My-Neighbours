<%-- 
    Document   : upload
    Created on : Mar 10, 2022, 11:18:29 PM
    Author     : 
--%>

<%@page import="osn.ProjectProperties"%>
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
    String profilePicPath = "images/users/none.jpg";
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
        <script src="jQueryAssets/jquery-1.8.3.min.js" type="text/javascript"></script>
        <script src="jQueryAssets/jquery-ui-1.9.2.accordion.custom.min.js" type="text/javascript"></script>
        <script src="jQueryAssets/jquery-ui-1.9.2.button.custom.min.js" type="text/javascript"></script>

        <style>
            #note:link {background-color:#B2FF99;}    /* unvisited link */
            #note:visited {background-color:#FFFF85;} /* visited link */
            #note:hover {background-color:#FF704D;}   /* mouse over link */
            #note:active {background-color:#FF704D;}  /* selected link */
        </style>

    </head>

    <body bgcolor="#011c92">

        <header class="head" id="headId">
            <div align="left" >
                <%                                  
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
                        profilePic = false;
                        response.sendRedirect("welcome.jsp?msg=Set Profiles First");                   
                        return;
                    }
                    
                %>




            </div>

            <div style="padding:.5% 0 0 .5% ;margin-left:.5%" >

                <div class="HeadingCc" id="HeadingId"  ><%=msg%>
                    <p>Welcome <%=name%>.....</p>
                    <div style="text-align:right;margin-right:10px">  <a class="hf" href="welcome.jsp" >HOME</a>&nbsp;&nbsp;<a class="hf" href="logout.jsp" >LOGOUT</a> </div>
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
                            out.println("<p><img src=\"" + profilePicPath + "\" width=\"150\" height=\"120\"  alt=\"\"/>");
                        }
                    %>

                    <label style="color:#FFF"> <a href="welcome.jsp" class="hf">Home</a></label>
                    &nbsp;
                    <label style="color:#FFF"   ><a href="logout.jsp" class="hf">Logout</a></label>
                    </p>
                </div>
                <div id="Accordion1" style="text-decoration:none">
                    <h3><a href="#" id="account" class="hhf">Account</a></h3>
                    <div>
                        <p><a href="profileSettings.jsp"  class="hf" title="Edit Profile Settings">Edit Profile</a></p>                             <p><a href="profileVisibility.jsp" class="hf" title="Disable/Enable Profile">Disable/Enable Profile</a></p>
                        <p><a href="upload.jsp?option=1" class="hf" >Upload Profile Pic</a></p>
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
                    <h1>Upload Area</h1>
                </div>
                <div><font color="white">
                    <form name="form1" id="form1" action="ProfilePicUploader" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="option" value="<%=option%>">
                        Files to upload:
                        <br/>
                        <input type="file" size="50" name="file1">
                        <br/>                        
                        
                        <br/>
                        <input type="submit" value="Upload">
                    </form>
                    </font>
                </div>

                <p>&nbsp;</p>
            </div>
            <div class="c_barright" id="Id_barright" align="center">                   
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
        $(function() {
            $( "#Accordion1" ).accordion({
                collapsible:true,
                icons:{header: "ui-icon-arrow-1-e", activeHeader: "ui-icon-minus"},
                heightStyle:"content"
            }); 
        });
        $(function() {
            $( "#Button1" ).button({
                disabled:true
            }); 
        });
        $(function() {
            $( "#Accordion2" ).accordion(); 
        });
        $(function() {
            $( "#Accordion3" ).accordion(); 
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
    </script>
</body>
</html>
