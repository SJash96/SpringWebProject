package com.webProject.metamodel;

import java.util.Date;

import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

import com.webProject.bean.Threads;
import com.webProject.bean.Users;

@StaticMetamodel(Users.class)
public class Users_ {
	public static volatile SingularAttribute<Users, Integer> uid;
	public static volatile SingularAttribute<Users, String> username;
	public static volatile SingularAttribute<Users, String> email;
	public static volatile SingularAttribute<Users, String> password;
	public static volatile SingularAttribute<Users, Date> usercreated;
	public static volatile ListAttribute<Users, Threads> threads;
}
