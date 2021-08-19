<%-- 
    Document   : orderCart
    Created on : Jan 19, 2021, 10:42:16 PM
    Author     : sasuk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Car Rental History Detail</title>
        <!-- Custom styles for this template -->
        <link href="${applicationScope.PATHHOME}/css/shop-homepage.css" rel="stylesheet">
        <!-- Bootstrap core CSS -->
        <link href="${applicationScope.PATHHOME}/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


        <script src="${applicationScope.PATHADMIN}/js/all.min.js" crossorigin="anonymous"></script>
    </head>
    <body>

        <jsp:include page="header.jsp"/>


        <br>
        <c:set var="productList" value="${requestScope.LISTPRODUCT}" />
        <c:if test="${not empty productList}">
            <div class="container">



                <div class="card">
                    <table class="table table-hover shopping-cart-wrap">
                        <thead class="text-muted">
                            <tr>
                                <th scope="col">Product</th>
                                <th scope="col" width="120">Quantity</th>
                                <th scope="col" width="120">Price</th>
                                <th scope="col" width="200" class="text-right">Action</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="dto" items="${productList}">

                                <tr>
                                    <td>
                                        <figure class="media">
                                            <div class="img-wrap"><img src="${applicationScope.PATHRESOURCE}/vinfat.jpg" class="img-thumbnail" width="150px" height="150px"></div>
                                            <figcaption class="media-body">
                                                <h6 class="title text-truncate">${dto.name}</h6>
                                                <dl class="param param-inline small">
                                                    <dt>Price: </dt>
                                                    <dd><fmt:formatNumber type = "number" maxFractionDigits = "1" value = "${dto.price}" /></dd>
                                                </dl>
                                            </figcaption>
                                        </figure> 
                                    </td>
                                    <td> 
                                        <input type="number" class="form-control"  value="${dto.quantity}"  disabled/>
                                    </td>
                                    <td> 
                                        <div class="price-wrap"> 
                                            <var class="price">USD </var> <var class="price" id="price"><fmt:formatNumber type = "number" maxFractionDigits = "1" value = "${dto.quantity*dto.price}" /></var>
                                        </div> <!-- price-wrap .// -->
                                    </td>
                                    <td class="text-center"> 

                                        <br>

                                    </td>

                                </tr>

                            </c:forEach>
                        </tbody>
                    </table>
                </div> 

                <br>
                <div class="row justify-content-around">

                    
                </div>
                <hr>

            </div>
        </c:if>
        <c:if test="${empty productList}">
            <c:redirect url="History"/>
        </c:if>


            <!-- Bootstrap core JavaScript -->
            <script src="${applicationScope.PATHADMIN}/js/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
            <script src="${applicationScope.PATHADMIN}/js/scripts.js"></script>
            <script src="${applicationScope.PATHRESOURCE}/js/jquery-1.12.0.min.js" crossorigin="anonymous"></script>
            <script>

            </script>
        </body>
    </html>




