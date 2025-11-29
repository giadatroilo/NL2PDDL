(define (domain gridkeylock)
  (:requirements :strips :typing)

  (:types
    robot - agent
    agent
    place
    key
    shape
    door
    lock
  )

  (:predicates
    (at-location ?r - robot ?p - place)
    (carrying-key ?r - robot ?k - key)
    (can-unlock ?r - robot ?d - door)
    (is-robot ?a - agent)
    (is-accessible ?p - place)
    (at-place ?k - key ?p - place)
    (has-shape ?k - key ?s - shape)
    (is-key-shape ?s - shape)
    (at-place ?d - door ?p - place)
    (is-unlocked ?d - door)
    (has-shape ?l - lock ?s - shape)
    (is-locked ?l - lock)
  )

  (:action move
    :parameters (?r - robot ?from - place ?to - place)
    :precondition (and (at-location ?r ?from) (is-accessible ?to))
    :effect (and (not (at-location ?r ?from)) (at-location ?r ?to))
  )

  (:action pick-up-key
    :parameters (?r - robot ?k - key ?p - place)
    :precondition (and (at-location ?r ?p) (at-place ?k ?p) (not (carrying-key ?r ?k)))
    :effect (and (carrying-key ?r ?k) (not (at-place ?k ?p)))
  )

  (:action drop-key
    :parameters (?r - robot ?k - key ?p - place)
    :precondition (and (at-location ?r ?p) (carrying-key ?r ?k))
    :effect (and (not (carrying-key ?r ?k)) (at-place ?k ?p))
  )

  (:action unlock-door
    :parameters (?r - robot ?d - door ?l - lock ?k - key ?s - shape ?p - place)
    :precondition (and (at-location ?r ?p) (at-place ?d ?p) (carrying-key ?r ?k) (has-shape ?k ?s) (has-shape ?l ?s) (is-locked ?l) (can-unlock ?r ?d))
    :effect (and (is-unlocked ?d) (not (is-locked ?l)))
  )

  (:action lock-door
    :parameters (?d - door ?l - lock)
    :precondition (and (is-unlocked ?d) (not (is-locked ?l)))
    :effect (and (not (is-unlocked ?d)) (is-locked ?l))
  )
)