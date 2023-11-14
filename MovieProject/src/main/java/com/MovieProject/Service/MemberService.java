package com.MovieProject.Service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.MovieProject.Dao.MemberDao;
import com.MovieProject.dto.Member;
import com.MovieProject.dto.Reserve;

@Service
public class MemberService {

	@Autowired
	private MemberDao mdao;

	public Member getLoginMemberInfo_kakao(String id) {
		System.out.println("Service - getLoginMemberInfo");
		return mdao.selectMemberInfo(id);
	}

	public int registMember_kakao(Member member) {
		System.out.println("Service - registMember_kakao()호출");
		return mdao.insertMember_kakao(member);
	}

	public int insertMemberInfo(Member mem, HttpSession session) throws IllegalStateException, IOException {
		System.out.println("Service - insertMemberInfo()호출");
		
		MultipartFile mfile = mem.getMfile();
		String mfilename = ""; // 파일명 저장할 변수

		String savePath = session.getServletContext().getRealPath("/resources/users/MemberUpload"); // 파일을 저장할 경로

		// .isEmpty 비어있으면 true 없우묜 false
		if (!mfile.isEmpty()) { // 첨부파일 확인
			// bfile.isEmpty() 첨부파일이 없는 경우 true
			// !bfile.isEmpty() 파일이 있는 경우 true
			System.out.println("첨부파일 있음");

			// 임의의 코드 + img3.jpg
			// UUID 32자리 랜덤 코드
			UUID uuid = UUID.randomUUID();

			String code = uuid.toString();
			System.out.println("code : " + code);

			mfilename = code + "_" + mfile.getOriginalFilename();
			System.out.println("savePath  :" + savePath);

//			File newFile = new File("경로","파일명");
			File newFile = new File(savePath, mfilename);
			mfile.transferTo(newFile);

			// 저장할 경로 resources/boardUpload 폴더에 파일저장
			// D:\spring-workspace\project\src\main\webapp\resources\boardUpload
		}

		System.out.println("파일이름 : " + mfilename);
		mem.setMfilename(mfilename);
	

		// INSERT 결과 변환
		int result = 0;
		try {
			result = mdao.InsertMemInfo(mem);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}

	public Member SelectLogin(String mid, String mpw) {
		System.out.println("Service - SelectLogin()호출");
		
		Member LoginInfo = mdao.SelectLoginInfo(mid,mpw);
		return LoginInfo;
	}

	public String memIdcheck(String inputId) {
		System.out.println("Service - SelectLogin()호출");
//		String result = mdao.selectMemberIdcheck(inputId);
//		if(result == null) {
//			return "Y";
//		}else {
//			return "N";
//		}
		return mdao.selectMemberIdcheck(inputId);
	}
	
	@Autowired 
	private AdminService adminsvc;

	public String registReserveInfo(Reserve reinfo) {
		//1. 예메코드 생성 (RE00001)
		// 가장 큰값 가져오기
		String recode_Max = mdao.getMaxRegistCode();
		
		// Select NVL(MAX(RECODE),'RE00000') FROM RESERVES
		String recode_gen = adminsvc.genCode(recode_Max);
		
		reinfo.setRecode(recode_gen);
		System.out.println(reinfo);
		
		//2. DAO - INSERT	
		int registReserveInfo_result = mdao.registReserveInfo(reinfo);;
		
		if(registReserveInfo_result > 0 ) {
			return recode_gen;
		}else {
			return null;
		}
	}

	public ArrayList<HashMap<String, String>> getReserveList(String loginId) {
		/*
		 <select id = selectreserveList resultType = hashmap>
		 	SELECT MVTITLE , THNAME, SCHALL, SCDATE
		  </select>
		  */
		 ArrayList<HashMap<String, String>> reList = mdao.selectReserveList(loginId);
		 
		 for(HashMap<String, String> re : reList) {
			 String recode = re.get("RECODE");//
			 System.out.println("RECODE : " +recode);
			 String rvcode = mdao.selectReviewCode(recode);
			 re.put("RVCODE", rvcode);
		 }
		
		return reList;
	}

	public int cancelReserve(String recode) {
		
		return  mdao.deleteReserveList(recode);
	}
	
	


	
	
}
