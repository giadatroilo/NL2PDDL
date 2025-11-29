(define (problem serve-snacks-to-children)
  (:domain child-snack)

  (:objects
    Marco Anna - child
    Kitchen Table - place
    tray - tray
    sandwich_gf - gluten-free-sandwich
    sandwich_g - gluten-sandwich
  )

  (:init
    (has-gluten-allergy Marco)
    (at-place Marco Table)
    (at-place Anna Table)
    (tray-at-place tray Kitchen)
    (is-serving-area Table)
    (is-serving-area Kitchen)
    (not (prepared sandwich_gf))
    (not (prepared sandwich_g))
    (not (at-place sandwich_gf Kitchen))
    (not (at-place sandwich_g Kitchen))
    (not (on-tray sandwich_gf tray))
    (not (on-tray sandwich_g tray))
  )

  (:goal
    (and
      (served-sandwich Marco sandwich_gf)
      (served-to-child sandwich_gf Marco)
      (served-sandwich Anna sandwich_g)
      (served-to-child sandwich_g Anna)
    )
  )
)