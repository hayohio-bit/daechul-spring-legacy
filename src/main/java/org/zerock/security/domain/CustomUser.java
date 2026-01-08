package org.zerock.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.zerock.dto.MemberDTO;

public class CustomUser extends User {

    public MemberDTO getMember() {
        return member;
    }

    private static final long serialVersionUID = 1L;

    private MemberDTO member;

    public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
        super(username, password, authorities);
    }

    public CustomUser(MemberDTO vo) {
        super(vo.getId(), vo.getPassword(),
                vo.getAuthList() == null ? java.util.Collections.emptyList()
                        : vo.getAuthList().stream()
                                .map(auth -> new SimpleGrantedAuthority(auth.getRole())).collect(Collectors.toList()));

        this.member = vo;
    }
}
