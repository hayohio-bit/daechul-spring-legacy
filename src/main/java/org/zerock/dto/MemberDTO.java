package org.zerock.dto;

import java.time.LocalDateTime;
import java.util.List;
import lombok.Data;

@Data
public class MemberDTO {
    private String id;
    private String password;
    private String name;
    private String email;
    private String role;
    private String phone;
    private LocalDateTime regdate;
    private boolean enabled;

    private List<AuthDTO> authList;
}
