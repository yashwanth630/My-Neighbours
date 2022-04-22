/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import osn.DataBase;

/**
 *
 * @author Helias
 */
public class DynamicFriends extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
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

            String s = request.getParameter("q");
            s = s.toLowerCase();
            //System.out.println("--------" + s);
            ArrayList<String> arrayList1 = new ArrayList<String>();
            try {

                DataBase dbfunc = new DataBase();

                dbfunc.createConnection();

                HttpSession session = request.getSession(false);            
                String email = (String) session.getAttribute("email");
                
                
                //String queryz = "SELECT * FROM users where email in(select friendMail from friends where email='"+email+"')";
                
                String queryz = "SELECT * FROM users";


                System.out.println("Query  : " + queryz);

                ResultSet rset = dbfunc.queryRecord(queryz);

                boolean found = rset.next();
                //out.println("<br><b>Sql Result</b>+"+query+"==>"+found);
                if (found) {
                    rset.last();
                    int count = rset.getRow();
                    int row = 0;

                    rset.beforeFirst();
                    while (rset.next()) {
                        row++;
                        arrayList1.add(rset.getString("firstname")+"."+rset.getString("lastname")+"-"+rset.getString("email"));
                        //resultHtml += "<tr><td>" + row + "</td><td>" + rset.getString(4) + "</td><td><a href=>" + rset.getString(5) + "</a></td></tr>";
                    }
                } else {
                    arrayList1.add("Data Not Found In Database");
                }
                dbfunc.closeConnection();

                int count = 0;
                for (int k = 0; k < arrayList1.size(); k++) {
                    String name = arrayList1.get(k);
                    String tname = name.toLowerCase();
                    if (tname.startsWith(s)) {
                        count++;
                        out.print(name + "\n");
                        if (count >= 10) {
                            break;
                        }
                    }

                }
            } catch (SQLException ex) {
                arrayList1.add("<p><b>" + ex.toString() + "</b></p>");
            } catch (Exception ex) {
                arrayList1.add("<p><b>" + ex.toString() + "</b></p>");
            }


        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
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
     * Handles the HTTP
     * <code>POST</code> method.
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
