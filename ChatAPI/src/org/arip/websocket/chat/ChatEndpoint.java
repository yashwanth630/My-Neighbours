package org.arip.websocket.chat;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.logging.Logger;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import res.DataBase;

/**
 *
 * @author
 */
@ServerEndpoint(
        value = "/chat/{username}",
        decoders = MessageDecoder.class,
        encoders = MessageEncoder.class
)
public class ChatEndpoint {

    private final Logger log = Logger.getLogger(getClass().getName());

    private Session session;
    private String username;
    private static final Set<ChatEndpoint> chatEndpoints = new CopyOnWriteArraySet<>();
    private static HashMap<String, String> users = new HashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("username") String username) throws IOException, EncodeException, Exception {
        log.info(session.getId() + " online!");

        this.session = session;
        this.username = username;
        chatEndpoints.add(this);
        users.put(session.getId(), username);

        Message message = new Message();
        message.setFrom(username);
        message.setContent("online!");
        //db update
        DataBase dbfunc = new DataBase();
        dbfunc.createConnection();
        String query3 = "update userLive set status='online',dateoflogin=now() where usid='" + username + "'";
        System.out.println(query3);
        dbfunc.updateRecord(query3);
        dbfunc.closeConnection();
        ///////////
        broadcast(message);
        //sendMessageToCircleOnline(message);
    }

    @OnMessage
    public void onMessage(Session session, Message message) throws IOException, EncodeException, Exception {
        log.info(message.toString());

        message.setFrom(users.get(session.getId()));
        sendMessageToOneUser(message);
        //sendMessageToCircle(message);
    }

    @OnClose
    public void onClose(Session session) throws IOException, EncodeException, Exception {
        log.info(session.getId() + " offline!");

        chatEndpoints.remove(this);
        Message message = new Message();
        message.setFrom(users.get(session.getId()));
        message.setContent("offline!");
        //db update
        DataBase dbfunc = new DataBase();
        dbfunc.createConnection();
        String query3 = "update userLive set status='offline',dateoflogin=now() where usid='" + username + "'";
        System.out.println(query3);
        dbfunc.updateRecord(query3);
        dbfunc.closeConnection();
        ///////////
        broadcast(message);        
        //sendMessageToCircleOnline(message);
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        log.warning(throwable.toString());
    }

    private static void broadcast(Message message) throws IOException, EncodeException {
        for (ChatEndpoint endpoint : chatEndpoints) {
            synchronized (endpoint) {              
                endpoint.session.getBasicRemote().sendObject(message);
            }
        }
    }

    private static void sendMessageToOneUser(Message message) throws IOException, EncodeException {
        for (ChatEndpoint endpoint : chatEndpoints) {
            synchronized (endpoint) {
                if (endpoint.session.getId().equals(getSessionId(message.getTo()))) {
                    System.out.println("--------------------"+message.getTo());
                    endpoint.session.getBasicRemote().sendObject(message);
                }
            }
        }
    }

    private static void sendMessageToCircleOnline(Message message) throws IOException, EncodeException, Exception {
        String name = message.getFrom();
        ArrayList<String> fList = new ArrayList<String>();

        {
            DataBase dbfunc = new DataBase();
            dbfunc.createConnection();

            //String query = "select u.email,u.firstname,u.lastname from users u,profiles p,profilesVisibility pv where p.email=u.email and pv.email=u.email";
            String query0 = "select email from userLive where usid='" + name + "' and status='online'";
            System.out.println(query0);

            ResultSet rset = dbfunc.queryRecord(query0);
            boolean found = rset.next();

            String email;
            if (found) {
                rset.last();
                rset.beforeFirst();                
                email = rset.getString("email");                
            } else {
                return;
            }            
            String query = "select * from friends where email='" + email + "' and status='1'";
            System.out.println(query);
            rset = dbfunc.queryRecord(query);
            found = rset.next();

            if (found) {
                rset.last();
                int count = rset.getRow();
                int row = 0;
                String line = "";
                rset.beforeFirst();
                while (rset.next()) {

                    String mail = rset.getString("friendMail");

                    //String query1 = "select p.email,p.ProfilePic,pv.email,pv.profilePic where p.email='"+mail.trim()+"' and pv.email='"+mail.trim()+"'";
                    String query1 = "select * from users where email='" + mail + "' and showProfile=1 and siteType='FBSim'";
                    System.out.println(query1);

                    DataBase dbfunc1 = new DataBase();
                    dbfunc1.createConnection();
                    ResultSet rset1 = dbfunc1.queryRecord(query1);
                    boolean found1 = rset1.next();
                    if (found1) {
                        String fN = rset1.getString("firstname");
                        String lN = rset1.getString("lastname");
                        query1 = "select usid,status from userLive where usid='" + fN + "." + lN + "' and status='online'";
                        System.out.println(query1);
                        rset1 = dbfunc1.queryRecord(query1);
                        boolean found2 = rset1.next();
                        if (found2) {
                            row++;
                            fList.add(fN + "." + lN);
                        }
                    }
                }
            }
        }
        System.out.println(fList.toArray().toString());
        for (ChatEndpoint endpoint : chatEndpoints) {
            synchronized (endpoint) {
                if (fList.contains(message.getTo())) {
                    endpoint.session.getBasicRemote().sendObject(message);
                }
            }
        }
    }

    private static void sendMessageToCircle(Message message) throws IOException, EncodeException, Exception {        
        String name = message.getFrom();
        ArrayList<String> fList = new ArrayList<String>();

        {
            DataBase dbfunc = new DataBase();
            dbfunc.createConnection();

            //String query = "select u.email,u.firstname,u.lastname from users u,profiles p,profilesVisibility pv where p.email=u.email and pv.email=u.email";
            String query0 = "select email from userLive where usid='" + name + "' and status='online'";
            System.out.println(query0);

            ResultSet rset = dbfunc.queryRecord(query0);
            boolean found = rset.next();
            
            String email;
            if (found) {
                rset.last();
                rset.beforeFirst();                
                email = rset.getString("email");                
            } else {
                return;
            }
            String query = "select * from friends where email='" + email + "' and status='1'";
            System.out.println(query);
            rset = dbfunc.queryRecord(query);
            found = rset.next();

            if (found) {
                rset.last();
                int count = rset.getRow();
                int row = 0;
                String line = "";
                rset.beforeFirst();
                while (rset.next()) {

                    String mail = rset.getString("friendMail");

                    //String query1 = "select p.email,p.ProfilePic,pv.email,pv.profilePic where p.email='"+mail.trim()+"' and pv.email='"+mail.trim()+"'";
                    String query1 = "select * from users where email='" + mail + "' and showProfile=1 and siteType='FBSim'";
                    System.out.println(query1);

                    DataBase dbfunc1 = new DataBase();
                    dbfunc1.createConnection();
                    ResultSet rset1 = dbfunc1.queryRecord(query1);
                    boolean found1 = rset1.next();
                    if (found1) {
                        String fN = rset1.getString("firstname");
                        String lN = rset1.getString("lastname");
                        query1 = "select usid,status from userLive where usid='" + fN + "." + lN + "' and status='online'";
                        System.out.println(query1);
                        rset1 = dbfunc1.queryRecord(query1);
                        boolean found2 = rset1.next();
                        if (found2) {
                            row++;
                            fList.add(fN + "." + lN);
                        }
                    }
                }
            }
        }
        System.out.println(fList.toArray().toString());
        for (ChatEndpoint endpoint : chatEndpoints) {
            synchronized (endpoint) {
                if (endpoint.session.getId().equals(getSessionId(message.getTo())) && fList.contains(message.getTo())) {
                    endpoint.session.getBasicRemote().sendObject(message);
                }
            }
        }
    }

    private static String getSessionId(String to) {
        if (users.containsValue(to)) {
            for (String sessionId : users.keySet()) {
                if (users.get(sessionId).equals(to)) {
                    return sessionId;
                }
            }
        }
        return null;
    }
}
