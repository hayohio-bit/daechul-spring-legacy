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
  private LocalDateTime regDate;
  private LocalDateTime updateDate;
  private boolean delflag;

  public String getCreatedDate() {
    return regDate == null ? "" : regDate.format(DateTimeFormatter.ISO_DATE);
  }

}
