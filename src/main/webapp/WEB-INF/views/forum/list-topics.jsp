<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${topicList.iterator().next().category.name}</title>
        <link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
        <link rel="stylesheet" href="<c:url value="/resources/css/style.css" />" />
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-lg-7">
                    <h1><a href="${contextPath}">Forum</a></h1>
                    <p class="lead">discussion on any topic</p>
                </div>
                <div class="col-lg-5 panel-body">
                    <div class="btn-group panel-right">
                        <security:authorize access="hasAnyRole('USER','ADMIN')">
                            <ul class="nav nav-pills">
                                <li class="active"><a href="${contextPath}/user/profile"><span class="glyphicon glyphicon-info-sign"></span> Profile</a></li>
                                <li class="active"><a href="${contextPath}/user/settings"><span class="glyphicon glyphicon-briefcase"></span> Settings</a></li>
                                <li class="active"><a href="${contextPath}/user/messages"><span class="glyphicon glyphicon-envelope"></span> Messages<span class="badge">3</span></a></li>
                                <li><a href="${contextPath}/j_spring_security_logout"><span class="glyphicon glyphicon glyphicon-off"></span></a></li>
                            </ul>
                        </security:authorize>
                        <security:authorize access="isAnonymous()">
                            <a href="${contextPath}/signup" class="btn btn-default">Sign up</a>
                            <a href="${contextPath}/login" class="btn btn-default">Log in</a>
                            <a href="${contextPath}/about-project" class="btn btn-default">About project</a>
                        </security:authorize>
                    </div>
                </div>
            </div>
        </div>
        <hr>
        <div class="container">
            <ol class="breadcrumb">
                <li><small><a href="${contextPath}">Home</a></small></li>
                <li class="active"><small>${topicList.iterator().next().category.name} category</small></li>
            </ol>
        </div>
        <div class="container">
            <h2>Forum: <span>${topicList.iterator().next().category.name}</span></h2>
            <p><small>${topicList.iterator().next().category.description}</small></p>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Started by</th>
                        <th>Replies</th>
                        <th>Last post by</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="t" items="${topicList}">
                        <tr>
                            <td>
                                <p>
                                    <a href="${contextPath}/topic/${t.titleSeo}">${t.title}</a> 
                                    <c:if test="${t.lastPost.getTime() > sevenDaysBack}">
                                        <span class="label label-danger">New</span>
                                    </c:if>
                                </p>
                            </td>
                            <td><p><a href="${contextPath}/user/profile/${t.author.login}">${t.author.login}</a></p></td>
                            <td><p>${t.posts}</p></td>
                            <td>
                                <p>
                                    <small>
                                        <c:choose>
                                            <c:when test="${empty t.lastPost}">
                                                <fmt:formatDate value="${t.startDate}" pattern="dd/MM/yyyy HH:mm"/>, <a href="${contextPath}/user/profile/${t.author.login}">${t.author.login}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatDate value="${t.lastPost}" pattern="dd/MM/yyyy HH:mm"/>, <a href="${contextPath}/user/profile/${t.lastPoster.login}">${t.lastPoster.login}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </small>
                                </p>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <security:authorize access="hasAnyRole('USER','ADMIN')">
                <h3>Create new thread</h3>
                <form:form method="post" modelAttribute="threadForm">
                    <div class="form-group">
                        <label for="title">Title</label>
                        <form:input path="title" cssClass="form-control" />
                        <form:errors path="title">
                            <div class="alert alert-danger"><form:errors path="title" htmlEscape="false" /></div>
                        </form:errors>
                    </div>
                    <div class="form-group">
                        <label for="description">Content</label>
                        <form:textarea path="description" placeholder="click to write a message" cssClass="form-control" />
                        <form:errors path="description">
                            <div class="alert alert-danger"><form:errors path="description" htmlEscape="false" /></div>
                        </form:errors>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-default">Submit</button>
                    </div>
                </form:form>
            </security:authorize>
        </div>
        <hr>
        <footer>
            <div class="container">
                <p class="text-right"><small>©2014 <a href="https://github.com/piecia">Piotr Baran</a> - <a href="https://github.com/piecia/forum">Code</a></small></p>
            </div>
        </footer>
    </body>
</html>
