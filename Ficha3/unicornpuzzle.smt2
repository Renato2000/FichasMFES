(set-logic QF_UF)

(declare-fun mythical () Bool)
(declare-fun immortal () Bool)
(declare-fun mammal () Bool)
(declare-fun horned () Bool)
(declare-fun magical () Bool)

(assert (=> mythical immortal))
(assert (=> (not mythical) (and (not immortal) mammal)))
(assert (=> (or immortal mammal) horned))
(assert (=> horned magical))

(push)

;; verify if the unicorn is magical
(assert magical)

(echo "Is unicorn magical?")
(check-sat)

(pop)
(push)

;; verify if the unicorn is horned
(assert horned)

(echo "Is unicorn horned?")
(check-sat)

(pop)
(push)

;; verify if the unicorn is mythical
(assert mythical)

(echo "Is unicorn mythical?")
(check-sat)

(pop)