package com.webProject.dao;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;

import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.Session;

import com.webProject.bean.Channels;
import com.webProject.bean.Users;
import com.webProject.util.hibernateUtil;

public class channelDao {
	
	public String createChannel(Channels channel, Users user) {
		Session sessionObj = null;
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			Calendar cal = Calendar.getInstance();
			Timestamp date = new Timestamp(cal.getTime().getTime());
			channel.setChannelcreated(date);
			channel.setUser(user);
			sessionObj.save(channel);
			
			sessionObj.getTransaction().commit();
			return "Channel has been saved!";
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
	
	public Channels getChannelById(int cid) {
		Session sessionObj = null;
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			CriteriaBuilder builder = sessionObj.getCriteriaBuilder();
			CriteriaQuery<Channels> criteria = builder.createQuery(Channels.class);
			Root<Channels> criteriaThread = criteria.from(Channels.class);
			criteria.select(criteriaThread).where(builder.equal(criteriaThread.get("cid"), cid));
			TypedQuery<Channels> query = sessionObj.createQuery(criteria);
			Channels queryResult = query.getSingleResult();
			
			if(queryResult != null) {
				return queryResult;
			}
			
			sessionObj.getTransaction().commit();
			return null;
		} catch(Exception e) {
			sessionObj.getTransaction().rollback();
			e.printStackTrace();
			return null;
		} finally {
			if(sessionObj != null) {
				sessionObj.close();
			}
		}
	}
	
	public List<Channels> getAllChannels() {
		Session sessionObj = null;
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			CriteriaBuilder builder = sessionObj.getCriteriaBuilder();
			CriteriaQuery<Channels> criteria = builder.createQuery(Channels.class);
			Root<Channels> criteriaThread = criteria.from(Channels.class);
			criteria.select(criteriaThread).orderBy(builder.desc(criteriaThread.get("channelcreated")));
			TypedQuery<Channels> query = sessionObj.createQuery(criteria);
			List<Channels> queryResult = query.getResultList();
			
			if(queryResult != null) {
				return queryResult;
			}
			
			sessionObj.getTransaction().commit();
			return null;
		} catch(Exception e) {
			sessionObj.getTransaction().rollback();
			e.printStackTrace();
			return null;
		} finally {
			if(sessionObj != null) {
				sessionObj.close();
			}
		}
	}
}
