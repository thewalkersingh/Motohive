package com.motohive.paymentservice.config;
// delete this class as it is for DEV profile
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.kafka.core.KafkaTemplate;

@Configuration
public class KafkaConfigDEV {
	
	// provides a null KafkaTemplate in dev so PaymentEventPublisher doesn't fail
	@Bean
	@Profile("dev")
	@ConditionalOnMissingBean(KafkaTemplate.class)
	public KafkaTemplate<String, String> devKafkaTemplate() {
		return null;
	}
	
}