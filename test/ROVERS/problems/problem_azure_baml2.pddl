(define (problem soil-sample-communication)
  (:domain mars-rover)

  (:objects
    Curiosity - rover
    LandingSite Crater - waypoint
    Lander - lander
    Store - storage
    SoilSample - soil-sample
    data - data
  )

  (:init
    (rover-at Curiosity LandingSite)
    (storage-on-rover Store Curiosity)
    (= (storage-used Curiosity) 0)
    (sample-at-waypoint SoilSample Crater)
    (not (data-on-rover data Curiosity))
    (not (data-at-lander data Lander))
    (lander-at Lander LandingSite)
    ; Assumed: connectivity and visibility are handled in the domain or map, not as predicates here
  )

  (:goal
    (and
      (data-at-lander data Lander)
    )
  )
)