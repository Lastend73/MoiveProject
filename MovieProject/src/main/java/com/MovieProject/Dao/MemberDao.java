package com.MovieProject.Dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.MovieProject.dto.Member;
import com.MovieProject.dto.Movie;
import com.MovieProject.dto.Reserve;


public interface MemberDao {

	Member selectMemberInfo(String id);

	int insertMember_kakao(Member member);

	int InsertMemInfo(Member mem);

	Member SelectLoginInfo(@Param("mid")String mid, @Param("mpw")String mpw);

	String selectMemberIdcheck(String inputId);

	String getMaxRegistCode();

	int registReserveInfo(Reserve reinfo);

	ArrayList<HashMap<String, String>> selectReserveList(String loginId);

	int deleteReserveList(String recode);

	String selectReviewCode(String recode);



}
