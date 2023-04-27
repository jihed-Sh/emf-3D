package com.emf.backend.repo;

import com.emf.backend.model.ElectroData;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ElectroRepo extends JpaRepository<ElectroData,Long> {

}
