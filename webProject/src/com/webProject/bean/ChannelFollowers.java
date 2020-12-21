package com.webProject.bean;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity
@Table(name = "ChannelFollowers")
public class ChannelFollowers {
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "user_id", referencedColumnName = "uid")
	private Users user;
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "channel_id", referencedColumnName = "cid")
	private Channels channel;
}
