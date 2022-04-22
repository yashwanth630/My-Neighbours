<%@page import="osn.ProjectProperties"%>
<%@page import="java.net.URL"%>
<%@page import="osn.Config"%>
<%
    // contextPath
    ServletContext context = session.getServletContext();
    Config.setContext(context);
    /////////////    

    URL urll = new URL(request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI());
    if (request.getServerName().contains("localhost")) {
        urll = new URL(request.getScheme() + "://" + Config.getMyIp() + ":" + request.getServerPort() + request.getRequestURI());
        String url = urll.toString();
        response.sendRedirect(url);
    }
%>
<%
    String msg = request.getParameter("msg");
    msg = (msg == null ? "" : "<font size='2'>" + msg + "</font>");

%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title><%=ProjectProperties.projectTitle%></title>        
        <!--link href="jQueryAssets/jquery.ui.core.min.css" rel="stylesheet" type="text/css">
        <link href="jQueryAssets/jquery.ui.theme.min.css" rel="stylesheet" type="text/css">
        <link href="jQueryAssets/jquery.ui.button.min.css" rel="stylesheet" type="text/css">
        <script src="jQueryAssets/jquery-1.8.3.min.js" type="text/javascript"></script>
        <script src="jQueryAssets/jquery-ui-1.9.2.button.custom.min.js" type="text/javascript"></script-->




        <!--CSS STYLES-->
        <link href="css/demoStyles.css" rel="stylesheet" type="text/css" />

        <!--jQuery core-->
        <script type="text/javascript" src="JS/jquery-1.6.4.js"></script>

        <!--Form Highlighter plugin-->
        <script src="JS/jquery.formHighlighter.js" type="text/javascript"></script>

        <!--Demo examples-->
        <script type="text/javascript">
            $(document).ready(function () {


                /*Calling your own functions through Form Highlighter*/
                $("#advancedCall").formHighlighter({
                    classFocus: 'demoFocus',
                    classBlur: 'demoBlur',
                    classKeyDown: 'demoKeydown',
                    classNotEqualToDefault: 'demoNotEqualToDefault',
                    clearField: false,
                    onBlur: function () {
                        demoBlur();
                    },
                    onFocus: function () {
                        demoFocus($(this));
                    }
                });


                /*Your own function that will be called from Form Highlighter*/
                function demoBlur() {
                    $("#advancedCall input.demoBlur:not(input:hidden)").stop(0, 1).fadeTo(500, 1.0);
                }

                function demoFocus(element) {
                    $("#advancedCall input.demoBlur:not(input:hidden)").stop(0, 1).fadeTo(500, 0.5);
                }

            });


        </script>

        <style>
            @font-face {
                font-family: 'ModernPictogramsNormal';
                src: url('fonts/modernpics-webfont.eot');
                src: url('fonts/modernpics-webfont.eot?#iefix') format('embedded-opentype'),
                    url('fonts/modernpics-webfont.woff') format('woff'),
                    url('fonts/modernpics-webfont.ttf') format('truetype'),
                    url('fonts/modernpics-webfont.svg#ModernPictogramsNormal') format('svg');
                font-weight: normal;
                font-style: normal;
            }
            body {
                background-color: #f9f9f9;
                background-image: url("css/1.png");                
                color: #555;
            }
            label {
                display: inline-block;
                cursor: pointer;
                position: relative;
                padding-left: 25px;
                margin-right: 15px;
                font-size: 13px;
            }
            .wrapper {
                width: 500px;
                margin: 50px auto;
            }
            input[type=radio],
            input[type=checkbox] {
                display: none;
            }
            label:before {
                content: "";
                display: inline-block;

                width: 16px;
                height: 16px;

                margin-right: 10px;
                position: absolute;
                left: 0;
                bottom: 1px;
                background-color: #aaa;
                box-shadow: inset 0px 2px 3px 0px rgba(0, 0, 0, .3), 0px 1px 0px 0px rgba(255, 255, 255, .8);
            }

            .radio label:before {
                border-radius: 8px;
            }
            .checkbox label {
                margin-bottom: 10px;
            }
            .checkbox label:before {
                border-radius: 3px;
            }

            input[type=radio]:checked + label:before {
                content: "\2022";
                color: #f3f3f3;
                font-size: 30px;
                text-align: center;
                line-height: 18px;
            }

            input[type=checkbox]:checked + label:before {
                content: "\2713";
                text-shadow: 1px 1px 1px rgba(0, 0, 0, .2);
                font-size: 15px;
                color: #f3f3f3;
                text-align: center;
                line-height: 15px;
            }
        </style>

    </head>
    <div>
        <div style="height:60px;width:100%;background-color:rgb(0,0,0);font-family:'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', 'DejaVu Sans', 'Verdana', 'sans-serif'">
            <div align='left'><img src='images/fb.PNG' width="292" height="57"  alt="" /> <div align="right" style="float:right;padding-top:10px;padding-right:200px;color:white;font-size:18px"><form method="post" action="Login">Login Id&nbsp;<input type="text" name="email" value="">&nbsp;Password&nbsp;<input type="password" name="password" value="">&nbsp;<input type="submit" style="font-size: 20px;height:40px; width:120px;background-color:rgb(0,153,255);" value="Login"></form></div></div>
        </div>

        <div>
            <div align="center">
                <div style="padding-top:100px;font-size:45px;color:white">Welcome To My Neighbors<br /><%=msg%></div>
                <div style="padding-top:20px;font-size:28px;color:white">Connect with Friends In Your Neighborhood</div>
                <div style="padding-top:20px;font-size:18px;color:white">Register Below If You Are Not Already Registered</div>
                <div id="advancedCall" style="padding-top:20px;font-size:28px;">
                    <form method="post" action="Registration">
                        <input class="myclass" type="text" name="fn" value="Type Your First Name Here" /><br />
                        <input class="myclass" type="text" name="ln" value="Type Your Last Name Here" /><br />

                        <input class="myclass" type="password" name="pw" value="Enter Password" /><br />
                        <input class="myclass" type="password" name="cpw" value="Confirm Password" /><br />

                        <input class="myclass" type="text" name="email2" value="Type Your Email Here" /><br />
                        <input class="myclass" type="text" name="email3" value="Confirm Your Email Here" /><br />                   

                        <input class="myclass" type="text" name="dob" value="DateOfBirth(mm/dd/yyyy)" /><br />                   

                        <input class="myclass" type="text" name="country" value="London(Canada)" /><br />                                       
                        <select id="zone" class="myclass" name="zone" onchange="myFunction()">
                            <option>Select A Zone</option>
                            <option>North-East London</option>
                            <option>South-East London</option>
                            <option>North-West London</option>
                            <option>South-West London</option>
                        </select>
                        <div id="demo"></div>

                        <div class="radio" style="font-size:45px;color:white">
                            <input id="male" type="radio" name="gender" value="Male">
                            <label for="male">Male</label>
                            <input id="female" type="radio" name="gender" value="Female">
                            <label for="female">Female</label>
                            <input id="others" type="radio" name="gender" value="Others">
                            <label for="others">Others</label>
                        </div>

                        <div class="checkbox" style="font-size:45px;color:white">
                            <input id="check1" type="checkbox" name="terms" value="yes">
                            <label for="check1">Accept Terms and Conditions(<a href="terms.jsp">Read Terms and Conditions</a>)</label>                
                        </div>

                        <input type="submit" style="height:60px;background-color:#3b5998;padding-top:10px;padding-bottom:10px;font-size:18px;width:300px;color:white;font-family:'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', 'DejaVu Sans', 'Verdana', 'sans-serif';" value="Sign Up For My Neighbors">               
                    </form>    
                    <script>
                        function myFunction() {
                            var x = document.getElementById("zone").value;
                            imgPath = '';
                            if (x == 'North-East London') {
                                imgPath = 'images/loc/nel.jpg';
                            }
                            if (x == 'South-East London') {
                                imgPath = 'images/loc/sel.jpg';
                            }
                            if (x == 'North-West London') {
                                imgPath = 'images/loc/nwl.jpg';
                            }
                            if (x == 'South-West London') {
                                imgPath = 'images/loc/swl.jpg';
                            }
                            var elem = document.createElement("img");
                            elem.setAttribute("src", imgPath);
                            elem.setAttribute("height", "100");
                            elem.setAttribute("width", "100");
                            elem.setAttribute("alt", "Map");
                            elem.onclick = function () {                                
                                window.open(elem.src, '_blank', 'location=yes,height=570,width=520,scrollbars=yes,status=yes');
                            };
                            document.getElementById("demo").innerHTML="";
                            document.getElementById("demo").appendChild(elem);
                        }
                        
                    </script>
                </div>


            </div>
        </div>
    </div>
    <body>


        <script type="text/javascript">
            $('#form').buttonset();
            ?
                    $(function () {
                        $("#Button1").button({
                        });
                    });
            $(function () {
                $("#Button2").button();
            });
        </script>
    </body>
</html>
