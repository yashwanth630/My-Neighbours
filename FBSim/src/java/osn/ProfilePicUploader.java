/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package osn;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author 
 */
public class ProfilePicUploader extends HttpServlet {

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

        HttpSession session = request.getSession(false);
        String store = (String) session.getAttribute("id");
        String email = (String) session.getAttribute("email");
        String name = (String) session.getAttribute("name");

        List uploadedItems = null;
        FileItem fileItem = null;
        String filePath = "";
        String option = "";


        // create file upload factory and upload servlet
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        try {
            // iterate over all uploaded files
            uploadedItems = upload.parseRequest(request);

            Iterator i = uploadedItems.iterator();

            while (i.hasNext()) {
                fileItem = (FileItem) i.next();
                if (fileItem.isFormField() == true) {
                    if (fileItem.getFieldName().trim().equals("option")) {
                        if (fileItem.getString().trim().equals("1")) {
                            option = "1";
                            filePath = ProjectProperties.getProfilePicResources() + "/" + store.trim() + "/";	// Path to store file on local system
                            File f = new File(filePath);
                            if (!f.exists()) {
                                f.mkdirs();
                            }
                        }                        
                    }
                }
                if (fileItem.isFormField() == false) {
                    if (fileItem.getSize() > 0) {
                        File uploadedFile = null;
                        String myFullFileName = fileItem.getName(),
                                myFileName = "",
                                slashType = (myFullFileName.lastIndexOf("\\") > 0) ? "\\" : "/"; // Windows or UNIX
                        int startIndex = myFullFileName.lastIndexOf(slashType);

                        // Ignore the path and get the filename
                        myFileName = myFullFileName.substring(startIndex + 1, myFullFileName.length());

                        // Create new File object
                        uploadedFile = new File(filePath, myFileName);

                        // Write the uploaded file to the system
                        fileItem.write(uploadedFile);

                        if (option.trim().equals("1")) {
                            String query1 = "update profiles set profilePic='" + uploadedFile.getAbsolutePath().replaceAll("\\\\", "/") + "' where email='" + email + "' and siteType='"+ProjectProperties.siteName+"'";                            
                            String query3 = "insert into notifications(`email`,`notification`,`activity`,`publishDate`,`siteType`) values('" + email + "','User(" + email + ") Updated Their Profile Pic','Profile Picture Updation',now(),siteType='"+ProjectProperties.siteName+"')";
                            System.out.println("Query : " + query1);                            

                            DataBase dbfunc = new DataBase();
                            dbfunc.createConnection();
                            dbfunc.updateRecord(query1);                            
                            dbfunc.updateRecord(query3);

                            dbfunc.closeConnection();
                        }             
                    }
                }
            }
            if (option.trim().equals("1")) {
                response.sendRedirect("upload.jsp?msg=Uploaded Successfully&option=1");
            }
            
        } catch (FileUploadException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
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
