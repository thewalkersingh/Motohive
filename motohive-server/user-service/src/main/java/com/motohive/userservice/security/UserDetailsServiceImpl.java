package com.motohive.userservice.security;

import com.motohive.userservice.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {
	
	private final UserRepository userRepository;
	
	@NonNull
	@Override
	public UserDetails loadUserByUsername(@NonNull String email) throws UsernameNotFoundException {
		return userRepository.findByEmail(email)
		                     .map(user ->
											  new User(user.getEmail(), user.getPassword(),
												  user.getRoles()
				                              .stream()
				                              .map(role -> new SimpleGrantedAuthority("ROLE_" + role.name()))
				                              .collect(Collectors.toList())
											  ))
		                     .orElseThrow(() -> new UsernameNotFoundException("User not found: " + email));
	}
	
}