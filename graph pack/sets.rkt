;; Set package ;;

(define (set-reps m)

  (define (list-rep)

    (define make-empty-set
      '())

    (define (make-set lst)
      (cond ((null? lst) make-empty-set)
            ((in-set? (cdr lst) (car lst)) (make-set (cdr lst)))
            (else (cons (car lst) (make-set (cdr lst))))))  

    (define (insert set elem)
      (cond ((in-set? set elem) set)
            (else (cons elem set))))

    (define (delete set elem)
      (cond ((null? set) set)
            ((equal? (car set) elem) (cdr set))
            (else (cons (car set) (delete (cdr set) elem)))))

    (define (union set1 set2) ;; go thru set1 and add elems not present in set2
      (cond ((null? set1) set2)
            ((not (in-set? set2 (car set1))) (union (cdr set1) (cons (car set1) set2)))
            (else (union (cdr set1) set2))))

    (define (intersection set1 set2) ;; go thru set1 and see if the car is in the set2, the build new set
      (cond ((or (null? set1) (null? set2)) '())
            ((and (in-set? set2 (car set1))) (cons (car set1) (intersection (cdr set1) set2)))
            (else (intersection (cdr set1) set2))))

    (define (in-set? set elem)
      (cond
        ((null? set) #f)
        ((and (null? elem) (not (null? set))) #t) ;; checks to see if the elem is empty set, and if it is, then check if set is not empty set: if so, #t, otherwise false (next cond)
            ((equal? (car set) elem) #t)
            (else (in-set? (cdr set) elem))))

    (define (dispatch m)
    (cond ((eq? m 'make-empty-set) make-empty-set)
          ((eq? m 'make-set) make-set)
          ((eq? m 'insert) insert)
          ((eq? m 'delete) delete)
          ((eq? m 'union) union)
          ((eq? m 'intersection) intersection)
          ((eq? m 'in-set?) in-set?)))

    dispatch)
    
    (cond ((eq? m 'list) (list-rep))
          (else #f))
  )


;; defining the basic functions at the top level

(define make-empty-set ((set-reps 'list) 'make-empty-set))
(define make-set ((set-reps 'list) 'make-set))
(define insert ((set-reps 'list) 'insert))
(define delete ((set-reps 'list) 'delete))
(define union ((set-reps 'list) 'union))
(define intersection ((set-reps 'list) 'intersection))
(define in-set? ((set-reps 'list) 'in-set?))


;; examples
(define set-0 make-empty-set)
(define set-1 (make-set '(a b c d)))
(define set-2 (insert set-1 'e))
(define set-3 (delete set-2 'a))
(define set-4 (union set-3 (make-set '(e t r b j))))


;;;> set-1
;;;(a b c d)
;;;> set-2
;;;(e a b c d)
;;;> set-3
;;;(e b c d)
;;;> set-4
;;;(d c e t r b j)