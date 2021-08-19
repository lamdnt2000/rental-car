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
        <title>Dashboard - Question</title>
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
                            <li class="breadcrumb-item active">Question/ Show Car</li>
                        </ol>
                        <div id="message"></div>
                        <div class="row" >
                            <div class="col-md-12">
                                <form action="" >
                                    <div class="row">
                                        <div class="col-md-12">
                                            <input name="txtSearchName" class="form-control" placeholder="Search Name" id="txtSearch" value="${param.txtSearchName}"/>
                                        </div>
                                    </div>
                                    <br>
                                    <div class="row">

                                        <div class="col-md-3">
                                            <select class="custom-select" name="catId" id="category">

                                            </select>
                                        </div>
                                        <div class="col-md-3">
                                            <select class="custom-select" name="status" id="status">
                                                <option value="1"
                                                        <c:if test="${param.status.equals('1')}">selected</c:if>
                                                            >Active</option>
                                                        <option value="0" 
                                                        <c:if test="${param.status.equals('0')}">selected</c:if>
                                                            >Disable</option>

                                                </select>                                       
                                            </div>
                                            <div class="col-md-3 justify-content-end">
                                                <button type="submit" class="btn btn-primary" onclick="this.form.action = 'ShowCar'">Search</button>
                                            </div>
                                            <div class="col-md-3">
                                                <button type="button" class="btn btn-danger" id="deleteBtn" data-toggle="modal" data-target="delete">Delete</button>
                                            </div>
                                            <br>
                                        </div>

                                        <div class="row"></br></div>
                                        <div class="row">

                                            <div class="table-responsive">


                                                <table id="mytable" class="table table-bordred table-striped">

                                                    <thead>

                                                    <th><input type="checkbox" id="checkall" /></th>
                                                    <th>Model</th>
                                                    <th>Name</th>
                                                    <th>Price</th>
                                                    <th>Quantity</th>
                                                    <th>Color</th>
                                                    <th>Date create</th>
                                                    <th>Action</th>
                                                    </thead>
                                                    <tbody id="mainBody">


                                                    </tbody>

                                                </table>



                                            </div>
                                        </div>
                                    </form> 

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
                            </div>

                        </div>

                    </main>

                <jsp:include page="footer.jsp"/>
            </div>

        </div>
        <script src="${applicationScope.PATHADMIN}/js/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="${applicationScope.PATHADMIN}/js/scripts.js"></script>
        <script src="${applicationScope.PATHRESOURCE}/js/jquery-1.12.0.min.js" crossorigin="anonymous"></script>
        <script src="${applicationScope.PATHRESOURCE}/js/jquery.twbsPagination.min.js" crossorigin="anonymous"></script>
        <Script>
                                                    $(document).ready(function () {
                                                        $("#mytable #checkall").click(function () {
                                                            if ($("#mytable #checkall").is(':checked')) {
                                                                $("#mytable input[type=checkbox]").each(function () {
                                                                    $(this).prop("checked", true);
                                                                });

                                                            } else {
                                                                $("#mytable input[type=checkbox]").each(function () {
                                                                    $(this).prop("checked", false);
                                                                });
                                                            }
                                                        });
                                                    });
        </script>

        <script type="text/javascript">
            $.ajax({
                type: "GET",
                url: "${applicationScope.PATHAPI}/ShowAllCategory",
                async: false,
                success: function (data) {
                    $('#category').append('<option value="0">All</option>');
                    data.forEach(function (item) {
                        var id = item.id;
                        if ($('#category').val()!=null) {
                            var checked = (id === $('#category').val()) ? "selected" : "";
                        }
                        $('#category').append('<option value="' + id + '"' + checked + '>' + item.name + '</option>');
                    });

                }
            });

        </script>

        <script>
            var catId = $('#category').val();
            var statusParam = $('#status').val();
            var rowCount;
            var searchTitleParam = $('#txtSearch').val();
            var dataGet = {};
            dataGet['catId'] = catId;
            dataGet['status'] = statusParam;
            dataGet['txtSearchName'] = searchTitleParam;
            $.ajax({
                type: "GET",
                url: "${applicationScope.PATHAPI}/GetDataForPaging",
                data: dataGet,
                async: false,
                success: function (data) {
                    rowCount = data.totalCar;
                }
            });

            var startPage = $('#page').val();
            var rowPerPage = 20;
            var totalPage = Math.ceil(rowCount / rowPerPage);
            $('#pagination').twbsPagination({
                startPage: parseInt(startPage),
                totalPages: totalPage,
                visiblePages: rowPerPage,

                hideOnlyOnePage: true,
                prev: '<span aria-hidden="true">&laquo;</span>',
                next: '<span aria-hidden="true">&raquo;</span>',
                onPageClick: function (event, page) {
                    $("tbody").children().remove(),
                            loadAjax(page),
                            $('#page').val(page)
                }

            });
            function loadAjax(page) {
                var data = {};
                data['catId'] = catId;
                data['status'] = statusParam;
                data['page'] = page;
                data['txtSearchName'] = searchTitleParam;
                $.ajax({
                    type: "GET",
                    url: "${applicationScope.PATHAPI}/ShowAllCar",
                    data: data,
                    async: true,
                    success: function (data) {
                        if (data != null) {
                            data.forEach(function (item) {
                                var model = item.id;
                                var name = item.name;
                                var color = item.color;
                                var quantity = item.quantity;
                                var price = item.price;
                                var createDate = item.createDate;
                                $('tbody').append('<tr>')
                                        .append('<td><input type="checkbox" class="checkthis" name="carId" value="' + model + '" /></td>')
                                        .append('<td>' + model + '</td>')
                                        .append('<td>' + name + '</td>')
                                        .append('<td>' + price + '</td>')
                                        .append('<td>' + quantity + '</td>')
                                        .append('<td>' + color + '</td>')
                                        .append('<td>' + createDate + '</td>')
                                        .append('<td><a class="btn btn-primary" href="GetCarProcess?id=' + model + '&catId=' + item.catId + '&status=' + statusParam + '&txtSearchName=' + searchTitleParam + '">Update</a></td>')
                                        .append('</tr>');
                            });

                        }
                    }
                });
            }


            $('#deleteBtn').click(function () {
                var questionId = [];
                $("#mytable td input:checked").each(function ()
                {
                    questionId.push($(this).val());
                });

                $.ajax({
                    type: "POST",
                    url: "DeleteQuestionProcess",
                    cache: false,
                    data: {questionId: questionId,
                        subjectId: subjectIdParam},
                    success: function (data) {
                        var status = data.status;
                        var msg = data.message;
                        var classElement = (status <= 0) ? 'p-3 mb-2 bg-danger text-white' : 'p-3 mb-2 bg-success text-white';
                        $('#message').addClass(classElement);
                        $('#message').html(msg);

                    }
                });
                setTimeout(location.reload(), 3000);
            });
        </script>
    </body>
</html>
