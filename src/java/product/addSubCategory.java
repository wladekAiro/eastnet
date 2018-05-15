/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package product;

import database.DB_Conn;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Chirag
 */
public class addSubCategory extends HttpServlet {

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
            /*
             * TODO output your page here. You may use following sample code.
             */
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet addSubCategory</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addSubCategory at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        //processRequest(request, response);

        String SubCategoryName = request.getParameter("SubCategoryName");

        String categoryName = request.getParameter("categoryName");

        PrintWriter out = response.getWriter();
        String message = addSubCategory(SubCategoryName, categoryName);
        out.print(message);
    }

    private String addSubCategory(String SubCategoryName, String categoryName) {
        String message;

        if (SubCategoryName.equals("")) {
            //out.println("Please enter in All the Values");
            message = "Please enter in a SubCategory name for " + categoryName;
        } else {
            try {
                //out.println("Done!!");
                Connection con;
                DB_Conn conn = new DB_Conn();
                con = conn.getConnection();

                String getCategoryIdQuery = "SELECT id FROM category WHERE category_name = ?";
                PreparedStatement st1 = con.prepareStatement(getCategoryIdQuery);
                st1.setString(1, categoryName);
                
                System.out.println(" category name  : "+ categoryName);

                ResultSet rs = st1.executeQuery();

                int categoryId = 0;

                while (rs.next()) {
                    categoryId = rs.getInt("id");
                }

                String sqlInsertCompany = "INSERT INTO  sub_category (sub_category_name ,category_id , category_name ) "
                        + "VALUES (?,?,?);";
                // "INSERT INTO  `saikiran enterprises`.`product-company` (`company-id` ,`company-name`)VALUES (NULL ,  '"+companyName+"');";                
                //String sqlInsertProduct = "INSERT INTO  `saikiran enterprises`.`category` (`category_id` ,`category_name`)VALUES (NULL ,  '"+companyName+"'); ";
                PreparedStatement st = con.prepareStatement(sqlInsertCompany);
                
                st.setString(1, SubCategoryName);
                st.setInt(2, categoryId);
                st.setString(3, categoryName);

                int rows = st.executeUpdate();

                if (rows != 1) {
                    // out.println("Company not inserted");
                    message = "Sub Category insertion cancelled.";
                } else {
                    //out.println(companyName+" Company Inserted");
                    message = SubCategoryName + " Sub-Category inserted";
                }
                st.close();
                con.close();
            } catch (SQLIntegrityConstraintViolationException ex) {
                ex.printStackTrace();
                //out.println("A comany name with the same name exists in your database... Try being specific.");
                message = "A SubCategory Name with the same name exists in your database... Try being specific.";
            } catch (SQLSyntaxErrorException ex) {
                ex.printStackTrace();
                //out.println("A comany name with the same name exists in your database... Try being specific.");
                message = "Please provide names without quotes";
            } catch (SQLException ex) {
                ex.printStackTrace();
                //out.println("There was a problem in Connectiong DB <br/> Exception has occoured "+ex);
                message = "There was a problem in Connectiong DB <br/> Exception has occoured " + ex;

            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
                //out.println("Application Cannot find the Class <br/> Exception has occoured "+ex);
                message = "Application Cannot find the Class <br/> Exception has occoured ";
            }
        }
        return message;
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
