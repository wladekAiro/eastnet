<%-- 
    Document   : admin_performance
    Created on : 22 Nov, 2012, 10:20:00 PM
    Author     : chirag
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            .highlight {
                box-shadow: inset -10px 0px 10px #666;
                background: #E0E0E0;
                border-radius: 0px 27px 27px 0px;
            }
            
            .blueButton {
                background: -webkit-linear-gradient(top,#00AAC9, #026A84);
            }
            
            
            #buy {
                padding: 30px;
                font-size: 17px;
                -webkit-transition:.3s all ease-in-out;
                -moz-transition:.3s all ease-in-out;
            }
            #buy:hover {
                padding: 30px;
                font-size: 17px;
                box-shadow: inset 0px 2px 17px #444;
            }
            .adminMenu {
                margin-top: 10px;
                margin-bottom: 10px;
                margin-right: 0px;
                background: #FFF;
                box-shadow: 0px 0px 10px #333;
            }
            .adminMain {
                margin-top: 10px;
                margin-bottom: 10px;
                background: #FFF;
                box-shadow: 0px -1px 10px #333;
            }
            #leftside {
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        
        <%
        if (session.getAttribute("user") == null ){// THen new user, show join now
            %>
            <jsp:include page="includesPage/_joinNow.jsp"></jsp:include>
        <%
        }else {
            %>
            <jsp:include page="includesPage/_logout.jsp"></jsp:include>
        <%
        }
        %>

        <jsp:include page="includesPage/_search_navigationbar.jsp"></jsp:include>
        <jsp:include page="includesPage/_facebookJoin.jsp"></jsp:include>

        <div class="container_16">
            <div class="grid_16" style="padding: 10px;" id="whiteBox">
                    <div class="grid_15">
                        <br/><h1>Add Product </h1><hr/>
                    </div>
                </div>
                <div class="clear"></div>
                
                <div id="leftside" class="grid_3">
                    <ul id="leftsideNav">
                        <li><a><strong>Dash Home</strong></a></li>
                        <li><a>Stock</a></li>
                        <li><a>Performance</a></li>
                        <li><a>Orders</a></li>
                        <li><a href="productInsert.jsp">Add Product</a></li>
                        <li><a>Settings</a></li>
                    </ul>
                </div>
                
                
                
                <jsp:useBean class="product.ProductBean" scope="session" id="productBean"/>
                <jsp:setProperty name="productBean" property="company" value="${param.company}"/>    
                <jsp:setProperty name="productBean" property="category" value="${param.category}"/>     
                <jsp:setProperty name="productBean" property="subcategory" value="${param.subCategory}"/>
                <jsp:setProperty name="productBean" property="name" value="${param.productName}"/>     
                <jsp:setProperty name="productBean" property="tags" value="${param.tags}"/>     
                <jsp:setProperty name="productBean" property="price" value="${param.price}"/>     
                <jsp:setProperty name="productBean" property="quantity" value="${param.productQty}"/>     
                <jsp:setProperty name="productBean" property="summary" value="${param.summary}"/>     

                <div class="grid_13"  style="padding: 10px 0px;" id="whiteBox">
                    <div class="grid_13">
                        <br/><h1>Add Product Controller</h1><hr/>
                    <%
                    if (request.getParameter("page") != null){
                        response.sendRedirect(request.getParameter("page"));
                    }else {
                        response.sendRedirect("index.jsp");
                    }
        
                    %>
                    </div>
                </div>
                    
        </div>
        
    </body>
</html>
