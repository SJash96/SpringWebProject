package com.webProject.dao;

import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.Session;

import com.webProject.bean.Users;
import com.webProject.util.hibernateUtil;


public class usersDao {
	
//	Next Task: Create a better check verification upon user creation.
	public String createUser(Users user) {
		Session sessionObj = null;
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			Date today = new Date(System.currentTimeMillis());
			user.setDateusercreated(today);
			sessionObj.save(user);
			
			sessionObj.getTransaction().commit();
			return "User has been saved!";
		} catch(Exception e) {
			sessionObj.getTransaction().rollback();
			e.printStackTrace();
			return "User already exists";
		} finally {
			if(sessionObj != null) {
				sessionObj.close();
			}
		}	
	}
	
	public Users updateUser(int uid, Users user) {
		Session sessionObj = null;
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			Users usertu = sessionObj.load(Users.class, uid);
			usertu.setUsername((user.getUsername() == null) ? usertu.getUsername() : user.getUsername());
			usertu.setEmail((user.getEmail() == null) ? usertu.getEmail() : user.getEmail());
			usertu.setPhonenumber((user.getPhonenumber() == null) ? usertu.getPhonenumber() : user.getPhonenumber());
			if(user.getDateofbirth() != null) {
				java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(user.getDateofbirth().toString());
				Date sqlDate = new Date(utilDate.getTime());
				usertu.setDateofbirth(sqlDate);
			}
			else {
				usertu.setDateofbirth(usertu.getDateofbirth());
			}
			sessionObj.update(usertu);
			
			sessionObj.getTransaction().commit();
			return getUserById(usertu.getUid());
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
	
	public Users getUserById(int id) {
		Session sessionObj = null;
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			CriteriaBuilder builder = sessionObj.getCriteriaBuilder();
			CriteriaQuery<Users> criteria = builder.createQuery(Users.class);
			Root<Users> criteriaUser = criteria.from(Users.class);
			criteria.select(criteriaUser).where(builder.equal(criteriaUser.get("uid"), id));
			TypedQuery<Users> query = sessionObj.createQuery(criteria);
			Users queryUser = query.getSingleResult();
			
			if(queryUser != null) {
				return queryUser;
			}
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
	
	public Users loginUser(Users user) {
		Session sessionObj = null;
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			CriteriaBuilder builder = sessionObj.getCriteriaBuilder();
			CriteriaQuery<Users> criteria = builder.createQuery(Users.class);
			Root<Users> criteriaUser = criteria.from(Users.class);
			criteria.select(criteriaUser).where(builder.equal(criteriaUser.get("username"), user.getUsername()), builder.equal(criteriaUser.get("password"), user.getPassword()));
			TypedQuery<Users> query = sessionObj.createQuery(criteria);
			Users queryUser = query.getSingleResult();
			
			if(queryUser != null) {
				return queryUser;
			}
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
