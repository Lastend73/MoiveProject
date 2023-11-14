package com.MovieProject.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.PageLoadStrategy;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MovieProject.Dao.AdminDao;
import com.MovieProject.dto.Movie;
import com.MovieProject.dto.Schedule;
import com.MovieProject.dto.Theater;

@Service
public class AdminService {

	@Autowired
	private AdminDao adminDao;

	/* addCgvMovies() 시작 */
	public int addCgvMovies() throws IOException {
		System.out.println("AdminService - addCgvMovies호출");
		// cgv 영화 정보수집
		// jsoup 사용
		// 무비차드 페이지 접속 >> 영화 상세 페이지 URL(19개) 수집
		String cgvRankUrl = "http://www.cgv.co.kr/movies/?lt=1&ft=0";

		Document cgvRankDoc = Jsoup.connect(cgvRankUrl).get();
		Elements urlsItems = cgvRankDoc.select("div.sect-movie-chart>ol>li>div.box-image>a");
		;

		ArrayList<Movie> movieList = new ArrayList<Movie>();
		for (Element urlsItem : urlsItems) {

			Movie movie = new Movie();

			String detailUrl = "http://www.cgv.co.kr" + urlsItem.attr("href");
			Document detailDoc = Jsoup.connect(detailUrl).get();

			String mvTitle = detailDoc
					.select("#select_main > div.sect-base-movie > div.box-contents > div.title > strong").text();
			System.out.println("영화제목 : " + mvTitle);
			movie.setMvtitle(mvTitle);

			String mvDirector = detailDoc.select(
					"#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd:nth-child(2) > a")
					.text();
			System.out.println("영화감독 : " + mvDirector);
			movie.setMvdirector(mvDirector);

			String mvActors = detailDoc
					.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd.on").get(0)
					.text();
			mvActors = mvActors.replace(" , ", ", ");
			System.out.println("배우 : " + mvActors);
			movie.setMvactors(mvActors);

			String mvgenre = detailDoc
					.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd.on").get(0)
					.nextElementSibling().text();
			mvgenre = mvgenre.replace("장르 :", "").replace(", ", ",").trim();
			System.out.println("장르 : " + mvgenre);
			movie.setMvgenre(mvgenre);

			String mvInfo = detailDoc
					.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd.on").get(1)
					.text();
			System.out.println("기본정보 : " + mvInfo);
			movie.setMvinfo(mvInfo);

			String mvOpen = detailDoc
					.select("#select_main > div.sect-base-movie > div.box-contents > div.spec > dl > dd.on").get(2)
					.text();
			mvOpen = mvOpen.substring(0, 10);
			System.out.println("개봉일 : " + mvOpen);
			movie.setMvopen(mvOpen);

			String mvPoster = detailDoc.select("#select_main > div.sect-base-movie > div.box-image > a > span > img")
					.attr("src");
			System.out.println("포스터 : " + mvPoster);
			movie.setMvposter(mvPoster);

			System.out.println();
			movieList.add(movie);
//			break;
		}
		System.out.println(movieList.size());
		// DB- MOVIES 테이블 INSERT

		// MOVIES 테이블 MVCODE 최대값 조회
		String maxMvcode = adminDao.selectMaxMvCode();
		System.out.println("maxMvcode : " + maxMvcode);// mv00000

		int insertCount = 0;
		for (Movie mov : movieList) {
			// 1. 영화코드 생성
			String mvcode = genCode(maxMvcode);
//			System.out.println("mvcode : " + mvcode);
			mov.setMvcode(mvcode);
			System.out.println(mov);

			// 2. MOVIES 테이블 INSERT
			try {
				int insertResult = adminDao.insertMovie(mov);
				insertCount += insertResult;
				maxMvcode = mvcode;
			} catch (Exception e) {
				continue;
			}

		}
		return insertCount;
	}
	/* addCgvMovies() 종료 */

	// 코드 생성 메소드
	public String genCode(String currentCode) {
		System.out.println("genCode() 호출 : " + currentCode);

		// currentCode = MV00000 :: 앞2자리 영문, 뒤 5자리 숫자
		String strCode = currentCode.substring(0, 2);
		System.out.println("strCode : " + strCode);

		int numCode = Integer.parseInt(currentCode.substring(2));
		System.out.println("numCode : " + numCode);

		String newCode = strCode + String.format("%05d", numCode + 1);
		;

		return newCode;
	}

	private ArrayList<String> getTheaterUrls() {
		System.out.println("AdminService - getTheaterUrls호출");
		ChromeOptions options = new ChromeOptions();
		options.setPageLoadStrategy(PageLoadStrategy.NORMAL);
//		options.addArguments("headless");

		WebDriver driver = new ChromeDriver(options);
		String cgvTheaterUrl = "http://www.cgv.co.kr/theaters/";
		driver.get(cgvTheaterUrl);
		List<WebElement> theaterUrls = driver.findElements(By.cssSelector("div.sect-city>ul>li>div.area>ul>li>a"));
//		System.out.println("theaterUrls.size() : " + theaterUrls.size());

		ArrayList<String> thUrls = new ArrayList<String>();
		for (WebElement theater : theaterUrls) {
			String thUrl = theater.getAttribute("href");
			thUrls.add(thUrl);
		}
		driver.quit();
		return thUrls;
	}

	public int addCgvTheaters() {
		System.out.println("AdminService - addCgvTheaters()호출");

		// 극장 페이지 URL 수정 기능 호출
		ArrayList<String> theaterUrls = getTheaterUrls();
		System.out.println(theaterUrls.size());

		ChromeOptions options = new ChromeOptions();
		options.setPageLoadStrategy(PageLoadStrategy.NORMAL);
//		options.addArguments("headless");

		WebDriver driver = new ChromeDriver(options);

		ArrayList<Theater> thList = new ArrayList<Theater>();

		int idx = 0;
		for (String url : theaterUrls) {
			driver.get(url);
			try {
				Theater th = new Theater();
				WebElement titleElement = driver
						.findElement(By.cssSelector("#contents > div.wrap-theater > div.sect-theater > h4 > span"));
				String thname = titleElement.getText();
				th.setThname(thname);
				System.out.println("극장 : " + thname);

				WebElement addrElement = driver.findElement(By.cssSelector(
						"#contents > div.wrap-theater > div.sect-theater > div > div.box-contents > div.theater-info > strong"));
				String thaddr = addrElement.getText();
				thaddr = thaddr.replace("위치/주차 안내 >", "");
				thaddr = thaddr.split("\n")[0];
				th.setThaddr(thaddr);
				System.out.println("주소 : " + thaddr);

				WebElement telElement = driver.findElement(By.cssSelector(
						"#contents > div.wrap-theater > div.sect-theater > div > div.box-contents > div.theater-info > span.txt-info > em:nth-child(1)"));
				String thtel = telElement.getText();
				th.setThtel(thtel);
				System.out.println("전화번호 : " + thtel);

				WebElement infoElement = driver.findElement(By.cssSelector(
						"#contents > div.wrap-theater > div.sect-theater > div > div.box-contents > div.theater-info > span.txt-info > em:nth-child(2)"));
				String thinfo = infoElement.getText();
				th.setThinfo(thinfo);
				System.out.println("정보 : " + thinfo);

				WebElement imgElement = driver.findElement(By.cssSelector("#theater_img_container > img"));
				String thimg = imgElement.getAttribute("src");
				th.setThimg(thimg);
				System.out.println("정보 : " + thimg);

				thList.add(th);
			} catch (Exception e) {

				continue;

			}

		}

		// CGV 극장 정보 202개 수집
		System.out.println("thList.size" + thList.size());

		int result = 0;
		// THEATERS 테이블 THCODE 최대값 조회 >TH00000
		for (Theater th : thList) {
			String theaterMaxCode = adminDao.selectThMaxMvCode();
			String theaterCode = genCode(theaterMaxCode);
			th.setThcode(theaterCode);
			// DB- THEATERS 테이블 INSERT
			int insertResult = adminDao.insertTheater(th);
			result += insertResult;
		}

//		List<WebElement> showtimes =  driver.findElements(By.cssSelector("body > div > div.sect-showtimes > ul > li"));
//		
//		for(WebElement showtime : showtimes) {
//			String mvtitle = showtime.findElement(By.cssSelector("div > div.info-movie > a > strong")).getText();
//			System.out.println("mvtitle : " + mvtitle);
//			List<WebElement> type_Halls = showtime.findElements(By.cssSelector(" div.col-times>div.type-hall"));
//			System.out.println(type_Halls.size());
//		}
		driver.quit();
		return result;

	}

	public int addCgvScheduleInfo() {
		System.out.println("AdminService - addCgvTheaters()호출");
		ArrayList<String> theaterUrls = getTheaterUrls();

		ChromeOptions options = new ChromeOptions();
		options.setPageLoadStrategy(PageLoadStrategy.NORMAL);
//		options.addArguments("headless");
		WebDriver driver = new ChromeDriver(options);

		ArrayList<Schedule> SchedeuleList = new ArrayList<Schedule>();

		for (String thurl : theaterUrls) {
			driver.get(thurl);
			try {
				String thname = driver
						.findElement(By.cssSelector("#contents > div.wrap-theater > div.sect-theater > h4 > span"))
						.getText();
//				System.out.println("극장 : " + thname);
				driver.switchTo().frame(driver.findElement(By.id("ifrm_movie_time_table")));

				List<WebElement> dayList = driver.findElements(By.cssSelector("#slider > div:nth-child(1) > ul > li"));

				for (int i = 0; i < dayList.size(); i++) {

					if (i > 0) {
						driver.findElement(By.cssSelector("#slider > div:nth-child(1) > ul > li.on+li")).click();
					}

					String mm = driver
							.findElement(By.cssSelector("#slider > div:nth-child(1) > ul > li.on > div > a > span"))
							.getText();

					mm = mm.replace("월", "");
					String dd = driver
							.findElement(By.cssSelector("#slider > div:nth-child(1) > ul > li.on > div > a > strong"))
							.getText();
//					System.out.println(mm + dd);

					List<WebElement> showtimes = driver
							.findElements(By.cssSelector("body > div > div.sect-showtimes > ul > li"));

					for (WebElement showtime : showtimes) {

						// 예매 가능한 영화 제목
						String mvtitle = showtime.findElement(By.cssSelector("div > div.info-movie > a > strong"))
								.getText();

						// 예매 가능한 상영관
						List<WebElement> type_Halls = showtime
								.findElements(By.cssSelector(" div.col-times>div.type-hall"));
//						System.out.println("mvtitle : " + mvtitle + ":: " + type_Halls.size());

						for (WebElement hall : type_Halls) {
							// 예매 가능한 상영관 이름 : 1관

							String hallName = hall.findElement(By.cssSelector(" div.info-hall > ul > li:nth-child(2)"))
									.getText();
//							System.out.println("상영관 : " + hallName);

							List<WebElement> timeList = hall
									.findElements(By.cssSelector("div.info-timetable > ul > li >a> em"));

							for (WebElement time : timeList) {
								String hallTime = time.getText();
								System.out.println(thname + " : " + mm + dd + " : " + mvtitle + " : " + hallName + " : "
										+ hallTime);
								Schedule schedule = new Schedule();
								schedule.setMvcode(mvtitle);
								schedule.setThcode(thname);
								schedule.setSchall(hallName);
								schedule.setScdate("2023" + mm + dd + " " + hallTime); // 20230824 18:30

								SchedeuleList.add(schedule);
							}
							System.out.println();
						}

					}

				}
			} catch (Exception e) {
				continue;
			}
//			break;
		}

		System.out.println("SchedeuleList.size()"+SchedeuleList.size());
		int insertCount = 0;
		for (Schedule sc : SchedeuleList) {
			try {
				int insertResult = adminDao.insertSchedule(sc);
				insertCount += insertResult;
			} catch (Exception e) {
				continue;
			}
		}

		driver.quit();
		return insertCount;
	}

	public void mapperTest_Moive(String thcode) {
		System.out.println("service");
		
		ArrayList<Movie> movList = adminDao.selectMapperTest(thcode);
		System.out.println("극장선택O 경우 : " +movList.size());
		
		ArrayList<Movie> movList2 = adminDao.selectMapperTest(null);
		System.out.println("극장선택X 경우 : " +movList2.size());
	}
}
