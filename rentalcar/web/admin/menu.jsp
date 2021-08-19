<%-- 
    Document   : menu
    Created on : Nov 28, 2020, 11:52:39 PM
    Author     : sasuk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<div id="layoutSidenav_nav">
    
    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
            <div class="nav">
                <div class="nav-tabs"><p class="text-info">Welcome,  ${sessionScope.RESULTLOGIN.name} </p></div>

                <div class="sb-sidenav-menu-heading">Manage Category</div>
                <a class="nav-link" href="ShowCategory">
                    <div class="sb-nav-link-icon"></div>
                    Category
                </a>
                <a class="nav-link" href="CreateCategory">
                    <div class="sb-nav-link-icon"></div>
                    Create Category
                </a>


                <div class="sb-sidenav-menu-heading">Manage Car</div>
                <a class="nav-link" href="CreateCar">
                    <div class="sb-nav-link-icon"></div>
                    Create Car
                </a>
                <a class="nav-link" href="ShowCar">
                    <div class="sb-nav-link-icon"></div>
                    Car
                </a>
                <div class="sb-sidenav-menu-heading">Setting</div>
                <a class="nav-link" href="LogoutProcess">
                    <div class="sb-nav-link-icon"></div>
                    Log out
                </a>
            </div>
        </div>
        
    </nav>
</div>