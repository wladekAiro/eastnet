
<%@page import="user.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<style type="text/css">
    .backRed {
        background: #CC0000;
        padding: 3px 7px;
        margin-right: 3px;
    }
</style>
<jsp:useBean id="cart" scope="session" class="service.CartServlce"  ></jsp:useBean>
<%
    ArrayList<Integer> Qty = new ArrayList();
    Qty = cart.getQty();
    int totalQty = 0;
    for (int i=0; i<Qty.size(); i++){
        totalQty += Qty.get(i);
    }
    
        
    
    User user = (User) session.getAttribute("user");
    String email = user.getUserEmail();
    String userName = user.getUsername();
    int uid = user.getUserId();
    
    String printName;
    if (userName == null){
        printName = email;
    }
    else {
        printName = userName;
    }
%>
   <div id = "topWrapper">
        <div class="container_16">
                <div class="grid_16">
                        <div id="logo" class="grid_6"> <a href="/"><img src="images/logo/eastnat_logo.png" /></a>
                        </div>
                        <div class="grid_9" id="top">
                            <ul>
                                <a href="_logoutServlet"><li id="greenBtn" class ="Btn showForm">Logout</li></a>
                                <a href="userinfo.jsp?uid=<%= uid %>"><li class ="Btn showForm"><%= printName %></li></a>
                                <%
                                    if (session.getAttribute("admin") != null){
                                %>
                                <a href="/admin"><li class ="Btn showForm">Administrator: </li></a>
                                <%
                                    }
                                %>
                                <a href="/cart"><li class ="Btn showForm"><span class="backRed"><%= totalQty %></span> in My Cart </li></a>
                            </ul>
                        </div>
                </div>
            </div>
    </div>
