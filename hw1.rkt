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
    (vector 0 (make-vector 31) higher-priority?)))

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
    (letrec ((vector (get-vector-from-heap heap))
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
;;;   
;;;   value, a value
;;; Purpose:
;;;   add a value to the heap
;;; Produces:
;;;   new heap with old heap copied
    

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
        "double me!")
    (vector-set! vec (vector-last heap) value)
    (vector-set! heap 0 (+ len 1))
    (sort-by-priority heap len))))


(define v
  (heap-new >))
(add v 324)
(add v 100)
(add v 40)
(add v 200)
