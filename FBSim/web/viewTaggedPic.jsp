<%-- 
    Document   : viewTaggedPic
    Created on : Apr 6, 2022, 8:51:03 AM
    Author     : Helias
--%>

<%@page import="osn.ProjectProperties"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="osn.DataBase"%>
<%

    String msg = request.getParameter("msg");
    msg = (msg == null ? "" : msg);

    String email = (String) session.getAttribute("email");
    String name = (String) session.getAttribute("name");

    if (email == null) {
        response.sendRedirect("index.jsp?msg=Unauthorized Access");
        return;
    }

    String returnPage = request.getParameter("page");
    String choice = request.getParameter("choice");
    String tid = request.getParameter("tid");
    String fileOwner = "none";
    String tagId = request.getParameter("tagid");

    if (choice.trim().equals("1")) {
%>


<html>
    <head>
        <title>Image Tagging</title>

        <link rel="stylesheet" type="text/css" href="pt_css/style2.css" />
        <script type="text/javascript" src="pt_js/jquery-1.4.2.min.js"></script>
        <script src="pt_js/jquery.autocomplete.js"></script>	



        <link rel="stylesheet" type="text/css" href="pt_css/style2.css" />
        <script type="text/javascript" src="pt_js/jquery-1.4.2.min.js"></script>
        <script src="pt_js/jquery.autocomplete.js"></script>
        <script src="pt_js/myajax.js"></script>


        <style type="text/css" >

            body{
                font-size:13px;
                font-family:"Arial";                
            }
            #mapper{
                border:5px solid #EEE;
                width:100px;
                height:100px;
                min-width:100px;
                min-height:100px;
                z-index:1000;
                position:absolute;
                top:0;
                display:none;
            }

            #planetmap div{

                display:block;
                position:absolute;
            }




            #main_panel{
                margin: auto;
                padding: 10px;
                width: 1000px;
            }
            #url_panel{

            }
            #form_panel{
                float: left;
                background:#eee;
                border:5px solid #FFF;
                outline:1px solid #eee;
                left: 100px;
                padding: 5px;
                /*position: absolute;*/
                top: 40px;
                width: 310px;
                display:none;
                z-index:2000;
            }

            #form_panel input,textarea{
                padding:3px;
                background:#FFF;
                border:1px solid #CFCFCF;
                color:#000;
            }

            #image_panel{
                float:left;
                width:600px;
                position:relative;
            }
            #image_panel img{
                left:0;top:-102px;
                max-width: 600px;
                overflow: hidden;

            }


            #form_panel .label{
                float:left;
                width:80px;
                padding:5px;
            }

            #form_panel .field{
                float:left;
                width:200px;
                padding:5px;
            }

            #form_panel .row{
                clear:both;
            }

            .tagged_title{
                background: none repeat scroll 0 0 #538DD3;
                border: 2px solid;
                color: #FFFFFF;
                font-size: 12px;
                font-weight: bold;
                padding: 3px;
                margin-top:5px;
            }


            #info_panel{
                padding:10px;
                margin:20px 0;
                background:#eee;
            }


            input[type='button']{
                background: none repeat scroll 0 0 #2769C4;
                border: 1px solid #CFCFCF;
                color: #FFFFFF;
                font-weight: bold;
                height: 30px;
                padding: 5px;
            }


            section {
                width: 80%;
                height: 200px;
                background: aqua;
                margin: auto;
                padding: 10px;
            }
            div#one {
                width: 50%;
                height: 200px;
                background: white;
                float: left;
            }
            div#two {
                margin-left: 15%;
                height: 200px;
                background: gray;
            }



        </style>
        <script>
            $(document).ready(function () {



                $("#imageMap").click(function (e) {


                    var image_left = $(this).offset().left;
                    var click_left = e.pageX;
                    var left_distance = click_left - image_left;

                    var image_top = $(this).offset().top;
                    var click_top = e.pageY;
                    var top_distance = click_top - image_top;

                    var mapper_width = $('#mapper').width();
                    var imagemap_width = $('#imageMap').width();

                    var mapper_height = $('#mapper').height();
                    var imagemap_height = $('#imageMap').height();






                    if ((top_distance + mapper_height > imagemap_height) && (left_distance + mapper_width > imagemap_width)) {
                        $('#mapper').css("left", (click_left - mapper_width - image_left))
                                .css("top", (click_top - mapper_height - image_top))
                                .css("width", "100px")
                                .css("height", "100px")
                                .show();
                    }
                    else if (left_distance + mapper_width > imagemap_width) {


                        $('#mapper').css("left", (click_left - mapper_width - image_left))
                                .css("top", top_distance)
                                .css("width", "100px")
                                .css("height", "100px")
                                .show();

                    }
                    else if (top_distance + mapper_height > imagemap_height) {
                        $('#mapper').css("left", left_distance)
                                .css("top", (click_top - mapper_height - image_top))
                                .css("width", "100px")
                                .css("height", "100px")
                                .show();
                    }
                    else {


                        $('#mapper').css("left", left_distance)
                                .css("top", top_distance)
                                .css("width", "100px")
                                .css("height", "100px")
                                .show();
                    }


                    $("#mapper").resizable({containment: "parent"});
                    $("#mapper").draggable({containment: "parent"});

                });


            });




            $(".tagged").live("mouseover", function () {
                if ($(this).find(".openDialog").length == 0) {
                    $(this).find(".tagged_box").css("display", "block");
                    $(this).css("border", "5px solid #EEE");

                    $(this).find(".tagged_title").css("display", "block");
                }


            });

            $(".tagged").live("mouseout", function () {
                if ($(this).find(".openDialog").length == 0) {
                    $(this).find(".tagged_box").css("display", "none");
                    $(this).css("border", "none");
                    $(this).find(".tagged_title").css("display", "none");
                }


            });

            $(".tagged").live("click", function () {
                $(this).find(".tagged_box").html("<img src='pt_img/del.png' class='openDialog' value='Delete' onclick='deleteTag(this)' />\n\
        <img src='pt_img/save.png' onclick='editTag(this);' value='Save' />");

                var img_scope_top = $("#imageMap").offset().top + $("#imageMap").height() - $(this).find(".tagged_box").height();
                var img_scope_left = $("#imageMap").offset().left + $("#imageMap").width() - $(this).find(".tagged_box").width();

                $(this).draggable({containment: [$("#imageMap").offset().left, $("#imageMap").offset().top, img_scope_left, img_scope_top]});

            });

            var addTag = function () {
                var position = $('#mapper').position();


                var pos_x = position.left;
                var pos_y = position.top;
                var pos_width = $('#mapper').width();
                var pos_height = $('#mapper').height();

                //document.write(pos_x+"--"+pos_y+"--"+pos_width+"---"+pos_height);
                var picId = <%=tid%>;
                makeRequest(picId, $("#title").val(), pos_x, pos_y, pos_width, pos_height);

                var split = $("#title").val().split('-');


                $('#planetmap').append('<div class="tagged"  style="width:' + pos_width + ';height:' +
                        pos_height + ';left:' + pos_x + ';top:' + pos_y + ';" ><div   class="tagged_box" style="width:' + pos_width + ';height:' +
                        pos_height + ';display:none;" ></div><div class="tagged_title" style="top:' + (pos_height + 5) + ';display:none;" >' +
                        split[0] + '</div></div>');

                $("#mapper").hide();
                $("#title").val('');
                $("#form_panel").hide();


            };

            var openDialog = function () {
                $("#form_panel").fadeIn("slow");
            };

            var showTags = function () {
                $(".tagged_box").css("display", "block");
                $(".tagged").css("border", "5px solid #EEE");
                $(".tagged_title").css("display", "block");
            };

            var hideTags = function () {
                $(".tagged_box").css("display", "none");
                $(".tagged").css("border", "none");
                $(".tagged_title").css("display", "none");
            };

            var editTag = function (obj) {

                $(obj).parent().parent().draggable('disable');
                $(obj).parent().parent().removeAttr('class');
                $(obj).parent().parent().addClass('tagged');
                $(obj).parent().parent().css("border", "none");
                $(obj).parent().css("display", "none");
                $(obj).parent().parent().find(".tagged_title").css("display", "none");
                $(obj).parent().html('');

            }

            var deleteTag = function (obj) {
                $(obj).parent().parent().remove();
            };

            // body load
            function fetch()
            {
            <%
                {
                    try {
                        String fetch = "";
                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        String query = "select * from taginfo where tid=" + tid + "";
                        System.out.println(query);

                        ResultSet rset = dbfunc.queryRecord(query);
                        boolean found = rset.next();

                        if (found) {
                            rset.last();
                            int count = rset.getRow();
                            rset.beforeFirst();
                            while (rset.next()) {
                                fetch += "$('#planetmap').append('<div class=\"tagged\"  style=\"width:" + rset.getString("w") + ";height:" + rset.getString("h") + ";left:" + rset.getString("x") + ";top:" + rset.getString("y") + ";\" ><div class=\"tagged_box\" style=\"width:100;height:100;display:none;\" ></div><div class=\"tagged_title\" style=\"top:'+(" + rset.getString("h") + "+5)+';display:none;\" >" + rset.getString("friendName") + "</div></div>');\n";
                                if (rset.getString("friendMail").equals(email)) {
                                    tagId = rset.getString("tagid");
                                }
                            }
                        }
                        out.println(fetch);
                    } catch (Exception e) {
                        out.println("E1:" + e.toString());
                    }
                }
            %>
                showTags();
            }

        </script>

        <style type="text/css">
            a {font-family:Georgia,serif; font-size:large}
            a:link {color:yellow;}
            a:visited {color:white;}
            a:hover {text-decoration:none;color:yellowgreen;font-weight:bold;}
            a:active {color:red;text-decoration: none}
        </style>       
    </head>
    <!--body bgcolor="#011c92" onLoad="fetch()"-->
    <body bgcolor="#011c92">
        <div>  <a href="welcome.jsp" >HOME</a>&nbsp;<a href="logout.jsp" >LOGOUT</a> </div>
        <div id='main_panel'>

            <div style='margin: auto; width: 600px;'>
                <%
                    String line = "";
                    try {

                        {
                            DataBase dbfunc = new DataBase();
                            dbfunc.createConnection();

                            String query = "select tid,email from fileuploads where filetype='Image' and tid=" + tid + "";
                            System.out.println(query);

                            ResultSet rset = dbfunc.queryRecord(query);
                            boolean found = rset.next();

                            if (found) {
                                rset.last();
                                int count = rset.getRow();

                                rset.beforeFirst();
                                if (rset.next()) {
                                    line = "\"ImageServlet?email=" + email + "&option=21&tid=" + rset.getString(1) + "\"";
                                    fileOwner = rset.getString(2).trim();
                                }
                            }
                        }

                    } catch (Exception e) {
                        out.println("E2:" + e.toString());
                    }

                %>

                <div id='main_panel'>

                    <div style='margin: auto; width: 600px;'>
                        <div id='image_panel' >
                            <img src=<%=line%> id='imageMap' />


                            <div id="planetmap">

                            </div>
                            <div id='form_panel'>                                                             

                            </div>
                        </div>

                    </div>
                    <div style="background: none repeat scroll 0 0 #C7C7C8;
                         border: 1px solid #AEAEAE;
                         clear: both;
                         margin: 20px auto;
                         padding: 20px 0;
                         text-align: center;
                         width: 600px;">
                        <!--input type="button" value="Show Tags" onclick="showTags()" />
                        <input type="button" value="Hide Tags" onclick="hideTags()" /--><br /><br />                      

                    </div>  
                    <center>

                        <form method="post" action="Operations">
                            <%
                                ArrayList<String> total = new ArrayList<String>();
                                ArrayList<String> myFriends = new ArrayList<String>();
                                ArrayList<String> fileOwnerFriends = new ArrayList<String>();
                                ArrayList<String> fileOwnerTaggedFriends = new ArrayList<String>();
                                ArrayList<String> fileOwnerTaggedFriendsFriends = new ArrayList<String>();

                                ArrayList<String> filteredFileOwnerFriends = new ArrayList<String>();

                                try {

                                    DataBase db = new DataBase();
                                    db.createConnection();
                                    //String query = "select * from friends where email='" + email.trim() + "'";
                                    // all members
                                    String query = "";
                                    System.out.println("*****************************************");

                                    // myFriends
                                    query = "select friendMail from friends where email='" + email.trim() + "'";
                                    System.out.println(query);
                                    ResultSet rset = db.queryRecord(query);
                                    while (rset.next()) {
                                        myFriends.add(rset.getString(1));
                                    }

                                    System.out.println("My Friends List : " + myFriends.size());

                                    // fileOwnerFriends
                                    query = "select friendMail from friends where email='" + fileOwner.trim() + "'";
                                    System.out.println(query);
                                    rset = db.queryRecord(query);
                                    while (rset.next()) {
                                        fileOwnerFriends.add(rset.getString(1));
                                    }

                                    System.out.println("File Owner Friends List : " + fileOwnerFriends.size());

                                    // fileOwner Tagged People
                                    query = "select friendMail from taginfo where friendMail!='" + fileOwner.trim() + "' and friendMail!='" + email + "' and tid=" + tid;
                                    System.out.println(query);
                                    rset = db.queryRecord(query);
                                    while (rset.next()) {
                                        fileOwnerTaggedFriends.add(rset.getString(1));
                                    }

                                    System.out.println("File Owner Tagged Friends List : " + fileOwnerTaggedFriends.size());

                                    // fileOwner Tagged People's friends
                                    for (int i = 0; i < fileOwnerTaggedFriends.size(); i++) {
                                        query = "select friendMail from friends where email='" + fileOwnerTaggedFriends.get(i).trim() + "'";
                                        System.out.println(query);
                                        rset = db.queryRecord(query);
                                        while (rset.next()) {
                                            fileOwnerTaggedFriendsFriends.add(rset.getString(1).trim());
                                        }
                                    }

                                    System.out.println("File Owner Tagged People's Friends List : " + fileOwnerTaggedFriendsFriends.size());

                                    // joining two lists
                                    ArrayList<String> newList = new ArrayList<String>(fileOwnerFriends);
                                    newList.addAll(fileOwnerTaggedFriends);
                                    newList.addAll(fileOwnerTaggedFriendsFriends);

                                    // remove duplicates
                                    HashSet hs = new HashSet();
                                    hs.addAll(newList);
                                    newList.clear();
                                    newList.addAll(hs);
                                    ////////////////////

                                    filteredFileOwnerFriends = newList;

                                    System.out.println("*****************************************");
                                    db.closeConnection();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    out.println("SQLException=" + e.toString());
                                }
                            %>


                            <section>
                                <div id="one">
                                    <b><u>My Friends</u></b>
                                            <%
                                                String html = "<table border=0>";
                                                for (int i = 0; i < myFriends.size(); i++) {
                                                    if (fileOwner.equals(myFriends.get(i).trim())) {
                                                    } else {
                                                        html += "<tr>";
                                                        html += "<td><input type=\"checkbox\" name='fid_" + i + "' value='" + myFriends.get(i).trim() + "' >" + myFriends.get(i).trim() + "</td>";
                                                        //html += "<td><input type='text' readonly='true' name=pc" + rset1.getString(1) + " value=" + rset1.getString(i) + "></td>";                                            
                                                        html += "</tr>";
                                                    }
                                                }
                                                html += "</table>";
                                                out.println(html);
                                            %>

                                </div>

                                <div id="two">
                                    <b><u>Pic Owner(<%=fileOwner%>) Members</u></b>
                                            <%
                                                String html2 = "<table border=0>";
                                                for (int i = 0; i < filteredFileOwnerFriends.size(); i++) {
                                                    if (fileOwner.equals(filteredFileOwnerFriends.get(i).trim())) {
                                                    } else {
                                                        html2 += "<tr>";
                                                        html2 += "<td><input type=\"checkbox\" name='mid_" + i + "' value='" + filteredFileOwnerFriends.get(i).trim() + "' " + ProjectProperties.historyAssesment(filteredFileOwnerFriends.get(i).trim(), email) + " ><b>" + filteredFileOwnerFriends.get(i).trim() + "</b></td>";
                                                        //html += "<td><input type='text' readonly='true' name=pc" + rset1.getString(1) + " value=" + rset1.getString(i) + "></td>";                                            
                                                        html2 += "</tr>";
                                                    }
                                                }
                                                html2 += "</table>";
                                                out.println(html2);
                                            %>

                                </div>
                            </section><br /><br />
                            <input type="hidden" name="tid" value='<%=tid%>'>
                            <input type="hidden" name="operation" value='20'>                            
                            <input type="hidden" name="fileOwner" value='<%=fileOwner%>'>  
                            <input type="hidden" name="tagId" value='<%=tagId%>'>  
                            <input type="submit" name="save" value="OK" />

                        </form>

                    </center>
                </div>
                </body>
                </html>


                <%            }

                    if (choice.trim().equals("2")) {
                        String query1 = "update taginfo set status='N' where tid=" + tid + " and friendMail='" + email + "'";
                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();
                        System.out.println(query1);
                        dbfunc.updateRecord(query1);

                        String query3 = "insert into tagMatrix(`tagId`,`tid`,`email`,`status`) values(" + tagId + "," + tid + ",'" + email.trim() + "','N')";
                        System.out.println(query3);
                        try {
                            dbfunc.updateRecord(query3);
                        } catch (Exception e) {
                            System.out.println(e.toString());
                        }

                        response.sendRedirect("welcome.jsp?msg=Tagging Denied");
                    }

                    if (choice.trim().equals("3")) {
                        String query1 = "update taginfo set status='Y' where tid=" + tid + " and friendMail='" + email + "'";
                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();
                        System.out.println(query1);
                        dbfunc.updateRecord(query1);
                        
                        String query3 = "insert into tagMatrix(`tagId`,`tid`,`email`,`status`) values(" + tagId + "," + tid + ",'" + email.trim() + "','Y')";
                        System.out.println(query3);
                        try {
                            dbfunc.updateRecord(query3);
                        } catch (Exception e) {
                            System.out.println(e.toString());
                        }

                        response.sendRedirect("welcome.jsp?msg=Tagging Accepted");
                    }

                %>