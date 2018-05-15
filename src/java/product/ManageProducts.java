/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product;

import database.DB_Conn;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author wladekairo
 */
public class ManageProducts extends HttpServlet {

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
        String messagePath = "/admin_manageProduct.jsp";
        System.out.println(" #### {" + messagePath + " } ");
        RequestDispatcher dispatcher
                = getServletContext().getRequestDispatcher(messagePath);
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
        String productId = request.getParameter("pid");

        if (productId == null) {
            //TODO get the product from db
        }

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

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        //TODO do put
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//           if (session.getAttribute("productId") != null   && session.getAttribute("productName") != null ){
//                String productId = request.getParameter("pid");
//
//                String productId = session.getAttribute("productId");
//                String productName session.getAttribute("productName");
//                 if (request.getParameter("del") != null){
//                     //DELETE THE PRODUCT OR SHOW ERROR IN SQL
//                     /*
//DELETE FROM `products` WHERE `product_id` = 9;# 1 row affected.
//
//DELETE FROM `images` WHERE `product-name` = 'Assasssins Book';# 1 row affected.
//
// * 
//                     */

    }

    private boolean updateProduct() {
        // TODO add logic to update product
        return false;
    }

    private boolean deleteProduct(int productId) throws SQLException, ClassNotFoundException {
 
        String sqlDeleteProduct = "DELETE CASCADE FROM products WHERE id = ?";
        Connection c = new DB_Conn().getConnection();
        PreparedStatement st = c.prepareStatement(sqlDeleteProduct);
        st.setInt(1, productId);
        
        return st.execute();
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
