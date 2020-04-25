package cn.edu.ncu.RTKanaly.dao;

import cn.edu.ncu.RTKanaly.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserDao {
    void insertUser(User user);
    String findUserByName(String name);
}
