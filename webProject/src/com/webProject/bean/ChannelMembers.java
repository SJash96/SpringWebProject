package com.webProject.bean;

import java.sql.Timestamp;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity
public class ChannelMembers {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int cmid;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss.S", timezone = "EST")
	private Timestamp channeljoined;
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "channel_id", referencedColumnName = "cid")
	private Channels channel;
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "user_id", referencedColumnName = "uid")
	private Users user;
}
