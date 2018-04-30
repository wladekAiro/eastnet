/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
/*
 *
 * @author Chirag
 */
public class DB_Conn {

    private String database="eastnet", username = "root", password = "";
    private Connection con;
    
    public Connection getConnection() throws SQLException, ClassNotFoundException  {
        Class.forName("com.mysql.jdbc.Driver"); 
        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+database+"",""+username+"",""+password+""); 
       // stm=con.createStatement(); 
        return con;
    }

    public String getDatabase() {
        return database;
    }

    public void setDatabase(String database) {
        this.database = database;
    }
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public void closeConnection(){
        try {
            if(!con.isClosed()){
                con.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(DB_Conn.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
