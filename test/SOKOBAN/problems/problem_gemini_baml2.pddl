(define (problem sokoban-hallway-task)
  (:domain sokoban)

  (:objects
    Wall-E - robot
    Box1 - box
    Tile1 Tile2 - location
    Tile3 - goal
    Right - direction
  )

  (:init
    (robot-at Wall-E Tile1)
    (box-at Box1 Tile2)
    (is-clear Tile3)
    (move-dir Tile1 Tile2 Right)
    (move-dir Tile2 Tile3 Right)
  )

  (:goal
    (and
      (box-at Box1 Tile3)
    )
  )
)