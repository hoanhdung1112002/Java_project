package com.springmvc.demo.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.demo.models.User;
import com.springmvc.demo.repositories.UserRepository;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    public Iterable<User> getAllUsers() {
        return userRepository.findAllUsersNotAdmin();
    }

    public User createUser(User user) {
        return userRepository.save(user);
    }
}
