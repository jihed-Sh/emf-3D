package com.emf.backend.registration;

import lombok.*;

@Getter
@EqualsAndHashCode
@AllArgsConstructor
@ToString
@Setter
public class RegistrationRequest {
    private  final  String firstName;
    private final String lastName;
    private  final  String password;
    private  final  String email;
}
