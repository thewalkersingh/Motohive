package com.motohive.listingservice.init;

import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;

@Component
public class DevDataSeeder {
	
	private final DataSource dataSource;
	private final Environment env;
	
	public DevDataSeeder(DataSource dataSource, Environment env) {
		this.dataSource = dataSource;
		this.env = env;
	}
	
	@EventListener(ApplicationReadyEvent.class)
	public void seed() {
		for (String p : env.getActiveProfiles()) {
			if ("dev".equals(p)) {
				int attempts = 0;
				int maxAttempts = 8;
				while (attempts < maxAttempts) {
					attempts++;
					try {
						Thread.sleep(1000);
						ResourceDatabasePopulator pop = new ResourceDatabasePopulator();
						pop.addScript(new ClassPathResource("db/dev_seed.sql"));
						pop.setContinueOnError(true);
						pop.execute(dataSource);
						System.out.println(
								"[DevDataSeeder] listing-service: dev_seed.sql executed (attempt=" + attempts + ")");
						break;
					} catch (Exception e) {
						System.err.println("[DevDataSeeder] Attempt " + attempts + " failed: " + e.getMessage());
						if (attempts >= maxAttempts) {e.printStackTrace();} else {
							try {Thread.sleep(1000);} catch (InterruptedException ie) {}
						}
					}
				}
				return;
			}
		}
	}
	
}