package com.adminPanel.app.model;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "product_details")
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ProductDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date expiration_date;

    private String manufacturer;

    private double price;

    private int available;

    @OneToOne
    @JoinColumn(name = "product_id")
    private Product product;
}
