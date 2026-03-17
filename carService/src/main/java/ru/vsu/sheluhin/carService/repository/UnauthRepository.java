package ru.vsu.sheluhin.carService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.vsu.sheluhin.carService.entity.UnauthUser;

public interface UnauthRepository extends JpaRepository<UnauthUser, Integer> {
}
