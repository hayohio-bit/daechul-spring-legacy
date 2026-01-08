package org.zerock.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.dto.Criteria;
import org.zerock.dto.ReplyDTO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService {

    private final ReplyMapper mapper;
    private final BoardMapper boardMapper;

    @Transactional
    @Override
    public int register(ReplyDTO vo) {
        log.info("register......" + vo);
        boardMapper.updateReplyCnt(vo.getBno(), 1);
        return mapper.insert(vo);
    }

    @Override
    public ReplyDTO get(int rno) {
        log.info("get......" + rno);
        return mapper.read(rno);
    }

    @Override
    public int modify(ReplyDTO vo) {
        log.info("modify......" + vo);
        return mapper.update(vo);
    }

    @Transactional
    @Override
    public int remove(int rno) {
        log.info("remove......" + rno);
        ReplyDTO vo = mapper.read(rno);
        boardMapper.updateReplyCnt(vo.getBno(), -1);
        return mapper.delete(rno);
    }

    @Override
    public List<ReplyDTO> getList(Criteria cri, int bno) {
        log.info("get Reply List of a Board " + bno);
        return mapper.getListWithPaging(cri, bno);
    }
}
