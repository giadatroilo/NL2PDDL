(define (domain robot-waiter)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    robot area plate food customer
    buffet - area
  )

  (:predicates
    (robot-at ?r - robot ?a - area)
    (holding-plate ?r - robot ?p - plate)
    (adjacent ?a1 - area ?a2 - area)
    (plate-at ?p - plate ?a - area)
    (has-food ?p - plate ?f - food)
    (served ?c - customer)
  )

  (:action move
    :parameters (?r - robot ?from - area ?to - area)
    :precondition (and
      (robot-at ?r ?from)
      (adjacent ?from ?to)
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
    )
  )

  (:action pick-up-plate
    :parameters (?r - robot ?p - plate ?a - area)
    :precondition (and
      (robot-at ?r ?a)
      (plate-at ?p ?a)
      (not (holding-plate ?r ?p))
    )
    :effect (and
      (not (plate-at ?p ?a))
      (holding-plate ?r ?p)
    )
  )

  (:action fill-plate
    :parameters (?r - robot ?b - buffet ?p - plate ?f - food)
    :precondition (and
      (robot-at ?r ?b)
      (holding-plate ?r ?p)
    )
    :effect (and
      (has-food ?p ?f)
    )
  )

  (:action serve-customer
    :parameters (?r - robot ?p - plate ?f - food ?c - customer ?a - area)
    :precondition (and
      (holding-plate ?r ?p)
      (has-food ?p ?f)
      (not (served ?c))
      (robot-at ?r ?a)
    )
    :effect (and
      (not (holding-plate ?r ?p))
      (served ?c)
      (not (has-food ?p ?f))
      (plate-at ?p ?a)
    )
  )
)