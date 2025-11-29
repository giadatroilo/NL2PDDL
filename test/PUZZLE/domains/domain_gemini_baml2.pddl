(define (domain n-puzzle)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    tile
    location
  )

  (:predicates
    (tile-at ?t - tile ?l - location)
    (is-blank ?t - tile)
    (adjacent ?l1 - location ?l2 - location)
  )

  (:action move
    :parameters (?tile - tile ?blank - tile ?from - location ?to - location)
    :precondition (and
      (tile-at ?tile ?from)
      (tile-at ?blank ?to)
      (is-blank ?blank)
      (not (is-blank ?tile))
      (adjacent ?from ?to)
    )
    :effect (and
      (not (tile-at ?tile ?from))
      (tile-at ?tile ?to)
      (not (tile-at ?blank ?to))
      (tile-at ?blank ?from)
    )
  )
)