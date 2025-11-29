(define (domain gold-mining)
  (:requirements :strips :typing :negative-preconditions :equality)

  (:types
    robot
    location
    object
    tool - object
    bomb - tool
    laser - tool
    gold - object
    obstacle - object
    soft-rock - obstacle
    hard-rock - obstacle
    arm
  )

  (:predicates
    (robot-at ?r - robot ?l - location)
    (arm-empty ?r - robot)
    (holding-object ?r - robot ?o - object)
    (connected ?l1 - location ?l2 - location)
    (location-clear ?l - location)
    (object-at ?o - object ?l - location)
    (obstacle-at ?ob - obstacle ?l - location)
    (tool-at ?t - tool ?l - location)
    (held-by-robot ?t - tool ?r - robot)
    (bomb-at ?b - bomb ?l - location)
    (laser-at ?l - laser ?loc - location)
    (gold-at ?g - gold ?l - location)
    (held-by-robot ?g - gold ?r - robot)
    (collected ?g - gold)
    (destroyed ?ob - obstacle)
    (soft-rock-at ?sr - soft-rock ?l - location)
    (hard-rock-at ?hr - hard-rock ?l - location)
  )

  (:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and
      (robot-at ?r ?from)
      (connected ?from ?to)
      (location-clear ?to)
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
    )
  )

  (:action pickup-object
    :parameters (?r - robot ?o - object ?l - location)
    :precondition (and
      (robot-at ?r ?l)
      (object-at ?o ?l)
      (arm-empty ?r)
    )
    :effect (and
      (not (object-at ?o ?l))
      (holding-object ?r ?o)
      (not (arm-empty ?r))
    )
  )

  (:action putdown-object
    :parameters (?r - robot ?o - object ?l - location)
    :precondition (and
      (robot-at ?r ?l)
      (holding-object ?r ?o)
    )
    :effect (and
      (object-at ?o ?l)
      (not (holding-object ?r ?o))
      (arm-empty ?r)
    )
  )

  (:action pickup-tool
    :parameters (?r - robot ?t - tool ?l - location)
    :precondition (and
      (robot-at ?r ?l)
      (tool-at ?t ?l)
      (arm-empty ?r)
    )
    :effect (and
      (not (tool-at ?t ?l))
      (held-by-robot ?t ?r)
      (holding-object ?r ?t)
      (not (arm-empty ?r))
    )
  )

  (:action putdown-tool
    :parameters (?r - robot ?t - tool ?l - location)
    :precondition (and
      (robot-at ?r ?l)
      (held-by-robot ?t ?r)
    )
    :effect (and
      (tool-at ?t ?l)
      (not (held-by-robot ?t ?r))
      (not (holding-object ?r ?t))
      (arm-empty ?r)
    )
  )

  (:action pickup-gold
    :parameters (?r - robot ?g - gold ?l - location)
    :precondition (and
      (robot-at ?r ?l)
      (gold-at ?g ?l)
      (arm-empty ?r)
    )
    :effect (and
      (not (gold-at ?g ?l))
      (held-by-robot ?g ?r)
      (holding-object ?r ?g)
      (not (arm-empty ?r))
      (collected ?g)
    )
  )

  (:action putdown-gold
    :parameters (?r - robot ?g - gold ?l - location)
    :precondition (and
      (robot-at ?r ?l)
      (held-by-robot ?g ?r)
    )
    :effect (and
      (gold-at ?g ?l)
      (not (held-by-robot ?g ?r))
      (not (holding-object ?r ?g))
      (arm-empty ?r)
    )
  )

  (:action detonate-bomb
    :parameters (?r - robot ?b - bomb ?from - location ?to - location ?sr - soft-rock)
    :precondition (and
      (robot-at ?r ?from)
      (held-by-robot ?b ?r)
      (connected ?from ?to)
      (soft-rock-at ?sr ?to)
    )
    :effect (and
      (not (soft-rock-at ?sr ?to))
      (not (obstacle-at ?sr ?to))
      (destroyed ?sr)
      (not (held-by-robot ?b ?r))
      (not (holding-object ?r ?b))
      (arm-empty ?r)
      (location-clear ?to)
    )
  )

  (:action fire-laser
    :parameters (?r - robot ?l - laser ?from - location ?to - location ?hr - hard-rock)
    :precondition (and
      (robot-at ?r ?from)
      (held-by-robot ?l ?r)
      (connected ?from ?to)
      (hard-rock-at ?hr ?to)
    )
    :effect (and
      (not (hard-rock-at ?hr ?to))
      (not (obstacle-at ?hr ?to))
      (destroyed ?hr)
      (location-clear ?to)
    )
  )
)
