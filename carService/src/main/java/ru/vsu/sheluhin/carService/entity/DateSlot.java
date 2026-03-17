package ru.vsu.sheluhin.carService.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Data
@Entity(name = "DateSlots")
@AllArgsConstructor
@NoArgsConstructor
public class DateSlot {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int slotId;

    @NotNull
    private LocalDateTime visitDate;

    private int authUserId;

    private int unauthUserId;

    @NotNull
    private int masterId;
}
