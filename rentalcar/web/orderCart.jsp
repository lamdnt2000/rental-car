<%-- 
    Document   : orderCart
    Created on : Jan 19, 2021, 10:42:16 PM
    Author     : sasuk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Car Rental Order </title>
        <!-- Custom styles for this template -->
        <link href="${applicationScope.PATHHOME}/css/shop-homepage.css" rel="stylesheet">
        <!-- Bootstrap core CSS -->
        <link href="${applicationScope.PATHHOME}/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


        <script src="${applicationScope.PATHADMIN}/js/all.min.js" crossorigin="anonymous"></script>
    </head>
    <body>

        <jsp:include page="header.jsp"/>


        <br>
        <div class="container">

            <c:if test="${not empty sessionScope.PRODUCTCART}">
                <c:set var="cartResult" value="${sessionScope.PRODUCTCART}"/>
                <c:if test="${not empty cartResult}">
                    
                    <c:set var="cartItem" value="${cartResult.items}"/>
                    <c:if test="${not empty cartItem}">
                        <c:set var="totalCart" value="${cartResult.totalPrice}"/>
                        <form action="" method="POST" id="orderForm">
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
                                        <c:forEach var="dto" items="${cartItem}">

                                            <tr>
                                                <td>
                                                    <figure class="media">
                                                        <div class="img-wrap"><img src="${applicationScope.PATHRESOURCE}/vinfat.jpg" class="img-thumbnail" width="150px" height="150px"></div>
                                                        <figcaption class="media-body">
                                                            <h6 class="title text-truncate">${dto.key.name}</h6>
                                                            <dl class="param param-inline small">
                                                                <dt>Category: </dt>
                                                                <dd>${dto.key.catName}</dd>
                                                            </dl>
                                                            <dl class="param param-inline small">
                                                                <dt>Price: </dt>
                                                                <dd><fmt:formatNumber type = "number" maxFractionDigits = "1" value = "${dto.key.price*dto.key.sale}"/></dd>
                                                            </dl>
                                                        </figcaption>
                                                    </figure> 
                                                </td>
                                                <td> 
                                                    <input type="number" class="form-control text-right" id="quantity${dto.key.id}" name="quantity${dto.key.id}" value="${dto.value}"  min="1" max="999999"/>
                                                    <input type="hidden" name="pk" value="${dto.key.id}"/>
                                                </td>
                                                <td> 
                                                    <div class="price-wrap"> 
                                                        <var class="price" id="price"><fmt:formatNumber type = "number" maxFractionDigits = "1" value = "${dto.key.price*dto.value*dto.key.sale}" /></var><var class="price"> VND</var> 
                                                    </div> <!-- price-wrap .// -->
                                                </td>
                                                <td class="text-center"> 
                                                    <input type="checkbox" class="form-control" name="id" value="${dto.key.id}"  />
                                                    <br>

                                                </td>

                                            </tr>

                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div> 

                            <br>
                            <div class="row justify-content-around">

                                <div clas="col-md-5 ">
                                    <button class="btn btn-danger" type="submit" id="delete" onclick="this.form.action = 'DeleteCartProcess'" disabled="true">Delete</button>
                                </div>
                                <div class="col-md-2">
                                    <input type="checkbox" class="form-control" id="checkAll" />
                                </div>
                            </div>
                            <hr>
                            <div class="row justify-content-end">
                                <div clas="col-md-5" id="total">
                                    Total:
                                    <strong class="text-danger" ><fmt:formatNumber type = "number" maxFractionDigits = "1" value = "${totalCart*sessionScope.DAYRENT}" /></strong>
                                </div>
                                <div clas="col-md-7 ">
                                    <button class="btn btn-primary" type="submit" onclick="this.form.action = 'UpdateCartAmountProcess'" >Update</button>
                                    <button class="btn btn-success" type="submit" onclick="this.form.action = 'CheckOutCartProcess'">Check Out</button>

                                </div>

                            </div>
                            <hr>
                            <div class="row justify-content-end">
                                <c:set var="code" value="${sessionScope.CODE}"/>
                                <p id="messageCode"><c:if test="${not empty code}">${code.title}</c:if><c:if test="${empty code}">No Code</c:if></p>
                                    <div class="col-md-2">
                                            <input oninput="OnInput(event)" class="form-control" name="code" placeholder="<c:if test="${not empty code}">${code.id}</c:if>" />
                                    </div>
                                    <div class="col-md-3">
                                        <button id="btnDiscount" class="btn btn-success" type="submit" onclick="this.form.action = 'AddDiscountCodeProcess'" disabled>Add Code</button>
                                    </div>

                                </div>
                                <br>
                            <c:if test="${not empty requestScope.ERROR}">
                                <div id="message" class="p-3 mb-2 bg-danger text-white">
                                    ${requestScope.ERROR}
                                </div>
                            </c:if>
                                <c:if test="${not empty requestScope.SUCCESS}">
                                <div id="message" class="p-3 mb-2 bg-success text-white">
                                    ${requestScope.SUCCESS}
                                </div>
                            </c:if>
                        </form>

                    </c:if>
                </c:if>
            </c:if>
            <c:if test="${empty sessionScope.PRODUCTCART}">
                <p class="font-weight-bold">No Cart.</p>
            </c:if>


        </div>
        <br>


        <!-- Bootstrap core JavaScript -->
        <script src="${applicationScope.PATHADMIN}/js/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="${applicationScope.PATHADMIN}/js/scripts.js"></script>
        <script src="${applicationScope.PATHRESOURCE}/js/jquery-1.12.0.min.js" crossorigin="anonymous"></script>
        <script src="${applicationScope.PATHRESOURCE}/js/jquery.validate.min.js"></script>
        <script src="${applicationScope.PATHRESOURCE}/js/additional-methods.min.js"></script>
        <script>
                                            function getCheck() {
                                                var flag = false;
                                                $('input[type=checkbox]').each(function () {
                                                    if ($(this).is(':checked')) {
                                                        flag = true;   // Set flag
                                                        return true; // Stop iterating
                                                    }
                                                });
                                                return flag;
                                            }
                                            $(document).ready(function () {
                                                $("#checkAll").click(function () {
                                                    if ($("#checkAll").is(':checked')) {
                                                        $("input[type=checkbox]").each(function () {
                                                            $(this).prop("checked", true);
                                                        });
                                                        $('#delete').prop('disabled', false);
                                                    } else {
                                                        $("input[type=checkbox]").each(function () {
                                                            $(this).prop("checked", false);
                                                        });
                                                        $('#delete').prop('disabled', true);
                                                    }
                                                });
                                            });
                                            $("input[type=checkbox]").click(function () {

                                                if (getCheck()) {
                                                    $('#delete').prop('disabled', false);
                                                } else {
                                                    $('#delete').prop('disabled', true);
                                                }
                                            });

                                            function OnInput(event) {

                                                if (event.target.value.length === 5) {
                                                    $.ajax({
                                                        type: "GET",
                                                        url: "CheckValidCodeProcess",
                                                        data: {"code": $('input[name="code"]').val()},
                                                        async: false,
                                                        success: function (data) {
                                                            console.log(data);
                                                            $("#messageCode").removeClass();
                                                            $("#messageCode").text("");
                                                            $("#btnDiscount").attr("disabled", true);
                                                            var status = data.status;
                                                            var msg = data.message;
                                                            $("#messageCode").text(msg);
                                                            if (status < 1) {
                                                                $("#messageCode").addClass("text-danger");
                                                            } else {
                                                                $("#messageCode").addClass("text-success");
                                                                $("#btnDiscount").attr("disabled", false);
                                                            }
                                                        }
                                                    });
                                                } else {
                                                    $("#messageCode").text("No code");
                                                    $("#messageCode").removeClass();
                                                    $("#btnDiscount").attr("disabled", true);
                                                }
                                            }
                                            $('#btnDiscount').click(
                                                    function () {

                                                    });
        </script>
    </body>
</html>




