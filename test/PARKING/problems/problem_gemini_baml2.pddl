(define (problem unblock-car-a)
  (:domain parking)

  (:objects
    CarA CarB - car
    Curb1 Curb2 - curb
  )

  (:init
    (at-curb CarA Curb1)
    (parked-behind CarB CarA)
    (unblocked CarB)
    (curb-free Curb2)
  )

  (:goal
    (and
      (at-curb CarA Curb2)
    )
  )
)