<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.DB_Conn"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Eastnat Foods</title>
        <!-- Default Stylesheets -->
        <%@include file="includesPage/_stylesheets.jsp" %>

        <link rel="stylesheet" href="css/slider.css"  />

        <script type="text/javascript" src="js/jquery.js"></script>

        <script type="text/javascript" src="js/slider.js"></script>


        <script type="text/javascript" >

            // This is the script for the banner slider

            $(document).ready(function () {
                $('#slider').s3Slider({
                    timeOut: 7000
                });
            });
        </script>


        <script type="text/javascript" src="js/myScript.js"></script>

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
        %>


        <%@include file="includesPage/_search_navigationbar.jsp" %>

        <%@include file="includesPage/_facebookJoin.jsp" %>

        <div id = "banner">
            <div class="container_16">
                <div class="grid_16" style="padding-left: 20px; " id="slider">	
                    <ul id="sliderContent">		
                        <!-- Duplicate this code for each image -->				

                        <li class="sliderImage" style="display: none; ">

                            <img src="images/banner/b1.jpg" width="900" height="300" /> 

                            <span class="top" style="display: none; ">

                                <strong>Eastnat Limited ...</strong>	

                                <br>backed by a passion for all things natural, 
                                food being the epicenter, powering a healthy community.

                            </span>

                        </li>  
                        <li class="sliderImage" style="display: none; ">

                            <img src="images/banner/dripping_on_lemon.png" width="900" height="300" /> 

                            <span class="top" style="display: none; ">

                                <strong>Natural honey ...</strong>				

                                <br> an Ayurvedic medicine over the years to cure colds,
                                coughs, sore throat, skin inflammations and burns amongst etc.
                                A natural modern cooking sauce, marinade or glaze. The natural substitute to maple syrup.

                            </span>

                        </li>  



                        <li class="sliderImage" style="display: none; ">

                            <img src="images/banner/kienyeji_eggs.png" width="900" height="300" /> 

                            <span class="top" style="display: none; ">

                                <strong>Kienyeji eggs...</strong>				

                                <br>Collection of Non-Toxic childrens colors available

                                Let your child learn the art of painting at an early age 

                                by having his hands on the colors available here... 

                            </span>

                        </li>  

                        <li class="sliderImage" style="display: none; ">

                            <img src="images/banner/chia_seeds.png" width="900" height="300" /> 

                            <span class="top" style="display: none; ">

                                <strong>Chia seeds...</strong>				

                                <br>The most amazing titles that you always wanted to get your hands onn.. 

                                Now you have the opportunity to have them all in your personal library.

                                International as well as Indian titles of many authors available

                            </span>

                        </li>   



                        <li class="sliderImage" style="display: none; ">

                            <img src="images/banner/peanut_butter_group.png" width="900" height="300" /> 

                            <span class="top" style="display: none; ">

                                <strong>Peanut butter...</strong>				

                                <br>A vast variety of different sets of colors including Oil-Pastels,

                                Pencil Colors, Poster Colors, Acrylic Colors and many more...

                            </span>

                        </li>   

                        <div class="clear sliderImage"></div>  

                    </ul>
                </div>
            </div>
        </div>



        <div class="container_16">
            <div id = "contents">
                <!-- LeftSide -->


                <%    DB_Conn db_conn = new DB_Conn();
                    Connection c = db_conn.getConnection();
                    Statement st = c.createStatement();
                    String getCategory = "SELECT * FROM  category  ";

                    ResultSet rs = st.executeQuery(getCategory);

                %>
                <div id="leftside" class="grid_3">
                    <div>
                        <ul id="leftsideNav">
                            <li><a href="#"><strong>Categories</strong></a></li>

                            <%                            while (rs.next()) {
                                    String category = rs.getString("category_name");
                            %>
                            <li><a href="/products?cat=<%= category%>"><%= category%></a></li>
                                <%
                                    }

                                    db_conn.closeConnection();
                                %>

                        </ul>
                    </div>
                    <!--        //         <div class="adv">
                                        <h2><br/>This is The Header of an Advertisement</h2>
                                        <p>We offer Advertisement display here </p>
                                    </div>-->
                </div>


            </div>

            <!-- Middle -->
            <div id="middle"class="grid_13">
                <jsp:include page="/includesPage/mainHeaders/topMostViewedProducts_4.jsp"></jsp:include>
                </div>
                <!--The Middle Content Div Closing -->
            </div>
            <!--The Center Content Div Closing -->

        <jsp:include page="includesPage/_footer.jsp"></jsp:include>





    </body>
</html>



