package com.MovieProject.Dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.MovieProject.dto.Movie;
import com.MovieProject.dto.Schedule;
import com.MovieProject.dto.Theater;
import com.MovieProject.dto.review;


public interface MovieDao {

	// 영화 인기 순위 조회
	ArrayList<Movie> selectRankList();
	
	//영화 상세정보 조회
	Movie selectMovieInfo(String mvcode);

	// 극장 목록 조회
	ArrayList<Theater> selectTheaterList(String selMvcode);

	// 영화 목록 조회
	ArrayList<Movie> getMovieList(String selThcode);

	ArrayList<Schedule> getSchduleDateList(@Param("mvcode")String mvcode, @Param("thcode")String thcode);

	ArrayList<Schedule> getReserveTimeListList(@Param("mvcode")String mvcode, @Param("thcode")String thcode, @Param("scdate") String scdate);

	int KakaoPay_cancel(String reserveCode);

	String getMaxmvCode();

	int insertReview(review re);

}
