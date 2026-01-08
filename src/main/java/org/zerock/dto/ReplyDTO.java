package org.zerock.dto;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class ReplyDTO {
    @com.fasterxml.jackson.annotation.JsonProperty("rno")
    private int rno;
    @com.fasterxml.jackson.annotation.JsonProperty("bno")
    private int bno;
    @com.fasterxml.jackson.annotation.JsonProperty("replyText")
    private String replyText;
    @com.fasterxml.jackson.annotation.JsonProperty("replyer")
    private String replyer;
    @com.fasterxml.jackson.annotation.JsonFormat(shape = com.fasterxml.jackson.annotation.JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime replydate;
    @com.fasterxml.jackson.annotation.JsonFormat(shape = com.fasterxml.jackson.annotation.JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime updatedate;
    private boolean delflag;
}
