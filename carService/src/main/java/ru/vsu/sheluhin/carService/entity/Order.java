package ru.vsu.sheluhin.carService.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Data
@Entity(name = "Orders")
@AllArgsConstructor
@NoArgsConstructor
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int orderId;

    @NotNull
    private LocalDateTime visitDate;

    @Enumerated(EnumType.STRING)
    private OrderType orderType;

    private int authUserId;

    private int unauthUserId;

    @NotNull
    private int masterId;

    @NotNull
    private int brandId;

    @NotNull
    private int modelId;

    public enum OrderType{
        REGISTRED, WORK, READY
    }
}
