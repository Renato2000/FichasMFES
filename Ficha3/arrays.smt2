;; =========== PROGRAMA ===========
;; x = a[i];
;; y = y + x;
;; a[i] = 5 + a[i];
;; a[i+1] = a[i-1] - 5;

(set-logic QF_AUFLIA)

(declare-fun a0 () (Array Int Int))
(declare-const a1 (Array Int Int))
(declare-const a2 (Array Int Int))
(declare-const y0 Int)
(declare-const y1 Int)
(declare-const x1 Int)
(declare-const i0 Int)

(assert (= x1 (select a0 i0)))
(assert (= y1 (+ x1 y0)))
(assert (= a1 (store a0 i0 (+ 5 (select a0 i0)))))
(assert (= a2 (store a1 (+ i0 1) (- (select a1 (- i0 1)) 5))))

(push)

(echo "O programa é consistente?")
(check-sat)

;; verifica se: x + a[i-1] = a[i] + a[i+1]
(assert (not (= (+ x1 (select a2 (- i0 1))) (+ (select a2 i0) (select a2 (+ i0 1))))))

(echo "No final da execução, verifica que x + a[i-1] = a[i] + a[i+1]?")
(check-sat)

(pop)
(push)

;; verifica se: a[i-1] e a[i] é sempre positiva
(assert (not (and (> (select a2 (- i0 1)) 0) (> (select a2 i0) 0))))

(echo "No final da execução, verifica que a[i-1] e a[i] é sempre positiva?")
(check-sat)
;;(get-model)