/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package osn;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author Helias
 */
public class Registration extends HttpServlet {

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

            String email = request.getParameter("email2");
            String cemail = request.getParameter("email3");

            String fn = request.getParameter("fn");
            String ln = request.getParameter("ln");

            String pw = request.getParameter("pw");
            String cpw = request.getParameter("cpw");

            String dob = request.getParameter("dob");
            String gender = request.getParameter("Gender");
            String country = request.getParameter("country");
            String zone = request.getParameter("zone");

            String terms = request.getParameter("terms");

            if (dob == null) {
                response.sendRedirect("index.jsp?msg=Please Provide date Of Birth!");
                return;
            }

            if (terms == null) {
                response.sendRedirect("index.jsp?msg=Please Accept The Terms And Agreements!!!");
                return;
            } else if (!terms.trim().equals("yes")) {
                response.sendRedirect("index.jsp?msg=Please Accept The Terms And Agreements!!!");
                return;
            }

            if (zone == null) {
                response.sendRedirect("index.jsp?msg=Please Select A Time Zone");
                return;
            } else if (zone.trim().equals("Select A Zone")) {
                response.sendRedirect("index.jsp?msg=Please Select A Time Zone");
                return;
            }

            if (pw != null && cpw != null) {
                if (!pw.trim().equals(cpw.trim())) {
                    response.sendRedirect("index.jsp?msg=Passwords Mismatch!");
                    return;
                }
            } else {
                response.sendRedirect("index.jsp?msg=Please Provide Passwords");
                return;
            }

            if (email != null && cemail != null) {
                if (!email.trim().equals(cemail.trim())) {
                    response.sendRedirect("index.jsp?msg=Emails Mismatch!");
                    return;
                }
            } else {
                response.sendRedirect("index.jsp?msg=Please Provide Emails");
                return;
            }

            pw = DigestUtils.md5Hex(pw);
            dob = dob.split("/")[2] + "-" + dob.split("/")[1] + "-" + dob.split("/")[0];

            String query = "insert into users(`email`,`password`,`firstname`,`lastname`,`dob`,`gender`,`country`,`zonal`,`dateofjoin`,`siteType`) values('" + email + "','" + pw + "','" + fn + "','" + ln + "','" + dob + "','" + gender + "','" + country + "','" + zone + "',now(),'" + ProjectProperties.siteName + "')";

            String query2 = "insert into notifications(`email`,`notification`,`activity`,`publishDate`,`siteType`) values('" + email + "','New User(" + fn + "." + ln + ") Joined with user Id : " + email + "','New Member joining',now(),'" + ProjectProperties.siteName + "')";

            String query3 = "insert into userLive(`usid`,`email`,`status`) values('" + fn + "." + ln + "','" + email + "','offline')";

            DataBase dbfunc = new DataBase();
            dbfunc.createConnection();
            System.out.println(query);
            dbfunc.updateRecord(query);
            dbfunc.updateRecord(query2);
            dbfunc.updateRecord(query3);
            //add same zone friends
            query = "select * from users where email!='" + email.trim() + "' and zonal='"+zone+"'";
            ArrayList<String> friends =new ArrayList<String>();
            ArrayList<String> toq =new ArrayList<String>();
            ArrayList<String> froq =new ArrayList<String>();            
            ResultSet rset = dbfunc.queryRecord(query);
            boolean found = rset.next();

            if (found) {
                rset.last();
                int count = rset.getRow();
                int row = 0;
                String line = "";
                rset.beforeFirst();
                while (rset.next()) {
                    row++;                    
                    String friendMail = rset.getString("email");
                    friends.add(friendMail);
                    toq.add("insert into friends(email,friendMail,status,publishDate,zonal,siteType) values('" + email.trim() + "','" + friendMail.trim() + "','1',now(),'"+zone.trim()+"','" + ProjectProperties.siteName + "')");
                    froq.add("insert into friends(email,friendMail,status,publishDate,zonal,siteType) values('" + friendMail.trim() + "','" + email.trim() + "','1',now(),'"+zone.trim()+"','" + ProjectProperties.siteName + "')");
                }                
            }
            for(int k=0;k<toq.size();k++){
                System.out.println("FReq["+(k+1)+"]-1:"+toq.get(k));
                System.out.println("FReq["+(k+1)+"]-2:"+froq.get(k));
                dbfunc.updateRecord(toq.get(k));
                dbfunc.updateRecord(froq.get(k));
            }            
            ///////////////////////
            String tname = fn + "." + ln;
            tname = tname.replace(".", "_");
            tname = tname + "_grps";
            String queryG = "create table " + tname + "(usid VARCHAR(255) NOT NULL,uname VARCHAR(255) NOT NULL,groupname VARCHAR(255) NOT NULL,usertype VARCHAR(255) NOT NULL,zonal VARCHAR(255) NOT NULL,status VARCHAR(255) NOT NULL)";
            System.out.println(queryG);
            dbfunc.updateRecord(queryG);
            
            dbfunc.closeConnection();

            response.sendRedirect("index.jsp?msg=User(" + email.trim() + ") Account Created!!!");

        } catch (Exception ex) {
            Logger.getLogger(Registration.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("index.jsp?msg=" + ex.toString());
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
