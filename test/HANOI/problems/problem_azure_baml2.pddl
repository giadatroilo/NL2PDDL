(define (problem hanoi-three-discs)
  (:domain tower-of-hanoi)

  (:objects
    Peg1 Peg2 Peg3 - peg
    D1 D2 D3 - disc
    S1 S2 S3 - stack
  )

  (:init
    ;; Disc sizes
    (= (disc-size D1) 1)
    (= (disc-size D2) 2)
    (= (disc-size D3) 3)

    ;; Initial stacks: S1 is the stack on Peg1, S2 on Peg2, S3 on Peg3
    (peg-has-stack Peg1 S1)
    (peg-has-stack Peg2 S2)
    (peg-has-stack Peg3 S3)

    ;; Stack heights
    (= (stack-height S1) 3)
    (= (stack-height S2) 0)
    (= (stack-height S3) 0)

    ;; Stack contents
    (stack-contains-disc S1 D1)
    (stack-contains-disc S1 D2)
    (stack-contains-disc S1 D3)

    ;; Top disc
    (top-disc S1 D1)

    ;; On relations
    (on-disc D1 D2)
    (on-disc D2 D3)
    (on-peg D3 Peg1)

    ;; Clear predicates
    (clear D1)
    ;; D2 and D3 are not clear (not (clear D2)), (not (clear D3))
  )

  (:goal
    (and
      ;; All discs stacked in order on Peg3
      (on-disc D1 D2)
      (on-disc D2 D3)
      (on-peg D3 Peg3)
      (clear D1)
      ;; D2 and D3 are not clear (not (clear D2)), (not (clear D3))
    )
  )
)