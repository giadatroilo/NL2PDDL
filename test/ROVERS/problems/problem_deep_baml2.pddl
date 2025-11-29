(define (problem mars-soil-sample-mission)
  (:domain mars-rover)

  (:objects
    Curiosity - rover
    LandingSite Crater - waypoint
    Lander - lander
    Store - tool
    soil_sample - soil-sample
    img1 - image
  )

  (:init
    (rover-at Curiosity LandingSite)
    (sample-at soil_sample Crater)
    (equipped-with-tool Curiosity Store)
    (= (storage-used Curiosity) 0)
  )

  (:goal
    (and
      (data-communicated img1 Lander)
    )
  )
)