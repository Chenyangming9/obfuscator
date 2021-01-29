; RUN: opt %loadPolly -polly-codegen -S < %s | FileCheck %s
;
; Check for the correct written value of a scalar phi write whose value is
; defined within the loop, but its effective value is its last definition when
; leaving the loop (in this test it is the value 2 for %i.inc). This can be
; either computed:
; - Using SCEVExpander:
;         In this case the Loop passed to the expander must NOT be the loop
; - Overwriting the same alloca in each iteration s.t. the last value will
;         retain in %i.inc.s2a
; The first is currently generated by Polly and tested here.

; CHECK:      polly.stmt.next:
; CHECK-NEXT:   store i32 2, i32* %phi.phiops
; CHECK-NEXT:   br label %polly.stmt.join

define i32 @func() {
entry:
  br label %start

start:
  br i1 true, label %loop, label %join

loop:
  %i = phi i32 [ 0, %start ], [ %i.inc, %loop ]
  %i.inc = add nsw i32 %i, 1
  %cond = icmp slt i32 %i.inc, 2
  br i1 %cond, label %loop, label %next

next:
  br label %join

join:
  %phi = phi i32 [%i.inc, %next], [0, %start]
  br label %return

return:
  ret i32 %phi
}
