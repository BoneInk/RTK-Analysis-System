package cn.edu.ncu.RTKanaly.dao;

import cn.edu.ncu.RTKanaly.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserDao {
    int insertUser(@Param("name") String name, @Param("password") String password, @Param("email") String email);

    User findUserByName(@Param("name") String name);
}
