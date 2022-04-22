/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package osn;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.activation.MimetypesFileTypeMap;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Helias
 */
public class HttpObjectDownload extends HttpServlet {

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
        try {
            String email = request.getParameter("email");
            String option = request.getParameter("option");
            //System.out.println("--------------"+option);

            if (option.trim().equals("1")) {
                String query = "select * from profiles p where p.email='" + email.trim() + "' and siteType='"+ProjectProperties.siteName+"'";

                DataBase dbfunc = new DataBase();
                dbfunc.createConnection();

                ResultSet rsett = dbfunc.queryRecord(query);
                boolean found = rsett.next();

                if (found) {
                    String pic = rsett.getString("p.profilePic");
                    if (pic.trim().contains("none.jpg")) {
                        File f = new File(pic);
                        String name = f.getName().split("\\.")[0].trim();
                        String ext = f.getName().split("\\.")[1].trim();

                        MimetypesFileTypeMap mimeTypesMap = new MimetypesFileTypeMap();

                        // only by file name
                        String mimeType = mimeTypesMap.getContentType(f.getName());
                        //System.out.println("-----------------"+mimeType);
                        response.setContentType(mimeType);
                        response.addHeader("Content-Disposition", "attachment; filename=" + f.getName().replaceAll(" ", "-"));

                        String pathToWeb = getServletContext().getRealPath("images/" + f.getName());
                        f = new File(pathToWeb);

                        BufferedImage bi = ImageIO.read(f);
                        OutputStream outz = response.getOutputStream();
                        ImageIO.write(bi, ext, outz);
                        outz.close();
                    } else {
                        File f = new File(pic);
                        String name = f.getName().split("\\.")[0].trim();
                        String ext = f.getName().split("\\.")[1].trim();
                        MimetypesFileTypeMap mimeTypesMap = new MimetypesFileTypeMap();

                        // only by file name
                        String mimeType = mimeTypesMap.getContentType(f.getName());
                        //System.out.println("-----------------"+mimeType);
                        response.setContentType(mimeType);
                        response.addHeader("Content-Disposition", "attachment; filename=" + f.getName().replaceAll(" ", "-"));



                        BufferedImage bi = ImageIO.read(f);
                        OutputStream outz = response.getOutputStream();
                        ImageIO.write(bi, ext, outz);
                        outz.close();
                    }

                } else {
                    MimetypesFileTypeMap mimeTypesMap = new MimetypesFileTypeMap();

                    // only by file name
                    String mimeType = mimeTypesMap.getContentType("none.jpg");
                    //System.out.println("-----------------"+mimeType);
                    response.setContentType(mimeType);
                    response.addHeader("Content-Disposition", "attachment; filename=" + "none.jpg".replaceAll(" ", "-"));

                    String pathToWeb = getServletContext().getRealPath("images/none.jpg");
                    File f = new File(pathToWeb);

                    BufferedImage bi = ImageIO.read(f);
                    OutputStream outz = response.getOutputStream();
                    ImageIO.write(bi, "jpg", outz);
                    outz.close();
                }

                dbfunc.closeConnection();
            }
        } catch (Exception ex) {
            Logger.getLogger(HttpObjectDownload.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            
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
