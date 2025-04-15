package com.jw.app.controller

import com.jw.app.model.AuthRequest
import com.jw.app.model.UserDto
import com.jw.app.service.AuthService
import com.jw.app.service.LazyAuthService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import org.springframework.context.annotation.Lazy

@RestController
@RequestMapping("/api/auth")
class AuthController @Autowired constructor(
    private val authService: AuthService,
    @Lazy private val lazyAuthService: LazyAuthService
) {

    @GetMapping("/users")
    fun getUsers(): List<UserDto> {
        println("Received request to get all users. Using AuthService.")
        return lazyAuthService.getAllUsers()
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
