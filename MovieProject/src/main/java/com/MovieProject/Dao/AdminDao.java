package com.MovieProject.Dao;

import java.util.ArrayList;

import com.MovieProject.dto.Movie;
import com.MovieProject.dto.Schedule;
import com.MovieProject.dto.Theater;

public interface AdminDao {

	String selectMaxMvCode();

	int insertMovie(Movie mov);

	String selectThMaxMvCode();

	int insertTheater(Theater th);

	int insertSchedule(Schedule sc);

	ArrayList<Movie> selectMapperTest(String selthcode);

}
