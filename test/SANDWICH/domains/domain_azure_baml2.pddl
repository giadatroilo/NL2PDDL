(define (domain child-snack)
  (:requirements :strips :typing :negative-preconditions :equality)

  (:types
    child
    sandwich
    gluten-free-sandwich gluten-sandwich - sandwich
    tray
    place
  )

  (:predicates
    (at-place ?c - child ?p - place)
    (served-sandwich ?c - child ?s - sandwich)
    (has-gluten-allergy ?c - child)
    (on-tray ?s - sandwich ?t - tray)
    (at-place ?s - sandwich ?p - place)
    (served-to-child ?s - sandwich ?c - child)
    (prepared ?s - sandwich)
    (is-gluten-free ?s - gluten-free-sandwich)
    (contains-gluten ?s - gluten-sandwich)
    (tray-at-place ?t - tray ?p - place)
    (tray-has-sandwich ?t - tray ?s - sandwich)
    (is-serving-area ?p - place)
  )

  (:action prepare-gluten-free-sandwich
    :parameters (?s - gluten-free-sandwich ?p - place)
    :precondition (and
      (not (prepared ?s))
      (not (at-place ?s ?p))
    )
    :effect (and
      (prepared ?s)
      (is-gluten-free ?s)
      (at-place ?s ?p)
    )
  )

  (:action prepare-gluten-sandwich
    :parameters (?s - gluten-sandwich ?p - place)
    :precondition (and
      (not (prepared ?s))
      (not (at-place ?s ?p))
    )
    :effect (and
      (prepared ?s)
      (contains-gluten ?s)
      (at-place ?s ?p)
    )
  )

  (:action place-sandwich-on-tray
    :parameters (?s - sandwich ?t - tray ?p - place)
    :precondition (and
      (prepared ?s)
      (at-place ?s ?p)
      (tray-at-place ?t ?p)
      (not (on-tray ?s ?t))
    )
    :effect (and
      (on-tray ?s ?t)
      (tray-has-sandwich ?t ?s)
      (not (at-place ?s ?p))
    )
  )

  (:action remove-sandwich-from-tray
    :parameters (?s - sandwich ?t - tray ?p - place)
    :precondition (and
      (on-tray ?s ?t)
      (tray-at-place ?t ?p)
    )
    :effect (and
      (not (on-tray ?s ?t))
      (not (tray-has-sandwich ?t ?s))
      (at-place ?s ?p)
    )
  )

  (:action move-tray
    :parameters (?t - tray ?from - place ?to - place)
    :precondition (and
      (tray-at-place ?t ?from)
      (not (tray-at-place ?t ?to))
    )
    :effect (and
      (not (tray-at-place ?t ?from))
      (tray-at-place ?t ?to)
    )
  )

  (:action serve-sandwich-to-child
    :parameters (?s - sandwich ?c - child ?p - place)
    :precondition (and
      (at-place ?s ?p)
      (at-place ?c ?p)
      (not (served-sandwich ?c ?s))
      (not (served-to-child ?s ?c))
      (prepared ?s)
      (or
        (and
          (has-gluten-allergy ?c)
          (is-gluten-free ?s)
        )
        (and
          (not (has-gluten-allergy ?c))
          (or
            (contains-gluten ?s)
            (is-gluten-free ?s)
          )
        )
      )
    )
    :effect (and
      (served-sandwich ?c ?s)
      (served-to-child ?s ?c)
    )
  )

  (:action serve-sandwich-to-child-from-tray
    :parameters (?s - sandwich ?t - tray ?c - child ?p - place)
    :precondition (and
      (on-tray ?s ?t)
      (tray-at-place ?t ?p)
      (at-place ?c ?p)
      (not (served-sandwich ?c ?s))
      (not (served-to-child ?s ?c))
      (prepared ?s)
      (or
        (and
          (has-gluten-allergy ?c)
          (is-gluten-free ?s)
        )
        (and
          (not (has-gluten-allergy ?c))
          (or
            (contains-gluten ?s)
            (is-gluten-free ?s)
          )
        )
      )
    )
    :effect (and
      (served-sandwich ?c ?s)
      (served-to-child ?s ?c)
      (not (on-tray ?s ?t))
      (not (tray-has-sandwich ?t ?s))
    )
  )
)
