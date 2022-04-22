<%-- 
    Document   : welcome
    Created on : Mar 14, 2022, 11:20:00 PM

--%>

<%@page import="java.net.URL"%>
<%@page import="osn.ProjectProperties"%>
<%@page import="osn.DataBase"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.File"%>
<%
    String msg = request.getParameter("msg");
    msg = (msg == null ? "" : msg);

    String email = (String) session.getAttribute("email");
    String name = (String) session.getAttribute("name");
    String zone = (String) session.getAttribute("zonal");
    String groupid = (String) session.getAttribute("groupid");

    String groupInfo = "";
    {
        DataBase dbfunc = new DataBase();
        dbfunc.createConnection();

        String query = "SELECT groupName from usergroups where usid='" + groupid + "'";
        System.out.println(query);

        ResultSet rset = dbfunc.queryRecord(query);
        boolean found = rset.next();

        if (found) {
            rset.last();
            int count = rset.getRow();
            int row = 0;
            String line = "";
            rset.beforeFirst();
            if (rset.next()) {
                String g = rset.getString("groupName");
                groupInfo += ("<option value='" + g + "'>" + g + "</option>");
            }
        }
        dbfunc.closeConnection();
    }

    if (email == null) {
        response.sendRedirect("index.jsp?msg=Unauthorized Access");
        return;
    }

    boolean adsProceed = true;
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
        <script src="JS/arrowfunction.js"></script>

        <script language="javascript">
            var hash = {
                '.jpg': 1,
                '.JPG': 1,
                '.JPEG': 1,
                '.jpeg': 1
            };

            function check_extension(filename, submitId) {
                var re = /\..+$/;
                var ext = filename.match(re);
                var submitEl = document.getElementById(submitId);
                if (hash[ext]) {
                    //submitEl.disabled = false;
                    return true;
                } else {
                    alert("Invalid filename, Please select JPG file");
                    //submitEl.disabled = true;
                    return false;
                }
            }
        </script>

        <style>            
            /* The Modal (background) */
            .modal {
                display: none; /* Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 1; /* Sit on top */
                padding-top: 100px; /* Location of the box */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                overflow: auto; /* Enable scroll if needed */
                background-color: rgb(0,0,0); /* Fallback color */
                background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            }

            /* Modal Content */
            .modal-content {
                position: relative;
                background-color: #fefefe;
                margin: auto;
                padding: 0;
                border: 1px solid #888;
                width: 80%;
                box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
                -webkit-animation-name: animatetop;
                -webkit-animation-duration: 0.4s;
                animation-name: animatetop;
                animation-duration: 0.4s
            }

            /* Add Animation */
            @-webkit-keyframes animatetop {
                from {top:-300px; opacity:0} 
                to {top:0; opacity:1}
            }

            @keyframes animatetop {
                from {top:-300px; opacity:0}
                to {top:0; opacity:1}
            }

            /* The Close Button */
            .close {
                color: white;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: #000;
                text-decoration: none;
                cursor: pointer;
            }

            .modal-header {
                padding: 2px 16px;
                background-color: #5cb85c;
                color: white;
            }

            .modal-body {padding: 2px 16px;}

            .modal-footer {
                padding: 2px 16px;
                background-color: #5cb85c;
                color: white;
            }
        </style>

        <style>
            #note:link {background-color:#B2FF99;}    /* unvisited link */
            #note:visited {background-color:#FFFF85;} /* visited link */
            #note:hover {background-color:#FF704D;}   /* mouse over link */
            #note:active {background-color:#FF704D;}  /* selected link */
        </style>

    </head>

    <body bgcolor="#011c92">
        <!-- The Modal -->
        <div id="myModal" class="modal">

            <!-- Modal content -->
            <div class="modal-content">
                <div class="modal-header">
                    <span class="close">&times;</span>
                    <h2>Upload A Pic...</h2>
                </div>
                <div class="modal-body">
                    <form name="form1" id="form1" action="UploadImageFromWall" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="option" value="3">                                                
                        <select name="groupid">
                            <option value='All'>Will Be Published to All</option>
                            <%=groupInfo%>
                        </select>
                        <input type="file" size="50" name="file1" onchange="check_extension(this.value, 'submitID');" multiple><br/>                        
                        <input type="submit" id="Button2" value="Upload A Pic" id="submitID" /><br />
                    </form>
                </div>
                <div class="modal-footer">
                    <h3>@</h3>
                </div>
            </div>

        </div>

        <header class="head" id="headId">
            <div align="left" >
                <%                    String notifications = "";
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
                            notifications += "<a id='note' href='profileSettings.jsp'>Click Here To Set Profile</a><br />";
                            profilePic = false;
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
                    <br />
                    <label style="color:#FFF"> <a href="welcome.jsp" class="hf">Home</a></label>
                    &nbsp;
                    <label style="color:#FFF"   ><a href="logout.jsp" class="hf">Logout</a></label>
                    </p>
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
                        <h3><a href="#" class="hhf">Games</a></h3>
                        <div>                            
                            <!--p><a href="games/tictactoe.html" class="hf">Tic Tac Toe</a></p-->
                            <p><a href="games/ball-fall.html" class="hf">Ball Fall</a></p>
                            <p><a href="games/ping-pong.html" class="hf">Ping Pong</a></p>
                            <p><a href="games/breakout.html" class="hf">Break Out</a></p>
                            <p><a href="games/snake.html" class="hf">Snake</a></p>                            
                        </div>                                                
                    </div>
                    <p>&nbsp;</p>
                    <p align="center">&nbsp; </p>
                </div>
                <p>&nbsp;</p>
            </div>
            <div class="c_center" id="Id_center">
                <div class="wall" id="wall">
                    <h1>Wall </h1>
                    <font color="black">
                    <form name="form1" id="form1" action="Operations" method="post" >
                        <input type="hidden" name="operation" value="10">                        
                        <input type="hidden" name="friendMail" value="<%=email%>">
                        <input type="hidden" name="page" value="welcome.jsp">
                        <input type="hidden" name="system" value="0">                        
                        <textarea name="message" rows="3" cols="35" placeholder="What's On Your Mind..."></textarea>
                        <br/>                                                
                        <select name="groupid">
                            <option value='All'>Will Be Published to All</option>
                            <%=groupInfo%>
                        </select>
                        <br/>
                        <input type="submit" id="Button2" value="Post Message" id="submitID" />&nbsp;&nbsp;                        
                    </form>
                    <button id="myBtn">Upload A Pic</button>
                    </font>
                </div>
                <%
                    String resultantHtml = "";
                    {
                        /////////////////
                        if (notifications.trim().length() > 0) {
                            resultantHtml += "<div class=\"wallpost\"><span style=\"padding:20px;alignment-adjust:central\"><!--img src=\"\" width=\"50\" height=\"50\"  alt=\"\"/--></span>";
                            resultantHtml += "<div>";
                            resultantHtml += "<h3><a href=\"#\">Notifications Area:</a></h3>";
                            resultantHtml += "<div><p>" + notifications + "</p></div>";
                            resultantHtml += "<h3>My Time Line</h3>";
                            resultantHtml += "<div><p>Now</p></div>";
                            resultantHtml += "</div>";
                            resultantHtml += "</div>";
                        }
                    }

                    {
                        //new friend request
//                        DataBase dbfunc = new DataBase();
//                        dbfunc.createConnection();
//
//                        String query = "select * from friends where friendMail='" + email + "' and status='0' and zonal='" + zone + "' order by publishDate desc";
//                        //System.out.println(query);
//
//                        ResultSet rset = dbfunc.queryRecord(query);
//                        boolean found = rset.next();
//
//                        if (found) {
//                            rset.last();
//                            int count = rset.getRow();
//                            int row = 0;
//                            String line = "";
//                            rset.beforeFirst();
//                            while (rset.next()) {
//                                String id = rset.getString("id");
//                                String requester = rset.getString("email");
//                                String status = rset.getString("status");
//                                String publishDate = rset.getString("publishDate");
//
//                                resultantHtml += "<div class=\"wallpost\"><span style=\"padding:20px;alignment-adjust:central\"><!--img src=\"\" width=\"50\" height=\"50\"  alt=\"\"/--></span>";
//                                resultantHtml += "<div>";
//                                resultantHtml += "<h3><a href=\"#\">New Friend Request By : " + requester + "</a></h3>";
//                                resultantHtml += "<div><p><a href='Operations?operation=3&page=welcome.jsp&choice=1&id=" + id + "'>Accept</a>&nbsp;&nbsp;<a href='Operations?operation=3&page=welcome.jsp&choice=2&id=2'>Decline</a></p></div>";
//                                resultantHtml += "<h3>My Time Line</h3>";
//                                resultantHtml += "<div><p>" + publishDate + "</p></div>";
//                                resultantHtml += "</div>";
//                                resultantHtml += "</div>";
//
//                            }
//                        }
                    }
                    // tag requests
                    {
                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        String query = "SELECT *,FLOOR(HOUR(TIMEDIFF(uploaddate, now()))/24) as days from taginfo t where friendMail='" + email + "' and status='W';";
                        System.out.println(query);

                        ResultSet rset = dbfunc.queryRecord(query);
                        boolean found = rset.next();

                        if (found) {
                            rset.last();
                            int count = rset.getRow();
                            int row = 0;
                            String line = "";
                            rset.beforeFirst();
                            if (rset.next()) {
                                String days = rset.getString("days");
                                String tagid = rset.getString("tagid");
                                String id = rset.getString("tid");
                                String requester = rset.getString("email");
                                String publishDate = rset.getString("uploaddate");
                                String stat = rset.getString("status");

                                if (stat.equals("W")) {
                                    if (days.trim().equals("0")) {
                                        resultantHtml += "<div class=\"wallpost\"><span style=\"padding:20px;alignment-adjust:central\"><!--img src=\"\" width=\"50\" height=\"50\"  alt=\"\"/--></span>";
                                        resultantHtml += "<div>";
                                        resultantHtml += "<h3><a href=\"#\">New Pic Tag Request By : " + requester + "</a></h3>";
                                        resultantHtml += "<div><p><a href='viewTaggedPic.jsp?page=welcome.jsp&choice=1&tagid=" + tagid + "&tid=" + id + "'>Review Request</a>&nbsp;&nbsp;<a href='viewTaggedPic.jsp?page=welcome.jsp&choice=3&tagid=" + tagid + "&tid=" + id + "'>Accept Request</a>&nbsp;&nbsp;<a href='viewTaggedPic.jsp?page=welcome.jsp&choice=2&tagid=" + tagid + "&tid=" + id + "'>Deny Request</a></p></div>";
                                        resultantHtml += "<h3>My Time Line</h3>";
                                        resultantHtml += "<div><p>" + publishDate + "</p></div>";
                                        resultantHtml += "</div>";
                                        resultantHtml += "</div>";
                                    }
                                    if (Integer.parseInt(days) > 0) {
                                        String up = "update taginfo set status='Y' where tagid=" + tagid + " and tid=" + id + " and email='" + requester + "'";
                                        String query2 = "insert into notifications(`email`,`notification`,`activity`,`publishDate`,siteType) values('" + email + "','User(" + requester + ") has Tagged Friend with (" + email + ") in " + rset.getString("filename") + "','PhotoTagging Complete By " + requester + " using UO',now(),'" + ProjectProperties.siteName + "')";
                                        System.out.println("Auto Submission : " + up);
                                        dbfunc.updateRecord(up);
                                        dbfunc.updateRecord(query2);

                                    }
                                }

                            }
                        }
                        dbfunc.closeConnection();
                    }
                    // end of tag requests
                    {
                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        String query = "select * from notifications order by publishDate desc";
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
                                String nid = rset.getString("id");
                                String myEmail = rset.getString("email");
                                String notification = rset.getString("notification");
                                String activity = rset.getString("activity");
                                String publishDate = rset.getString("publishDate");
                                String otherinfo = rset.getString("otherinfo");
                                String siteType = rset.getString("siteType");

                                if (activity.startsWith("TagPic:")) {
                                    if (myEmail.trim().equals(email)) {
                                        String parts[] = activity.trim().split(":");
                                        resultantHtml += "<div class=\"wallpost\"><span style=\"padding:20px;alignment-adjust:central\"><!--img src=\"\" width=\"50\" height=\"50\"  alt=\"\"/--></span>";
                                        resultantHtml += "<div>";
                                        resultantHtml += "<h3><a href=\"#\">" + notification + "</a></h3>";
                                        resultantHtml += "<div><p><a href='viewTagPic.jsp?page=welcome.jsp&tid=" + parts[1].trim() + "'>View Tagged Pic</a></p></div>";
                                        resultantHtml += "<h3>Time Line</h3>";
                                        resultantHtml += "<div><p>" + publishDate + "</p></div>";
                                        resultantHtml += "</div>";
                                        resultantHtml += "</div>";
                                    }
                                } else if (activity.contains("Posted New Message On")) {
                                    if (ProjectProperties.isFriends(email, myEmail)) {
                                        resultantHtml += ProjectProperties.getMessage(siteType, email);
                                    } else {
                                        if (email.equals(myEmail)) {
                                            resultantHtml += ProjectProperties.getMessage(siteType, email);
                                        }
                                    }
                                } else if (activity.startsWith("New Image Upload")) {
                                    if (myEmail.trim().equals(email)) {
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
                                        if (ProjectProperties.isFriends(email, myEmail)) {
                                            String par[] = siteType.split("_");
                                            if (par.length == 2) {
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
                                            }
                                            if (par.length == 4) {
                                                String groupTable = par[2];
                                                groupTable = groupTable.replace("$", "_");
                                                String subGroup = par[3];
                                                if (ProjectProperties.isUserBelongsToGroup(groupTable, subGroup, email)) {
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
//                                                    resultantHtml += "<div class=\"wallpost\">";
//                                                    resultantHtml += "<div>";
//                                                    resultantHtml += "<h3><a href=\"#\">Image Redacted</a></h3>";
//                                                    resultantHtml += "<div><p><font color='red'>Redacted Image</font></p></div>";
//                                                    resultantHtml += "</div>";
//                                                    resultantHtml += "</div>";
                                                }
                                            }
                                        }
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
                                }
                                continue;
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
                <jsp:include page="chat.jsp" />  
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
            <div>Content for New Div Tag Goes Here</div>
        </div>

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

    <script>
// Get the modal
        var modal = document.getElementById("myModal");

// Get the button that opens the modal
        var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
        btn.onclick = function () {
            modal.style.display = "block";
        }

// When the user clicks on <span> (x), close the modal
        span.onclick = function () {
            modal.style.display = "none";
        }

// When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>
</html>

