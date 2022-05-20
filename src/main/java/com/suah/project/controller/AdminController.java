package com.suah.project.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.suah.project.domain.MemberRoleVO;
import com.suah.project.domain.MemberVO;
import com.suah.project.domain.PageVO;
import com.suah.project.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("admin")
public class AdminController {
	
	@Inject
	MemberService memberService;

	@RequestMapping("home")
	public String home() {
		
		log.info("admin home");
		
		return "redirect:/admin/member/memberList";
	}
	
	@RequestMapping("member/memberList")
	public String memberList(@RequestParam(value="page", defaultValue="1") int page, 
							 @RequestParam(value="limit", defaultValue="10") int limit,
							 Model model) {
		
		log.info("admin memebrList");
		
		List<MemberRoleVO> members = memberService.getMemberByPaging(page, limit);
		
		// 총 회원 수 
		int totalMemberCount = memberService.getTotalMemberCount();
		
		//마지막 페이지
		int startPage = 1;
		int maxPage = (int)(totalMemberCount / limit + 0.95) + 1; // 마지막 페이지 공식
		
		PageVO pageVO = new PageVO();
		pageVO.setCurrPage(page);
		pageVO.setStartPage(startPage);
		pageVO.setEndPage(maxPage);
		pageVO.setLimit(limit);
		pageVO.setMaxPage(maxPage);

		
		model.addAttribute("members", members);
		model.addAttribute("pageVO", pageVO);
		
		return "/admin/member/member_list";
		
	}
	
	
	
}
