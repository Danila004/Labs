package ru.vsu.sheluhin.carService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.vsu.sheluhin.carService.entity.AuthUser;

public interface AuthUserRepository extends JpaRepository<AuthUser, Integer> {

}
