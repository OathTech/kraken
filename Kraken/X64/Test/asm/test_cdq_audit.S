movq $-1, %rax
movq $0, %rcx
subq $1, %rcx           # cf = 1, sf = 1, pf = 1, af = 1
movq $0x8000000000000000, %rax
cqto                    # rdx = -1
movq %rdx, %r8
movq $0x00000000ffffffff, %rax
cltd                    # rdx = 0x00000000ffffffff
movq %rdx, %r9
movq $0xffffffff00000000, %rax
cltd                    # rdx = 0
movq %rdx, %r10
movq $0xffffffffffff7fff, %rax
movq $0xffffffffffffffff, %rdx
cwtd                    # rdx = 0xffffffffffff0000
movq %rdx, %r11
