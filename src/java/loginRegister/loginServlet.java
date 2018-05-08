package loginRegister;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import database.DB_Conn;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import user.user;
import utils.PasswordHash;

/**
 *
 * @author chirag
 */
public class loginServlet extends HttpServlet {

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
            out.println("<title>Servlet loginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet loginServlet at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        String email, pass;
        String db_email, db_pass;
        boolean isLoggedIn = false;
        HttpSession userSession = request.getSession();
        PrintWriter out = response.getWriter();
        email = request.getParameter("email");
        pass = request.getParameter("pass");
        String message, messageDetail;
        message = "";
        messageDetail = "";

        String messageUrl = "/message.jsp";
        RequestDispatcher dispatchMessage
                = request.getServletContext().getRequestDispatcher(messageUrl);

        DB_Conn con = null;

        try {
            out.println("email " + email + " pass " + pass);
            con = new DB_Conn();
            Connection c = con.getConnection();
            String sqlGetUsers = "SELECT * FROM  users where email = ? OR user_name = ?";

            PreparedStatement st = c.prepareStatement(sqlGetUsers);
            st.setString(1, email);
            st.setString(2, email);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                db_email = rs.getString("email");
                db_pass = rs.getString("password");

                if (PasswordHash.validatePassword(pass, db_pass)) {
                    message = "Your email-id exists with us!";
                    //you exist with us
                    isLoggedIn = true;
                    //user exists and password is matching
                    out.print("You are logged in");
                    user User = new user();
                    User.setUserEmail(db_email);
                    userSession.setAttribute("user", User);
                    response.sendRedirect(request.getContextPath() + "/index.jsp");

                } else {
                    isLoggedIn = false;
                    // user exsts but wrong passwotd ask to CHANGE THE PASSWORD
                    message = "Wrong Password...!";
                    messageDetail = "Wrong email/password combination";
                    out.println("wrong password Change the password now <a href = 'changeMyPassword.jsp'>Change</a>");
                }
            } else {
                //or there no such email YOu do not exist with us Create an account now!!
                out.println(" no such email Register an account now!");
                message = "Email does not exists";
                messageDetail = "Please register with us right now to buy items on the go!";
                isLoggedIn = false;
            }

            if (isLoggedIn == false) {
                request.setAttribute("message", message);
                request.setAttribute("messageDetail", messageDetail);
                dispatchMessage.forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println(" Problem in the process execution...");
            //response.sendError(404);
            message = "An Error occoured during the process of login";
            messageDetail = "We are extremely sorry to have this but we had an error during your process of login please do try after some time,";

            request.setAttribute("message", message);
            request.setAttribute("messageDetail", messageDetail);
            dispatchMessage.forward(request, response);

        } catch (IOException e) {
            e.printStackTrace();
            out.println(" Problem in the process execution...");
            //response.sendError(404);
        } catch (ClassNotFoundException e) {
            out.println(" Problem in the process execution...");
            //response.sendError(404);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            out.println(" Problem in the process execution...");
            //response.sendError(404);
        } catch (InvalidKeySpecException e) {
            out.println(" Problem in the process execution...");
            //response.sendError(404);
        } catch (ServletException e) {
            e.printStackTrace();
            out.println(" Problem in the process execution...");
            //response.sendError(404);
        } finally {
            if (con != null) {
                con.closeConnection();
            }
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
