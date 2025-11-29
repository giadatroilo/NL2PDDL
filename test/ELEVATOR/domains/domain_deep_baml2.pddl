(define (domain miconic)
  (:requirements :adl :typing :negative-preconditions :equality :conditional-effects :universal-preconditions :existential-preconditions)

  (:types
    elevator passenger floor
    vip - passenger
    attendant - passenger
  )

  (:predicates
    (elevator-at ?e - elevator ?f - floor)
    (passenger-at ?p - passenger ?f - floor)
    (in-elevator ?p - passenger ?e - elevator)
    (destined-for ?p - passenger ?f - floor)
    (never-alone ?p - passenger)
    (conflicts-with ?p1 - passenger ?p2 - passenger)
  )

  (:action move
    :parameters (?e - elevator ?from - floor ?to - floor)
    :precondition (and
      (elevator-at ?e ?from)
    )
    :effect (and
      (not (elevator-at ?e ?from))
      (elevator-at ?e ?to)
    )
  )

  (:action board
    :parameters (?p - passenger ?e - elevator ?f - floor)
    :precondition (and
      (passenger-at ?p ?f)
      (elevator-at ?e ?f)
      (not (in-elevator ?p ?e))
      (or (not (never-alone ?p))
          (exists (?p2 - passenger) (and (not (= ?p2 ?p)) (in-elevator ?p2 ?e)))
      )
      (forall (?p2 - passenger) (or 
             (not (in-elevator ?p2 ?e)) 
             (not (conflicts-with ?p ?p2))
          ))
    )
    :effect (and
      (in-elevator ?p ?e)
      (not (passenger-at ?p ?f))
    )
  )

  (:action disembark
    :parameters (?p - passenger ?e - elevator ?f - floor)
    :precondition (and
      (in-elevator ?p ?e)
      (elevator-at ?e ?f)
      (destined-for ?p ?f)
    )
    :effect (and
      (not (in-elevator ?p ?e))
      (passenger-at ?p ?f)
    )
  )
)