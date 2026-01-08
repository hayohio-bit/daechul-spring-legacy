<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>DC-SPRING</title>
                <link rel="stylesheet" href="/resources/css/main.css">
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;800&display=swap"
                    rel="stylesheet">
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            </head>

            <body>
                <header>
                    <nav>
                        <a href="/" class="logo">DC-SPRING</a>
                        <div class="nav-links">
                            <a href="/board/list">게시판</a>
                            <sec:authorize access="isAnonymous()">
                                <a href="/customLogin">로그인</a>
                                <a href="/member/join">회원가입</a>
                            </sec:authorize>
                            <sec:authorize access="isAuthenticated()">
                                <span>환영합니다, <b>
                                        <sec:authentication property="principal.member.name" />
                                    </b>님</span>
                                <a href="/member/update">회원정보 수정</a>
                                <a href="javascript:document.logoutForm.submit()">로그아웃</a>
                                <form name="logoutForm" action="/customLogout" method="post" style="display:none">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                </form>
                            </sec:authorize>
                        </div>
                    </nav>
                </header>
                <div class="container fade-in">