<%-- 
    Document   : topMostViewedProducts
    Created on : 13 Dec, 2012, 6:45:53 PM
    Author     : chirag
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="database.DB_Conn"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>

<style type="text/css">
    .prodGrid {
        margin: 10px;
        margin-right: -12px;
        margin-left: 36px;
    }
</style>
<div class="grid_13" id="productStrip"> 
    <a href="viewProducts_.jsp">
        <div class="ProductHeading">
            <div class="grid_12">
                <h2 class="heading">Top Most Viewed Products Currently</h2>
            </div>
            <!--<div id="viewMore" class="grid_3">
                <h6 class="blue">View More</h6>
            </div>-->
        </div>
    </a>
    <div class="clear"></div>
    <%
        String sqlTopMostProds = "SELECT * "
                + " FROM (SELECT distinct ON (product_id) * FROM images) AS i"
                + " INNER JOIN products p"
                + " ON p.id=i.product_id "
                + " WHERE p.product_qty > 5 "
                + " ORDER BY p.hits DESC "
                + " OFFSET 0"
                + " LIMIT 16 ";

        DB_Conn db_conn = new DB_Conn();
        Connection c = db_conn.getConnection();
        Statement st = c.createStatement();
        ResultSet rs = st.executeQuery(sqlTopMostProds);
        String name, productId, category, subCategory, company, imageName, price;
        int i = 1;

        while (rs.next()) {

            price = rs.getString("price");
            imageName = rs.getString("image_name");
            productId = rs.getString("product_id");
            name = rs.getString("product_name");
            subCategory = rs.getString("sub_category_name");
            category = rs.getString("category_name");
            company = rs.getString("company_name");
    %>
    <div id="productList" class="grid_3 prodGrid"> 
        <a href="products?id=<%= productId%>"><img src="<%= imageName%>" /></a>
        <p id="info">
            <a href="product.jsp?id="><span class="blue"><%= name%></span></a><br/>
            By <%= company%> <%= category%><br/>
            <span class="red">Kshs. <%= price%></span>
        </p>            
    </div>
    <%
        if (i % 4 == 0) {
    %>
    <div class="clear"></div>
    <%
            }
            i++;
        }

        db_conn.closeConnection();

        if (i == 0) {
    %>
    <div class="clear"></div><div id="productList" class="grid_3 prodGrid"> 
        <a href="product.jsp"><img src="images/textures/linen.png" /></a>
        <p id="info">
            <a href="product.jsp?id="><span class="blue">No Product Added in Database</span></a><br/>
            <br/>
            <span class="red">Kshs. 0</span>
        </p>            
    </div>
    <%
        }
    %>
</div>