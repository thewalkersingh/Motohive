-- V2: Seed listings required for payment/booking flows
-- Creates one listing (id=300) referencing vehicle_id=200 and seller_id=100
INSERT INTO listings (id, vehicle_id, seller_id, price, description, meeting_location, status, listed_at, updated_at)
VALUES
  (300, 200, 100, 750000.00, 'Test listing for vehicle 200', 'Pune', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Optionally add an enquiry to exercise endpoints
INSERT INTO listing_enquiries (id, listing_id, buyer_id, message, contact_number, status, created_at, updated_at)
VALUES
  (700, 300, 101, 'Is the price negotiable?', '9990002000', 'PENDING', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Note: keep types generic (TIMESTAMP, VARCHAR/TEXT) so scripts are compatible with H2 in dev