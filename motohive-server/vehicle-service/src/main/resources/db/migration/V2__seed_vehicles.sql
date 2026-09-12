-- ── Seed vehicles ─────────────────────────────────────────────────

INSERT INTO vehicles (seller_id, vehicle_type, brand, model, year,
                      fuel_type, transmission, mileage_kmpl, odometer_km,
                      color, condition, registration_number, insurance_expiry,
                      number_of_owners, city, status, created_at, updated_at)
VALUES
-- CAR 1
(1, 'CAR', 'Toyota', 'Innova', 2021,
 'DIESEL', 'MANUAL', 14.50, 45000,
 'White', 'GOOD', 'DL01AB1234', DATE '2026-12-31',
 1, 'Delhi', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- CAR 2
(1, 'CAR', 'Honda', 'City', 2020,
 'PETROL', 'AUTOMATIC', 17.80, 32000,
 'Silver', 'EXCELLENT', 'MH02CD5678', DATE '2027-03-15',
 1, 'Mumbai', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- BIKE 1
(2, 'BIKE', 'Royal Enfield', 'Classic 350', 2022,
 'PETROL', 'MANUAL', 35.00, 12000,
 'Black', 'EXCELLENT', 'KA03EF9012', DATE '2027-06-30',
 1, 'Bangalore', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- EV 1
(3, 'EV', 'Tata', 'Nexon EV', 2023,
 'ELECTRIC', 'AUTOMATIC', NULL, 18000,
 'Blue', 'EXCELLENT', 'GJ04GH3456', DATE '2028-01-15',
 1, 'Ahmedabad', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- CAR 3 (SOLD)
(2, 'CAR', 'Maruti', 'Swift', 2019,
 'PETROL', 'MANUAL', 22.00, 65000,
 'Red', 'FAIR', 'TN05IJ7890', DATE '2025-08-20',
 2, 'Chennai', 'SOLD', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ── Seed car_details ──────────────────────────────────────────────

INSERT INTO car_details (vehicle_id, engine_cc, seating_capacity,
                         boot_space_litres, airbags, drive_type, sunroof, abs)
VALUES (1, 2393, 7, 300, 4, 'FWD', FALSE, TRUE),
       (2, 1498, 5, 506, 6, 'FWD', TRUE, TRUE),
       (5, 1197, 5, 268, 2, 'FWD', FALSE, TRUE);

-- ── Seed bike_details ─────────────────────────────────────────────

INSERT INTO bike_details (vehicle_id, engine_cc, bike_type, abs, tyre_type)
VALUES (3, 349, 'CRUISER', TRUE, 'TUBELESS');

-- ── Seed ev_details ───────────────────────────────────────────────

INSERT INTO ev_details (vehicle_id, battery_capacity_kwh, range_km,
                        charge_time_hours, connector_type, top_speed_kmph, drive_type)
VALUES (4, 40.50, 312, 8.00, 'CCS2', 120, 'FWD');

-- ── Seed vehicle_images ───────────────────────────────────────────

INSERT INTO vehicle_images (vehicle_id, image_url, is_primary, display_order, uploaded_at)
VALUES (1, 'https://cdn.motohive.com/vehicles/1/front.jpg', TRUE, 1, CURRENT_TIMESTAMP),
       (1, 'https://cdn.motohive.com/vehicles/1/side.jpg', FALSE, 2, CURRENT_TIMESTAMP),
       (2, 'https://cdn.motohive.com/vehicles/2/front.jpg', TRUE, 1, CURRENT_TIMESTAMP),
       (3, 'https://cdn.motohive.com/vehicles/3/front.jpg', TRUE, 1, CURRENT_TIMESTAMP),
       (4, 'https://cdn.motohive.com/vehicles/4/front.jpg', TRUE, 1, CURRENT_TIMESTAMP);