package org.zerock.controller;
// Updated to trigger re-deployment

import java.util.List;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.dto.Criteria;
import org.zerock.dto.ReplyDTO;
import org.zerock.service.ReplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@RequestMapping("/replies")
@RestController
@Log4j2
@RequiredArgsConstructor
public class ReplyController {

    private final ReplyService service;

    @PreAuthorize("isAuthenticated()")
    @PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
    public ResponseEntity<String> create(@RequestBody ReplyDTO vo) {
        log.info("ReplyDTO: " + vo);
        int insertCount = service.register(vo);
        return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/pages/{bno}/{page}", produces = { MediaType.APPLICATION_JSON_VALUE })
    public ResponseEntity<List<ReplyDTO>> getList(@PathVariable("page") int page, @PathVariable("bno") int bno) {
        log.info("getList GET... bno: " + bno + ", page: " + page);
        Criteria cri = new Criteria(page, 10);
        List<ReplyDTO> replies = service.getList(cri, bno);
        log.info("replies list size: " + (replies != null ? replies.size() : "null"));
        return new ResponseEntity<>(replies, HttpStatus.OK);
    }

    @GetMapping(value = "/{rno}", produces = { MediaType.APPLICATION_JSON_VALUE })
    public ResponseEntity<ReplyDTO> get(@PathVariable("rno") int rno) {
        log.info("get: " + rno);
        return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
    }

    @PreAuthorize("principal.username == #vo.replyer")
    @DeleteMapping(value = "/{rno}", produces = { MediaType.TEXT_PLAIN_VALUE })
    public ResponseEntity<String> remove(@RequestBody ReplyDTO vo, @PathVariable("rno") int rno) {
        log.info("remove: " + rno);
        return service.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PreAuthorize("principal.username == #vo.replyer")
    @RequestMapping(method = { RequestMethod.PUT,
            RequestMethod.PATCH }, value = "/{rno}", consumes = "application/json", produces = {
                    MediaType.TEXT_PLAIN_VALUE })
    public ResponseEntity<String> modify(@RequestBody ReplyDTO vo, @PathVariable("rno") int rno) {
        vo.setRno(rno);
        log.info("rno: " + rno);
        log.info("modify: " + vo);
        return service.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
