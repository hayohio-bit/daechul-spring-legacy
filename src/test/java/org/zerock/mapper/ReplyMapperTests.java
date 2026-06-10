package org.zerock.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.Criteria;
import org.zerock.dto.ReplyDTO;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
class ReplyMapperTests {

	@Autowired
	private ReplyMapper replyMapper;
	
	// 실제 존재하는 게시물 번호 (테스트 환경에 맞게 조정 필요)
	private Integer[] bnoArr = { 1, 2, 3, 4, 5 };

	@Test
	@DisplayName("insert - 댓글 작성")
	void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i -> {
			ReplyDTO reply = new ReplyDTO();
			reply.setBno(bnoArr[i % 5]);
			reply.setReply("댓글 테스트 " + i);
			reply.setReplyer("replyer" + i);
			
			replyMapper.insert(reply);
		});
		log.info("댓글 10개 삽입 완료");
	}

	@Test
	@DisplayName("read - 특정 댓글 조회")
	void testRead() {
		Integer targetRno = 1; // 존재하는 번호로 설정
		ReplyDTO reply = replyMapper.read(targetRno);
		log.info("조회된 댓글: {}", reply);
	}

	@Test
	@DisplayName("delete - 댓글 삭제")
	void testDelete() {
		Integer targetRno = 2; // 존재하는 번호로 설정
		int count = replyMapper.delete(targetRno);
		log.info("DELETE COUNT: {}", count);
	}

	@Test
	@DisplayName("update - 댓글 수정")
	void testUpdate() {
		Integer targetRno = 3; // 존재하는 번호로 설정
		ReplyDTO reply = replyMapper.read(targetRno);
		
		if (reply == null) return;
		
		reply.setReply("수정된 댓글입니다.");
		int count = replyMapper.update(reply);
		log.info("UPDATE COUNT: {}", count);
	}

	@Test
	@DisplayName("getListWithPaging - 특정 게시물의 댓글 목록 페이징")
	void testList() {
		Criteria cri = new Criteria();
		List<ReplyDTO> replies = replyMapper.getListWithPaging(cri, bnoArr[0]);
		
		replies.forEach(reply -> log.info(reply));
	}
	
	@Test
	@DisplayName("getCountByBno - 특정 게시물의 댓글 개수")
	void testGetCountByBno() {
		int bno = bnoArr[0];
		int count = replyMapper.getCountByBno(bno);
		log.info("게시글 {}번의 댓글 수: {}", bno, count);
	}
}
