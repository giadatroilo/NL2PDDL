(define (problem read-two-books)
  (:domain book_assignment)

  (:objects
    BookA BookB - book
    month1 month2 - month
  )

  (:init
    (predecessor BookA BookB)
  )

  (:goal
    (and
      (or (assigned BookA month1) (assigned BookA month2))
      (or (assigned BookB month1) (assigned BookB month2))
    )
  )
)