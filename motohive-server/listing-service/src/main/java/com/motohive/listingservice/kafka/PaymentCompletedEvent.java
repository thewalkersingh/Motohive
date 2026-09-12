package com.motohive.listingservice.kafka;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class PaymentCompletedEvent {
	
	private Long paymentId;
	private Long listingId;
	private Long buyerId;
	private Long sellerId;
	private BigDecimal listingPrice;
	private BigDecimal bookingAmount;
	private BigDecimal remainingAmount;
	private BigDecimal platformFeeAmount;
	private String transactionId;
	private LocalDateTime completedAt;
	
}