-- Seed a payment for listing 300: buyer 101 paying seller 100
-- booking_amount_type = FIXED; booking_amount_value = 10000.00
-- listing_price = 750000.00; booking_amount = 10000.00; remaining_amount = 740000.00
-- platform fee set as 2.50% => platform_fee_amount = 18750.00
INSERT IGNORE INTO payments (id, listing_id, buyer_id, seller_id, listing_price, booking_amount_type,
                             booking_amount_value, booking_amount, remaining_amount, platform_fee_percent,
                             platform_fee_amount, payment_method, transaction_id, status, initiated_at, created_at,
                             updated_at)
VALUES (400, 300, 101, 100, 750000.00, 'FIXED',
        10000.00, 10000.00, 740000.00, 2.50,
        18750.00, 'MOCK', NULL,
        'INITIATED', NOW(), NOW(), NOW());

-- Optional: add an outbox entry to simulate event emission after payment creation
INSERT IGNORE INTO payment_outbox (id, payment_id, event_type, payload, status, retry_count, created_at)
VALUES (800, 400, 'PAYMENT_INITIATED', JSON_OBJECT('paymentId', 400, 'listingId',
                                                   300, 'buyerId', 101), 'PENDING', 0,
        NOW());