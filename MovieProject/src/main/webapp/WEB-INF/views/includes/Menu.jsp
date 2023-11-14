<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
			<div class="container">
				<!-- 8080/boardList -->
				<a class="navbar-brand" href="${pageContext.request.contextPath}/">MOVIES
					PROJECT</a>
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
					data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
					aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link" href="movieList">영화</a></li>
						<li class="nav-item"><a class="nav-link" href="/reserveMovie">예매</a></li>

						<c:choose>
							<c:when test="${sessionScope.loginId == null }">
								<li class="nav-item"><a class="nav-link" href="/memberLoginForm">로그인</a></li>
								<li class="nav-item"><a class="nav-link active" href="/memberJoinForm">회원가입</a></li>
							</c:when>
							<c:otherwise>
								<li class="nav-item"><a class="nav-link" href="/memberInfo">내정보</a></li>
								<li class="nav-item"><a class="nav-link" href="/reserveList">예매내역</a></li>
								<li class="nav-item"><a class="nav-link active" href="/memberLogout">로그아웃</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</nav>