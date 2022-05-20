<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  

<%@ include file="../header.jsp" %>  
<%@ include file="sub_img.jsp"%> 
<%@ include file="sub_menu.jsp" %>    

<style>
/* 탈퇴회원 점검 박스 */
#check_inactive_mamber_box {
	width:500px;
	font-size:14pt;
/*  	background-color:cyan; */
}

/*탈퇴회원 점검 버튼*/
#check_inactive_member_buttons {
	width:500px;
}

</style>   

<!-- <script>
//에러 메시징
var msg = "${InActiveMember_err_msg}";

console.log("msg : " + msg);

if (msg !='') {
	alert(msg);
}

</script> -->

<script>
function choose_default_member() {
	
	console.log("기존 정보 (탈퇴전 정보) 활용 점검");
	
	if (confirm("기존 정보(탈퇴 전 정보)를 다시 사용하시겠습니까?")) {
		
		console.log("기존 정보 재사용");
		
	} else {
		
		console.log("신규가입");
		history.back();
		return false;
		
	}
}

</script>



  <article>  

    <h1>탈퇴 회원 재가입</h1>

    <form method="post" action="${contextPath}/member/check_inactive_member_proc">
        
        <!-- 탈퇴 회원 점검 박스  -->
        <div id="box" class="my-5">
 
        	<div class="row">
		        <div class="col-4 pt-2 my-1">
		        	<label class="form-label">User Id</label>
		        </div>
		        <div class="col-8 my-1">
		        	<!-- 아이디 : 영문 시작 영문/숫자 조합 8~20 -->
		        	<input name="id" type="text" class="form-control" 
		        		   required pattern="[a-zA-Z]{1}\w{7,19}" maxlength="20"
		        		   title="아이디는 영문으로 시작하여 영문/숫자 조합 8~20자로 작성해야 합니다.">
		        </div>
		     </div>

	        <div class="row">
	        	<div class="col-4 pt-2 my-1">
		        	<label class="form-label">Password</label>
		        </div>
		        <div class="col-8 my-1">
		        	<input type="password" id="pwd" name="pwd" class="form-control" 
        			   required pattern="(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,20}"
        			   title="비밀번호는 영문+숫자 및 특수문자 최소 1자의 조합으로 8~20사이로 입력하십시오">
		        </div>
	        </div>
	        
	        <div class="row">
		        <div class="col-4 pt-2 my-1">
		        	<label class="form-label">E-mail</label>
		        </div>
		        <div class="col-8 my-1">
		        	<!--이메일 -->
		        	<input type="text" id="email" name="email" class="form-control" 
        			   required pattern="[a-zA-Z0-9_+.-]+@([a-zA-Z0-9-]+\.)+[a-zA-Z0-9]{2,4}"
        			   title="올바른 메일 형식이 아닙니다">
		        </div>
		     </div>

	        <div class="row">
	        	<div class="col-4 pt-2 my-1">
		        	<label class="form-label">Phone</label>
		        </div>
		        <div class="col-8 my-1">
		        	<!-- 연락처 -->
		        	<input type="text" id="phone" name="phone" class="form-control" 
        			   required pattern="0\d{1,3}-\d{3,4}-\d{4}"
        			   title="010-1234-5678 형식으로 입력하십시오"
        			   placeholder="ex)010-1234-5678">
		        </div>
	        </div>

        </div>
        <!-- // 탈퇴 회원 점검 박스 -->
        
        <!-- 탈퇴 회원 점검 버튼 -->
        <div class="clear"></div>

		<div id="login_buttons" class="row my-5">
		
			<div class="col-5"></div>
							
			<div class="col-5 ps-2">
				<input type="submit" value="탈퇴 회원 여부 점검" class=" btn btn-outline-secondary"
					   onclick="choose_default_member()" >
			</div>

			<div class="col-2">
				<input type="button" value="회원가입" class=" btn btn-outline-secondary"
					  <%--  onclick="location='${contextPath}/member/join_form?contractOK=ture'"> --%>
					  onclick="return history.back()" > 
			</div>

<%-- 			<div class="col-5 ps-3">
				<input type="button" value="아이디 비밀번호 찾기" class=" btn btn-outline-secondary">
			</div> --%>
			
		</div>

		<!-- //탈퇴 회원 점검 버튼 -->

    </form>  

  </article>
  
<%@ include file="../footer.jsp" %>      
