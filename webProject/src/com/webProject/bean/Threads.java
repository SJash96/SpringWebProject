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

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

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
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "MMMM dd yyyy hh:mm a z", timezone = "EST")
	private Timestamp threadcreated;
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "user_id", referencedColumnName = "uid")
	private Users user;
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "channel_id", referencedColumnName = "cid")
	private Channels channel;
	
	@OneToMany(mappedBy = "thread")
	@LazyCollection(LazyCollectionOption.FALSE)
	@OrderBy("replycreated desc")
	@JsonIgnoreProperties("thread")
	private List<Replies> replies;
}
