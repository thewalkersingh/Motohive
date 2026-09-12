package com.motohive.userservice.init;

import com.motohive.userservice.entity.User;
import com.motohive.userservice.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Component
@RequiredArgsConstructor
public class StartupDataInitializer {
	
	private static final Logger log = LoggerFactory.getLogger(StartupDataInitializer.class);
	private final UserRepository userRepository;
	private final PasswordEncoder passwordEncoder;
	
	@EventListener(ApplicationReadyEvent.class)
	@Transactional
	public void onApplicationReady() {
		try {
			List<User> users = userRepository.findAll();
			int encoded = 0;
			for (User u : users) {
				String pwd = u.getPassword();
				if (pwd == null || pwd.isEmpty()) continue;
				// If password not already bcrypt encoded (bcrypt hashes start with $2a,$2b or $2y)
				if (!(pwd.startsWith("$2a$") || pwd.startsWith("$2b$") || pwd.startsWith("$2y$"))) {
					String hashed = passwordEncoder.encode(pwd);
					u.setPassword(hashed);
					userRepository.save(u);
					encoded++;
				}
			}
			if (encoded > 0) {
				log.info("Encoded {} plaintext user passwords on startup", encoded);
			}
		} catch (Exception e) {
			log.warn("StartupDataInitializer failed to encode passwords: {}", e.getMessage());
		}
	}
	
}