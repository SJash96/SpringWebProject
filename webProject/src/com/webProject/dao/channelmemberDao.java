package com.webProject.dao;

import java.sql.Timestamp;
import java.util.Calendar;

import org.hibernate.Session;

import com.webProject.bean.ChannelMembers;
import com.webProject.bean.Channels;
import com.webProject.bean.Users;
import com.webProject.util.hibernateUtil;

public class channelmemberDao {
	
	public String addchannelMember(Channels channel, Users user) {
		Session sessionObj = null;
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			Calendar cal = Calendar.getInstance();
			Timestamp date = new Timestamp(cal.getTime().getTime());
			ChannelMembers member = new ChannelMembers();
			member.setChanneljoined(date);
			member.setChannel(channel);
			member.setUser(user);
			sessionObj.save(member);
			
			sessionObj.getTransaction().commit();
			return "User added to channel!";
		} catch(Exception e) {
			sessionObj.getTransaction().rollback();
			e.printStackTrace();
			return "Error";
		} finally {
			if(sessionObj != null) {
				sessionObj.close();
			}
		}	
	}
	
	public String removechannelMember(ChannelMembers members) {
		Session sessionObj = null;
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			sessionObj.delete(members);
			
			sessionObj.getTransaction().commit();
			return "Member removed!";
		} catch(Exception e) {
			sessionObj.getTransaction().rollback();
			e.printStackTrace();
			return "Error";
		} finally {
			if(sessionObj != null) {
				sessionObj.close();
			}
		}	
	}
}
