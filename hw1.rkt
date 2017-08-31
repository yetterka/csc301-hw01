#lang racket
;;; Procedure:
;;;   heap-new
;;; Parameters:
;;;   higher-priority?, a binary predicate
;;; Purpose:
;;;   Create a new heap.
;;; Produces:
;;;   heap, a heap
(define heap-new
  (lambda (higher-priority?)
    (vector 0 (make-vector 21) higher-priority?)))

;;; Procedure:
;;;   get-vector-from-heap
;;; Parameters:
;;;   heap, a heap
;;; Purpose:
;;;   return the vector stored in the heap structure 
;;; Produces:
;;;   vector
(define get-vector-from-heap
  (lambda (heap)
    (vector-ref heap 1)))

;;; Procedure:
;;;   vector-last
;;; Parameters:
;;;   heap, a heap
;;; Purpose:
;;;   return index of the last element of a heap (stored in a vector). 
;;; Produces:
;;;   i, an index
(define vector-last
  (lambda (heap)
    (vector-ref heap 0)))

;;;Procedure:
;;;   swap
;;; Parameters:
;;;   vector
;;;   index-one
;;;   index-two
;;; Purpose:
;;;   switch two elements positions in a vector
;;; Produces:
;;;   return nothing, call for side-effect
(define swap!
  (lambda (vector index-one index-two)
    (let ([temp (vector-ref vector index-one)])
      (vector-set! vector index-one (vector-ref vector index-two))
      (vector-set! vector index-two temp))))

;;; Procedure:
;;;   percolate-up!
;;; Parameters:
;;;   heap, a heap
;;;   pos, the current position in the heap
;;; Purpose:
;;;   Sort through the heap by priority
;;; Produces:
;;;   heap, a heap
(define percolate-up!
  (lambda (heap pos)
    (let ([vec (vector-ref heap 1)]
          [higher-priority? (vector-ref heap 2)])
      (let kernel ([pos-new pos])
        (if (zero? pos-new)
            (void)
            (if (higher-priority? (vector-ref vec pos-new)
                                  (vector-ref vec (quotient pos-new 2)))
                (swap! vec (quotient pos-new 2) pos-new)
                (kernel (quotient pos-new 2))))))))

;;; Procedure:
;;;   percolate-down!
;;; Parameters:
;;;   heap, a heap
;;;   pos, the current position in the heap
;;; Purpose:
;;;   Sort through the heap by priority
;;; Produces:
;;;   heap, a heap
(define percolate-down!
  (lambda (heap)
    (let ([vec (vector-ref heap 1)]
          [higher-priority? (vector-ref heap 2)]
          [length (vector-ref heap 0)])
      (swap! vec 0 (- length 1)
      (let kernel ([pos-new 0])
        (cond [(eq? pos-new length) (void)]
              [(not (higher-priority? (vector-ref vec pos-new)
                                  (vector-ref vec (+ (* pos-new 2) 1))))
                (swap! vec (+ (* pos-new 2) 1) pos-new)
                (kernel (+ (quotient pos-new 2) 1))]
              [(not (higher-priority? (vector-ref vec pos-new)
                                  (vector-ref vec (+ (* pos-new 2) 2))))
                (swap! vec (+ (* pos-new 2) 2) pos-new)
                (kernel (+ (* pos-new 2)2))]))))))
;;;Procedure:
;;;   first
;;; Parameters:
;;;   heap, a heap
;;; Purpose:
;;;   return the element of highest priority
;;; Produces:
;;;   fill me in
(define first
  (lambda (heap)
    (if (= (vector-ref heap 0) 0)
        (error "The heap is empty")
        (vector-ref (get-vector-from-heap heap) 0))))

;;;Procedure:
;;;   get
;;; Parameters:
;;;   heap, a heap
;;; Purpose:
;;;   return the element of highest priority,and remove it from the vector
;;; Produces:
;;;   fill me in
(define get
  (lambda (heap)
    (let ([len (vector-ref heap 0)])
    (vector-set! heap 0 (- len 1))
    (vector-ref (get-vector-from-heap heap) (+ 1 (vector-last heap))))))
        
;;;Procedure:
;;;   expand
;;; Parameters:
;;;   heap
;;; Purpose:
;;;   double the size of the heap and re-copy original heap elements
;;; Produces:
;;;   new heap with old heap copied in the front
(define expand!
  (lambda (heap)
    (let* ([len (vector-ref heap 0)]
          [vec (vector-ref heap 1)]
          [new-vec (make-vector (* len 2))])
      (vector-copy! new-vec 0 vec)
      (vector-set! heap 1 new-vec))))

;;;Procedure:
;;;   add
;;; Parameters:
;;;   heap, a heap
;;;   value, a value
;;; Purpose:
;;;   add a value to the heap
;;; Produces:
;;;   return nothing, call for side-effect
(define add
  (lambda (heap value)
    (let ([vec (get-vector-from-heap heap)]
          [len (vector-ref heap 0)])
    (when(>= len (vector-length vec))
        (expand! heap))
    (vector-set! (get-vector-from-heap heap) (vector-last heap) value)
    (vector-set! heap 0 (+ len 1))
    (percolate-up! heap len))))
