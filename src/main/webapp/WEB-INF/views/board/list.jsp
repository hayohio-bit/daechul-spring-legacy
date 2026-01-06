<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>
<div class="container my-4">
  <h2 class="mb-3">Board List</h2>

  <!-- 게시글 리스트 테이블 -->
  <table class="table table-hover table-striped" id="boardTable">
    <thead class="table-light">
      <tr>
        <th scope="col">Seq</th>
        <th scope="col">Title</th>
        <th scope="col">Writer</th>
        <th scope="col">RegDate</th>
        <th scope="col">Hit</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="board" items="${dto.dto}">
        <tr>
          <td><c:out value="${board.seq}" /></td>
          <td>
            <a href="<c:url value='/board/view?seq=${board.seq}' />">
              <c:out value="${board.title}" />
            </a>
          </td>
          <td><c:out value="${board.writer}" /></td>
          <td><c:out value="${board.createdDate}" /></td>
          <td><c:out value="${board.hit}" /></td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

  <!-- 페이지네이션 -->
  <nav aria-label="Board pagination">
    <ul class="pagination justify-content-center">

      <!-- 이전 블럭 -->
      <c:if test="${dto.prev}">
        <li class="page-item">
          <a class="page-link"
             href="?page=${dto.start - 1}&size=${dto.size}"
             aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
          </a>
        </li>
      </c:if>

      <!-- 페이지 번호들 -->
      <c:forEach var="p" items="${dto.pageNums}">
        <li class="page-item ${p == dto.page ? 'active' : ''}">
          <a class="page-link" href="?page=${p}&size=${dto.size}">
            ${p}
          </a>
        </li>
      </c:forEach>

      <!-- 다음 블럭 -->
      <c:if test="${dto.next}">
        <li class="page-item">
          <a class="page-link"
             href="?page=${dto.end + 1}&size=${dto.size}"
             aria-label="Next">
            <span aria-hidden="true">&raquo;</span>
          </a>
        </li>
      </c:if>

    </ul>
  </nav>
</div>
</body>
</html>
