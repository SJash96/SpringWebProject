package com.webProject.bean;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity
@Table(name = "Threads")
public class Threads {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int tid;
	private String threadname;
	private String threadpost;
//	@Temporal(value = TemporalType.TIMESTAMP)
	private Timestamp threadcreated;
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "user_id", referencedColumnName = "uid")
	private Users user;
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "channel_id", referencedColumnName = "cid")
	private Channels channel;
	
	@OneToMany(mappedBy = "thread", fetch = FetchType.EAGER)
	@OrderBy("replycreated desc")
	private List<Replies> replies;
}
