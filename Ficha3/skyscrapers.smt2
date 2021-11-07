(set-logic QF_UFLIA)

;      - - - <- 1
;      - - -
; 2 -> - - -
;          |
;          3

(declare-const a1 Int)
(declare-const a2 Int)
(declare-const a3 Int)
(declare-const b1 Int)
(declare-const b2 Int)
(declare-const b3 Int)
(declare-const c1 Int)
(declare-const c2 Int)
(declare-const c3 Int)

(declare-fun visiveis ((a1 Int) (a2 Int) (a3 Int) Int) (ite (And (< a1 a2) (< a2 a3)) 3 (ite (> a1 a2) 1 2)))

(assert (> a1 0))
(assert (> a2 0))
(assert (> a3 0))
(assert (> b1 0))
(assert (> b2 0))
(assert (> b3 0))
(assert (> c1 0))
(assert (> c2 0))
(assert (> c3 0))
(assert (<= a1 3))
(assert (<= a2 3))
(assert (<= a3 3))
(assert (<= b1 3))
(assert (<= b2 3))
(assert (<= b3 3))
(assert (<= c1 3))
(assert (<= c2 3))
(assert (<= c3 3))
(assert (= (visiveis a3 a2 a1) 1))
(assert (= (visiveis c1 c2 c3) 2))
(assert (= (visiveis c3 b3 a3) 3))

(check-sat)
(get-model)