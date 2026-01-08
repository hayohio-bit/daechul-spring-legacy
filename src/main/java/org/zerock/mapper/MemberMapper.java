package org.zerock.mapper;

import org.zerock.dto.AuthDTO;
import org.zerock.dto.MemberDTO;

public interface MemberMapper {

    public MemberDTO read(String id);

    public int insert(MemberDTO member);

    public int insertAuth(AuthDTO auth);

    public int idCheck(String id);

    public int update(MemberDTO member);
}
