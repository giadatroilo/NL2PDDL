(define (domain scanalyzer3d)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    car
    segment
    group
    pair quad - group
  )

  (:predicates
    (car-at-segment ?c - car ?s - segment)
    (in-group ?c - car ?g - group)
    (analyzed ?c - car)
    (segment-occupied ?s - segment)
    (group-analyzed ?g - group)
    (is-pair ?p - pair)
    (is-quad ?q - quad)
  )

  (:action analyze-pair
    :parameters (?p - pair ?c1 - car ?c2 - car ?s1 - segment ?s2 - segment)
    :precondition (and
      (is-pair ?p)
      (in-group ?c1 ?p)
      (in-group ?c2 ?p)
      (car-at-segment ?c1 ?s1)
      (car-at-segment ?c2 ?s2)
      (segment-occupied ?s1)
      (segment-occupied ?s2)
      (not (group-analyzed ?p))
      (not (analyzed ?c1))
      (not (analyzed ?c2))
    )
    :effect (and
      (group-analyzed ?p)
      (analyzed ?c1)
      (analyzed ?c2)
    )
  )

  (:action analyze-quad
    :parameters (?q - quad ?c1 - car ?c2 - car ?c3 - car ?c4 - car ?s1 - segment ?s2 - segment ?s3 - segment ?s4 - segment)
    :precondition (and
      (is-quad ?q)
      (in-group ?c1 ?q)
      (in-group ?c2 ?q)
      (in-group ?c3 ?q)
      (in-group ?c4 ?q)
      (car-at-segment ?c1 ?s1)
      (car-at-segment ?c2 ?s2)
      (car-at-segment ?c3 ?s3)
      (car-at-segment ?c4 ?s4)
      (segment-occupied ?s1)
      (segment-occupied ?s2)
      (segment-occupied ?s3)
      (segment-occupied ?s4)
      (not (group-analyzed ?q))
      (not (analyzed ?c1))
      (not (analyzed ?c2))
      (not (analyzed ?c3))
      (not (analyzed ?c4))
    )
    :effect (and
      (group-analyzed ?q)
      (analyzed ?c1)
      (analyzed ?c2)
      (analyzed ?c3)
      (analyzed ?c4)
    )
  )

  (:action rotate-car
    :parameters (?c - car ?from - segment ?to - segment)
    :precondition (and
      (car-at-segment ?c ?from)
      (segment-occupied ?from)
      (not (segment-occupied ?to))
      (not (analyzed ?c))
    )
    :effect (and
      (not (car-at-segment ?c ?from))
      (not (segment-occupied ?from))
      (car-at-segment ?c ?to)
      (segment-occupied ?to)
    )
  )

  (:action unrotate-car
    :parameters (?c - car ?from - segment ?to - segment)
    :precondition (and
      (car-at-segment ?c ?to)
      (segment-occupied ?to)
      (not (segment-occupied ?from))
      (not (analyzed ?c))
    )
    :effect (and
      (not (car-at-segment ?c ?to))
      (not (segment-occupied ?to))
      (car-at-segment ?c ?from)
      (segment-occupied ?from)
    )
  )

  (:action form-pair
    :parameters (?p - pair ?c1 - car ?c2 - car)
    :precondition (and
      (is-pair ?p)
      (not (in-group ?c1 ?p))
      (not (in-group ?c2 ?p))
      (not (analyzed ?c1))
      (not (analyzed ?c2))
    )
    :effect (and
      (in-group ?c1 ?p)
      (in-group ?c2 ?p)
    )
  )

  (:action dissolve-pair
    :parameters (?p - pair ?c1 - car ?c2 - car)
    :precondition (and
      (is-pair ?p)
      (in-group ?c1 ?p)
      (in-group ?c2 ?p)
      (not (group-analyzed ?p))
    )
    :effect (and
      (not (in-group ?c1 ?p))
      (not (in-group ?c2 ?p))
    )
  )

  (:action form-quad
    :parameters (?q - quad ?c1 - car ?c2 - car ?c3 - car ?c4 - car)
    :precondition (and
      (is-quad ?q)
      (not (in-group ?c1 ?q))
      (not (in-group ?c2 ?q))
      (not (in-group ?c3 ?q))
      (not (in-group ?c4 ?q))
      (not (analyzed ?c1))
      (not (analyzed ?c2))
      (not (analyzed ?c3))
      (not (analyzed ?c4))
    )
    :effect (and
      (in-group ?c1 ?q)
      (in-group ?c2 ?q)
      (in-group ?c3 ?q)
      (in-group ?c4 ?q)
    )
  )

  (:action dissolve-quad
    :parameters (?q - quad ?c1 - car ?c2 - car ?c3 - car ?c4 - car)
    :precondition (and
      (is-quad ?q)
      (in-group ?c1 ?q)
      (in-group ?c2 ?q)
      (in-group ?c3 ?q)
      (in-group ?c4 ?q)
      (not (group-analyzed ?q))
    )
    :effect (and
      (not (in-group ?c1 ?q))
      (not (in-group ?c2 ?q))
      (not (in-group ?c3 ?q))
      (not (in-group ?c4 ?q))
    )
  )
)
