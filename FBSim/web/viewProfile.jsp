<%-- 
    Document   : viewProfile
    Created on : Mar 14, 2022, 1:27:08 AM

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

    String result = "";

    String friendMail = request.getParameter("friendMail");
    String urls0 = "MemberManagement?option=6&friendMail=" + friendMail.trim();

    boolean adsProceed = false;
    boolean profilePic = true;
    String profilePicPath = "images/users/none.jpg";

    String query = "select * from profiles p where p.email='" + friendMail.trim() + "' and p.siteType='"+ProjectProperties.siteName+"'";
    System.out.println(query);
    
    DataBase dbfunc = new DataBase();
    dbfunc.createConnection();

    ResultSet rsett = dbfunc.queryRecord(query);
    boolean found = rsett.next();

    if (found) {

        profilePicPath = "HttpObjectDownload?email=" + email + "&option=1";
        profilePic = true;

        adsProceed = true;

        String profiles = "work,education,relationship,familyMembers,aboutMe,quotations,movies,tvshows,singer,book,player,cityOfLiving,phone,address,profilePic";       

        String p[] = profiles.split(",");        
        result = "<table border=1><tr><th>ProfileItem</th><th>OldProfileValue</th></tr>";
        for (int i = 0; i < p.length; i++) {
            result += "<tr><td>" + p[i].toUpperCase() + "</td><td>" + rsett.getString("p." + p[i]) + "</td></tr>";
        }
        result += "</table>";
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
        <script type="text/javascript" src="myajax.js"></script>

        <link rel="stylesheet" type="text/css" href="css/style2.css" />
        <script type="text/javascript" src="JS/jquery-1.4.2.min.js"></script>
        <script src="JS/jquery.autocomplete.js"></script>	

    </head>

    <body bgcolor="#011c92">

        <header class="head" id="headId">
            <div style="padding:.5% 0 0 .5% ;margin-left:.5%" >

                <div class="HeadingCc" id="HeadingId"  ><%=msg%>
                    <p>Welcome <%=name%>.....</p>
                    <div style="text-align:right;margin-right:10px">  <a class="hf" href="logout.jsp" > LOG OUT</a> </div>
                </div>

            </div>


        </header>
        <div style="padding:2px">
            <div class="c_barleft" id="Id_barleft">
                <div style="padding:20px;alignment-adjust:central" align="center">
                    <%
                        if (!profilePic) {
                            profilePicPath = "images/none.jpg";
                            out.println("<p><img src=\"" + profilePicPath + "\" width=\"150\" height=\"120\"  alt=\"Set Profile Pic\"/></p>");
                        } else {
                            out.println("<p><img src=\"" + profilePicPath + "\" width=\"195\" height=\"240\"  alt=\"Set Profile Pic\"/></p>");
                        }
                    %>
                    <label style="color:#FFF"> <a href="welcome.jsp" class="hf">Home</a></label>
                    &nbsp;
                    <label style="color:#FFF"   ><a href="logout.jsp" class="hf">Logout</a>&nbsp;</label>
                </div>

                <div class="cleft_content" id="Idleft_content">


                    <div id="Accordion1" style="text-decoration:none">
                        <h3><a href="#" id="account" class="hhf">Account</a></h3>
                        <div>
                            <p><a href="profileSettings.jsp"  class="hf" title="Edit Profile Settings">Edit Profile</a></p>                             <p><a href="profileVisibility.jsp" class="hf" title="Disable/Enable Profile">Disable/Enable Profile</a></p>
                            <p><a href="upload.jsp?option=1" class="hf" >Upload Profile Pic</a></p>
                        </div>                        
                        <h3><a href="#" class="hhf">Friends</a></h3>
                        <div>                            
                            <!--p><a href="friends.jsp?option=1" class="hf"  title="Friends">Add Friends</a></p-->                            
                            <p><a href="<%=urls0%>" class="hf"  title="Friends">Block <%=friendMail%></a></p>
                            <!--p><a href="friends.jsp?option=2" class="hf"  title="Friends">View Friends</a></p-->                            
                        </div>                        
                    </div>
                    <p>&nbsp;</p>
                    <p align="center">&nbsp; </p>
                </div>
                <p>&nbsp;</p>
            </div>
            <div class="c_center" id="Id_center">
                <div>
                    <h1>Profile Information</h1>
                    <font color="white">
                    <div style='overflow:auto; width:400px;height:700px;'>
                        <%=result%>  
                    </div>
                    </font>
                </div>
                <h1></h1>
                <div>
                </div>
                <script>
                    jQuery(function(){
                        $("#movies").autocomplete("DynamicMovResults");
                        $("#singer").autocomplete("DynamicSingerResults");
                        $("#tvshows").autocomplete("DynamicShowResults");
                        $("#book").autocomplete("DynamicBookResults");
                        $("#player").autocomplete("DynamicPlayerResults");
                    });
                </script>        
                <p>&nbsp;</p>
            </div>
            <div class="c_barright" id="Id_barright" >
                <div class="cleft_content" id="Idleft_content2"><br>
                    <div id="Accordion5" style="text-decoration:none">

                    </div>
                    <p align="center">&nbsp; </p>
                </div>
            </div>
            <div></div>
        </div>
        <footer class="cfooter" id="idfooter">

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
<%
    }
    else
               {
        out.println("No Profile Created Yet!!!");
        
        out.println("<br/><br/><a href='"+urls0+"'>Block "+friendMail+"</a>");
    }
%>
