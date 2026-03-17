package ru.vsu.sheluhin.carService.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.vsu.sheluhin.carService.entity.Brand;

public interface BrandRepository extends JpaRepository<Brand, Integer> {
}
