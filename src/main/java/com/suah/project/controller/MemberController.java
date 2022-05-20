package com.suah.project.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.suah.project.domain.MemberDTO;
import com.suah.project.domain.MemberVO;
import com.suah.project.domain.RoleVO;
import com.suah.project.service.MemberService;

import lombok.extern.log4j.Log4j2;


@Controller
@Log4j2
@RequestMapping("member")
public class MemberController {

	@Autowired
	MemberService memberService;
	
	@RequestMapping("contract")
	public String contract() {
		
		log.info("회원 가입 약관 동의 : contract");
		
		return "/member/contract";
	}
	@RequestMapping("join_form")
	public String joinForm(@RequestParam(value="contractOK", defaultValue="") String contractOK) {
		
		log.info("회원 가입 폼");
		String page ="";
		
		if (contractOK.equals("true")) {
			log.info("약관 동의  : " + contractOK);
			page="/member/join";
		} else {
			log.info("약관 미동의 : " + contractOK);
			page="redirect:/member/contract";
		}
		
		return page;
	}
	
	@PostMapping("join_proc")
	public String JoinProc(MemberVO memberVO) {
		
		log.info("회원 가입 처리" + memberVO);
		String page = "";
		
		memberVO.setUseyn("y"); // 회원(활동 여부 체크)
		
		RoleVO roleVO = new RoleVO();
		roleVO.setId(memberVO.getId());
		roleVO.setRole("user"); // 기본  role => 일반 회원
		
		// 회원 가입 성공
		if (memberService.insertMember(memberVO, roleVO) == true) {
			
			log.info("회원 가입 성공");
			page = "redirect:/login/login_form"; // 로그인 화면
			
		} else {
			
			log.info("회원 가입 실패");
			page = "redirect:/member/join_form?contractOK=true"; // 회원가입 화면
		}
		
		return page;
	}
	
	@GetMapping("member_info")
	public String memberInfo() {
		
		log.info("개별 회원 정보 조회/ 수정/ (탈퇴) 페이지");
		String page = "/member/member_info";
		
		return page;
	}
	
	@GetMapping("member_update")
	public String memberUpdate() {
		
		log.info("개별 회원 정보 수정");
		
		return "/member/member_update";
	}
	
	@PostMapping("update_proc")
	public String updateProc(@Valid MemberDTO memberDTO, 
							 BindingResult result,
							 RedirectAttributes ra,
							 HttpSession session ) {
		
		log.info("개별 회원 정보 수정 처리");
		String page = "";
		
		// 신규 비밀번호 간의 동등여부 점검
		log.info("신규 비밀번호 간의 동등 여부 점검 : " + memberDTO.getPwd().trim().contentEquals(memberDTO.getPwdCheck().trim()));
					
		String pwd = memberDTO.getPwd().trim();
		String pwdCheck = memberDTO.getPwdCheck().trim();
		
		// 공백이 아닌 폼점검 통과 => 신규 비밀번호 저장
		if (!pwd.equals(pwdCheck)) {
			
			log.info("비밀번호 불일치");
			ra.addFlashAttribute("pwd_err_msg", "비밀번호가 일치하지 않습니다");
		}
					
		// 주소 폼점검
		// 세가지 필드 모두 공백이거나 모두 입력 => 유효
		if (!memberDTO.getZipNum().equals("") && 
				!memberDTO.getAddress1().equals("") && 
				memberDTO.getAddress2().trim().equals("")) {
 						
			ra.addFlashAttribute("address_err_msg", "상세 주소를 입력하십시오");					
		} 
		
		if (memberDTO.getZipNum().equals("") && 
			memberDTO.getAddress1().equals("") && 
			!memberDTO.getAddress2().trim().equals("")) {
	
			ra.addFlashAttribute("address_err_msg", "주소 찾기 버튼으로 주소를 입력하십시오");	
			
		}
										
		
		///////////////////////////////////////////////////////////////////////////////////////////////
		if (result.hasErrors()) {
			log.error("폼점검 에러");
			result.getAllErrors().forEach(x->{ log.error(x); });
			
			ra.addFlashAttribute("org.springframework.validation.BindingResult.memberDTO", result);
			
			page = "redirect:/member/member_update";
			
		} else {
			log.info("폼점검 완료");
			log.info("MemberDTO : {}", memberDTO);
			
			// 이메일 중복 점검
			boolean emailCheck = memberService.isEmailOnUpdate(memberDTO.getId(), memberDTO.getEmail());
			boolean phoneCheck = memberService.isPhoneOnUpdate(memberDTO.getId(), memberDTO.getPhone()); 
					
			if (emailCheck == false) {
			
				log.info("이메일 중복");
				ra.addFlashAttribute("email_err_msg", "해당 이메일은 이미 사용하고 있습니다");
			}
			
			if (phoneCheck == false) {
					
				log.info("연락처 중복");
				ra.addFlashAttribute("phone_err_msg", "해당 연락처는 이미 사용하고 있습니다");		
			}
				
			// 수정 회원 정보 점검 완료
			if (emailCheck == true && phoneCheck == true) {
						
			
			// DTO => VO
			//MemberVO memberVO = new MemberVO(memberDTO);
			//log.info("memberVO : {}", memberVO);
			
			MemberVO memberVO = (MemberVO)session.getAttribute("LOGIN_USER");

			// 비밀번호 변경시 수정 반영
			if (!pwd.equals("")) {
				memberVO.setPwd(pwd);
			}
			
			// 이메일 변경시 수정 반영
			if (!memberVO.getEmail().equals(memberDTO.getEmail())) {
				memberVO.setEmail(memberDTO.getEmail());
			}
			
			// 연락처 변경시 수정 반영
			if (!memberVO.getPhone().equals(memberDTO.getPhone())) {
				memberVO.setPhone(memberDTO.getPhone());
			}
				
			// 주소 변경시 수정 반영
			memberVO.setZipNum(memberDTO.getZipNum());
			memberVO.setAddress1(memberDTO.getAddress1());
			memberVO.setAddress2(memberDTO.getAddress2());
			
			log.info("업데이트(수정) memberVO : {}", memberVO);
			
			String updateMsg = "";
			
			if (memberService.updateMember(memberVO) == true) {
				
				log.info("회원 정보 수정 성공");
				updateMsg = "회원 정보 수정에 성공하였습니다";
				
			} else {
				
				log.info("회원 정보 수정 실패");
				updateMsg = "회원 정보 수정에 실패하였습니다";
			}
			
			ra.addFlashAttribute("update_success_msg", updateMsg);
			
			// 기존 정보(session) 변경
			session.setAttribute("LOGIN_USER", memberVO);
				
		}// 수정 회원 정보 점검 완료
			
			page = "redirect:/member/member_update";
		}
		
		return page;
	}

	
	@RequestMapping("member_inactive")
	public String memberInactiveProc(HttpSession session, Model model) {
		
		// 회원 탈퇴 처리시 회원 정보 삭제 X / 회원정보 비활성화 (useyn)=N
		log.info("회원 탈퇴 처리");
		
		String errMsg = ""; // 에러 메세지
		String path = "";
		
		String id = ((MemberVO)session.getAttribute("LOGIN_USER")).getId();
		
		if (memberService.inactiveMemberRole(id) == true) {
			// 세션 종료(로그아웃처리)
			session.invalidate();
			errMsg = "회원 탈퇴 처리가 완료되었습니다";
 			path = "/"; // 홈페이지로 이동
 			
		} else {
			
			// 회원 탈퇴 실패
			errMsg = "회원 탈퇴 처리에 실패했습니다";
			path = "/member/member_info";
		}
		
		model.addAttribute("err_msg", errMsg);
		model.addAttribute("path", path);
		
		return "/error/error";
	}
	
	@GetMapping("check_inactive_member")
	public String checkInactiveMember() {
		
		log.info("탈퇴한 회원 여부 점검");
		
		return "/member/check_inactive_member";
		
	}
	
	@PostMapping("check_inactive_member_proc")
	public String checkInActiveMemberProc(@ModelAttribute MemberVO memberVO, Model model) {
		
		log.info("탈퇴한 회원 여부 점검 처리  : {}", memberVO);
		
		String errMsg = "";
		String movePath="";
		
		// 탈퇴한 회원 기존정보 존재 여부
		if (memberService.isInactiveMember(memberVO)==true) {
			
			
			// 기존 회원정보 재사용 여부
			
			// 기존 회원정보 재사용 설정
			if (memberService.activeMemberRole(memberVO.getId(), "user", "y")== true) {
				
				log.info("기존(탈퇴전) 회원정보 갱신 성공");
				errMsg = "기존(탈퇴전) 회원정보를 갱신했습니다 \\n로그인 페이지로 이동하겠습니다";
				movePath = "/login/login_form";
				
			} else {
				
				log.info("기존(탈퇴전) 회원정보 갱신 실패");
				
				errMsg = "기존(탈퇴전) 회원정보 갱신에 실패하였습니다";
				movePath = "/member/join_form?contractOK=true";
				
			}
			
		// 기존 정보가 없음 (신규회원)
		} else {
			
			log.info("기존(탈퇴전) 회원정보 없음");
			
			errMsg = "기존(탈퇴전) 회원정보가 존재하지 않습니다 //n신규 회원가입 페이지로 이동하겠습니다";
			movePath = "/member/join_form?contractOK=true";

		}
		
		model.addAttribute("err_msg", errMsg);
		model.addAttribute("move_path", movePath);
		
		return "/error/error";
	}
}

