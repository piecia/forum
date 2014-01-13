<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
    </head>
    <body>
        <!-- 
        Podlaczyc tilesy - http://viralpatel.net/blogs/spring-3-mvc-tiles-plugin-tutorial-example-eclipse/
        -->
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <h1><a href="./">Forum</a></h1>
                    <p class="lead">discussion on any topic</p>
                </div>
                <div class="col-lg-4 panel-body">
                    <div class="btn-group">
                        <a href="./users/new" class="btn btn-default">Sign up</a>
                        <a href="/" class="btn btn-default">Log in</a>
                        <a href="/" class="btn btn-default">About project</a>
                      </div>
                </div>
            </div>
        </div>
        <hr>
        <div class="container">
            <c:forEach var="c" items="${categoryList}">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">${c.name}</h3>
                        </div>
                        <div class="panel-footer">
                            <p>Threads: ${c.topics}</p>
                            <p>Posts: ${c.posts}</p>
                        </div>
                    </div>
            </c:forEach>
        </div>
    </body>
</html>
