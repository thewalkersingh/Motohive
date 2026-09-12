-- V3: Additional test vehicles (Bikes, EVs, and more cars) for comprehensive testing

-- ── BIKE VEHICLES ──────────────────────────────────────────────────

-- Bike 1: Honda CB500F Sport Bike
INSERT IGNORE INTO vehicles (id, seller_id, vehicle_type, brand, model, year, fuel_type, transmission, mileage_kmpl,
                             odometer_km, color, vehicle_condition, registration_number, number_of_owners, city, status,
                             created_at, updated_at)
VALUES (201, 101, 'BIKE', 'Honda', 'CB500F', 2021, 'PETROL', 'MANUAL', 22.00, 15000, 'Black', 'EXCELLENT', 'MH02BK2001',
        1, 'Mumbai', 'ACTIVE', NOW(), NOW());

INSERT IGNORE INTO bike_details (vehicle_id, engine_cc, bike_type, abs, tyre_type)
VALUES (201, 471, 'SPORT', TRUE, 'TUBELESS');

-- Bike 2: Royal Enfield Classic (Cruiser)
INSERT IGNORE INTO vehicles (id, seller_id, vehicle_type, brand, model, year, fuel_type, transmission, mileage_kmpl,
                             odometer_km, color, vehicle_condition, registration_number, number_of_owners, city, status,
                             created_at, updated_at)
VALUES (205, 104, 'BIKE', 'Royal Enfield', 'Classic 350', 2020, 'PETROL', 'MANUAL', 28.00, 22000, 'Black', 'GOOD',
        'MH06BK2005', 2, 'Delhi', 'ACTIVE', NOW(), NOW());

INSERT IGNORE INTO bike_details (vehicle_id, engine_cc, bike_type, abs, tyre_type)
VALUES (205, 349, 'CRUISER', TRUE, 'TUBE');

-- ── EV VEHICLES ────────────────────────────────────────────────────

-- EV 1: Tata Nexon EV
INSERT IGNORE INTO vehicles (id, seller_id, vehicle_type, brand, model, year, fuel_type, transmission, mileage_kmpl,
                             odometer_km, color, vehicle_condition, registration_number, number_of_owners, city, status,
                             created_at, updated_at)
VALUES (202, 102, 'EV', 'Tata', 'Nexon EV', 2022, 'ELECTRIC', 'AUTOMATIC', 25.00, 8000, 'Silver', 'EXCELLENT',
        'MH03EV2002', 1, 'Bangalore', 'ACTIVE', NOW(), NOW());

INSERT IGNORE INTO ev_details (vehicle_id, battery_capacity_kwh, range_km, charge_time_hours, connector_type,
                               top_speed_kmph, drive_type)
VALUES (202, 40.50, 312, 9.25, 'TYPE2', 160, 'FWD');

-- EV 2: MG ZS EV (Premium Electric SUV)
INSERT IGNORE INTO vehicles (id, seller_id, vehicle_type, brand, model, year, fuel_type, transmission, mileage_kmpl,
                             odometer_km, color, vehicle_condition, registration_number, number_of_owners, city, status,
                             created_at, updated_at)
VALUES (206, 105, 'EV', 'MG', 'ZS EV', 2021, 'ELECTRIC', 'AUTOMATIC', 23.00, 12000, 'White', 'EXCELLENT', 'MH07EV2006',
        1, 'Pune', 'ACTIVE', NOW(), NOW());

INSERT IGNORE INTO ev_details (vehicle_id, battery_capacity_kwh, range_km, charge_time_hours, connector_type,
                               top_speed_kmph, drive_type)
VALUES (206, 50.30, 340, 8.50, 'CCS2', 180, 'FWD');

-- ── ADDITIONAL CAR VEHICLES ────────────────────────────────────────

-- Car 2: Hyundai Creta (Compact SUV)
INSERT IGNORE INTO vehicles (id, seller_id, vehicle_type, brand, model, year, fuel_type, transmission, mileage_kmpl,
                             odometer_km, color, vehicle_condition, registration_number, number_of_owners, city, status,
                             created_at, updated_at)
VALUES (203, 101, 'CAR', 'Hyundai', 'Creta', 2020, 'DIESEL', 'AUTOMATIC', 16.50, 32000, 'Red', 'GOOD', 'MH04AB2003', 2,
        'Pune', 'ACTIVE', NOW(), NOW());

INSERT IGNORE INTO car_details (vehicle_id, engine_cc, seating_capacity, boot_space_litres, airbags, drive_type,
                                sunroof, abs)
VALUES (203, 1493, 5, 426, 6, 'FWD', FALSE, TRUE);

-- Car 3: Maruti Swift (Budget hatchback)
INSERT IGNORE INTO vehicles (id, seller_id, vehicle_type, brand, model, year, fuel_type, transmission, mileage_kmpl,
                             odometer_km, color, vehicle_condition, registration_number, number_of_owners, city, status,
                             created_at, updated_at)
VALUES (204, 103, 'CAR', 'Maruti', 'Swift', 2019, 'PETROL', 'MANUAL', 20.00, 28000, 'Blue', 'FAIR', 'MH05AB2004', 3,
        'Hyderabad', 'ACTIVE', NOW(), NOW());

INSERT IGNORE INTO car_details (vehicle_id, engine_cc, seating_capacity, boot_space_litres, airbags, drive_type,
                                sunroof, abs)
VALUES (204, 1197, 5, 268, 2, 'FWD', FALSE, FALSE);

-- Car 4: BMW 3 Series (Luxury car - SOLD status for testing)
INSERT IGNORE INTO vehicles (id, seller_id, vehicle_type, brand, model, year, fuel_type, transmission, mileage_kmpl,
                             odometer_km, color, vehicle_condition, registration_number, number_of_owners, city, status,
                             created_at, updated_at)
VALUES (207, 106, 'CAR', 'BMW', '320i', 2019, 'PETROL', 'AUTOMATIC', 12.50, 65000, 'Black', 'GOOD', 'MH08AB2007', 2,
        'Mumbai', 'SOLD', NOW(), NOW());

INSERT IGNORE INTO car_details (vehicle_id, engine_cc, seating_capacity, boot_space_litres, airbags, drive_type,
                                sunroof, abs)
VALUES (207, 1998, 5, 480, 8, 'RWD', TRUE, TRUE);

-- ── ADD IMAGES FOR ALL VEHICLES ────────────────────────────────────

-- Images for main test vehicle (id=200 - Toyota Corolla)
INSERT IGNORE INTO vehicle_images (vehicle_id, image_url, is_primary, display_order, uploaded_at)
VALUES (200, 'https://example.com/vehicles/200/primary.jpg', TRUE, 1, NOW()),
       (200, 'https://example.com/vehicles/200/side.jpg', FALSE, 2, NOW()),
       (200, 'https://example.com/vehicles/200/interior.jpg', FALSE, 3, NOW());

-- Images for bikes
INSERT IGNORE INTO vehicle_images (vehicle_id, image_url, is_primary, display_order, uploaded_at)
VALUES (201, 'https://example.com/vehicles/201/primary.jpg', TRUE, 1, NOW()),
       (201, 'https://example.com/vehicles/201/side.jpg', FALSE, 2, NOW()),
       (205, 'https://example.com/vehicles/205/primary.jpg', TRUE, 1, NOW());

-- Images for EVs
INSERT IGNORE INTO vehicle_images (vehicle_id, image_url, is_primary, display_order, uploaded_at)
VALUES (202, 'https://example.com/vehicles/202/primary.jpg', TRUE, 1, NOW()),
       (202, 'https://example.com/vehicles/202/charging.jpg', FALSE, 2, NOW()),
       (206, 'https://example.com/vehicles/206/primary.jpg', TRUE, 1, NOW()),
       (206, 'https://example.com/vehicles/206/charging.jpg', FALSE, 2, NOW()),
       (206, 'https://example.com/vehicles/206/interior.jpg', FALSE, 3, NOW());

-- Images for other cars
INSERT IGNORE INTO vehicle_images (vehicle_id, image_url, is_primary, display_order, uploaded_at)
VALUES (203, 'https://example.com/vehicles/203/primary.jpg', TRUE, 1, NOW()),
       (203, 'https://example.com/vehicles/203/interior.jpg', FALSE, 2, NOW()),
       (204, 'https://example.com/vehicles/204/primary.jpg', TRUE, 1, NOW()),
       (207, 'https://example.com/vehicles/207/primary.jpg', TRUE, 1, NOW()),
       (207, 'https://example.com/vehicles/207/interior.jpg', FALSE, 2, NOW());