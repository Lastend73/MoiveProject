package com.MovieProject.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.MovieProject.Dao.MovieDao;
import com.MovieProject.Service.AdminService;
import com.MovieProject.Service.MovieService;
import com.MovieProject.dto.review;

@Controller
public class adminController {

	
	@Autowired
	private AdminService adsvc;
	
	@Autowired
	private MovieService mosvc;
	
	@RequestMapping(value = "/getCgvMovieInfo")
	public ModelAndView getCgvMovieInfo() throws IOException {
		System.out.println("영화정보 수집요처 - /getCgvMovieInfo");
		// 추가된 영화 개수
		int addCount = adsvc.addCgvMovies();
		System.out.println("추가 : " + addCount);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		return mav;
		
	}
	
	@RequestMapping(value = "/getCgvTheaterInfo")
	public ModelAndView getCgvTheaterInfo() throws IOException {
		System.out.println("CGV극장 정보 수집 요청 - /getCgvTheaterInfo");
		
		int addCount = adsvc.addCgvTheaters();
		System.out.println("추가 : " + addCount);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		return mav;
	}
	
	@RequestMapping(value = "/getCgvScheduleInfo")
	public ModelAndView getCgvScheduleInfo() throws IOException {
		System.out.println("CGV극장 정보 수집 요청 - /getCgvTheaterInfo");
		
		int addCount = adsvc.addCgvScheduleInfo();
		System.out.println("추가 : " + addCount);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		return mav;
	}
	
	@RequestMapping(value = "/mapperTest")
	public String mapperTest(String thcode) {
		System.out.println("선택한 극장 : " + thcode);
		
		adsvc.mapperTest_Moive(thcode);
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/reviewWriteForm")
	public ModelAndView reviewWriteForm(String recode) {
		System.out.println("관란평 작성 페이지 이동요청 - /reviewWriteForm");
		ModelAndView mav = new ModelAndView();
		
		// 관람한 영화 정보 조회
		
		mav.setViewName("movie/ReviewWriteForm");
		return mav;
	}
	
	@RequestMapping(value = "/registReview")
	public ModelAndView registReview(review re,HttpSession session) {
		System.out.println("관란평 작성 요청 - /registReview");
		ModelAndView mav = new ModelAndView();
		re.setMid((String)session.getAttribute("loginId"));
		// Insert 
				
		int resultReview = mosvc.registReview(re);
		mav.setViewName("redirect:/reserveList");
		return mav;
	}
}
