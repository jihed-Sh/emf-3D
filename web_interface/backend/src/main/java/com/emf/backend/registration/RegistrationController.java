package com.emf.backend.registration;


import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
public class RegistrationController {
        private RegistrationService registrationService;
    @PostMapping("/register")
    public String register(@RequestBody RegistrationRequest request){
        return  registrationService.register(request);
    }
    @GetMapping("/login")
    public String adminEndpoint() {
        return "Login!";
    }
}
