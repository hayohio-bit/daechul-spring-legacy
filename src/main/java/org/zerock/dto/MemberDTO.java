package org.zerock.dto;

import java.time.LocalDateTime;
import java.util.List;

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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public LocalDateTime getRegdate() {
        return regdate;
    }

    public void setRegdate(LocalDateTime regdate) {
        this.regdate = regdate;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public List<AuthDTO> getAuthList() {
        return authList;
    }

    public void setAuthList(List<AuthDTO> authList) {
        this.authList = authList;
    }
}
