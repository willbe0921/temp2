package sist.com;

import java.io.Serializable;

public class MemberDto implements Serializable {
	
	
	/*drop table MEMBER
	cascade constraints;*/
	
	
	/*create table MEMBER(
			id varchar2(50) primary key,
			name varchar2(50) not null,
			pwd varchar2(50) not null,
			email varchar2(50) unique,
			auth number(1) not null
		);*/
	

	private static final long serialVersionUID = -4328788013425944595L;
	
	private String id;
	private String name;
	private String pwd;
	private String email;
	private int auth;
	
	public MemberDto() {
	}
	
	
	public MemberDto(String id, String name, String pwd, String email, int auth) {
		super();
		this.id = id;
		this.name = name;
		this.pwd = pwd;
		this.email = email;
		this.auth = auth;
	}
	public MemberDto(String name, String pwd, String email ,int auth) {
		
		this(null, name, pwd, email, 3);
	}



	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getPwd() {
		return pwd;
	}



	public void setPwd(String pwd) {
		this.pwd = pwd;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public int getAuth() {
		return auth;
	}



	public void setAuth(int auth) {
		this.auth = auth;
	}



	@Override
	public String toString() {
		return "MemberDto [id=" + id + ", name=" + name + ", pwd=" + pwd + ", email=" + email + ", auth=" + auth + "]";
	}
	
	
	
	
	
}
