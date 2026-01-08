package org.zerock.service;

import java.util.List;
import org.zerock.dto.Criteria;
import org.zerock.dto.ReplyDTO;

public interface ReplyService {

    public int register(ReplyDTO vo);

    public ReplyDTO get(int rno);

    public int modify(ReplyDTO vo);

    public int remove(int rno);

    public List<ReplyDTO> getList(Criteria cri, int bno);
}
