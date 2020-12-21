<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<title>Register</title>
</head>
<body>
	
	<c:url value="/" var="welcomUrl"/>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand" href="${welcomUrl}">My Blogger</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item">
	        <a class="nav-link" href="${welcomUrl}">Home</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="login">Login</a>
	      </li>
	      <li class="nav-item active">
	        <a class="nav-link" href="register">Register<span class="sr-only">(current)</span></a>
	      </li>
	    </ul>
	    <div>
			<p class="text-right mb-0 mr-2" id="displayDateTime"></p>
		</div>
	  </div>
	</nav>
	<div class="container">
	<h1>${registerMessage}</h1>
	<c:url var="url" value="addUser" />
	<form:form modelAttribute="user" method="post" action="${url}">
	  <div class="form-group">
	    <label for="exampleInputEmail1">Username</label>
	    <form:input path="username" type="text" class="form-control" id="exampleInputEmail1" placeholder="Enter username" />
	  </div>
	  <div class="form-group">
	    <label for="exampleInputPassword1">Password</label>
	    <form:input path="password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password" />
	  </div>
	  <button type="submit" class="btn btn-primary">Submit</button>
	</form:form>
	<h2>${userCreateMessage}</h2>
	</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="<c:url value="/scripts/script.js" />"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
</body>
</html>