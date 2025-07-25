;;! target = "x86_64"
;;! test = "compile"
;;! flags = " -C cranelift-enable-heap-access-spectre-mitigation=false -O static-memory-forced -O static-memory-guard-size=0 -O dynamic-memory-guard-size=0"

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i32 1)

  (func (export "do_store") (param i32 i32)
    local.get 0
    local.get 1
    i32.store offset=0xffff0000)

  (func (export "do_load") (param i32) (result i32)
    local.get 0
    i32.load offset=0xffff0000))

;; wasm[0]::function[0]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       movl    %edx, %r8d
;;       cmpq    $0xfffc, %r8
;;       ja      0x27
;;   14: addq    0x38(%rdi), %r8
;;       movl    $0xffff0000, %r11d
;;       movl    %ecx, (%r8, %r11)
;;       movq    %rbp, %rsp
;;       popq    %rbp
;;       retq
;;   27: ud2
;;
;; wasm[0]::function[1]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       movl    %edx, %r8d
;;       cmpq    $0xfffc, %r8
;;       ja      0x67
;;   54: addq    0x38(%rdi), %r8
;;       movl    $0xffff0000, %r11d
;;       movl    (%r8, %r11), %eax
;;       movq    %rbp, %rsp
;;       popq    %rbp
;;       retq
;;   67: ud2
