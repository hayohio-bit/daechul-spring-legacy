package org.zerock.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BoardListPaginDTO {
	
	private List<BoardDTO> dto;
	private int page;
	private int size;
	private int total;
	private int start;
	private int end;
	
	private boolean prev;
	private boolean next;
	
	private List<Integer> pageNums;
}
