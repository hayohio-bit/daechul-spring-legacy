package org.zerock.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardDTO {

  private int seq;
  private String writer;
  private String title;
  private String content;
  private int hit;
  private LocalDateTime regdate;
  private LocalDateTime updatedate;
  private boolean delflag;

  private int replyCnt;

  public String getCreatedDate() {
    return regdate == null ? "" : regdate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
  }

}
