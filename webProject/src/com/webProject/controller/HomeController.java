package com.webProject.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.webProject.bean.Channels;
import com.webProject.bean.Replies;
import com.webProject.bean.Threads;
import com.webProject.bean.Users;
import com.webProject.dao.channelDao;
import com.webProject.dao.replyDao;
import com.webProject.dao.threadDao;
import com.webProject.dao.usersDao;

@Controller
public class HomeController {
	
	@GetMapping(value = "/")
	public String welcomePage(ModelMap model, @RequestParam(required = false) String threadCreateMessage, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		threadDao threaddao = new threadDao();
		model.addAttribute("listOfThreads", threaddao.getAllThreads());
		model.addAttribute("threadCreateMessage", threadCreateMessage);
		
		model.addAttribute("thread", new Threads());
		model.addAttribute("session", session);
		
		return "Welcome";
	}
	
	@GetMapping(value = "login")
	public String loginPage(ModelMap model) {
		
		model.addAttribute("user", new Users());
		model.addAttribute("loginMessage", "Welcome, please login to your account!");
		
		return "Login";
	}
	
	@GetMapping(value = "register")
	public String registerPage(ModelMap model, @RequestParam(required = false) String userCreateMessage) {
		
		model.addAttribute("user", new Users());
		model.addAttribute("registerMessage", "Welcome, please create your account!");
		model.addAttribute("userCreateMessage", userCreateMessage);
		
		return "Register";
	}
	
	@PostMapping(value = "addUser")
	public String addUser(ModelMap model, @ModelAttribute("user") Users user) {
		
		usersDao userdao = new usersDao();
		model.addAttribute("userCreateMessage", userdao.createUser(user));
		
		return "redirect:/register";
	}
	
	@GetMapping(value = "account")
	public String accountPage(ModelMap model, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		model.addAttribute("user", new Users());
		model.addAttribute("session", session);
		
		return "Account";
	}
	
	@PostMapping(value = "editUser")
	public String editUser(ModelMap model, @ModelAttribute("user") Users user, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(false);
		
		usersDao userdao = new usersDao();
		int id = ((Users)session.getAttribute("user")).getUid();
		Users updatedUser = userdao.updateUser(id, user);
		session.setAttribute("user", updatedUser);
		
		return "redirect:/account";
	}
	
	@GetMapping(value = "logout")
	public String logout(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(false);
		
		if(session != null) {
			session.invalidate();
		}
		
		threadDao threaddao = new threadDao();
		model.addAttribute("listOfThreads", threaddao.getAllThreads());
		
		return "Welcome";
	}
	
	@PostMapping(value = "loginUser")
	public String loginUser(ModelMap model, @ModelAttribute("user") Users user, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = null;
		
		usersDao userdao = new usersDao();
		Users loggedInUser = userdao.loginUser(user);
		if(loggedInUser != null) {
			session = request.getSession(true);
			session.setAttribute("user", loggedInUser);
		}
		
		return "redirect:/";
	}
	
	@GetMapping(value = "channels")
	public String channelsPage(ModelMap model, @RequestParam(required = false) String channelCreateMessage,  HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		channelDao channeldao = new channelDao();
		model.addAttribute("listofchannels", channeldao.getAllChannels());
		model.addAttribute("channelCreateMessage", channelCreateMessage);
		
		model.addAttribute("channel", new Channels());
		model.addAttribute("session", session);
		
		return "Channels";
	}
	
	@PostMapping(value = "createChannel")
	public String createChannel(ModelMap model, @ModelAttribute("channel") Channels channel, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		channelDao channeldao = new channelDao();
		model.addAttribute("channelCreateMessage", channeldao.createChannel(channel, ((Users) session.getAttribute("user"))));
		
		return "redirect:/channels";
	}
	
	@GetMapping(value = "viewChannel")
	public String viewChannel(ModelMap model, @RequestParam int channel_id, @RequestParam(required = false) String threadCreateMessage, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		channelDao channeldao = new channelDao();
		model.addAttribute("currentChannel", channeldao.getChannelById(channel_id));
		
		model.addAttribute("threadCreateMessage", threadCreateMessage);
		
		model.addAttribute("thread", new Threads());
		model.addAttribute("session", session);
		
		return "ChannelInfo";
	}
	
	@PostMapping(value = "createThread")
	public String createThread(ModelMap model, @ModelAttribute("thread") Threads thread, @RequestParam int channel_id, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		threadDao threaddao = new threadDao();
		channelDao channeldao = new channelDao();
		model.addAttribute("threadCreateMessage", threaddao.createThread(thread, channeldao.getChannelById(channel_id), ((Users) session.getAttribute("user"))));
		
		return "redirect:/viewChannel?channel_id=" + channel_id;
	}
	
	@GetMapping(value = "viewThread")
	public String viewThread(ModelMap model, @RequestParam int thread_id, @RequestParam(required = false) String replyCreateMessage, @RequestParam(required = false) String replyDeleteMessage, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		threadDao threaddao = new threadDao();
		model.addAttribute("currentThread", threaddao.getThreadById(thread_id));
		
		model.addAttribute("replyCreateMessage", replyCreateMessage);
		model.addAttribute("replyDeleteMessage", replyDeleteMessage);
		
		model.addAttribute("reply", new Replies());
		model.addAttribute("session", session);
		
		return "ThreadInfo";
	}
	
	@PostMapping(value = "createReply")
	public String createReply(ModelMap model, @ModelAttribute("reply") Replies reply, @RequestParam int thread_id, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		threadDao threaddao = new threadDao();
		replyDao replydao = new replyDao();
		model.addAttribute("replyCreateMessage", replydao.createReply(reply, threaddao.getThreadById(thread_id), (Users) session.getAttribute("user")));
		
		return "redirect:/viewThread?thread_id=" + thread_id;
	}
	
	@GetMapping(value = "deleteReply")
	public String deleteReply(ModelMap model, @RequestParam int reply_id) {
		
		replyDao replydao = new replyDao();
		Replies reply = replydao.getReplyById(reply_id);
		model.addAttribute("replyDeleteMessage", replydao.deleteReply(reply));
		
		return "ThreadInfo";
	}
	
	@PostMapping(value = "editReply")
	public String deleteReply(ModelMap model, @ModelAttribute("reply") Replies reply, @RequestParam int reply_id) {
		
		replyDao replydao = new replyDao();
		Replies edreply = replydao.getReplyById(reply_id);
		replydao.updateReply(reply_id, reply);
		
		return "redirect:/viewThread?thread_id=" + edreply.getThread().getTid();
	}
}
