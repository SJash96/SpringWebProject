<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<title>Account</title>
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
		        <a class="nav-link" href="channels">Channels</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="logout">Logout</a>
		      </li>
		    </ul>
		    <div>
		    	<p class="text-right mb-0 mr-2" id="displayDateTime"></p>
		    	<p class="text-right mb-0 mr-2">Logged in as: <a href="account">${session.getAttribute('user').getUsername()}</a></p>
		    </div>
		</div>
	</nav>		
	<h1 class="text-center">Welcome ${session.getAttribute('user').getUsername()}</h1>
	<div class="container">
		<c:url var="url" value="editUser" />
		<form:form modelAttribute="user" method="post" action="${url}">
		  <div class="form-group">
		    <label for="user">Username</label>
		    <form:input path="username" type="text" class="form-control" id="user" placeholder="Username" value="${session.getAttribute('user').getUsername()}" />
		  </div>
		  <div class="form-group">
		    <label for="em">Email</label>
		    <form:input path="email" type="text" class="form-control" id="em" placeholder="Email" value="${session.getAttribute('user').getEmail()}" />
		  </div>
		  <div class="form-group">
		    <label for="num">Phone Number</label>
		    <form:input path="phonenumber" type="text" class="form-control" id="num" placeholder="PhoneNumber (xxx) xxx-xxxx" value="${session.getAttribute('user').getPhonenumber()}" />
		  </div>
		  <div class="form-group">
		    <label for="dob">Date of Birth</label>
		    <form:input path="dateofbirth" type="date" class="form-control" id="dob" value="${session.getAttribute('user').getDateofbirth()}" />
		  </div>
		  <button type="submit" class="btn btn-primary">Edit/Save</button>
		</form:form>
	</div>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value="/scripts/script.js" />"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
</body>
</html>