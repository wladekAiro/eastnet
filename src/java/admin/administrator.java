/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package admin;

import database.DB_Conn;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import models.enums.UserRole;

/**
 *
 * @author chirag
 */
public class administrator {

    Connection c;
    String admin_email = null;

    public ArrayList<String> getListsOfAdmin() throws SQLException, ClassNotFoundException {

        try {
            c = new DB_Conn().getConnection();
            String getAdministratorsEmail = " SELECT * FROM  users where user_role = ?";

            PreparedStatement st = c.prepareStatement(getAdministratorsEmail);
            st.setString(1, UserRole.ADMIN.name());

            ResultSet executeQuery = st.executeQuery();

            listsOfAdmin.clear();

            while (executeQuery.next()) {
                listsOfAdmin.add(executeQuery.getString("email"));
            }
        } finally {
            c.close();
        }

        return listsOfAdmin;
    }

    ArrayList<String> listsOfAdmin = new ArrayList<String>();

    public String getAdmin_email() {
        return admin_email;
    }

    public void setAdmin_email(String admin_email) {
        this.admin_email = admin_email;
    }

}
