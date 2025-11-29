(define (domain mprime-strips)
  (:requirements :strips :typing :negative-preconditions :fluents :numeric-fluents)

  (:types
    resource vehicle cargo location
    fuel space-resource - resource
  )

  (:predicates
    (at-location ?r - resource ?l - location)
    (vehicle-at ?v - vehicle ?l - location)
    (loaded ?c - cargo ?v - vehicle)
    (cargo-at ?c - cargo ?l - location)
  )

  (:functions
    (amount ?r - resource) - number
    (fuel-level ?v - vehicle) - number
    (size ?c - cargo) - number
  )

  (:action move-vehicle
    :parameters (?v - vehicle ?from - location ?to - location)
    :precondition (and
      (vehicle-at ?v ?from)
      (> (fuel-level ?v) 0)
    )
    :effect (and
      (not (vehicle-at ?v ?from))
      (vehicle-at ?v ?to)
      (decrease (fuel-level ?v) 1)
    )
  )

  (:action load-cargo
    :parameters (?v - vehicle ?c - cargo ?loc - location ?s - space-resource)
    :precondition (and
      (vehicle-at ?v ?loc)
      (cargo-at ?c ?loc)
      (not (loaded ?c ?v))
      (at-location ?s ?loc)
    )
    :effect (and
      (not (cargo-at ?c ?loc))
      (loaded ?c ?v)
      (increase (amount ?s) (size ?c))
    )
  )

  (:action unload-cargo
    :parameters (?v - vehicle ?c - cargo ?loc - location ?s - space-resource)
    :precondition (and
      (vehicle-at ?v ?loc)
      (loaded ?c ?v)
      (at-location ?s ?loc)
      (>= (amount ?s) (size ?c))
    )
    :effect (and
      (not (loaded ?c ?v))
      (cargo-at ?c ?loc)
      (decrease (amount ?s) (size ?c))
    )
  )

  (:action refuel-vehicle
    :parameters (?v - vehicle ?loc - location ?f - fuel)
    :precondition (and
      (vehicle-at ?v ?loc)
      (at-location ?f ?loc)
      (>= (amount ?f) 10)
      (<= (fuel-level ?v) 90)
    )
    :effect (and
      (increase (fuel-level ?v) 10)
      (decrease (amount ?f) 10)
    )
  )
)