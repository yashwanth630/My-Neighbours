/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package osn;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Helias
 */
public class MemberManagement extends HttpServlet {

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
            String email = (String) session.getAttribute("email");
            String name = (String) session.getAttribute("name");
            String zone = (String) session.getAttribute("zonal");

            String option = request.getParameter("option");

            if (option.trim().equals("2")) {
                String friendMail = request.getParameter("friendMail");
                Globals.saveActions(friendMail, email, "ViewedProfile", "GUEST", "YES");
                String page = "viewProfile.jsp?option=2&friendMail=" + friendMail;
                response.sendRedirect(page);
            }

            if (option.trim().equals("3")) {
                String friendMail = request.getParameter("friendMail");
                Globals.saveActions(friendMail, email, "ViewedProfile", "FRIEND", "NO");
                String page = "viewProfile.jsp?option=1&friendMail=" + friendMail;
                response.sendRedirect(page);
            }

            // 4 users's page
            if (option.trim().equals("4")) {
                String friendMail = request.getParameter("friendMail");
                Globals.saveActions(friendMail, email, "AccountAccess", "FRIEND", "NO");
                String page = "template.jsp?option=1&friendMail=" + friendMail;
                response.sendRedirect(page);
            }

            // 5 users's wall
            if (option.trim().equals("5")) {
                String friendMail = request.getParameter("friendMail");
                Globals.saveActions(friendMail, email, "WallAccess", "FRIEND", "NO");
                String page = "template.jsp?option=2&friendMail=" + friendMail;
                response.sendRedirect(page);
            }

            // 7 users's friends
            if (option.trim().equals("8")) {
                String friendMail = request.getParameter("friendMail");
                Globals.saveActions(friendMail, email, "FriendAccess", "FRIEND", "NO");
                String page = "template.jsp?option=5&friendMail=" + friendMail;
                response.sendRedirect(page);
            }

            // 9 chain users's page
            if (option.trim().equals("9")) {
                String source = request.getParameter("source");
                String friendMail = request.getParameter("friendMail");
                Globals.saveActions(friendMail, email, "FriendAccess:Source(" + source + ") and Friend(" + friendMail + ")", "FRIEND", "NO");
                String page = "template.jsp?option=1&friendMail=" + friendMail;
                response.sendRedirect(page);
            }

            // 6 block user
            if (option.trim().equals("6")) {
                String friendMail = request.getParameter("friendMail");
                String toq = "update friends set status='0' where email='" + email + "' and friendMail='" + friendMail + "'";
                String froq = "update friends set status='0' where email='" + friendMail + "' and friendMail='" + email + "'";
                DataBase dbfunc = new DataBase();
                dbfunc.createConnection();
                try {
                    dbfunc.updateRecord(toq);
                    dbfunc.updateRecord(froq);
                    dbfunc.closeConnection();
                    Globals.saveActions(friendMail, email, "BlockFriend", "FRIEND", "YES");
                    String page = "welcome.jsp?msg=" + friendMail + " Blocked";
                    response.sendRedirect(page);
                } catch (Exception e) {
                    String page = "welcome.jsp?msg=Failed to Block " + friendMail;
                    response.sendRedirect(page);
                }
            }

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
