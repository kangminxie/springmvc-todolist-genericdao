<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.kangmin.todolist.util.UrlMappings" %>
<%@ page import="com.kangmin.todolist.util.ModelAttributes" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Item</title>
    <jsp:include page="../frag/_navi_common.jsp"/>
    <jsp:include page="../frag/_style-external-links.jsp"/>
    <link href='<spring:url value="/resources/css/my_common.css"/>' rel="stylesheet" />
</head>
<body>
    <div class="container col-lg-8 col-md-8 col-sm-8 col-xsm-12">
        <div class="tab-pane" id="about" role="tabpanel" aria-labelledby="about-tab">
            <h1>Add a new to do item</h1>
            <hr>
            <!-- check if any error message -->
            <%--@elvariable id="home_error" type="java"--%>
            <c:if test="${!(empty error)}">
                <div class="alert alert-danger col-sm-12" role="alert">
                        <%--@elvariable id="${ModelAttributes.HOME_ERROR}" type="java"--%>
                    <i class="alert">${error}</i>
                </div>
            </c:if>

            <%--@elvariable id="${ModelAttributes.TO_DO_ITEM_DTO}" type="java"--%>
            <%--@elvariable id="draft_item" type="java"--%>
            <form:form class="form-horizontal" method="POST"
                       action="${contextPath}/${UrlMappings.TO_DO_LIST}/add"
                       modelAttribute="${ModelAttributes.TO_DO_ITEM_DTO}">
                <div class="form-group row">
                    <div class="col-sm-6">
                        <label><b>Title</b></label><br>
                        <form:input class="form-control" type="text"
                                    path="title" value="${draft_item.title}"/>
                        <form:errors path="title" cssClass="error" />
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-sm-6">
                        <label><b>Type</b></label><br>
                        <form:select class="form-control" path="type" id="type">
                            <form:options items="${draft_item.typeOptions}" />
                        </form:select>
                        <form:errors path="type" cssClass="error" />
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-sm-6">
                        <label><b>Priority</b></label><br>
                        <form:select class="form-control" path="priority" id="priority">
                            <form:options items="${draft_item.priorityOptions}" />
                        </form:select>
                        <form:errors path="priority" cssClass="error" />
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-sm-6">
                        <label><b>Details</b></label><br>
                        <form:input class="form-control" type="text"
                                    path="detail" value="${draft_item.detail}"/>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-sm-6">
                        <label><b>Due Date</b></label><br>
                        <form:input class="form-control" path="dueDay" type="date" />
                    </div>
                </div>

                <br>
                <div class="form-group row">
                    <div class="col-sm-6">
                        <button type="submit" class="btn btn-success btn-lg" >
                            &nbsp;&nbsp;Confirm Add This Item&nbsp;&nbsp;</button>
                    </div>
                </div>

            </form:form>
        </div>
        <br><br>
    </div>
    <jsp:include page="../frag/_scripts-external-links.jsp"/>
    <jsp:include page="../frag/_footer.jsp"/>
</body>
</html>
