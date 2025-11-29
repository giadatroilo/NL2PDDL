(define (domain paint-robots)
  (:requirements :strips :typing :negative-preconditions :fluents :numeric-fluents :equality)

  (:types
    robot
    tile
    color
    direction
    action
    grid
  )

  (:predicates
    (robot-at-tile ?r - robot ?t - tile)
    (robot-facing-direction ?r - robot ?d - direction)
    (robot-has-color ?r - robot ?c - color)
    (tile-painted-color ?t - tile ?c - color)
    (tile-in-grid ?t - tile ?g - grid)
  )

  (:functions
    (action-cost) - number
  )

  (:action move
    :parameters (?r - robot ?from - tile ?to - tile ?d - direction ?g - grid ?move-cost - action)
    :precondition (and
      (robot-at-tile ?r ?from)
      (robot-facing-direction ?r ?d)
      (tile-in-grid ?from ?g)
      (tile-in-grid ?to ?g)
      (not (robot-at-tile ?r ?to))
    )
    :effect (and
      (not (robot-at-tile ?r ?from))
      (robot-at-tile ?r ?to)
      (increase (action-cost) 1)
    )
  )

  (:action turn
    :parameters (?r - robot ?from-dir - direction ?to-dir - direction ?turn-cost - action)
    :precondition (and
      (robot-facing-direction ?r ?from-dir)
      (not (robot-facing-direction ?r ?to-dir))
    )
    :effect (and
      (not (robot-facing-direction ?r ?from-dir))
      (robot-facing-direction ?r ?to-dir)
      (increase (action-cost) 1)
    )
  )

  (:action change-color
    :parameters (?r - robot ?from-color - color ?to-color - color ?color-cost - action)
    :precondition (and
      (robot-has-color ?r ?from-color)
      (not (robot-has-color ?r ?to-color))
    )
    :effect (and
      (not (robot-has-color ?r ?from-color))
      (robot-has-color ?r ?to-color)
      (increase (action-cost) 1)
    )
  )

  (:action paint-tile
    :parameters (?r - robot ?t - tile ?c - color ?g - grid ?paint-cost - action)
    :precondition (and
      (robot-at-tile ?r ?t)
      (robot-has-color ?r ?c)
      (tile-in-grid ?t ?g)
    )
    :effect (and
      (tile-painted-color ?t ?c)
      (increase (action-cost) 1)
    )
  )

  (:action paint-adjacent-tile
    :parameters (?r - robot ?from - tile ?adj - tile ?d - direction ?c - color ?g - grid ?paint-cost - action)
    :precondition (and
      (robot-at-tile ?r ?from)
      (robot-facing-direction ?r ?d)
      (robot-has-color ?r ?c)
      (tile-in-grid ?from ?g)
      (tile-in-grid ?adj ?g)
    )
    :effect (and
      (tile-painted-color ?adj ?c)
      (increase (action-cost) 1)
    )
  )

  (:action erase-tile
    :parameters (?r - robot ?t - tile ?c - color ?g - grid ?erase-cost - action)
    :precondition (and
      (robot-at-tile ?r ?t)
      (tile-painted-color ?t ?c)
      (tile-in-grid ?t ?g)
    )
    :effect (and
      (not (tile-painted-color ?t ?c))
      (increase (action-cost) 1)
    )
  )

  (:action erase-adjacent-tile
    :parameters (?r - robot ?from - tile ?adj - tile ?d - direction ?c - color ?g - grid ?erase-cost - action)
    :precondition (and
      (robot-at-tile ?r ?from)
      (robot-facing-direction ?r ?d)
      (tile-painted-color ?adj ?c)
      (tile-in-grid ?from ?g)
      (tile-in-grid ?adj ?g)
    )
    :effect (and
      (not (tile-painted-color ?adj ?c))
      (increase (action-cost) 1)
    )
  )
)
