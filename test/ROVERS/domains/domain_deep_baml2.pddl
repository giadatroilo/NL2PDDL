(define (domain mars-rover)
  (:requirements :strips :typing :negative-preconditions :fluents :numeric-fluents :equality)

  (:types
    rover waypoint lander tool
    sample data
    soil-sample rock-sample - sample
    image - data
  )

  (:predicates
    (rover-at ?r - rover ?w - waypoint)
    (carrying-sample ?r - rover ?s - sample)
    (equipped-with-tool ?r - rover ?t - tool)
    (has-data ?r - rover ?d - data)
    (sample-at ?s - sample ?w - waypoint)
    (data-communicated ?d - data ?l - lander)
    (tool-at ?t - tool ?w - waypoint)
  )

  (:functions
    (storage-used ?r - rover) - number
    (mass ?s - sample) - number
  )

  (:action move
    :parameters (?r - rover ?from - waypoint ?to - waypoint)
    :precondition (and
      (rover-at ?r ?from)
    )
    :effect (and
      (not (rover-at ?r ?from))
      (rover-at ?r ?to)
    )
  )

  (:action pickup-sample
    :parameters (?r - rover ?s - sample ?w - waypoint)
    :precondition (and
      (rover-at ?r ?w)
      (sample-at ?s ?w)
      (not (carrying-sample ?r ?s))
      (<= (+ (storage-used ?r) (mass ?s)) 100)
    )
    :effect (and
      (carrying-sample ?r ?s)
      (not (sample-at ?s ?w))
      (increase (storage-used ?r) (mass ?s))
    )
  )

  (:action drop-sample
    :parameters (?r - rover ?s - sample ?w - waypoint)
    :precondition (and
      (rover-at ?r ?w)
      (carrying-sample ?r ?s)
    )
    :effect (and
      (not (carrying-sample ?r ?s))
      (sample-at ?s ?w)
      (decrease (storage-used ?r) (mass ?s))
    )
  )

  (:action equip-tool
    :parameters (?r - rover ?t - tool ?w - waypoint)
    :precondition (and
      (rover-at ?r ?w)
      (tool-at ?t ?w)
      (not (equipped-with-tool ?r ?t))
    )
    :effect (and
      (equipped-with-tool ?r ?t)
      (not (tool-at ?t ?w))
    )
  )

  (:action unequip-tool
    :parameters (?r - rover ?t - tool ?w - waypoint)
    :precondition (and
      (rover-at ?r ?w)
      (equipped-with-tool ?r ?t)
    )
    :effect (and
      (not (equipped-with-tool ?r ?t))
      (tool-at ?t ?w)
    )
  )

  (:action take-image
    :parameters (?r - rover ?t - tool ?w - waypoint ?i - image)
    :precondition (and
      (rover-at ?r ?w)
      (equipped-with-tool ?r ?t)
      (not (has-data ?r ?i))
      (< (storage-used ?r) 100)
    )
    :effect (and
      (has-data ?r ?i)
      (increase (storage-used ?r) 1)
    )
  )

  (:action communicate-data
    :parameters (?r - rover ?d - data ?l - lander)
    :precondition (and
      (has-data ?r ?d)
      (not (data-communicated ?d ?l))
    )
    :effect (and
      (not (has-data ?r ?d))
      (data-communicated ?d ?l)
      (decrease (storage-used ?r) 1)
    )
  )
)