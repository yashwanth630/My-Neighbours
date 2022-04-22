<%-- 
    Document   : viewTagPic
    Created on : Apr 6, 2022, 12:17:48 PM
    Author     : Helias
--%>

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
    String tid = request.getParameter("tid");
    String heading = "";

    boolean ownerOfThePic = false;
    boolean checkDateProceed = false;

    // check owner
    {
        DataBase dbfunc = new DataBase();
        dbfunc.createConnection();

        String query = "select * from taginfo where tid=" + tid + " and  email='" + email + "'";
        System.out.println(query);

        ResultSet rset = dbfunc.queryRecord(query);
        boolean found = rset.next();

        if (found) {
            ownerOfThePic = true;
        } else {
            ownerOfThePic = false;
        }
    }
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


        </style>
        <script>
            $(document).ready(function() {
                


                $("#imageMap").click(function(e){


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


			



                    if((top_distance + mapper_height > imagemap_height) && (left_distance + mapper_width > imagemap_width)){
                        $('#mapper').css("left", (click_left - mapper_width - image_left  ))
                        .css("top",(click_top - mapper_height - image_top  ))
                        .css("width","100px")
                        .css("height","100px")
                        .show();
                    }
                    else if(left_distance + mapper_width > imagemap_width){


                        $('#mapper').css("left", (click_left - mapper_width - image_left  ))
                        .css("top",top_distance)
                        .css("width","100px")
                        .css("height","100px")
                        .show();
			
                    }
                    else if(top_distance + mapper_height > imagemap_height){
                        $('#mapper').css("left", left_distance)
                        .css("top",(click_top - mapper_height - image_top  ))
                        .css("width","100px")
                        .css("height","100px")
                        .show();
                    }
                    else{


                        $('#mapper').css("left",left_distance)
                        .css("top",top_distance)
                        .css("width","100px")
                        .css("height","100px")
                        .show();
                    }


                    $("#mapper").resizable({ containment: "parent" });
                    $("#mapper").draggable({ containment: "parent" });
                    
                });


            });




            $(".tagged").live("mouseover",function(){
                if($(this).find(".openDialog").length == 0){
                    $(this).find(".tagged_box").css("display","block");
                    $(this).css("border","5px solid #EEE");

                    $(this).find(".tagged_title").css("display","block");
                }
			

            });

            $(".tagged").live("mouseout",function(){
                if($(this).find(".openDialog").length == 0){
                    $(this).find(".tagged_box").css("display","none");
                    $(this).css("border","none");
                    $(this).find(".tagged_title").css("display","none");
                }
			

            });

            $(".tagged").live("click",function(){
                $(this).find(".tagged_box").html("<img src='pt_img/del.png' class='openDialog' value='Delete' onclick='deleteTag(this)' />\n\
        <img src='pt_img/save.png' onclick='editTag(this);' value='Save' />");

                var img_scope_top = $("#imageMap").offset().top + $("#imageMap").height() - $(this).find(".tagged_box").height();
                var img_scope_left = $("#imageMap").offset().left + $("#imageMap").width() - $(this).find(".tagged_box").width();

                $(this).draggable({ containment:[$("#imageMap").offset().left,$("#imageMap").offset().top,img_scope_left,img_scope_top]  });

            });

            var addTag = function(){                
                var position = $('#mapper').position();


                var pos_x = position.left;
                var pos_y = position.top;
                var pos_width = $('#mapper').width();
                var pos_height = $('#mapper').height();
                
                //document.write(pos_x+"--"+pos_y+"--"+pos_width+"---"+pos_height);
                var picId = <%=tid%>;
                makeRequest(picId,$("#title").val(),pos_x,pos_y,pos_width,pos_height);

                var split = $("#title").val().split('-');
                

                $('#planetmap').append('<div class="tagged"  style="width:'+pos_width+';height:'+
                    pos_height+';left:'+pos_x+';top:'+pos_y+';" ><div   class="tagged_box" style="width:'+pos_width+';height:'+
                    pos_height+';display:none;" ></div><div class="tagged_title" style="top:'+(pos_height+5)+';display:none;" >'+
                    split[0]+'</div></div>');

                $("#mapper").hide();
                $("#title").val('');
                $("#form_panel").hide();
                

            };

            var openDialog = function(){
                $("#form_panel").fadeIn("slow");
            };

            var showTags = function(){
                $(".tagged_box").css("display","block");
                $(".tagged").css("border","5px solid #EEE");
                $(".tagged_title").css("display","block");
            };

            var hideTags = function(){
                $(".tagged_box").css("display","none");
                $(".tagged").css("border","none");
                $(".tagged_title").css("display","none");
            };
		
            var editTag = function(obj){

                $(obj).parent().parent().draggable( 'disable' );
                $(obj).parent().parent().removeAttr( 'class' );
                $(obj).parent().parent().addClass( 'tagged' );
                $(obj).parent().parent().css("border","none");
                $(obj).parent().css("display","none");
                $(obj).parent().parent().find(".tagged_title").css("display","none");
                $(obj).parent().html('');

            }

            var deleteTag = function(obj){
                $(obj).parent().parent().remove();
            };

            // body load
            function fetch()
            {                
            <%
                if (ownerOfThePic) {
                    String fetch = "";
                    DataBase dbfunc = new DataBase();
                    dbfunc.createConnection();

                    String query = "select * from tagInfo where tid =" + tid + "&email='" + email + "'";
                    System.out.println(query);

                    ResultSet rset = dbfunc.queryRecord(query);
                    boolean found = rset.next();

                    if (found) {
                        rset.last();
                        int count = rset.getRow();
                        rset.beforeFirst();
                        while (rset.next()) {
                            fetch += "$('#planetmap').append('<div class=\"tagged\"  style=\"width:" + rset.getString("w") + ";height:" + rset.getString("h") + ";left:" + rset.getString("x") + ";top:" + rset.getString("y") + ";\" ><div class=\"tagged_box\" style=\"width:100;height:100;display:none;\" ></div><div class=\"tagged_title\" style=\"top:'+(" + rset.getString("h") + "+5)+';display:none;\" >" + rset.getString("friendName") + "</div></div>');\n";
                        }
                        out.println(fetch);
                    }
                } else {

                    ArrayList<String> tagIds = new ArrayList<String>();
                    String tagIdList = "";


                    {
                        DataBase dbfunc = new DataBase();
                        dbfunc.createConnection();

                        String query = "select * from taginfo where tid=" + tid + " and FLOOR(HOUR(TIMEDIFF(uploaddate, now()))/24)>0";
                        System.out.println(query);

                        ResultSet rset = dbfunc.queryRecord(query);
                        boolean found = rset.next();

                        if (found) {
                            checkDateProceed = true;
                            heading = "Review Completed!!!";
                        } else {
                            checkDateProceed = false;
                            heading = "Review Not Yet Complete!!!";
                        }

                        //tagIdList = tagIdList.trim().substring(0, tagIdList.trim().length() - 1);
                    }

                    // date ok
                    if (checkDateProceed) {
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
                            String fetch = "";
                            
                            while (rset.next()) {
                                String tagId = rset.getString("tagid");
                                String friendMail = rset.getString("friendMail");
                                String fileOwner = rset.getString("email");

                                DataBase dbfunc2 = new DataBase();
                                dbfunc2.createConnection();
                                String query2 = "select * from tagMatrix where tagid=" + tagId + " and tid=" + tid + " and email='" + email + "' and status='N'";
                                System.out.println(query2);
                                ResultSet rset2 = dbfunc2.queryRecord(query2);
                                boolean found2 = rset2.next();

                                if (found2) {
                                } else {
                                  fetch += "$('#planetmap').append('<div class=\"tagged\"  style=\"width:" + rset.getString("w") + ";height:" + rset.getString("h") + ";left:" + rset.getString("x") + ";top:" + rset.getString("y") + ";\" ><div class=\"tagged_box\" style=\"width:100;height:100;display:none;\" ></div><div class=\"tagged_title\" style=\"top:'+(" + rset.getString("h") + "+5)+';display:none;\" >" + rset.getString("friendName") + "</div></div>');\n";  
                                }
                            }
                            out.println(fetch);
                        } else {
                            heading += "<br />No Tag Info Found For Id:" + tid;
                        }

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
    <body bgcolor="#011c92" onLoad="fetch()">
        <div>  <a href="welcome.jsp" >HOME</a>&nbsp;<a href="logout.jsp" >LOGOUT</a> </div>
        <div id='main_panel'>

            <div style='margin: auto; width: 600px;'>
                <%
                    String line = "";
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
                            }
                        }
                    }
                %>

                <div id='main_panel'>

                    <div style='margin: auto; width: 600px;'>
                        <div id='image_panel' >
                            <img src=<%=line%> id='imageMap'  />


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
                        <h2><%=heading%></h2>
                        <input type="button" value="Show Tags" onclick="showTags()" />
                        <input type="button" value="Hide Tags" onclick="hideTags()" /><br /><br />                      
                    </div>                      
                </div>
                </body>
                </html>






