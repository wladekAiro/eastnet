
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Eastnat</title>
        <jsp:useBean class="product.ProductService" id="product" scope="session"></jsp:useBean>

        <%@page import="java.sql.*, database.*" %>
        <link rel="shortcut icon" href="images/logo/ico.ico"/>
        <link rel="stylesheet" type="text/css" href="css/reset.css"/>
        <link rel="stylesheet" type="text/css" href="css/text.css"/>
        <link rel="stylesheet" type="text/css" href="css/960_16.css"/>
        <link rel="stylesheet" type="text/css" href="css/product.css"  />

        <link rel="stylesheet" type="text/css" href="css/lightbox.css"  />

        <link rel="stylesheet" type="text/css" href="css/styles.css"/>

        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/lightbox.js"></script>
        <script src="js/myScript.js"></script>
    </head>
    <body>


        <%
            if (session.getAttribute("user") == null) {// THen new user, show join now
        %>
        <jsp:include page="/includesPage/_joinNow.jsp"></jsp:include>
        <%
        } else {
        %>
        <jsp:include page="/includesPage/_logout.jsp"></jsp:include>
        <%
            }
        %>

        <jsp:include page="/includesPage/_search_navigationbar.jsp"></jsp:include>
        <jsp:include page="/includesPage/_facebookJoin.jsp"></jsp:include>

            <div class="container_16">
                <div id = "contents">
                    <!-- LeftSide -->
                <%
                    /*
                *       FILTERING OF PRODUCTS AS OF FOLLOWS
 * 1) Retrieve Category 
 *      if Category set 
 *      Show 
 *          SubCategory
 *          Company
 *          Pricing
 *              SQL select * from products WHERE category = 'cat';
 *      2) Retrieve Sub Category 
                if SubCategory is set
 *                  Shw
    *                  Company  
    *                  Pricing
 *                  SQL select * from products WHERE subcategory = 'scat';
            *     else  Show 
            *          SubCategory
            *          Company
            *          Pricing
 *      else 
 *          Show
 *          Category 
 *          Pricing
 *              SQL select * from products;
 * 
 * Accordingly set the SQL Statement 
                     */
                %>

                <div id="leftside" class="grid_3">

                    <%                        String category, subcategory;
                        StringBuffer sql = new StringBuffer();
                        sql.append("SELECT * FROM (SELECT distinct ON (product_id) * FROM images) AS i "
                                + " INNER JOIN  products p "
                                + " ON p.id=i.product_id ");

                        category = "";
                        subcategory = "";
                        if (request.getParameter("cat") != null) {
                            category = (String) request.getParameter("cat");
                            ArrayList subCat = product.getSubcategory(category);

                    %>
                    <div>
                        <ul id="leftsideNav">
                            <li><a href="#"><strong>Sub-Categories</strong></a></li>
                                <%                                for (int i = 0; i < subCat.size(); i++) {
                                %>
                            <li><a href="/products?cat=<%= category%>&scat=<%= subCat.get(i)%>"><%= subCat.get(i)%></a></li>      
                                <%
                                    }
                                    subCat.clear(); %>
                        </ul>
                    </div>

                    <%
                        if (request.getParameter("scat") != null) {
                            subcategory = (String) request.getParameter("scat");
                        }
                    } else {
                        //Show Category
                        ArrayList cat = product.getCategory();
                    %>
                    <div>
                        <ul id="leftsideNav">
                            <li><a href="#"><strong>Categories</strong></a></li>
                                <%
                                    for (int i = 0; i < cat.size(); i++) {
                                %>
                            <li><a href="/products?cat=<%= cat.get(i)%>"><%= cat.get(i)%></a></li>      
                                <%
                                    }
                                    cat.clear();
                                %>
                        </ul>
                    </div>
                    <%
                        }
                    %>

                    <div class="adv">
                        <!--                        <h2><br/>This is The Header of an Advertisement</h2>
                                                <p>We offer Advertisement display here </p>-->
                    </div>
                </div>
            </div>

            <!-- Middle -->
            <div id="middle"class="grid_13">
                <div class="grid_13" id="whiteBox">
                    <div class="ProductHeading">
                        <div class="grid_12">
                            <h2 class="heading">Products >
                                <%= category%>  >
                                <%= subcategory%>
                            </h2>
                        </div>

                    </div>
                    <div class="grid_12 productListing">

                        <div class="clear"></div>
                        <%
                            if (request.getParameter("cat") != null) {
                                category = (String) request.getParameter("cat");
                                /*
WHERE  `category-name` =  'Games'
AND  `sub-category-name` =  'Action-Adventure-Game'
GROUP BY  `product-name` */

                                sql.append(" WHERE  p.category_name =  '" + category + "' ");
                        %>
                        <div class="grid_4 ">
                            <a id="greenBtn" href="/products">Category : <%= category%> [x]</a>
                        </div>
                        <%

                        %>

                        <%                            if (request.getParameter("scat") != null) {
                                subcategory = (String) request.getParameter("scat");
                                sql.append(" AND p.sub_category_name =  '" + subcategory + "' ");
                        %>
                        <div class="grid_4 ">
                            <a id="greenBtn" href="/products?cat=<%= category%>">Sub-Category : <%= subcategory%> [x]</a>
                        </div>
                        <%
                            }
                        %>
                        <%
                            }
                        %>

                        <%
                            //String sql = "SELECT * FROM  `products` p "
                            //           + "INNER JOIN  `images` i "
                            //           + "USING (  `product-name` ) 
                            //             +`product_qty` > 0
                            //          + "GROUP BY  `product-name` ";
                            DB_Conn con = new DB_Conn();
                            Connection c = con.getConnection();
                            Statement st = c.createStatement();
                            ResultSet rs;
                            if (sql.toString().equalsIgnoreCase("SELECT p.id as product_id,p.price,i.image_name,p.product_name,"
                                    + "p.sub_category_name,p.category_name,p.company_name FROM  products p "
                                    + "INNER JOIN  images i "
                                    + "ON p.id=i.product_id "
                            )) {

                                String newSQL = "SELECT p.id as product_id,p.price,i.image_name,p.product_name,"
                                        + "p.sub_category_name,p.category_name,p.company_name "
                                        + " FROM  products p"
                                        + " INNER JOIN  images i"
                                        + " ON p.id=i.product_id "
                                        + "WHERE p.product_qty > 0 "
                                        + " GROUP BY  p.id, i.product_id "
                                        + " ORDER BY  p.hits DESC ";
                                //out.print("Equals "+sql.toString() +" "+newSQL);
                                rs = st.executeQuery(newSQL);
                            } else {

                                sql.append(" AND p.product_qty > 0  "
                                        + " ORDER BY  hits DESC  ");
                                //out.print("Not Equals "+sql.toString());
                                rs = st.executeQuery(sql.toString());
                            }

                            while (rs.next()) {
                                /*
product-name	product_id	sub-category-name	category-name	company-name	price	summary	image-id	image-name*/
                                String product_id = rs.getString("product_id");

                                String product_name = rs.getString("product_name");

                                String sub_category_name = rs.getString("sub_category_name");

                                String category_name = rs.getString("category_name");

                                String company_name = rs.getString("company_name");

                                String price = rs.getString("price");

                                String summary = rs.getString("summary");

                                String image_name = rs.getString("image_name");
                                /*
                                    out.println("<br/>"+product_id+
                                            "<br/>"+product_name+
                                            "<br/>"+sub_category_name+
                                            "<br/>"+category_name+
                                            "<br/>"+company_name+
                                            "<br/>"+price+
                                            "<br/>"+summary+
                                            "<br/>"+image_name);
                                 */
                        %>
                        <div class="clear"></div>
                        <div class="grid_2">
                            <a href="/products?id=<%=product_id%>"><img src="<%= image_name%>" /></a>
                        </div>
                        <div class="grid_9">
                            <div class="grid_5">
                                <p id="info"><a href="/products?id=<%=product_id%>"><h3><span class="blue"> <%=product_name%></span></h3></a>By <%= company_name + " " + category_name%><br/><span class="red">Kshs. <%= price%></span></p>
                            </div>
                            <div class="grid_3 push_2">
                                <p><%=sub_category_name%>  <a href="addToCart.jsp?id=<%= product_id%>" id="greenBtn">Add to cart</a></p><p>Will Be delivered in 3 Working days</p>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <%
                            }
                            rs.close();
                            st.close();
                            con.closeConnection();
                        %>

                    </div>
                </div>

                <jsp:include page="/includesPage/mainHeaders/topMostViewedProducts_4.jsp"></jsp:include>

                </div>
                <!--The Middle Content Div Closing -->
            </div>
            <!--The Center Content Div Closing -->
        <jsp:include page="/includesPage/_footer.jsp"></jsp:include>

    </body>
</html>
