(define (domain miconic)
  (:requirements :strips :typing :negative-preconditions :equality :fluents :numeric-fluents)

  (:types
    passenger
    vip - passenger
    attendant - passenger
    floor
    elevator
    conflict-group
    never-alone-group
  )

  (:predicates
    (passenger-at ?p - passenger ?f - floor)
    (destination ?p - passenger ?f - floor)
    (in-elevator ?p - passenger ?e - elevator)
    (served ?p - passenger)
    (in-conflict ?p1 - passenger ?p2 - passenger)
    (must-be-escorted ?p - passenger)
    (above ?f1 - floor ?f2 - floor)
    (elevator-at ?e - elevator ?f - floor)
    (doors-open ?e - elevator)
    (conflict-group-active ?cg - conflict-group)
    (in-conflict-group ?p - passenger ?cg - conflict-group)
    (never-alone-group-active ?nag - never-alone-group)
    (in-never-alone-group ?p - passenger ?nag - never-alone-group)
    (floor-has-call ?f - floor)
  )

  (:functions
    (floor-number ?f - floor) - number
    (load ?e - elevator) - number
  )

  (:action move-elevator
    :parameters (?e - elevator ?from - floor ?to - floor)
    :precondition (and
      (elevator-at ?e ?from)
      (not (doors-open ?e))
    )
    :effect (and
      (not (elevator-at ?e ?from))
      (elevator-at ?e ?to)
    )
  )

  (:action open-door
    :parameters (?e - elevator ?f - floor)
    :precondition (and
      (elevator-at ?e ?f)
      (not (doors-open ?e))
    )
    :effect (doors-open ?e)
  )

  (:action close-door
    :parameters (?e - elevator ?f - floor)
    :precondition (and
      (elevator-at ?e ?f)
      (doors-open ?e)
    )
    :effect (not (doors-open ?e))
  )

  (:action board-passenger
    :parameters (?p - passenger ?e - elevator ?f - floor)
    :precondition (and
      (passenger-at ?p ?f)
      (elevator-at ?e ?f)
      (doors-open ?e)
    )
    :effect (and
      (not (passenger-at ?p ?f))
      (in-elevator ?p ?e)
      (increase (load ?e) 1)
    )
  )

  (:action alight-passenger
    :parameters (?p - passenger ?e - elevator ?f - floor)
    :precondition (and
      (in-elevator ?p ?e)
      (elevator-at ?e ?f)
      (doors-open ?e)
      (destination ?p ?f)
    )
    :effect (and
      (not (in-elevator ?p ?e))
      (passenger-at ?p ?f)
      (served ?p)
      (decrease (load ?e) 1)
    )
  )

  (:action board-vip-passenger
    :parameters (?v - vip ?e - elevator ?f - floor)
    :precondition (and
      (passenger-at ?v ?f)
      (elevator-at ?e ?f)
      (doors-open ?e)
    )
    :effect (and
      (not (passenger-at ?v ?f))
      (in-elevator ?v ?e)
      (increase (load ?e) 1)
    )
  )

  (:action alight-vip-passenger
    :parameters (?v - vip ?e - elevator ?f - floor)
    :precondition (and
      (in-elevator ?v ?e)
      (elevator-at ?e ?f)
      (doors-open ?e)
      (destination ?v ?f)
    )
    :effect (and
      (not (in-elevator ?v ?e))
      (passenger-at ?v ?f)
      (served ?v)
      (decrease (load ?e) 1)
    )
  )

  (:action board-attendant-passenger
    :parameters (?a - attendant ?e - elevator ?f - floor)
    :precondition (and
      (passenger-at ?a ?f)
      (elevator-at ?e ?f)
      (doors-open ?e)
    )
    :effect (and
      (not (passenger-at ?a ?f))
      (in-elevator ?a ?e)
      (increase (load ?e) 1)
    )
  )

  (:action alight-attendant-passenger
    :parameters (?a - attendant ?e - elevator ?f - floor)
    :precondition (and
      (in-elevator ?a ?e)
      (elevator-at ?e ?f)
      (doors-open ?e)
      (destination ?a ?f)
    )
    :effect (and
      (not (in-elevator ?a ?e))
      (passenger-at ?a ?f)
      (served ?a)
      (decrease (load ?e) 1)
    )
  )

  (:action activate-conflict-group
    :parameters (?cg - conflict-group ?p - passenger ?e - elevator)
    :precondition (and
      (in-conflict-group ?p ?cg)
      (in-elevator ?p ?e)
      (not (conflict-group-active ?cg))
    )
    :effect (conflict-group-active ?cg)
  )

  (:action deactivate-conflict-group
    :parameters (?cg - conflict-group)
    :precondition (conflict-group-active ?cg)
    :effect (not (conflict-group-active ?cg))
  )

  (:action activate-never-alone-group
    :parameters (?nag - never-alone-group ?p - passenger ?e - elevator)
    :precondition (and
      (in-never-alone-group ?p ?nag)
      (in-elevator ?p ?e)
      (not (never-alone-group-active ?nag))
    )
    :effect (never-alone-group-active ?nag)
  )

  (:action deactivate-never-alone-group
    :parameters (?nag - never-alone-group)
    :precondition (never-alone-group-active ?nag)
    :effect (not (never-alone-group-active ?nag))
  )

  (:action call-elevator
    :parameters (?p - passenger ?f - floor)
    :precondition (and
      (passenger-at ?p ?f)
      (not (floor-has-call ?f))
    )
    :effect (floor-has-call ?f)
  )

  (:action clear-elevator-call
    :parameters (?f - floor)
    :precondition (floor-has-call ?f)
    :effect (not (floor-has-call ?f))
  )
)
