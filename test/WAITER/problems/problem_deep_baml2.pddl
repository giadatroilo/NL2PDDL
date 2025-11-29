(define (problem serve-customer1)
  (:domain robot-waiter)

  (:objects
    Kitchen - area
    Buffet - buffet
    Table1 - area
    Lucki - robot
    PlateA - plate
    sushi - food
    Customer1 - customer
  )

  (:init
    (robot-at Lucki Kitchen)
    (plate-at PlateA Kitchen)
    (adjacent Kitchen Buffet)
    (adjacent Buffet Kitchen)
    (adjacent Buffet Table1)
    (adjacent Table1 Buffet)
  )

  (:goal
    (served Customer1)
  )
)