<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>DC-SPRING</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
                <style>
                    .logo {
                        position: relative;
                        display: inline-flex;
                        align-items: center;
                        /* overflow: hidden; */
                        /* Removing overflow:hidden to let head pop out if needed, but legs will stay masked by header boundary or explicit clipping */
                    }

                    .header-crab {
                        position: absolute;
                        width: 75px;
                        height: auto;
                        right: -80px;
                        bottom: -45px;
                        /* Clip legs by pushing below the header line */
                        animation: headerFloating 3s ease-in-out infinite;
                        pointer-events: none;
                        z-index: 1;
                    }

                    header {
                        overflow: hidden;
                        /* This will clip anything going below the header bottom border */
                    }

                    @keyframes headerFloating {

                        0%,
                        100% {
                            transform: translateY(0) rotate(0);
                        }

                        50% {
                            transform: translateY(-5px) rotate(5deg);
                        }
                    }
                </style>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;800&display=swap"
                    rel="stylesheet">
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            </head>

            <body>
                <header>
                    <nav>
                        <a href="${pageContext.request.contextPath}/" class="logo">
                            DC-SPRING
                            <img src="${pageContext.request.contextPath}/resources/img/lego-crab-2.png"
                                class="header-crab" alt="crab">
                        </a>
                        <div class="nav-links">
                            <a href="${pageContext.request.contextPath}/board/list">게시판</a>
                            <sec:authorize access="isAnonymous()">
                                <a href="${pageContext.request.contextPath}/customLogin">로그인</a>
                                <a href="${pageContext.request.contextPath}/member/join">회원가입</a>
                            </sec:authorize>
                            <sec:authorize access="isAuthenticated()">
                                <span>환영합니다, <b>
                                        <sec:authentication property="principal.member.name" />
                                    </b>님</span>
                                <a href="${pageContext.request.contextPath}/member/update">회원정보 수정</a>
                                <a href="javascript:document.logoutForm.submit()">로그아웃</a>
                                <form name="logoutForm" action="${pageContext.request.contextPath}/customLogout"
                                    method="post" style="display:none">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                </form>
                            </sec:authorize>
                        </div>
                    </nav>
                </header>
                <div class="container fade-in">