package org.zerock.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.Criteria;
import org.zerock.mapper.BoardMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {

	private final BoardMapper mapper;

	@Override
	public void register(BoardDTO board) {
		log.info("register......" + board);
		mapper.insertSelectKey(board);
	}

	@Transactional
	@Override
	public BoardDTO get(int bno) {
		log.info("get......" + bno);
		mapper.updateHit(bno);
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardDTO board) {
		log.info("modify......" + board);
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(int bno) {
		log.info("remove......" + bno);
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<BoardDTO> getList(Criteria cri) {
		log.info("get List with criteria: " + cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
}
