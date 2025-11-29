(define (problem push-box-to-goal)
  (:domain sokoban)

  (:objects
    Wall-E - robot
    Box1 - box
    Tile1 Tile2 Tile3 - location
    Right - direction
  )

  (:init
    (robot-at Wall-E Tile1)
    (box-at Box1 Tile2)
    (is-accessible Tile3)
    (facing-direction Wall-E Right)
    (is-goal-location Tile3)
  )

  (:goal
    (and
      (box-at Box1 Tile3)
      (at-goal-location Box1 Tile3)
    )
  )
)