package com.webProject.util;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;

import com.webProject.bean.ChannelFollowers;
import com.webProject.bean.Channels;
import com.webProject.bean.Replies;
import com.webProject.bean.Threads;
import com.webProject.bean.Users;

public class hibernateUtil {
	
static SessionFactory sessionFactoryObj;
	
	private static SessionFactory buildSessionFactory() {
		Configuration configObj = new Configuration();
		configObj.configure("hibernate.cfg.xml");
		
		configObj.addAnnotatedClass(Users.class);
		configObj.addAnnotatedClass(Threads.class);
		configObj.addAnnotatedClass(Replies.class);
		configObj.addAnnotatedClass(Channels.class);
		configObj.addAnnotatedClass(ChannelFollowers.class);
		
		ServiceRegistry serverRegistryObj = new StandardServiceRegistryBuilder().applySettings(configObj.getProperties()).build();
		
		sessionFactoryObj = configObj.buildSessionFactory(serverRegistryObj);
		return sessionFactoryObj;
	}
	
	public static SessionFactory getSessionFactory() {
		return buildSessionFactory();
	}

}
