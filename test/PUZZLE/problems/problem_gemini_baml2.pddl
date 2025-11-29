(define (problem solve-2x2-puzzle)
  (:domain npuzzle)

  (:objects
    T1 T2 T3 - tile
    P1 P2 P3 P4 - location
  )

  (:init
    (tile-at T3 P2)
    (tile-at T2 P1)
    (tile-at T1 P3)
    (is-blank P4)
    
    ; Grid adjacencies
    (adjacent P1 P2)
    (adjacent P2 P1)
    (adjacent P3 P4)
    (adjacent P4 P3)
    (adjacent P1 P3)
    (adjacent P3 P1)
    (adjacent P2 P4)
    (adjacent P4 P2)
  )

  (:goal
    (and
      (tile-at T1 P1)
      (tile-at T2 P2)
      (tile-at T3 P3)
      (is-blank P4)
    )
  )
)