<%-- 
    Document   : admin_addProduct_Insert
    Created on : 30 Nov, 2012, 11:35:07 PM
    Author     : chirag
--%>

<%@page import="java.sql.Date"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLIntegrityConstraintViolationException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="database.DB_Conn"%>
<%@page import="javazoom.upload.DBStore"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eastnat</title>
    </head>
    <body>

        <jsp:useBean class="product.productBean" scope="session" id="productBean"></jsp:useBean>

        <%
            if (productBean.getCompany() == null
                    || productBean.getCompany() == "") {
                response.sendRedirect("admin_addProduct_1.jsp");
            } else if (productBean.getCategory() == null
                    || productBean.getCategory() == ""
                    || productBean.getSubcategory() == null
                    || productBean.getSubcategory() == "") {
                response.sendRedirect("admin_addProduct_2.jsp");
            } else if (productBean.getName() == null
                    || productBean.getName() == ""
                    || productBean.getTags() == null
                    || productBean.getTags() == "") {
                response.sendRedirect("admin_addProduct_3.jsp");
            } else if (productBean.getPrice() == null
                    || productBean.getPrice() == ""
                    || productBean.getQuantity() == null
                    || productBean.getQuantity() == ""
                    || productBean.getSummary() == null
                    || productBean.getSummary() == "") {
                response.sendRedirect("admin_addProduct_4.jsp");
            }

            double price = 0;
            int quantity = 0;

            Connection c = new DB_Conn().getConnection();

            try {
                price = Double.parseDouble(productBean.getPrice());
                quantity = Integer.parseInt(productBean.getQuantity());


        %>


        <%                /*
        INSERT INTO  `saikiran enterprises`.`products` (
`product_id` ,
`product-name` ,
`sub-category-name` ,
`category-name` ,
`company-name` ,
`price` ,
`summary` ,
`tags` ,
`product_qty` ,
`lastUpdated`
)
VALUES (
NULL ,  'Assassins Cedd',  'Action-Game',  'Games',  'EA, Electronic Arts',  '3', 'dcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdc', 'dcdcdcdcdcdcdcdc',  '2', NOW( )
);
 
//Fetch the product id
SELECT  `product_id` 
FROM  `products` 
WHERE  `product-name` =  'Assassins Creed'
 
      //Insert into expenses
 INSERT INTO  `saikiran enterprises`.`expenses` (
`expenses_id` ,
`product_id` ,
`product_name` ,
`price` ,
`purchase_date`
)
VALUES (
NULL ,  '2',  'Ayinga Movie ',  '123456', NOW( )
);  
                 */
                String categoryIdQuery = "SELECT id FROM category WHERE category_name = ?";
                String subCategoryQuery = "SELECT id FROM sub_category WHERE sub_category_name = ?";

                String insertQuery = ""
                        + "INSERT INTO  "
                        + "products "
                        + "(product_name,"
                        + "category_id ,"
                        + "sub_category_name ,"
                        + "sub_category_id,"
                        + "category_name ,"
                        + "company_name ,"
                        + "price ,"
                        + "summary, "
                        + "tags, "
                        + "product_qty, "
                        + "last_updated, "
                        + "hits) "
                        + "VALUES "
                        + ""
                        + "(?,?,?,?,?,?,?,?,?,?,?,?);";

                int categoryId = 0;
                int subCategoryId = 0;

                PreparedStatement categoryIdSt = c.prepareStatement(categoryIdQuery);
                PreparedStatement subCategoryIdSt = c.prepareStatement(subCategoryQuery);
                PreparedStatement insertStmt = c.prepareStatement(insertQuery);

                categoryIdSt.setString(1, productBean.getCategory());
                subCategoryIdSt.setString(1, productBean.getSubcategory());

                ResultSet ctId = categoryIdSt.executeQuery();
                ResultSet sctId = subCategoryIdSt.executeQuery();

                while (ctId.next()) {
                    categoryId = ctId.getInt("id");
                }

                while (sctId.next()) {
                    subCategoryId = sctId.getInt("id");
                }

                Date currentDate = new Date(new java.util.Date().getTime());

                insertStmt.setString(1, productBean.getName());
                insertStmt.setInt(2, categoryId);
                insertStmt.setString(3, productBean.getSubcategory());
                insertStmt.setInt(4, subCategoryId);
                insertStmt.setString(5, productBean.getCategory());
                insertStmt.setString(6, productBean.getCompany());
                insertStmt.setDouble(7, price);
                insertStmt.setString(8, productBean.getSummary());
                insertStmt.setString(9, productBean.getTags());
                insertStmt.setInt(10, quantity);
                insertStmt.setDate(11, currentDate);
                insertStmt.setInt(12, 0);

                int result = insertStmt.executeUpdate();

                if (result > 0) {
                    Statement st = c.createStatement();

                    ResultSet executeQuery = st.executeQuery("SELECT id "
                            + " FROM products "
                            + " WHERE product_name = '" + productBean.getName() + "'");

                    int ProductId = 0;
                    while (executeQuery.next()) {
                        ProductId = executeQuery.getInt("id");
                    }
                    session.setAttribute("productName", productBean.getName());
                    session.setAttribute("productId", ProductId);

                    st.executeUpdate(" INSERT INTO expenses ("
                            + "product_id ,"
                            + "product_name ,"
                            + "price ,"
                            + "purchase_date"
                            + ")"
                            + "VALUES ('" + ProductId + "',  '" + productBean.getName() + "',  '" + (quantity * price) + "', '" + currentDate + "'"
                            + " );  ");
                    response.sendRedirect("productInsertImages.jsp");
                }

            } catch (NumberFormatException e) {
                response.sendRedirect("admin_addProduct_4.jsp");
            } catch (SQLIntegrityConstraintViolationException e) {
                response.sendRedirect("admin_addProduct_3.jsp");
            } finally {
                c.close();
            }
        %>
    </body>
</html>
