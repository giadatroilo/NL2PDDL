(define (domain parking)
  (:requirements :strips :typing :negative-preconditions :equality)

  (:types
    place
    car curb - place
  )

  (:predicates
    (at-curb ?c - car ?k - curb)
    (parked-behind ?c1 - car ?c2 - car)
    (unblocked ?c - car)
    (curb-free ?k - curb)
  )

  (:action move-curb-to-curb
    :parameters (?c - car ?from - curb ?to - curb)
    :precondition (and
      (at-curb ?c ?from)
      (unblocked ?c)
      (curb-free ?to)
      (not (= ?from ?to))
    )
    :effect (and
      (not (at-curb ?c ?from))
      (curb-free ?from)
      (at-curb ?c ?to)
      (not (curb-free ?to))
    )
  )

  (:action park-behind-from-curb
    :parameters (?mover - car ?from - curb ?target - car)
    :precondition (and
      (at-curb ?mover ?from)
      (unblocked ?mover)
      (unblocked ?target)
      (not (= ?mover ?target))
    )
    :effect (and
      (not (at-curb ?mover ?from))
      (curb-free ?from)
      (parked-behind ?mover ?target)
      (not (unblocked ?target))
    )
  )

  (:action unpark-to-curb
    :parameters (?mover - car ?blockedcar - car ?to - curb)
    :precondition (and
      (parked-behind ?mover ?blockedcar)
      (unblocked ?mover)
      (curb-free ?to)
    )
    :effect (and
      (not (parked-behind ?mover ?blockedcar))
      (unblocked ?blockedcar)
      (at-curb ?mover ?to)
      (not (curb-free ?to))
    )
  )

  (:action move-behind-to-behind
    :parameters (?mover - car ?fromcar - car ?tocar - car)
    :precondition (and
      (parked-behind ?mover ?fromcar)
      (unblocked ?mover)
      (unblocked ?tocar)
      (not (= ?mover ?tocar))
      (not (= ?fromcar ?tocar))
    )
    :effect (and
      (not (parked-behind ?mover ?fromcar))
      (unblocked ?fromcar)
      (parked-behind ?mover ?tocar)
      (not (unblocked ?tocar))
    )
  )
)
