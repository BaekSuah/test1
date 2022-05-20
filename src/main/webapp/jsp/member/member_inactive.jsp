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
/* 
form fieldset legend.join_title {
	font-size: 17pt; 
	border-bottom: 1px dotted #ccc; 
	width: 680px; 
	padding: 10px 0; 
	margin: 10px 0 ;
} */
</style>

<script>
if (confirm("정말 회원 탈퇴하시겠습니까?")) {

	console.log("탈퇴");
	location.href = "${contextPath}/member/member_inactive_proc";
	
} else {
	console.log("탈퇴 취소");
	alert("탈퇴 요청을 취소하였습니다");
	
}

</script>


<article id="inactive_box" class="container">

	회원 탈퇴

</article>


<!-- footer -->
<%@ include file="../footer.jsp" %>