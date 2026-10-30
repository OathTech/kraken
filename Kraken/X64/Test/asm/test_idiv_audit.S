# Undefined flags: cf, pf, af, zf, sf, of
movq $1, %rdx
movq $5, %rax
movq $3, %rcx
idivq %rcx              # rdx:rax = 2^64 + 5: rax = 6148914691236517207, rdx = 0
movq %rax, %r8
movq %rdx, %r9
movq $0x1234567800000001, %rdx
movq $0x1234567800000000, %rax
movl $3, %ecx
idivl %ecx              # edx:eax = 2^32: rax = 0x55555555, rdx = 1
movq %rax, %r10
movq %rdx, %r11
movq $0xabcdef0100000001, %rdx
movq $0xabcdef0100000000, %rax
movw $3, %cx
idivw %cx               # dx:ax = 65536: ax = 0x5555, dx = 1, the upper bits of rax/rdx kept
movq %rax, %r12
movq %rdx, %r13
movq $0x102, %rax
movb $5, %cl
idivb %cl               # ax = 258: al = 51, ah = 3
movq %rax, %r14
movq $100, %rax
movb $-7, %cl
idivb %cl               # al = -14, ah = 2
movq %rax, %r15
movl $-100, %eax
cltd
movl $-7, %ecx
idivl %ecx              # -100 / -7 = 14 r -2
movq %rax, %rbx
movq %rdx, %rsi
