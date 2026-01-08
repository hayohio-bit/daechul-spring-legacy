package org.zerock.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.dto.AuthDTO;
import org.zerock.dto.MemberDTO;
import org.zerock.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

    private final MemberMapper mapper;
    private final PasswordEncoder passwordEncoder;

    @Transactional
    @Override
    public boolean join(MemberDTO member) {
        log.info("join......" + member);

        if (mapper.idCheck(member.getId()) > 0) {
            return false;
        }

        member.setPassword(passwordEncoder.encode(member.getPassword()));
        mapper.insert(member);

        AuthDTO auth = new AuthDTO();
        auth.setId(member.getId());
        auth.setRole("ROLE_MEMBER");
        mapper.insertAuth(auth);

        return true;
    }

    @Override
    public int idCheck(String id) {
        log.info("idCheck......" + id);
        return mapper.idCheck(id);
    }

    @Override
    public MemberDTO get(String id) {
        log.info("get......" + id);
        return mapper.read(id);
    }

    @Transactional
    @Override
    public boolean modify(MemberDTO member) {
        log.info("modify......" + member);

        if (member.getPassword() != null && !member.getPassword().isEmpty()) {
            member.setPassword(passwordEncoder.encode(member.getPassword()));
        }

        return mapper.update(member) == 1;
    }
}
