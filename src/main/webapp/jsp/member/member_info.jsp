<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!--  header -->
<%@ include file="../header.jsp" %>
<%@ include file="sub_menu_member.jsp" %>  

<style>
article#view_box {
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


<article id ="view_box">

	<h2 class="my-3">회원 정보</h2>
	
	<%-- ${LOGIN_USER} --%>

    <form id="member_view">

      <fieldset>

        <legend class="join_title">Basic Info</legend>
        
        <!-- 아이디 -->
 		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label">User ID</label>
        	</div>
        	<div class="col-8 mt-1">
        		${LOGIN_USER.id}
        	</div>
        </div>   

 		<!-- 비밀번호 -->
  		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label">Password</label>
        	</div>
        	<div class="col-8 mt-1">
        		<%-- ${LOGIN_USER.pwd} --%>
        		**********
        	</div>
        </div> 
 
 		<!-- 회원 이름 -->
  		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label">Name</label>
        	</div>
        	<div class="col-8 mt-1">
        		${LOGIN_USER.name}
        	</div>
        </div> 
 
 		<!-- 이메일 -->
  		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label">E-mail</label>
        	</div>
        	<div class="col-8 mt-1">
        		${LOGIN_USER.email}
        	</div>
        </div> 
 
 		<!-- 연락처 -->
  		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label">Phone Number</label>
        	</div>
        	<div class="col-8 mt-1">
        		${LOGIN_USER.phone}
        	</div>
        </div>
   
      </fieldset>

      <fieldset>

        <legend class="join_title" style="margin:10px 0">Optional</legend>

 		<!-- 우편번호 -->
  		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label">Zip Code</label>
        	</div>
        	<div class="col-4 mt-1">
        		${LOGIN_USER.zipNum}
        	</div>
        	<div class="col-4">      		
        	</div>
        </div> 

 		<!-- 회원 기본 주소 -->
  		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label">Address(Basic)</label>
        	</div>
        	<div class="col-8 mt-1">
        		${LOGIN_USER.address1}
        	</div>
		</div>
		
 		<!-- 회원 상세 주소 -->
  		<div class="row my-2">
        	<div class="col-4">
        		<label class="form-label">Address(Detail)</label>
        	</div>
        	<div class="col-8 mt-1">
        		${LOGIN_USER.address2}
        	</div>
        </div> 
    
      </fieldset>
      

    </form>




</article>

<!-- footer -->
<%@ include file="../footer.jsp" %>