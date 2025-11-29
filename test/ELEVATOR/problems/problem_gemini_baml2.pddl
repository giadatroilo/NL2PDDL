(define (problem transport-passenger-a)
  (:domain miconic)

  (:objects
    Floor0 Floor1 Floor2 - floor
    Elevator1 - elevator
    PassengerA - passenger
  )

  (:init
    (elevator-at Elevator1 Floor0)
    (passenger-at PassengerA Floor0)
    (destination PassengerA Floor2)
    (above Floor1 Floor0)
    (above Floor2 Floor1)
    (= (load Elevator1) 0)
    (= (floor-number Floor0) 0)
    (= (floor-number Floor1) 1)
    (= (floor-number Floor2) 2)
  )

  (:goal
    (and
      (served PassengerA)
    )
  )
)