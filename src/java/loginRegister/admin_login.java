/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package loginRegister;

import admin.administrator;
import database.DB_Conn;
import helpers.SecureSHA1;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import user.user;
import utils.PasswordHash;

/**
 *
 * @author chirag
 */
public class admin_login extends HttpServlet {

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
            out.println("<title>Servlet admin_login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet admin_login at " + request.getContextPath() + "</h1>");
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
        response.sendRedirect("admin_.jsp");
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
        //processRequest(request, response);//processRequest(request, response);
        String email, pass;
        String db_email, db_pass;
        boolean isLoggedIn = false;
        HttpSession userSession = request.getSession();
        PrintWriter out = response.getWriter();
        email = request.getParameter("email");
        pass = request.getParameter("pass");
        String message, messageDetail = null;

        String messageUrl = "/message.jsp";
        RequestDispatcher dispatchMessage
                = request.getServletContext().getRequestDispatcher(messageUrl);

        try {
            pass = SecureSHA1.getSHA1(pass);
            //out.println("email " + email + " pass " + pass);
            DB_Conn con = new DB_Conn();
            Connection c = con.getConnection();
            String sqlGetUser = "SELECT * FROM  `administrators` where `email'='" + email + "';";

            PreparedStatement st = c.prepareStatement(sqlGetUser);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {

                db_pass = rs.getString("password");
                db_email = rs.getString("email");

                if (PasswordHash.validatePassword(pass, db_pass)) {
                    message = "Your email-id exists with us!";
                    //you exist with us
                    isLoggedIn = true;
                    //user exists and password is matching
                    //out.print("You are logged in");
                    user User = new user();
                    administrator Administrator = new administrator();
                    Administrator.setAdmin_email(db_email);
                    User.setUserEmail(email);
                    userSession.setAttribute("user", User);
                    userSession.setAttribute("admin", Administrator);
                    response.sendRedirect(request.getContextPath());
                } else {
                    isLoggedIn = false;
                    // user exsts but wrong passwotd ask to CHANGE THE PASSWORD
                    message = "Log in failed...!";
                    messageDetail = "Wrong username or password";
                    //out.println("wrong password Change the password now <a href = 'changeMyPassword.jsp'>Change</a>");
                }
            } else {
                message = "Log in failed...!";
                messageDetail = "Wrong username or password";
            }

            if (isLoggedIn == false) {
                request.setAttribute("message", message);
                request.setAttribute("messageDetail", messageDetail);
                dispatchMessage.forward(request, response);
            }
        } catch (SQLException e) {
            message = "Error in the Login process";
            messageDetail = "There was an error in the process of login Please try after some time!";

            request.setAttribute("message", message);
            request.setAttribute("messageDetail", messageDetail);
            //dispatchMessage.forward(request, response);
        } catch (IOException e) {
            message = "Error in the Login process";
            messageDetail = "There was an error in the process of login Please try after some time!";

            request.setAttribute("message", message);
            request.setAttribute("messageDetail", messageDetail);
            //dispatchMessage.forward(request, response);
        } catch (ClassNotFoundException e) {
            message = "Error in the Login process";
            messageDetail = "There was an error in the process of login Please try after some time!";

            request.setAttribute("message", message);
            request.setAttribute("messageDetail", messageDetail);
            //dispatchMessage.forward(request, response);
        } catch (NoSuchAlgorithmException e) {
            message = "Error in the Login process";
            messageDetail = "There was an error in the process of login Please try after some time!";

            request.setAttribute("message", message);
            request.setAttribute("messageDetail", messageDetail);
            //dispatchMessage.forward(request, response);
        } catch (InvalidKeySpecException e) {
            message = "Error in the Login process";
            messageDetail = "There was an error in the process of login Please try after some time!";

            request.setAttribute("message", message);
            request.setAttribute("messageDetail", messageDetail);
            //dispatchMessage.forward(request, response);
        } catch (ServletException e) {
            message = "Error in the Login process";
            messageDetail = "There was an error in the process of login Please try after some time!";

            request.setAttribute("message", message);
            request.setAttribute("messageDetail", messageDetail);
            //dispatchMessage.forward(request, response);
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
