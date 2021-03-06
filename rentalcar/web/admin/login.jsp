<%-- 
    Document   : login
    Created on : Jan 7, 2021, 7:22:15 PM
    Author     : sasuk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Login Page</title>
        <link href="${applicationScope.PATHADMIN}/css/styles.css" rel="stylesheet" />
        <script src="${applicationScope.PATHADMIN}/js/all.min.js" crossorigin="anonymous"></script>
    </head>

    <body class="bg-primary">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">Login</h3></div>
                                    <div class="card-body">
                                        <form action="LoginProcess" method="POST" id="loginForm">
                                            <div class="form-group">
                                                <label class="small mb-1" for="inputEmailAddress">Email</label>
                                                <input class="form-control py-4" name="txtEmail" id="inputEmailAddress" type="text" placeholder="Enter email" />
                                            </div>
                                            <div class="form-group">
                                                <label class="small mb-1" for="inputPassword">Password</label>
                                                <input class="form-control py-4" name="txtPassword" id="inputPassword" type="password" placeholder="Enter password" />
                                            </div>
                                            <div class="form-group">
                                                <div class="custom-control custom-checkbox">
                                                    <input class="custom-control-input" id="rememberPasswordCheck" type="checkbox" />
                                                    <label class="custom-control-label" for="rememberPasswordCheck">Remember password</label>
                                                </div>
                                            </div>
                                            <div class="form-group d-flex align-items-center justify-content-center ">

                                                <button type="submit" value="LOGIN" class="btn btn-primary">Login</button>
                                            </div>
                                            <div id="message">
                                                <c:set var="errorActive" value="${requestScope.ERRORACTIVE}"/>

                                                <c:if test="${not empty errorActive}">
                                                    <div class="p-3 mb-2 bg-danger text-white">${errorActive}</div>
                                                </c:if>
                                            </div>
                                            <div id="capcha" class="g-recaptcha" data-sitekey="6LddPnQaAAAAAF_GRI0qbx16EyOcn187n0F_dH5Z"></div>
                                            <br>
                                        </form>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <div id="layoutAuthentication_footer">
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2021</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="${applicationScope.PATHADMIN}/js/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="${applicationScope.PATHADMIN}/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="${applicationScope.PATHADMIN}/js/scripts.js"></script>
        <script src="${applicationScope.PATHRESOURCE}/js/jquery-1.12.0.min.js" crossorigin="anonymous"></script>
        <script src="${applicationScope.PATHRESOURCE}/js/jquery.validate.min.js"></script>
        <script src="${applicationScope.PATHRESOURCE}/js/additional-methods.min.js"></script>
        <script src='https://www.google.com/recaptcha/api.js'></script>
        <script type="text/javascript">
            $().ready((function () {
                $('#loginForm').validate({
                    rule: {

                    },
                    submitHandler: function (form) {
                        $.ajax({
                            type: form.method,
                            url: form.action,
                            data: $(form).serialize(),
                            success: function (data) {
                                var status = data.status;
                                var msg = data.message;
                                if (status <= 0) {
                                    $('#message').addClass('p-3 mb-2 bg-danger text-white');
                                    $('#message').html(msg);
                                } else {
                                    window.location.href = msg;
                                }

                            }
                        });
                    },

                })
            })
                    )

        </script>

    </body>
</html>
