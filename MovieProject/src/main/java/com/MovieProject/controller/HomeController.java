package com.MovieProject.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.MovieProject.Service.MovieService;
import com.MovieProject.dto.Member;
import com.MovieProject.dto.Movie;
import com.MovieProject.dto.Schedule;
import com.MovieProject.dto.Theater;
import com.google.gson.Gson;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private MovieService movsc;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home() {
		System.out.println("메인 페이지 이동요청");
		
		ModelAndView mav = new ModelAndView();
		//1. 영화 랭킹 목록 조회
		// SELECT * FROM MOVIES ORDER BY MVOP;
		ArrayList<Movie> rankMovList = movsc.selectMoive(); 
		mav.addObject("rankMovList", rankMovList);
		
		// 2. 이동 할 페이지 설정
		mav.setViewName("home");
		return mav;
	}
	
	@RequestMapping(value = "/detailMovie")
	public ModelAndView detailMovie(String mvcode)  {
		System.out.println("영화 상세 정보 페이지 이동요청");
		
		// 1. SERVICE - 영화정보 조회 메소드 호출
		Movie movieInfo =  movsc.selectMoiveInfo(mvcode);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("movieInfo", movieInfo);
		mav.setViewName("movie/DetailMovie");
		
		return mav;
	}
	
	@RequestMapping(value = "/movieList")
	public ModelAndView movieList()  {
		System.out.println("영화 목록 페이지 이동요청");
		ModelAndView mav = new ModelAndView();
		
		// 1. SERVICE - 영화정보 조회 메소드 호출
		
		ArrayList<Movie> MovList = movsc.MovieInfo();
		mav.addObject("mv", MovList);
	
		mav.setViewName("movie/movieList");
		
		return mav;
	}
	
	@RequestMapping(value = "/reserveMovie")
	public ModelAndView reserveMovie()  {
		System.out.println("영화 예매 페이지 이동요청 - /reserveMovie");
		ModelAndView mav = new ModelAndView();
		
		//영화 목록
		ArrayList<Movie> movList = movsc.getMovieList("ALL");
		mav.addObject("mvlist",movList);
		
//		극장 목록
		ArrayList<Theater> thList = movsc.getTheaterList("ALL");
		mav.addObject("thlist", thList);
		
		mav.setViewName("movie/ReservePage");
		
		return mav;
	}
	
	@RequestMapping(value = "/getMovieList_json")
	public @ResponseBody String getMovieList_json(String selectThCode) {
		System.out.println("예매페이지_영화 목록 조회 함정 /getMovieList_json");
		
		ArrayList<Movie> movList = movsc.getMovieList(selectThCode);
		
		System.out.println(movList);
		
		return new Gson().toJson(movList);

	}
	
	@RequestMapping(value = "/getTheaterList_json")
	public @ResponseBody String getTheaterList_json(String selectMvCode) {
		System.out.println("예매페이지_극장 목록 조회 함정 /getTheaterList_json");
		System.out.println("선택한 영화 코드 : " + selectMvCode);
		
		ArrayList<Theater> thList = movsc.getTheaterList(selectMvCode);
		
		System.out.println(thList);
		System.out.println(thList.size());
		
		return new Gson().toJson(thList);

	}
	
	@RequestMapping(value = "/getSchduleDateList_json")
	public @ResponseBody String getSchduleDateList_json(String mvcode , String thcode) {
		System.out.println("예매페이지_극장 목록 조회 함정 /getTheaterList_json");
		
		ArrayList<Schedule> shList = movsc.getSchduleDateList(mvcode, thcode);

		
		return new Gson().toJson(shList);

	}
	
	@RequestMapping(value = "/getReserveTimeListList_json")
	public @ResponseBody String getReserveTimeListList_json(String mvcode , String thcode, String scdate) {
		System.out.println("예매페이지_시간 목록 조회 함정 /getReserveTimeListList_json");
		System.out.println("선택한 영화 코드 : " + mvcode);
		System.out.println("선택한 극장 코드 : " + thcode);
		System.out.println("선택한 날짜 : " + scdate);
		
		ArrayList<Schedule> timeList = movsc.getReserveTimeListList(mvcode, thcode, scdate);
		
		System.out.println(timeList);
		System.out.println(timeList.size());	
		
		return new Gson().toJson(timeList);

	}
	
}
