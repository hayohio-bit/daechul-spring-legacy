<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container">
    <h1>게시글 상세</h1>
    <c:if test="${empty dto}">
        <p>게시글이 존재하지 않습니다.</p>
        <a href="/board/list">목록으로</a>
    </c:if>
    <c:if test="${not empty dto}">
        <div class="board-view">
            <table>
                <tr>
                    <th>번호</th>
                    <td>${dto.seq}</td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td>${dto.title}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${dto.writer}</td>
                </tr>
                <tr>
                    <th>조회수</th>
                    <td>${dto.hit}</td>
                </tr>
                <tr>
                    <th>작성일</th>
                    <td>${dto.regDate}</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td style="height: 300px; vertical-align: top;">${dto.content}</td>
                </tr>
            </table>
            <div class="btn-group">
                <a href="/board/list" class="btn btn-list">목록</a>
                <a href="/board/modify?seq=${dto.seq}" class="btn btn-modify">수정</a>
                <a href="/board/remove?seq=${dto.seq}" class="btn btn-remove">삭제</a>
            </div>
        </div>
    </c:if>
</div>