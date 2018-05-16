/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets.admin;

import database.DB_Conn;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import product.ProductBean;

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
        String sortBy = request.getParameter("sortBy");

        if (productId != null) {
            //TODO get the product from db
        }

        try {
            if (sortBy != null) {
                ArrayList<ProductBean> products = sortProducts(sortBy);
                request.setAttribute("products", products);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageProducts.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ManageProducts.class.getName()).log(Level.SEVERE, null, ex);
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

    private ArrayList<ProductBean> sortProducts(String sortBy) throws SQLException, ClassNotFoundException {
        ArrayList<ProductBean> products = new ArrayList();

        Connection c = new DB_Conn().getConnection();
        Statement st = c.createStatement();

        String sqlFetchItems = "SELECT p.id AS product_id,p.product_name,"
                + "p.sub_categroy,p.category_name,p.company_name,p.price,p.summary,p.product_qty,p.hits,i.image_name "
                + "FROM products p "
                + "INNER JOIN  images i "
                + "ON p.id=i.product_id "
                + "GROUP BY  p.id,i.product_id ";

        String orderBy = "ORDER BY p.product_qty ASC ";

        StringBuilder builder = new StringBuilder(sqlFetchItems);

        if (sortBy.equals("qa")) {
            orderBy = "ORDER BY p.product_qty ASC ";
        }

        if (sortBy.equals("qd")) {
            orderBy = "ORDER BY p.product_qty DESC ";
        }

        if (sortBy.equals("ha")) {
            orderBy = "ORDER BY p.hits ASC ";
        }

        if (sortBy.equals("hd")) {
            orderBy = "ORDER BY `hits` DESC ";
            //price
        }

        if (sortBy.equals("pa")) {
            orderBy = "ORDER BY p.price ASC ";
        }

        if (sortBy.equals("pd")) {
            orderBy = "ORDER BY p.price DESC ";
        }

        builder.append(orderBy);
        //out.print(""+productId+sqlFetchItems);      
        Statement st1 = c.createStatement();
        ResultSet rs = st1.executeQuery(builder.toString());

        while (rs.next()) {
            /*
                     product-name	product_id	sub-category-name	category-name	company-name	price	summary	image-id	image-name*/
            int product_id = rs.getInt("product_id");
            String product_name = rs.getString("product_name");
            String sub_category_name = rs.getString("sub_category_name");
            String category_name = rs.getString("category_name");
            String company_name = rs.getString("company_name");
            String price = rs.getString("price");
            String summary = rs.getString("summary");
            int qty = rs.getInt("product_qty");
            int hits = rs.getInt("hits");
            String image_name = rs.getString("image_name");

            ProductBean product = new ProductBean();
            product.setProductId(new Long(product_id));
            product.setProductName(product_name);
            product.setSubcategory(sub_category_name);
            product.setCategory(category_name);
            product.setCompany(company_name);
            product.setPrice(price);
            product.setSummary(summary);
            product.setHits(new Long(hits));
            product.setImageName(image_name);

            String alert = "";
            if (qty < 5) {
                alert = "alert";
            }

            product.setAlert(alert);

            products.add(product);

        }

        return products;
    }
}
