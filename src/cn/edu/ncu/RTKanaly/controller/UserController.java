package cn.edu.ncu.RTKanaly.controller;


import cn.edu.ncu.RTKanaly.entity.User;
import cn.edu.ncu.RTKanaly.service.UserService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import until.ProduceMD5;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping(value = "/findUser", method = RequestMethod.POST)
    public ModelAndView findUserByName(@RequestParam("name") String name, @RequestParam("password") String password, ModelAndView model, HttpSession session, HttpServletResponse response) throws IOException {
        User user = userService.findUserByName(name);
        password = ProduceMD5.getMD5(password);
        if (user.getPassword().equals(password)) {
            session.setAttribute("username", user.getName());
            model.setViewName("main");
        } else {
            response.setCharacterEncoding("utf-8");
            response.setContentType("text/html; charset=utf-8");
            PrintWriter p = response.getWriter();
            p.flush();
            p.println("<script>");
            p.println("alert('密码错误！');");
            p.println("</script>");
            model.setViewName("index");
        }
        return model;
    }

    @RequestMapping(value = "/addUser", method = RequestMethod.POST)
    public ModelAndView insertUser(@RequestParam("name") String name, @RequestParam("password") String password, @RequestParam("email") String email, ModelAndView model, HttpSession session, HttpServletResponse response) throws IOException {
        password = ProduceMD5.getMD5(password);
        if (userService.insertUser(name, password, email) > 0) {
            session.setAttribute("username", userService.findUserByName(name).getName());
            response.setCharacterEncoding("utf-8");
            response.setContentType("text/html; charset=utf-8");
            PrintWriter p = response.getWriter();
            p.flush();
            p.println("<script>");
            p.println("alert('注册成功！');");
            p.println("</script>");
            model.setViewName("main");
        } else {
            response.setCharacterEncoding("utf-8");
            response.setContentType("text/html; charset=utf-8");
            PrintWriter p = response.getWriter();
            p.flush();
            p.println("<script>");
            p.println("alert('注册失败！');");
            p.println("</script>");
            model.setViewName("index");
        }
        return model;

    }

    @RequestMapping(value = "/isValidName", method = RequestMethod.POST)
    public @ResponseBody
    JSON isValidName(@Param("name") String name) {
        JSONObject json = new JSONObject();
        if ((User) userService.findUserByName(name) != null) {
            json.put("res", "no");
        } else json.put("res", "ok");
        return json;

    }

}
