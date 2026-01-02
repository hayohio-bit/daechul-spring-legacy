package org.zerock.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * create table board ( seq int auto_increment primary key, writer varchar(50) not null, title
 * varchar(500) not null, content text not null, hit int default 0, regdate timestamp default now(),
 * updatedate timestamp default now() on update current_timestamp, delflag boolean default false,
 * foreign key (writer) references members(id) on delete cascade);
 */
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
