/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package osn;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Helias
 */
public class Operations extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            HttpSession session = request.getSession(false);
            String store = (String) session.getAttribute("id");
            String emailId = (String) session.getAttribute("email");
            String name = (String) session.getAttribute("name");

            String operation = request.getParameter("operation");

            // change profile visibility
            if (operation.trim().equals("2")) {
                String friendMail = request.getParameter("friendMail");
                String pageRedirect = request.getParameter("page");

                String query = "insert into friends(email,friendMail,status,publishDate,siteType) values('" + emailId.trim() + "','" + friendMail.trim() + "','0',now(),'" + ProjectProperties.siteName + "')";
                String query2 = "insert into notifications(`email`,`notification`,`activity`,`publishDate`,siteType) values('" + emailId + "','User(" + emailId + ") is Trying To be Friends with (" + friendMail + ")','New Friendship request by " + emailId + "',now(),'" + ProjectProperties.siteName + "')";
                //System.out.println(query);
                //System.out.println(query2);

                //DataBase dbfunc = new DataBase();
                //dbfunc.createConnection();
                //System.out.println(query);
                //dbfunc.updateRecord(query);
                //dbfunc.updateRecord(query2);
                //dbfunc.closeConnection();
                //Globals.saveActions(friendMail, emailId, "FriendInvitation", "GUEST", "YES");
                //response.sendRedirect(pageRedirect + "?option=1&msg=Friend Request Sent!Please Wait For Acceptance By:" + friendMail);
                response.sendRedirect(pageRedirect + "?option=1&msg=Operation Not Supported");
            }

            // change profile visibility
            if (operation.trim().equals("3")) {
                String choice = request.getParameter("choice");
                String pageRedirect = request.getParameter("page");
                String id = request.getParameter("id");

                if (choice.trim().equals("1")) {
                    String query = "update friends set status='" + choice + "' where id=" + id + " and siteType='" + ProjectProperties.siteName + "'";
                    String query1 = "select * from friends where id=" + id + " and siteType='" + ProjectProperties.siteName + "'";
                    String query2 = "insert into notifications(`email`,`notification`,`activity`,`publishDate`,siteType) values('" + emailId + "','User(" + emailId + ") has increased their Social Network Circle','Friendship request accepted by " + emailId + "',now(),'" + ProjectProperties.siteName + "')";

                    System.out.println(query);
                    System.out.println(query2);

                    DataBase dbfunc = new DataBase();
                    dbfunc.createConnection();
                    dbfunc.updateRecord(query);

                    ResultSet rsett = dbfunc.queryRecord(query1);
                    boolean found = rsett.next();
                    if (found) {
                        String email = rsett.getString("email");
                        String friendMail = rsett.getString("friendMail");
                        String temp = "insert into friends(email,friendMail,status,publishDate,siteType) values('" + friendMail.trim() + "','" + email.trim() + "','1',now(),'" + ProjectProperties.siteName + "')";
                        System.out.println(temp);
                        dbfunc.updateRecord(temp);
                    }

                    dbfunc.updateRecord(query2);
                    dbfunc.closeConnection();

                    response.sendRedirect(pageRedirect + "?option=1&msg=Friend Request Accepted By:" + emailId);
                }

                if (choice.trim().equals("2")) {
                    String query = "delete from friends where id=" + id + " and siteType='" + ProjectProperties.siteName + "'";
                    String query2 = "insert into notifications(`email`,`notification`,`activity`,`publishDate`,siteType) values('" + emailId + "','User(" + emailId + ") has rejected a new friend request','Friendship request declined by " + emailId + "',now(),'" + ProjectProperties.siteName + "')";

                    System.out.println(query);
                    System.out.println(query2);

                    DataBase dbfunc = new DataBase();
                    dbfunc.createConnection();
                    System.out.println(query);
                    dbfunc.updateRecord(query);
                    dbfunc.updateRecord(query2);
                    dbfunc.closeConnection();

                    response.sendRedirect(pageRedirect + "?option=1&msg=Friend Request Rejected By:" + emailId);
                }
            }

            if (operation.trim().equals("20")) {
                try {
                    ArrayList<String> myFriends = new ArrayList<String>();
                    ArrayList<String> strangers = new ArrayList<String>();
                    String tid = "";
                    String fileOwner = "";
                    String all = "";
                    String tagId = "";

                    Map params = request.getParameterMap();
                    Iterator i = params.keySet().iterator();

                    while (i.hasNext()) {
                        String key = (String) i.next();
                        String value = ((String[]) params.get(key))[ 0];
                        //out.println("<br /> "+key+" ---- "+value+"");
                        //out.println("<br />String "+key+" = request.getParameter(\""+key+"\");");

                        if (key.startsWith("fid_")) {
                            myFriends.add(value.trim());
                            all += "'" + value.trim() + "',";
                        }
                        if (key.startsWith("mid_")) {
                            strangers.add(value.trim());
                            all += "'" + value.trim() + "',";
                        }
                        if (key.startsWith("tid")) {
                            tid = value.trim();
                        }
                        if (key.startsWith("tagId")) {
                            tagId = value.trim();
                        }
                        if (key.startsWith("fileOwner")) {
                            fileOwner = value.trim();
                        }
                    }

                    String query1 = "update taginfo set status='Y' where tagId=" + tagId + " and friendMail='" + emailId + "'";
                    DataBase dbfunc = new DataBase();
                    dbfunc.createConnection();
                    System.out.println(query1);
                    dbfunc.updateRecord(query1);

                    query1 = "insert into tagMatrix(`tagId`,`tid`,`email`,`status`) values(" + tagId + "," + tid + ",'" + fileOwner.trim() + "','Y')";
                    System.out.println(query1);
                    try {
                        dbfunc.updateRecord(query1);
                    } catch (Exception e) {
                        System.out.println(e.toString());
                    }

                    query1 = "insert into tagMatrix(`tagId`,`tid`,`email`,`status`) values(" + tagId + "," + tid + ",'" + emailId.trim() + "','Y')";
                    System.out.println(query1);
                    try {
                        dbfunc.updateRecord(query1);
                    } catch (Exception e) {
                        System.out.println(e.toString());
                    }

                    all = all + "'" + fileOwner + "','" + emailId + "',";
                    all = all.trim().substring(0, all.trim().length() - 1);

                    String query = "select email from users where email NOT IN(" + all + ")";
                    System.out.println(query);
                    ResultSet rset = dbfunc.queryRecord(query);
                    boolean found = rset.next();
                    ArrayList<String> remains = new ArrayList<String>();

                    if (found) {
                        rset.last();
                        int count = rset.getRow();
                        int row = 0;
                        rset.beforeFirst();
                        while (rset.next()) {
                            remains.add(rset.getString(1).trim());
                        }
                    }

                    for (int k = 0; k < myFriends.size(); k++) {
                        String query2 = "insert into notifications(`email`,`notification`,`activity`,`publishDate`,siteType) values('" + myFriends.get(k).trim() + "','User(" + emailId + ") has accepted Tagged Pic from :" + fileOwner + "','TagPic:" + tid + "',now(),'" + ProjectProperties.siteName + "')";
                        String query3 = "insert into tagMatrix(`tagId`,`tid`,`email`,`status`) values(" + tagId + "," + tid + ",'" + myFriends.get(k).trim() + "','Y')";

                        System.out.println(query2);
                        try {
                            dbfunc.updateRecord(query2);
                        } catch (Exception e) {
                            System.out.println(e.toString());
                        }
                        System.out.println(query3);
                        try {
                            dbfunc.updateRecord(query3);
                        } catch (Exception e) {
                            System.out.println(e.toString());
                        }
                    }

                    for (int k = 0; k < strangers.size(); k++) {
                        String query2 = "insert into notifications(`email`,`notification`,`activity`,`publishDate`,siteType) values('" + strangers.get(k).trim() + "','User(" + emailId + ") has accepted Tagged Pic from :" + fileOwner + "','TagPic:" + tid + "',now(),'" + ProjectProperties.siteName + "')";
                        String query3 = "insert into tagMatrix(`tagId`,`tid`,`email`,`status`) values(" + tagId + "," + tid + ",'" + strangers.get(k).trim() + "','Y')";

                        System.out.println(query2);
                        try {
                            dbfunc.updateRecord(query2);
                        } catch (Exception e) {
                            System.out.println(e.toString());
                        }
                        System.out.println(query3);
                        try {
                            dbfunc.updateRecord(query3);
                        } catch (Exception e) {
                            System.out.println(e.toString());
                        }
                    }

                    for (int k = 0; k < remains.size(); k++) {
                        String query2 = "insert into notifications(`email`,`notification`,`activity`,`publishDate`,siteType) values('" + remains.get(k).trim() + "','User(" + emailId + ") has accepted Tagged Pic from :" + fileOwner + "','TagPic:" + tid + ":N',now(),'" + ProjectProperties.siteName + "')";
                        String query3 = "insert into tagMatrix(`tagId`,`tid`,`email`,`status`) values(" + tagId + "," + tid + ",'" + remains.get(k).trim() + "','N')";

                        System.out.println(query2);
                        try {
                            dbfunc.updateRecord(query2);
                        } catch (Exception e) {
                            System.out.println(e.toString());
                        }
                        System.out.println(query3);
                        try {
                            dbfunc.updateRecord(query3);
                        } catch (Exception e) {
                            System.out.println(e.toString());
                        }
                    }

                    query1 = "insert into notifications(`email`,`notification`,`activity`,`publishDate`,siteType) values('" + emailId.trim() + "','User(" + emailId + ") has accepted Tagged Pic from :" + fileOwner + "','TagPic:" + tid + "',now(),'" + ProjectProperties.siteName + "')";
                    dbfunc.createConnection();
                    System.out.println(query1);
                    dbfunc.updateRecord(query1);

                    response.sendRedirect("welcome.jsp?msg=Succesfully Tagged");
                    return;
                } catch (Exception e) {
                    out.println("Exception : " + e.toString());
                    e.printStackTrace();
                }
            }

            if (operation.trim().equals("10")) {
                // declaration
                long start = -1, stop = -1;
                // start
                start = System.nanoTime();

                String friendMail = request.getParameter("friendMail");
                String message = request.getParameter("message");
                String pageDirect = request.getParameter("page");
                String system = request.getParameter("system");
                
                String groupid = request.getParameter("groupid");

                if (message == null) {
                    String rdm = pageDirect + "&msg=Specify A Wall Message";
                    response.sendRedirect(rdm);
                    return;
                }
                if (message.trim().length() == 0) {
                    String rdm = pageDirect + "&msg=Specify A Wall Message";
                    response.sendRedirect(rdm);
                    return;
                }

                message = message.replaceAll("'", "");

                if (system.equals("0")) {
                    String randToken = ProjectProperties.genRandToken();
                    if(groupid!=null){
                        if(!groupid.equals("All")){
                            String usergroupid = (String) session.getAttribute("groupid");
                            usergroupid = usergroupid.replace("_", "$");
                            randToken = randToken+"_"+usergroupid+"_"+groupid;
                        }
                    }
                    String query1 = "insert into wallmessages(`toMail`,`fromMail`,`message`,`msgDate`,siteType) values('" + friendMail + "','" + emailId + "','" + message + "',now(),'" + randToken + "')";
                    String query2 = "insert into notifications(`email`,`notification`,`activity`,`otherinfo`,`publishDate`,siteType) values('" + emailId + "','New Wall Message for user : " + friendMail + "','User(" + emailId + ") Posted New Message On " + friendMail + " wall','NA',now(),'" + randToken + "')";

                    System.out.println(query1);
                    System.out.println(query2);
                    
                    
                    DataBase dbfunc = new DataBase();
                    dbfunc.createConnection();
                    System.out.println(query1);
                    dbfunc.updateRecord(query1);
                    dbfunc.updateRecord(query2);
                    dbfunc.closeConnection();

                    // End
                    stop = System.nanoTime() - start;
                    double sec = (double) stop / 1000000000.0;

                    String rdm = pageDirect + "?option=2&msg=Message Successfully Posted On '" + emailId + "' wall&friendMail=" + friendMail;
                    response.sendRedirect(rdm);
                    return;
                }

            }

        } catch (Exception ex) {
            Logger.getLogger(Operations.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
