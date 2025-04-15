package com.jw.app.service

import com.jw.app.entity.User
import com.jw.app.model.UserDto
import org.springframework.stereotype.Service

@Service
class AuthService {

    private val users = listOf(
        User("admin", "admin123", "ADMIN"),
        User("user", "user123", "USER")
    )

    fun authorize(username: String, password: String): Boolean {
        return users.any { it.username == username && it.password == password }
    }

    fun getAllUsers(): List<UserDto> {
        return users.map { UserDto(it.username, it.role) }
    }

    fun findUserByUsername(username: String): User? {
        return users.find { it.username == username }
    }
}
