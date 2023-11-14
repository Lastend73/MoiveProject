<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

                .gradeAll {
                    background-color: green;
                }

                .grade12 {
                    background-color: blue;
                }

                .grade15 {
                    background-color: coral;
                }

                .grade18 {
                    background-color: red;
                }

                .rankMov {
                    background-color: red;
                    margin-bottom: 5px;
                    border-radius: 5px;
                    text-align: center;
                    color: white;
                    font-size: 18px;
                    font-weight: bold;
                }

                .img-profile {
                    width: 50px;
                    border-radius: 50%;
                    object-fit: cover;
                }

                .loginInfo {
                    align-items: center;
                    display: flex;
                }

                .card-title {
                    margin-left: 10px;
                    font-size: 25px;
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
                            <h1 class="fw-bolder">메인페이지</h1>
                            <p class="lead mb-0">영화 예매순 1위~6위 목록 출력</p>
                        </div>
                    </div>
                </header>
                <!-- Page content-->
                <div class="container">
                    <div class="row">
                        <!-- Blog entries-->
                        <div class="col-lg-8">
                            <!-- Featured blog post-->
                            <!-- Nested row for non-featured blog posts-->
                            <div class="row">
                                <c:forEach items="${rankMovList}" var="mv" varStatus="status">
                                    <!-- 영화 출력 시작 -->
                                    <div class="col-lg-4 col-md-6">

                                        <div class="rankMov">
                                            No.${status.index + 1}
                                        </div>

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
                                    <!-- 영화 출력 끝 -->

                                </c:forEach>
                            </div>
                        </div>
                        <!-- Side widgets-->
                        <div class="col-lg-4">
                            <!-- Search widget-->
                            <div class="card mb-4">
                                <c:choose>
                                    <c:when test="${sessionScope.loginId == null }">
                                        <div class="card-header" style="text-align: center;">로그인 후 이용해주세요</div>
                                        <div class="card-body">
                                            <div class="input-group">
                                                <a href="memberLoginForm" class="btn btn-primary"
                                                    style="width: 100%">로그인</a>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="card-header" style="text-align: center;">Movie Project</div>
                                        <div class="card-body">
                                            <div class="loginInfo">
                                                <c:choose>
                                                    <c:when test="${sessionScope.loginState =='YC'}">

                                                        <c:choose>
                                                            <c:when test="${sessionScope.loginProfile == null}">
                                                                <!-- 등록된 프로필이 없는 경우 -->
                                                                <img class="img-profile"
                                                                    src="${pageContext.request.contextPath}/resources/users/MemberUpload/Basic.png"
                                                                    alt="">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <!-- 등록된 프로필이 있는 경우 -->
                                                                <img class="img-profile"
                                                                    src="${pageContext.request.contextPath}/resources/users/MemberUpload/${sessionScope.loginProfile}"
                                                                    alt="">
                                                            </c:otherwise>
                                                        </c:choose>

                                                    </c:when>
                                                    <c:otherwise>
                                                        <img class="img-profile" src="${sessionScope.loginProfile}"
                                                            alt="">
                                                    </c:otherwise>
                                                </c:choose>
                                                <!-- 비율이 다르면 수정한다 object-fit -->
                                                <h2 class="card-title">${sessionScope.loginName }</h2>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <!-- Categories widget-->
                            <div class="card mb-4">
                                <div class="card-header">Categories</div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <ul class="list-unstyled mb-0">
                                                <li><a href="#!">예매 내역</a></li>
                                                <li><a href="#!">HTML</a></li>
                                                <li><a href="#!">Freebies</a></li>
                                            </ul>
                                        </div>
                                        <div class="col-sm-6">
                                            <ul class="list-unstyled mb-0">
                                                <li><a href="#!">회원정보</a></li>
                                                <li><a href="#!">로그아웃</a></li>
                                                <li><a href="#!">Tutorials</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Side widget-->
                            <div class="card mb-4">
                                <div class="card-header">Side Widget</div>
                                <div class="card-body">You can put anything you want inside of these side widgets. They
                                    are easy to use, and feature the Bootstrap 5 card component!</div>
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

                <script type="text/javascript">
                    let msg = '${msg}';
                    if (msg.length > 0) {
                        alert(msg);
                    }
                </script>
        </body>

        </html>