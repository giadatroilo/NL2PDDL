(define (domain tower-of-hanoi)
  (:requirements :strips :typing :negative-preconditions :equality :fluents :numeric-fluents ::existential-preconditions)

  (:types
    peg
    disc
    stack
  )

  (:predicates
    (peg-has-stack ?p - peg ?s - stack)
    (on-disc ?d1 - disc ?d2 - disc)
    (on-peg ?d - disc ?p - peg)
    (clear ?d - disc)
    (top-disc ?s - stack ?d - disc)
    (stack-contains-disc ?s - stack ?d - disc)
  )

  (:functions
    (disc-size ?d - disc) - number
    (stack-height ?s - stack) - number
  )

  (:action move-disc
    :parameters (?d - disc ?from - peg ?to - peg ?from-stack - stack ?to-stack - stack)
    :precondition (and
      (on-peg ?d ?from)
      (peg-has-stack ?from ?from-stack)
      (peg-has-stack ?to ?to-stack)
      (top-disc ?from-stack ?d)
      (clear ?d)
      (> (stack-height ?from-stack) 0)
      (>= (stack-height ?to-stack) 0)
      (or
        (= (stack-height ?to-stack) 0)
        (and
          (exists (?d2 - disc)
            (and
              (top-disc ?to-stack ?d2)
              (clear ?d2)
              (< (disc-size ?d) (disc-size ?d2))
            )
          )
        )
      )
    )
    :effect (and
      (not (on-peg ?d ?from))
      (on-peg ?d ?to)
      (not (top-disc ?from-stack ?d))
      (top-disc ?to-stack ?d)
      (not (stack-contains-disc ?from-stack ?d))
      (stack-contains-disc ?to-stack ?d)
      (decrease (stack-height ?from-stack) 1)
      (increase (stack-height ?to-stack) 1)
      (not (clear ?d))
      (when (> (stack-height ?from-stack) 0)
        (exists (?newtop - disc)
          (and
            (top-disc ?from-stack ?newtop)
            (clear ?newtop)
          )
        )
      )
      (when (> (stack-height ?to-stack) 1)
        (exists (?prevtop - disc)
          (and
            (not (clear ?prevtop))
            (top-disc ?to-stack ?prevtop)
          )
        )
      )
    )
  )

  (:action move-disc-between-discs
    :parameters (?d - disc ?from-disc - disc ?to-disc - disc ?from-stack - stack ?to-stack - stack)
    :precondition (and
      (on-disc ?d ?from-disc)
      (peg-has-stack ?from-stack)
      (peg-has-stack ?to-stack)
      (top-disc ?from-stack ?d)
      (top-disc ?to-stack ?to-disc)
      (clear ?d)
      (clear ?to-disc)
      (> (stack-height ?from-stack) 0)
      (>= (stack-height ?to-stack) 0)
      (< (disc-size ?d) (disc-size ?to-disc))
      (stack-contains-disc ?from-stack ?from-disc)
      (stack-contains-disc ?to-stack ?to-disc)
    )
    :effect (and
      (not (on-disc ?d ?from-disc))
      (on-disc ?d ?to-disc)
      (not (top-disc ?from-stack ?d))
      (top-disc ?to-stack ?d)
      (not (stack-contains-disc ?from-stack ?d))
      (stack-contains-disc ?to-stack ?d)
      (decrease (stack-height ?from-stack) 1)
      (increase (stack-height ?to-stack) 1)
      (clear ?from-disc)
      (not (clear ?to-disc))
      (not (clear ?d))
    )
  )

  (:action move-disc-to-empty-peg
    :parameters (?d - disc ?from - peg ?to - peg ?from-stack - stack ?to-stack - stack)
    :precondition (and
      (on-peg ?d ?from)
      (peg-has-stack ?from ?from-stack)
      (peg-has-stack ?to ?to-stack)
      (top-disc ?from-stack ?d)
      (clear ?d)
      (> (stack-height ?from-stack) 0)
      (= (stack-height ?to-stack) 0)
    )
    :effect (and
      (not (on-peg ?d ?from))
      (on-peg ?d ?to)
      (not (top-disc ?from-stack ?d))
      (top-disc ?to-stack ?d)
      (not (stack-contains-disc ?from-stack ?d))
      (stack-contains-disc ?to-stack ?d)
      (decrease (stack-height ?from-stack) 1)
      (increase (stack-height ?to-stack) 1)
      (not (clear ?d))
      (when (> (stack-height ?from-stack) 0)
        (exists (?newtop - disc)
          (and
            (top-disc ?from-stack ?newtop)
            (clear ?newtop)
          )
        )
      )
    )
  )
)
