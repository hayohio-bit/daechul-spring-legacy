package org.zerock.mapper;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.AuthDTO;
import org.zerock.dto.MemberDTO;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@ContextConfiguration({
  "file:src/main/webapp/WEB-INF/spring/root-context.xml",
  "file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j2
class MemberMapperTests {

	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private PasswordEncoder pwencoder;

	@Test
	@DisplayName("insert - 회원 가입")
	void testInsert() {
		MemberDTO member = new MemberDTO();
		member.setUserid("testuser1");
		member.setUserpw(pwencoder.encode("pw00"));
		member.setUserName("테스트사용자1");
		
		int result = memberMapper.insert(member);
		log.info("회원 가입 결과: {}", result);
	}

	@Test
	@DisplayName("insertAuth - 권한 부여")
	void testInsertAuth() {
		AuthDTO auth = new AuthDTO();
		auth.setUserid("testuser1");
		auth.setAuth("ROLE_USER");
		
		int result = memberMapper.insertAuth(auth);
		log.info("권한 추가 결과: {}", result);
	}
	
	@Test
	@DisplayName("read - 회원 정보 및 권한 조회")
	void testRead() {
		MemberDTO member = memberMapper.read("testuser1");
		log.info("조회된 회원 정보: {}", member);
		if (member != null) {
			member.getAuthList().forEach(authVO -> log.info("권한: {}", authVO));
		}
	}
	
	@Test
	@DisplayName("idCheck - 아이디 중복 확인")
	void testIdCheck() {
		int count = memberMapper.idCheck("testuser1");
		log.info("idCheck count: {}", count);
	}
	
	@Test
	@DisplayName("update - 회원 정보 업데이트")
	void testUpdate() {
		MemberDTO member = new MemberDTO();
		member.setUserid("testuser1");
		member.setUserName("수정된이름");
		
		int result = memberMapper.update(member);
		log.info("update result: {}", result);
	}
}
