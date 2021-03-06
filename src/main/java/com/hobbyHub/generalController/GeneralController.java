package com.hobbyHub.generalController;

import com.hobbyHub.user.User;
import com.hobbyHub.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class GeneralController {

    @Autowired
    UserService userService;

    @RequestMapping("/main")
    public String main() { //for testing js and cs with jsp and html files
        return "about-hobbyhub";
    }

    @RequestMapping("/browse")
    public String browse() {
        return "hobbies";
    }

    @RequestMapping(value = {"/", "", "/about"})
    public String about() {
        return "about-hobbyhub";
    }

    @RequestMapping("/following")
    public String followers(HttpServletRequest request){
        HttpSession session=request.getSession();

        if(session.getAttribute("user_object")!=null){
            User user=(User)(session.getAttribute("user_object"));
            List<User> following=user.getFollowings();
            session.setAttribute("following",following);
        }
        return "following";

    }

    @RequestMapping("/user/{username}")
    public String followHobby(@PathVariable(name = "username") String username, HttpServletRequest request) {

        User user=userService.findByUsername(username);
        HttpSession session=request.getSession();

        session.setAttribute("user_profile",user);
        session.setAttribute("current_profile_name",username);
        return "/user-profile";
    }

    @RequestMapping("/blog")
    public String showAllBlogs() {
        return "blogs";
    }

    @RequestMapping(value = {"/videos",  "/courses"})
    public String showAllvideos() {
        return "videos";
    }

    @RequestMapping(value = {"/post-blog"})
    public String post_blog() {
        return "post-blog";
    }


}
