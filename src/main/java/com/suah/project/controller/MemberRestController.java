package com.suah.project.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.suah.project.service.MemberService;

@RestController
@RequestMapping("member")
public class MemberRestController {
	
	private static final Logger log 
	= LoggerFactory.getLogger(MemberRestController.class);
	
	@Autowired
	MemberService memberService;

/*	@GetMapping(value="id_check", produces="text/plain; charset=UTF-8")
	public String idCheck(@RequestParam("id") String id) {
		
		log.info("아이디 중복점검 Rest Service id : " + id );
		String result = "중복 점검 전송 성공";
		
		result = memberService.isMember(id) == true ? "가입된 아이디" : "가능한 아이디" ;
		return result;
	}*/
	
	@GetMapping(value="id_check", produces="text/plain; charset=UTF-8")
	public ResponseEntity<String> idCheck(@RequestParam("id") String id) {
		
		log.info("아이디 중복점검 Rest Service id : " + id );
		
		try {
			//String result = memberService.isMember(id) == true ? "가입된 아이디" : "가능한 아이디" ;
				
			// 회원이 존재하는 경우 (200)
			if (memberService.isMember(id) == true) {
				return new ResponseEntity<String>("회원 존재", HttpStatus.OK);
			
			// 회원이 없는 경우 (204)
			} else {
				/*return new ResponseEntity<String>("회원이 존재하지 않음", HttpStatus.NO_CONTENT); // 오류코드가 나옴 */
				return new ResponseEntity<String>("회원이 존재하지 않음", HttpStatus.OK); //(200) 구체적인 문구가 나옴
				 
			}

		
		} catch(Exception e) {
			log.error("idCheck Rest Service error : " + e.getMessage());
			return new ResponseEntity<String>(HttpStatus.EXPECTATION_FAILED);
		}
	}
	

	@GetMapping(value="email_check", produces="text/plain; charset=UTF-8")
	public ResponseEntity<String> emailCheck(@RequestParam("email") String email) {
		
		log.info("이메일 중복점검 Rest Service email : " + email );
		try {
			// 회원이 존재하는 경우 (200)
			if (memberService.isEmail(email) == true) {
				return new ResponseEntity<String>("이메일 존재", HttpStatus.OK);
			
			// 회원이 없는 경우 (204)
			} else {
				/*return new ResponseEntity<String>("회원이 존재하지 않음", HttpStatus.NO_CONTENT); // 오류코드가 나옴 */
				return new ResponseEntity<String>("이메일 존재하지 않음", HttpStatus.OK); //(200) 구체적인 문구가 나옴

			}

		} catch(Exception e) {
			log.error("emailCheck Rest Service error : " + e.getMessage());
			return new ResponseEntity<String>(HttpStatus.EXPECTATION_FAILED);
		}
	}
	
	@GetMapping(value="phone_check", produces="text/plain; charset=UTF-8")
	public ResponseEntity<String> phoneCheck(@RequestParam("phone") String phone) {
		
		log.info("연락처 중복점검 Rest Service phone : " + phone );
		try {
			// 회원이 존재하는 경우 (200)
			if (memberService.isPhone(phone) == true) {
				return new ResponseEntity<String>("연락처 존재", HttpStatus.OK);
			
			// 회원이 없는 경우 (204)
			} else {
				/*return new ResponseEntity<String>("회원이 존재하지 않음", HttpStatus.NO_CONTENT); // 오류코드가 나옴 */
				return new ResponseEntity<String>("연락처 존재하지 않음", HttpStatus.OK); //(200) 구체적인 문구가 나옴

			}

		} catch(Exception e) {
			log.error("phoneCheck Rest Service error : " + e.getMessage());
			return new ResponseEntity<String>(HttpStatus.EXPECTATION_FAILED);
		}
	}
	
}
