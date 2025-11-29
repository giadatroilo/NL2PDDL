(define (domain book_assignment)
  (:requirements :strips :typing :negative-preconditions :adl)
  (:types
    book
    month
  )
  (:predicates
    (assigned ?b - book ?m - month)
    (predecessor ?b1 - book ?b2 - book)
  )
  (:action assigna
    :parameters (?b - book ?m - month)
    :precondition (and
      (forall (?m2 - month) (not (assigned ?b ?m2)))
      (forall (?b1 - book) 
        (implies (predecessor ?b1 ?b)
                 (exists (?m3 - month) (assigned ?b1 ?m3))))
    )
    :effect (and
      (assigned ?b ?m)
    )
  )
)