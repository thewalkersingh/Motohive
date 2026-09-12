-- Seed initial users for testing (seller and buyer)
INSERT IGNORE INTO users (id, first_name, last_name, email, password, phone, status, created_at, updated_at)
VALUES (100, 'Seller', 'One', 'seller1@example.com', 'password', '9998887770', 'ACTIVE', NOW(), NOW()),
       (101, 'Buyer', 'One', 'buyer1@example.com', 'password', '8887776660', 'ACTIVE', NOW(), NOW());

-- Assign roles
INSERT IGNORE INTO user_roles (user_id, role)
VALUES (100, 'SELLER'),
       (101, 'BUYER');

-- Optional: add a default address for the seller
INSERT IGNORE INTO user_addresses (id, user_id, address_line, city, state, pincode, is_default, created_at)
VALUES (500, 100, '123 Seller Street', 'Pune', 'Maharashtra', '411001', TRUE, NOW());