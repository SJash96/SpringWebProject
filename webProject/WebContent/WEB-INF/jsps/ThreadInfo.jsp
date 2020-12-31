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
<title>${currentThread.getThreadname()}</title>
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
		<h6>${replyCreateMessage}</h6>
		<h6>${replyDeleteMessage}</h6>
		<div class="container">
			<div class="card mt-4">
				<div class="card-body text-muted">
					Posted by <b>${currentThread.getUser().getUsername()}</b>
					on <fmt:formatDate pattern="MMMM dd yyyy hh:mm a z" value="${currentThread.getThreadcreated()}" />
				</div>
  				<div class="card-body">
  					<h3 class="card-title">${currentThread.getThreadname()}</h3>
  					<p class="card-text">${currentThread.getThreadpost()}</p>
  					<a class="badge badge-light" href="" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	    				<svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-three-dots" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  							<path fill-rule="evenodd" d="M3 9.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z"/>
						</svg>
	  				</a>
	  				<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
	  					<c:if test="${currentThread.getUser().getUsername() == session.getAttribute('user').getUsername()}">
	    					<a class="dropdown-item" href="#">Edit</a>
	    					<a class="dropdown-item" href="#">Delete</a>
	    				</c:if>
	    				<c:if test="${currentThread.getUser().getUsername() != session.getAttribute('user').getUsername()}">
	    					<a class="dropdown-item" href="#">Report</a>
	    				</c:if>
	  				</div>
  				</div>
  				<div class="card-body">
		  			<c:url var="url" value="createReply?thread_id=${currentThread.getTid()}" />
					<form:form modelAttribute="reply" method="post" id="replyForm" action="${url}">
				  		<div class="input-group mb-3">
  							<form:input path="replypost" type="text" class="form-control" placeholder="Write Your Reply..." />
							<div class="input-group-append">
								<button type="submit" class="btn btn-light">Reply</button>
							</div>
						</div>
					</form:form>
  				</div>
  				<c:forEach items="${currentThread.getReplies()}" var="threadReplies">
  					<div class="card-body">
  						<div class="card-text text-muted">
  							Replied by ${threadReplies.getUser().getUsername()}
  						</div>
	  					<div class="card-text">
	  						<div id="${threadReplies.getRid()}">
	  							<div>
	  								${threadReplies.getReplypost()}	
	  							</div>
		  						<div style="display : none;">
			    					<c:url var="url" value="editReply?reply_id=${threadReplies.getRid()}" />
									<form:form modelAttribute="reply" method="post" action="${url}">
										<div class="input-group mb-3">
  											<form:input path="replypost" type="text" class="form-control" value="${threadReplies.getReplypost()}" />
										  	<div class="input-group-append">
										    	<button type="submit" class="btn btn-light" onclick="saveScrollLocation()">Edit</button>
										  	</div>
										</div>
									</form:form>
								</div>
							</div>
	  					</div>
	  					<div class="card-text">
	  						<a style="cursor : pointer;" class="badge badge-light">
		  						<svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-hand-thumbs-up" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
	  								<path fill-rule="evenodd" d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a9.84 9.84 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733.058.119.103.242.138.363.077.27.113.567.113.856 0 .289-.036.586-.113.856-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.163 3.163 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16v-1c.563 0 .901-.272 1.066-.56a.865.865 0 0 0 .121-.416c0-.12-.035-.165-.04-.17l-.354-.354.353-.354c.202-.201.407-.511.505-.804.104-.312.043-.441-.005-.488l-.353-.354.353-.354c.043-.042.105-.14.154-.315.048-.167.075-.37.075-.581 0-.211-.027-.414-.075-.581-.05-.174-.111-.273-.154-.315L12.793 9l.353-.354c.353-.352.373-.713.267-1.02-.122-.35-.396-.593-.571-.652-.653-.217-1.447-.224-2.11-.164a8.907 8.907 0 0 0-1.094.171l-.014.003-.003.001a.5.5 0 0 1-.595-.643 8.34 8.34 0 0 0 .145-4.726c-.03-.111-.128-.215-.288-.255l-.262-.065c-.306-.077-.642.156-.667.518-.075 1.082-.239 2.15-.482 2.85-.174.502-.603 1.268-1.238 1.977-.637.712-1.519 1.41-2.614 1.708-.394.108-.62.396-.62.65v4.002c0 .26.22.515.553.55 1.293.137 1.936.53 2.491.868l.04.025c.27.164.495.296.776.393.277.095.63.163 1.14.163h3.5v1H8c-.605 0-1.07-.081-1.466-.218a4.82 4.82 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
								</svg>
								<p style="display : inline">${threadReplies.getTotallikes()}</p>
							</a>
							<a style="cursor : pointer;" class="badge badge-light">
		  						<svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-hand-thumbs-down" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  									<path fill-rule="evenodd" d="M6.956 14.534c.065.936.952 1.659 1.908 1.42l.261-.065a1.378 1.378 0 0 0 1.012-.965c.22-.816.533-2.512.062-4.51.136.02.285.037.443.051.713.065 1.669.071 2.516-.211.518-.173.994-.68 1.2-1.272a1.896 1.896 0 0 0-.234-1.734c.058-.118.103-.242.138-.362.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.094 2.094 0 0 0-.16-.403c.169-.387.107-.82-.003-1.149a3.162 3.162 0 0 0-.488-.9c.054-.153.076-.313.076-.465a1.86 1.86 0 0 0-.253-.912C13.1.757 12.437.28 11.5.28v1c.563 0 .901.272 1.066.56.086.15.121.3.121.416 0 .12-.035.165-.04.17l-.354.353.353.354c.202.202.407.512.505.805.104.312.043.44-.005.488l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.415-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.353.352.373.714.267 1.021-.122.35-.396.593-.571.651-.653.218-1.447.224-2.11.164a8.907 8.907 0 0 1-1.094-.17l-.014-.004H9.62a.5.5 0 0 0-.595.643 8.34 8.34 0 0 1 .145 4.725c-.03.112-.128.215-.288.255l-.262.066c-.306.076-.642-.156-.667-.519-.075-1.081-.239-2.15-.482-2.85-.174-.502-.603-1.267-1.238-1.977C5.597 8.926 4.715 8.23 3.62 7.93 3.226 7.823 3 7.534 3 7.28V3.279c0-.26.22-.515.553-.55 1.293-.138 1.936-.53 2.491-.869l.04-.024c.27-.165.495-.296.776-.393.277-.096.63-.163 1.14-.163h3.5v-1H8c-.605 0-1.07.08-1.466.217a4.823 4.823 0 0 0-.97.485l-.048.029c-.504.308-.999.61-2.068.723C2.682 1.815 2 2.434 2 3.279v4c0 .851.685 1.433 1.357 1.616.849.232 1.574.787 2.132 1.41.56.626.914 1.28 1.039 1.638.199.575.356 1.54.428 2.591z"/>
								</svg>
								<p style="display : inline">${threadReplies.getTotaldislikes()}</p>
							</a>
	  					</div>
	  					<c:if test="${threadReplies.getUser().getUsername() == session.getAttribute('user').getUsername()}">
	    					<a style="cursor : pointer;" onclick="showhideFunction(this, '${threadReplies.getRid()}')" class="badge badge-light">Edit</a>
	    					<a href="deleteReply?reply_id=${threadReplies.getRid()}" class="badge badge-light" onclick="saveScrollLocation()">Delete</a>
	    				</c:if>
	    				<c:if test="${threadReplies.getUser().getUsername() != session.getAttribute('user').getUsername()}">
	    					<a style="cursor : pointer;" class="badge badge-light mt-1">Report</a>
	    				</c:if>
  					</div>
				</c:forEach>
  				<div class="card-body">
  					<a href="viewChannel?channel_id=${currentThread.getChannel().getCid()}" class="badge badge-light">Go Back!</a>	
  				</div>
			</div>
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
		<div class="container-fluid w-50">
			<div class="card mt-4">
				<div class="card-body text-muted">
					Posted by <b>${currentThread.getUser().getUsername()}</b>
					on <fmt:formatDate pattern="MMMM dd yyyy hh:mm a z" value="${currentThread.getThreadcreated()}" />
				</div>
	  			<div class="card-body">
	  				<h3 class="card-title">${currentThread.getThreadname()}</h3>
	  				<p class="card-text">${currentThread.getThreadpost()}</p>
	  			</div>
  				<c:forEach items="${currentThread.getReplies()}" var="threadReplies">
  					<div class="card-body">
	  					<div class="card-text text-muted">
	  						Replied by ${threadReplies.getUser().getUsername()}
	  					</div>
		  				<div class="card-text">
		  					${threadReplies.getReplypost()}
		  				</div>
		    			<a href="#" class="badge badge-light">Report</a>
  					</div>
				</c:forEach>
  				<div class="card-body">
	  				<a href="viewChannel?channel_id=${currentThread.getChannel().getCid()}" class="badge badge-light">Go Back!</a>
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
		</div>
	</c:if>
</body>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value="/scripts/script.js" />"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
</body>
</html>