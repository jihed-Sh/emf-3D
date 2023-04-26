package com.emf.backend.appuser;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Transactional(readOnly=true)
@Repository
public interface AppUserRepo extends JpaRepository<AppUser,Long> {
    Optional<AppUser> findByEmail(String email);
}
