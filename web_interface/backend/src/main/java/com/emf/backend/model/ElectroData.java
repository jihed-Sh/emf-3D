package com.emf.backend.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;
@Entity
@NoArgsConstructor
@Data
@AllArgsConstructor
public class ElectroData {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long Id;
    @ElementCollection
    private List<Double> xValues;
    @ElementCollection
    private List<Double> yValues;
    @ElementCollection
    private List<Double> zValues;
    @ElementCollection
    private List<Double> emfValues;
}
