/**
 * 회원정보 수정
 */

window.onload = function() {
	
	// 부가 항목 : 상세주소
	var update_zipNum = document.querySelector("form#update input#zipNum");
	var update_address1 = document.querySelector("form#update input#address1");
	var update_address2 = document.querySelector("form#update input#address2");
	
	// 주소 초기화 시작
	
	address_init_btn.onclick = function() {
		
		console.log("주소 초기화");
		
		update_zipNum.value = "";
		update_address1.value = "";
		update_address2.value = "";
		
	}
	
	// 주소 초기화 끝
};