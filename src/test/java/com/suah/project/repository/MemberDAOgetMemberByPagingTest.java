package com.suah.project.repository;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.suah.project.domain.MemberRoleVO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/resources/spring/db-context.xml"})
@Slf4j
public class MemberDAOgetMemberByPagingTest {

	@Autowired
	SqlSession sqlSession;
	
	@Transactional(readOnly=true)
	@Test
	public void test() {
		log.info("getMemberByPaging unit test");
		
		Map<String, String> map = new HashMap<>();
		map.put("page", "1");
		map.put("limit", "10");
		
		List<MemberRoleVO> members = sqlSession.selectList("com.suah.project.mapper.Member.getMemberByPaging", map);
		
		assertEquals(10, members.size());
		assertEquals(members.get(0).getId(), "dksalrud");
		
		log.info("MemberRoleVO : " + members.get(0));
	}

}