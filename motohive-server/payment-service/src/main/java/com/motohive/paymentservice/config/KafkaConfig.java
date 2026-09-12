package com.motohive.paymentservice.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.common.serialization.StringSerializer;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.kafka.core.DefaultKafkaProducerFactory;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.core.ProducerFactory;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class KafkaConfig {
	
	// Provide a KafkaTemplate bean when autoconfiguration doesn't create one.
	// This builds a minimal producer factory using spring.kafka.bootstrap-servers and reasonable defaults.
	@Bean
	@ConditionalOnMissingBean(KafkaTemplate.class)
	public ProducerFactory<String, String> producerFactory(Environment env) {
		String bootstrap = env.getProperty("spring.kafka.bootstrap-servers", "localhost:9092");
		Map<String, Object> props = new HashMap<>();
		props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrap);
		props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
		props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
		// allow additional producer properties via spring.kafka.producer.* -> these will be picked up by auto-config
		// normally
		return new DefaultKafkaProducerFactory<>(props);
	}
	
	@Bean
	@ConditionalOnMissingBean(KafkaTemplate.class)
	public KafkaTemplate<String, String> kafkaTemplate(ProducerFactory<String, String> producerFactory) {
		return new KafkaTemplate<>(producerFactory);
	}
	
	// Provide a Jackson ObjectMapper bean if one is not present on the context. This helps when
	// other dependencies bring alternate Jackson versions and Spring Boot doesn't expose a
	// com.fasterxml.jackson.databind.ObjectMapper bean automatically.
	@Bean
	@ConditionalOnMissingBean(ObjectMapper.class)
	public ObjectMapper objectMapper() {
		return new ObjectMapper();
	}
	
}