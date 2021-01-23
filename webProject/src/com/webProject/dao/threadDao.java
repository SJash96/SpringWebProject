package com.webProject.dao;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;

import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import com.webProject.bean.Channels;
import com.webProject.bean.Threads;
import com.webProject.bean.Users;
import com.webProject.util.hibernateUtil;

public class threadDao {
	
	public String createThread(Threads thread, Channels channel, Users user) {
		Session sessionObj = null;
		
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			Calendar cal = Calendar.getInstance();
			Timestamp date = new Timestamp(cal.getTime().getTime());
			thread.setThreadcreated(date);
			thread.setUser(user);
			thread.setChannel(channel);
			sessionObj.save(thread);
			
			sessionObj.getTransaction().commit();
			return "Thread has been saved!";
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
	
	public Threads getThreadById(int tid) {
		Session sessionObj = null;
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			CriteriaBuilder builder = sessionObj.getCriteriaBuilder();
			CriteriaQuery<Threads> criteria = builder.createQuery(Threads.class);
			Root<Threads> criteriaThread = criteria.from(Threads.class);
			criteria.select(criteriaThread).where(builder.equal(criteriaThread.get("tid"), tid));
			TypedQuery<Threads> query = sessionObj.createQuery(criteria);
			Threads queryResult = query.getSingleResult();
			
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
	
	public List<Threads> getThreadByName(String name) {
		Session sessionObj = null;
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			CriteriaBuilder builder = sessionObj.getCriteriaBuilder();
			CriteriaQuery<Threads> criteria = builder.createQuery(Threads.class);
			Root<Threads> criteriaThread = criteria.from(Threads.class);
			criteria.select(criteriaThread).where(builder.like(criteriaThread.get("threadname"), name + '%'));
			TypedQuery<Threads> query = sessionObj.createQuery(criteria);
			List<Threads> queryResult = query.getResultList();
			
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
	
	public List<Threads> getAllThreads() {
		Session sessionObj = null;
		System.out.println(sessionObj = hibernateUtil.getSessionFactory().openSession());
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			CriteriaBuilder builder = sessionObj.getCriteriaBuilder();
			CriteriaQuery<Threads> criteria = builder.createQuery(Threads.class);
			Root<Threads> criteriaThread = criteria.from(Threads.class);
			criteria.select(criteriaThread).orderBy(builder.desc(criteriaThread.get("threadcreated")));
			TypedQuery<Threads> query = sessionObj.createQuery(criteria);
			List<Threads> queryResult = query.getResultList();
			
			if(queryResult != null) {
				return queryResult;
			}
			
			sessionObj.getTransaction().commit();
			return null;
		} catch(HibernateException e) {
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
