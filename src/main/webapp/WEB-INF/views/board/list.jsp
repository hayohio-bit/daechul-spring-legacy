<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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