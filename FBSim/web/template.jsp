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

    String friendMail = request.getParameter("friendMail");
    boolean adsProceed = false;
    boolean profilePic = true;
    String profilePicPath = "";

    boolean profilePic2 = true;
    String profilePicPath2 = "";

    String urls0 = "MemberManagement?option=6&friendMail=" + friendMail.trim();
    String urls1 = "MemberManagement?option=5&friendMail=" + friendMail.trim();
    String urls2 = "localContent.jsp?option=5&friendMail=" + friendMail.trim();
    String urls3 = "remoteContent.jsp?option=5&friendMail=" + friendMail.trim();
    String urls4 = "MemberManagement?option=8&friendMail=" + friendMail.trim();

    if (option.equals("1")) {
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
                    {
                        String query = "select * from profiles p where p.email='" + email.trim() + "' and siteType='" + ProjectProperties.siteName + "'";
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
                        }
                    }

                    {
                        String query = "select * from profiles p where p.email='" + friendMail.trim() + "' and siteType='" + ProjectProperties.siteName + "'";
                        System.out.println(query);

                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        ResultSet rsett = dbfunc.queryRecord(query);
                        boolean found = rsett.next();

                        if (found) {
                            profilePicPath2 = "HttpObjectDownload?email=" + friendMail + "&option=1";
                            profilePic2 = true;

                        } else {
                            profilePic2 = false;
                        }
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
                            out.println("<p><img src=\"" + profilePicPath + "\" width=\"195\" height=\"240\"  alt=\"\"/>");
                        }
                    %>
                    <label style="color:#FFF"> <a href="welcome.jsp" class="hf">Home</a></label>
                    &nbsp;
                    <label style="color:#FFF"   ><a href="logout.jsp" class="hf">Logout</a></label>
                    </p>
                    <p>Member Data
                        <%
                            if (!profilePic2) {
                                profilePicPath2 = "images/users/none.jpg";
                                out.println("<p><img src=\"" + profilePicPath2 + "\" width=\"150\" height=\"120\"  alt=\"\"/>");
                            } else {
                                out.println("<p><img src=\"" + profilePicPath2 + "\" width=\"195\" height=\"240\"  alt=\"\"/>");
                            }
                        %>
                        <label style="color:#FFF"><%=friendMail%></label>

                </div>
                <div class="cleft_content" id="Idleft_content">


                    <div id="Accordion1" style="text-decoration:none">
                        <h3><a href="#" class="hhf">Wall</a></h3>
                        <div>                                                        
                            <p><a href="<%=urls1%>" class="hf"  title="Friends">View <%=friendMail%> Wall</a></p>                            
                        </div>                        
                        <h3><a href="#" class="hhf">Friends</a></h3>
                        <div>                                               
                            <p><a href="<%=urls4%>" class="hf"  title="Friends">View <%=friendMail%> Friends</a></p>                            
                        </div>
                    </div>
                    <p>&nbsp;</p>
                    <p align="center">&nbsp; </p>
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
                            out.println("<div><font color=\"black\" size=\"5\"></div>");
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
                heightStyle: "content"
            });
        });
        $(function () {
            $("#Button1").button({
                disabled: true
            });
        });
        $(function () {
            $("#Accordion2").accordion();
        });
        $(function () {
            $("#Accordion3").accordion();
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
    </script>
</body>
</html>
<%}%>

<%

    if (option.equals("2")) {

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
                <%                    {
                        String query = "select * from profiles p where p.email='" + email.trim() + "' and p.siteType='" + ProjectProperties.siteName + "'";
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
                        }
                    }

                    {
                        String query = "select * from profiles p where p.email='" + friendMail.trim() + "' and p.siteType='" + ProjectProperties.siteName + "'";
                        System.out.println(query);

                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        ResultSet rsett = dbfunc.queryRecord(query);
                        boolean found = rsett.next();

                        if (found) {
                            profilePicPath2 = "HttpObjectDownload?email=" + friendMail + "&option=1";
                            profilePic2 = true;

                        } else {
                            profilePic2 = false;
                        }
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
                            out.println("<p><img src=\"" + profilePicPath + "\" width=\"195\" height=\"240\"  alt=\"\"/>");
                        }
                    %>
                    <label style="color:#FFF"> <a href="welcome.jsp" class="hf">Home</a></label>
                    &nbsp;
                    <label style="color:#FFF"   ><a href="logout.jsp" class="hf">Logout</a></label>
                    </p>
                    <p>Member Data
                        <%
                            if (!profilePic2) {
                                profilePicPath2 = "images/users/none.jpg";
                                out.println("<p><img src=\"" + profilePicPath2 + "\" width=\"150\" height=\"120\"  alt=\"\"/>");
                            } else {
                                out.println("<p><img src=\"" + profilePicPath2 + "\" width=\"195\" height=\"240\"  alt=\"\"/>");
                            }
                        %>
                        <label style="color:#FFF"><%=friendMail%></label>
                </div>
                <div class="cleft_content" id="Idleft_content">


                    <div id="Accordion1" style="text-decoration:none">
                        <h3><a href="#" class="hhf">Wall</a></h3>

                        <div>                                                        
                            <p><a href="<%=urls0%>" class="hf"  title="Friends">Block <%=friendMail%></a></p>
                            <p><a href="<%=urls1%>" class="hf"  title="Friends">View <%=friendMail%> Wall</a></p>                            
                            <p><a href="<%=urls2%>" class="hf"  title="Friends">View <%=friendMail%> Pics</a></p>                            
                            <!--p><a href="<%=urls3%>" class="hf"  title="Friends">View <%=friendMail%> Cross Site Pics</a></p-->                            
                        </div>                        
                        <h3><a href="#" class="hhf">Friends</a></h3>
                        <div>                                               
                            <p><a href="<%=urls4%>" class="hf"  title="Friends">View <%=friendMail%> Friends</a></p>                            
                        </div>
                    </div>
                    <p>&nbsp;</p>
                    <p align="center">&nbsp; </p>
                </div>
                <p>&nbsp;</p>
            </div>
            <div class="c_center" id="Id_center">
                <div class="wall" id="wall">
                    <h1><%=friendMail%>-Wall</h1>
                    <font color="black">
                    <form name="form1" id="form1" action="Operations" method="post" >
                        <input type="hidden" name="operation" value="10">                        
                        <input type="hidden" name="friendMail" value="<%=friendMail%>">
                        <input type="hidden" name="page" value="template.jsp">
                        <input type="hidden" name="system" value="0">
                        Post Wall Message
                        <br/><br/>
                        <textarea name="message" rows="3" cols="35"></textarea>
                        <br/>                        
                        <br/><br/>
                        <input type="submit" id="Button2" value="Post Message" id="submitID" /><br />
                    </form>
                    </font> 
                </div>
                <%
                    String resultantHtml = "";
                    {
                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        String query = "select * from friends where friendMail='" + friendMail + "' and status='1' and siteType='" + ProjectProperties.siteName + "' order by publishDate desc";
                        //System.out.println(query);

                        ResultSet rset = dbfunc.queryRecord(query);
                        boolean found = rset.next();

                        if (found) {
                            rset.last();
                            int count = rset.getRow();
                            int row = 0;
                            String line = "";
                            rset.beforeFirst();
                            while (rset.next()) {
                                String id = rset.getString("id");
                                String requester = rset.getString("email");
                                String status = rset.getString("status");
                                String publishDate = rset.getString("publishDate");

//                                resultantHtml += "<div class=\"wallpost\"><span style=\"padding:20px;alignment-adjust:central\"><img src=\"\" width=\"50\" height=\"50\"  alt=\"\"/></span>";
//                                resultantHtml += "<div>";
//                                resultantHtml += "<h3><a href=\"#\">New Friend Request By : " + requester + "</a></h3>";
//                                resultantHtml += "<div><p><a href='Operations?operation=3&page=welcome.jsp&choice=1&id=" + id + "'>Accept</a>&nbsp;&nbsp;<a href='Operations?operation=3&page=welcome.jsp&choice=2&id=2'>Decline</a></p></div>";
//                                resultantHtml += "<h3>My Time Line</h3>";
//                                resultantHtml += "<div><p>" + publishDate + "</p></div>";
//                                resultantHtml += "</div>";
//                                resultantHtml += "</div>";

                            }
                        }
                    }
                    {
                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        String query = "select * from wallmessages where siteType='" + ProjectProperties.siteName + "' order by msgDate desc";
                        //System.out.println(query);

                        ResultSet rset = dbfunc.queryRecord(query);
                        boolean found = rset.next();

                        if (found) {
                            rset.last();
                            int count = rset.getRow();
                            int row = 0;
                            String line = "";
                            rset.beforeFirst();
                            while (rset.next()) {
                                String fromMail = rset.getString("fromMail");
                                String message = rset.getString("message");
                                String publishDate = rset.getString("msgDate");

                                resultantHtml += "<div class=\"wallpost\">";
                                resultantHtml += "<div>";
                                resultantHtml += "<h3><a href=\"#\">New Post from : " + fromMail + "</a></h3>";
                                resultantHtml += "<div><p><font color='red'>" + message + "</font></p></div>";
                                resultantHtml += "<h3>My Time Line</h3>";
                                resultantHtml += "<div><p>" + publishDate + "</p></div>";
                                resultantHtml += "</div>";
                                resultantHtml += "</div>";

                            }
                        }
                    }
                    {
                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        String query = "select * from notifications where siteType='" + ProjectProperties.siteName + "' order by publishDate desc";

                        ResultSet rset = dbfunc.queryRecord(query);
                        boolean found = rset.next();

                        if (found) {
                            rset.last();
                            int count = rset.getRow();
                            int row = 0;
                            String line = "";
                            rset.beforeFirst();
                            while (rset.next()) {
                                String nid = rset.getString("id");
                                String myEmail = rset.getString("email");
                                String notification = rset.getString("notification");
                                String activity = rset.getString("activity");
                                String publishDate = rset.getString("publishDate");
                                String otherinfo = rset.getString("otherinfo");

                                if (friendMail.equals(myEmail)) {
                                    if (activity.startsWith("New Image Upload")) {
                                        String parts = activity.trim();
                                        resultantHtml += "<div class=\"wallpost\">";

                                        resultantHtml += "<div>";
                                        resultantHtml += "<h3><a href=\"#\">" + notification + " on " + publishDate + "</a></h3>";
                                        if (otherinfo.equals("null")) {
                                            otherinfo = "1";
                                        }
                                        String lin = "<p><a href=\"ImageServlet?email=" + email + "&option=21&tid=" + otherinfo + "\"><img src=\"ImageServlet?email=" + email + "&option=21&tid=" + otherinfo + "\" width=\"160\" height=\"160\"  alt=\"\"/></a></p>";
                                        resultantHtml += "<div>" + lin + "</div>";
                                        resultantHtml += "</div>";

                                        resultantHtml += "</div>";
                                    } else {
                                        resultantHtml += "<div class=\"wallpost\"><span style=\"padding:20px;alignment-adjust:central\"><!--img src=\"\" width=\"50\" height=\"50\"  alt=\"\"/--></span>";
                                        resultantHtml += "<div>";
                                        resultantHtml += "<h3><a href=\"#\">" + activity + "</a></h3>";
                                        resultantHtml += "<div><p>" + notification + "</p></div>";
                                        resultantHtml += "<h3>My Time Line</h3>";
                                        resultantHtml += "<div><p>" + publishDate + "</p></div>";
                                        resultantHtml += "</div>";
                                        resultantHtml += "</div>";
                                        continue;
                                    }
                                } else {
                                    resultantHtml += "<div class=\"wallpost\"><span style=\"padding:20px;alignment-adjust:central\"><!--img src=\"\" width=\"50\" height=\"50\"  alt=\"\"/--></span>";
                                    resultantHtml += "<div>";
                                    resultantHtml += "<h3><a href=\"#\">" + activity + "</a></h3>";
                                    resultantHtml += "<div><p>" + notification + "</p></div>";
                                    resultantHtml += "<h3>Time Line</h3>";
                                    resultantHtml += "<div><p>" + publishDate + "</p></div>";
                                    resultantHtml += "</div>";
                                    resultantHtml += "</div>";
                                    continue;
                                }
                            }
                        } else {
                            resultantHtml += "<div class=\"wallpost\"><span style=\"padding:20px;alignment-adjust:central\"><!--img src=\"\" width=\"50\" height=\"50\"  alt=\"\"/--></span>";
                            resultantHtml += "<div>";
                            resultantHtml += "<h3><a href=\"#\">No Activities</a></h3>";
                            resultantHtml += "<div><p>No Notifications</p></div>";
                            resultantHtml += "<h3>Time Line</h3>";
                            resultantHtml += "<div><p>No TimeLines</p></div>";
                            resultantHtml += "</div>";
                            resultantHtml += "</div>";
                        }

                    }
                    out.println(resultantHtml);
                %>

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
                            out.println("<div><font color=\"black\" size=\"5\"></div>");
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
                heightStyle: "content"
            });
        });
        $(function () {
            $("#Button1").button({
                disabled: true
            });
        });
        $(function () {
            $("#Accordion2").accordion();
        });
        $(function () {
            $("#Accordion3").accordion();
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
    </script>
</body>
</html>
<%}%>




<%

    if (option.equals("5")) {

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
                <%                    {
                        String query = "select * from profiles p where p.email='" + email.trim() + "' and p.siteType='" + ProjectProperties.siteName + "'";
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
                        }
                    }

                    {
                        String query = "select * from profiles p where p.email='" + friendMail.trim() + "' and p.siteType='" + ProjectProperties.siteName + "'";
                        System.out.println(query);

                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        ResultSet rsett = dbfunc.queryRecord(query);
                        boolean found = rsett.next();

                        if (found) {
                            profilePicPath2 = "HttpObjectDownload?email=" + friendMail + "&option=1";
                            profilePic2 = true;

                        } else {
                            profilePic2 = false;
                        }
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
                            out.println("<p><img src=\"" + profilePicPath + "\" width=\"195\" height=\"240\"  alt=\"\"/>");
                        }
                    %>
                    <label style="color:#FFF"> <a href="welcome.jsp" class="hf">Home</a></label>
                    &nbsp;
                    <label style="color:#FFF"   ><a href="logout.jsp" class="hf">Logout</a></label>
                    </p>
                    <p>Member Data
                        <%
                            if (!profilePic2) {
                                profilePicPath2 = "images/users/none.jpg";
                                out.println("<p><img src=\"" + profilePicPath2 + "\" width=\"150\" height=\"120\"  alt=\"\"/>");
                            } else {
                                out.println("<p><img src=\"" + profilePicPath2 + "\" width=\"195\" height=\"240\"  alt=\"\"/>");
                            }
                        %>
                        <label style="color:#FFF"><%=friendMail%></label>
                </div>
                <div class="cleft_content" id="Idleft_content">


                    <div id="Accordion1" style="text-decoration:none">
                        <h3><a href="#" class="hhf">Wall</a></h3>
                        <div>                                                        
                            <p><a href="<%=urls1%>" class="hf"  title="Friends">View <%=friendMail%> Wall</a></p>                            
                        </div>                        
                        <h3><a href="#" class="hhf">Friends</a></h3>
                        <div>                                               
                            <p><a href="<%=urls4%>" class="hf"  title="Friends">View <%=friendMail%> Friends</a></p>                            
                        </div>
                    </div>
                    <p>&nbsp;</p>
                    <p align="center">&nbsp; </p>
                </div>
                <p>&nbsp;</p>
            </div>
            <div class="c_center" id="Id_center">
                <div class="wall" id="wall">
                    <h1><%=friendMail%>-Friends</h1>
                </div>
                <%
                    {
                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        //String query = "select u.email,u.firstname,u.lastname from users u,profiles p,profilesVisibility pv where p.email=u.email and pv.email=u.email";
                        String query = "select * from friends where email='" + friendMail + "' and status='1' and siteType='" + ProjectProperties.siteName + "'";
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
                                if (mail.equals(email)) {
                                    continue;
                                }

                                //String query1 = "select p.email,p.ProfilePic,pv.email,pv.profilePic where p.email='"+mail.trim()+"' and pv.email='"+mail.trim()+"'";
                                String query1 = "select * from users where email='" + mail + "' and showProfile=1 and siteType='" + ProjectProperties.siteName + "'";
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
                                            line += "<p><span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=9&source=" + friendMail + "&friendMail=" + mail.trim() + "\"><img src=\"HttpObjectDownload?email=" + mail.trim() + "&option=1\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                                            continue;
                                        }
                                        if (row % 4 == 0) {
                                            line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=9&source=" + friendMail + "&friendMail=" + mail.trim() + "\"><img src=\"HttpObjectDownload?email=" + mail.trim() + "&option=1\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span></p>";
                                            row = 0;
                                            continue;
                                        } else {
                                            line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=9&source=" + friendMail + "&friendMail=" + mail.trim() + "\"><img src=\"HttpObjectDownload?email=" + mail.trim() + "&option=1\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                                            continue;
                                        }
                                    } else {
                                        row++;
                                        if (row == 1) {
                                            line += "<p><span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=9&source=" + friendMail + "&friendMail=" + mail.trim() + "\"><img src=\"images/none.jpg\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
                                            continue;
                                        }
                                        if (row % 4 == 0) {
                                            line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=9&source=" + friendMail + "&friendMail=" + mail.trim() + "\"><img src=\"images/none.jpg\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span></p>";
                                            row = 0;
                                            continue;
                                        } else {
                                            line += "<span style=\"padding:20px;alignment-adjust:central\"><a href=\"MemberManagement?option=9&source=" + friendMail + "&friendMail=" + mail.trim() + "\"><img src=\"images/none.jpg\" width=\"80\" height=\"80\"  alt=\"\"/></a><font size=1>" + fN + "." + lN + "</font></span>";
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
                            out.println("<div><font color=\"black\" size=\"5\"></div>");
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
                heightStyle: "content"
            });
        });
        $(function () {
            $("#Button1").button({
                disabled: true
            });
        });
        $(function () {
            $("#Accordion2").accordion();
        });
        $(function () {
            $("#Accordion3").accordion();
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
    </script>
</body>
</html>
<%}%>

<%

    if (option.equals("6")) {
        String mid = request.getParameter("mid");
        String highLight = "";
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
                    {
                        String query = "select * from profiles p where p.email='" + email.trim() + "' and p.siteType='" + ProjectProperties.siteName + "'";
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
                        }
                    }

                    {
                        String query = "select * from profiles p where p.email='" + friendMail.trim() + "' and p.siteType='" + ProjectProperties.siteName + "'";
                        System.out.println(query);

                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        ResultSet rsett = dbfunc.queryRecord(query);
                        boolean found = rsett.next();

                        if (found) {
                            profilePicPath2 = "HttpObjectDownload?email=" + friendMail + "&option=1";
                            profilePic2 = true;

                        } else {
                            profilePic2 = false;
                        }
                    }

                    {
                        String query = "select * from wallMessageStatus where num ='" + mid.trim() + "' and siteType='" + ProjectProperties.siteName + "'";
                        System.out.println(query);

                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        ResultSet rsett = dbfunc.queryRecord(query);
                        boolean found = rsett.next();

                        if (found) {
                            String data[] = rsett.getString("messageDetails").split("[$$$]+");
                            if (data[0].equals("Yes")) {
                                highLight += "<p>Profane Message Found";
                                highLight += "<p>" + data[1];
                                highLight += "<p>" + data[2];
                                highLight += "<p>" + data[3];
                                highLight += "<p>Transformed : " + data[4];
                                highLight += "<p><hr />";
                            }
                            if (data[0].equals("No")) {
                                highLight += "<p>Profane Message Found";
                                highLight += "<p>" + data[1];
                                highLight += "<p>" + data[2];
                                highLight += "<p>" + data[3];
                                highLight += "<p>Transformed : " + data[4];
                                highLight += "<p><hr />";
                            }
                        } else {
                            highLight += "Message Not Found!!!";
                        }
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
                            out.println("<p><img src=\"" + profilePicPath + "\" width=\"195\" height=\"240\"  alt=\"\"/>");
                        }
                    %>
                    <label style="color:#FFF"> <a href="welcome.jsp" class="hf">Home</a></label>
                    &nbsp;
                    <label style="color:#FFF"   ><a href="logout.jsp" class="hf">Logout</a></label>
                    </p>
                    <p>Member Data
                        <%
                            if (!profilePic2) {
                                profilePicPath2 = "images/users/none.jpg";
                                out.println("<p><img src=\"" + profilePicPath2 + "\" width=\"150\" height=\"120\"  alt=\"\"/>");
                            } else {
                                out.println("<p><img src=\"" + profilePicPath2 + "\" width=\"195\" height=\"240\"  alt=\"\"/>");
                            }
                        %>
                        <label style="color:#FFF"><%=friendMail%></label>
                </div>
                <div class="cleft_content" id="Idleft_content">


                    <div id="Accordion1" style="text-decoration:none">
                        <h3><a href="#" class="hhf">Wall</a></h3>
                        <div>                                                        
                            <p><a href="<%=urls1%>" class="hf"  title="Friends">View <%=friendMail%> Wall</a></p>                            
                        </div>                        
                        <h3><a href="#" class="hhf">Friends</a></h3>
                        <div>                                               
                            <p><a href="<%=urls4%>" class="hf"  title="Friends">View <%=friendMail%> Friends</a></p>                            
                        </div>
                    </div>
                    <p>&nbsp;</p>
                    <p align="center">&nbsp; </p>
                </div>
                <p>&nbsp;</p>
            </div>
            <div class="c_center" id="Id_center">
                <div class="wall" id="wall">
                    <h1><%=friendMail%>-Wall</h1><font color="black">
                    <form name="form1" id="form1" action="Operations" method="post" >
                        <input type="hidden" name="operation" value="10">                        
                        <input type="hidden" name="friendMail" value="<%=friendMail%>">
                        <input type="hidden" name="page" value="template.jsp">
                        <input type="hidden" name="system" value="0">
                        Post Wall Message
                        <br/><br/>
                        <textarea name="message" rows="3" cols="35"></textarea>
                        <br/>                        
                        <br/><br/>
                        <input type="submit" id="Button2" value="Post Message" id="submitID" /><br />
                        <%=highLight%>
                    </form></font> 
                </div>
                <%
                    String resultantHtml = "";
                    {
                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        String query = "select * from friends where friendMail='" + friendMail + "' and status='0' and siteType='" + ProjectProperties.siteName + "' order by publishDate desc";
                        //System.out.println(query);

                        ResultSet rset = dbfunc.queryRecord(query);
                        boolean found = rset.next();

                        if (found) {
                            rset.last();
                            int count = rset.getRow();
                            int row = 0;
                            String line = "";
                            rset.beforeFirst();
                            while (rset.next()) {
                                String id = rset.getString("id");
                                String requester = rset.getString("email");
                                String status = rset.getString("status");
                                String publishDate = rset.getString("publishDate");

                                resultantHtml += "<div class=\"wallpost\"><span style=\"padding:20px;alignment-adjust:central\"><img src=\"\" width=\"50\" height=\"50\"  alt=\"\"/></span>";
                                resultantHtml += "<div>";
                                resultantHtml += "<h3><a href=\"#\">New Friend Request By : " + requester + "</a></h3>";
                                resultantHtml += "<div><p><a href='Operations?operation=3&page=welcome.jsp&choice=1&id=" + id + "'>Accept</a>&nbsp;&nbsp;<a href='Operations?operation=3&page=welcome.jsp&choice=2&id=2'>Decline</a></p></div>";
                                resultantHtml += "<h3>My Time Line</h3>";
                                resultantHtml += "<div><p>" + publishDate + "</p></div>";
                                resultantHtml += "</div>";
                                resultantHtml += "</div>";

                            }
                        }
                    }
                    {
                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        String query = "select * from wallmessages where siteType='" + ProjectProperties.siteName + "' order by msgDate desc";
                        //System.out.println(query);

                        ResultSet rset = dbfunc.queryRecord(query);
                        boolean found = rset.next();

                        if (found) {
                            rset.last();
                            int count = rset.getRow();
                            int row = 0;
                            String line = "";
                            rset.beforeFirst();
                            while (rset.next()) {
                                String fromMail = rset.getString("fromMail");
                                String message = rset.getString("message");
                                String publishDate = rset.getString("msgDate");

                                resultantHtml += "<div class=\"wallpost\"><span style=\"padding:20px;alignment-adjust:central\"><img src=\"\" width=\"50\" height=\"50\"  alt=\"\"/></span>";
                                resultantHtml += "<div>";
                                resultantHtml += "<h3><a href=\"#\">New Message from : " + fromMail + "</a></h3>";
                                resultantHtml += "<div><p><font color='red'>" + message + "</font></p></div>";
                                resultantHtml += "<h3>My Time Line</h3>";
                                resultantHtml += "<div><p>" + publishDate + "</p></div>";
                                resultantHtml += "</div>";
                                resultantHtml += "</div>";

                            }
                        }
                    }
                    {
                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        String query = "select * from notifications where siteType='" + ProjectProperties.siteName + "' order by publishDate desc";

                        ResultSet rset = dbfunc.queryRecord(query);
                        boolean found = rset.next();

                        if (found) {
                            rset.last();
                            int count = rset.getRow();
                            int row = 0;
                            String line = "";
                            rset.beforeFirst();
                            while (rset.next()) {
                                String nid = rset.getString("id");
                                String myEmail = rset.getString("email");
                                String notification = rset.getString("notification");
                                String activity = rset.getString("activity");
                                String publishDate = rset.getString("publishDate");

                                if (friendMail.equals(myEmail)) {
                                    resultantHtml += "<div class=\"wallpost\"><span style=\"padding:20px;alignment-adjust:central\"><!--img src=\"\" width=\"50\" height=\"50\"  alt=\"\"/--></span>";
                                    resultantHtml += "<div>";
                                    resultantHtml += "<h3><a href=\"#\">" + activity + "</a></h3>";
                                    resultantHtml += "<div><p>" + notification + "</p></div>";
                                    resultantHtml += "<h3>My Time Line</h3>";
                                    resultantHtml += "<div><p>" + publishDate + "</p></div>";
                                    resultantHtml += "</div>";
                                    resultantHtml += "</div>";
                                    continue;

                                } else {
                                    resultantHtml += "<div class=\"wallpost\"><span style=\"padding:20px;alignment-adjust:central\"><!--img src=\"\" width=\"50\" height=\"50\"  alt=\"\"/--></span>";
                                    resultantHtml += "<div>";
                                    resultantHtml += "<h3><a href=\"#\">" + activity + "</a></h3>";
                                    resultantHtml += "<div><p>" + notification + "</p></div>";
                                    resultantHtml += "<h3>Time Line</h3>";
                                    resultantHtml += "<div><p>" + publishDate + "</p></div>";
                                    resultantHtml += "</div>";
                                    resultantHtml += "</div>";
                                    continue;
                                }
                            }
                        } else {
                            resultantHtml += "<div class=\"wallpost\"><span style=\"padding:20px;alignment-adjust:central\"><!--img src=\"\" width=\"50\" height=\"50\"  alt=\"\"/--></span>";
                            resultantHtml += "<div>";
                            resultantHtml += "<h3><a href=\"#\">No Activities</a></h3>";
                            resultantHtml += "<div><p>No Notifications</p></div>";
                            resultantHtml += "<h3>Time Line</h3>";
                            resultantHtml += "<div><p>No TimeLines</p></div>";
                            resultantHtml += "</div>";
                            resultantHtml += "</div>";
                        }

                    }
                    out.println(resultantHtml);
                %>

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
                            out.println("<div><font color=\"black\" size=\"5\"></div>");
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
                heightStyle: "content"
            });
        });
        $(function () {
            $("#Button1").button({
                disabled: true
            });
        });
        $(function () {
            $("#Accordion2").accordion();
        });
        $(function () {
            $("#Accordion3").accordion();
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
    </script>
</body>
</html>
<%}%>