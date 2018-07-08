<%-- 
    Document   : showMyBill
    Created on : 21 Nov, 2012, 10:13:42 PM
    Author     : chirag
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
        <style type="text/css">

            #whiteBox input , textarea{
                width:90px;
                position: relative;
                color:#000;
                border-color:#696969;
                outline: none;
                border-radius:7px 0px 7px 0px;
                padding:5px;
                background: -webkit-linear-gradient(top, #EEE,#FFF);
                background: -moz-linear-gradient(top, #EEE,#FFF);
                box-shadow:0px 0px 3px  #000;
                -webkit-transition: .7s all ease-in-out;
            }

            #whiteBox input :focus{
                color:#000;
                border-color:#696969;
                outline: none;
                background: -webkit-linear-gradient(top, #FFF,#EEE);
                background: -moz-linear-gradient(top, #FFF,#EEE);
                font-family:'Droid';
                box-shadow:0px 0px 7px  #000;
                -webkit-transition: .7s all ease-in-out;
            }

            #whiteBox  textarea:focus{
                color:#000;
                border-color:#696969;
                outline: none;
                background: -webkit-linear-gradient(top, #FFF,#EEE);
                background: -moz-linear-gradient(top, #FFF,#EEE);
                font-family:'Droid';
                box-shadow:0px 0px 7px  #000;
                -webkit-transition: .7s all ease-in-out;

            }
            #whiteBox textarea{
                font-family:'Droid';
            }
            #whiteBox {
                padding-top: 10px;
                padding-bottom: 10px;
                padding: 10px;
            }
            #status {
                margin: 17px;
                padding: 7px;
                font-size: 17px;
                text-align: center;
                box-shadow: 0px 0px 10px #999;
            }
        </style>
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
            if ((session.getAttribute("user") == null)) {
                response.sendRedirect("/");
            }
        %>

        <jsp:include page="includesPage/_search_navigationbar.jsp"></jsp:include>
        <jsp:include page="includesPage/_facebookJoin.jsp"></jsp:include>
        <%--
 <div id = "" style="background: #AAA; padding: 10px; box-shadow: 0px 10px 10px #555;">
     <div class="container_16"  style="background: #AAA; ">
         <div class="grid_16">
             <div id="" class="grid_5 push_1" style="font-size: 17px; padding: 15px;">
                 <a href="index.jsp">
                     <img style="margin-left: 33px" src="images/logo/icon.png" />
                     SaiKiran BookStores
                 </a>
             </div>
             <div class="grid_8">
                 
                 <p style="text-align: left; color: black; text-shadow: none;" >Contact:
                 +91 9004300647</p> 
                 <p style="text-align: left; color: black; text-shadow: none;" >Address:
                 <br/>B-3/, Shop No 18,
                 Silver Park,
                 Mira Bhyendar Road, 
                 Mira Road East,
                 Mumbai</p> 
                 
             </div>
         </div>
     </div>
 </div>
        --%> 
        <div class="container_16">
            <!--
            <div class="grid_3" id="whiteBox">
                <h1 style="text-align: center;">Enter an Order Number</h1>
                <hr/><br/> 
                <form>
                    <input style="float: right; width: 130px" type="text" placeholder="Order Number Here..." required/>
                    <input type="submit" value="Show invoice"/>
                </form>
           </div>-->

            <%
                if (request.getParameter("oid") != null) {

                    Connection c = new DB_Conn().getConnection();
                    try {
                        String OrderId = request.getParameter("oid");
                        String fetchInfoSQL = "SELECT * FROM  orders WHERE id =  '" + OrderId + "' ; ";
                        Statement st = c.createStatement();
                        ResultSet rs1 = st.executeQuery(fetchInfoSQL);
                        while (rs1.next()) {
                            String name,
                                    email, address, mobileNum, status;
                            Date ordered_on_date;
                            Time ordered_on_time;

                            name = rs1.getString("shippers_name");
                            email = rs1.getString("shippers_email");
                            address = rs1.getString("address");
                            mobileNum = rs1.getString("mobile_number");
                            ordered_on_date = rs1.getDate("ordered_On");
                            ordered_on_time = rs1.getTime("ordered_On");
                            status = rs1.getString("status");
            %>
            <div class="grid_12 push_2" id="whiteBox" style="margin-top: 30px;">
                <div class="grid_6">
                    <div class="grid_2">
                        To ;
                    </div>
                    <div class="clear">
                    </div>
                    <div class="grid_2">
                        Name :
                    </div>
                    <div class="grid_3">
                        <%= name%>
                    </div>
                    <div class="grid_2">
                        Email:
                    </div>
                    <div class="grid_3">
                        <%= email%>
                    </div>
                    <div class="grid_2">
                        Address:
                    </div>
                    <div class="grid_3">
                        <%= address%>
                    </div>
                    <div class="grid_2">
                        Mobile:
                    </div>
                    <div class="grid_3">
                        <%= mobileNum%>
                    </div>
                    <div class="grid_2">
                        Ordered On:
                    </div>
                    <div class="grid_3">
                        <%= ordered_on_date + ":" + ordered_on_time%>
                    </div>
                </div>
                <div class="grid_5" id="whiteBox" style="margin-top: 30px;">
                    <div class="grid_5">
                        <div class="grid_1">
                            From;
                        </div>
                        <div class="grid_3">
                            Eastnat Foods
                        </div>
                        <div class="grid_1">
                            Email:
                        </div>
                        <div class="grid_3">
                            support@eastnatfoods.com
                        </div>
                        <div class="grid_1">
                            Address:
                        </div>
                        <div class="grid_3">
                            Nairobi
                        </div>
                        <div class="grid_1">
                            Mobile:
                        </div>
                        <div class="grid_3">
                            +254711109431
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            %>
            <div id="whiteBox" class="grid_12 push_2">
                <div id="CartTable" style="padding:10px 00px" class="grid_12">
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
                    <div class="grid_3 ">
                        <h3>Total Value</h3>
                    </div>

                    <div class="clear"></div>

                    <%
                        String sql = "SELECT 0.id , o.order_number ,  s.product_name ,  s.product_price ,  s.product_quantity ,  s.sold_on "
                                + " FROM  orders o "
                                + " INNER JOIN  sales s "
                                + " ON o.id = s.order_id "
                                + " WHERE o.id = " + OrderId + " "
                                + " ORDER BY id DESC ";

                        PreparedStatement psmt
                                = c.prepareStatement(sql);

                        ResultSet rs = psmt.executeQuery();

                        int oldOrder = 0;
                        int newOrder;
                        int billNo;

                        String product_name;
                        double product_price;
                        int product_quantity;
                        Date sold_on_date;
                        Time sold_on_time;
                        double totalPrice = 0;
                        double totalValue = 0;
                        while (rs.next()) {
                            newOrder = rs.getInt("id");
                            product_name = rs.getString("product_name");
                            product_price = rs.getDouble("product_price");
                            product_quantity = rs.getInt("product_quantity");
                            sold_on_time = rs.getTime("sold_on");
                            sold_on_date = rs.getDate("sold_on");
                            billNo = rs.getInt("order_number");
                            totalValue = product_quantity * product_price;
                            totalPrice += totalValue;

                            if (oldOrder == newOrder) {
                                // Dont Draw border Type II order Div
%>

                    <!-- Type II Order -->
                    <div class="grid_12">
                        <div  class="grid_1">
                            <a class="blue" href="showMyBill.jsp?oid=<%= newOrder%>"><%= billNo%></a>
                        </div>
                        <div class="grid_7">
                            <div class="grid_4 ">
                                <a href="product.jsp?id="></a>
                                <%= product_name%>
                            </div>
                            <div class="grid_2">
                                Kshs. <%= product_price%> x<%= product_quantity%>
                            </div>
                        </div>
                        <div class="grid_3">
                            <%= totalValue%> 
                        </div>
                    </div>

                    <%
                    } else {
                        // Draw New Order Type I order Div
%>

                    <!-- Type I Order -->
                    <div class="grid_12">
                        <div  class="grid_1">
                            <a class="blue" href="showMyBill.jsp?oid=<%= newOrder%>"><%= billNo%></a>
                        </div>
                        <div class="grid_7">
                            <div class="grid_4 ">
                                <%= product_name%> 
                            </div>
                            <div class="grid_2">
                                Kshs. <%= product_price%> x<%= product_quantity%>
                            </div>
                        </div>
                        <div class="grid_3">
                            <%= totalValue%> 
                        </div>
                    </div>
                    <div class="clear"></div>

                    <%
                            }
                            oldOrder = newOrder;
                        }

                        totalPrice = Math.ceil(totalPrice);
                    %>

                    <!-- Type I Order -->
                    <div class="clear"></div><br/>
                    <div class="grid_12">
                        <hr class="grid_11"/>
                        <div class="grid_4">
                            Total Order Price
                        </div>
                        <div class="grid_4 push_4">
                            <h1>Ksh. <%= totalPrice%></h1> 
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
        </div>

        <%
            } finally {
                c.close();
            }
        } else {
        %>
        <div class="container_16">
            <div class="grid_12 push_2" id="whiteBox">
                <br/><h1>No Product Invoice to Print</h1><hr/><br/>
            </div>
        </div>
        <%            }
        %>


    </body>
</html>
