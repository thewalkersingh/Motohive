-- Dev-only seed for H2 (user-service)
-- Inserts users (seller 100, buyer 101, inactive user 102) and supporting data
INSERT INTO users (id, first_name, last_name, email, password, phone, status, created_at, updated_at)
VALUES (100, 'Seller', 'One', 'seller1@example.com', 'Password123!', '9990001000', 'ACTIVE', CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP),
       (101, 'Buyer', 'One', 'buyer1@example.com', 'Password123!', '9990002000', 'ACTIVE', CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP),
       (102, 'Inactive', 'User', 'inactive@example.com', 'Password123!', '9990003000', 'INACTIVE', CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP);

INSERT INTO user_roles (user_id, role)
VALUES (100, 'SELLER'),
       (101, 'BUYER'),
       (102, 'BUYER');

INSERT INTO user_addresses (id, user_id, address_line, city, state, pincode, is_default, created_at)
VALUES (500, 100, '123 Seller St', 'Pune', 'MH', '411001', TRUE, CURRENT_TIMESTAMP),
       (501, 101, '456 Buyer Ave', 'Pune', 'MH', '411002', TRUE, CURRENT_TIMESTAMP);