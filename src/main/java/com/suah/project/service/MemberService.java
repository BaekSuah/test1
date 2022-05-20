package com.suah.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionCallback;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

import com.suah.project.domain.MemberRoleVO;
import com.suah.project.domain.MemberVO;
import com.suah.project.domain.RoleVO;
import com.suah.project.repository.MemberDAO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberService {

	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	TransactionTemplate txTemplate;
	
	// 아이디 중복 점검
	@Transactional(readOnly=true)
	public boolean isMember(String id) {
		
		log.info("MemberService.isMember");
				
		return txTemplate.execute(status -> {return memberDAO.isMember(id); });
		

/*		return txTemplate.execute(new TransactionCallback<Boolean>() {
					
			@Override
			public Object doInTransaction(TransactionStatus status) {
				return memberDAO.isMember(id);
			}
		});*/
		
	}
	
	// 이메일 중복 점검
	@Transactional(readOnly=true)
	public boolean isEmail(String email) {
		
		log.info("MemberService.isEmail");
				
		return txTemplate.execute(status -> {return memberDAO.isEmail(email); });
	}
	
	// 연락처 중복 점검
	@Transactional(readOnly=true)
	public boolean isPhone(String phone) {
		
		log.info("MemberService.isPhone");
				
		return txTemplate.execute(status -> {return memberDAO.isPhone(phone); });	
	}
	
//	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
/*	@Transactional(propagation=Propagation.REQUIRED)
	public void insertMember(final MemberVO memberVO) {
		
		log.info("MemberService.insertMember");
		
		txTemplate.execute(new TransactionCallbackWithoutResult() {
			
			@Override
			protected void doInTransactionWithoutResult(TransactionStatus status) {
				
				try {
					memberDAO.insertmember(memberVO);
					log.info("회원 정보 저장 성공");
				} catch(Exception e) {
					status.setRollbackOnly();
					log.error("Memberservice.insertMember error : " + e.getMessage());
				}
			}
		});
	}*/
	
/*	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertMember(final MemberVO memberVO) {
		
		log.info("MemberService.insertMember");
		
		txTemplate.execute(status -> { memberDAO.insertmember(memberVO); return null; });
	}*/
	
	/*@Transactional(propagation=Propagation.REQUIRED)
	public void insertMember(final MemberVO memberVO) {
		
		log.info("MemberService.insertMember");
		
		txTemplate.execute(new TransactionCallback<Boolean>() {
					
			@Override
			public Boolean doInTransaction(TransactionStatus status) {
				boolean flag = false;				
				
				try {
					memberDAO.insertmember(memberVO);
					log.info("회원 정보 저장 성공");
					flag = true;
				} catch(Exception e) {
					status.setRollbackOnly();
					flag = false;
					log.error("Memberservice.insertMember error : " + e.getMessage());
				}
				
				return flag;
			}			
		});
	}*/
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public boolean insertMember(final MemberVO memberVO, final RoleVO roleVO) {
		
		log.info("MemberService.insertMember");
		
		return txTemplate.execute(status -> {
				boolean flag = false;				
				
				try {
					memberDAO.insertmember(memberVO);
					log.info("회원 정보 저장 성공");
					
					memberDAO.insertRole(roleVO);
					log.info("회원 정보 롤 저장 성공");
					
					flag = true;
				} catch(Exception e) {
					status.setRollbackOnly();
					flag = false;
					log.error("Memberservice.insertMember error : " + e.getMessage());
				}
				
				return flag;
		});
	}
	
	@Transactional(readOnly=true)
	public String checkLogin(String id, String pwd) {
		
		log.info("MemberService.checkLogin");
		String msg = "";
		
		//case-1 아이디 없음		
		//case-2 아이디 일치 / 비밀번호 불일치
		//case-3 아이디 비밀번호 일치
		
		if (memberDAO.isMember(id) == true) { 
			
			if(memberDAO.checkIdPwd(id, pwd)==true) { // case-3				
				msg = "회원정보 일치합니다.";
				
			} else { // case-2
				msg = "비밀번호가 일치하지 않습니다.";
			}
			
		} else { // 회원 아이디 없음 case-1
			
			msg = "회원 아이디가 존재하지 않습니다.";
			
		}
		
		
		return msg;
	}
	
	@Transactional(readOnly=true)
	public MemberVO getMember(String id) {
		
		log.info("MemberService.getMember");
				
		return txTemplate.execute(status -> {return memberDAO.getMember(id); });	
	}
	
	@Transactional(propagation=Propagation.REQUIRED)
	public boolean updateMember(final MemberVO memberVO) {
		
		log.info("MemberService.updateMember");
		
		return txTemplate.execute(status -> {
				boolean flag = false;				
				
				try {
					memberDAO.updateMember(memberVO);
					log.info("회원 정보 수정 성공");

					flag = true;
				} catch(Exception e) {
					status.setRollbackOnly();
					flag = false;
					log.error("Memberservice.updateMember error : " + e.getMessage());
				}
				
				return flag;
		});
	}
	
	/**
	 * 이메일 사용 가능 여부
	 * 
	 * @param id 회원 아이디
	 * @param email 회원 이메일
	 * @return 이메일 사용 가능 여부
	 */
	@Transactional(readOnly=true)
	public boolean isEmailOnUpdate(String id, String email) {
		
		log.info("MemberService.isEmailOnUpdate");
				
		return txTemplate.execute(status -> {return !memberDAO.isEmailOnUpdate(id, email); });
	}
	
	/**
	 * 연락처 사용 가능 여부
	 * 
	 * @param id 회원 아이디
	 * @param phone 회원 연락처
	 * @return 연락처 사용 가능 여부
	 */
	@Transactional(readOnly=true)
	public boolean isPhoneOnUpdate(String id, String phone) {
		
		log.info("MemberService.isPhoneOnUpdate");
				
		return txTemplate.execute(status -> {return !memberDAO.isPhoneOnUpdate(id, phone); });
	}
	
	/**
	 * 회원 탈퇴 
	 * 처리
	 * @param id 회원 아이디
	 * @return 회원 탈퇴 처리 성공 여부
	 */
	@Transactional(propagation=Propagation.REQUIRED)
	public boolean inactiveMemberRole(final String id) {
		
		log.info("MemberService.inactiveMemberRole");
		
		return txTemplate.execute(status -> {
				boolean flag = false;				
				
				try {
					memberDAO.inactiveMember(id);
					log.info("회원 탈퇴(useyn 비활성화) 처리 성공");
					
					memberDAO.inactiveRole(id);
					log.info("회원 탈퇴(role 비활성화) 처리 성공");
					
					flag = true;
				} catch(Exception e) {
					status.setRollbackOnly();
					flag = false;
					log.error("Memberservice.inactiveMemberRole error : " + e.getMessage());
				}
				
				return flag;
		});
	}
	
	@Transactional(readOnly=true)
	public boolean isActiveMember(String id) {
		
		log.info("MemberService.isActiveMember");
				
		return txTemplate.execute(status -> {return memberDAO.isActiveMember(id); });
	}
	
	/**
	 * 회원 활성화 여부 갱신 (useyn + role)
	 * 
	 * @param id 회원 아이디
	 * @param useyn 회원 활성화 여부
	 * @param role 회원 등급
	 * 
	 * @return 회원 활동 여부
	 */
	@Transactional(propagation=Propagation.REQUIRED)
	public boolean activeMemberRole(final String id, final String role, final String useyn) {
		
		log.info("MemberService.activeMemberRole");
		
		return txTemplate.execute(status -> {
				boolean flag = false;				
				
				try {
					memberDAO.activeMember(id, useyn);
					log.info("회원 상태 변경 처리 성공");
					
					memberDAO.activeRole(id, role);
					log.info("회원 등급 변경 처리 성공");
					
					flag = true;
				} catch(Exception e) {
					status.setRollbackOnly();
					flag = false;
					log.error("Memberservice.activeMemberRole error : " + e.getMessage());
				}
				
				return flag;
		});
	}
	
	@Transactional(readOnly=true)
	public boolean isInactiveMember(final MemberVO memberVO) {
		
		log.info("MemberService.isInactiveMember");
		
		return txTemplate.execute(status -> {return memberDAO.isInactiveMember(memberVO); });
	}
	
	
	@Transactional(readOnly=true)
	public String getRole(String id) {
		
		log.info("MemberService.getRole");
				
		return txTemplate.execute(status -> {return memberDAO.getRole(id); });
	}
	
	/**
	 * 전체 회원 조회 (페이지적용)
	 * 
	 * @param page 현재페이지
	 * @param limit 페이지당 자료(게시글) 수
	 * @return 인원 정보 리스트
	 */
	
	@Transactional(readOnly=true)
	public List<MemberRoleVO> getMemberByPaging(final int page, final int limit) {
		
		log.info("MemberService.getMemberByPaging");
				
		return txTemplate.execute(status -> {return memberDAO.getMemberByPaging(page, limit); });
	
	}
	
	/**
	 * 총 회원 수 조회
	 * 
	 * @return 총 회원 수
	 */
	
	@Transactional(readOnly=true)
	public int getTotalMemberCount() {
		
		log.info("MemberService.getTotalMemberCount");

		return txTemplate.execute(status -> {return memberDAO.getTotalMemberCount(); });
	}
}
