package org.zerock.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.zerock.dto.MemberDTO;
import org.zerock.mapper.MemberMapper;
import org.zerock.security.domain.CustomUser;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service("customUserDetailsService")
public class CustomUserDetailsService implements UserDetailsService {

    private static final Logger log = LoggerFactory.getLogger(CustomUserDetailsService.class);

    private MemberMapper memberMapper;

    @Autowired
    public void setMemberMapper(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }

    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {

        log.warn("Load User By UserName : " + userName);

        // userName means id
        MemberDTO vo = memberMapper.read(userName);

        log.warn("queried by member mapper: " + vo);

        if (vo == null) {
            throw new UsernameNotFoundException("User not found with username: " + userName);
        }

        return new CustomUser(vo);
    }

}
