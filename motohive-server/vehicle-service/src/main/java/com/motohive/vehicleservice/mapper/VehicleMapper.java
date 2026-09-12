package com.motohive.vehicleservice.mapper;
import com.motohive.vehicleservice.dto.request.CreateVehicleRequest;
import com.motohive.vehicleservice.dto.response.VehicleImageResponse;
import com.motohive.vehicleservice.dto.response.VehicleResponse;
import com.motohive.vehicleservice.entity.*;
import org.mapstruct.*;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)  // makes it a Spring bean — inject with @Autowired
public interface VehicleMapper {
	
	// ── Entity → Flat Response ────────────────────────
	@Mapping(target = "model", source = "modelName")
	@Mapping(target = "year", source = "mfgYear")
	VehicleResponse toResponse(Vehicle vehicle);
	
	// ── CreateRequest → Entity ────────────────────────
	@Mapping(target = "id", ignore = true)
	@Mapping(target = "status", ignore = true)  // defaults to ACTIVE in entity
	@Mapping(target = "createdAt", ignore = true)
	@Mapping(target = "updatedAt", ignore = true)
	@Mapping(target = "modelName", source = "model")
	@Mapping(target = "mfgYear", source = "year")
	@Mapping(target = "images", ignore = true)
	Vehicle toEntity(CreateVehicleRequest request);
	
	// ── Image Entity → Response ───────────────────────
	VehicleImageResponse toImageResponse(VehicleImage image);
	
	// ── Custom mapping method with after-mapping ──────
	@AfterMapping
	default void enrichVehicleResponse(Vehicle vehicle, @MappingTarget VehicleResponse response) {
		// Map vehicle-type specific details based on actual runtime type
		if (vehicle instanceof CarDetails carDetails) {
			response.setEngineCc(carDetails.getEngineCc());
			response.setSeatingCapacity(carDetails.getSeatingCapacity());
			response.setBootSpaceLitres(carDetails.getBootSpaceLitres());
			response.setAirbags(carDetails.getAirbags());
			response.setDriveType(carDetails.getDriveType());
			response.setSunroof(carDetails.getSunroof());
			response.setAbs(carDetails.getAbs());
		} else if (vehicle instanceof BikeDetails bikeDetails) {
			response.setEngineCc(bikeDetails.getEngineCc());
			response.setBikeType(bikeDetails.getBikeType());
			response.setAbs(bikeDetails.getAbs());
			response.setTyreType(bikeDetails.getTyreType());
		} else if (vehicle instanceof EvDetails evDetails) {
			response.setBatteryCapacityKwh(evDetails.getBatteryCapacityKwh());
			response.setRangeKm(evDetails.getRangeKm());
			response.setChargeTimeHours(evDetails.getChargeTimeHours());
			response.setConnectorType(evDetails.getConnectorType());
			response.setTopSpeedKmph(evDetails.getTopSpeedKmph());
			response.setDriveType(evDetails.getDriveType());
		}
	}
	
}