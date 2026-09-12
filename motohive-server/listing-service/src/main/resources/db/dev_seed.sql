-- Dev-only seed for H2 (listing-service)
-- Listings: 300 active, 301 deleted/inactive
INSERT INTO listings (id, vehicle_id, seller_id, price, description, meeting_location, status, listed_at, updated_at)
VALUES (300, 200, 100, 750000.00, 'Test listing for vehicle 200', 'Pune', 'ACTIVE', CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP),
       (301, 201, 100, 250000.00, 'Old listing for vehicle 201', 'Pune', 'INACTIVE', CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP);

INSERT INTO listing_enquiries (id, listing_id, buyer_id, message, contact_number, status, created_at, updated_at)
VALUES (700, 300, 101, 'Is the price negotiable?', '9990002000', 'PENDING', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
       (701, 301, 101, 'Is this still available?', '9990002000', 'CLOSED', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);