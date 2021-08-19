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
        <title>Dashboard - Category</title>
        <link href="${applicationScope.PATHADMIN}/css/styles.css" rel="stylesheet" />
        <link href="${applicationScope.PATHADMIN}/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <script src="${applicationScope.PATHADMIN}/js/all.min.js" crossorigin="anonymous"></script>

    </head>
    <body>
        <div id="layoutSidenav">
            <jsp:include page="menu.jsp"/>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h1 class="mt-4">Dashboard</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Subject / Create Subject </li>
                        </ol>

                        <div class="row">
                            <div class="col-xl-6">

                                <form action="CreateCategoryProcess" method="POST" id="formCat">
                                    <small class="text-dark">Category name</small><br>
                                    <input type="text" name="txtCategoryName" placeholder="Category Name" class="form-control form-control-sm" value="${param.txtCategoryName}">

                                    <small class="text-dark">Category Description</small><br>
                                    <textarea class="form-control" name="txtCategoryDes" placeholder="Category description" rows="3" >${param.txtCategoryDes}</textarea><br>
                                    <button type="submit" class="btn btn-primary">Create</button>

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
            $().ready((function () {
                $('#formCat').validate({
                    rules: {
                        txtCategoryName: {
                            required: true,
                            rangelength: [3, 20]
                        },
                        txtCategoryDes: {
                            required: true,
                            rangelength: [0, 150]
                        },
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
                })
            })
                    )
        </script>
    </body>
</html>
