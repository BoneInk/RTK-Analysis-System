package cn.edu.ncu.RTKanaly.service;

import cn.edu.ncu.RTKanaly.dao.ContentDao;
import cn.edu.ncu.RTKanaly.entity.Content;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ContentService {
    @Autowired
    private ContentDao contentDao;

    public List<Content>  findContentByName(String name){
        return contentDao.findContentByName(name);
    }

    public
}
