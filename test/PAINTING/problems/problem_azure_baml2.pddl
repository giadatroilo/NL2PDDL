(define (problem two-tile-paint-pattern)
  (:domain paint-robots)

  (:objects
    PainterBot - robot
    Tile1 Tile2 - tile
    Black White - color
    Grid1 - grid
    North South East West - direction
    MoveAction TurnAction PaintAction - action
  )

  (:init
    (robot-at-tile PainterBot Tile1)
    (robot-has-color PainterBot Black)
    (tile-in-grid Tile1 Grid1)
    (tile-in-grid Tile2 Grid1)
    (= (action-cost) 0)
  )

  (:goal
    (and
      (tile-painted-color Tile1 Black)
      (tile-painted-color Tile2 White)
    )
  )
)