; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -indvars -dce -disable-lftr -S | FileCheck %s

; LFTR should not eliminate the need for the computation of i*i completely
; due to LFTR is disabled.

; Provide legal integer types.
target datalayout = "n8:16:32:64"

@A = external global i32

define i32 @quadratic_setlt() {
; CHECK-LABEL: @quadratic_setlt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[I:%.*]] = phi i32 [ 7, [[ENTRY:%.*]] ], [ [[I_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[I_NEXT]] = add nuw nsw i32 [[I]], 1
; CHECK-NEXT:    store i32 [[I]], i32* @A
; CHECK-NEXT:    [[I2:%.*]] = mul i32 [[I]], [[I]]
; CHECK-NEXT:    [[C:%.*]] = icmp slt i32 [[I2]], 1000
; CHECK-NEXT:    br i1 [[C]], label [[LOOP]], label [[LOOPEXIT:%.*]]
; CHECK:       loopexit:
; CHECK-NEXT:    ret i32 32
;
entry:
  br label %loop

loop:
  %i = phi i32 [ 7, %entry ], [ %i.next, %loop ]
  %i.next = add i32 %i, 1
  store i32 %i, i32* @A
  %i2 = mul i32 %i, %i
  %c = icmp slt i32 %i2, 1000
  br i1 %c, label %loop, label %loopexit

loopexit:
  ret i32 %i
}

