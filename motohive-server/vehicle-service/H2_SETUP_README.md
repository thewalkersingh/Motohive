# Vehicle Service - H2 Database Configuration for Testing

## Overview
The Vehicle Service has been configured with H2 in-memory database for local development and testing. This document explains how the H2 setup works and how to use it.

## Configuration

### Files Modified/Created:
1. **application-dev.yaml** - Dev profile configuration with H2 database settings
2. **db/migration/schema.sql** - Initial schema creation (unchanged)
3. **db/migration/data.sql** - Initial test data (1 Toyota Corolla)
4. **db/migration/V3__seed_additional_vehicles.sql** - Additional test vehicles (bikes, EVs, additional cars)

## How It Works

### 1. Database Initialization on Startup
When the service starts with the dev profile, the following happens in order:

1. **Flyway Migration** - Automatically runs in the correct order:
   - `schema.sql` - Creates all table schemas
   - `data.sql` - Inserts initial test data
   - `V3__seed_additional_vehicles.sql` - Inserts additional test vehicles

2. **JPA Configuration** - Set to `hibernate.ddl-auto: validate` which validates the schema without modifying it

3. **H2 Console** - Accessible at `http://localhost:8082/h2-console` for direct SQL queries

### 2. Test Data Available

#### Vehicle Types:
- **CAR**: Toyota Corolla, Hyundai Creta, Maruti Swift, BMW 320i
- **BIKE**: Honda CB500F, Royal Enfield Classic 350
- **EV**: Tata Nexon EV, MG ZS EV

#### Key Test Scenarios:
- Different vehicle types (CAR, BIKE, EV)
- Different fuel types (PETROL, DIESEL, ELECTRIC)
- Different conditions (EXCELLENT, GOOD, FAIR, POOR)
- Vehicle status variations (ACTIVE, SOLD)
- Multiple owners for vehicles
- Vehicle images with primary and secondary images
- Related detail entities (CarDetails, BikeDetails, EvDetails)

### 3. Starting the Service

#### Option A: Using Maven
```bash
cd vehicle-service
mvn spring-boot:run -Dspring-boot.run.arguments="--spring.profiles.active=dev"
```

#### Option B: Using Java
```bash
cd vehicle-service
java -jar target/vehicle-service-1.0.0.jar --spring.profiles.active=dev
```

#### Option C: Using IDE
Set VM options: `-Dspring.profiles.active=dev`

### 4. Accessing H2 Console

Once the service is running with the dev profile:

1. Open browser: **http://localhost:8082/h2-console**
2. Connection settings (should be auto-filled):
   - **JDBC URL**: `jdbc:h2:mem:vehicles;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE;MODE=MySQL`
   - **User Name**: `sa`
   - **Password**: (leave empty)
3. Click **Connect** to access the in-memory database

### 5. Query Examples

#### View all vehicles:
```sql
SELECT * FROM vehicles;
```

#### View specific vehicle with details:
```sql
SELECT 
    v.id, v.brand, v.model, v.vehicle_type, v.status, v.city,
    cd.engine_cc, cd.seating_capacity,
    bd.bike_type, bd.engine_cc as bike_cc,
    ed.battery_capacity_kwh
FROM vehicles v
LEFT JOIN car_details cd ON v.id = cd.vehicle_id
LEFT JOIN bike_details bd ON v.id = bd.vehicle_id
LEFT JOIN ev_details ed ON v.id = ed.vehicle_id
WHERE v.id = 200;
```

#### View vehicles by city:
```sql
SELECT id, brand, model, city, status FROM vehicles WHERE city = 'Pune';
```

#### View vehicle images:
```sql
SELECT v.id, v.brand, v.model, vi.image_url, vi.is_primary 
FROM vehicle_images vi
JOIN vehicles v ON vi.vehicle_id = v.id
ORDER BY v.id, vi.display_order;
```

## Database Schema

### Tables:
- **vehicles** - Main vehicle information
- **car_details** - Details specific to cars (OneToOne)
- **bike_details** - Details specific to bikes (OneToOne)
- **ev_details** - Details specific to electric vehicles (OneToOne)
- **vehicle_images** - Images associated with vehicles (OneToMany)

## Key Configuration Details

### H2 Connection URL
```
jdbc:h2:mem:vehicles;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE;MODE=MySQL
```

**Parameters:**
- `mem:vehicles` - In-memory database named "vehicles"
- `DB_CLOSE_DELAY=-1` - Keeps database open after connection closes
- `DB_CLOSE_ON_EXIT=FALSE` - Prevents database from closing when last connection exits
- `MODE=MySQL` - H2 compatibility mode for MySQL syntax

### JPA Hibernate Configuration
```yaml
hibernate:
  ddl-auto: validate  # Validates schema without creating/dropping tables
database-platform: org.hibernate.dialect.H2Dialect  # Uses H2 dialect
```

### Flyway Configuration
```yaml
flyway:
  enabled: true
  locations: classpath:db/migration  # Migration script location
  baseline-on-migrate: true
  out-of-order: false
```

## Important Notes

1. **In-Memory Database** - Data is lost when the service stops. Perfect for testing but not for persistence.

2. **Automatic Execution** - All migration scripts are automatically executed in version order (V1, V2, V3...) when the service starts.

3. **Migration Safety** - Use `INSERT IGNORE` to prevent duplicate key errors if running migrations multiple times.

4. **H2 Console** - Only enabled in dev profile with `web-allow-others: false` for security.

5. **Thread Safety** - H2 in-memory databases can be safely accessed from multiple threads.

## Adding More Test Data

To add more test data:

1. Create a new migration file: `V4__seed_more_vehicles.sql`
2. Add your INSERT statements following the same pattern:
   ```sql
   INSERT IGNORE INTO vehicles (id, seller_id, vehicle_type, ...) VALUES (...);
   ```
3. Flyway will automatically execute it in version order

## Troubleshooting

### Q: Data is not loading
- Check that `spring.profiles.active=dev` is set
- Check Flyway logs: `org.flywaydb` logging should show migration details
- Verify migration files are in `src/main/resources/db/migration`

### Q: "duplicate key" errors
- This is normal if you restart and migrations try to insert duplicate IDs
- Use `INSERT IGNORE` which the migration scripts already do
- For H2, duplicate errors are usually harmless on subsequent runs

### Q: H2 console shows empty database
- Ensure dev profile is active
- Check that migrations passed (look at logs)
- Verify table names match the schema

### Q: Can't connect to H2 console
- Service might be running on a different port (check application-dev.yaml)
- Ensure H2 console is enabled in config
- Try: http://localhost:8082/h2-console

## Production vs Dev

**Important**: This H2 in-memory configuration is intentionally designed for testing ONLY. 

For production:
- Use `application.yaml` (default) which uses MySQL
- Ensure `DB_USERNAME` and `DB_PASSWORD` environment variables are set
- Verify connection to real MySQL database before deploying

## Testing with H2

### API Testing Examples:
```bash
# Get all vehicles (seller ID 100)
curl http://localhost:8082/api/v1/vehicles/seller/100

# Get specific vehicle
curl http://localhost:8082/api/v1/vehicles/200

# Search vehicles by type
curl "http://localhost:8082/api/v1/vehicles/search?vehicleType=CAR&city=Pune"

# Get vehicle with details
curl http://localhost:8082/api/v1/vehicles/200/details
```

---

For more information, refer to the Spring Boot, Flyway, and H2 documentation.