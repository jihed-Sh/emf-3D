package com.emf.backend.controller;

import com.emf.backend.model.ElectroData;
import com.emf.backend.service.ElectroService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin(origins = "http://localhost:4200")
@RequestMapping("/electro")
public class ElectroWS {
    private final ElectroService electroService;

    public ElectroWS(ElectroService data) {
        this.electroService=data;
    }
    @PostMapping("/add")
    public ResponseEntity<ElectroData> addData(@RequestBody ElectroData data){
        ElectroData newData= electroService.saveData(data);
        return new ResponseEntity<>(newData, HttpStatus.CREATED);
    }
    @GetMapping("/find")
    public ResponseEntity<ElectroData> getData(){
        ElectroData data= electroService.findData();
        return new ResponseEntity<>(data, HttpStatus.OK);
    }
}
