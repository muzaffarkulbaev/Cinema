package com.example.examproject.service;

import com.example.examproject.entity.Hall;
import com.example.examproject.entity.Seat;

import java.util.Iterator;
import java.util.List;
import java.util.Objects;

public class SeatService extends TemplateService<Seat>{
    public List<Seat> findSeatsByHall(Hall hall) {
        List<Seat> all = getAll(Seat.class);
        Iterator<Seat> iterator = all.iterator();
        while (iterator.hasNext()) {
            Seat seat = iterator.next();
//            System.out.println(seat.getHall().getId() + " - " + hall.getId());
            if (!Objects.equals(seat.getHall().getId(), hall.getId())) {
                iterator.remove();
            }
        }
        return all;
    }


    public void changeStateToBooked(int seatId) {
        Seat seatById = getById(Seat.class, seatId);
        if (seatById.getIsBooked()) throw new RuntimeException("Already booked");
        seatById.setIsBooked(true);
        save(seatById);
    }
}
