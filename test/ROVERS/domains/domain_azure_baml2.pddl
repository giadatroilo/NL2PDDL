(define (domain mars-rover)
  (:requirements :strips :typing :negative-preconditions :fluents :numeric-fluents :equality)

  (:types
    rover
    waypoint
    sample
    soil-sample rock-sample - sample
    image
    tool
    analysis-tool imaging-tool - tool
    lander
    data
    equipment
    storage
  )

  (:predicates
    (rover-at ?r - rover ?w - waypoint)
    (equipped-with-tool ?r - rover ?t - tool)
    (carrying-sample ?r - rover ?s - sample)
    (carrying-image ?r - rover ?i - image)
    (carrying-data ?r - rover ?d - data)
    (sample-at-waypoint ?s - sample ?w - waypoint)
    (on-rover ?s - sample ?r - rover)
    (analyzed ?s - sample)
    (image-on-rover ?i - image ?r - rover)
    (image-captured-at ?i - image ?w - waypoint)
    (transmitted-to-lander ?i - image ?l - lander)
    (tool-on-rover ?t - tool ?r - rover)
    (tool-available ?t - tool)
    (analysis-tool-on-rover ?a - analysis-tool ?r - rover)
    (imaging-tool-on-rover ?i - imaging-tool ?r - rover)
    (equipment-on-rover ?e - equipment ?r - rover)
    (lander-at ?l - lander ?w - waypoint)
    (data-on-rover ?d - data ?r - rover)
    (data-at-lander ?d - data ?l - lander)
    (data-received ?l - lander ?d - data)
    (storage-on-rover ?s - storage ?r - rover)
    (visited ?w - waypoint)
  )

  (:functions
    (storage-used ?r - rover) - number
    (storage-capacity ?r - rover) - number
    (mass ?s - soil-sample) - number
    (mass ?s - rock-sample) - number
    (image-size ?i - image) - number
    (data-size ?d - data) - number
  )

  (:action navigate
    :parameters (?r - rover ?from - waypoint ?to - waypoint)
    :precondition (and
      (rover-at ?r ?from)
      (not (rover-at ?r ?to))
    )
    :effect (and
      (not (rover-at ?r ?from))
      (rover-at ?r ?to)
      (visited ?to)
    )
  )

  (:action collect-soil-sample
    :parameters (?r - rover ?s - soil-sample ?w - waypoint)
    :precondition (and
      (rover-at ?r ?w)
      (sample-at-waypoint ?s ?w)
      (not (carrying-sample ?r ?s))
      (not (on-rover ?s ?r))
      (<= (+ (storage-used ?r) (mass ?s)) (storage-capacity ?r))
    )
    :effect (and
      (carrying-sample ?r ?s)
      (on-rover ?s ?r)
      (not (sample-at-waypoint ?s ?w))
      (increase (storage-used ?r) (mass ?s))
    )
  )

  (:action collect-rock-sample
    :parameters (?r - rover ?s - rock-sample ?w - waypoint)
    :precondition (and
      (rover-at ?r ?w)
      (sample-at-waypoint ?s ?w)
      (not (carrying-sample ?r ?s))
      (not (on-rover ?s ?r))
      (<= (+ (storage-used ?r) (mass ?s)) (storage-capacity ?r))
    )
    :effect (and
      (carrying-sample ?r ?s)
      (on-rover ?s ?r)
      (not (sample-at-waypoint ?s ?w))
      (increase (storage-used ?r) (mass ?s))
    )
  )

  (:action drop-sample
    :parameters (?r - rover ?s - sample ?w - waypoint)
    :precondition (and
      (rover-at ?r ?w)
      (carrying-sample ?r ?s)
      (on-rover ?s ?r)
    )
    :effect (and
      (not (carrying-sample ?r ?s))
      (not (on-rover ?s ?r))
      (sample-at-waypoint ?s ?w)
      (decrease (storage-used ?r) (mass ?s))
    )
  )

  (:action analyze-sample
    :parameters (?r - rover ?s - sample ?a - analysis-tool)
    :precondition (and
      (on-rover ?s ?r)
      (analysis-tool-on-rover ?a ?r)
      (equipped-with-tool ?r ?a)
      (not (analyzed ?s))
    )
    :effect (and
      (analyzed ?s)
    )
  )

  (:action capture-image
    :parameters (?r - rover ?i - image ?w - waypoint ?t - imaging-tool)
    :precondition (and
      (rover-at ?r ?w)
      (imaging-tool-on-rover ?t ?r)
      (equipped-with-tool ?r ?t)
      (not (carrying-image ?r ?i))
      (not (image-on-rover ?i ?r))
      (<= (+ (storage-used ?r) (image-size ?i)) (storage-capacity ?r))
    )
    :effect (and
      (carrying-image ?r ?i)
      (image-on-rover ?i ?r)
      (image-captured-at ?i ?w)
      (increase (storage-used ?r) (image-size ?i))
    )
  )

  (:action drop-image
    :parameters (?r - rover ?i - image ?w - waypoint)
    :precondition (and
      (rover-at ?r ?w)
      (carrying-image ?r ?i)
      (image-on-rover ?i ?r)
    )
    :effect (and
      (not (carrying-image ?r ?i))
      (not (image-on-rover ?i ?r))
      (decrease (storage-used ?r) (image-size ?i))
    )
  )

  (:action equip-tool
    :parameters (?r - rover ?t - tool)
    :precondition (and
      (tool-on-rover ?t ?r)
      (tool-available ?t)
      (not (equipped-with-tool ?r ?t))
    )
    :effect (and
      (equipped-with-tool ?r ?t)
    )
  )

  (:action unequip-tool
    :parameters (?r - rover ?t - tool)
    :precondition (equipped-with-tool ?r ?t)
    :effect (and
      (not (equipped-with-tool ?r ?t))
    )
  )

  (:action load-tool
    :parameters (?r - rover ?t - tool)
    :precondition (and
      (tool-available ?t)
      (not (tool-on-rover ?t ?r))
    )
    :effect (and
      (tool-on-rover ?t ?r)
      (equipment-on-rover ?t ?r)
    )
  )

  (:action unload-tool
    :parameters (?r - rover ?t - tool)
    :precondition (and
      (tool-on-rover ?t ?r)
      (not (equipped-with-tool ?r ?t))
    )
    :effect (and
      (not (tool-on-rover ?t ?r))
      (not (equipment-on-rover ?t ?r))
    )
  )

  (:action transmit-image-to-lander
    :parameters (?r - rover ?i - image ?l - lander ?w - waypoint)
    :precondition (and
      (image-on-rover ?i ?r)
      (carrying-image ?r ?i)
      (lander-at ?l ?w)
      (rover-at ?r ?w)
    )
    :effect (and
      (transmitted-to-lander ?i ?l)
      (not (carrying-image ?r ?i))
      (not (image-on-rover ?i ?r))
      (decrease (storage-used ?r) (image-size ?i))
    )
  )

  (:action transmit-data-to-lander
    :parameters (?r - rover ?d - data ?l - lander ?w - waypoint)
    :precondition (and
      (data-on-rover ?d ?r)
      (carrying-data ?r ?d)
      (lander-at ?l ?w)
      (rover-at ?r ?w)
    )
    :effect (and
      (data-at-lander ?d ?l)
      (data-received ?l ?d)
      (not (carrying-data ?r ?d))
      (not (data-on-rover ?d ?r))
      (decrease (storage-used ?r) (data-size ?d))
    )
  )

  (:action store-data
    :parameters (?r - rover ?d - data)
    :precondition (and
      (<= (+ (storage-used ?r) (data-size ?d)) (storage-capacity ?r))
      (not (carrying-data ?r ?d))
      (not (data-on-rover ?d ?r))
    )
    :effect (and
      (carrying-data ?r ?d)
      (data-on-rover ?d ?r)
      (increase (storage-used ?r) (data-size ?d))
    )
  )

  (:action drop-data
    :parameters (?r - rover ?d - data)
    :precondition (and
      (carrying-data ?r ?d)
      (data-on-rover ?d ?r)
    )
    :effect (and
      (not (carrying-data ?r ?d))
      (not (data-on-rover ?d ?r))
      (decrease (storage-used ?r) (data-size ?d))
    )
  )

  (:action load-storage
    :parameters (?r - rover ?s - storage)
    :precondition (not (storage-on-rover ?s ?r))
    :effect (and
      (storage-on-rover ?s ?r)
    )
  )

  (:action unload-storage
    :parameters (?r - rover ?s - storage)
    :precondition (storage-on-rover ?s ?r)
    :effect (and
      (not (storage-on-rover ?s ?r))
    )
  )
)
