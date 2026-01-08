<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="includes/header.jsp" %>

        <div class="card" style="max-width: 400px; margin: 5rem auto;">
            <h2 style="text-align: center; margin-bottom: 2rem;">로그인</h2>

            <c:if test="${not empty error}">
                <div
                    style="background: #fee2e2; color: #b91c1c; padding: 0.75rem; border-radius: 0.375rem; margin-bottom: 1rem; font-size: 0.875rem;">
                    ${error}
                </div>
            </c:if>

            <c:if test="${not empty logout}">
                <div
                    style="background: #ecfdf5; color: #047857; padding: 0.75rem; border-radius: 0.375rem; margin-bottom: 1rem; font-size: 0.875rem;">
                    성공적으로 로그아웃 되었습니다.
                </div>
            </c:if>

            <form method="post" action="/login">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                <div class="form-group">
                    <label>아이디</label>
                    <input type="text" name="username" placeholder="Username" required autofocus>
                </div>

                <div class="form-group">
                    <label>비밀번호</label>
                    <input type="password" name="password" placeholder="Password" required>
                </div>

                <div class="form-group" style="display: flex; align-items: center; gap: 0.5rem;">
                    <input type="checkbox" name="remember-me" id="remember">
                    <label for="remember" style="margin-bottom: 0; font-weight: normal;">로그인 유지</label>
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">로그인</button>
            </form>

            <div style="margin-top: 1.5rem; text-align: center; font-size: 0.875rem;">
                계정이 없으신가요? <a href="/member/join">회원가입</a>
            </div>
        </div>

        <%@ include file="includes/footer.jsp" %>