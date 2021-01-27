<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<title>Channels</title>
</head>
<body>
	<c:if test ="${session != null && session.getAttribute('user') != null}">
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
			      <li class="nav-item active">
			        <a class="nav-link" href="channels">Channels<span class="sr-only">(current)</span></a>
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
		<h6>${channelCreateMessage}</h6>		
		<div class="container">
			<c:url var="url" value="createChannel" />
			<form:form modelAttribute="channel" method="post" action="${url}">
		  		<div class="form-group">
		    		<label for="ChannelName">Channel Name</label>
		    		<form:input path="channelname" type="text" class="form-control" id="ChannelName" placeholder="Enter channel name..." />
		  		</div>
		  		<div class="form-group">
		    		<label for="ChannelDescription">Description</label>
		    		<form:input path="channeldescription" class="form-control" id="ChannelDescription" />
		  		</div>
		  		<div class="form-group">
		    		<label for="ChannelCategories">Category</label>
		    		<form:select path="channelcategory" items="${channel.channelcategories}" class="form-control" id="ChannelCategories" />
		  		</div>
		  		<div class="text-center">
		  			<button type="submit" class="btn btn-light">Create Channel</button>
		  		</div>
			</form:form>
		</div>
		<div class="container-fluid">
			<c:forEach items="${listofchannels}" var="channelList">
				<div class="row mt-4 mx-2">
					<c:forEach items="${channelList}" var="channel">
						<div class="col-md-3">
							<div class="card">
								<div class="card-body text-muted">
									<span class="badge badge-secondary">${channel.getChannelcategory()}</span>
									<br>
									Posted by <b>${channel.getUser().getUsername()}</b>
									on <fmt:formatDate pattern="MMMM dd yyyy hh:mm a z" value="${channel.getChannelcreated()}" />
								</div>
	    						<div class="card-body">
		    						<h5 class="card-title">${channel.getChannelname()}</h5>
									<p class="card-text">${channel.getChanneldescription()}</p>
	    						</div> 
	    						<a href="viewChannel?channel_id=${channel.getCid()}" class="stretched-link"></a> 						
	    					</div>
						</div>
					</c:forEach>
				</div>	
    		</c:forEach>
		</div>
	</c:if>
	<c:if test ="${session == null || session.getAttribute('user') == null}">
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
			      <li class="nav-item active">
			        <a class="nav-link" href="channels">Channels<span class="sr-only">(current)</span></a>
			      </li>
			      <li class="nav-item">
		        	<a class="nav-link" href="login">Login</a>
		      	  </li>
		      	  <li class="nav-item">
		        	<a class="nav-link" href="register">Register</a>
		      	  </li>
			    </ul>
			    <form class="form-inline my-2 my-lg-0">
      				<input id="searchBar" class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
    			</form>
			    <div>
			    	<p class="text-right mb-0 mr-2" id="displayDateTime"></p>
			    </div>
			</div>
		</nav>
		<div class="container-fluid">
			<c:forEach items="${listofchannels}" var="channelList">
				<div class="row mt-4 mx-2">
					<c:forEach items="${channelList}" var="channel">
						<div class="col-md-3">
							<div class="card">
								<div class="card-body text-muted">
									<span class="badge badge-secondary">${channel.getChannelcategory()}</span>
									<br>
									Posted by <b>${channel.getUser().getUsername()}</b>
									on <fmt:formatDate pattern="MMMM dd yyyy hh:mm a z" value="${channel.getChannelcreated()}" />
								</div>
	    						<div class="card-body">
		    						<h5 class="card-title">${channel.getChannelname()}</h5>
									<p class="card-text">${channel.getChanneldescription()}</p>
	    						</div> 
	    						<a href="viewChannel?channel_id=${channel.getCid()}" class="stretched-link"></a> 						
	    					</div>
						</div>
					</c:forEach>
				</div>	
    		</c:forEach>
		</div>
	</c:if>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value="/scripts/script.js" />"></script>
</body>
</html>