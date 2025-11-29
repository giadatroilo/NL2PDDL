(define (domain sokoban)
  (:requirements :strips :typing :negative-preconditions :equality)

  (:types
    robot
    box
    location
    direction
  )

  (:predicates
    (robot-at ?r - robot ?l - location)
    (facing-direction ?r - robot ?d - direction)
    (pushing-box ?r - robot ?b - box)
    (box-at ?b - box ?l - location)
    (at-goal-location ?b - box ?l - location)
    (is-goal-location ?l - location)
    (is-accessible ?l - location)
  )

  (:action move
    :parameters (?r - robot ?from - location ?to - location ?d - direction)
    :precondition (and
      (robot-at ?r ?from)
      (is-accessible ?to)
      (facing-direction ?r ?d)
      (not (exists (?b - box) (box-at ?b ?to)))
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
    )
  )

  (:action turn
    :parameters (?r - robot ?old-d - direction ?new-d - direction)
    :precondition (facing-direction ?r ?old-d)
    :effect (and
      (not (facing-direction ?r ?old-d))
      (facing-direction ?r ?new-d)
    )
  )

  (:action push-box
    :parameters (?r - robot ?b - box ?from - location ?to - location ?d - direction)
    :precondition (and
      (robot-at ?r ?from)
      (box-at ?b ?from)
      (is-accessible ?to)
      (facing-direction ?r ?d)
      (not (exists (?b2 - box) (and (not (= ?b2 ?b)) (box-at ?b2 ?to))))
    )
    :effect (and
      (not (box-at ?b ?from))
      (box-at ?b ?to)
      (not (robot-at ?r ?from))
      (robot-at ?r ?from)
      (pushing-box ?r ?b)
    )
  )

  (:action stop-pushing
    :parameters (?r - robot ?b - box)
    :precondition (pushing-box ?r ?b)
    :effect (and
      (not (pushing-box ?r ?b))
    )
  )

  (:action place-box-at-goal
    :parameters (?r - robot ?b - box ?l - location)
    :precondition (and
      (box-at ?b ?l)
      (is-goal-location ?l)
    )
    :effect (and
      (at-goal-location ?b ?l)
    )
  )
)
