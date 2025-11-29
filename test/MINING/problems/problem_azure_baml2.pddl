(define (problem mine-gold-collection)
  (:domain gold-mining)

  (:objects
    Robot - robot
    Base Toolshed GoldVein - location
    Bomb - bomb
    SoftRock - soft-rock
    Gold - gold
  )

  (:init
    (robot-at Robot Base)
    (arm-empty Robot)
    (bomb-at Bomb Toolshed)
    (soft-rock-at SoftRock GoldVein)
    (gold-at Gold GoldVein)
    (location-clear Base)
    (location-clear Toolshed)
    (connected Base Toolshed)
    (connected Toolshed Base)
    (connected Toolshed GoldVein)
    (connected GoldVein Toolshed)
  )

  (:goal
    (and
      (holding-object Robot Gold)
    )
  )
)