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
    (vector 0 (make-vector 2) higher-priority?)))

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
;;;   first
;;; Parameters:
;;;   heap, a heap
;;; Purpose:
;;;   return the element of highest priority
;;; Produces:
;;;   fill me in
(define first
  (lambda (heap)
    (vector-ref (get-vector-from-heap heap) (vector-last heap))))

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
;;;   swap
;;; Parameters:
;;;   vector
;;;   index-one
;;;   index-two
;;; Purpose:
;;;   switch two elements positions in a vector
;;; Produces:
;;;   return nothing, call for side-effect
(define swap
  (lambda (heap index-one index-two)
    (let* ((vector (get-vector-from-heap heap))
          (temp (vector-ref vector index-one)))
      (vector-set! vector index-one (vector-ref vector index-two))
      (vector-set! vector index-two temp)
      heap)))

;;;Procedure:
;;;   sort-by-priority
;;; Parameters:
;;;   heap, a heap
;;; Purpose:
;;;   reorder the vector in the heap by priority
;;; Produces:
;;;   return nothing, call for side-effect
(define sort-by-priority
  (lambda (heap index)
    (let ([vec (get-vector-from-heap heap)]
          [higher-priority?(vector-ref heap 2)])
    (if (<= index 0)
        heap
        (if (higher-priority? (vector-ref vec index) (vector-ref vec (- index 1)))
            heap
            (sort-by-priority (swap heap (- index 1) index) (- index 1)))))))
        
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
    (sort-by-priority heap len))))
