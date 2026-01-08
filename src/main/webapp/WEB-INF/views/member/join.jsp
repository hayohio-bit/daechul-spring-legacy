<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../includes/header.jsp" %>

        <div class="card" style="max-width: 500px; margin: 3rem auto;">
            <h2 style="text-align: center; margin-bottom: 2rem;">회원가입</h2>

            <c:if test="${not empty error}">
                <div style="background-color: #ffe0e0; color: #d00; padding: 0.75rem; border-radius: 4px; margin-bottom: 1rem; font-size: 0.875rem; border: 1px solid #ffcccc;">
                    ${error}
                </div>
            </c:if>

            <form role="form" action="/member/join" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                <div class="form-group">
                    <label>아이디</label>
                    <input type="text" name="id" placeholder="아이디를 입력하세요" required>
                </div>

                <div class="form-group">
                    <label>비밀번호</label>
                    <input type="password" name="password" placeholder="비밀번호를 입력하세요" required>
                </div>

                <div class="form-group">
                    <label>이름</label>
                    <input type="text" name="name" placeholder="이름을 입력하세요" required>
                </div>

                <div class="form-group">
                    <label>이메일</label>
                    <input type="email" name="email" placeholder="email@example.com" required>
                </div>

                <div class="form-group">
                    <label>전화번호</label>
                    <input type="text" name="phone" placeholder="010-0000-0000">
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">가입하기</button>
                <a href="/customLogin" class="btn btn-outline"
                    style="width: 100%; margin-top: 0.5rem; text-align: center; box-sizing: border-box;">이미 계정이 있으신가요?
                    로그인</a>
            </form>
        </div>

        <%@ include file="../includes/footer.jsp" %>