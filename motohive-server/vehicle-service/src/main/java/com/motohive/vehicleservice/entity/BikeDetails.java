package com.motohive.vehicleservice.entity;

import com.motohive.vehicleservice.enums.BikeType;
import com.motohive.vehicleservice.enums.TyreType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class BikeDetails extends Vehicle {
	
	@Column(name = "engine_cc")
	private Integer engineCc;
	
	@Enumerated(EnumType.STRING)
	@Column(name = "bike_type", length = 10)
	private BikeType bikeType;
	
	@Column
	private Boolean abs;
	
	@Enumerated(EnumType.STRING)
	@Column(name = "tyre_type", length = 10)
	private TyreType tyreType;
	
}