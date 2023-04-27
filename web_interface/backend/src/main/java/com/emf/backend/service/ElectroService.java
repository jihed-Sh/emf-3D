package com.emf.backend.service;

import com.emf.backend.model.ElectroData;
import com.emf.backend.repo.ElectroRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ElectroService {
    private final ElectroRepo electroRepo;

    @Autowired
    public ElectroService(ElectroRepo electroRepo) {
        this.electroRepo = electroRepo;
    }
    public ElectroData saveData(ElectroData data){
        return electroRepo.save(data);
    }
    public ElectroData findData(){
        List<ElectroData> list =electroRepo.findAll();
        return list.get(list.size()-1);
    }
}
