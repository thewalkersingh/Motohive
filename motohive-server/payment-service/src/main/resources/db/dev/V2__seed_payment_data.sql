-- ── Seed payments ─────────────────────────────────────────────────

INSERT INTO payments (listing_id, buyer_id, seller_id,
                      listing_price, booking_amount_type, booking_amount_value,
                      booking_amount, remaining_amount,
                      platform_fee_percent, platform_fee_amount,
                      payment_method, transaction_id, status,
                      initiated_at, completed_at, created_at, updated_at)
VALUES
-- Payment 1: SUCCESS (fixed booking amount)
(1, 2, 1,
 550000.00, 'FIXED', 5000.00,
 5000.00, 545000.00,
 2.50, 13750.00,
 'MOCK', 'TXN-DEV-001', 'SUCCESS',
 NOW(), NOW(), NOW(), NOW()),

-- Payment 2: INITIATED (percentage booking amount)
(2, 3, 1,
 380000.00, 'PERCENTAGE', 5.00,
 19000.00, 361000.00,
 2.50, 9500.00,
 'MOCK', NULL, 'INITIATED',
 NOW(), NULL, NOW(), NOW()),

-- Payment 3: FAILED
(3, 2, 4,
 720000.00, 'FIXED', 10000.00,
 10000.00, 710000.00,
 2.50, 18000.00,
 'MOCK', NULL, 'FAILED',
 NOW(), NOW(), NOW(), NOW()),

-- Payment 4: PROCESSING
(4, 5, 1,
 290000.00, 'PERCENTAGE', 10.00,
 29000.00, 261000.00,
 2.50, 7250.00,
 'MOCK', NULL, 'PROCESSING',
 NOW(), NULL, NOW(), NOW()),

-- Payment 5: REFUNDED
(5, 2, 3,
 450000.00, 'FIXED', 5000.00,
 5000.00, 445000.00,
 2.50, 11250.00,
 'MOCK', 'TXN-DEV-002', 'REFUNDED',
 NOW(), NOW(), NOW(), NOW());

-- ── Seed outbox (one published, one pending) ──────────────────────

INSERT INTO payment_outbox (payment_id, event_type, payload, status, retry_count, created_at, published_at)
VALUES
-- already published (for payment 1)
(1, 'PAYMENT_SUCCESS',
 '{"paymentId":1,"listingId":1,"buyerId":2,"sellerId":1,"listingPrice":550000.00,"bookingAmount":5000.00,"remainingAmount":545000.00,"platformFeeAmount":13750.00,"transactionId":"TXN-DEV-001"}',
 'PUBLISHED', 0, NOW(), NOW()),

-- pending (for payment 4 - will be picked up by OutboxScheduler)
(4, 'PAYMENT_SUCCESS',
 '{"paymentId":4,"listingId":4,"buyerId":5,"sellerId":1,"listingPrice":290000.00,"bookingAmount":29000.00,"remainingAmount":261000.00,"platformFeeAmount":7250.00,"transactionId":null}',
 'PENDING', 0, NOW(), NULL);