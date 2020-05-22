package cn.edu.ncu.RTKanaly.service;

import cn.edu.ncu.RTKanaly.dao.UserDao;
import cn.edu.ncu.RTKanaly.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    private UserDao userDao;

    public int insertUser(String name, String password, String email) {
        return userDao.insertUser(name, password, email);
    }


    public User findUserByName(String name) {
        return userDao.findUserByName(name);
    }
}
