movq $0x1234, %rdi
push %rdi
movq %rsp, %rbp
movq $0x4567, %rdi
push %rdi
push %rdi
leave
