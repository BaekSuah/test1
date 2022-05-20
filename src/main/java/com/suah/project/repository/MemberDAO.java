package com.suah.project.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.suah.project.domain.MemberRoleVO;
import com.suah.project.domain.MemberVO;
import com.suah.project.domain.RoleVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class MemberDAO {

	@Autowired
	SqlSession sqlSession;
	
	public boolean isMember(String id) {
		log.info("MemberDAO.isMember");
		
		return (int)sqlSession.selectOne("com.suah.project.mapper.Member.isMember", id) == 1 ? true : false;
	}
		
	public boolean isEmail(String email) {
		log.info("MemberDAO.isEmail");
		
		return (int)sqlSession.selectOne("com.suah.project.mapper.Member.isEmail", email) == 1 ? true : false;
	}

	public boolean isPhone(String phone) {
		log.info("MemberDAO.isPhone");
		
		return (int)sqlSession.selectOne("com.suah.project.mapper.Member.isPhone", phone) == 1 ? true : false;
	}
	
	public void insertmember(MemberVO memberVO) {
		log.info("MemberVO.insertMember");
		
		sqlSession.insert("com.suah.project.mapper.Member.insertMember", memberVO);
	}
	
	public void insertRole(RoleVO roleVO) {
		log.info("MemberDAO.insertRole");
		sqlSession.insert("com.suah.project.mapper.Member.insertRole", roleVO);
	}
	
	public boolean checkIdPwd(String id, String pwd) {
		
		log.info("MemberDAO.checkIdPwd");
		MemberVO member = new MemberVO();
		member.setId(id);
		member.setPwd(pwd);
		
		return (int)sqlSession.selectOne("com.suah.project.mapper.Member.checkIdPwd", member)
				== 1? true : false;
	}
	
	public MemberVO getMember(String id) {
		
		log.info("MemberDAO.getMember");
		
		return sqlSession.selectOne("com.suah.project.mapper.Member.getMember", id);
	}
	
	public void updateMember(MemberVO memberVO) {
		
		log.info("MemberDAO.updateMember");

		sqlSession.update("com.suah.project.mapper.Member.updateMember", memberVO);
		
	}

	/**
	 * 
	 * @param id 회원 아이디
	 * @param email 회원 이메일
	 * @return 이메일 존재 여부
	 */
	
	public boolean isEmailOnUpdate(String id, String email) {
		
		log.info("MemberDAO.isEmailOnUpdate");
				
		HashMap<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("email", email);
		
		return (int)sqlSession.selectOne("com.suah.project.mapper.Member.isEmailOnUpdate", map) == 1 ? true : false;
	}
	
	/**
	 * 연락처 사용 가능 여부
	 * 
	 * @param id 회원 아이디
	 * @param phone 회원 연락처
	 * @return 연락처 존재 여부
	 */
	
	public boolean isPhoneOnUpdate(String id, String phone) {
		
		log.info("MemberDAO.isPhoneOnUpdate");
				
		HashMap<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("phone", phone);
		
		return (int)sqlSession.selectOne("com.suah.project.mapper.Member.isPhoneOnUpdate", map) == 1 ? true : false;
	}
	
	/**
	 * 회원 탈퇴 처리 : (useyn)=N
	 * 
	 * @param id 회원아이디
	 */
	public void inactiveMember(String id) {
		
		log.info("MemberDAO.inactiveMember");
		
		sqlSession.update("com.suah.project.mapper.Member.inactiveMember", id);
	}
	
	/**
	 * 회원 탈퇴 처리 : Role=guest

	 * @param id 회원 아이디
	 */
	public void inactiveRole(String id) {
		
		log.info("MemberDAO.inactiveRole");
		
		sqlSession.update("com.suah.project.mapper.Member.inactiveRole", id);
	}
	
	/**
	 * 회원 활성화 여부 점검
	 * 
	 * @param id 회원아이디
	 * @return 회원 활동 여부 (boolean)
	 */
	public boolean isActiveMember(String id) {
		
		log.info("MemberDAO.isActiveMember");
		
		return sqlSession.selectOne("com.suah.project.mapper.Member.isActiveMember", id).equals("y") ? true : false;
		
	}
	
	/**
	 * 탈퇴 회원 재사용 처리 : (useyn)= Y /N
	 * 
	 * @param id 회원아이디
	 * @param useyn 회원 활성화 여부
	 */
	public void activeMember(String id, String useyn) {
		
		log.info("MemberDAO.activeMember");
		Map<String, String> map = new HashMap<>();
		map.put("id",id);
		map.put("useyn", useyn);
		
		sqlSession.update("com.suah.project.mapper.Member.activeMember", map);
	}
	
	/**
	 * 회원 탈퇴 처리 : Role= admin / user / guest
	 * 
	 * @param id 회원 아이디
	 * @param role 회원 등급
	 */
	public void activeRole(String id, String role) {
		
		log.info("MemberDAO.activeRole");
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("role", role);
		
		sqlSession.update("com.suah.project.mapper.Member.activeRole", map);
	}
	
	/**
	 * 탈퇴한 회원 정보 유무 조회
	 * 
	 * @param memberVO 회원정보 객체 / id, pwd, email, phone
	 * 
	 * @return 회원정보 존재여부 true/false
	 */
	public boolean isInactiveMember(MemberVO memberVO) {
		
		log.info("MemberDAO.isInactiveMember");
		
		return (int)sqlSession.selectOne("com.suah.project.mapper.Member.isInactiveMember", memberVO)==1 ? true : false;
	}
	
	/**
	 * 개별 회원 롤 정보 조회
	 * 
	 * @param id 회원 아이디
	 * @return 회원 롤
	 */
	public String getRole(String id) {
		
		log.info("MemberDAO.getRole");
		
		return sqlSession.selectOne("com.suah.project.mapper.Member.getRole", id);
	}
	
	/**
	 * 전체 회원 조회 (페이지적용)
	 * 
	 * @param page 현재페이지
	 * @param limit 페이지당 자료(게시글) 수
	 * @return 인원 정보 리스트
	 */
	public List<MemberRoleVO> getMemberByPaging(int page, int limit) {
		
		log.info("MemberDAO.getMemberByPaging");
		
		Map<String, Integer> map = new HashMap<>();
		map.put("page", page);
		map.put("limit", limit);
		
		return sqlSession.selectList("com.suah.project.mapper.Member.getMemberByPaging", map);
		
	}
	
	/**
	 * 총 회원 수 조회
	 * 
	 * @return 총 회원 수
	 */
	public int getTotalMemberCount() {
		
		log.info("MemberDAO.getTotalMemberCount");
		
		return sqlSession.selectOne("com.suah.project.mapper.Member.getTotalMemberCount");
	}

}
