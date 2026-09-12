package com.motohive.listingservice.kafka;

import com.motohive.listingservice.entity.VehicleExpense;
import com.motohive.listingservice.enums.ExpenseType;
import com.motohive.listingservice.enums.ListingStatus;
import com.motohive.listingservice.repository.ListingRepository;
import com.motohive.listingservice.repository.VehicleExpenseRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Component
@RequiredArgsConstructor
@Slf4j
public class PaymentEventConsumer {
	
	private final ListingRepository      listingRepository;
	private final VehicleExpenseRepository expenseRepository;
	
	@KafkaListener(
			topics = "payment.completed",
			groupId = "listing-service-group"
	)
	@Transactional
	public void handlePaymentCompleted(PaymentCompletedEvent event) {
		log.info("Received payment.completed event for listing: {}", event.getListingId());
		
		// 1. mark listing as SOLD
		listingRepository.findById(event.getListingId()).ifPresent(listing -> {
			listing.setStatus(ListingStatus.SOLD);
			listing.setFinalSalePrice(event.getListingPrice());
			listing.setSoldAt(LocalDateTime.now());
			listingRepository.save(listing);
			log.info("Listing {} marked as SOLD", event.getListingId());
		});
		
		// 2. add PLATFORM_FEE to vehicle_expenses
		listingRepository.findById(event.getListingId()).ifPresent(listing -> {
			VehicleExpense platformFee = VehicleExpense.builder()
					                             .vehicleId(listing.getVehicleId())
					                             .sellerId(event.getSellerId())
					                             .expenseType(ExpenseType.PLATFORM_FEE)
					                             .amount(event.getPlatformFeeAmount())
					                             .description("Platform fee for listing " + event.getListingId()
							                                          + " — txn: " + event.getTransactionId())
					                             .incurredAt(LocalDate.now())
					                             .build();
			expenseRepository.save(platformFee);
			log.info("Platform fee expense added for vehicle: {}", listing.getVehicleId());
		});
	}
}