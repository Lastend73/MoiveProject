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
                    .login {
                        width: 100%;
                        border-radius: 10px
                    }

                    .login:focus {
                        outline-color: blue;
                    }

                    .loginbtn {
                        width: 100px;
                    }

                    .row {
                        width: 400px;
                        margin: auto;
                        padding-top: 5px;
                        height: 40px;
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
                                <h1 class="fw-bolder">로그인 페이지</h1>
                                <p class="lead mb-0">로그인을 위한 아이디, 비밀번호 입력 페이지</p>
                            </div>
                        </div>
                    </header>
                    <!-- Page content-->
                    <div class="container">
                        <!-- 컨텐츠 시작 -->
                        <div class="card mb-4 mx-auto" style="width: 500px;">   

                            <div class="card-title">

                                <div class="card-title" style="text-align: center;">
                                    로그인
                                </div>

                                <form action="${pageContext.request.contextPath}/memberLogin" onsubmit="return checkId(this)">

                                    <div class="row">
                                        <input type="text" name="mid" class="login" placeholder="아이디">
                                    </div>

                                    <div class="row">
                                        <input type="text" name="mpw" class="login" placeholder="비밀번호">
                                    </div>

                                    <div class="row" style="text-align: center; display: block;">
                                        <input type="submit" value="로그인" class="loginbtn">
                                    </div>

                                </form>

                                <div class="row mb-1">
                                    <button onclick="memberLogin_kakao()" class="btn btn-warning">카카오 로그인</button>
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
                    <!-- 카카오로그인 JS -->
                    <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.3.0/kakao.min.js"
                        integrity="sha384-70k0rrouSYPWJt7q9rSTKpiTfX6USlMYjZUtr1Du+9o4cGvhPAWxngdtVZDdErlh"
                        crossorigin="anonymous"></script>

                    <script>
                        Kakao.init('7dc2c6b0b75b52fca2072b8f50ecfe78');
                        Kakao.isInitialized();


                        function memberLogin_kakao() {
                            console.log('카카오 로그인 호출');
                            Kakao.Auth.authorize({
                                redirectUri: 'http://localhost:8080/memberLoginForm',
                            });

                        }

                        let authCode = '${param.code}'; //파라메더 영역(주소창) 의 code를 찾기
                        console.log("authCode : " + authCode)
                        if (authCode.length > 0) {
                            console.log("카카오_인가코드 있음");
                            console.log("인증토큰 요청");

                            $.ajax({
                                type: 'post',
                                url: 'https://kauth.kakao.com/oauth/token',
                                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                                data: {
                                    'grant_type': 'authorization_code',
                                    'client_id': 'd044e04c05a966380897097d5609b35c',
                                    'redirect_uri': 'http://localhost:8080/memberLoginForm',
                                    'code': authCode
                                },
                                success: function (response) {
                                    console.log("인증토큰 : " + response.access_token);
                                    Kakao.Auth.setAccessToken(response.access_token);

                                    Kakao.API.request({
                                        url: '/v2/user/me',
                                    })
                                        .then(function (response) {
                                            console.log('카카오 계정 정보');
                                            console.log('id : ' + response.id);
                                            console.log('email : ' + response.kakao_account.email);
                                            console.log('nickname : ' + response.properties.nickname);
                                            console.log('profile_img : ' + response.properties.profile_image);

                                            // location.href = ""
                                            //$.ajax()
                                            // form 양식

                                            /* ajdax 카카오계정 정보가 members 테이블에서 Select*/
                                            $.ajax({
                                                type: "get",
                                                url: 'memberLogin_kakao',
                                                data: {
                                                    'id': response.id,
                                                    'profile' : response.properties.profile_image
                                                },
                                                success: function (checkMember_kakao) {
                                                    if (checkMember_kakao == 'Y') {
                                                        alert('로그인 되었습니다');
                                                        location.href = '/';
                                                    } else {
                                                        let check = confirm('가입된 정보가 없습니다\n카카오 계정으로 가입 하겠습니까?')
                                                        if (check) {
                                                            console.log('카카오 회원가입 기능 호출')
                                                            memberJoin_kakao(response);
                                                        }
                                                    }
                                                }
                                            })




                                        })
                                        .catch(function (error) {
                                            console.log(error);
                                        });
                                }

                            });
                        }


                    </script>

                    <script>
                        function memberJoin_kakao(res) {
                            console.log("memberJoin_kakao() 호출")

                            $.ajax({
                                type: 'get',	
                                url: 'memberJoin_kakao',
                                data: {
                                    'mid': res.id,
                                    'mname': res.properties.nickname,
                                    'memail': res.kakao_account.email,
                                    'mprofile': res.properties.profile_image
                                },
                                success: function (JoinResult) {
                                    alert('카카오 계정으로 회원가입되었습니다\n다시 로그인 해주세요!')
                                    location.href = 'memberLoginForm';
                                }
                            })
                        }

                        let msg = '${msg}';
                        if (msg.length > 0) {
                            alert(msg);
                        }
                    </script>

                    <script>
                        function checkId(obj){
                            console.log("formCheck() 호출");
                            // 아이디가 입력되지 않았으면 false
                            let inputId = obj.mid  // 아이디 입력 input태그
                            let inputPw = obj.mpw  // 비밀번호 입력 input태그

                            if(inputId.value.length == 0){
                                alert('아이디를 입력해주세요');
                                inputId.focus()
                                return false;
                            }

                            // 비밀번호가 입력되지 않았으면 false
                            if(inputPw.value.length == 0){
                                alert('비밀번호를 입력해주세요') ;
                                inputPw.focus()
                                return false;
                            }

                        }

                    </script>
            </body>

            </html>