package com.webProject.dao;

import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.Session;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.webProject.bean.Users;
import com.webProject.util.hibernateUtil;


public class usersDao {
	PasswordEncoder encoder;
	
	public usersDao() {
		encoder = new BCryptPasswordEncoder();
	}
	
//	Next Task: Create a better check verification upon user creation.
	public String createUser(Users user) {
		Session sessionObj = null;
		
		try {
			sessionObj = hibernateUtil.getSessionFactory().openSession();
			sessionObj.beginTransaction();
			
			Date today = new Date(System.currentTimeMillis());
			user.setDateusercreated(today);
			user.setPassword(encoder.encode(user.getPassword()));
			sessionObj.save(user);
			
			sessionObj.getTransaction().commit();
			return "User has been saved!";
		} catch(ConstraintViolationException se) {
			return se.getCause().getMessage();
		} catch(Exception e) {
			sessionObj.getTransaction().rollback();
			e.printStackTrace();
			return e.getMessage();
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
			criteria.select(criteriaUser).where(builder.equal(criteriaUser.get("username"), user.getUsername()));
			TypedQuery<Users> query = sessionObj.createQuery(criteria);
			Users queryUser = query.getSingleResult();
			
			if(queryUser != null) {
				if(encoder.matches(user.getPassword(), queryUser.getPassword())) {
					return queryUser;
				}
				return null;
			}
			return null;
		} catch(NoResultException re) {
			sessionObj.getTransaction().rollback();
			re.printStackTrace();
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
