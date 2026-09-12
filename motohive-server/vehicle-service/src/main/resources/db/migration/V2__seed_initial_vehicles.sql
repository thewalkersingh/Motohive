-- Seed initial vehicle owned by seller id 100
INSERT IGNORE INTO vehicles (id, seller_id, vehicle_type, brand, model, year, fuel_type, transmission, mileage_kmpl,
                             odometer_km, color, vehicle_condition, registration_number, number_of_owners, city, status,
                             created_at, updated_at)
VALUES (200, 100, 'CAR', 'Toyota', 'Corolla', 2018, 'PETROL', 'AUTOMATIC', 18.50, 45000, 'White', 'GOOD', 'MH01AB2000',
        1, 'Pune', 'ACTIVE', NOW(), NOW());

-- Populate car_details for vehicle 200
INSERT IGNORE INTO car_details (vehicle_id, engine_cc, seating_capacity, boot_space_litres, airbags, drive_type,
                                sunroof, abs)
VALUES (200, 1798, 5, 470, 6, 'FWD', FALSE, TRUE);

-- Add a primary image for the vehicle
INSERT IGNORE INTO vehicle_images (id, vehicle_id, image_url, is_primary, display_order, uploaded_at)
VALUES (900, 200, 'https://example.com/images/vehicles/200/primary.jpg', TRUE, 1, NOW());