package com.webProject.bean;

import java.sql.Date;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity
@Table(name = "Users")
public class Users {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int uid;
	private String username;
	private String password;
	private String email;
	private String phonenumber;
//	@Temporal(value = TemporalType.DATE)
//	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dateofbirth;
//	@Temporal(value = TemporalType.DATE)
	private Date dateusercreated;
}
