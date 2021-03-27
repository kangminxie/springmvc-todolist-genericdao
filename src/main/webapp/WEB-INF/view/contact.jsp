<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
<head>
    <title>Contact</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <%@ include file="frag/_style-external-links.jsp" %>
    <link href='<spring:url value="/resources/css/my_common.css"/>' rel="stylesheet" />
</head>
<body>
    <%@ include file="frag/_navi_common.jsp" %>
    <!-- CONTACT HEADER -->
    <header id="main-header" class="mt-0">
        <div class="row">
            <div class="col mt-1 py-2 bg-dark text-center text-white">
                <h1>ToDoList App - Contact Page</h1>
            </div>
        </div>
    </header>
    <!-- CONTACT SECTION -->
    <section id="contact" class="py-3">
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <section>
                        <div class="row">
                            <div class="card card-body text-white pb-2 mx-3 mt-2" style="background-color: #286ABA;">
                                <h2>Contact Me</h2>
                            </div>
                        </div>
                        <div class="card card-body py-3">
                            <h3>Send me a message</h3>
                            <p>Usually I will reply within 24 - 48 hours.</p>
                            <form>
                                <div class="form-group">
                                    <div class="input-group input-group-lg">
                                        <div class="input-group-prepend">
                      <span class="input-group-text">
                        <i class="fas fa-user"></i>
                      </span>
                                        </div>
                                        <input type="text" class="form-control" placeholder="Name">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="input-group input-group-lg">
                                        <div class="input-group-prepend">
                      <span class="input-group-text">
                        <i class="fas fa-envelope"></i>
                      </span>
                                        </div>
                                        <input type="email" class="form-control" placeholder="Email">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="input-group input-group-lg">
                                        <div class="input-group-prepend">
                      <span class="input-group-text">
                        <i class="fas fa-pencil-alt"></i>
                      </span>
                                        </div>
                                        <textarea class="form-control" placeholder="Message"></textarea>
                                    </div>
                                </div>

                                <input type="submit" value="Submit" class="btn btn-warning btn-block btn-lg">
                            </form>
                        </div>
                    </section>
                </div>
                <div class="col-md-4 p-2">
                    <div class="card p-2">
                        <!--               <div class="card-header">
                                      </div> -->
                        <!-- Address -->
                        <div class="card-body">
                            <div>
                                <address>
                                    <strong>Kangmin Xie</strong><br>
                                    <a href="mailto:#">kangmin.xie at gmail.com</a><br>
                                </address>
                                <address>
                                    <strong>Carnegie Mellon University</strong><br>
                                    5000 Forbes Avenue<br>
                                    Pittsburgh, Pennsylvania 15213<br>
                                    United States
                                </address>
                            </div>
                            <!-- Map -->
                            <div class="map">
                                <iframe width="280" height="220" style="border:0"
                                        src="https://www.google.com/maps/embed/v1/place?q=place_id:ChIJkZqj4iPyNIgRkRiPR6mXTt4&key=[API_KEY]" allowfullscreen>
                                </iframe>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="row">
        <br/><br/>
    </div>
    <%@ include file="frag/_scripts-external-links.jsp" %>
    <%@ include file="frag/_footer_pre.jsp" %>
    <%@ include file="frag/_footer.jsp" %>
</body>
</html>
