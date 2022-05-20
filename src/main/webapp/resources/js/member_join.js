// 회원가입(join) 폼 점검(form validation)
window.onload = function() {

	var id_check_flag = false; // 아이디 점검 플래그 변수
	var pw_check_flag = false; // 비밀번호 중복 점검 플래그 변수
	var name_check_flag = false; // 이름 점검 플래그 변수
	var email_check_flag = false; // 이메일 점검 플래그 변수
	var phone_check_flag = false; // 연락처 점검 플래그 변수
	
////////////////////////////////////////////////////////////////////////////////////////////
	
	// 유효성 확인
	console.log("아이디 유효성 통과 : " + id_check_flag);
	console.log("비밀번호 유효성 통과 : " + pw_check_flag);
	console.log("이름 유효성 통과 : " + name_check_flag);
	console.log("이메일 유효성 통과 : " + email_check_flag);
	console.log("연락처 유효성 통과 : " + phone_check_flag);

////////////////////////////////////////////////////////////////////////////////////////////
	
	// 필수 항목
	var join_id = document.querySelector("form#join input#id");
/*	var pwdCheck = document.getElementById("pwdCheck");	*/
	var join_pwdCheck = document.querySelector("form#join input#pwdCheck");
	var join_name = document.querySelector("form#join input#name");
	var join_email = document.querySelector("form#join input#email");
	var join_phone = document.querySelector("form#join input#phone");
		
	// 부가 항목 : 상세주소
	var join_zipNum = document.querySelector("form#join input#zipNum");
	var join_address1 = document.querySelector("form#join input#address1");
	var join_address2 = document.querySelector("form#join input#address2");
			
/*	var zipNum = document.getElementById("zipNum").value;
	var address1 = document.getElementById("address1").value;
	var address2 = document.getElementById("address2").value;*/
	
////////////////////////////////////////////////////////////////////////////////////////////
	
	// 아이디 유효성 점검 시작
	
	$("#id").keyup(function(){
		idReg();
	})
	
	function idReg(){
		
		console.log("아이디 값 : " + join_id.value);
		
		// 폼 점검(form validation)
		// console.log("아이디 유효성 점검 여부 : " + join_id.value.match(/^[a-zA-Z]{1}\w{7,19}$/));
		// console.log("아이디 유효성 점검 여부2 : " + new RegExp(/^[a-zA-Z]{1}\w{7,19}$/).test(join_id.value));
		
		var regex_id = new RegExp(/^[a-zA-Z]{1}\w{7,19}$/);			
				
		if (regex_id.test(id.value) == false){
			
			console.log("아이디 유효성 점검 : 땡탈락");
			document.getElementById("id_err_msg").innerHTML = id.title;
			
			id_check_flag = false;
			$("#id_check_flag").html("false"); 			
			
		}else {
			
			console.log("아이디 유효성 점검 : 성공");
						
			$.ajax({
				url: "../member/id_check" ,
				type: "get",
				data : { id : $("form#join input#id").val() } ,
				dataType: "text",
				success : function(data) {
					console.log("data : " + data);
					
					if (data.trim() == '회원 존재'){
						document.getElementById("id_err_msg").innerHTML ="<font color='red'><b>이미 존재하는 회원입니다.</b>";
						
						id_check_flag = false;
						$("#id_check_flag").html("false"); // 플래그 모니터링에 반영
						
						// 탈퇴한 회원이 재가입 시도 했을 때
						
						if (confirm("탈퇴한 회원이시면 재가입을 하시겠습니까?")) {
							
							location.href = "../member/check_inactive_member"; 
							
						}
						
					} else {
						document.getElementById("id_err_msg").innerHTML ="<font color='skyblue'><b>가입할 수 있는 아이디입니다.</b>";
						
						id_check_flag = true;
						$("#id_check_flag").html("true"); // 플래그 모니터링에 반영
					}
				},
				error : function(xhr, status, error) {
					console.error("xhr : " + xhr);
					console.error("status : " + status);
					console.error("error : " + error);
				}
					
			}); // ajax
		}
		} 
		// 아이디 중복점검
	
////////////////////////////////////////////////////////////////////////////////////////////	
	
		// 비밀번호  점검
		
		// pwd, pwdCheck 둘다 사용하기 위해  함수밖으로 이동
		var pwd = document.getElementById("pwd");
		var regex_pwd = new RegExp(/^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,20}$/);

		pwd.onblur = function() {
					
			console.log("비밀번호 유효성 점검");	

			console.log("pwd : " + pwd.value);
			
			// 비밀번호 유효성 점검
			
			if (regex_pwd.test(pwd.value) == false){
				
				console.log("비밀번호 유효성 점검 : 땡탈락");
				
				// 에러 메시징
				document.getElementById("pwd_err_msg1").innerHTML = pwd.title;
				
				pw_check_flag = false;
				$("#pw_check_flag").html("false"); // 플래그 모니터링에 반영	
				
			} else {
				// 에러 메시지 초기화
				document.getElementById("pwd_err_msg1").innerHTML = "";
				
				if(pwd.value != join_pwdCheck.value) {
				
					console.log("비밀번호 안맞음")
				
					// 에러 메시징
					document.getElementById("pwd_err_msg2").innerHTML = "비밀번호가 일치하지 않습니다";
					
					pw_check_flag = false;
					$("#pw_check_flag").html("false"); // 플래그 모니터링에 반영

				} else {
					document.getElementById("pwd_err_msg2").innerHTML = "";
					
					pw_check_flag = true;
					$("#pw_check_flag").html("true"); // 플래그 모니터링에 반영
				}
						
			}
		} 
		
		join_pwdCheck.onblur = function() {
			
			console.log("비밀번호 일치여부 점검");
									
			console.log("join_pwdCheck : " + join_pwdCheck.value);
								
			if (regex_pwd.test(pwd.value) == true && pwd.value == join_pwdCheck.value && pwd.value != '') {
				
				console.log("비밀번호 일치")
				
				// 에러 메시지 초기화
				document.getElementById("pwd_err_msg2").innerHTML = "";
				
				pw_check_flag = true;
				$("#pw_check_flag").html("true"); // 플래그 모니터링에 반영
			
			} else {
				
				console.log("비밀번호 안맞음")
				
				// 에러 메시징
				document.getElementById("pwd_err_msg2").innerHTML = "비밀번호가 일치하지 않습니다";
				
				pw_check_flag = false;
				$("#pw_check_flag").html("false"); // 플래그 모니터링에 반영
			
			}
		
	}
		// 비밀번호 점검 끝

///////////////////////////////////////////////////////////////////////////////////////////
		
		// 이름 유효성 점검 시작
		
		join_name.onblur = function() {

			console.log("회원 이름 점검 : " + join_name.value);
			
			var regex_name = new RegExp(/^[가-힣]{2,13}/);
			
			if (regex_name.test(join_name.value)){
			
				console.log("이름 유효성 통과");
				
				// 에러 메세지 초기화
				document.getElementById("name_err_msg").innerHTML = "";
				
				name_check_flag = true;
				document.getElementById("name_check_flag").innerHTML = "true";
				
			} else {
				
				console.log("이름 유효성 오류")
				
				// 에러 메시징
				document.getElementById("name_err_msg").innerHTML = join_name.title;
				
				name_check_flag = false;
				document.getElementById("name_check_flag").innerHTML = "false";
				
			}
		}
		// 이름 점검 끝
		
/////////////////////////////////////////////////////////////////////////////////////////////
	
		// 이메일 점검 시작
		
		join_email.onblur = function() {
			
			console.log("이메일 값 : " + join_email.value);
			
			const join_email_valid = new RegExp(/^[a-zA-Z0-9_+.-]+@([a-zA-Z0-9-]+\.)+[a-zA-Z0-9]{2,4}$/).test(join_email.value);
			
			// ajax 전송 여부
			
			if(join_email_valid == true) {
				
				console.log("이메일 유효성 점검 : 통과");
				
				//ajax 포함해서 플래그 결과
				
				$.ajax({
					url: "../member/email_check" ,
					type: "get",
					data : { email : $("form#join input#email").val() } ,
					dataType: "text",
					success : function(data) {
						console.log("data : " + data);
						
						if (data.trim() == '이메일 존재'){
							document.getElementById("email_err_msg").innerHTML = "<font color='red'><b>이미 가입된 이메일입니다.</b>";
							
							email_check_flag = false;
							$("#email_check_flag").html("false"); // 플래그 모니터링에 반영
							
						} else {
							document.getElementById("email_err_msg").innerHTML = "<font color='skyblue'><b>가입할 수 있는 이메일입니다.</b>";
							
							email_check_flag = true;
							$("#email_check_flag").html("true"); // 플래그 모니터링에 반영
						}
					},
					error : function(xhr, status, error) {
						console.error("xhr : " + xhr);
						console.error("status : " + status);
						console.error("error : " + error);
					}
						
				}); // ajax
				
			} else {
				
				console.log("이메일 유효성 점검 : 땡탈락");
				
				// 에러 메시징
				document.getElementById("email_err_msg").innerHTML = join_email.title;
							
				email_check_flag = false;
				document.getElementById("email_check_flag").innerHTML = "false";
				
			}
		}
		
		
		
		// 이메일 점검 끝
////////////////////////////////////////////////////////////////////////////////////////////		

		// 연락처 점검 시작
		
		join_phone.onblur = function() {
			
			console.log("연락처 값 : " + join_phone.value);
			
			var regex_phone = new RegExp(/^0\d{1,3}-\d{3,4}-\d{4}$/);			
					
			if (regex_phone.test(phone.value) == false){
				
				console.log("연락처 유효성 점검 : 땡탈락");
				
				// 에러 메시징
				document.getElementById("phone_err_msg").innerHTML = join_phone.title;
				
				phone_check_flag = false;
				$("#phone_check_flag").html("false"); // 플래그 모니터링에 반영
				
				
			}else {
				
				console.log("연락처 유효성 점검 : 성공");
							
				$.ajax({
					url: "../member/phone_check" ,
					type: "get",
					data : { phone : $("form#join input#phone").val() } ,
					dataType: "text",
					success : function(data) {
						console.log("data : " + data);
						
						if (data.trim() == '연락처 존재'){
							document.getElementById("phone_err_msg").innerHTML ="<font color='red'><b>이미 존재하는 연락처입니다.</b>";
							
							phone_check_flag = false;
							$("#phone_check_flag").html("false"); // 플래그 모니터링에 반영

							
						} else {
							document.getElementById("phone_err_msg").innerHTML ="<font color='skyblue'><b>가입할 수 있는 연락처입니다.</b>";
							
							phone_check_flag = true;
							$("#phone_check_flag").html("true"); // 플래그 모니터링에 반영
						}
					},
					error : function(xhr, status, error) {
						console.error("xhr : " + xhr);
						console.error("status : " + status);
						console.error("error : " + error);
					}
						
				}); // ajax
			}
			
		}

		// 연락처 점검 끝
		
////////////////////////////////////////////////////////////////////////////////////////////
		
		// 주소 유효성 점검 시작
		
		join_address2.onblur = function() {

			console.log("상세 주소 점검 : " + join_address2.value);
			
			if ((join_zipNum.value == '' && join_address1.value == '' && join_address2.value.trim() == '') ||
				(join_zipNum.value != '' && join_address1.value != '' && join_address2.value.trim() != ''))
			{
			
				console.log("상세 주소 유효성 통과");
				
				// 에러 메세지 초기화
				document.getElementById("address2_err_msg").innerHTML = "";
				
			} else if(join_zipNum.value == '' && join_address1.value == '' && join_address2.value.trim() != '') {
				console.log("상세 주소  유효성 오류")
				
				// 에러 메시징
				document.getElementById("address2_err_msg").innerHTML = "전체 주소를 입력하십시오";
			
			} else {
				
				console.log("상세 주소  유효성 오류")
				
				// 에러 메시징
				document.getElementById("address2_err_msg").innerHTML = "상세 주소를 입력하십시오";
								
			}
		}
		// 주소 점검 끝
		
		// 주소 초기화 시작
		
		address_init_btn.onclick = function() {
			
			console.log("주소 초기화");
			
			join_zipNum.value = "";
			join_address1.value = "";
			join_address2.value = "";
			
		}
		
		// 주소 초기화 끝
	
////////////////////////////////////////////////////////////////////////////////////////////

		
		// 회원정보 전송 (가입) 시작
		
		join_submit.onclick = function() {
			
			console.log("회원 정보 전송(가입)");
			
			console.log("아이디 유효성 통과 : " + id_check_flag);
			console.log("비밀번호 유효성 통과 : " + pw_check_flag);
			console.log("이름 유효성 통과 : " + name_check_flag);
			console.log("이메일 유효성 통과 : " + email_check_flag);
			console.log("연락처 유효성 통과 : " + phone_check_flag);
			
			// 필수항목 점검
			if (id_check_flag == true && // 아이디 점검 플래그 변수
				pw_check_flag == true && // 비밀번호 중복 점검 플래그 변수
				name_check_flag == true && // 이름 점검 플래그 변수
				email_check_flag == true && // 이메일 점검 플래그 변수
				phone_check_flag == true) // 연락처 점검 플래그 변수
			{
			console.log("필수항목 점검 완료");
			
			// 부가항목 점검
			// 주소 : 전송 가능상태
			// 주소 폼 3개가 모두 공란 or 모두 입력상태
			
			if ((join_zipNum.value == '' && join_address1.value == '' && join_address2.value.trim() == '') ||
			   (join_zipNum.value != '' && join_address1.value != '' && join_address2.value.trim() != ''))
			{
				// 회원 정보 전송 (가입)
				console.log("회원정보 전송");
				
				document.getElementById("join").submit();
				
			} else {
				
				// 회원 정보 미전송
				console.log("부가정보 점검 실패");
				
				alert("주소 정보를 다시 입력해주세요");
				
			}
				
		} else {
			console.log("필수항목 점검 실패");
			
			alert("가입정보를 다시 입력해주세요");
		}
			
			
		}
		
		
		
		// 회원정보 전송 (가입) 끝
				
////////////////////////////////////////////////////////////////////////////////////////////

		
		
	} // window.onload 끝