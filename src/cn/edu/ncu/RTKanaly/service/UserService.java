package cn.edu.ncu.RTKanaly.service;

import cn.edu.ncu.RTKanaly.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserDao userDao;

    public String findUserByName(String name){
        return userDao.findUserByName(name);
    }
}
