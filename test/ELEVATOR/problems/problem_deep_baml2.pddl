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
    (destined-for PassengerA Floor2)
  )

  (:goal
    (and
      (passenger-at PassengerA Floor2)
    )
  )
)