package com.example.demoweb.service;

import com.example.demoweb.model.User;
import com.example.demoweb.repository.UserRepository;

public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository){
        this.userRepository = userRepository;
    }

    public UserService() {
        this.userRepository = new UserRepository();
    }

    public void addUser(String login, String email, String password) {
        if (login != null && login != "" && email != null && email != "" && password != null && password != "") {
            User user = new User(login, email, password);
            if (userRepository.save(user)) return;
        }
        throw new IllegalArgumentException();
    }

    public boolean validUser(String login, String password) {
        User user = userRepository.getUser(login);
        return user != null && user.getPassword().equals(password);
    }
}
