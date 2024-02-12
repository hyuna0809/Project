package kr.co.evcharger.member.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
        http
                .authorizeRequests(authorizeRequests ->
                        authorizeRequests
                                .antMatchers("/css/**", "/js/**", "/img/**", "member/save", "/member/update", "/member/save").permitAll()
                                .antMatchers("/home", "/about", "/charging", "/products", "/faq", "/board", "/login", "/logout", "/mypage").permitAll()
                                .antMatchers("/product", "/connector", "/goods", "/cover","/cart","/connector", "/updateCart","/shippingInfo","/processShippingInfo", "/orderConfirmation", "/checkOutCancelled", "/thankCustomer", "exceptionNoProductId.jsp").permitAll()
                                .antMatchers("/paging","/board/{id}", "/board/save", "/board/update/{id}", "/board/delete/{id}", "/member/", "/home_charging").permitAll()
                                .antMatchers("/admin").hasRole("ADMIN")
                                .anyRequest().authenticated()
                )

                .formLogin(formLogin ->
                        formLogin
                                .loginPage("/member/login")
                                .loginProcessingUrl("/member/loginProc")
                                .permitAll()
                )
                .logout(logout ->
                        logout
                                .logoutUrl("/logout")
                                .logoutSuccessUrl("/home")
                )
                .csrf().disable()
                .sessionManagement(sessionManagement ->
                        sessionManagement
                                .maximumSessions(1)
                                .maxSessionsPreventsLogin(true)
                );
//        http
//                .sessionManagement((auth)->auth
//                        .sessionFixation().none() 로그인시 세션정보 변경 안함
//                        .sessionFixation().newSession() 로그인시 세션 새로 생성
//                        .sessionFixation().changeSessionId() 로그인 시 동일한 세션에 대한 id변경
//                );
        return http.build();
    }
//    @Bean
//    public AuthenticationManager authenticationManagerBean() throws Exception{
//        return authenticationManagerBean();
//    }
}
