package com.webProject.controller;

import java.util.List;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.webProject.bean.Threads;
import com.webProject.dao.threadDao;

@RestController
public class Controller {
	
	@PostMapping(value = "searchThreads")
	@ResponseBody
	public List<Threads> searchThreads(@RequestParam String thread_name) {
		
		threadDao threaddao = new threadDao();
		List<Threads> searchedThreads = threaddao.getThreadByName(thread_name);
		
		return searchedThreads;
	}
}
