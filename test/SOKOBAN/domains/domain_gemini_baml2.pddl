(define (domain sokoban)
  (:requirements :strips :typing :negative-preconditions :equality)

  (:types
    robot
    box
    location
    direction
    goal - location
  )

  (:predicates
    (robot-at ?r - robot ?l - location)
    (box-at ?b - box ?l - location)
    (is-clear ?l - location)
    (move-dir ?from - location ?to - location ?dir - direction)
  )

  (:action move
    :parameters (?r - robot ?from - location ?to - location ?dir - direction)
    :precondition (and
      (robot-at ?r ?from)
      (is-clear ?to)
      (move-dir ?from ?to ?dir)
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
      (is-clear ?from)
      (not (is-clear ?to))
    )
  )

  (:action push
    :parameters (?r - robot ?b - box ?r-loc - location ?b-loc - location ?to-loc - location ?dir - direction)
    :precondition (and
      (robot-at ?r ?r-loc)
      (box-at ?b ?b-loc)
      (is-clear ?to-loc)
      (move-dir ?r-loc ?b-loc ?dir)
      (move-dir ?b-loc ?to-loc ?dir)
    )
    :effect (and
      (not (robot-at ?r ?r-loc))
      (robot-at ?r ?b-loc)
      (not (box-at ?b ?b-loc))
      (box-at ?b ?to-loc)
      (is-clear ?r-loc)
      (not (is-clear ?to-loc))
    )
  )
)
