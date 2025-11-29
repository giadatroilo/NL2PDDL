(define (problem scan-two-cars)
  (:domain scanalyzer3d)

  (:objects
    Car-A Car-B - car
    Seg1 Seg2 Seg3 Seg4 - segment
  )

  (:init
    (car-at-segment Car-A Seg1)
    (car-at-segment Car-B Seg2)
    (segment-occupied Seg1)
    (segment-occupied Seg2)
    (not (segment-occupied Seg3))
    (not (segment-occupied Seg4))
    (not (analyzed Car-A))
    (not (analyzed Car-B))
  )

  (:goal
    (and
      (analyzed Car-A)
      (analyzed Car-B)
    )
  )
)