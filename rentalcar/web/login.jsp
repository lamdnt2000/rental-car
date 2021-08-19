<%-- 
    Document   : login
    Created on : Jan 6, 2021, 1:03:29 PM
    Author     : sasuk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Sign In</title>
        <link href="/rentalcar/resource/home/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
    </head>

    <!------ Include the above in your HEAD tag ---------->




    <br><br><br>

    <div class="container">

        <div class="row justify-content-md-center">

            <aside class="col-sm-5 ">


                <div class="card">
                    <article class="card-body">
                        <a href="Signup" class="float-right btn btn-outline-primary">Sign up</a>
                        <h4 class="card-title mb-5 mt-2 float-left">Sign in</h4>


                        <form action="LoginProcess" method="POST" id="loginForm">
                            <div class="form-group">
                                <input name="txtEmail" class="form-control" placeholder="Email" type="text">
                            </div> <!-- form-group// -->
                            <div class="form-group">
                                <input name="txtPassword" class="form-control" placeholder="******" type="password">
                            </div> <!-- form-group// -->   

                            <hr>
                            <div id="message">
                                <c:set var="errorActive" value="${requestScope.ERRORACTIVE}"/>

                                <c:if test="${not empty errorActive}">
                                    <div class="p-3 mb-2 bg-danger text-white">${errorActive}</div>
                                </c:if>
                            </div>
                            <div id="capcha" class="g-recaptcha" data-sitekey="6LddPnQaAAAAAF_GRI0qbx16EyOcn187n0F_dH5Z"></div>
                            <br>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-primary btn-block">Login</button>
                                    </div> <!-- form-group// -->
                                </div>
                            </div> <!-- .row// -->                                                                  
                        </form>
                    </article>
                </div> <!-- card.// -->

            </aside> <!-- col.// -->

        </div> <!-- row.// -->

    </div> 
    <!--container end.//-->

    <br><br><br>

    <script src="/rentalcar/resource/home/vendor/jquery/jquery.min.js"></script>
    <script src="/rentalcar/resource/home/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="/rentalcar/resource/js/jquery-1.12.0.min.js" crossorigin="anonymous"></script>
    <script src="/rentalcar/resource/js/jquery.validate.min.js"></script>
    <script src="/rentalcar/resource/js/additional-methods.js"></script>
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
                            console.log(data);
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
</html>
