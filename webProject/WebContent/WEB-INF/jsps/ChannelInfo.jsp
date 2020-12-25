<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<title>Welcome</title>
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
		<h6>${threadCreateMessage}</h6>
		<div class="container">
			<div class="card mt-4">
				<div class="card-body text-muted">
					Posted by ${currentChannel.getUser().getUsername()} on <fmt:formatDate pattern="yyyy-MM-dd hh:mm a z" value="${currentChannel.getChannelcreated()}" />
				</div>
  				<div class="card-body">
  					<h3 class="card-title">${currentChannel.getChannelname()}</h3>
  					<p class="card-text">${currentChannel.getChanneldescription()}</p>
  					<a class="badge badge-light" href="" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	    				<svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-three-dots" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  							<path fill-rule="evenodd" d="M3 9.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z"/>
						</svg>
	  				</a>
	  				<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
	  					<c:if test="${currentChannel.getUser().getUsername() == session.getAttribute('user').getUsername()}">
	    					<a class="dropdown-item" href="#">Edit</a>
	    					<a class="dropdown-item" href="#">Delete</a>
	    				</c:if>
	    				<c:if test="${currentChannel.getUser().getUsername() != session.getAttribute('user').getUsername()}">
	    					<a class="dropdown-item" href="#">Report</a>
	    				</c:if>
	  				</div>
  				</div>
  				<div class="card-body">
		  			<c:url var="url" value="createThread?channel_id=${currentChannel.getCid()}" />
					<form:form modelAttribute="thread" method="post" action="${url}">
				  		<div class="form-group">
				    		<label for="ThreadName">Thread Name</label>
				    		<form:input path="threadname" type="text" class="form-control" id="ThreadName" placeholder="Enter thread name..." />
				  		</div>
				  		<div class="form-group">
				    		<label for="ThreadPost">Post</label>
				    		<form:textarea path="threadpost" class="form-control" id="ThreadPost" row="3" placeholder="Enter your post..." />
				  		</div>
				  		<div class="text-center">
				  			<button type="submit" class="btn btn-light">Create Thread</button>
				  		</div>
					</form:form>
  				</div>
  				<div class="card-body">
  					<a href="channels" class="badge badge-light">Go Back!</a>	
  				</div>
			</div>
			<c:forEach items="${currentChannel.getThreads()}" var="channelThreads">
  				<div class="card mt-4">
					<div class="card-body text-muted">
						Posted by ${channelThreads.getUser().getUsername()} on <fmt:formatDate pattern="yyyy-MM-dd hh:mm a z" value="${channelThreads.getThreadcreated()}" />
					</div>
		  			<div class="card-body">
		  				<h3 class="card-title">${channelThreads.getThreadname()}</h3>
		  				<p class="card-text">${channelThreads.getThreadpost()}</p>
		  			</div>
		  			<div class="card-body">
		  				<a href="viewThread?thread_id=${channelThreads.getTid()}" class="badge badge-light">
							<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chat-square-dots" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
		  						<path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h2.5a2 2 0 0 1 1.6.8L8 14.333 9.9 11.8a2 2 0 0 1 1.6-.8H14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h2.5a1 1 0 0 1 .8.4l1.9 2.533a1 1 0 0 0 1.6 0l1.9-2.533a1 1 0 0 1 .8-.4H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
		  						<path d="M5 6a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
							</svg>
							${channelThreads.getReplies().size()} Comments
						</a>
			  			<a class="badge badge-light" href="" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			    			<svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-three-dots" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
		  						<path fill-rule="evenodd" d="M3 9.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z"/>
							</svg>
			  			</a>
			  			<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
			  				<c:if test="${channelThreads.getUser().getUsername() == session.getAttribute('user').getUsername()}">
			    				<a class="dropdown-item" href="#" onclick="saveScrollLocation()">Edit</a>
			    				<a class="dropdown-item" href="#" onclick="saveScrollLocation()">Delete</a>
			    			</c:if>
			    			<c:if test="${channelThreads.getUser().getUsername() != session.getAttribute('user').getUsername()}">
			    				<a class="dropdown-item" href="#">Report</a>
			    			</c:if>
			  			</div>	
		  			</div>
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
		      <li class="nav-item">
			    <a class="nav-link" href="channels">Channels</a>
			  </li>
		      <li class="nav-item">
		        <a class="nav-link" href="login">Login</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="register">Register</a>
		      </li>
		    </ul>
		    <div>
		    	<p class="text-right mb-0 mr-2" id="displayDateTime"></p>
		    </div>
		  </div>
		</nav>
		<div class="container">
			<div class="card mt-4">
				<div class="card-body text-muted">
					Posted by ${currentChannel.getUser().getUsername()} on <fmt:formatDate pattern="yyyy-MM-dd hh:mm a z" value="${currentChannel.getChannelcreated()}" />
				</div>
	  			<div class="card-body">
	  				<h3 class="card-title">${currentChannel.getChannelname()}</h3>
	  				<p class="card-text">${currentChannel.getChanneldescription()}</p>
	  			</div>
  				<div class="card-body">
	  				<a href="channels" class="badge badge-light">Go Back!</a>
		  			<a class="badge badge-light" href="" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	    				<svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-three-dots" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  							<path fill-rule="evenodd" d="M3 9.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z"/>
						</svg>
	  				</a>
	  				<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
	  					<a class="dropdown-item" href="#">Report</a>
	  				</div>
	  			</div>
			</div>
			<c:forEach items="${currentChannel.getThreads()}" var="channelThreads">
  				<div class="card mt-4">
					<div class="card-body text-muted">
						Posted by ${channelThreads.getUser().getUsername()}
						on <fmt:formatDate pattern="yyyy-MM-dd hh:mm a z" value="${channelThreads.getThreadcreated()}" />
					</div>
		  			<div class="card-body">
		  				<h3 class="card-title">${channelThreads.getThreadname()}</h3>
		  				<p class="card-text">${channelThreads.getThreadpost()}</p>
		  			</div>
		  			<div class="card-body">
		  				<a href="viewThread?thread_id=${channelThreads.getTid()}" class="badge badge-light">
							<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chat-square-dots" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
		  						<path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h2.5a2 2 0 0 1 1.6.8L8 14.333 9.9 11.8a2 2 0 0 1 1.6-.8H14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h2.5a1 1 0 0 1 .8.4l1.9 2.533a1 1 0 0 0 1.6 0l1.9-2.533a1 1 0 0 1 .8-.4H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
		  						<path d="M5 6a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
							</svg>
							${channelThreads.getReplies().size()} Comments
						</a>
						<a class="badge badge-light" href="" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    				<svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-three-dots" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
	  							<path fill-rule="evenodd" d="M3 9.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z"/>
							</svg>
		  				</a>
			  			<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
			    			<a class="dropdown-item" href="#">Report</a>
			  			</div>
		  			</div>
				</div>
			</c:forEach>
		</div>
	</c:if>
</body>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value="/scripts/script.js" />"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
</body>
</html>