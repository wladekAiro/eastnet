
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*, database.*" %>

<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Easnat</title>
        <link rel="shortcut icon" href="images/logo/ico.ico"/>

        <link rel="stylesheet" type="text/css" href="css/reset.css"/>
        <link rel="stylesheet" type="text/css" href="css/text.css"/>
        <link rel="stylesheet" type="text/css" href="css/960_16.css"/>
        <link rel="stylesheet" type="text/css" href="css/styles.css"/>
        <link rel="stylesheet" type="text/css" href="css/product.css"  />

        <link rel="stylesheet" type="text/css" href="css/lightbox.css"  />

        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/lightbox.js"></script>

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

        <%
            String id = request.getParameter("id");
            if (request.getParameter("id") == null) {
                response.sendRedirect("viewProducts_.jsp");
            } else {

                DB_Conn c = new DB_Conn();
                Connection con = c.getConnection();

                Statement st = con.createStatement();

                String getProductQuery = "SELECT *  "
                        + "FROM (SELECT distinct ON (product_id) * FROM images WHERE product_id =" + id + ") AS i INNER JOIN products p ON p.id=i.product_id";
                ResultSet rs = st.executeQuery(getProductQuery);

                rs.next();
                //out.println(""+rs.getString("product-name"));

                String product_id = rs.getString("product_id");

                int product_hits = rs.getInt("hits");

                String product_name = rs.getString("product_name");

                String sub_category_name = rs.getString("sub_category_name");

                String category_name = rs.getString("category_name");

                String company_name = rs.getString("company_name");

                String price = rs.getString("price");

                String summary = rs.getString("summary");

                String image_name = rs.getString("image_name");

        %>


        <div class="container_16">

            <div class="grid_16" id="productStrip">
                <div class="ProductHeading">
                    <div class="grid_16">
                        <h2 class="heading"><%= product_name%>- <%=company_name%> <%= category_name%></h2>
                    </div>
                </div>

                <div class="grid_10">
                    <div class="grid_10">
                        <br/>
                        <h5>Category :<a href="#"><span class="blue"><%= category_name%></span></a> > <a href="#"><span class="blue"><%= sub_category_name%></span></a></h5>
                        <div class="clear"></div>
                        <br/>
                        <h5>Priced At <span class="BigRed">Kshs. <%= price%></span></h5>
                        <br/>
                        <br/>
                        <%
                            if (session.getAttribute("admin") != null) {
                        %>
                        <a href="admin_manageProduct.jsp?pid=<%= product_id%>">
                            <div class="grid_1" id="buy">
                                Edit
                            </div>
                        </a>
                        <%
                            }
                        %>


                        <a href="/products?id=<%= product_id%>">
                            <div class="grid_3" id="buy">
                                Buy This Product Now
                            </div>
                        </a>

                        <h1>Summary Of this item</h1>
                        <div class="clear"></div>
                        <p>Summary of <%= product_name%>

                            <%= summary%>

                        <h1>Brief Description</h1>
                        <br/>
                        <table class="grid_6" id="descripTable">
                            <tr class="grid_6">
                                <td>Name:</td>
                                <td><%= product_name%></td>
                            </tr>
                            <tr class="grid_6">
                                <td>Category</td>
                                <td><%= category_name%></td>
                            </tr>
                            <tr class="grid_6">
                                <td>Sub-Category</td>
                                <td><%= sub_category_name%></td>
                            </tr>
                            <tr class="grid_6">
                                <td>Company </td>
                                <td><%= company_name%></td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div  class="grid_5">
                    <div id="productImages">
                        <!-- Images with T are thumbs Images While with Q are The actual source Images -->

                        <img class="BigProductBox" alt="<%= product_name%>" src="<%= image_name%>" />

                        <div class="clear"></div>

                        <%
                            String getImages = "SELECT i.image_name FROM  images i INNER JOIN products p ON i.product_id=p.id WHERE i.product_id =" + product_id + "";

                            rs.close();

                            rs = st.executeQuery(getImages);
                            int img_number = 1;
                            rs.next();
                            // GET THE REST OF THE PRODUCT IMAGES
                            while (rs.next()) {

                                image_name = rs.getString("image_name");

                        %>


                        <a href="<%= image_name%>" rel="lightbox[product]" title="Click on the right side of the image to move forward.">
                            <img class="SmallProductBox" alt="<%= image_name%> 1 of 8 thumb" src="<%= image_name%>" />
                        </a>

                        <%
                                }
                                st.execute("UPDATE  products "
                                        + " SET  hits =  '" + (product_hits + 1) + "' "
                                        + " WHERE products.id =" + product_id + "");
                                st.close();
                                c.closeConnection();

                            }
                        %>
                        <!--
                                                <a href="images/productImages/q1.jpeg" rel="lightbox[product]" title="Click on the right side of the image to move forward.">
                                                    <img class="SmallProductBox" alt="Assassins Creed 1 of 8 thumb" src="images/productImages/t1.jpeg" />
                                                </a>
                        -->
                    </div>
                    <div class="clear"></div>

                </div>

            </div>
            <jsp:include page="/includesPage/mainHeaders/topMostViewedProducts_5_1.jsp"></jsp:include>
            </div>
        <jsp:include page="/includesPage/_footer.jsp"></jsp:include>
    </body>
</html>
