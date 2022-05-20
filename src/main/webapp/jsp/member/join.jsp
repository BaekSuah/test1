<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  

<%@ include file="../header.jsp" %>   
<%@ include file="sub_img.jsp"%> 
<%@ include file="sub_menu.jsp" %>   

<script type="text/javascript" src="<c:url value="/js/member_join.js" />" charset="UTF-8"></script>


<style>
article#join_box {
	float:left;
	margin-left: 50px;
	width:680px;
	font-size:13pt;
	line-height:21pt;
/* 	background-color:yellow; */	
}

form fieldset legend.join_title {
	font-size: 17pt; 
	border-bottom: 1px dotted #ccc; 
	width: 680px; 
	padding: 10px 0; 
	margin: 10px 0 ;
}
</style>

  <article id="join_box">

    <h2>Join Us</h2>

    <form id="join" action="${contextPath}/member/join_proc" method="post" name="formm">

      <fieldset>

        <legend class="join_title">Basic Info</legend>
        
        <!-- 아이디 -->
 		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label">User ID</label>
        	</div>
        	<div class="col-8">
        		<input type="text" id="id" name="id" class="form-control" 
        			   required	pattern="[a-zA-Z]{1}\w{7,19}"
        		       title="아이디는 영문+숫자 조합으로 8~20사이로 입력하십시오">
        	</div>
        </div>   
        
        <!-- 아이디 유효성 에러 메시지 -->       
		<div class="row text-danger" >
			<div class="col-4"></div>
			<div class="col-8" id="id_err_msg" ></div>
		</div>     	

      	<input type="hidden" name="reid">           

        <!-- <input type="button"    value="중복 체크"  class="dup" onclick="idcheck()"><br> -->
 
 		<!-- 비밀번호 -->
  		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label">Password</label>
        	</div>
        	<div class="col-8">
        		<input type="password" id="pwd" name="pwd" class="form-control" 
        			   required pattern="(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,20}"
        			   title="비밀번호는 영문+숫자 및 특수문자 최소 1자의 조합으로 8~20사이로 입력하십시오">
        	</div>
        </div> 
        
        <!-- 비밀번호 유효성 에러 메시지 -->       
		<div class="row text-danger" >
			<div class="col-4"></div>
			<div class="col-8" id="pwd_err_msg1" ></div>
		</div>
        
 		<!-- 비밀번호 확인 -->
  		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label w-100">Retype-Password</label>
        	</div>
        	<div class="col-8">
        		<input type="password" id="pwdCheck" name="pwdCheck" class="form-control" 
        			   required pattern="(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,20}"
        			   title="비밀번호는 영문+숫자 및 특수문자 최소 1자의 조합으로 8~20사이로 입력하십시오">
        	</div>
        </div>  
        
        <!-- 비밀번호 일치여부 에러 메시지 -->       
		<div class="row text-danger" >
			<div class="col-4"></div>
			<div class="col-8" id="pwd_err_msg2" ></div>
		</div>


 		<!-- 회원 이름 -->
  		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label">Name</label>
        	</div>
        	<div class="col-8">
        		<input type="text" id="name" name="name" class="form-control" 
        			   required pattern="[가-힣]{2,13}"
        			   title="이름은 한글로 13자까지만 허용합니다">
        	</div>
        </div> 
        
        <!-- 이름 에러 메시지 -->       
		<div class="row text-danger" >
			<div class="col-4"></div>
			<div class="col-8" id="name_err_msg" ></div>
		</div>

 		<!-- 이메일 -->
  		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label">E-mail</label>
        	</div>
        	<div class="col-8">
        		<input type="text" id="email" name="email" class="form-control" 
        			   required pattern="[a-zA-Z0-9_+.-]+@([a-zA-Z0-9-]+\.)+[a-zA-Z0-9]{2,4}"
        			   title="올바른 메일 형식이 아닙니다">
        	</div>
        </div> 
        
        <!-- 이메일 에러 메시지 -->       
		<div class="row text-danger" >
			<div class="col-4"></div>
			<div class="col-8" id="email_err_msg" ></div>
		</div>
        
        <br><br>
        
 		<!-- 연락처 -->
  		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label">Phone Number</label>
        	</div>
        	<div class="col-8">
        		<input type="text" id="phone" name="phone" class="form-control" 
        			   required pattern="0\d{1,3}-\d{3,4}-\d{4}"
        			   title="010-1234-5678 형식으로 입력하십시오"
        			   placeholder="ex)010-1234-5678">
        	</div>
        </div>
        
        <!-- 연락처 에러 메시지 -->       
		<div class="row text-danger" >
			<div class="col-4"></div>
			<div class="col-8" id="phone_err_msg" ></div>
		</div>
         

      </fieldset>

      <fieldset>

        <legend class="join_title">Optional</legend>

 		<!-- 우편번호 -->
  		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label">Zip Code</label>
        	</div>
        	<div class="col-2">
        		<input type="text" id="zipNum" name="zipNum" class="form-control bg-light" readonly >
        	</div>
        	<div class="col-2">
        		<input type="button" value="주소 찾기" class="btn btn-outline-secondary" onclick="getPostcodeAddress()" >
        	</div>
        	<div class="col-2">
        		<input type="button" id="address_init_btn" value="초기화" class="btn btn-outline-secondary" >
        	</div>
        </div> 

 		<!-- 회원 기본 주소 -->
  		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label">Address(Basic)</label>
        	</div>
        	<div class="col-8">
        		<input type="text" id="address1" name="address1" class="form-control bg-light" readonly>
        	</div>
		</div>
		
 		<!-- 회원 상세 주소 -->
  		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label">Address(Detail)</label>
        	</div>
        	<div class="col-8">
        		<input type="text" id="address2" name="address2" class="form-control" >
        	</div>
        </div> 
        
        <!-- 주소 에러 메시지 -->       
		<div class="row text-danger" >
			<div class="col-4"></div>
			<div class="col-8" id="address2_err_msg" ></div>
		</div>
        

      </fieldset>
      
     
      <div id="buttons" class="row mb-3">
      	<div class="col-5"></div>
      	<div class="col-4 ps-5 pe-3">
        	<input type="button" id="join_submit" class="btn btn-outline-secondary px-5" value="회원가입"> 
        </div>
        <div class="col-3">
      	  <input type="reset" class="btn btn-outline-secondary px-5" value="취소" >
      	</div>
      </div>


    </form>
  </article>
  
  
<%@ include file="../footer.jsp" %>
  