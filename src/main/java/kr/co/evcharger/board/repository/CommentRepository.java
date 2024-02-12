package kr.co.evcharger.board.repository;

import kr.co.evcharger.board.entity.BoardEntity;
import kr.co.evcharger.board.entity.CommentEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommentRepository extends JpaRepository<CommentEntity, Long> {
    List<CommentEntity> findAllByBoardEntityOrderByIdDesc(BoardEntity boardEntity);
}
