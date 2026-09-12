-- Seed a listing for vehicle 200 by seller 100
INSERT IGNORE INTO listings (id, vehicle_id, seller_id, price, expected_price, final_sale_price, is_negotiable, description, meeting_location, status, listed_at, updated_at)
VALUES
  (300, 200, 100, 750000.00, 760000.00, NULL, TRUE, 'Well maintained Toyota Corolla, single owner, service history available.', 'Pune', 'ACTIVE', NOW(), NOW());

-- Optional: a sample enquiry by buyer 101
INSERT IGNORE INTO listing_enquiries (id, listing_id, buyer_id, message, contact_number, status, created_at)
VALUES
  (700, 300, 101, 'Is the car still available? Can I schedule a viewing?', '8887776660', 'PENDING', NOW());