-- V2: Seed users, roles and addresses for local/dev testing
-- Inserts two users: seller (id=100) and buyer (id=101)
INSERT INTO users (id, first_name, last_name, email, password, phone, status, created_at, updated_at)
VALUES
  (100, 'Seller', 'One', 'seller1@example.com', 'Password123!', '9990001000', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (101, 'Buyer', 'One', 'buyer1@example.com', 'Password123!', '9990002000', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Roles
INSERT INTO user_roles (user_id, role)
VALUES (100, 'SELLER'), (101, 'BUYER');

-- Addresses
INSERT INTO user_addresses (id, user_id, address_line, city, state, pincode, is_default, created_at)
VALUES
  (500, 100, '123 Seller St', 'Pune', 'MH', '411001', TRUE, CURRENT_TIMESTAMP),
  (501, 101, '456 Buyer Ave', 'Pune', 'MH', '411002', TRUE, CURRENT_TIMESTAMP);

-- NOTE: passwords are inserted in plain text intentionally for the dev profile. A startup component
-- will encode plaintext passwords using BCrypt on application startup so authentication works.