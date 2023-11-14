<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page session="false" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>영화예매프로젝트 - MOVIESPROJECT</title>
                <!-- Favicon-->
                <link rel="icon" type="image/x-icon"
                    href="${pageContext.request.contextPath}/resources/users/assets/favicon.ico" />
                <!-- Core theme CSS (includes Bootstrap)-->
                <link href="${pageContext.request.contextPath}/resources/users/css/styles.css" rel="stylesheet" />
                <style>
                    .ageInfo {
                         
                        text-align: center;
                        border-radius: 10px;
                        padding: 3px 5px;
                        font-weight: bold;
                        color: white;
                        position: absolute;
                        top: 8px;
                        left: 8px;
                    }
                    .gradeAll{
                    	background-color: green;
                    }
                    .grade12{
                    	background-color: blue;
                    }
                    .grade15{
                    	background-color: coral;
                    }
                    .grade18{
                   		 background-color: red;
                    }
                </style>
            </head>

            <body>
                <!-- 메뉴 시작-->
                <!-- Responsive navbar-->
                <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>
                    <!-- 메뉴 끝-->
                    <!-- Page header with logo and tagline-->
                    <header class="py-5 bg-light border-bottom mb-4">
                        <div class="container">
                            <div class="text-center my-5">
                                <h1 class="fw-bolder">영화 목록 페이지</h1>
                                <p class="lead mb-0">애매 가능한 영화 목록 출력</p>
                            </div>
                        </div>
                    </header>
                    <!-- Page content-->
                    <div class="container">
                        <div class="row">
                            <!-- Blog entries-->
                            <div class="col-lg-12">
                                <!-- Featured blog post-->
                                <!-- Nested row for non-featured blog posts-->
                                <div class="row">
                                    <c:forEach items="${mv}" var="mv">
                                        <div class="col-lg-3 col-md-4 col-sm-6">
                                            <!-- Blog post-->
                                            <div class="card mb-4">
                                                <a href="/detailMovie?mvcode=${mv.mvcode }"><img class="card-img-top"
                                                        src="${mv.mvposter }" alt="..." /></a>
                                             
                                                <span class="ageInfo grade${mv.mvstate }">${mv.mvstate }</span>
                                                <div class="card-body">
                                                    <div class="small text-muted">예매율</div>
                                                    <h2 class="card-title h4"
                                                        style="overflow : hidden; white-space: nowrap;"
                                                        title="${mv.mvtitle }1">${mv.mvtitle } +${mv.mvopen }</h2>
                                                    <a class="btn btn-danger" href="${pageContext.request.contextPath}/reserveMovie?mvcode=${mv.mvcode}">예매하기</a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Footer-->
                    <footer class="py-5 bg-dark">
                        <div class="container">
                            <p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p>
                        </div>
                    </footer>
                    <!-- Bootstrap core JS-->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>