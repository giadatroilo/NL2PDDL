(define (problem robot-door-task)
  (:domain grid-robot)

  (:objects
    R1 - robot
    RoomA RoomB - place
    Door1 - door
    KeyQ - key
  )

  (:init
    (robot-at R1 RoomA)
    (key-at KeyQ RoomA)
    (key-fits KeyQ Door1)
    (locked Door1)
  )

  (:goal
    (and
      (robot-at R1 RoomB)
    )
  )
)