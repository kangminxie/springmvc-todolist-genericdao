<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
<head>
    <title>About</title>
    <%@ include file="frag/_style-external-links.jsp" %>
    <link href='<spring:url value="/resources/css/my_common.css"/>' rel="stylesheet" />
</head>
<body>
    <%@ include file="frag/_navi_common.jsp" %>
    <header id="main-header" class="mt-0">
        <div class="row">
            <div class="col mt-1 py-2 bg-dark text-center text-white">
                <h1>ToDoList App - About Page</h1>
            </div>
        </div>
    </header>
    <div class="container mt-3 col-lg-8 col-md-8 col-sm-8 col-xsm-12">
        <div class="tab-pane" id="about" role="tabpanel" aria-labelledby="about-tab">
            <h1>About this web application</h1><hr>
            <p>
                Based on Spring MVC Framework -
                    <a href="https://docs.spring.io/spring/docs/5.1.7.RELEASE/javadoc-api/">spring.io</a><br>
                Front-End: JSP/HTML/CSS/
                    <a href="https://getbootstrap.com/docs/4.1/getting-started/introduction/">Bootstrap4</a>
                    /<a href="https://fontawesome.com/icons?d=gallery">Fontawesome</a><br>
                Back-End: MySQL-JDBC/<a href="http://www.jeffeppinger.com/GenericDAO/">GenericDAO</a><br>
                Version: 1.02 (updated on Oct-2019)<br>
            </p>
            <div>
                Basic Features:
                <ul>
                    <li>Incorporated with Spring Security, BCrypt Password Encoder</li>
                    <li>Single/Multiple level Authority Support</li>
                </ul>
            </div>
            <div>
                <p class="btn btn-success" data-toggle="collapse" data-target="#implementedList">
                    -> Actions/Functions implemented
                </p>
                <div id="implementedList" class="collapse show">
                    <ul>
                        <li>User Register and Admin Register</li>
                        <li>Edit Information</li>
                        <li>Change Password</li>
                        <li>Login/logout incorporated with Spring Security</li>
                        <li>Regex Form Validation, Spring Form Anti-CSRF Token</li>
                        <li>Adding NewToDoItem in situ</li>
                        <li>Able to put three-party .jar to Maven</li>
                        <li>Use self-configured checkstyle and suppression for Java style check</li>
                        <li>
                            Contact Page - Google Map Implementation
                            <a href="https://developers.google.com/maps/documentation/javascript/examples/places-placeid-finder">
                                Find placeId by Address
                            </a>
                        </li>
                        <li>Support Chinese Characters</li>
                    </ul>
                </div>
            </div>
            <div>
                <p class="btn btn-warning" data-toggle="collapse" data-target="#tobeImpleList">
                    -> Actions/Functions to be implemented
                </p>
                <div id="tobeImpleList" class="collapse in">
                    <ul>
                        <li>Password Reset</li>
                        <li>Flash message can be closed</li>
                        <li>Add friends</li>
                        <li>Error message for date</li>
                    </ul>
                </div>
            </div>

            <p class="btn btn-info" data-toggle="collapse" data-target="#utilities">
                -> Library Utilities
            </p>
            <div id="utilities" class="collapse in">
                <ul>
                    <li>tomcat 8.5.23 as container</li>
                    <li>mysql + genericdao 3.0.2</li>
                    <li>jstl 1.1.2</li>
                    <li>Bootstrap 4.2</li>
                    <li>Font-awesome v5</li>
                </ul>
            </div>
        </div>
    </div>
    <%@ include file="frag/_scripts-external-links.jsp" %>
    <%@ include file="frag/_footer_pre.jsp" %>
    <%@ include file="frag/_footer.jsp" %>
</body>
</html>
