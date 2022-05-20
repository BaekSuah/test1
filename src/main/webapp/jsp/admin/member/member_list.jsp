<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<%@ page import="java.util.*" %>
<%@ page import="com.suah.project.domain.*" %>

<!-- contextPath -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" /> 

<!DOCTYPE html>
<html lang="ko-kr">
<head>
	<meta charset="UTF-8">
	<title>Suah_project Admin</title>
	
	<!-- google material(icon) -->
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

	<!-- jquery -->
	<script src="<c:url value="/webjars/jquery/3.6.0/jquery.min.js" />"></script>
	
	<!-- bootstrap -->
	<link href="<c:url value="/bootstrap/5.1.3/css/bootstrap.min.css" />" rel="stylesheet" />
	<script src="<c:url value="/bootstrap/5.1.3/js/bootstrap.bundle.min.js" />"></script>	

  <script>
	// java List => javascript Array
	function getRoleFromMembers(num) {
		
		var i = 0;
		var arr = new Array(); // javascript 배열
		<%
		
		List<MemberRoleVO> list = (List<MemberRoleVO>)request.getAttribute("members");
			for (int i=0; i<list.size(); i++) {
				
				MemberRoleVO roleVO = list.get(i);
		%>
				arr.push("<%=roleVO.getRole() %>"); // javascript 배열에 요소 추가
		<%
			}
		%>
		
		// java List => javascript Array 변환 완료
		
		console.log("arr : " + arr[num]);
		
		return arr[num];
	}
	
	window.onload = function() {
		
		var limit = "${pageVO.limit}";
		
		// 회원 롤(role) 제어
		// 초기 상태(값) 반영
		//console.log("선택된 항목(option)의 index2 : " + selectBox.selectedIndex);
		//console.log("선택된 항목의 텍스트 : " + selectBox.options[selectBox.selectedIndex].text);
		//console.log("선택된 항목의 값 : " + selectBox.options[selectBox.selectedIndex].value);
		
		// select box(role) id => "role0"
		var selectBoxId;
		var selectBox;
		
		var role;
		
		for (var i=0; i<limit; i++) {
			
			selectBoxId = "role" + i;
			selectBox = document.getElementById(selectBoxId);
			
			// role = "${members[0].role}"; // (X)
			role = getRoleFromMembers(i); // java List => javascript Array
			
			console.log("개별 회원 role : " + role);
			
			for (var j=0; j<selectBox.options.length; j++) {
				
				if (selectBox.options[j].value == role) {
					selectedIdx = j;					
				}
				
			} // for
			
			console.log(j + "의 selectedIdx : " + selectedIdx);
			
			selectBox.selectedIndex = selectedIdx; // role => select에 반영
			
		} // for
		
		
		// 관리자가 변경시 변경 사항 반영 : ajax
		var roleSelectBoxes = document.querySelectorAll("select[id^=role]");
		
		for (var roleSelectBox of roleSelectBoxes) {
		
			roleSelectBox.onchange = function(e) {
				
				console.log("이벤트 발생");
				console.log("roleSelectBoxes onchange event : " + e.currentTarget.id);
				
				var tempId = e.currentTarget.id;
				console.log("target title : " + document.getElementById(tempId).title);
				// console.log("target name : " + document.getElementById(id).name);
				
				console.log("선택된 값 : " + document.getElementById(tempId).value);
				
				// 회원 아이디
				var memberId =  document.getElementById(tempId).title;
				// 회원 롤(role)
				var memberRole = document.getElementById(tempId).value;
				
				/*
				// AJAX : 회원 id, 회원 role => update => success => 전체 현황 reload
				$.ajax({
					url : "../member/id_check",
					type : "get",
					data : { 
						id : memberId,
						role : memberRole
					},
					dataType: "text",
					success : function(data) {
						
						console.log("data : " + data);
						
						
						
						
					},
					error : function(xhr, status, error) {
						
						console.error("xhr : " + xhr);
						console.error("status : " + status);
						console.error("error : " + error);
					}
					
				}); // ajax
				*/
			} //
		
		} // for
		
	}
	</script>
	
<style>
	/* 전체 레이아웃 */
	div#wrap {
		width:1300px;
		/* background:yellow; */
		height:98vh;
		margin:auto;	
	}
	
	/* 로고 */
	div#logo {
		width:200px;
		float:left;
		/* background-color:#E7B9C0; */
	}
	
	/* 상단부 */
	header {
		width:100%;
		height:100px;
		/* background-color:cyan; */
	}
	
	/* 메뉴 */
	nav ul {
		list-style-type:none;
		margin:0;
		padding:0;
		overflow:hidden;
		width:1000px;
		/* background-color:#FFE5D4; */
	}
	
	nav ul li {
		float:left;
	}
	
	nav ul li a {
		display:block;
		padding:35px 50px;
		text-decoration:none;
		text-align:center;
		font-size:1.2em;
		color:#000;
		font-weight:bold;
	}
	
	/* 현황 본문 */
	article {
		width:100%;
		height:calc(97vh - 200px);
		/* background-color:#C8EBFA; */
	}
	
	/* 하단부 */ 
	footer {
		margin:10px 0 0 0;
		/* height:60px; */
		height:80px;
		/* background-color:lightgray; */
		background-image: url('../../img/under_logo.png');
		background-repeat: no-repeat;
		background-position: 40px center;
	}
	
	footer #copy {
		margin: 20px 0 30px 300px;
		width:600px;	
		float:left;	
		line-height:2em;
		/* background-color:cyan; */
	}
	</style>
	
</head>
<body>

	<div id="wrap">
	
		<header>
		 	
		 	<!--로고 들어가는 곳 시작--->  
		    <div id="logo">
		      <a href="${contextPath}/">
		        <img src="<c:url value="/img/logo.png" />" width="180" height="100" alt="SuahProject">
		      </a>  
		    </div>
		    <!--로고 들어가는 곳 끝-->
		    
		    <nav>
		    	<ul>
			    	<li><a href="#">상품 리스트</a></li>
			    	<li><a href="#">주문 리스트</a></li>
			    	<li><a href="#">회원 리스트</a></li>
			    	<li><a href="#">Q&amp;A리스트</a></li>
			    	<li><a href="#">로그아웃</a></li>
			    	<!-- <li><a href="#">로그인</a></li> -->
		    	</ul>
		    </nav>
		         
		</header>
		
		<!--  페이지 관련 인자들 -->
		<div>
			<table class="table table-striped">
				<thead>
			      <tr>
			        <th>인자</th>
			        <td>현재페이지</td>
			        <td>시작페이지</td>
			        <td>마지막페이지</td>
			        <td>페이지당 게시글 수</td>
			        <td>총 페이지 수</td>
			        
			      </tr>
			    </thead>
			    <tbody>
			      <tr>
			        <th>값</th>
			        <td>${pageVO.currPage}</td>
			        <td>${pageVO.startPage}</td>
			        <td>${pageVO.endPage}</td>
			        <td>${pageVO.limit}</td>
			        <td>${pageVO.maxPage}</td>
			        
			      </tr>
			    </tbody>
			
			</table>		
		</div>

		
		<!-- 현황 본문 -->
		<article >
			
			<!-- 회원 정보 리스트 -->
			<div class="table-responsive mt-5">
			
				<table class="table table-hover table-striped" style="width:1800px;">
					<thead>
						<tr>
							<th>번호</th>
							<th>아이디</th>
							<th>비밀번호</th>
							<th>이름</th>
							<th>이메일</th>
							<th>연락처</th>
							<th>우편번호</th>
							<th>기본주소</th>
							<th>상세주소</th>
							<th>활성화 여부</th>
							<th>가입날짜</th>
							<th>회원 등급</th>
							<th>관리자 메뉴</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="member" items="${members}" varStatus="st">
					
						<tr>
							<td>${pageVO.limit*(pageVO.currPage-1) + st.count}</td>
							<td>${member.id}</td>
							<%-- <td>${member.pwd}</td> --%>
							<td>********</td>
							<td>${member.name}</td>
							<td>${member.email}</td>
							<td>${member.phone}</td>
							<td>${member.zipNum}</td>
							<td>${member.address1}</td>
							<td>${member.address2}</td>
							<td>${member.useyn == 'y' ? "회원" : "탈퇴"}</td>
							<td><fmt:formatDate value="${member.indate}" pattern="yyyy년  MM월  dd일 HH:mm:ss" /></td>
							<%-- <td>${member.role == 'user' ? "일반회원" : member.role == 'admin' ? "관리자" : "게스트"}</td> --%>

							<td>
								<select id="role${st.index}" title="${member.id}" name="role${st.index}" class="form-select" >
									<option value="user">일반회원</option>
									<option value="admin">관리자</option>
									<option value="guest">게스트</option>
								</select>
							</td>
							
							<td>
								<div class="btn-group btn-group-sm mt-1">
								  <button type="button" class="btn btn-secondary py-1">수정</button>
								  <button type="button" class="btn btn-light py-1">삭제</button>
								</div>
							</td>
																				
						</tr>
						
						</c:forEach>					
					</tbody>
				</table>
			
			</div>
			
			<!--  페이징 -->
			<div class="w-100 mt-3">				
				<ul class="pagination justify-content-center">
	
				 	<!-- 현재페이지가 처음페이지가 아니라면 링크 출력 -->
				 	<c:if test="${pageVO.currPage != pageVO.startPage}">
				 	
				 	<!-- 첫 페이지 -->
					<li class="page-item" style="width:40px;">
						<a class="page-link pt-0 pb-1" 
							href="${contextPath}/admin/member/memberList?page=${pageVO.startPage}&limit=${pageVO.limit}" 
							style="font-size:16pt">&laquo;
						</a>
					</li>
					
					<!-- 이전페이지 -->
				 	<li class="page-item" style="width:40px;">
				 		<a class="page-link"
				 			href="${contextPath}/admin/member/memberList?page=${pageVO.currPage-1}&limit=${pageVO.limit}">
				 			&lt;
				 		</a>
				 	</li>				 	
					
					<li class="page-item" style="width:40px;">
						<a class="page-link text-center" 
							href="${contextPath}/admin/member/memberList?page=${pageVO.currPage-1}&limit=${pageVO.limit}">
							${pageVO.currPage-1}				
						</a>
					</li>
					</c:if>
					
					<!-- 현재페이지가 처음페이지라면 블랭크 링크 출력 -->
				 	<c:if test="${pageVO.currPage == pageVO.startPage}">
				 	
				 	<!-- 첫 페이지 -->
					<li class="page-item" style="width:40px; align-text:center mx-auto">
					<a class="page-link pt-0 pb-1 text-secondary opacity-50" style="font-size:16pt;">&laquo;</a>
					</li>
					
					<!-- 이전페이지 -->
					<li class="page-item" style="width:40px">
					<a class="page-link text-secondary opacity-50">&lt;</a>
					</li>			 	
					
					<li class="page-item" style="width:40px">
					<a class="page-link">&nbsp;</a>
					</li>
					</c:if>
					
					<!-- 현재 페이지 -->
					<li class="page-item active" style="width:40px">
						<a class="page-link text-center" 
						href="${contextPath}/admin/member/memberList?page=${pageVO.currPage}&limit=${pageVO.limit}" 
						>${pageVO.currPage}
						</a>
					</li>
					
					<!-- 다음 페이지 -->
					<!-- 현재페이지가 마지막 페이지가 아니라면 -->
					<c:if test="${pageVO.currPage != pageVO.endPage}">
					<li class="page-item" style="width:40px">
						<a class="page-link text-center" 
							href="${contextPath}/admin/member/memberList?page=${pageVO.currPage+1}&limit=${pageVO.limit}">
							${pageVO.currPage+1}
						</a>
					</li>
					
					<li class="page-item" style="width:40px">
						<a class="page-link" 
							href="${contextPath}/admin/member/memberList?page=${pageVO.currPage+1}&limit=${pageVO.limit}">
							&gt;
						</a>
					</li>
					
					<!-- 마지막 페이지 -->
					<li class="page-item" style="width:40px">
						<a class="page-link pt-0 pb-1" 
							href="${contextPath}/admin/member/memberList?page=${pageVO.endPage}&limit=${pageVO.limit}"  
							style="font-size:16pt">&raquo;
						</a>
					</li>					
					</c:if>
					
					<!-- 현재페이지가 마지막 페이지라면 블랭크 링크 출력 -->
				 	<c:if test="${pageVO.currPage == pageVO.endPage}">
				 	
				 	<!-- 빈페이지 -->
				 	<li class="page-item" style="width:40px">
					<a class="page-link">&nbsp;&nbsp;</a>
					</li>
							
					<!-- 다음 페이지 -->
					<li class="page-item" style="width:40px">
					<a class="page-link text-secondary opacity-50">&gt;</a>
					</li>
					
					<!-- 마지막 페이지 -->	
					<li class="page-item" style="width:40px">
					<a class="page-link pt-0 pb-1 text-secondary opacity-50" style="font-size:16pt;">&raquo;</a>
					</li>		 	
					

					</c:if>
									
				</ul>			
			</div>
			
			<!-- 검색 -->
			<div class="w-100 row mt-2">
			
				<div class="col-3 "></div>
				
				<div class="col-2">
					<select name="search_field" class="form-select">
					<option>아이디</option>
					<option selected>이름</option>
					<option>이메일</option>
					<option>연락처</option>
					</select>				
				</div>
				
				<div class="col-3">
					<input type="text" name="search_word" class="form-control">
				</div>
				
				<div class="col-4">
					<button class="btn btn-secondary">검색</button>
				</div>
				
			</div>
			
		</article>

<%@ include file="../../footer.jsp" %>