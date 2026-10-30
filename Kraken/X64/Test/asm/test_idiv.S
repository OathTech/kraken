# Undefined flags: cf, pf, af, zf, sf, of
# Test: IDIV at every operand width (Intel SDM Vol. 2A, IDIV)
# The quotient is truncated toward zero, the remainder has the dividend's sign; the dividend is
# rdx:rax, edx:eax, dx:ax, or ax for the 8-bit form, whose quotient goes to al and remainder to ah.
# A zero divisor or an out-of-range quotient would be #DE and is not exercised here.

# ----- idivq: negative dividend, positive divisor -----
movq $-100, %rax
cqto
movq $7, %rcx
idivq %rcx              # rax = -14, rdx = -2
movq %rax, %r8
movq %rdx, %r9

# ----- idivq: positive dividend, negative divisor -----
movq $100, %rax
cqto
movq $-7, %rcx
idivq %rcx              # rax = -14, rdx = 2
movq %rax, %r10
movq %rdx, %r11

# ----- idivl: the 32-bit results zero-extend rax and rdx -----
movl $-100, %eax
cltd
movl $7, %ecx
idivl %ecx              # rax = 0x00000000fffffff2, rdx = 0x00000000fffffffe
movq %rax, %r12
movq %rdx, %r13

# ----- idivw: the 16-bit results keep the upper bits of rax and rdx -----
movq $0x1234567800000000, %rax
movw $-100, %ax
movq $0x1234567800000000, %rdx
cwtd                    # dx = 0xffff
movw $7, %cx
idivw %cx               # rax = 0x12345678_0000_fff2, rdx = 0x12345678_0000_fffe
movq %rax, %r14
movq %rdx, %r15

# ----- idivb: ax / cl into al (quotient) and ah (remainder) -----
movq $0, %rax
movw $-100, %ax         # ax = 0xff9c
movb $7, %cl
idivb %cl               # al = 0xf2 (-14), ah = 0xfe (-2): rax = 0xfef2
movq %rax, %rbx

# ----- idivq with a memory divisor -----
movq $-9, %rsi
pushq %rsi
movq $100, %rax
cqto
idivq (%rsp)            # rax = -11, rdx = 1
popq %rsi
movq %rax, %rdi         # rdi = -11; rdx = 1 is left as is
