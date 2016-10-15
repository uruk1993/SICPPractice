#! /bin/env guile
!#
;; chapter one
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

(define lat?
  (lambda (l)
    (cond
     ((null? l) #t)
     ((atom? (car l)) (lat? (cdr l)))
     (else #f))))

(define member?
  (lambda (a l)
    (cond
     ((null? l) #f)
     ((eq? a (car l)) #t)
     (else (member? a (cdr l))))))

(define rember
  (lambda (a lat)
    (cond
     ((null? lat) lat)
     ((eq? a (car lat)) (cdr lat))
     (else (cons (car lat)
                 (rember a (cdr lat))) ))))
(define (firsts l)
  (cond
   ((null? l) l)
   (else (cons (car (car l))
               (first (cdr l))))))

(define (insertR new old lat)
  (cond
   ((null? lat) lat)
   ((eq? old (car lat)) (cons old (cons new (cdr lat))))
   (else (cons (car lat)
               (insertR old new (cdr lat))))))

(define (insertL new old l)
  (cond
   ((null? l) l)
   ((eq? old (car l)) (cons new l))
   (else (cons (car l)
               (insertL old new (cdr l))))))

(define (subset new old l)
  (cond
   ((null? l) l)
   ((eq? old (car l)) (cons new (cdr l)))
   (else (cons (car l)
               (subset old new (cdr l))))))

(define (subset2 new old1 old2 l)
  (cond
   ((null? l) l)
   ((or (eq? old1 (car l))
        (eq? old2 (car l))) (cons new (cdr l)))
   (else (cons (car l)
               (subset2 new old1 old2 (cdr l))))))

(define (multirember a l)
  (cond
   ((null? l) l)
   (else (cond
          ((eq? a (car l)) (multirember a (cdr l)))
          (else (cons (car l)
                      (multirember a (cdr l))))))))

(define (multiinsertR new old l)
  (cond
   ((null? l) l)
   (else (cond
          ((eq? old (car l)) (cons old
                                   (cons new
                                         (multiinsertR new old (cdr l)))))
          (else (cons (car l)
                      (multiinsertR new old (cdr l))))))))

(define (multiinsertL new old l)
  (cond
   ((null? l) l)
   (else (cond
          ((eq? old (car l)) (cons new
                                   (cons old (multiinsertL new old (cdr l)))))
          (else (cons (car l) (multiinsertL new old (cdr l))))))))

(define (multisubset new old l)
  (cond
   ((null? l) l)
   (else (cond
          ((eq? old (car l)) (cons new (multisubset new old (cdr l))))
          (else (cons (car l)
                      (multisubset new old (cdr l))))))))
;; chapter four
(define (add1 n)
  (+ 1 n))

(define (sub1 n)
  (- n 1))

(define (o+ a b)
  (cond
   ((zero? b) a)
   (else (add1 (o+ a (sub1 b))))))

(define (o- a b)
  (cond
   ((zero? b) a)
   (else (sub1 (o- a (sub1 b))))))

(define (addup l)
  (cond
   ((null? l) 0)
   (else (o+ (car l) (addup (cdr l))))))

(define (o* a b)
  (cond
   ((zero? b) 0)
   (else (o+ a (o* a (sub1 b))))))

(define (tup+ tup1 tup2)
  (cond
   ((null? tup2) tup1)
   ((null? tup1) tup2)
   (else (cons (o+ (car tup1) (car tup2))
               (tup+ (cdr tup1) (cdr tup2))))))

(define (o> a b)
  (cond
   ((zero? a) #f)
   ((zero? b) #t)
   (else (o> (sub1 a) (sub1 b)))))

(define (o< a b)
  (cond
   ((zero? b) #f)
   ((zero? a) #t)
   (else (o< (sub1 a) (sub1 b)))))

(define (o= a b)
  (cond
   ((or (o< a b) (o> a b)) #f)
   (else #t)))

(define (expt a b)
  (cond
   ((zero? b) 1)
   (else (o* a (expt a (sub1 b))))))

(define (length l)
  (cond
   ((null? l) 0)
   (else (add1 (length (cdr l))))))

(define (pick num l)
  (cond
   ((zero? (sub1 num)) (car l))
   (else (pick (sub1 num) (cdr l)))))

(define (rempick n l)
  (cond
   ((one? n) (cdr l))
   (else (cons (car l) (rempick (sub1 n) (cdr l))))))

(define (no-num l)
  (cond
   ((null? l) l)
   ((number? (car l)) (no-num (cdr l)))
   (else (cons (car l) (no-num (cdr l))))))

(define (all-num l)
  (cond
   ((null? l) l)
   (else
    (cond
     ((number? (car l)) (cons (car l) (all-num (cdr l))))
     (else (all-num (cdr l)))))))

(define (eqan? a b)
  (cond
   ((and (number? a) (number? b)) (= a b))
   ((or (number? a) (number? b)) #f)
   (else (eq? a b))))

(define (occur a l)
  (cond
   ((null? l) 0)
   (else (cond
          ((eqan? a (car l))
           (add1 (occur a (cdr l))))
          (else (occur a (cdr l)))))))

(define (one? a)
  (= a 1))

;; chapter five

(define (rember* a l)
  (cond
   ((null? l) l)
   ((atom? (car l))
    (cond
     ((eqan? (car l) a) (rember* a (cdr l)))
     (else (cons (car l) (rember* a (cdr l))))))
   (else
    (cons (rember* a (car l)) (rember* a (cdr l))) )))

(define (insertR* old new l)
  (cond
   ((null? l) l)
   ((atom? (car l))
    (cond
     ((eqan? (car l) old)
      (cons old
            (cons new (insertR* old new (cdr l)))))
     (else
      (cons (car l) (insertR* old new (cdr l))))))
   (else
    (cons
     (insertR* old new (car l))
     (insertR* old new (cdr l))))))

(define (occur* a l)
  (cond
   ((null? l) 0)
   ((atom? (car l))
    (cond
     ((eqan? (car l) a)
      (add1 (occur* a (cdr l))))
     (else (occur* a (cdr l)))))
   (else
    (o+ (occur* a (car l)) (occur* a (cdr l))))))

(define (subset* old new l)
  (cond
   ((null? l) l)
   ((atom? (car l))
    (cond
     ((eqan? (car l) old)
      (cons new
            (subset* old new (cdr l))))
     (else (cons (car l)
                 (subset* old new (cdr l))))))
   (else
    (cons (subset* old new (car l))
          (subset* old new (cdr l))))))

(define (insertL* old new l)
  (cond
   ((null? l) l)
   ((atom? (car l))
    (cond
     ((eqan? (car l) old)
      (cons new
            (cons old
                  (insertL* old new (cdr l)))))
     (else (cons (car l)
                 (insertL* old new (cdr l))))))
   (else
    (cons (insertL* old new (car l))
          (insertL* old new (cdr l))))))

(define (member* a l)
  (cond
   ((null? l) #f)
   ((atom? (car l))
    (or (eqan? (car l) a)
        (member* a (cdr l))))
   (else
    (or (member* a (car l))
        (member* a (cdr l))))))


(define (leftmost l)
  (cond
   ((atom? (car l)) (car l))
   (else
    (leftmost (car l)))))

(define (eqlist? l1 l2)
  (cond
   ((and (null? l1) (null? l2)) #t)
   ((or (null? l1) (null? l2)) #f)
   ((and (atom? (car l1)) (atom? (car l2)))
    (and
     (eqan? (car l1) (car l2))
     (eqlist? (cdr l1) (cdr l2))))
   ((or (atom? (car l1)) (atom? (car l2))) #f)
   (else
    (and (eqlist? (car l1) (car l2))
         (eqlist? (cdr l1) (cdr l2))))))


(define (eqlist2? l1 l2)
  (cond
   ((and (null? l1) (null? l2)) #t)
   ((or (null? l1) (null? l2)) #f)
   (else
    (and (equal? (car l1) (car l2))
         (equal? (cdr l1) (cdr l2))))))

(define (equal? s1 s2)
  (cond
   ((and (atom? s1) (atom? s2))
    (eqan? s1 s2))
   ((or (atom? s1) (atom? s2)) #f)
   (else
    (eqlist2? s1 s2))))


(define (numbered? aexp)
  (cond
   ((atom? aexp) (number? aexp))
   (else
    (and (numbered? (car aexp))
         (numbered? (car (cdr (cdr aexp))))))))

(define (1st-sub-exp aexp)
  (car (cdr aexp)))

(define (2nd-sub-exp aexp)
  (car (cdr (car aexp))))

(define (operator aexp)
  (car aexp))

(define (value aexp)
  (cond
   ((atom? aexp) aexp)
   (else
    (cond
     ((eqan? '+ (operator aexp))
      (+ (value (1st-sub-exp aexp))
         (value (2nd-sub-exp aexp))))
     ((eqan? '* (operator aexp))
      (* (value (1st-sub-exp aexp))
         (value (2nd-sub-exp aexp))))
     (else
      (expt (value (1st-sub-exp aexp))
            (value (2nd-sub-exp aexp))))))))

;; chapter seven

(define (set? l)
  (cond
   ((null? l) #t)
   ((member? (car l) (cdr l)) #f)
   (else
    (set? (cdr l)))))

(define (makeset l)
  (cond
   ((null? l) l)
   (else
    (cons (car l)
          (makeset (multirember (car l)
                                (cdr l)))))))

(define (subset? set1 set2)
  (cond
   ((null? set1) #t)
   (else
    (and (member? (car set1) set2)
         (subset? (cdr set1) set2)))))

(define (eqset? set1 set2)
  (and (subset? set1 set2)
       (subset? set2 set1)))

(define (intersect? set1 set2)
  (cond
   ((null? set1) #f)
   (else
    (or (member? (car set1) set2)
         (intersect? (cdr set1) set2)))))

(define (intersect set1 set2)
  (cond
   ((null? set1) set1)
   ((member? (car set1) set2)
    (cons (car set1) (intersect (cdr set1) set2)))
   (else
    (intersect (cdr set1) set2))))

(define (union set1 set2)
  (cond
   ((null? set1) set2)
   ((member? (car set1) set2)
    (union (cdr set1) set2))
   (else
    (cons
     (car set1)
     (union (cdr set1) set2)))))

(define (intersectall lset)
  (cond
   ((null? (cdr lset)) (car lset))
   (else
    (intersect (car lset)
               (intersectall (cdr lset))))))

(define (a-pair? l)
  (cond
   ((atom? l) #f)
   ((null? l) #f)
   ((null? (cdr l)) #f)
   ((null? (cdr (cdr l))) #t)
   (else #f)))

(define (first l)
  (car l))

(define (second l)
  (car (cdr l)))

(define (build s1 s2)
  (cons s1 (cons s2 '())))

(define (fun? l)
  (set? (firsts l)))

(define (revrel1 l)
  (cond
   ((null? l) l)
   (else
    (cons
     (build (second (car l))
            (first (car l)))
     (revrel1 (cdr l))))))

(define (revpair pair)
  (build (first pair)
         (second pair)))

(define (revrel2 l)
  (cond
   ((null? l) l)
   (else
    (cons
     (revpair (car l))
     (revrel2 (cdr l))))))

(define (seconds l)
  (cond
   ((null? l) l)
   (else
    (cons
     (car (cdr l))
     (seconds (cdr l))))))

(define (fullfun? fun)
  (set? (seconds fun)))


;; Chapter eight
