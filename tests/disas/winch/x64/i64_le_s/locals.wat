;;! target = "x86_64"
;;! test = "winch"

(module
    (func (result i32)
        (local $foo i64)
        (local $bar i64)

        (i64.const 2)
        (local.set $foo)
        (i64.const 3)
        (local.set $bar)

        (local.get $foo)
        (local.get $bar)
        (i64.le_s)
    )
)
;; wasm[0]::function[0]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       movq    8(%rdi), %r11
;;       movq    0x10(%r11), %r11
;;       addq    $0x20, %r11
;;       cmpq    %rsp, %r11
;;       ja      0x6e
;;   1c: movq    %rdi, %r14
;;       subq    $0x20, %rsp
;;       movq    %rdi, 0x18(%rsp)
;;       movq    %rsi, 0x10(%rsp)
;;       xorq    %r11, %r11
;;       movq    %r11, 8(%rsp)
;;       movq    %r11, (%rsp)
;;       movl    $2, %eax
;;       movq    %rax, 8(%rsp)
;;       movl    $3, %eax
;;       movq    %rax, (%rsp)
;;       movq    (%rsp), %rax
;;       movq    8(%rsp), %rcx
;;       cmpq    %rax, %rcx
;;       movl    $0, %ecx
;;       setle   %cl
;;       movl    %ecx, %eax
;;       addq    $0x20, %rsp
;;       popq    %rbp
;;       retq
;;   6e: ud2
