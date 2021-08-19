<%-- 
    Document   : index
    Created on : Dec 1, 2020, 8:26:31 PM
    Author     : sasuk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>RentalCar Homepage</title>

        <!-- Bootstrap core CSS -->
        <link href="${applicationScope.PATHHOME}/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="${applicationScope.PATHHOME}/css/shop-homepage.css" rel="stylesheet">
        <script src="${applicationScope.PATHADMIN}/js/all.min.js" crossorigin="anonymous"></script>

    </head>

    <body>

        <!-- Navigation -->

        <jsp:include page="header.jsp"/>


        <!-- Page Content -->
        <div class="container">
            <br>
            <form action="" id="searchForm" >
                <div class="row">
                    <small class="text-muted">Name</small>
                    <input id="txtSearchName" name="txtSearchName" class="form-control" placeholder="Name of product" value="${param.txtSearchName}" >
                    <br>
                </div>
                <div class="row">
                    <small class="text-muted">Date Rental</small>
                    <div class="input-group">
                        <input id="rentalDate" value="${param.rentalDate}" type="date" class="form-control text-right" name="rentalDate">
                        <input id="returnDate" value="${param.returnDate}" type="date" class="form-control text-right" name="returnDate">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3">
                        <small class="text-muted">Amount</small>
                        <input id="amountCar" value="1" type="number" name="amountCar" class="form-control text-right" placeholder="0"  >
                    </div>
                    <div class="col-md-9">
                        <small class="text-muted">Category</small>
                        <select class="form-control" id="category" name="catId">

                        </select>
                    </div>
                </div>
                <hr>
                <div class="row justify-content-around ">
                    <div clas="col-md-4">
                        <input class="btn btn-primary" type="submit" value="Search Car">

                    </div>
                    <div clas="col-md-3 ">
                        <input id="reset" type="reset" class="btn btn-success" value="Reset"/>
                    </div>
                </div>
            </form>
            <!-- /.row -->
            <div class="col-lg-12">


                <br>
                <div class="row" id="showProduct">

                </div>
                <!-- /.row -->

            </div>
            <div class="row">
                <div class="col-sm-12 col-md-7">
                    <input type="hidden" id="page" name="page" value="1"/>
                    <div id="paper">
                        <ul id="pagination" class="paginaion-sm">
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.container -->

        <!-- Footer -->


        <!-- Bootstrap core JavaScript -->
        <script src="${applicationScope.PATHADMIN}/js/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="${applicationScope.PATHADMIN}/js/scripts.js"></script>
        <script src="${applicationScope.PATHRESOURCE}/js/jquery-1.12.0.min.js" crossorigin="anonymous"></script>
        <script src="${applicationScope.PATHRESOURCE}/js/jquery.validate.min.js"></script>
        <script src="${applicationScope.PATHRESOURCE}/js/additional-methods.min.js"></script>
        <script src="${applicationScope.PATHRESOURCE}/js/jquery.twbsPagination.min.js" crossorigin="anonymous"></script>
        <script src="${applicationScope.PATHRESOURCE}/js/jquery.number.min.js" crossorigin="anonymous"></script>
        <script type="text/javascript">
            let today = new Date();
            document.getElementById("rentalDate").setAttribute('min', addDate(today, 0));
            document.getElementById("rentalDate").setAttribute('value', addDate(today, 0));
            document.getElementById("returnDate").setAttribute('min', addDate(today, 1));
            document.getElementById("returnDate").setAttribute('value', addDate(today, 1));


            $('#reset').click(function () {
                document.getElementById("rentalDate").removeAttribute('readonly');
                document.getElementById("returnDate").removeAttribute('readonly');
            });
            showCategory();
            var rowPerPage = 20;
            var totalPage;
            var rowCount = getDateForPaging();
            var startPage = $('#page').val();

            totalPage = Math.ceil(rowCount / rowPerPage);
            $('#pagination').twbsPagination({
                startPage: parseInt(startPage),
                totalPages: totalPage,
                visiblePages: 5,
                hideOnlyOnePage: true,
                prev: '<span aria-hidden="true">&laquo;</span>',
                next: '<span aria-hidden="true">&raquo;</span>',
                onPageClick: function (event, page) {
                    $("#showProduct").children().remove(),
                            loadAjax(page),
                            $('#page').val(page)
                }

            });

            $().ready(function () {
                $('#searchForm').validate({
                    rules: {
                        rentalDate: {
                            required: true,
                            date: true,
                            max: function () {
                                var returnDate = new Date($("#returnDate").val());
                                return returnDate.toISOString().split("T")[0];
                            }
                        },
                        returnDate: {
                            required: true,
                            date: true,
                            min: function () {
                                var rentalDate = new Date($("#rentalDate").val());
                                return rentalDate.toISOString().split("T")[0];
                            },
                            max: function () {
                                var rentalDate = new Date($("#rentalDate").val());
                                return addDate(rentalDate, 30);
                            }
                        },
                        amountCar: {
                            required: true,
                            number: true,
                            range: [1, 1000000000]
                        },
                        carQuantity: {
                            required: true,
                            range: [0, 10000]
                        },
                        carYear: {
                            required: true,
                            range: [1990, 2021]
                        }

                    },
                    submitHandler: function () {
                        $("#showProduct").children().remove();
                        $('#pagination').twbsPagination('destroy');
                        rowCount = getDateForPaging();
                        if (${not empty sessionScope.TXTRENTALDATE}) {

                            document.getElementById("rentalDate").setAttribute('value', parseDate('${sessionScope.TXTRENTALDATE}'));
                            document.getElementById("returnDate").setAttribute('value', parseDate('${sessionScope.TXTRETURNDATE}'));
                            document.getElementById("rentalDate").setAttribute('readonly', true);
                            document.getElementById("returnDate").setAttribute('readonly', true);
                        }
                        if (rowCount > 0) {
                            totalPage = Math.ceil(rowCount / rowPerPage);
                            $('#pagination').twbsPagination({
                                startPage: parseInt(startPage),
                                totalPages: totalPage,
                                visiblePages: 5,
                                hideOnlyOnePage: true,
                                prev: '<span aria-hidden="true">&laquo;</span>',
                                next: '<span aria-hidden="true">&raquo;</span>',
                                onPageClick: function (event, page) {
                                    $("#showProduct").children().remove(),
                                            loadAjax(page),
                                            $('#page').val(page)
                                }

                            });
                        } else {
                            $('#showProduct').append('<p>Search no result</p>');
                        }
                    }

                });

            }
            );

            function getDateForPaging() {
                var rowCount;
                var data = {};
                data["txtSearchName"] = $('#txtSearchName').val();
                data["rentalDate"] = $('#rentalDate').val();
                data["returnDate"] = $('#returnDate').val();
                data["amountCar"] = ($('#amountCar').val() == "") ? 1 : $('#amountCar').val();
                data["catId"] = $('#category').val();

                $.ajax({
                    type: "GET",
                    url: "${applicationScope.PATHAPI}/PagingSearchRentalCar",
                    data: data,
                    async: false,
                    success: function (data) {
                        rowCount = data.totalCar;
                    }
                });
                return rowCount;
            }

            function addDate(currentDate, day) {
                let date = new Date(currentDate.valueOf());
                date.setDate(date.getDate() + day);
                return date.toISOString().split('T')[0];
            }

            function parseDate(currentDate) {
                var date = new Date(currentDate).toISOString().split('T')[0];
                return date;
            }
            function loadAjax(page) {
                var data = {};
                data['catId'] = $('#category').val();
                data['status'] = 1;
                data['page'] = page;
                data['txtSearchName'] = $('#txtSearchName').val();
                $.ajax({
                    type: "GET",
                    url: "${applicationScope.PATHAPI}/ShowAllCar",
                    data: data,
                    async: true,
                    success: function (data) {

                        if (data != null) {
                            data.forEach(function (item) {
                                var id = item.id;
                                var name = item.name;
                                var color = item.color;
                                var quantity = item.quantity;
                                var price = item.price;
                                var year = item.year;
                                var createDate = item.createDate;
                                var catName = item.catName;
                                $('#showProduct').append('<div class="col-lg-4  mb-4">\n\
                                            <div class="card h-100">\n\
                                            <img class="card-img-top rounded " src="${applicationScope.PATHRESOURCE}/vinfat.jpg" alt="" >\n\
                                            <div class="card-body"> <small class="text-muted">' + createDate + '</small>\n\
                                            <h2 class="card-title">' + name + '-' + year + '</h2>\n\
                                            <h5 class="text-primary"><a href="#">' + catName + '</a></h5>\n\
                                            <h6 class="text-info">' + $.number(price) + ' VND</h6>\n\
                                            <p class="card-text">' + color + '</p>\n\
                                            <span class="text-danger">Quantity: </span><span class="text-danger" id="amountProduct">' + quantity + '</span></div>\n\
                                            <div class="card-footer">\n\
                                                <form action="" method="POST" id="addToCart' + id + '">\n\
                                                <input type="hidden" value="' + id + '" name="id"/>\n\
                                                <div class="row justify-content-around">\n\
                                                    <div class="col-md-4 text-right">\n\
                                                    <input name="amount" type="number" value="1" min="1" max="' + quantity + '" class="form-control text-right  " size="4"/>\n\
                                                </div>\n\
                                                <div class="col-md-7 text-right">\n\
                                                    <button type="button" onclick="addToCart(\'' + id + '\')" class="btn btn-success" >Rent Car</button>\n\
                                                </div>\n\
                                                 </form>\n\
                                            </div>\n\
                                            </div>\n\
                                            </div>\n\
                                            </div>');
                            });
                        }
                    }});

            }
            function showCategory() {
                $.ajax({
                    type: "GET",
                    url: "${applicationScope.PATHAPI}/ShowAllCategory",
                    async: false,
                    success: function (data) {
                        $('#category').append('<option value="0">All</option>');
                        data.forEach(function (item) {
                            var id = item.id;
                            if ($('#catId').val() !== null) {
                                var checked = (id === $('#catId').val()) ? "selected" : "";
                            }

                            $('#category').append('<option value="' + id + '"' + checked + '>' + item.name + '</option>');
                        });

                    }
                });
            }

            function addToCart(carId) {

                var amount = $('#addToCart' + carId).find('input[name="amount"]').val();
                $.ajax({
                    type: "POST",
                    url: "AddToCarProcess",
                    data: {
                        "id": carId,
                        "amount": amount
                    },
                    async: false,
                    success: function (data) {
                        alert(data.message);
                    }
                });
            }
        </script>




    </body>

</html>
