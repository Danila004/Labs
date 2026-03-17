package ru.vsu.sheluhin.carService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.vsu.sheluhin.carService.entity.Service;
import ru.vsu.sheluhin.carService.entity.UnauthUser;

public interface ServiceRepository extends JpaRepository<Service, Integer> {
}
