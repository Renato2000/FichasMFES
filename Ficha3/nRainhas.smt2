(set-logic QF_BV)

; The 4 rows are represented by 4 bitvectors of length 4
(declare-fun r1() (_ BitVec 4))
(declare-fun r2() (_ BitVec 4))
(declare-fun r3() (_ BitVec 4))
(declare-fun r4() (_ BitVec 4))

(bvand #b110 #b011)          ; bitwise and
(bvxor #x6 #x3)              ; bitwise xor
(bvsub #b00000111 #b0000011) ; subtraction
(bvshl #x07 #x03)            ; shift left
(bvlshr #xf0 #x03)           ; unsigned (logical) shift right