-- ── payments ──────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS payments
(
    id                   BIGINT         NOT NULL AUTO_INCREMENT,
    listing_id           BIGINT         NOT NULL,
    buyer_id             BIGINT         NOT NULL,
    seller_id            BIGINT         NOT NULL,
    listing_price        DECIMAL(12, 2) NOT NULL,
    booking_amount_type  VARCHAR(15)    NOT NULL,
    booking_amount_value DECIMAL(10, 2) NOT NULL,
    booking_amount       DECIMAL(12, 2) NOT NULL,
    remaining_amount     DECIMAL(12, 2) NOT NULL,
    platform_fee_percent DECIMAL(5, 2)  NOT NULL,
    platform_fee_amount  DECIMAL(12, 2) NOT NULL,
    payment_method       VARCHAR(15)    NOT NULL DEFAULT 'MOCK',
    transaction_id       VARCHAR(100),
    status               VARCHAR(15)    NOT NULL DEFAULT 'INITIATED',
    failure_reason       VARCHAR(255),
    initiated_at         TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at         TIMESTAMP,
    created_at           TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

-- ── payment_outbox ────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS payment_outbox
(
    id           BIGINT      NOT NULL AUTO_INCREMENT,
    payment_id   BIGINT      NOT NULL,
    event_type   VARCHAR(50) NOT NULL,
    payload      TEXT        NOT NULL,
    status       VARCHAR(15) NOT NULL DEFAULT 'PENDING',
    retry_count  TINYINT     NOT NULL DEFAULT 0,
    created_at   TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    published_at TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_outbox_payment FOREIGN KEY (payment_id) REFERENCES payments (id)
);