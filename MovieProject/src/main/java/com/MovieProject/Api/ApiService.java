package com.MovieProject.Api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MovieProject.Dao.MovieDao;
import com.MovieProject.dto.Reserve;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class ApiService {

	@Autowired
	MovieDao mdao;
	
	public String KakaoPay_ready(Reserve reinfo, HttpSession session) {
		System.out.println("service-KakaoPay_ready()");
		String requestUrl = "https://kapi.kakao.com/v1/payment/ready";
		
		
		/*
		partner_order_id  	가맹점 주문번호, 최대 100자 O, "RE00000'
		partner_user_id 	가맹점 회원 id, 최대 100자  O, "THESTID
	 	item_name 			상품명, 최대 100자 "영화제목",
	 	quantity 			상품 수량 O, // 1
		total_amount,		상품 총액 O // 상품총액 12,000
		tax_free_amount 	상품 총액 O	
		approval_url		결제 성공 시 redirect url, 최대 255자 O http://localhost:8080/kakaopay_approva.
		cancel_url 			결제 취소 시 redirect url, 최대 255자 O http://localhost:8080/kakaopay,approva
		fail_url 			결제 실패 시 redirect url, 최대 255자 O http://localhost:8080/kakaopay,approva
		 */
		
		HashMap<String, String> requestParams = new HashMap<String, String>();

		requestParams.put("partner_order_id", "RE00000");
		requestParams.put("partner_user_id", "TESTID");
		requestParams.put("item_name", "RE00000");
		requestParams.put("quantity", "1");
		requestParams.put("total_amount", "12000");
		requestParams.put("tax_free_amount", "0");
		requestParams.put("approval_url", "http://localhost:8080/kakaoPay_approval");
		requestParams.put("cancel_url", "http://localhost:8080/kakaoPay_cancel");
		requestParams.put("fail_url", "http://localhost:8080/kakaoPay_fail");

		String result = null;

		try {
			String response = kakoResponse_json(requestUrl, requestParams);

			// tid, next_redirect_pc_url
			JsonObject re = (JsonObject) JsonParser.parseString(response);

			String tid = re.get("tid").getAsString();
			String nextUrl = re.get("next_redirect_pc_url").getAsString();

			System.out.println("tid : " + tid);
			session.setAttribute("tid", tid);
			System.out.println("nextUrl : " + nextUrl);
			result = nextUrl;

		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}

	private String kakoResponse_json(String requestUrl, HashMap<String, String> requestParams) throws IOException {
		System.out.println("service-kakoResponse_json() 호출");
		
		StringBuilder urlBuilder = new StringBuilder(requestUrl); /* URL */
		
		urlBuilder.append("?" + URLEncoder.encode("cid", "UTF-8")+ "=TC0ONETIME"); // 가맹점 코드(CID)
		
		for(String key : requestParams.keySet()) {
			urlBuilder.append("&" + URLEncoder.encode(key , "UTF-8") + "=" + URLEncoder.encode(requestParams.get(key), "UTF-8")); /* 페이지번호 */
		}
		
		
		URL url = new URL(urlBuilder.toString());
		
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		
		//요청 : 헤더
		conn.setRequestProperty("Authorization", "KakaoAK eb7f592e59eda115833db1500ca33d62");
		conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		System.out.println("Response code: " + conn.getResponseCode());
		
		if(conn.getResponseCode() != 200) {
			// tid, next_redirect_pc_url
			return null;
		}
		
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		System.out.println(sb.toString());
		
		return sb.toString();
	}

	public String kakaoPay_approval(String tid, String pg_token) {
		System.out.println("service-kakoResponse_json() 호출");
		
		String url = "https://kapi.kakao.com/v1/payment/approve";
		HashMap<String, String> requestParams = new HashMap<String, String>();
		
		requestParams.put("tid", tid);
		requestParams.put("partner_order_id", "RE00000");
		requestParams.put("partner_user_id", "TESTID");
		requestParams.put("pg_token", pg_token);
		
		String result = null;
		try {
			String response = kakoResponse_json(url,requestParams);
			result = response;
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		return result;
	}

	public int KakaoPay_cancel(String reserveCode) {
		
		
		return mdao.KakaoPay_cancel(reserveCode);
	}
}
