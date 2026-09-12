package com.motohive.paymentservice.config;
// delete this class as it is for DEV profile
import org.h2.server.web.JakartaWebServlet;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
	// ── Register H2 Console Servlet manually ─────────
	@Bean
	@Profile("dev")
	public ServletRegistrationBean<JakartaWebServlet> h2ConsoleServlet() {
		ServletRegistrationBean<JakartaWebServlet> bean =
				new ServletRegistrationBean<>(new JakartaWebServlet(), "/h2-console/*");
		bean.addInitParameter("webAllowOthers", "true");
		bean.addInitParameter("trace", "false");
		bean.setLoadOnStartup(1);
		return bean;
	}
	
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http
				.csrf(AbstractHttpConfigurer::disable)
				.authorizeHttpRequests(
						auth -> auth
								        // ── H2 Console ──────────────────────────
								        .requestMatchers("/h2-console/**").permitAll()
								        
								        // ── Swagger ─────────────────────────────
								        .requestMatchers(
										        "/swagger-ui/**",
										        "/swagger-ui.html",
										        "/v3/api-docs/**"
								        ).permitAll()
								        
								        // ── Payment APIs (open for now) ──────────
								        .requestMatchers("/api/v1/payments/**").permitAll()
								        
								        .anyRequest().authenticated()
				)
				
				// ── Required for H2 console frames ───────────
				.headers(
						headers -> headers.frameOptions(HeadersConfigurer.FrameOptionsConfig::disable))
				
				.sessionManagement(
						session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS));
		
		return http.build();
	}
	
}