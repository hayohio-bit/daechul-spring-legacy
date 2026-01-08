<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="includes/header.jsp" %>

<div class="card" style="max-width: 500px; margin: 5rem auto; text-align: center;">
    <h1 style="color: var(--danger); font-size: 3rem; margin-bottom: 1rem;">403</h1>
    <h2>접근 권한이 없습니다.</h2>
    <p style="color: var(--text-muted); margin-bottom: 2rem;">요청하신 페이지에 접근할 수 있는 권한이 부족합니다.</p>
    
    <a href="/board/list" class="btn btn-primary">홈으로 돌아가기</a>
</div>

<%@ include file="includes/footer.jsp" %>