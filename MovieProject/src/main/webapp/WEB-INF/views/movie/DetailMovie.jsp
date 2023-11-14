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

                <style type="text/css">
                    .movie_poseter{
                        max-width: 70%;
                        height: auto;
                        border-radius: 10px;
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
                                <h1 class="fw-bolder">영화 정보페이지</h1>
                                <p class="lead mb-0">영화 상세 정보 출력</p>
                            </div>
                        </div>
                    </header>
                    <!-- Page content-->
                    <div class="container">
                        <!-- 컨텐츠 시작 -->
                        <!-- mb : margin bottom,  mt: margin top, my : margin bottom&top, ml : margin left, mr : margin right,-->
                        <div class="row my-4">  
                            <div class="col-lg-5" style="text-align: center;">
                                <img class="movie_poseter" src="${movieInfo.mvposter }" alt="">
                            </div>

                            <div class="col-lg-7">
                                <!-- pt : padding top, pb : padding bottom, pr : padding right, pl : padding left, -->
                                <div class="card-body pt-5">
                                    <div class="small text-muted mb-1" >예매율</div>
                                    <h2 class="card-title mb-2" title="${movieInfo.mvtitle }">영화 제목 출력</h2>
                                    <div class="card-text mb-1"> 감독 : ${movieInfo.mvdirector } / 배우 : ${movieInfo.mvactors}  </div>
                                     <div class="card-text mb-1"> 장르 : ${movieInfo.mvgenre }  </div>
                                     <div class="card-text mb-4"> 개봉일 : ${movieInfo.mvopen }  </div>
                                    <a class="btn btn-danger" href="${pageContext.request.contextPath}/reserveMovie?mvcode=${movieInfo.mvcode}">예매하기</a>
                                </div>
                            </div>
                        </div>
                        <!-- 컨텐츠 끝 -->

                    <!--양화정보 출력 - row  시작-->
                    
                     <!-- 관람평 출력 - row 시작  -->
                    
                     <!-- 관람평 출력 - row 끝-->
                    
                    <!-- <양화정보 출력 - row  시작  -->
                    
                        
                    
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