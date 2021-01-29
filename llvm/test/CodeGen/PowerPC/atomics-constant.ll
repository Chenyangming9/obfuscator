; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s | FileCheck %s

target triple = "powerpc64le-unknown-linux-gnu"

@a = constant i64 zeroinitializer

define i64 @foo() {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addis 3, 2, a@toc@ha
; CHECK-NEXT:    li 4, 0
; CHECK-NEXT:    addi 3, 3, a@toc@l
; CHECK-NEXT:    cmpd 7, 4, 4
; CHECK-NEXT:    ld 3, 0(3)
; CHECK-NEXT:    li 3, 0
; CHECK-NEXT:    bne- 7, .+4
; CHECK-NEXT:    isync
; CHECK-NEXT:    blr
entry:
  %value = load atomic i64, i64* @a acquire, align 8
  ret i64 %value
}
