/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package product;

import service.CartServlce;
import database.DB_Conn;
import java.io.IOException;
import java.io.PrintWriter;
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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.enums.Status;
import orders.Location;
import orders.OrderNumberGenerator;
import user.User;

/**
 *
 * @author chirag
 */
@WebServlet(name = "buyItems", urlPatterns = {"/buyItems"})
public class BuyItemsServlet extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet buyItems</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet buyItems at " + request.getContextPath() + "</h1>");
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        doPost(request, response);
        /*
         HttpSession session = request.getSession();
         if (!(session.getAttribute("user") == null) && !(session.getAttribute("CartServlce") == null)) {

         user user;
         user = (user) session.getAttribute("user");
         CartServlce cart;
         cart = (CartServlce) session.getAttribute("CartServlce");

         PrintWriter out = response.getWriter();
         try {
         out.println("you user :" + user.getUserEmail() + " has bought items worth " + cart.getTotalPriceOfCart());


         } catch (SQLException ex) {
         Logger.getLogger(BuyItemsServlet.class.getName()).log(Level.SEVERE, null, ex);
         } catch (ClassNotFoundException ex) {
         Logger.getLogger(BuyItemsServlet.class.getName()).log(Level.SEVERE, null, ex);
         }
         } else {
         response.sendRedirect("/MyCartApplication/index.jsp");
         }
         */
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
        try {
            PrintWriter out = response.getWriter();
            //processRequest(request, response);
            String name, age, address, mobile;
            int order_id, location_id;
            Connection c = null;
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            CartServlce cart = (CartServlce) session.getAttribute("cart");
            name = request.getParameter("name");
            age = request.getParameter("age");
            address = request.getParameter("address");
            mobile = request.getParameter("mobile");
            location_id = Integer.parseInt(request.getParameter("location_id"));
            Location location = cart.getLocation(location_id);
            if (name.trim().length() > 1
                    && address.trim().length() >= 5
                    && mobile.trim().length() >= 5
                    && mobile.trim().length() <= 12) {

                if (!(session.getAttribute("user") == null)
                        && !(session.getAttribute("cart") == null)) {

                    try {
                        response.setContentType("text/html;charset=UTF-8");

                        c = new DB_Conn().getConnection();

                        //******* Starting a Transaction
                        c.setAutoCommit(false);
                        String insertOrder;
                        insertOrder = "INSERT INTO  orders ("
                                + "    user_id ,"
                                + "    status ,"
                                + "    shippers_name ,"
                                + "    address ,"
                                + "    mobile_number ,"
                                + "    shippers_email ,"
                                + "    ordered_On ,"
                                + "    total_order_price,"
                                + "    location,"
                                + "    location_charge,"
                                + "    order_number)"
                                + "    VALUES (?, ?, ?, ?, ?, ?, NOW( ) ,? , ? , ? ,?)";

                        PreparedStatement preparedSQL1
                                = c.prepareStatement(insertOrder);

                        preparedSQL1.setInt(1, user.getUserId()); // user iD
                        preparedSQL1.setString(2, Status.PENDING.name().toLowerCase());

                        preparedSQL1.setString(3, name); //`shippers_name`

                        preparedSQL1.setString(4, address); //`address`

                        preparedSQL1.setString(5, mobile); //`mobile`

                        preparedSQL1.setString(6, user.getUserEmail()); //`shippers_email`

                        preparedSQL1.setDouble(7, cart.getTotalPriceOfCart()); //`total_order_price``
                        preparedSQL1.setString(8, location.getName());
                        preparedSQL1.setDouble(9, location.getCost());
                        preparedSQL1.setInt(10, OrderNumberGenerator.generateOrderNumber().intValueExact());

                        int executeUpdatePreparedSQL1 = preparedSQL1.executeUpdate();

                        if (executeUpdatePreparedSQL1 == 1) {
                            //get the latest order id of the recent update

                            //out.println("Ok here we are onr order updted");
                            String getLatestOrderId = "SELECT id "
                                    + "FROM  orders "
                                    + "WHERE user_id = '" + user.getUserId() + "'"
                                    + "ORDER BY id DESC "
                                    + "LIMIT 1";

                            preparedSQL1.close();

                            Statement st = c.createStatement();
                            ResultSet executeQueryGetOrderId = st.executeQuery(getLatestOrderId);
                            executeQueryGetOrderId.next();

                            //Here we get the latest order id for the current user
                            order_id = executeQueryGetOrderId.getInt("id");

                            executeQueryGetOrderId.close();

                            //out.println("you user :" + user.getUserEmail() + " has bought items worth " + cart.getTotalPriceOfCart() + "gffdgfgvgedfrggfdre and order id of " + order_id);
                            ArrayList<String> productCategorys = cart.getProductCategorys();
                            ArrayList<String> productNames = cart.getProductNames();
                            ArrayList<Double> prices = cart.getPrices();
                            ArrayList<Integer> qty = cart.getQty();
                            ArrayList<Integer> id = cart.getId();

                            String insertIntoSalesSQL3 = ""
                                    + "INSERT INTO  sales ("
                                    + "order_id ,"
                                    + "product_id ,"
                                    + "product_name ,"
                                    + "product_price ,"
                                    + "product_quantity ,"
                                    + "sold_on ,"
                                    + "user_id"
                                    + ")"
                                    + "VALUES (?,  ?,  ?,  ?,  ?, NOW( ) ,  ? );";

                            PreparedStatement insertIntoSalesTable = c.prepareStatement(insertIntoSalesSQL3);

                            for (int i = 0; i < productNames.size(); i++) {

                                insertIntoSalesTable.setInt(1, order_id);

                                insertIntoSalesTable.setInt(2, id.get(i));

                                insertIntoSalesTable.setString(3, productNames.get(i));

                                insertIntoSalesTable.setDouble(4, prices.get(i));

                                insertIntoSalesTable.setInt(5, qty.get(i));

                                insertIntoSalesTable.setInt(6, user.getUserId());

                                int executeUpdateSalesTable = insertIntoSalesTable.executeUpdate();

                                if (executeUpdateSalesTable == 1) {
                                    out.println("Success");

                                } else {
                                    out.println("Failed for now Product name " + productNames.get(i));
                                }
                            }
                            //DECREMENT THE QUANTITY in the CART FROM products TABLE

                            for (int i = 0; i < productNames.size(); i++) {
                                st.addBatch(
                                        " UPDATE  products "
                                        + " SET "
                                        + " product_qty = product_qty - " + qty.get(i) + ""
                                        + " WHERE id = " + id.get(i) + " "
                                        + " AND "
                                        + " product_name = '" + productNames.get(i) + "' ");
                            }
                            int[] executeBatch = st.executeBatch();
                            int i = 0;
                            while (i < executeBatch.length) {
                                out.print("? --> " + executeBatch[i]);
                                i++;
                            }
                            c.commit();
                            response.sendRedirect(request.getContextPath() + "/userinfo.jsp");
                        } else {
                            //not updated
                            response.sendRedirect(request.getContextPath());
                        }

                    } catch (SQLException ex) {
                        ex.printStackTrace();
                        Logger.getLogger(BuyItemsServlet.class.getName()).log(Level.SEVERE, null, ex);
                        c.rollback();
                        String message, messageDetail;
                        String messageUrl = "/message.jsp";
                        RequestDispatcher dispatchMessage
                                = request.getServletContext().getRequestDispatcher(messageUrl);
                        message = "Oops, Less Product Stock...!";
                        messageDetail = "We see that your demand for the product was critically higher than what we had in our inventory, We respect your purchase but your purchase was cancelled, We are sorry, but please in a urgent requirement do order less stock right now!!";
                        request.setAttribute("message", message);
                        request.setAttribute("messageDetail", messageDetail);
                        dispatchMessage.forward(request, response);
                    } catch (ClassNotFoundException ex) {
                        out.println("you user " + ex);
                    }
                    session.removeAttribute("cart");
                } else {
                    out.println("No items in cart");
                }

            } else {
                //response.sendRedirect("/saikiranBookstoreApp/buyItems.jsp");
                out.println("NOt validated");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(BuyItemsServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
            Logger.getLogger(BuyItemsServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

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
