package com.motohive.vehicleservice.entity;

import com.motohive.vehicleservice.enums.DriveType;
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
public class CarDetails extends Vehicle {
	
	@Column(name = "seating_capacity")
	private Byte seatingCapacity;
	
	@Column(name = "boot_space_litres")
	private Integer bootSpaceLitres;
	
	@Column
	private Byte airbags;
	
	@Enumerated(EnumType.STRING)
	@Column(name = "drive_type", length = 5)
	private DriveType driveType;
	
	@Column
	private Boolean sunroof;
	
	@Column
	private Boolean abs;
	
}