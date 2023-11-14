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

                .row,
                .row_email {
                    margin: auto;

                }

                .row,
                .row_email,
                .img_div {
                    padding-top: 5px;

                }

                .row {
                    width: 300px;
                    height: 27%;
                }

                .row_email {
                    width: 440px;
                    height: 44px;
                }

                #upload_btn {
                    border: solid black 1px;
                    margin-top: 5px;
                }

                #image_file {
                    width: 120px;
                    height: 100px;

                }

                .img_div {
                    padding-left: 20px;
                }

                #idCheckMsg {
                    height: 10%;
                    font-size: 10px;
                    margin-bottom: 5px;
                }

                .fontRed{
                    color: red;
                }
                .fontGreen{
                    color: green;
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
                            <h1 class="fw-bolder">회원가입 페이지</h1>
                            <p class="lead mb-0">회원가입를 위한 아이디, 비밀번호 입력 페이지</p>
                        </div>
                    </div>
                </header>
                <!-- Page content-->
                <div class="container">
                    <!-- 컨텐츠 시작 -->
                    <div class="card mb-4 mx-auto" style="width: 500px;">

                        <div class="card-title">

                            <div class="card-title" style="text-align: center;">
                                회원가입
                            </div>

                            <form action="${pageContext.request.contextPath}/memberJoin" method="post"
                                enctype="multipart/form-data" onsubmit="return checkNeed(this)">
                                <!-- 파일전송을 위해 enctype="multipart/form-data" 이 form 양식에 추가 필요 -->
                                <div style="display: flex; justify-content: center;">
                                    <div>
                                        <div class="row">
                                            <input type="text" name="mid" class="login" placeholder="아이디"
                                                onkeyup="idCheck(this)">
                                        </div>

                                        <div class="row" id="idCheckMsg">
                                           
                                        </div>

                                        <div class="row">
                                            <input type="password" name="mpw" class="login" placeholder="비밀번호">
                                        </div>

                                        <div class="row">
                                            <input type="text" name="mname" class="login" placeholder="성함">
                                        </div>
                                    </div>

                                    <div class="img_div">
                                        <img src="http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg"
                                            alt="http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg"
                                            id="image_file">
                                        <div style=" text-align: center;">
                                            <label id="upload_btn" for="Uploadprofile">업로드</label>
                                            <input type="file" id="Uploadprofile" name="mfile" style="display: none;"
                                                onchange="preview(this)">
                                        </div>
                                    </div>
                                </div>


                                <div class="row_email" style="display: flex;">
                                    <input type="text" name="memail_Foward" class="login" placeholder="이메일아이디">
                                    	
                                    <input type="text" id="edomain" name="memaill_Back" class="login"
                                        placeholder="비밀번호">
                                    <select id="hello" style="margin-left: 5px;" onchange="selectDomain(this)">
                                        <option value="">직접입력</option>
                                        <option value="naver.com">네이버</option>
                                        <option value="google.com">구글</option>
                                    </select>

                                </div>


                                <div class="row" style="text-align: center; display: block;">
                                    <input type="submit" value="회원가입" class="loginbtn" style="border-radius: 15px;">
                                </div>

                            </form>


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

                    let idChecked = false;

                    function idCheck(inputObj){
                        $.ajax({
                            type: "get",
                            url :"memberIdCheck",
                            data: {"inputId" : inputObj.value},
                            success : function(checkResult){
                                console.log("확인할 아이디 : " + checkResult);
                                console.log("확인할 아이디 : " + checkResult.length);

                                let msgE1 =  document.querySelector("#idCheckMsg");
                                if(checkResult.length > 0 ){
                                    console.log('중복 아이디 입니다.');
                                    msgE1.innerText = "중복된 아이디 입니다"
                                    msgE1.style.color = "red";
                                    idChecked = false;

                                }else{
                                    console.log('사용 가능한 아이디 입니다.');
                                    document.querySelector("#idCheckMsg").innerText = "사용 가능한 아이디 입니다."
                                    msgE1.style.color = "green";
                                    idChecked = true;
                                }
                            }

                        })
                    }

                </script>

                <script>
                    function selectDomain(src) {
                        // console.log(src.value)
                        document.querySelector("#edomain").value = src.value;

                    }

                    function preview(src) {

                        var reader = new FileReader();

                        reader.readAsDataURL(event.target.files[0]);

                        reader.onload = function (event) {
                            var img = document.querySelector("#image_file");
                            console.log(event.target)
                            img.setAttribute("src", event.target.result);
                        };


                    }
                </script>

                <script>
                    function checkNeed(obj) {

                        let inputId = obj.mid;
                        let inputPw = obj.mpw;
                        let inputName = obj.mname;

                        if (inputId.value == "") {
                            alert("아이디를 입력해주세요")
                            inputId.focus();
                            return false
                        }
                        if(!idChecked){
                            alert('아이디를 중복확인 해주세요!')
                            inputId.focus();
                            return false;
                            
                        }
                        if (inputPw.value == "") {
                            alert("비밀번호를 입력해주세요")
                            inputPw.focus();
                            return false;
                        }

                        if (inputName.value == "") {
                            alert("이름을 입력해주세요")
                            inputName.focus();
                            return false
                        }
                    }
                </script>
        </body>

        </html>