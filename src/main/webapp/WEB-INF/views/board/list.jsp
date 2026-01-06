<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
.content-main {
  padding: 16px;
}

.board-list-view {
  width: 100%;
  border-collapse: collapse;
  font-size: 14px;
}

.board-list-view thead {
  background-color: #f5f5f5;
}

.board-list-view th,
.board-list-view td {
  padding: 8px 12px;
  border-bottom: 1px solid #e0e0e0;
  text-align: left;
}

.board-list-view tbody tr:nth-child(even) {
  background-color: #fafafa;
}

.board-list-view tbody tr:hover {
  background-color: #eef5ff;
}
</style>

<div class="content-main">
<table class="board-list-view" id="dataTable">
	<thead>
		<tr>
			<th>seq</th>
			<th>title</th>
			<th>writer</th>
			<th>regDate</th>
			<th>hit</th>
		</tr>
	</thead>
	<tbody class="tbody">
		<c:forEach var="board" items="${boardList}">
			<tr>
				<td><c:out value="${board.seq}" /></td>
				<td><c:out value="${board.title }" /></td>
				<td><c:out value="${board.writer }" /></td>
				<td><c:out value="${board.regDate }" /></td>
				<td><c:out value="${board.hit }" /></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</div>