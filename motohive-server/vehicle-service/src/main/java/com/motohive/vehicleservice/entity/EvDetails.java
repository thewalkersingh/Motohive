package com.motohive.vehicleservice.entity;

import com.motohive.vehicleservice.enums.ConnectorType;
import com.motohive.vehicleservice.enums.DriveType;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.math.BigDecimal;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class EvDetails extends Vehicle {
	
	// ID is inherited from Vehicle - do not redeclare
	// No separate OneToOne relationship needed - EvDetails IS a Vehicle via inheritance
	
	@Column(name = "battery_capacity_kwh", precision = 5, scale = 2)
	private BigDecimal batteryCapacityKwh;
	
	@Column(name = "range_km")
	private Integer rangeKm;
	
	@Column(name = "charge_time_hours", precision = 4, scale = 2)
	private BigDecimal chargeTimeHours;
	
	@Enumerated(EnumType.STRING)
	@Column(name = "connector_type", length = 10)
	private ConnectorType connectorType;
	
	@Column(name = "top_speed_kmph")
	private Integer topSpeedKmph;
	
	@Enumerated(EnumType.STRING)
	@Column(name = "drive_type", length = 5)
	private DriveType driveType;
	
}