// delete this class as it is for DEV profile
package com.motohive.paymentservice.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@Profile("dev")
public class MvcConfig implements WebMvcConfigurer {
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// tell Spring MVC to NOT handle /h2-console
		// so the H2 servlet can intercept it instead
		registry.addResourceHandler("/h2-console/**")
				.addResourceLocations("classpath:/h2-console/");
	}
	
}