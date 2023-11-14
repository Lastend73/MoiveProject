package com.MovieProject.Api;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.MovieProject.dto.Reserve;

@Controller
public class ApiController {
	
	@Autowired
	private ApiService apisvc; 
	
	@RequestMapping(value = "/kakaoPay_ready")
	public @ResponseBody String kakaoPay_ready(Reserve reinfo , HttpSession session){
		System.out.println("카카오 결제 준비 요청 - /kakaoPay_ready");
		
		
		
		String result = apisvc.KakaoPay_ready(reinfo, session);
		System.out.println(reinfo);
		return result;
	}
	
	@RequestMapping(value = "/kakaoPay_approval")
	public ModelAndView kakaoPay_approval(String pg_token, HttpSession session){
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("카카오 결제 승인 요청 - /kakaoPay_approval");
		System.out.println("pg_token : " + pg_token);
		
		String tid = (String)session.getAttribute("tid");
		System.out.println("tid : " + tid);
		
		String result = apisvc.kakaoPay_approval(tid, pg_token);
		
		if(result == null) {
			System.out.println("결제 오류");
			mav.addObject("payResult","N");	
		}else {
			System.out.println("결제 승인");
			mav.addObject("payResult","Y");
		}
		
		mav.setViewName("hello");
		return mav;
	}
	
	@RequestMapping(value = "/kakaoPay_cancel")
	public ModelAndView kakaoPay_ready(){
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("payResult","N");
		System.out.println("카카오 결제 최소 요청 - /kakaoPay_cancel");
		
		
		mav.setViewName("hello");
		
		return mav;
	}
	
	@RequestMapping(value = "/deleteReserveCode")
	public @ResponseBody String deleteReserveCode(String reserveCode ){
		System.out.println("DELETE 요청 - /deleteReserveCode");
		
		System.out.println("reserveCode : " + reserveCode);
		
		int result = apisvc.KakaoPay_cancel(reserveCode);
		
		
		return "";
	}
	

}
