package com.MovieProject.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Member {
	private String mid;			//아이디
	private String mpw;			//비밀번호
	private String mname;		//이름
	private String memail;		//이메일
	private String mdate;		//가입일
	private String mprofile;	//프로필이미지
	private String mstate;		//상태
	
	private MultipartFile mfile;
	private String mfilename;
}
