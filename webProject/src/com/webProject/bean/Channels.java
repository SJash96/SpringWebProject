package com.webProject.bean;

import java.sql.Timestamp;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity
@Table(name = "Channels")
public class Channels {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int cid;
	private String channelname;
	private String channeldescription;
	private String channelcategory;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss.S", timezone = "EST")
	private Timestamp channelcreated;
	
	@Transient
	@JsonIgnore
	private String channelsarray[] = {"General", "News", "Gaming", "Music", "Movie Reviews", "Life Style"};
	@Transient
	@JsonIgnore
	private LinkedHashSet<String> channelcategories = new LinkedHashSet<>(Arrays.asList(channelsarray));
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "user_id", referencedColumnName = "uid")
	private Users user;
	
	@OneToMany(mappedBy = "channel")
	@LazyCollection(LazyCollectionOption.FALSE)
	@OrderBy("threadcreated desc")
	@JsonIgnoreProperties("channel")
	private List<Threads> threads;
	
	@OneToMany(mappedBy = "channel")
	@LazyCollection(LazyCollectionOption.FALSE)
	@JsonIgnoreProperties("channel")
	private List<ChannelMembers> members;
}
