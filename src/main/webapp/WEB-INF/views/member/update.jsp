<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../includes/header.jsp" %>

        <div class="card" style="max-width: 500px; margin: 3rem auto;">
            <h2 style="text-align: center; margin-bottom: 2rem;">회원정보 수정</h2>

            <form role="form" action="/member/update" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                <div class="form-group">
                    <label>아이디</label>
                    <input type="text" name="id" value="${member.id}" readonly>
                </div>

                <div class="form-group">
                    <label>새 비밀번호 (변경할 경우만 입력)</label>
                    <input type="password" name="password" placeholder="새 비밀번호를 입력하세요">
                </div>

                <div class="form-group">
                    <label>이름</label>
                    <input type="text" name="name" value="${member.name}" required>
                </div>

                <div class="form-group">
                    <label>이메일</label>
                    <input type="email" name="email" value="${member.email}" required>
                </div>

                <div class="form-group">
                    <label>전화번호</label>
                    <input type="text" name="phone" value="${member.phone}">
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">수정하기</button>
                <a href="/" class="btn btn-outline"
                    style="width: 100%; margin-top: 0.5rem; text-align: center; box-sizing: border-box;">취소</a>
            </form>
        </div>

        <%@ include file="../includes/footer.jsp" %>