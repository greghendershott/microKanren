#lang racket

(require rackunit
         "microKanren.rkt"
         "microKanren-wrappers.rkt"
         "microKanren-test-programs.rkt")

(check-equal?
  (let (($ ((call/fresh (lambda (q) (== q 5))) empty-state)))
    (car $))
  '(((#(0) . 5)) . 1))

(check-equal?
  (let (($ ((call/fresh (lambda (q) (== q 5))) empty-state)))
    (cdr $))
  '())

(check-equal?
  (let (($ (a-and-b empty-state)))
    (car $))
  '(((#(1) . 5) (#(0) . 7)) . 2))

(check-equal?
  (let (($ (a-and-b empty-state)))
    (take 1 $))
  '((((#(1) . 5) (#(0) . 7)) . 2)))

(check-equal?
  (let (($ (a-and-b empty-state)))
    (car (cdr $)))
  '(((#(1) . 6) (#(0) . 7)) . 2))

(check-equal?
  (let (($ (a-and-b empty-state)))
    (cdr (cdr $)))
  '())

(check-equal?
  (let (($ ((call/fresh (lambda (q) (fives q))) empty-state)))
    (take 1 $))
  '((((#(0) . 5)) . 1)))

(check-equal?
  (let (($ (a-and-b empty-state)))
    (take 2 $))
  '((((#(1) . 5) (#(0) . 7)) . 2)
    (((#(1) . 6) (#(0) . 7)) . 2)))

(check-equal?
  (let (($ (a-and-b empty-state)))
    (take-all $))
  '((((#(1) . 5) (#(0) . 7)) . 2)
    (((#(1) . 6) (#(0) . 7)) . 2)))

(check-equal?
  (car ((ground-appendo empty-state)))
  '(((#(2) b) (#(1)) (#(0) . a)) . 3))

(check-equal?
  (car ((ground-appendo2 empty-state)))
  '(((#(2) b) (#(1)) (#(0) . a)) . 3))

(check-equal?
  (take 2 (call-appendo empty-state))
  '((((#(0) #(1) #(2) #(3)) (#(2) . #(3)) (#(1))) . 4)
    (((#(0) #(1) #(2) #(3)) (#(2) . #(6)) (#(5)) (#(3) #(4) . #(6)) (#(1) #(4) . #(5))) . 7)))

(check-equal?
  (take 2 (call-appendo2 empty-state))
  '((((#(0) #(1) #(2) #(3)) (#(2) . #(3)) (#(1))) . 4) (((#(0) #(1) #(2) #(3)) (#(3) #(4) . #(6)) (#(2) . #(6)) (#(5)) (#(1) #(4) . #(5))) . 7)))

(check-equal?
  (map reify-1st (take 2 (call-appendo empty-state)))
  '((() _.0 _.0) ((_.0) _.1 (_.0 . _.1))))

(check-equal?
  (map reify-1st (take 2 (call-appendo2 empty-state)))
  '((() _.0 _.0) ((_.0) _.1 (_.0 . _.1))))

(check-equal?
  (take 1 (many-non-ans empty-state))
  '((((#(0) . 3)) . 1)))
