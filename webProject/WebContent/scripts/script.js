/**
 * Jashandeep Singh
 * Simple javascript file to perform dynamic client side operations (mostly for asthetic looks)
 * Created 2020-11-01
 */

// Home.jsp javascript & jQuery section----------------------------------------------------------------------------

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

$(document).ready(function(){
	$("#searchBar").on("keyup", function() {
		var inputVal = $(this).val().toLowerCase();
		$(".card-title").each(function() {
			$(this).parent().parent().toggle(($(this).text().toLowerCase().indexOf(inputVal) > -1));
		});
	})
});


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

/*$.ajax({
				type: "post",
				url: "searchThreads",
				data: "thread_name=" + funcEle.value,
				success: function(res) {
					console.log(res)
					$.each(res, function(k,v) {
						
					});
				},
				error: function(req, err) {
					console.log("Error" + err);
				}
			});*/

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

// Channel.jsp jquery section

$(document).ready(function(){
	$("#searchBar").on("keyup", function() {
		var inputVal = $(this).val().toLowerCase();
		$(".card-title").each(function() {
			$(this).parent().parent().parent().toggle(($(this).text().toLowerCase().indexOf(inputVal) > -1));
		});
	})
});
