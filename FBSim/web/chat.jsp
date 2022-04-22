                                  
<%@page import="osn.Config"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="osn.ProjectProperties"%>
<%@page import="osn.DataBase"%>
<head>        
    <script src="JS/chat.js" type="text/javascript"></script>       
</head>

<%

    String curl = "http://" + ProjectProperties.chatAPI + "/";    
    if (Config.chkChatAPI(curl) == 200) {

%>

<%    String email = (String) session.getAttribute("email");
    String name = (String) session.getAttribute("name");

    String flistChat = "<select id='lfriends' onchange='chat_selectFriend()'>";
    flistChat += "<option value='0'>Select A Friend</option>";
    {
        DataBase dbfunc = new DataBase();
        dbfunc.createConnection();

        //String query = "select u.email,u.firstname,u.lastname from users u,profiles p,profilesVisibility pv where p.email=u.email and pv.email=u.email";
        String query = "select * from friends where email='" + email + "' and status='1' and siteType='" + ProjectProperties.siteName + "'";
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
                String query1 = "select * from users where email='" + mail + "' and showProfile=1 and siteType='" + ProjectProperties.siteName + "'";
                System.out.println(query1);

                DataBase dbfunc1 = new DataBase();
                dbfunc1.createConnection();
                ResultSet rset1 = dbfunc1.queryRecord(query1);
                boolean found1 = rset1.next();
                if (found1) {
                    String fN = rset1.getString("firstname");
                    String lN = rset1.getString("lastname");
                    query1 = "select usid,status from userLive where usid='" + fN + "." + lN + "'";
                    System.out.println(query1);
                    rset1 = dbfunc1.queryRecord(query1);
                    boolean found2 = rset1.next();
                    if (found2) {
                        row++;
                        line += "<option value='" + fN + "." + lN + "'>" + fN + "." + lN +"</option>";
                        continue;

                    }
                }
            }
            //out.println(line);
            flistChat += line;
        } else {
            out.println("No Members Found!!!");
        }
    }
    flistChat += "</select>";
%>

<table>
    <tr>
        <td colspan="2">
            <input type="hidden" id="username" placeholder="Username" value="<%=name%>"/>
            <!--button type="button" id="jchat" onclick="connect();" >Join Chat</button-->
        </td>
    </tr>
    <tr>
        <td>
            <%
                out.println(flistChat);
            %>
            <input type="hidden" size="15" id="chatAPI" value="<%=ProjectProperties.chatAPI%>"/>
        </td>
    </tr>
    <tr>                    
        <td>
            <input type="hidden" size="15" id="to" placeholder="To"/>
            <input type="text" size="20" id="msg" placeholder="Message"/>
            <button type="button" onclick="send();" >Send</button>
        </td>
    </tr>    
    <tr>
        <td>
            <textarea readonly="true" rows="30" cols="20" id="log"></textarea>
        </td>
    </tr>                    
</table>
<script language="javascript">
    connect();
</script>

<%
    }
%>