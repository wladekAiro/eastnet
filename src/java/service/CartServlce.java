/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import database.DB_Conn;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Scanner;
import orders.Location;

/**
 *
 * @author chirag
 */
public class CartServlce {

    public ArrayList<Integer> id = new ArrayList();
    public ArrayList<String> productCategory = new ArrayList();
    public ArrayList<String> productName = new ArrayList();
    public ArrayList<Double> prices = new ArrayList();
    public ArrayList<Integer> qty = new ArrayList();
    public ArrayList<String> res = new ArrayList();
    private String shippingLocation;
    private Double shippingCost;
    Connection c;
    //this method will genarate "res" with colons

    public ArrayList<String> showProducts() {
        for (int i = 0; i < this.id.size(); i++) {
            // Try to concatinate the quantity and id by colon (:)
            System.out.println(qty.get(i) + " " + id.get(i) + " ");
            res.add(qty.get(i) + ":" + id.get(i));
        }
        // RES Contains How many things? (Qty) : Of what? (Item)
        return res;
    }

    //this method will genarate the prices of produt names which have an id
    public void listItemsOfCart() throws SQLException, ClassNotFoundException {

        c = new DB_Conn().getConnection();

        try {
            PreparedStatement st = null;
            for (int i = 0; i < id.size(); i++) {
                Integer getItemId = id.get(i);
                String getItemName = "SELECT  product_name ,  category_name ,  price FROM  products WHERE  id = ?";
                /*
             SELECT  `product-name` ,  `category-name` ,  `price` 
             FROM  `products` 
             WHERE  `product_id` =1
                 */
                st = c.prepareStatement(getItemName);
                st.setInt(1, getItemId);
                ResultSet rs = st.executeQuery();

                rs.next();

                String p_name = rs.getString("product_name");
                Double p_price = rs.getDouble("price");
                String p_Category = rs.getString("category_name");

                productName.add(p_name);
                productCategory.add(p_Category);
                prices.add(p_price);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            c.close();
        }
    }

    public ArrayList<String> getProductCategorys() {
        return productCategory;
    }

    public String getShippingLocation() {
        return shippingLocation;
    }

    public void setShippingLocation(String shippingLocation) {
        this.shippingLocation = shippingLocation;
    }

    public Double getShippingCost() {
        return shippingCost;
    }

    public void setShippingCost(Double shippingCost) {
        this.shippingCost = shippingCost;
    }

    //getters for product names, prices 
    public ArrayList<String> getProductNames() throws SQLException, ClassNotFoundException {
        /*for (int i=0;i<productName.size();i++){
         System.out.println(""+productName.get(i));
         }*/
        return productName;
    }
    //this will return a list

    public ArrayList<Double> getPrices() throws SQLException, ClassNotFoundException {
        /*for (int i=0;i<prices.size();i++){
         System.out.println(""+prices.get(i));
         }*/
        listItemsOfCart();
        return prices;
    }

    public String getProductName(int id) throws SQLException, ClassNotFoundException {
        //String p_name = productName.get(id);
        //return p_name;
        c = new DB_Conn().getConnection();

        String name = null;

        try {
            String getProductName = "SELECT  product_name FROM  products WHERE  id =" + id + "";
            Statement st = c.createStatement();

            ResultSet rs = st.executeQuery(getProductName);
            rs.next();
            name = rs.getString("product_name");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            c.close();
        }
        return name;
    }

    public String getProductCategory(int id) throws SQLException, ClassNotFoundException {
        //String p_name = productName.get(id);
        //return p_name;
        c = new DB_Conn().getConnection();
        String getCategoryName = "SELECT   category_name  FROM  products WHERE  id = " + id + "";
        Statement st = c.createStatement();
        /*SELECT  `category-name` 
         FROM  `products` 
         WHERE  `product_id` =1*/
        ResultSet rs = st.executeQuery(getCategoryName);
        rs.next();
        String name = rs.getString("category_name");
        return name;
    }

    public double getProductPrice(int id) throws SQLException, ClassNotFoundException {
        c = new DB_Conn().getConnection();
        String getProductName = "SELECT price FROM  products WHERE  id =" + id + "";
        Statement st = c.createStatement();
        ResultSet rs = st.executeQuery(getProductName);
        rs.next();
        double price = rs.getDouble("price");
        return price;
    }

    public double getTotalPriceOfCart() throws SQLException, ClassNotFoundException {
        ArrayList<Double> t_prices = new ArrayList(); //this will hold the prices

        //Step 1: GET THE "ids" inside the arraylist, 
        //Step 2:  find the corresponding matching price
        //Step 3:  multiply with the "qty"
        // ids (Product name) => retrieve price (Store it) => Multiply by *qty
        c = new DB_Conn().getConnection();
        double sum = 0;
        try {
            Statement st = c.createStatement();
            for (int i = 0; i < id.size(); i++) {
                String sqlGetPrice = "SELECT price FROM  products WHERE id =" + id.get(i);
                ResultSet rs = st.executeQuery(sqlGetPrice);
                rs.next();
                //theres only one value in resultset so go one step further and get the value
                double f = rs.getFloat("price");
                // Multiply by the quantity 
                f *= qty.get(i);
                // Add that multiplied value to prices list
                t_prices.add(f);
            }

            for (int i = 0; i < t_prices.size(); i++) {
                double p = t_prices.get(i);
                sum += p;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            c.close();
        }
        //System.out.println("Sum of your CartServlce is "+ sum);
        return sum;
    }

    public ArrayList<Integer> getQty() {
        return qty;
    }

    public ArrayList<Integer> getId() {
        return id;
    }

    public boolean addProduct(int id) throws SQLException, ClassNotFoundException {
        boolean added = false;
        boolean matches = false;
        //Step 1 : check for ids in DATABASE
        //Step 2 : Match the given id with database
        //          Matched -> break and mtches = 1

        c = new DB_Conn().getConnection();

        try {
            Statement st = c.createStatement();

            String sqlGetValidIds = "SELECT id FROM  products;";
            ResultSet rs = st.executeQuery(sqlGetValidIds);

            while (rs.next()) {
                int id_db = rs.getInt("id");
                if (id_db == id) {
                    // id matches in the database 
                    matches = true;
                    break;
                }
            }

            // here we get is a valid id
            // STEP 3 : if arraylist contains the same id Do not insert
            //          increment the qty, else insert into id & qty
            if (matches = true) {
                //inserti nto arraylist
                if (this.id.contains(id)) {
                    //increment the quantity at where the product id resides
                    int index = this.id.indexOf(id);
                    this.qty.set(index, this.qty.get(index) + 1);
                } else {
                    //Add one qty
                    this.qty.add(1);
                    //Add productID
                    this.id.add(id);
                }
                added = true;
            } else {
                //get out the function
                //Because no product in in the db with that id
                System.out.println("No product with that id exist in database");
                added = false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            c.close();
        }

        return added;
    }

    public ArrayList<Location> getLocations() throws SQLException, ClassNotFoundException {
        ArrayList<Location> locations = new ArrayList(); //this will hold the prices

        c = new DB_Conn().getConnection();
        try {
            Statement st = c.createStatement();
            String sqlGetPrice = "SELECT id,location_name,location_charge FROM  locations";
            ResultSet rs = st.executeQuery(sqlGetPrice);

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("location_name");
                Double cost = rs.getDouble("location_charge");
                locations.add(new Location(id, name, cost));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            c.close();
        }

        System.out.println(" ### Locations found ### " + locations.size());

        return locations;
    }

    public Location getLocation(int locationId) throws SQLException, ClassNotFoundException {

        Location location = null;

        c = new DB_Conn().getConnection();
        try {

            String shippingLocation = "SELECT id,location_name,location_charge FROM  locations where id = ?";
            PreparedStatement st = c.prepareStatement(shippingLocation);
            st.setInt(1, locationId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("location_name");
                Double cost = rs.getDouble("location_charge");
                location = new Location(id, name, cost);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            c.close();
        }
        return location;
    }

    public boolean removeProduct(int productId) {
        boolean removed;

        if (this.id.contains(productId)) {
            //where is the id's position
            //this.id.indexOf(productId);
            int index = this.id.indexOf(productId);
            int quantity = this.qty.get(index);
            //remove the entire stack from all the ArrayLists 
            this.productCategory.remove(index);
            this.productName.remove(index);
            this.prices.remove(index);
            this.qty.remove(index);
            this.id.remove(index);
            removed = true;
        } else {
            removed = false;
        }

        return removed;
    }

    public static void main(String args[]) throws SQLException, ClassNotFoundException {
        try {
            CartServlce c = new CartServlce();
            Scanner sc = new Scanner(System.in);
            /*
             do {
             System.out.println("Do u wish to continue?");
             String choice = sc.next();
             }while (choice.equals("1"));*/
            String choice = "1";
            while (choice.equals("1")) {

                System.out.println("What do u want to buy? Give me ID");

                int id = sc.nextInt();

                c.addProduct(id); //Good

                System.out.println("Do u wish to continue?");

                choice = sc.next();
            }

            c.showProducts(); //Good

            //c.listItemsOfCart();
            ArrayList<String> productNames = c.getProductNames();
            ArrayList<String> p_Category = c.getProductCategorys();
            ArrayList<Double> prices1 = c.getPrices();
            ArrayList<Integer> qty1 = c.getQty();
            for (int i = 0; i < productNames.size(); i++) {
                System.out.println(p_Category.get(i) + " " + productNames.get(i) + "              \t\t" + prices1.get(i) + " \t\t" + qty1.get(i) + " \t\t" + prices1.get(i) * qty1.get(i));
            }
            System.out.println("Total Price of the cart is :" + c.getTotalPriceOfCart());

            choice = "1";
            while ("1".equals(choice)) {

                System.out.println("Give Product id to remove");
                int id = sc.nextInt();
                boolean removeProduct = c.removeProduct(id);
                if (removeProduct) {
                    for (int i = 0; i < productNames.size(); i++) {
                        System.out.println(p_Category.get(i) + " " + productNames.get(i) + "              \t\t" + prices1.get(i) + " \t\t" + qty1.get(i) + " \t\t" + prices1.get(i) * qty1.get(i));

                        System.out.println("Total Price of the cart is :" + c.getTotalPriceOfCart());

                    }
                } else {
                    System.out.println("No Product to remove!!");
                }
            }

            //c.getTotalPriceOfCart();
        } catch (SQLException e) {
            System.out.println("" + e);
        } catch (ClassNotFoundException e) {
            System.out.println("" + e);
        }
    }
}
