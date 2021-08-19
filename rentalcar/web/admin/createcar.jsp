<%-- 
    Document   : createcategory
    Created on : Jan 8, 2021, 10:32:34 AM
    Author     : sasuk
--%>

<%-- 
    Document   : category
    Created on : Jan 7, 2021, 9:44:53 PM
    Author     : sasuk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Dashboard - Create Question</title>
        <link href="${applicationScope.PATHADMIN}/css/styles.css" rel="stylesheet" />
        <script src="${applicationScope.PATHADMIN}/js/all.min.js" crossorigin="anonymous"></script>

    </head>
    <body>

        <jsp:include page="header.html"/>
        <div id="layoutSidenav">
            <jsp:include page="menu.jsp"/>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h1 class="mt-4">Dashboard</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Question/Create Car Rental</li>
                        </ol>

                        <div class="row">
                            <div class="col-xl-10">


                                <form action="CreateCarProcess" method="POST" id="carForm" >
                                    <small class="text-dark">Model</small><br>
                                    <input type="text" name="txtCarId" placeholder="Car model" class="form-control form-control-sm" value="${param.txtCarId}">
                                    
                                    <small class="text-dark">Name</small><br>
                                    <input type="text" name="txtCarName" placeholder="Car name" class="form-control form-control-sm" value="${param.txtCarName}">
                                    
                                    <small class="text-dark">Color</small><br>
                                    <input type="text" name="txtCarColor" placeholder="Car Color" class="form-control form-control-sm" value="${param.txtCarColor}">

                                    
                                    <small class="text-dark">Category</small>
                                    <select class="custom-select" name="catId" id="category">
                                    </select>
                                    <small class="text-dark">Price</small><br>
                                    <input type="number" name="carPrice" placeholder="Rental Price" class="form-control form-control-sm" value="${param.carPrice}" step="0.001">

                                    <small class="text-dark">Quanity</small><br>
                                    <input type="number" name="carQuantity" placeholder="Car Quantity" class="form-control form-control-sm" value="${param.carQuantity}" step="1">
                                    <small class="text-dark">Year</small><br>
                                    <input type="number" name="carYear" placeholder="Car Year" class="form-control form-control-sm" value="${param.carYear}" step="1">


                                    <small class="text-dark">Status</small><br>
                                    <input type="checkbox" name="status"  id="status" disabled="true" checked/>
                                    <label for="status">Active</label><br><br>

                                    <button id="submit" type="submit" class="btn btn-primary">Create Car</button>

                                </form>
                                <br>
                                <div id="message"></div>
                            </div>

                        </div>

                    </div>
                </main>
                <jsp:include page="footer.jsp"/>
            </div>
        </div>
        <script src="${applicationScope.PATHADMIN}/js/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>

        <script src="${applicationScope.PATHADMIN}/js/scripts.js"></script>
        <script src="${applicationScope.PATHRESOURCE}/js/jquery-1.12.0.min.js" crossorigin="anonymous"></script>
        <script src="${applicationScope.PATHRESOURCE}/js/jquery.validate.min.js"></script>
        <script src="${applicationScope.PATHRESOURCE}/js/additional-methods.min.js"></script>
        <script type="text/javascript">
            $.ajax({
                type: "GET",
                url: "${applicationScope.PATHAPI}/ShowAllCategory",
                async: true,
                success: function (data) {

                    data.forEach(function (item) {
                        var id = item.id;

                        var checked = (id === '${param.catId}') ? "selected" : "";
                        $('#category').append('<option value="' + id + '"' + checked + '>' + item.name + '</option>');
                    });

                }
            });


        </script>
        <script type="text/javascript">
            $().ready(function () {
                $('#carForm').validate({
                    rules: {
                        txtCarId: {
                            required: true,
                            rangelength: [3, 10]
                        },
                        txtCarName: {
                            required: true,
                            rangelength: [5, 50]
                        },
                        txtCarColor: {
                            required: true,
                            rangelength: [4, 15]

                        },
                        catId: {
                            required: true,
                            digits: true
                        },
                        carPrice: {
                            required: true,
                            number: true,
                            range: [0, 1000000000]
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
                    submitHandler: function (form) {
                        $.ajax({
                            type: form.method,
                            url: form.action,
                            data: $(form).serialize(),
                            success: function (data) {
                                var status = data.status;
                                var msg = data.message;
                                var classElement = (status <= 0) ? 'p-3 mb-2 bg-danger text-white' : 'p-3 mb-2 bg-success text-white';
                                $('#message').addClass(classElement);
                                $('#message').html(msg);
                            }
                        });
                    }
                });

            }
            );
        </script>
    </body>
</html>
