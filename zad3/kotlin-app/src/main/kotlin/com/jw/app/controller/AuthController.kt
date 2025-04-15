package com.jw.app.controller

import com.jw.app.model.AuthRequest
import com.jw.app.model.UserDto
import com.jw.app.service.AuthService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api/auth")
class AuthController @Autowired constructor(
    private val authService: AuthService
) {

    @GetMapping("/users")
    fun getUsers(): List<UserDto> {
        return authService.getAllUsers()
    }

    @PostMapping("/login")
    fun login(@RequestBody request: AuthRequest): Map<String, Any> {
        val isAuthorized = authService.authorize(request.username, request.password)
        val role = authService.findUserByUsername(request.username)?.role ?: "UNKNOWN"

        return mapOf(
            "authorized" to isAuthorized,
            "user" to request.username,
            "role" to role
        )
    }
}
