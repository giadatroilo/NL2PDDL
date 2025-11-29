(define (domain grid-robot)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    robot place key door
  )

  (:predicates
    (robot-at ?r - robot ?p - place)
    (robot-has-key ?r - robot ?k - key)
    (key-at ?k - key ?p - place)
    (key-fits ?k - key ?d - door)
    (locked ?d - door)
  )

  (:action move
    :parameters (?r - robot ?from - place ?to - place)
    :precondition (and
      (robot-at ?r ?from)
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
    )
  )

  (:action pickup
    :parameters (?r - robot ?k - key ?p - place)
    :precondition (and
      (robot-at ?r ?p)
      (key-at ?k ?p)
      (not (robot-has-key ?r ?k))
    )
    :effect (and
      (not (key-at ?k ?p))
      (robot-has-key ?r ?k)
    )
  )

  (:action drop
    :parameters (?r - robot ?k - key ?p - place)
    :precondition (and
      (robot-at ?r ?p)
      (robot-has-key ?r ?k)
    )
    :effect (and
      (not (robot-has-key ?r ?k))
      (key-at ?k ?p)
    )
  )

  (:action unlock
    :parameters (?r - robot ?k - key ?d - door)
    :precondition (and
      (robot-has-key ?r ?k)
      (key-fits ?k ?d)
      (locked ?d)
    )
    :effect (and
      (not (locked ?d))
    )
  )
)