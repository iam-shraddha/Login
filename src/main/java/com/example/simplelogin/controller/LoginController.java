package com.example.simplelogin.controller;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class LoginController {
  @PostMapping("/login")
  public String login(@RequestParam String username,
                      @RequestParam String password) {
    return ("admin".equals(username) && "password".equals(password))
      ? "✅ Login successful!"
      : "❌ Invalid credentials.";
  }

  @GetMapping("/ping")
  public String ping() {
    return "App is running!";
  }
}

