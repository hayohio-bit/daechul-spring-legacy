package org.zerock.service;

import org.zerock.dto.MemberDTO;

public interface MemberService {
    public boolean join(MemberDTO member);

    public int idCheck(String id);

    public MemberDTO get(String id);

    public boolean modify(MemberDTO member);
}
