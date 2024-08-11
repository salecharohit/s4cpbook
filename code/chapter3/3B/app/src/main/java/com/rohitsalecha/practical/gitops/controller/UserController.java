package com.rohitsalecha.practical.gitops.controller;

import com.rohitsalecha.practical.gitops.model.*;
import com.rohitsalecha.practical.gitops.repository.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.validation.Valid;

@Controller
@RequestMapping("/users/")
public class UserController {

    static final Logger logger = LoggerFactory.getLogger(UserController.class);
    private final UserRepository userRepository;

    @Autowired
    public UserController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping("signup")
    public String showSignUpForm(User user) {
        logger.info("showSignUpForm function");
        
        return "add-user";
    }

    @GetMapping("list")
    public String showUpdateForm(Model model) {
        logger.info("showUpdateForm function");
        
        model.addAttribute("users", userRepository.findAll());
        return "index";
    }

    @PostMapping("add")
    public String adduser(@Valid User user, BindingResult result, Model model) {
        logger.info("adduser function");
        
        if (result.hasErrors()) {
            logger.error("adduser has errors {}",result.getAllErrors());
            return "add-user";
        }

        logger.info("User {} has been addded",user.getName());
        
        userRepository.save(user);
        return "redirect:list";
    }

    @GetMapping("edit/{id}")
    public String showUpdateForm(@PathVariable("id") long id, Model model) {

    	logger.info("showUpdateForm function");
    	
        User user = userRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Invalid user Id:" + id));
        
        logger.info("User with id {} will be edited",id);
        
        model.addAttribute("user", user);
        return "update-user";
    }

    @PostMapping("update/{id}")
    public String updateuser(@PathVariable("id") long id, @Valid User user, BindingResult result,
        Model model) {
    	
    	logger.info("updateuser function updating user with id {}",id);
    	
        if (result.hasErrors()) {
            logger.error("updateuser has errors {}",result.getAllErrors());        	
            user.setId(id);
            return "update-user";
        }

        userRepository.save(user);
        
    	logger.info("User {} has been updated",user.getName());
        
        model.addAttribute("users", userRepository.findAll());
        return "index";
    }

    @GetMapping("delete/{id}")
    public String deleteuser(@PathVariable("id") long id, Model model) {
        
    	logger.info("deleteuser function deleting user with id {}",id);
    	
    	User user = userRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Invalid user Id:" + id));
    	
        userRepository.delete(user);
        
    	logger.info("User with id {} has been deleted",id);
        
        model.addAttribute("users", userRepository.findAll());
        return "index";
    }

// SSRF Exampple just in Code DONOT use in production
// Comment From here
	private static void getURL(String url) throws IOException {
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("GET");
		int responseCode = con.getResponseCode();
		System.out.println("GET Response Code :: " + responseCode);
		if (responseCode == HttpURLConnection.HTTP_OK) { // success
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			System.out.println(response.toString());
		} else {
			System.out.println("GET request did not work.");
		}
	}
// SSRF Exampple just in Code DONOT use in production
// Comment Till here

}
