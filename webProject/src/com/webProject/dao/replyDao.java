package com.webProject.dao;

import java.sql.Timestamp;
import java.util.Calendar;

import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.Session;

import com.webProject.bean.Replies;
import com.webProject.bean.Threads;
import com.webProject.bean.Users;
import com.webProject.util.hibernateUtil;

public class replyDao {
	
	public String createReply(Replies reply, Threads thread, Users user) {
		Session sessionObj = null;
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			Calendar cal = Calendar.getInstance();
			Timestamp date = new Timestamp(cal.getTime().getTime());
			reply.setReplycreated(date);
			reply.setThread(thread);
			reply.setUser(user);
			sessionObj.save(reply);
			
			sessionObj.getTransaction().commit();
			return "Reply has been saved!";
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
	
	public void updateReply(int rid, Replies reply) {
		Session sessionObj = null;
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			Replies replyu = sessionObj.load(Replies.class, rid);
			replyu.setReplypost((reply.getReplypost().isBlank()) ? replyu.getReplypost() : reply.getReplypost());
			sessionObj.update(replyu);
			
			sessionObj.getTransaction().commit();
//			return getReplyById(replyu.getRid());
		} catch(Exception e) {
			sessionObj.getTransaction().rollback();
			e.printStackTrace();
//			return null;
		} finally {
			if(sessionObj != null) {
				sessionObj.close();
			}
		}
	}
	
	public Replies getReplyById(int rid) {
		Session sessionObj = null;
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			CriteriaBuilder builder = sessionObj.getCriteriaBuilder();
			CriteriaQuery<Replies> criteria = builder.createQuery(Replies.class);
			Root<Replies> criteriaThread = criteria.from(Replies.class);
			criteria.select(criteriaThread).where(builder.equal(criteriaThread.get("rid"), rid));
			TypedQuery<Replies> query = sessionObj.createQuery(criteria);
			Replies queryResult = query.getSingleResult();
			
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
	
	public String deleteReply(Replies reply) {
		Session sessionObj = null;
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			sessionObj.delete(reply);
			
			sessionObj.getTransaction().commit();
			return "Reply deleted!";
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
