package org.zerock.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.zerock.dto.Criteria;
import org.zerock.dto.ReplyDTO;

public interface ReplyMapper {

    public int insert(ReplyDTO vo);

    public ReplyDTO read(int rno);

    public int delete(int rno);

    public int update(ReplyDTO reply);

    public List<ReplyDTO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") int bno);

    public int getCountByBno(int bno);
}
