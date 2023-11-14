package com.MovieProject.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.MovieProject.Service.MemberService;
import com.MovieProject.dto.Member;
import com.MovieProject.dto.Reserve;

@Controller
public class MemberController {

	@Autowired
	MemberService msvc;

	@RequestMapping(value = "/memberLoginForm")
	public ModelAndView memberLoginForm() {
		System.out.println("로그인 페이지 이동요청 - /memberLoginForm");

		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/MemberLoginForm");

		return mav;
	}

	@RequestMapping(value = "/memberLogin_kakao")
	public @ResponseBody String memberLogin_kakao(String id, String profile, HttpSession session) {
		System.out.println("카카오 로그인 요청 - /memberLogin_kakao");
		System.out.println("카카오 id : " + id);

		Member loginMember = msvc.getLoginMemberInfo_kakao(id);

		if (loginMember == null) {
			System.out.println("카카오 계정 정보 없음");
			return "N";
		} else {
			System.out.println("카카오 계정 정보 있음");
			System.out.println("로그인 처리");
			session.setAttribute("loginId", loginMember.getMid());
			session.setAttribute("loginName", loginMember.getMname());
			session.setAttribute("loginProfile", profile);
			session.setAttribute("loginState", loginMember.getMstate());
			return "Y";
		}
	}

	@RequestMapping(value = "/memberJoin_kakao")
	public @ResponseBody String memberJoin_kakao(Member member) {
		System.out.println("카카오 회원가입 요청 - /memberJoin_kakao");
		System.out.println(member);
		int result = msvc.registMember_kakao(member);
		return result + "";

	}

	@RequestMapping(value = "/memberJoinForm")
	public ModelAndView memberJoinForm() {
		System.out.println("회원가입 페이지 이동요청 - /memberJoinForm");

		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/MemberJoinForm");

		return mav;
	}

	@RequestMapping(value = "/memberJoin")
	public ModelAndView memberJoin(Member mem, String memail_Foward, String memaill_Back, HttpSession session,RedirectAttributes rs) throws IllegalStateException, IOException{
		System.out.println("회원가입 요청 - /memberJoin");
		ModelAndView mav = new ModelAndView();
		
		mem.setMemail(memail_Foward + "@" + memaill_Back);
		
		System.out.println(mem);
		
		// 첨부 파일이름
		System.out.println("파일이릉 : "+mem.getMfile().getOriginalFilename());
		
		int insertMemberInfo = msvc.insertMemberInfo(mem , session);
		
		if(insertMemberInfo > 0) {
			mav.setViewName("redirect:/");
			rs.addFlashAttribute("msg","회원가입에 성공했습니다");
		}else {
			mav.setViewName("redirect:/memberJoinForm");
			rs.addFlashAttribute("msg","회원가입에 실패했습니다");
		}

		return mav;
	}
	
	@RequestMapping(value = "/memberLogin")
	public ModelAndView memberLogin(Member mem,  HttpSession session,RedirectAttributes rs) throws IllegalStateException, IOException{
		System.out.println("회원가입 요청 - /memberLogin");
		ModelAndView mav = new ModelAndView();
		
		Member mem1 = msvc.SelectLogin(mem.getMid(), mem.getMpw());
		
		if(mem1 !=null) {
			System.out.println("로그인에 성공하였습니다");
			
			//session.setAttribute("loginMember", mem1);
			
			String mstate = mem1.getMstate().substring(0,1);
			System.out.println(mstate);
			System.out.println(mstate.equals("Y"));
			System.out.println(mstate.equals("N"));
			
			session.setAttribute("loginId", mem1.getMid());
			session.setAttribute("loginName", mem1.getMname());
			session.setAttribute("loginProfile", mem1.getMprofile());
			session.setAttribute("loginState", mem1.getMstate()); // 프로필 사진의 구별을 위해 사용 ex) 카카오면 URL, 일반이면 파일경로 
			rs.addFlashAttribute("msg","로그인에 성공하였습니다");
			mav.setViewName("redirect:/");
		}else {
			System.out.println("로그인에 실패하였습니다");
			rs.addFlashAttribute("msg","아이디 또는 비밀번호가 일치하지 않습니다.");
			mav.setViewName("redirect:/memberLoginForm");
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/memberLogout")
	public ModelAndView memberLogout(HttpSession session){
		System.out.println("로그아웃 요청 - /memberLogin");
		ModelAndView mav = new ModelAndView();
		session.invalidate();
		
		mav.setViewName("redirect:/");
		return mav;
	}
	
	
	@RequestMapping(value = "/memberIdCheck")
	public @ResponseBody String memberIdCheck(String inputId) {
		System.out.println("아이디 중복확인  요청 - /memberIdCheck");
		System.out.println("중복 확인할 아이디 : " + inputId);
		
		// "ALL" 이거나 영화코드
		return msvc.memIdcheck(inputId);

	}
	
	@RequestMapping(value = "/registReserveInfo")
	public @ResponseBody String registReserveInfo(Reserve reinfo, HttpSession session) {
		System.out.println("예메 처리 요청 - /registReserveInfo");
		System.out.println(reinfo);
		
		String loginId = (String)session.getAttribute("loginId");
		
		if(loginId == null) {
			return "login";
		}else {
			reinfo.setMid(loginId);
			String registResult = msvc.registReserveInfo(reinfo);		
			return registResult+"";
			
		}
	}
	
	@RequestMapping(value = "/reserveList")
	public ModelAndView reserveList(HttpSession session, RedirectAttributes rs) {
		System.out.println("예매 내역 페이지 이동요청 - /reserveList");
		ModelAndView mav = new ModelAndView();
		
		String loginId = (String)session.getAttribute("loginId");
		System.out.println("현재 접속중인 아이디 : " + loginId);
		
		if(loginId == null) {
			rs.addFlashAttribute("msg","로그인후 이용해주세요");
			mav.setViewName("redirect:/MemberLoginFrom ");
			return mav;
		}
		
		// 예매 목록 조회 (영화제목, 극장, 상영관, 상영시간)
		ArrayList<HashMap<String, String> > reserveList = msvc.getReserveList(loginId);
			
		System.out.println(reserveList);
		mav.addObject("reserveList",reserveList);
		mav.setViewName("member/ReserveList");
		return mav;

	}
	
	@RequestMapping(value = "/cancelReserve")
	public ModelAndView cancelReserve(String recode, RedirectAttributes rs) {
		System.out.println("예매 내역 삭제 요청 - /cancelReserve");
		ModelAndView mav = new ModelAndView();
		System.out.println("recode : " + recode);
		int cancelResult = msvc.cancelReserve(recode);
		
		if(cancelResult>0) {
			rs.addFlashAttribute("msg","예약이 삭제되었습니다.");
		} else {
			rs.addFlashAttribute("msg","예약이 삭제에 문제가 발생했습니다.");
		}
		
		mav.setViewName("redirect:/reserveList");
		return mav;

	}

}
