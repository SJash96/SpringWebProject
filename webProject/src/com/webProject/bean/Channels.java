package com.webProject.bean;

import java.sql.Timestamp;
import java.util.Arrays;
import java.util.LinkedHashSet;
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
import javax.persistence.Transient;

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
	private Timestamp channelcreated;
	
	@Transient
	private String channelsarray[] = {"General", "News", "Gaming", "Music", "Movie Reviews", "Life Style"};
	@Transient
	private LinkedHashSet<String> channelcategories = new LinkedHashSet<>(Arrays.asList(channelsarray));
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "user_id", referencedColumnName = "uid")
	private Users user;
	
	@OneToMany(mappedBy = "channel", fetch = FetchType.EAGER)
	@OrderBy("threadcreated desc")
	private List<Threads> threads;
	
	@OneToMany(mappedBy = "channel", fetch = FetchType.EAGER)
	private List<ChannelFollowers> followers;
}
