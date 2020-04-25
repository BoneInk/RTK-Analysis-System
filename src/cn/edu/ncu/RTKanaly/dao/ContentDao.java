package cn.edu.ncu.RTKanaly.dao;

import cn.edu.ncu.RTKanaly.entity.Content;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContentDao {
    void insertContent(Content content);
    List<Content>  findContentByName(String name);
}
