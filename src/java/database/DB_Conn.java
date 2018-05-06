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
    
    private Connection con;
    
    public Connection getConnection() throws SQLException, ClassNotFoundException  {
        Class.forName("org.postgresql.Driver"); 
        con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/easnat", "postgres","postgres"); 
       // stm=con.createStatement(); 
        return con;
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
