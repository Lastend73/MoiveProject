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
                .timeInfo {
                    display: inline-block;
                    width: 31%;
                    margin: 4px;
                }

                .selEl {
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                .smallTitle {
                    border-radius: 10px;
                    border: 2px solid lightsteelblue;
                    font-weight: bold;
                    background: lightsteelblue;
                }

                .selectList {
                    cursor: pointer;
                    border-radius: 5px;
                    margin-bottom: 3px;
                    margin-top: 3px;
                    padding: 3px;

                    border: 2px solid black;
                }

                .selectList:hover {
                    background-color: lightsteelblue;
                }

                .unselectList {
                    cursor: pointer;
                    border-radius: 5px;
                    margin-bottom: 3px;
                    margin-top: 3px;
                    padding: 3px;

                    border: 1px solid lightgray;
                    color: lightgray;
                }

                .selectObj {
                    background-color: black !important;
                    color: white;
                    font-weight: bold;
                }

                .movcard {
                    height: 414px;
                    overflow: scroll;
                }

                .movcard::-webkit-scrollbar {
                    display: none;
                }

                .selMoviePoster {
                    max-width: 70%;
                    max-height: 150px;
                    height: auto;
                    border-radius: 10px;
                }

                .title {
                    border: solid 1px lightskyblue;
                    margin-bottom: 5px;
                    border-radius: 10px;
                    background-color: lightgreen;
                }

                .selInfo {
                    font-weight: bold;
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
                            <div class="title text-center">영화</div>
                            <div class="card mb-4">
                                <div class="card-body p-2 movcard" id="movArea">
                                    <c:forEach items="${mvlist}" var="mv">
                                        <div class="selectList selEl" id="${mv.mvcode}" tabindex="0"
                                            onclick="movieClick(this,'${mv.mvcode}', '${mv.mvposter}' )">${mv.mvtitle}
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6 p-2">
                            <div class="title text-center">극장</div>
                            <div class="card mb-4">
                                <div class="card-body p-2 movcard" id="thArea">
                                    <c:forEach items="${thlist}" var="th">
                                        <div class="selectList selEl" id="${th.thcode}"
                                            onclick="theaterClick(this, '${th.thcode}', '${th.thimg}')">${th.thname}
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-2 col-md-6 p-2">
                            <div class="title text-center">날짜 </div>

                            <div class="card mb-4">
                                <div class="card-body p-2 movcard" id="dateArea">

                                </div>
                            </div>

                        </div>


                        <div class="col-lg-4 col-md-6 p-2">

                            <div class="title text-center">시간</div>

                            <div class="card mb-4">
                                <div class="card-body p-2 movcard" id="timeArea">

                                </div>
                            </div>

                        </div>

                    </div>

                    <div class="row">

                        <div class="col-lg-4">
                            <div class="card mb-4">
                                <div class="card-body p-2" style="text-align: center;">
                                    <p class="card-text" id="movTitle" style="margin-bottom: 0;">영화제목</p>
                                    <img class="selMoviePoster" id="movPoster"
                                        src="${pageContext.request.contextPath}/resources/users/MemberUpload/CGV.png"
                                        alt="">
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-5">
                            <div class="card mb-4">
                                <div class="card-body p-2" style="text-align: center;">
                                    <p class="card-text" id="thTitle">극장 이름</p>
                                </div>
                                <div class="card-body p-2">
                                    <p class="p-2 m-1 w-100">극장 <span class="selInfo" id="selTheater">극장이름</span></p>
                                    <p class="p-2 m-1 w-100">일시 <span class="selInfo" id="selDate">날짜</span> <span
                                            class="selInfo" id="seltime">시간</span></p>
                                    <p class="p-2 m-1 w-100">상영관 <span class="selInfo" id="selHall">??관</span></p>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3">
                            <div class="card mb-4">
                                <div class="card-body p-2">
                                    <button class="btn btn-danger w-100 p-5" style="height: 175px;"
                                        onclick="movieReserve()">예매하기</button>
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
                    function movieReserve() {

                        let loginCheck = '${sessionScope.loginId}';
                        if (loginCheck.length == 0) {
                            alert('로그인 후 이용 가능합니다.')
                            location.href = "memberLoginForm";
                        } else if (reserve_mvcode == null) {
                            alert("영화를 선택 해주세요!");
                        } else if (reserve_thcode == null) {
                            alert("극장을 선택 해주세요!");
                        } else if (reserve_scdate == null) {
                            alert("날짜를 선택 해주세요!");
                        } else if (reserve_schall == null) {
                            alert("시간을 선택 해주세요!");
                        } else {
                            console.log('예매처리 요청');
                            // 1. INSERT   >> 성공
                            registReserveInfo();
                            // 2. KAKAOPAY >> 성공, 
                            //            >> 실패
                        }
                    }

                    function reserveResult_Success() {
                        /* 예메 성공 시 호출 */
                        alert("예매가 성공하였습니다");
                        location.href = "/";
                    }

                    function failReserve() {
                        alert("예메에 실패했습니다.");

                        $.ajax({
                            /* DELETE FROM RESERVE WHERE RECODE = ???*/
                            type: 'get',
                            url: "deleteReserveCode",
                            data: {
                                "reserveCode": reserveCode
                            },
                            success: function (result) {

                            }
                        })

                        // location.reload();
                    }

                    function kakaoPay_ready(recode) {
                        console.log('카카오 페이 결제 준비');
                        $.ajax({
                            type: 'post',
                            url: "kakaoPay_ready",
                            data: {
                                'recode': recode,
                                'mvcode': reserve_mvcode,
                                'thcode': reserve_thcode,
                                'schall': reserve_schall,
                                'scdate': reserve_scdate + " " + reserve_sctime
                            },
                            success: function (result) {
                                console.log(result);
                                window.open(result, "pay", "width=400, height=500");
                            }

                        })
                    }

                    let reserveCode = null;

                    function registReserveInfo() {
                        $.ajax({
                            type: 'get',
                            url: 'registReserveInfo',
                            data: {
                                'mvcode': reserve_mvcode,
                                'thcode': reserve_thcode,
                                'schall': reserve_schall,
                                'scdate': reserve_scdate + " " + reserve_sctime
                            },
                            async: false,
                            success: function (result) {
                                console.log('예매 처리 결과')
                                if (result == 'login') {
                                    alert('로그인후 이용가능합니다');
                                    location.href = "/memberLoginForm"
                                }
                                else if (result.length > 0) {
                                    console.log("예매 성공");
                                    reserveCode = result;
                                    kakaoPay_ready(result);

                                } else {
                                    console.log("예매 insert 실패")
                                    // alert("예메 실패했습니다!");

                                }
                            }
                        })
                    }

                </script>


                <script>

                    let reserve_mvcode = null; // 선택한 영화 코드 저장 = 'MV00001'
                    let reserve_thcode = null; // 선택한 극장 코드 저장 = 'TH00001'
                    let reserve_scdate = null; // 선택한 날짜 = '2023-09-14'
                    let reserve_sctime = null; // 선택한 시간 = '13:20'
                    let reserve_schall = null; // 선택한 상영관 = '2관 B3층'
                    // '2023-09-14' +' '+ '13:20' = '2023-09-14 13:20'

                    function resetSelectInfo(sel) {
                        //선택 정보 초기화
                        switch (sel) {
                            case 'date':
                                // 날짜를 클릭한 경우에 초기화 해줄 내용
                                // 페이지 : 시간, 상영관 초기화
                                document.querySelector('#seltime').innerText = "";
                                document.querySelector('#selHall').innerText = "";
                                // 변수 : reserve_sctime, reserve_schall 초기화

                                // 시간, 상영관 목록초기화 
                                document.querySelector('#timeArea').innerHTML = "";;


                                reserve_sctime = null;
                                reserve_schall = null;

                                if (sel) {
                                    // 페이지 : 날짜 초기화
                                    document.querySelector('#selDate').innerText = "";

                                    // 변수 : reserve_scdate 초기화
                                    reserve_scdate = null;
                                }
                                break;

                            case 'movie':
                            case 'theater':
                                // 영화, 극장 클릭한 경우에 초기화 해줄 내용
                                // 페이지 : 시간, 상영관 초기화 + 날짜
                                // 변수 : reserve_sctime, reserve_schall 초기화 + reserve_sctime
                                break;

                        }
                    }

                    let EnterKey = document.createElement('br');

                    function movieClick(selectMvObj, mvcode, mvposter) {
                        console.log(selectMvObj) // STYLE 변경
                        console.log('movieClick() 호출')
                        console.log('선택한 영화코드 :' + mvcode); // 극장목록조회
                        console.log('선택한 영화제목 :' + selectMvObj.innerText); // 선택항목출력
                        console.log('선택한 영화포스터 URL :' + mvposter); // 선택항목 출력

                        if (selectMvObj.classList.contains('unselectList')) {
                            console.log('얘매가 불가능한 극장 선택')
                            let reloadCheck = confirm('선택한 극장에 원하는 상영스케줄이 없습니다.\n계속하시겠습니까?');

                            if (reloadCheck) {
                                // 새로고침
                                location.reload();
                            }
                        } else {
                            //선택 정보 초기화 함수 호출
                            resetSelectInfo(true);

                            reserve_mvcode = mvcode; // 선택한 영화 코드 저장

                            // 1. 선택 항목 츨력
                            document.querySelector('#movTitle').innerText = selectMvObj.innerText
                            document.querySelector('#movPoster').setAttribute('src', mvposter);

                            // 2.선택항목 STYLE 변경
                            addSelectStyle(selectMvObj);

                            // 3. 선택한 영화를 예매 할 수 있는 극장 목록 조회
                            let thList = getReserveTheaterList(mvcode);
                            console.log(thList.length);
                            changeTheaterList(thList);

                            // 4. 영화 & 극장이 모두 선택이 되어 있으면 날짜 목록 조회 출력
                            if ((reserve_thcode != null) && (reserve_mvcode != null)) {
                                document.querySelector('#selDate').innerText = "";
                                document.querySelector('#seltime').innerText = "";
                                document.querySelector('#selHall').innerText = "";
                                document.querySelector("#timeArea").innerHTML = "";
                                getReserveSchdulesDateList()
                            }
                        }

                    }


                    function addSelectStyle(selObj) {
                        console.log('removeSelectStyle호출');
                        console.log(selObj.parentElement)
                        let movDivs = selObj.parentElement.querySelectorAll('div.selEl');

                        for (let movEl of movDivs) {
                            movEl.classList.remove('selectObj');
                        }

                        selObj.classList.add('selectObj');
                    }

                    function getReserveTheaterList(selectMoiveCode) {
                        console.log("예매 가능한 극장 목록 조회")
                        let theaterList = [];
                        $.ajax({
                            type: 'get',
                            url: 'getTheaterList_json',
                            data: {
                                'selectMvCode': selectMoiveCode
                            },
                            async: false,
                            dataType: "json",
                            success: function (result) {
                                theaterList = result
                            }
                        })
                        return theaterList
                    }

                    function changeTheaterList(thList) {
                        console.log("changeTheaterList 호출");
                        console.log(thList.length);

                        let thCodeList = [];
                        for (let th of thList) {
                            thCodeList.push(th.thcode);
                        }
                        console.log(thCodeList);

                        let theaterEls = document.querySelectorAll("#thArea>div.selEl");

                        let thArea = document.querySelector('#thArea');

                        for (let thEl of theaterEls) {
                            thEl.classList.remove('selectList');
                            thEl.classList.remove('unselectList');

                            if (thCodeList.includes(thEl.getAttribute('id'))) {
                                console.log("예매 가능한 극장")
                                thEl.classList.add('selectList');
                            } else {
                                console.log("예매 불가능한 극장")
                                thArea.appendChild(thEl);
                                thEl.classList.add('unselectList');
                            }

                        }
                    }
                </script>

                <script>
                    function theaterClick(selectTHObj, thcode, thimg) {
                        console.log("theaterClick 호출()");
                        console.log(selectTHObj);

                        if (selectTHObj.classList.contains('unselectList')) {
                            console.log('얘매가 불가능한 극장 선택')
                            let reloadCheck = confirm('선택한 영화에 원하는 상영스케줄이 없습니다.\n계속하시겠습니까?');

                            if (reloadCheck) {
                                // 새로고침
                                location.reload();
                            }

                        } else {
                            //선택 정보 초기화 함수 호출
                            resetSelectInfo(true);

                            reserve_thcode = thcode;

                            // 1. 선택 항목 출력
                            document.querySelector('#thTitle').innerText = selectTHObj.innerText;
                            document.querySelector('#selTheater').innerText = selectTHObj.innerText;

                            // 2. 선택 항목 style 변경
                            console.log("예매가 가능한 극장 선택");
                            addSelectStyle(selectTHObj);

                            // 3. 선택한 극장에서 예매 할 수있는 영화 목록 조회
                            let mvList = getReserveMovieList(thcode);
                            console.log(mvList.length);
                            changeMovieList(mvList);

                            // 4. 영화 & 극장이 모두 선택이 되어 있으면 날짜 목록 조회 출력
                            if ((reserve_thcode != null) && (reserve_mvcode != null)) {
                                document.querySelector('#selDate').innerText = "";
                                document.querySelector('#seltime').innerText = "";
                                document.querySelector('#selHall').innerText = "";
                                document.querySelector("#timeArea").innerHTML = "";
                                getReserveSchdulesDateList()

                            }
                        }



                    }

                    function getReserveMovieList(thcode) {
                        console.log("예매 가능한 영화 목록 조회")
                        console.log("선택한 극장코드 : " + thcode);
                        let mvList = [];
                        $.ajax({
                            data: "get",
                            url: " getMovieList_json",
                            data: {
                                'selectThCode': thcode
                            },
                            async: false,
                            dataType: 'json',
                            success: function (result) {
                                mvList = result
                            }
                        })
                        return mvList
                    }

                    function changeMovieList(mvList) {
                        let mvCodeList = [];

                        for (let mv of mvList) {
                            mvCodeList.push(mv.mvcode);
                        }
                        console.log(mvCodeList);

                        let movieEls = document.querySelectorAll("#movArea>div.selEl");

                        let mvArea = document.querySelector('#movArea');

                        for (let mvEl of movieEls) {
                            mvEl.classList.remove('selectList');
                            mvEl.classList.remove('unselectList');

                            if (mvCodeList.includes(mvEl.getAttribute('id'))) {
                                console.log("예매 가능한 극장")
                                mvEl.classList.add('selectList');
                            } else {
                                console.log("예매 불가능한 극장")
                                mvArea.appendChild(mvEl);
                                mvEl.classList.add('unselectList');
                            }

                        }
                    }
                </script>

                <script>
                    function getReserveSchdulesDateList() {
                        console.log('예매 가능한 날짜 목록 조회 요청');

                        $.ajax({
                            type: "get",
                            url: "getSchduleDateList_json",
                            data: {
                                'mvcode': reserve_mvcode, 'thcode': reserve_thcode
                            },
                            async: false,
                            dataType: 'json',
                            success: function (result) {
                                console.log(result);
                                printDateList(result);

                            }
                        })
                    }

                    function printDateList(schList) {
                        let date_div = document.querySelector('#dateArea'); // 날자 출력 div
                        date_div.innerHTML = "";
                        let nowMM = null // (월)을 출력하기 위한것
                        for (let sch of schList) {
                            let sch_div = document.createElement('div');
                            sch_div.classList.add('selectList');
                            sch_div.classList.add('selEl');
                            sch_div.classList.add('text-center');

                            let date_info = sch.scdate.split("/")

                            if (nowMM != date_info[1]) {

                                if (nowMM != null) {
                                    let Enter = document.createElement('br');
                                    date_div.appendChild(Enter)
                                }

                                nowMM = date_info[1];
                                let mmDiv = document.createElement('div');
                                mmDiv.innerText = date_info[1] + '월';
                                mmDiv.classList.add('text-center');
                                mmDiv.classList.add('smallTitle');

                                date_div.appendChild(mmDiv);
                            }

                            sch_div.addEventListener('click', function (e) {
                                resetSelectInfo(false);

                                reserve_scdate = sch.scdate;

                                // 1. 선택 항목 스타일 변경
                                addSelectStyle(e.target);
                                // 2. 선택 항목 출력
                                document.querySelector('#selDate').innerText = date_info[0] + "년 " + date_info[1] + "월 " + date_info[2] + "일"

                                // 3. SCHDULES SCHALL(상영관), SCDATE(시간)
                                // 선택 영화코드, 선택 극장코드, 선택 날짜 코드
                                document.querySelector('#seltime').innerText = "";
                                document.querySelector('#selHall').innerText = "";
                                getReserveTimeListList(reserve_mvcode, reserve_thcode, sch.scdate)

                            })

                            sch_div.innerText = date_info[2] + "일"

                            date_div.appendChild(sch_div);

                        }
                    }
                </script>

                <script>
                    function getReserveTimeListList(mvcode, thcode, scdate) {
                        console.log('예매 가능한 일정 목록 조회 요청');
                        console.log("선택한 영화 코드 : " + mvcode);
                        console.log("선택한 영화 코드 : " + thcode);
                        console.log("선택한 날짜  : " + scdate);

                        $.ajax({
                            type: 'get',
                            url: "getReserveTimeListList_json",
                            data: {
                                'mvcode': mvcode,
                                'thcode': thcode,
                                'scdate': scdate
                            },
                            async: false,
                            dataType: "json",
                            success: function (result) {
                                printTimeList(result);
                            }
                        })
                    }

                    function printTimeList(timeList) {
                        console.log("timeList");
                        console.log(timeList)

                        let hall = null;
                        let time_div = document.querySelector("#timeArea");
                        time_div.innerHTML = "";

                        for (let tm of timeList) {

                            if (hall != tm.schall) {

                                // 엔터키 
                                if (hall != null) {
                                    let Enter = document.createElement('hr');
                                    time_div.appendChild(Enter)
                                }

                                hall = tm.schall;
                                let hallDiv = document.createElement('div');

                                hallDiv.innerText = tm.schall;
                                hallDiv.classList.add('text-center');
                                hallDiv.classList.add('smallTitle');

                                time_div.appendChild(hallDiv);
                            }
                            // 시간 div
                            let tm_div = document.createElement('div');

                            // div 클래스 추가
                            tm_div.classList.add('selectList');
                            tm_div.classList.add('selEl');
                            tm_div.classList.add('text-center');
                            tm_div.classList.add('timeInfo');

                            //div 내용 추가
                            let time_hour_eng = tm.scdate.substr(11, 8);
                            let time_hour = time_hour_eng.split(":");
                            tm_div.innerText = time_hour[0] + "시 " + time_hour[1] + "분";

                            tm_div.addEventListener('click', function (e) {
                                resetSelectInfo(false);

                                reserve_sctime = time_hour[0] + ":" + time_hour[1]
                                reserve_schall = tm.schall

                                // 1. 선택 항목 스타일 변경
                                addSelectStyle(e.target);

                                // 2. 선택 항목 출력
                                document.querySelector('#seltime').innerText = time_hour[0] + "시 " + time_hour[1] + "분";
                                document.querySelector('#selHall').innerText = tm.schall;

                            })

                            // time div 추가
                            time_div.appendChild(tm_div);
                        }

                    }   
                </script>
                <c:if test="${param.mvcode != null}"></c:if>
                <script>
                    document.querySelector("#${param.mvcode}").click();
                    document.querySelector("#${param.mvcode}").focus();
                </script>

        </body>

        </html>