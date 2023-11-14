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
                .selectList {
                    cursor: pointer;
                    border-radius: 5px;
                    margin-bottom: 3px;
                    margin-top: 3px;
                    padding: 3px;

                    border: 1px solid black;
                }

                .selectList:hover {
                    background-color: lightsteelblue;
                }

                .selectObj {
                    background-color: black !important;
                    color: white;
                    font-weight: bold;
                }

                .movcard {
                    height: 533px;
                    overflow: scroll;
                }

                .movcard::-webkit-scrollbar {
                    display: none;
                }

                .selMoviePoster {
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
                            <h1 class="fw-bolder">영화에메페이지</h1>
                            <p class="lead mb-0">영화 예매순 1위~6위 목록 출력</p>
                        </div>
                    </div>
                </header>
                <!-- Page content-->
                <div class="container">
                    <!-- 컨텐츠 시작 -->
                    <div class="row">
                        <div class="col-lg-3 col-md-6 p-2">
                            <div class="card mb-4">
                                <div class="card-body p-2 movcard" id="movArea">
                                    <!-- <c:forEach items="${mvlist}" var="mv">
                                            <div class="selectList">${mv.mvtitle}</div>
                                        </c:forEach> -->
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6 p-2">
                            <div class="card mb-4">
                                <div class="card-body p-2 movcard" id="thArea">
                                    <!-- <c:forEach items="${thlist}" var="th">
                                        <div class="selectList">${th.thname}</div>
                                    </c:forEach> -->
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6 p-2">
                            날짜
                        </div>
                        <div class="col-lg-3 col-md-6 p-2">
                            상영관 및 시간
                        </div>

                    </div>

                    <div class="row">

                        <div class="col-lg-4">
                            <div class="card mb-4">
                                <div class="card-body p-2" style="text-align: center;">
                                    <p class="card-text" id="movTitle">영화제목</p>
                                    <img class="selMoviePoster" id="movPoster"
                                        src="https://img.cgv.co.kr/Movie/Thumbnail/Poster/000087/87246/87246_320.jpg"
                                        alt="">
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-5">
                            <div class="card mb-4">
                                <div class="card-body p-2">
                                    선택 극장 정보
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <div class="card mb-4">
                                <div class="card-body p-2">
                                    <button class="btn btn-danger w-100 p-5">예매하기</button>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- 컨텐츠 끝 -->
                </div>
                <!-- Footer-->
                <footer class="py-5 bg-dark">
                    <div class="container">
                        <p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p>
                    </div>
                </footer>
                <!-- Bootstrap core JS-->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

                <!-- Jquery js -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

                <script>
                    $(document).ready(function () {
                        //1.예매 가능한 영화 목록 조회 Json
                        let mvList = getReserveMovieList('ALL');

                        //3. 영화목록 출력  
                        printMovieList(mvList);

                        //2.예매 가능한 극장 목록 조회 Json
                        let thList = getReserveTheaterList('ALL');

                        //4. 극장목록 출력
                        printTheaterList(thList)
                    })
                </script>

                <script>

                    let reserve_mvcode = null; // 선택한 영화 코드 저장할 변수
                    let reserve_thcode = null; // 선택한 극장 코드 저장할 변수

                    function getReserveMovieList(selectTheaterCode) {
                        console.log('예매 가능한 영화 목록 조회 요청')
                        let movieList = "";
                        $.ajax({
                            type: "get",
                            url: "getMovieList_json",
                            data: {'selThcode' : selectTheaterCode},
                            dataType: "json",
                            async: false,
                            success: function (result) {
                                console.log("영화 목록")
                                console.log(result)
                                movieList = result;
                            }
                        })

                        return movieList;
                    }

                    function getReserveTheaterList(selectMovieCode) {
                        console.log('예매 가능한 극장 목록 조회 요청')
                        let theaterList = [];
                        $.ajax({
                            type: "get",
                            url: "getTheaterList_json",
                            data: { 'selMvcode': selectMovieCode },
                            dataType: "json",
                            async: false,
                            success: function (result) {
                                console.log("극장 목록")
                                console.log(result)
                                theaterList = result;
                            }
                        })

                        return theaterList;
                    }

                    function printMovieList(movList) {
                        console.log("영화 목록 출력");
                        let movArea_Div = document.querySelector('#movArea');
                        movArea_Div .innerHTML = ""
                        for (let mvinfo of movList) {
                            let mv_Div = document.createElement('div');
                            mv_Div.innerText = mvinfo.mvtitle;
                            mv_Div.classList.add('selectList');
                            mv_Div.classList.add('selEl');
                            mv_Div.addEventListener('click', function (e) {

                                reserve_mvcode = mvinfo.mvcode

                                //영화 목록에 모든 영화에 강조 STYLE 제거
                                removeSelectStyle('movArea');

                                // 선택된 영화 강조 STYLE 추가
                                mv_Div.classList.add('selectObj');


                                console.log('선택영화코드 : ' + mvinfo.mvcode);

                                console.log('선택영화제목 : ' + mvinfo.mvtitle);
                                document.querySelector("#movTitle").innerText = mvinfo.mvtitle

                                console.log('선택영화포스터 : ' + mvinfo.mvposter);
                                document.querySelector('#movPoster').setAttribute('src', mvinfo.mvposter)

                                if(reserve_thcode == null){
                                    let thList = getReserveTheaterList(mvinfo.mvcode);
                                    printTheaterList(thList)
                                }
                                //1. 극장목록 조회 및 출력(영화코드)

                                //2. 선택 정보 출력(제목, 포스터)

                            })

                            movArea_Div.appendChild(mv_Div);
                        }

                    }

                    function printTheaterList(thList) {
                        console.log("극장 목록 출력");
                        let thArea_Div = document.querySelector('#thArea');
                        thArea_Div.innerHTML = ""
                        for (let th of thList) {
                            let th_div = document.createElement('div');
                            th_div.innerText = th.thname;
                            th_div.setAttribute('id', th.thcode);
                            th_div.classList.add('selectList')
                            th_div.classList.add('selEl')

                            th_div.addEventListener('click', function (e) {

                                reserve_thcode = th.thcode;

                                //영화 목록에 모든 영화에 강조 STYLE 제거
                                removeSelectStyle('thArea');

                                //  선택된 영화 강조 STYLE 추가
                                th_div.classList.add('selectObj');

                                // 영화 목록 조회
                                if(reserve_mvcode == null){
                                    let movList = getReserveMovieList(th.thcode);
                                    printMovieList(movList);
                                    console.log('영화 목록 조회');
                                }

                            })


                            thArea_Div.appendChild(th_div);
                        }
                    }


                    function removeSelectStyle(areaId) {
                        let areaDIV = document.querySelectorAll('#' + areaId + ">.selectList");

                        for (let el of areaDIV) {
                            el.classList.remove('selectObj');
                        }

                    }
                </script>

                <script>
                    let movAreaEl = document.querySelectorAll('#movArea div.selectList');


                    for (let movEl of movAreaEl) {
                        movEl.addEventListener('click', function (e) {
                            console.log(e.target.innerText);
                            console.log(movEl.innerText);
                        })
                    }
                </script>
        </body>

        </html>