<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>  
<%@ include file="../header.jsp" %>  
<%@ include file="sub_img.jsp"%> 
<%@ include file="sub_menu.jsp" %>    

<style>
/* 로그인 박스 */
#login_box {
	width:500px;
	font-size:14pt;
/*  	background-color:cyan; */
}

/*로그인 버튼*/
#login_buttons {
	width:500px;
}

</style>   

<script>
//로그인 에러 메시징
var msg = "${login_err_msg}";

console.log("msg : " + msg);

if (msg !='') {
	alert(msg);
}

</script>



  <article>  

    <h1>Login</h1>

    <form method="post" action="${contextPath}/login/login_proc">
        
        <!-- 로그인박스  -->
        <div id="login_box" class="my-5">
 
        	<div class="row">
		        <div class="col-4 pt-2 my-1">
		        	<label class="form-label">User Id</label>
		        </div>
		        <div class="col-8 my-1">
		        	<!-- 아이디 : 영문 시작 영문/숫자 조합 8~20 -->
		        	<input name="id" type="text" class="form-control" 
		        		   pattern="[a-zA-Z]{1}\w{7,19}" maxlength="20"
		        		   title="아이디는 영문으로 시작하여 영문/숫자 조합 8~20자로 작성해야 합니다.">
		        </div>
		     </div>

	        <div class="row">
	        	<div class="col-4 pt-2 my-1">
		        	<label class="form-label">Password</label>
		        </div>
		        <div class="col-8 my-1">
		        	<!-- 비밀번호 : 영문/숫자/특수문자 포함 -->
		        	<input name="pwd" type="password" class="form-control"
		        		   pattern="(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,20}" maxlength="20"
		        		   title="비밀번호는 영문/숫자/특수문자가 포함 8~20자로 작성해야 합니다.">
		        </div>
	        </div>

        </div>
        <!-- // 로그인박스 -->
        
        <!-- 로그인 버튼 -->
        <div class="clear"></div>

		<div id="login_buttons" class="row my-5">
		
			<div class="col-1"></div>
							
			<div class="col-3 ps-4">
				<input type="submit" value="로그인" class=" btn btn-outline-secondary">
			</div>
			<div class="col-3">
				<input type="button" value="회원가입" class=" btn btn-outline-secondary"
					   onclick="location='${contextPath}/member/contract'">
			</div>
			<div class="col-5 ps-3">
				<input type="button" value="아이디 비밀번호 찾기" class=" btn btn-outline-secondary">
			</div>
			
		</div>

		<!-- //로그인 버튼 -->

    </form>  

  </article>
<%@ include file="../footer.jsp" %>      
