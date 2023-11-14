package com.MovieProject.Service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MovieProject.Dao.MovieDao;
import com.MovieProject.dto.Movie;
import com.MovieProject.dto.Schedule;
import com.MovieProject.dto.Theater;
import com.MovieProject.dto.review;

@Service
public class MovieService {

	@Autowired
	private MovieDao MovieDao;
	
	@Autowired
	private AdminService adminsvc;
	
	public ArrayList<Movie> selectMoive() {
		System.out.println("MovieService - selectMoive()호출");
		
		ArrayList<Movie> movieTable = MovieDao.selectRankList();
		
		for(Movie mov : movieTable) {
			String movGrade = mov.getMvinfo().split(",")[0];
			System.out.println("movGrade : " + movGrade);
			
			movGrade = movGrade.substring(0,2);
			if(movGrade.equals("전체")) {
				movGrade = "All";
			}else if(movGrade.equals("청소")) {
				movGrade = "18";
			} 
			mov.setMvstate(movGrade);
		}
		
		return movieTable;
	}

	public Movie selectMoiveInfo(String mvcode) {
		System.out.println("MovieService - selectMoiveInfo()호출");
		
		Movie movieInfo = MovieDao.selectMovieInfo(mvcode);
		
//		System.out.println(movieInfo);
		return movieInfo;
	}

	public ArrayList<Movie> MovieInfo() {
		System.out.println("MovieService - MovieInfo()호출");
		
		ArrayList<Movie> movList = MovieDao.getMovieList("ALL");
		
		for(Movie mov : movList) {
			String movGrade = mov.getMvinfo().split(",")[0];
			
			movGrade = movGrade.substring(0,2);
			if(movGrade.equals("전체")) {
				movGrade = "All";
			}else if(movGrade.equals("청소")) {
				movGrade = "18";
			} 
			
			mov.setMvstate(movGrade);
		}
		return movList;
	}
	

	public ArrayList<Movie> getMovieList(String selThcode) {
		System.out.println("MovieService - getMovieList()호출");
		ArrayList<Movie> movList = MovieDao.getMovieList(selThcode);
		
		return movList;
	}



	public ArrayList<Theater> getTheaterList(String selMvcode) {
		System.out.println("MovieService - selectTheaterList()호출");
		
		return MovieDao.selectTheaterList(selMvcode);
	}

	public ArrayList<Schedule> getSchduleDateList(String mvcode, String thcode) {
		System.out.println("MovieService - getSchduleDateList()호출");
		return MovieDao.getSchduleDateList(mvcode, thcode);
	}

	public ArrayList<Schedule> getReserveTimeListList(String mvcode, String thcode, String scdate) {
		System.out.println("MovieService - getReserveTimeListList()호출");
		return MovieDao.getReserveTimeListList(mvcode, thcode, scdate);
	}

	public int registReview(review re) {
		System.out.println("MovieService - registReview()호출");
		
		String rvcodeMax = MovieDao.getMaxmvCode();
		
		String rvcode_gen = adminsvc.genCode(rvcodeMax);
		re.setRvcode(rvcode_gen);
		
		int insertResult = MovieDao.insertReview(re);
		
		return insertResult;
	}

	
}
