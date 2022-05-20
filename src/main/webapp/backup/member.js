function go_save() {
  if (document.formm.id.value == "") {
    alert("아이디를 입력하여 주세요.");
    document.formm.id.focus();
  } else if (document.formm.id.value != document.formm.reid.value) {
    alert("중복확인을 클릭하여 주세요.");
    document.formm.id.focus();
  } else if (document.formm.pwd.value == "") {
    alert("비밀번호를 입력해 주세요.");
    document.formm.pwd.focus();
  } else if ((document.formm.pwd.value != document.formm.pwdCheck.value)) {
    alert("비밀번호가 일치하지 않습니다.");
    document.formm.pwd.focus();
  } else if (document.formm.name.value == "") {
    alert("이름을 입력해 주세요.");
    document.formm.name.focus();
  } else if (document.formm.email.value == "") {
    alert("이메일을 입력해 주세요.");
    document.formm.email.focus();
  } else {
    document.formm.action = "NonageServlet?command=join";
    document.formm.submit();
  }
}

function idcheck() {
  if (document.formm.id.value == "") {
    alert('아이디를 입력하여 주십시오.');
    document.formm.id.focus();
    return;
  }
  var url = "NonageServlet?command=id_check_form&id=" 
+ document.formm.id.value;
  window.open( url, "_blank_1",
"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=330, height=200");
}

/*// 다음넷 서비스로 대체
function post_zip() {
  var url = "NonageServlet?command=find_zip_num";
  window.open( url, "_blank_1",
"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=550, height=300, top=300, left=300, ");
}
*/

///////////////////////////////////////////////////////////////////////////////

// 도로명 주소 검색
function getPostcodeAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            /*
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }
            */
            
            fullAddr = data.roadAddress; // 지번/도로명 => 도로명 주소

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            // if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            // }
            
           // 주소 정보 전체 필드 및 내용 확인 : javateacher
           /*
            var output = '';
            for (var key in data) {
            	output += key + ":" +  data[key]+"\n";
            }
            
            console.log(output); 
			*/
			
            // 3단계 : 해당 필드들에 정보 입력
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zipNum').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('address1').value = fullAddr;

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('address2').focus();
        }
    }).open();
}


///////////////////////////////////////////////////////////////////////////////


function go_next() {
	
	console.log("go_next");
	if (document.formm.okon1[0].checked == true) {
//    document.formm.action = "join_form";
//    document.formm.submit();
	  
	  console.log("약관 동의 여부 : " + document.formm.okon1[0].checked);
	  location.href ="join_form?contractOK="+document.formm.okon1[0].checked;
    
  } else if (document.formm.okon1[1].checked == true) {
    alert('약관에 동의하셔야만 합니다.');
  }
}

//////////////////////////////////////////////////////////////////////////////
// 회원가입(join) 폼 점검(form validation)
window.onload = function() {

	var id_check_flag = false; // 아이디 점검 플래그 변수
	var pw_check_flag = false; // 비밀번호 중복 점검 플래그 변수
	var name_check_flag = false; // 이름 점검 플래그 변수
	var email_check_flag = false; // 이메일 점검 플래그 변수
	
	var join_id = document.querySelector("form#join input#id");
	var join_name = document.querySelector("form#join input#name");
	var join_email = document.querySelector("form#join input#email");
		
	$("#id").keyup(function(){
		idReg();
	})
	
	function idReg(){
		
		console.log("아이디 값 : " + join_id.value);
		
		// 폼 점검(form validation)
		// console.log("아이디 유효성 점검 여부 : " + join_id.value.match(/^[a-zA-Z]{1}\w{7,19}$/));
		console.log("아이디 유효성 점검 여부2 : " + new RegExp(/^[a-zA-Z]{1}\w{7,19}$/).test(join_id.value));
		
		var regex_id = new RegExp(/^[a-zA-Z]{1}\w{7,19}$/);			
				
		if (regex_id.test(id.value) == false){
			
			console.log("아이디 유효성 점검 : 땡탈락");
			
			// 에러 메시징
			document.getElementById("id_err_msg").innerHTML = id.title;
			
			document.getElementById("idReg").innerHTML = "";
			
			
		}else {
			
			console.log("아이디 유효성 점검 : 성공");
			
			// 에러 메시지 초기화
			document.getElementById("id_err_msg").innerHTML = "";
			
			$.ajax({
				url: "../member/id_check" ,
				type: "get",
				data : { id : $("form#join input#id").val() } ,
				dataType: "text",
				success : function(data) {
					console.log("data : " + data);
					
					if (data.trim() == '회원 존재'){
						$("#idReg").html("<font color='red'><b>이미 존재하는 회원입니다.</b>");
						
						$("#id_check_flag").html("false"); // 플래그 모니터링에 반영
//								join_id.value = "";
//								join_id.focus();
						
					} else {
						$("#idReg").html("<font color='skyblue'><b>가입할 수 있는 아이디입니다.</b>");
						
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
		
		
	
		//아이디 유효성 점검
	
		/*join_id.onblur = function() {
			
			console.log("아이디 값 : " + join_id.value);
			
			// 폼 점검(form validation)
			// console.log("아이디 유효성 점검 여부 : " + join_id.value.match(/^[a-zA-Z]{1}\w{7,19}$/));
			console.log("아이디 유효성 점검 여부2 : " + new RegExp(/^[a-zA-Z]{1}\w{7,19}$/).test(join_id.value));
			
			let join_id_valid = new RegExp(/^[a-zA-Z]{1}\w{7,19}$/).test(join_id.value);
			
			// ajax 전송 여부
			if (join_id_valid == true) {
				
				// ajax
				console.log("ajax 전송");
				
				$.ajax({
					url: "../member/id_check" ,
					type: "get",
					data : { id : $("form#join input#id").val() } ,
					dataType: "text",
					success : function(data) {
						console.log("data : " + data);
						
						if (data.trim() == '회원 존재'){
							alert("이미 있는 아이디지롱~")
							
							id_check_flag = false;
							$("#id_check_flag").html("false"); // 플래그 모니터링에 반영
//							join_id.value = "";
//							join_id.focus();
							
						} else {
							alert("가입 할수 있는 아이디지롱~")
							
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
				
			} else {
				
				// 필드 초기화 + 재입력
				console.log("재입력");
				

			} // */
		} 
		// 아이디 중복점검
		
		// 비밀번호  점검
		pwd.onblur = function() {
					
			console.log("비밀번호 유효성 점검");
			
			var pwd = document.getElementById("pwd");
			console.log("pwd : " + pwd.value);

			
			// 비밀번호 유효성 점검
			var regex_pwd = new RegExp(/^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,20}$/);
			
			if (regex_pwd.test(pwd.value) == false ){
				
				console.log("비밀번호 유효성 점검 : 땡탈락");
				// 에러 메시징
				document.getElementById("pwd_err_msg1").innerHTML = pwd.title;
				
				pw_check_flag = false;
				$("#pw_check_flag").html("false"); // 플래그 모니터링에 반영
				
				
			} else {
				// 에러 메시지 초기화
				document.getElementById("pwd_err_msg1").innerHTML = "";
				
				// 일치여부까지 확인 후 플래그 모니터링 반영
				
			}
		}
			
		var pw_check_flag = false; // 비밀번호 중복 점검 플래그 변수
		
		pwdCheck.onblur = function() {
				
			console.log("비밀번호 일치여부 점검");
							
			var pwdCheck = document.getElementById("pwdCheck");			
			console.log("pwdCheck : " + pwdCheck.value);
			
			
			if (pwd.value == pwdCheck.value) {
				
				console.log("비밀번호 일치")
				
				// 에러 메시지 초기화
				document.getElementById("pwd_err_msg2").innerHTML = "";
				
				pw_check_flag = true;
				$("#pw_check_flag").html("true"); // 플래그 모니터링에 반영
			
			} else {
				
				console.log("비밀번호 안맞음")
				
				// 에러 메시징
				document.getElementById("pwd_err_msg2").innerHTML = "비밀번호가 일치하지 않지롱~";
				
				pw_check_flag = false;
				$("#pw_check_flag").html("false"); // 플래그 모니터링에 반영
			
			}
		} 
		// 비밀번호 점검 끝
		
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
				
				//오류 메세지 초기화
				document.getElementById("email_err_msg").innerHTML = "";

				//ajax 포함해서 플래그 결과
				
				$.ajax({
					url: "../member/email_check" ,
					type: "get",
					data : { email : $("form#join input#email").val() } ,
					dataType: "text",
					success : function(data) {
						console.log("data : " + data);
						
						if (data.trim() == '이메일 존재'){
							$("#emailReg").html("<font color='red'><b>이미 가입된 이메일입니다.</b>");
							
							email_check_flag = false;
							$("#email_check_flag").html("false"); // 플래그 모니터링에 반영
							
						} else {
							$("#emailReg").html("<font color='skyblue'><b>가입할 수 있는 이메일입니다.</b>");
							
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
				
				// ajax 메세지 초기화
				$("#emailReg").html("");				
				
				//join_email.value = ""; // 초기화
				
				email_check_flag = false;
				document.getElementById("email_check_flag").innerHTML = "false";
				
			}
		}
		
		
		
		// 이메일 점검 끝
////////////////////////////////////////////////////////////////////////////////////////////		
	console.log("아이디 유효성 통과 : " + id_check_flag.value);
	console.log("비밀번호 유효성 통과 : " + pw_check_flag.value);
	console.log("이름 유효성 통과 : " + name_check_flag.value);
		
		
	} // window.onload 끝