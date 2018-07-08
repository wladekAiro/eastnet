<%-- 
    Document   : admin_approvedOrders
    Created on : Nov 24, 2012, 2:07:17 PM
    Author     : jDeveloper
--%>

<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Eastnat Foods</title>
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
        <jsp:include page="includesPage/_joinNow.jsp"></jsp:include>
        <%
        } else {
        %>
        <jsp:include page="includesPage/_logout.jsp"></jsp:include>
        <%
            }
            if (session.getAttribute("admin") == null) {
                response.sendRedirect("/admin");
            }
        %>

        <jsp:include page="includesPage/_search_navigationbar.jsp"></jsp:include>
        <jsp:include page="includesPage/_facebookJoin.jsp"></jsp:include>


            <div class="container_16">

                <div class="grid_16" style="padding: 10px;" id="whiteBox">

                    <br/>
                    <h1 class="grid_15">Delivered Orders</h1><hr/>

                </div>
                <div class="clear"></div>

            <jsp:include page="includesPage/hesders_sidebars/admin_menuSideBar.jsp"></jsp:include>

            <jsp:include page="includesPage/gChartings/gCharts_pieChartItemsSoldByCategory.jsp"></jsp:include>

            </div>

            <div class="container_16">
                <div id="whiteBox" class="grid_16" style="padding-top: 10px; padding-bottom: 10px;">

                    <form method="post" action="changeProductStatus">
                        <div class="grid_16">
                            <div class="grid_16"  id="CartTable" style="padding:10px 00px;">
                                <h1 class="grid_15" style ="text-align: center; padding: 10px 0px 10px 0px;  border-top: 20px #444 solid;">Delivered Orders</h1>  

                                <div class="clear"></div>
                                <div class="grid_10">
                                    <input id="greenBtn" type="submit" value="Change Product Status">
                                    <select name="ChangeStatus">
                                        <option value="delivered">Delivered</option>
                                        <option value="cancel">Cancel</option>
                                    </select></div>
                                <div class="clear"></div>
                            <%-----------------%>
                            <div class="grid_1">
                                <h3>Order No</h3>
                            </div>
                            <div class="grid_7">
                                <h3 class="push_3">Order Summary</h3> 
                                <div class="clear"></div>
                                <div class="grid_4">
                                    Item 
                                </div>
                                <div class="grid_2">
                                    Price x Quantity
                                </div>
                            </div>
                            <div class="grid_2">
                                <h3 style ="text-align: center;">Date</h3>
                            </div>   
                            <div class="grid_2">
                                <h3 style ="text-align: center;">Mobile No</h3>
                            </div>
                            <div class="grid_3">
                                <h3 >Address</h3>
                            </div>       
                            <div class="clear"></div>

                            <%
                                String sql = "\n"
                                        + "SELECT o.id AS order_id, o.order_number, s.product_name ,"
                                        + " s.product_price , s.product_quantity, "
                                        + " s.sold_on , o.mobile_number ,"
                                        + " o.address , o.shippers_name "
                                        + " FROM orders o "
                                        + " INNER JOIN sales s "
                                        + " ON o.id=s.order_id "
                                        + " WHERE o.status = 'delivered' "
                                        + " ORDER BY o.id DESC";

                                Connection c = new database.DB_Conn().getConnection();
                                try {
                                    PreparedStatement psmt
                                            = c.prepareStatement(sql);

                                    ResultSet rs = psmt.executeQuery();

                                    int oldOrder = 0;
                                    int newOrder;
                                    int billNo;

                                    String product_name,
                                            name, address, mobile_no;
                                    double product_price;
                                    int product_quantity;
                                    Date sold_on_date;
                                    Time sold_on_time;

                                    while (rs.next()) {

                                        newOrder = rs.getInt("order_id");
                                        product_name = rs.getString("product_name");
                                        product_price = rs.getDouble("product_price");
                                        product_quantity = rs.getInt("product_quantity");
                                        sold_on_time = rs.getTime("sold_on");
                                        sold_on_date = rs.getDate("sold_on");
                                        billNo = rs.getInt("order_number");
                                        String orderDateArr[] = sold_on_date.toString().split("-");

                                        name = rs.getString("shippers_name");

                                        address = rs.getString("address");

                                        mobile_no = rs.getString("mobile_number");
                                        
                                        if (oldOrder == newOrder) {
                                            // Dont Draw border Type II order Div
%>

                            <!-- Type II Order -->
                            <div class="grid_12">
                                <div class="push_1">
                                    <div class="grid_7">
                                        <div class="grid_4 ">
                                            <a href="product.jsp?id="></a>
                                            <%= product_name%>
                                        </div>
                                        <div class="grid_2">
                                            Rs. <%= product_price%> x<%= product_quantity%>
                                        </div>
                                    </div>
                                    <div class="grid_2 ">
                                        <%= sold_on_date%>
                                    </div>
                                </div>
                            </div>

                            <%
                            } else {
                                // Draw New Order Type I order Div
%>

                            <!-- Type I Order -->
                            <div class="grid_16"  >

                                <div  class="grid_1" style="border-top: 2px #444 solid; ">
                                    <a class="blue" href="showMyBill.jsp?oid=<%= newOrder%>"><%= billNo%></a>
                                </div>  
                                <div class="grid_7" style="border-top: 2px #444 solid; ">
                                    <div class="grid_4 ">
                                        <%= product_name%>
                                    </div>
                                    <div class="grid_2">
                                        Rs. <%= product_price%> x<%= product_quantity%>
                                    </div>
                                </div>
                                <div class="grid_2" style="border-top: 2px #444 solid; ">
                                    <%= sold_on_date%>
                                </div>
                                <div class="grid_2" style="border-top: 2px #444 solid; ">
                                    <%= mobile_no%>
                                </div>
                                <div class="grid_3" style="border-top: 2px #444 solid; ">


                                    <%= name%> <br/><br/>

                                    <input type="checkbox" class="order" name="order" value="<%= newOrder%>"/>

                                    <%= address%>
                                </div>  
                            </div>

                            <%
                                        }
                                        oldOrder = newOrder;
                                    }
                                } finally {
                                    c.close();
                                }
                            %>
                        </div></div></form>
            </div>
        </div>
    </body>
</html>
