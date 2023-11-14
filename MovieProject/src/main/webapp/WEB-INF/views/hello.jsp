<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
       
       <script type="text/javascript">
        let payResult = "${payResult}"
        if(payResult == 'Y'){
            /* Insert 성공. 결제 성공*/
            /* 부모창애 예매가 되었습니다! */
            window.opener.location.href = "/";
        }else{
            /* Insert 성공. 결제 실패*/
            /* 부모창애 예매가 실패하였습니다
               DELETE 
            */

            window.opener.failReserve();
        }
            window.close();
        </script>
    </head>

    <body>

    </body>

    </html>