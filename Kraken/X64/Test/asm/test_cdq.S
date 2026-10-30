# Test: CWD/CDQ/CQO (AT&T cwtd/cltd/cqto)
# The sign of ax/eax/rax fills dx/edx/rdx. A 32-bit write zero-extends rdx; a 16-bit write keeps
# the upper 48 bits of rdx. No flag is affected.

# ----- cqto: rax negative, then positive -----
movq $-1, %rax
cqto                    # rdx = 0xffffffffffffffff
movq %rdx, %r8
movq $5, %rax
cqto                    # rdx = 0
movq %rdx, %r9

# ----- cltd: eax negative (the upper half of rax is irrelevant), rdx zero-extended -----
movq $0x7fffffff80000000, %rax
movq $0x1234567812345678, %rdx
cltd                    # rdx = 0x00000000ffffffff
movq %rdx, %r10
movq $0x7fffffff, %rax
movq $0x1234567812345678, %rdx
cltd                    # rdx = 0
movq %rdx, %r11

# ----- cwtd: ax negative, the upper 48 bits of rdx preserved -----
movq $0x8000, %rax
movq $0x1234567812345678, %rdx
cwtd                    # rdx = 0x123456781234ffff
movq %rdx, %r12
movq $0x7fff, %rax
movq $0x1234567812345678, %rdx
cwtd                    # rdx = 0x1234567812340000
