/**
 * Jashandeep Singh
 * Simple javascript file to perform dynamic client side operations (mostly for asthetic looks)
 * Created 2020-11-01
 */

// Home.jsp jquery section--------------------------------------------------------------------------------------

function searchForThread(funcEle) {
	var threadList = document.getElementById("threadList");
	var searchedList = document.getElementById("searchedList");
	if(funcEle.value.length > 0) {
		if(threadList.style.display != "none") {
			threadList.style.display = "none";
			searchedList.style.display = "";
		}
		while(searchedList.hasChildNodes()) {
			searchedList.removeChild(searchedList.firstChild);
		}
		$(document).ready(function(){
			$.ajax({
				type: "post",
				url: "searchThreads",
				data: "thread_name=" + funcEle.value,
				success: function(res) {
					//console.log(res)
					$.each(res, function(k,v) {
						var card = $("<div class='card mt-4'></div>");
						var cardBody = $("<div class='card-body'></div>");
						var cardTitle = $("<h3 class='card-title'>"+ v.threadname +"</h3>");
						var cardText = $("<p class='card-text'>"+ v.threadpost +"</p>");
						cardBody.append(cardTitle);
						cardBody.append(cardText);
						card.append(cardBody);
						$("#searchedList").append(card);
					});
				},
				error: function(req, err) {
					console.log("Error" + err);
				}
			});
		});
	}
	else {
		threadList.style.display = "";
		searchedList.style.display = "none";
		while(searchedList.hasChildNodes()) {
			searchedList.removeChild(searchedList.firstChild);
		}
	}
}


// ThreadInfo.jsp javascript section----------------------------------------------------------------------------

function showhideFunction(funcEle, Rid) {
	var parent = document.getElementById(Rid);
	var child = parent.getElementsByTagName("div");
	var childForm = child[1].firstElementChild;
	if(child[0].style.display == "") {
		child[0].style.display = "none";
		child[1].style.display = "";
		funcEle.innerText = "Close";
			
	}
	else {
		child[0].style.display = "";
		child[1].style.display = "none";
		funcEle.innerText = "Edit";
		childForm.reset();
	}
}

/*function likeFunction(funcEle) {
	var parentEle = funcEle.parentElement;
	var likebutton = funcEle.getElementsByTagName("svg")[0];
	var dislikebutton = parentEle.getElementsByTagName("a")[1].firstElementChild;
	if(likebutton.getAttribute("class") == "bi bi-hand-thumbs-up" && dislikebutton.getAttribute("class") == "bi bi-hand-thumbs-down") {
		likebutton.removeAttribute("class");
		likebutton.setAttribute("class", "bi bi-hand-thumbs-up text-success");
	}
	else if(likebutton.getAttribute("class") == "bi bi-hand-thumbs-up" && dislikebutton.getAttribute("class") == "bi bi-hand-thumbs-down text-danger") {
		likebutton.removeAttribute("class");
		dislikebutton.removeAttribute("class");
		likebutton.setAttribute("class", "bi bi-hand-thumbs-up text-success");
		dislikebutton.setAttribute("class", "bi bi-hand-thumbs-down");
	}
	else {
		likebutton.removeAttribute("class");
		likebutton.setAttribute("class", "bi bi-hand-thumbs-up");
	}
}

function dislikeFunction(funcEle) {
	var parentEle = funcEle.parentElement;
	var dislikebutton = funcEle.getElementsByTagName("svg")[0];
	var likebutton = parentEle.getElementsByTagName("a")[0].firstElementChild;
	if(dislikebutton.getAttribute("class") == "bi bi-hand-thumbs-down" && likebutton.getAttribute("class") == "bi bi-hand-thumbs-up") {
		dislikebutton.removeAttribute("class");
		dislikebutton.setAttribute("class", "bi bi-hand-thumbs-down text-danger");
	}
	else if(dislikebutton.getAttribute("class") == "bi bi-hand-thumbs-down" && likebutton.getAttribute("class") == "bi bi-hand-thumbs-up text-success") {
		dislikebutton.removeAttribute("class");
		likebutton.removeAttribute("class");
		dislikebutton.setAttribute("class", "bi bi-hand-thumbs-down text-danger");
		likebutton.setAttribute("class", "bi bi-hand-thumbs-up");
	}
	else {
		dislikebutton.removeAttribute("class");
		dislikebutton.setAttribute("class", "bi bi-hand-thumbs-down");
	}
}*/

/*$(document).ready(function() {
	$('#replyForm').children('button').click(function(e) {
		e.preventDefault();
		
		console.log($('#replyForm').serialize());
		console.log($(this).attr('action'));

		$.post({
			url: 'createReply?thread_id=' + $(this).attr('action'),
			data: $('#formReply').serialize(),
			success: function(data) {
				console.log(JSON.stringify(data));
			},
			error: function(error) {
				console.log(error);
			}
		});
	});
});*/

// Home.jsp javascript section----------------------------------------------------------------------------

function getDateTime() {
	var d = new Date();
	var x = document.getElementById("displayDateTime");
	var date = d.toDateString();
	var localTime = d.toLocaleTimeString();
	x.innerHTML = date + "<br/>" + localTime;
}

getDateTime();
setInterval(getDateTime,1000);

onload = function() {
	if(sessionStorage.getItem("scrollPos")) {
		scrollTo(0, sessionStorage.getItem("scrollPos"));
		sessionStorage.removeItem("scrollPos");
	}
}

function saveScrollLocation() {
	var x = document.documentElement;
	sessionStorage.setItem("scrollPos", x.scrollTop);
}

// Account.jsp javascript section----------------------------------------------------------------------------

function showhideUsername(funcEle) {
	var parent = document.getElementById("editUsername");
	var child = parent.getElementsByTagName("div");
	var childForm = child[1].firstElementChild;
	if(child[0].style.display == "") {
		child[0].style.display = "none";
		child[1].style.display = "";
		funcEle.innerText = "Close";
	}
	else {
		child[0].style.display = "";
		child[1].style.display = "none";
		funcEle.innerText = "Edit UserName";
		childForm.reset();
	}
}

function showhideEmail(funcEle) {
	var parent = document.getElementById("editEmail");
	var child = parent.getElementsByTagName("div");
	var childForm = child[1].firstElementChild;
	if(child[0].style.display == "") {
		child[0].style.display = "none";
		child[1].style.display = "";
		funcEle.innerText = "Close";
	}
	else {
		child[0].style.display = "";
		child[1].style.display = "none";
		funcEle.innerText = "Edit Email";
		childForm.reset();
	}
}

function showhidePhonenumber(funcEle) {
	var parent = document.getElementById("editPhonenumber");
	var child = parent.getElementsByTagName("div");
	var childForm = child[1].firstElementChild;
	if(child[0].style.display == "") {
		child[0].style.display = "none";
		child[1].style.display = "";
		funcEle.innerText = "Close";
	}
	else {
		child[0].style.display = "";
		child[1].style.display = "none";
		funcEle.innerText = "Edit PhoneNumber";
		childForm.reset();
	}
}

function showhideDateofbirth(funcEle) {
	var parent = document.getElementById("editDateofbirth");
	var child = parent.getElementsByTagName("div");
	var childForm = child[1].firstElementChild;
	if(child[0].style.display == "") {
		child[0].style.display = "none";
		child[1].style.display = "";
		funcEle.innerText = "Close";
	}
	else {
		child[0].style.display = "";
		child[1].style.display = "none";
		funcEle.innerText = "Edit DOB";
		childForm.reset();
	}
}
