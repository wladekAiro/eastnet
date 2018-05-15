/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product;

import database.DB_Conn;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Hashtable;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadException;
import javazoom.upload.UploadBean;
import javazoom.upload.UploadFile;

/**
 *
 * @author wladekairo
 */
public class FileUploadServlet extends HttpServlet {

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
        RequestDispatcher dispatcher
                = getServletContext().getRequestDispatcher("/productInsertImages.jsp");
        dispatcher.forward(request, response);
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
        
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        UploadBean upBean = new UploadBean();
        if (MultipartFormDataRequest.isMultipartFormData(request)) {
            try {
                // Uses MultipartFormDataRequest to parse the HTTP request.
                MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
                String todo = mrequest.getParameter("todo");

                if ((todo != null) && (todo.equalsIgnoreCase("upload"))) {
                    Hashtable files = mrequest.getFiles();
                    if ((files != null) && (!files.isEmpty())) {
                        UploadFile file = (UploadFile) files.get("uploadfile");
                        String fileName, fileType;
                        String result;
                        long fileSize;
                        fileName = file.getFileName();
                        fileType = file.getContentType();
                        fileSize = file.getFileSize();
                        String productName = (String) session.getAttribute("productName");

                        if (fileName != null || productName != null) {
                            fileName = fileName.replaceAll("\\s+", "_");
                        }

                        System.out.println(" UPLOADING IMAGE : {" + fileName + " } FOR PRODUCT : {" + productName + "}");

                        double randomA = Math.random() * 1000000000;
                        int randA = (int) randomA;
                        file.setFileName(randA +"_"+ fileName);
                        fileName = file.getFileName();
                        if (fileType.equals("image/jpeg") || fileType.equals("image/png")) {

                            if (fileSize <= 700000) {
                                try {
                                    upBean.setFolderstore(request.getServletContext().getRealPath("/") + "uploads");
                                    upBean.store(mrequest, "uploadfile");
                                    result = "File Uploaded with no errors...";
                                    DB_Conn conn = new DB_Conn();
                                    Connection con = conn.getConnection();
                                    String productIdQuery = "SELECT id FROM products WHERE product_name = ?";
                                    PreparedStatement ps = con.prepareStatement(productIdQuery);
                                    ps.setString(1, productName);

                                    ResultSet rs = ps.executeQuery();
                                    int productId = 0;
                                    while (rs.next()) {
                                        productId = rs.getInt("id");
                                    }

                                    String insertImage = "INSERT INTO images "
                                            + "(image_name ,product_name , product_id) VALUES (?,?,?)";

                                    ps = con.prepareStatement(insertImage);
                                    ps.setString(1, "uploads/" + file.getFileName());
                                    ps.setString(2, productName);
                                    ps.setInt(3, productId);

                                    int rows = ps.executeUpdate();
                                    if (rows == 1) {
                                        result = "File Uploaded with no errors...";
                                    }
                                    ps.close();
                                    con.close();
                                } catch (SQLException e) {
                                    result = "Database Problem occoured." + e;
                                } catch (ClassNotFoundException e) {
                                    result = "Error occoured." + e;
                                }

                                files.clear();
                            } else {
                                result = "Please Upload the file size of less than 700 KB";
                            }
                        } else {
                            result = "Please upload a filetype of image/jpeg or image/png";
                        }

                        request.setAttribute("fileName", fileName);
                        request.setAttribute("fileType", fileType);
                        request.setAttribute("fileSize", fileSize);
                        request.setAttribute("result", result);
                    } else {
                        out.println("<li>No uploaded files");
                    }
                } else {
                    out.println("<BR> todo=" + todo);
                }
            } catch (UploadException ex) {
                Logger.getLogger(FileUploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
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
