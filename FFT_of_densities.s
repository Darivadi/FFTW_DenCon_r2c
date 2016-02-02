	.file	"FFT_of_densities.c"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"grep -v \"#\" %s | grep -v \"^$\" | gawk -F\"=\" '{print $2}' > %s.dump"
	.text
	.p2align 4,,15
	.globl	conf2dump
	.type	conf2dump, @function
conf2dump:
.LFB42:
	.cfi_startproc
	subq	$1016, %rsp
	.cfi_def_cfa_offset 1024
	movq	%rdi, %r8
	movq	%rdi, %r9
	movq	%fs:40, %rax
	movq	%rax, 1000(%rsp)
	xorl	%eax, %eax
	movl	$1000, %edx
	movl	$.LC0, %ecx
	movl	$1, %esi
	movq	%rsp, %rdi
	call	__sprintf_chk
	movq	%rsp, %rdi
	call	system
	xorl	%eax, %eax
	movq	1000(%rsp), %rdx
	xorq	%fs:40, %rdx
	jne	.L5
	addq	$1016, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L5:
	.cfi_restore_state
	call	__stack_chk_fail
	.cfi_endproc
.LFE42:
	.size	conf2dump, .-conf2dump
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"r"
	.section	.rodata.str1.8
	.align 8
.LC2:
	.string	"  * The file '%s' doesn't exist!\n"
	.section	.rodata.str1.1
.LC3:
	.string	"%s.dump"
.LC4:
	.string	"%d"
.LC5:
	.string	"%lf"
.LC6:
	.string	"%s"
	.section	.rodata.str1.8
	.align 8
.LC8:
	.string	"  * The file '%s' has been loaded!\n"
	.section	.rodata.str1.1
.LC9:
	.string	"rm -rf %s.dump"
	.text
	.p2align 4,,15
	.globl	read_parameters
	.type	read_parameters, @function
read_parameters:
.LFB43:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$.LC1, %esi
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$2024, %rsp
	.cfi_def_cfa_offset 2048
	movq	%fs:40, %rax
	movq	%rax, 2008(%rsp)
	xorl	%eax, %eax
	call	fopen
	testq	%rax, %rax
	je	.L11
	movq	%rax, %rdi
	call	fclose
	leaq	1008(%rsp), %rdi
	movq	%rbp, %r9
	movq	%rbp, %r8
	movl	$.LC0, %ecx
	movl	$1000, %edx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__sprintf_chk
	leaq	1008(%rsp), %rdi
	call	system
	leaq	1008(%rsp), %rdi
	movq	%rbp, %r8
	movl	$.LC3, %ecx
	movl	$1000, %edx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__sprintf_chk
	leaq	1008(%rsp), %rdi
	movl	$.LC1, %esi
	call	fopen
	movl	$GV+1016, %edx
	movq	%rax, %rbx
	movq	%rax, %rdi
	movl	$.LC4, %esi
	xorl	%eax, %eax
	call	__isoc99_fscanf
	movl	$GV+1008, %edx
	movl	$.LC5, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	__isoc99_fscanf
	movl	$GV, %edx
	movl	$.LC6, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	__isoc99_fscanf
	movl	$GV+1096, %edx
	movl	$.LC5, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	__isoc99_fscanf
	movl	$GV+1104, %edx
	movl	$.LC5, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	__isoc99_fscanf
	movl	$GV+1072, %edx
	movl	$.LC5, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	__isoc99_fscanf
	movl	$GV+1064, %edx
	movl	$.LC5, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	__isoc99_fscanf
	movsd	.LC7(%rip), %xmm0
	movq	%rbx, %rdi
	movsd	GV+1072(%rip), %xmm1
	addsd	%xmm0, %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, GV+1080(%rip)
	call	fclose
	movq	%rbp, %rdx
	movl	$.LC8, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	movq	%rbp, %r8
	movl	$.LC9, %ecx
	movl	$1000, %edx
	movl	$1, %esi
	movq	%rsp, %rdi
	xorl	%eax, %eax
	call	__sprintf_chk
	movq	%rsp, %rdi
	call	system
	xorl	%eax, %eax
.L8:
	movq	2008(%rsp), %rcx
	xorq	%fs:40, %rcx
	jne	.L12
	addq	$2024, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	.cfi_restore_state
	movq	%rbp, %rdx
	movl	$.LC2, %esi
	movl	$1, %edi
	call	__printf_chk
	movl	$1, %eax
	jmp	.L8
.L12:
	call	__stack_chk_fail
	.cfi_endproc
.LFE43:
	.size	read_parameters, .-read_parameters
	.section	.rodata.str1.8
	.align 8
.LC10:
	.string	"%d %d %lf %lf %lf %lf %lf %lf %lf"
	.align 8
.LC11:
	.string	"%d %lf %lf %lf %lf %lf %lf %lf\n"
	.text
	.p2align 4,,15
	.globl	read_data
	.type	read_data, @function
read_data:
.LFB44:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	$.LC1, %esi
	movl	$1125899907, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	xorl	%ebx, %ebx
	subq	$1064, %rsp
	.cfi_def_cfa_offset 1104
	movq	%fs:40, %rax
	movq	%rax, 1048(%rsp)
	xorl	%eax, %eax
	call	fopen
	leaq	48(%rsp), %rdi
	movq	%rax, %rdx
	movl	$1000, %esi
	movq	%rax, %r12
	call	fgets
	movl	GV+1020(%rip), %eax
	testl	%eax, %eax
	jg	.L19
	jmp	.L16
	.p2align 4,,10
	.p2align 3
.L15:
	addl	$1, %ebx
	addq	$296, %rbp
	cmpl	%ebx, GV+1020(%rip)
	jle	.L16
.L19:
	movq	%rbp, %r8
	addq	gp(%rip), %r8
	movl	$.LC10, %esi
	movq	%r12, %rdi
	leaq	32(%r8), %rax
	leaq	28(%r8), %rdx
	leaq	24(%r8), %rcx
	leaq	8(%r8), %r9
	movq	%rax, 32(%rsp)
	leaq	144(%r8), %rax
	movq	%rax, 24(%rsp)
	leaq	136(%r8), %rax
	movq	%rax, 16(%rsp)
	leaq	128(%r8), %rax
	movq	%rax, 8(%rsp)
	leaq	16(%r8), %rax
	movq	%rax, (%rsp)
	xorl	%eax, %eax
	call	__isoc99_fscanf
	movl	%ebx, %eax
	imull	%r13d
	movl	%ebx, %eax
	sarl	$31, %eax
	sarl	$18, %edx
	subl	%eax, %edx
	imull	$1000000, %edx, %edx
	cmpl	%edx, %ebx
	jne	.L15
	movq	%rbp, %rax
	addq	gp(%rip), %rax
	movl	$.LC11, %esi
	movl	$1, %edi
	movl	28(%rax), %edx
	movsd	32(%rax), %xmm6
	movsd	144(%rax), %xmm5
	movsd	136(%rax), %xmm4
	movsd	128(%rax), %xmm3
	movsd	16(%rax), %xmm2
	movsd	8(%rax), %xmm1
	movsd	(%rax), %xmm0
	movl	$7, %eax
	call	__printf_chk
	jmp	.L15
	.p2align 4,,10
	.p2align 3
.L16:
	movq	%r12, %rdi
	call	fclose
	xorl	%eax, %eax
	movq	1048(%rsp), %rsi
	xorq	%fs:40, %rsi
	jne	.L22
	addq	$1064, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L22:
	.cfi_restore_state
	call	__stack_chk_fail
	.cfi_endproc
.LFE44:
	.size	read_data, .-read_data
	.section	.rodata.str1.8
	.align 8
.LC12:
	.string	"-----------------------------------------------"
	.section	.rodata.str1.1
.LC13:
	.string	"Cosmological parameters:"
	.section	.rodata.str1.8
	.align 8
.LC14:
	.string	"OmegaM0=%lf OmegaL0=%lf redshift=%lf HubbleParam=%lf\n"
	.section	.rodata.str1.1
.LC15:
	.string	"Simulation parameters:"
.LC16:
	.string	"L=%lf\n"
	.text
	.p2align 4,,15
	.globl	read_binary
	.type	read_binary, @function
read_binary:
.LFB45:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movl	$.LC1, %esi
	movl	$GV, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	call	fopen
	movl	$1, %edx
	movq	%rax, %rbp
	movq	%rax, %rcx
	movl	$8, %esi
	movl	$GV+1008, %edi
	call	fread
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$8, %esi
	movl	$GV+1096, %edi
	call	fread
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$8, %esi
	movl	$GV+1104, %edi
	call	fread
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$8, %esi
	movl	$GV+1072, %edi
	call	fread
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$8, %esi
	movl	$GV+1064, %edi
	call	fread
	movsd	.LC7(%rip), %xmm0
	movl	$.LC12, %edi
	movsd	GV+1072(%rip), %xmm1
	addsd	%xmm0, %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, GV+1080(%rip)
	call	puts
	movl	$.LC13, %edi
	call	puts
	movsd	GV+1064(%rip), %xmm3
	movl	$.LC14, %esi
	movsd	GV+1072(%rip), %xmm2
	movl	$1, %edi
	movsd	GV+1104(%rip), %xmm1
	movl	$4, %eax
	movsd	GV+1096(%rip), %xmm0
	call	__printf_chk
	movl	$.LC12, %edi
	call	puts
	movl	$.LC15, %edi
	call	puts
	movsd	GV+1008(%rip), %xmm0
	movl	$.LC16, %esi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk
	movl	$.LC12, %edi
	call	puts
	movl	GV+1020(%rip), %eax
	testl	%eax, %eax
	jle	.L25
	xorl	%ebx, %ebx
	xorl	%r12d, %r12d
	.p2align 4,,10
	.p2align 3
.L26:
	movq	%rbx, %rdi
	addq	gp(%rip), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	addl	$1, %r12d
	addq	$28, %rdi
	call	fread
	movq	%rbx, %rdi
	addq	gp(%rip), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	addq	$24, %rdi
	call	fread
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$8, %esi
	movq	%rsp, %rdi
	call	fread
	movq	%rbx, %rdx
	addq	gp(%rip), %rdx
	movq	%rbp, %rcx
	movsd	(%rsp), %xmm0
	movl	$8, %esi
	addq	$296, %rbx
	movsd	%xmm0, (%rdx)
	leaq	32(%rdx), %rdi
	movsd	8(%rsp), %xmm0
	movsd	%xmm0, 8(%rdx)
	movsd	16(%rsp), %xmm0
	movsd	%xmm0, 16(%rdx)
	movl	$1, %edx
	call	fread
	cmpl	%r12d, GV+1020(%rip)
	jg	.L26
.L25:
	movq	%rbp, %rdi
	call	fclose
	addq	$32, %rsp
	.cfi_def_cfa_offset 32
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE45:
	.size	read_binary, .-read_binary
	.section	.rodata.str1.1
.LC17:
	.string	"w"
	.section	.rodata.str1.8
	.align 8
.LC18:
	.string	"./../Processed_data/DenCon_Pot_PotDot.bin"
	.text
	.p2align 4,,15
	.globl	write_binary
	.type	write_binary, @function
write_binary:
.LFB46:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movl	$.LC17, %esi
	movl	$.LC18, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	call	fopen
	movl	$1, %edx
	movq	%rax, %rbp
	movq	%rax, %rcx
	movl	$8, %esi
	movl	$GV+1008, %edi
	call	fwrite
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$8, %esi
	movl	$GV+1096, %edi
	call	fwrite
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$8, %esi
	movl	$GV+1104, %edi
	call	fwrite
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$8, %esi
	movl	$GV+1072, %edi
	call	fwrite
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$8, %esi
	movl	$GV+1064, %edi
	call	fwrite
	movl	GV+1020(%rip), %eax
	testl	%eax, %eax
	jle	.L31
	xorl	%ebx, %ebx
	xorl	%r12d, %r12d
	.p2align 4,,10
	.p2align 3
.L32:
	movq	%rbx, %rdi
	addq	gp(%rip), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	addl	$1, %r12d
	addq	$28, %rdi
	call	fwrite
	movq	%rbx, %rax
	addq	gp(%rip), %rax
	movq	%rbp, %rcx
	movl	$3, %edx
	movl	$8, %esi
	movq	%rsp, %rdi
	movsd	(%rax), %xmm0
	movsd	%xmm0, (%rsp)
	movsd	8(%rax), %xmm0
	movsd	%xmm0, 8(%rsp)
	movsd	16(%rax), %xmm0
	movsd	%xmm0, 16(%rsp)
	call	fwrite
	movq	%rbx, %rdi
	addq	gp(%rip), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$8, %esi
	addq	$32, %rdi
	call	fwrite
	movq	%rbx, %rdi
	addq	gp(%rip), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$8, %esi
	addq	$216, %rdi
	call	fwrite
	movq	%rbx, %rdi
	addq	gp(%rip), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$8, %esi
	addq	$248, %rdi
	call	fwrite
	movq	%rbx, %rdi
	addq	gp(%rip), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$8, %esi
	addq	$296, %rbx
	addq	$272, %rdi
	call	fwrite
	cmpl	%r12d, GV+1020(%rip)
	jg	.L32
.L31:
	movq	%rbp, %rdi
	call	fclose
	addq	$32, %rsp
	.cfi_def_cfa_offset 32
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE46:
	.size	write_binary, .-write_binary
	.section	.rodata.str1.8
	.align 8
.LC20:
	.string	"Copy of input of Density Contrast for FFTW finished."
	.align 8
.LC21:
	.string	"-----------------------------------------------------------------"
	.align 8
.LC22:
	.string	"FFT: density contrast r2k out-of-place finished!"
	.section	.rodata.str1.1
.LC23:
	.string	"./../DenCon_k_raw.dat"
.LC24:
	.string	"Im_DenCon"
.LC25:
	.string	"Re_DenCon"
.LC26:
	.string	"#"
.LC27:
	.string	"%s%14s %15s\n"
	.section	.rodata.str1.8
	.align 8
.LC28:
	.string	"Inverse FFT for contrast density finished!"
	.section	.rodata.str1.1
.LC29:
	.string	"./../Testing_c2r.dat"
.LC30:
	.string	"Reconstruted"
.LC31:
	.string	"DenCon"
.LC32:
	.string	"%s%9s %15s\n"
.LC33:
	.string	"%10d %16.8lf %16.8lf\n"
.LC34:
	.string	"Freeing up memory!"
	.section	.rodata.str1.8
	.align 8
.LC35:
	.string	"--------------------------------------------------"
	.section	.rodata.str1.1
.LC36:
	.string	"Destroying plans!"
.LC37:
	.string	"plan_r2k destroyed!"
.LC39:
	.string	"k vectors computed!"
	.section	.rodata.str1.8
	.align 8
.LC40:
	.string	"------------------------------------------------"
	.align 8
.LC41:
	.string	"Computing density contrast in k space with CIC weight-function!"
	.align 8
.LC42:
	.string	"Density contrast in k-space with CIC weight fn ready!!"
	.section	.rodata.str1.1
.LC43:
	.string	"FFT_transform code finished!"
	.text
	.p2align 4,,15
	.globl	transform
	.type	transform, @function
transform:
.LFB47:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movslq	GV+1020(%rip), %rdi
	salq	$3, %rdi
	call	fftw_malloc
	movslq	GV+1040(%rip), %rdi
	movq	%rax, %rbp
	salq	$4, %rdi
	call	fftw_malloc
	movl	GV+1020(%rip), %ecx
	movq	%rax, %r12
	xorl	%eax, %eax
	movq	gp(%rip), %rdx
	testl	%ecx, %ecx
	jle	.L39
.L78:
	movsd	32(%rdx), %xmm0
	addq	$296, %rdx
	movsd	%xmm0, 0(%rbp,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %ecx
	jg	.L78
.L39:
	movl	$.LC20, %edi
	xorl	%r14d, %r14d
	xorl	%r13d, %r13d
	call	puts
	movl	$.LC21, %edi
	movq	%r12, %rbx
	call	puts
	movl	GV+1016(%rip), %edi
	movl	$64, %r9d
	movq	%r12, %r8
	movq	%rbp, %rcx
	movl	%edi, %edx
	movl	%edi, %esi
	call	fftw_plan_dft_r2c_3d
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	fftw_execute
	movl	$.LC22, %edi
	call	puts
	movl	$.LC21, %edi
	call	puts
	movl	$.LC17, %esi
	movl	$.LC23, %edi
	call	fopen
	movl	$.LC27, %edx
	movq	%rax, %rdi
	movq	%rax, %r15
	movl	$.LC24, %r9d
	xorl	%eax, %eax
	movl	$.LC25, %r8d
	movl	$.LC26, %ecx
	movl	$1, %esi
	call	__fprintf_chk
	movl	GV+1040(%rip), %edx
	testl	%edx, %edx
	jle	.L38
.L79:
	movsd	GV+1024(%rip), %xmm1
	movq	%r14, %rax
	addq	gp(%rip), %rax
	movsd	(%rbx), %xmm0
	movl	%r13d, %ecx
	movl	$.LC33, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	divsd	%xmm1, %xmm0
	addl	$1, %r13d
	addq	$296, %r14
	addq	$16, %rbx
	movsd	%xmm0, 40(%rax)
	movsd	-8(%rbx), %xmm0
	divsd	%xmm1, %xmm0
	movsd	%xmm0, 48(%rax)
	movl	$2, %eax
	movsd	-8(%rbx), %xmm1
	movsd	-16(%rbx), %xmm0
	call	__fprintf_chk
	cmpl	%r13d, GV+1040(%rip)
	jg	.L79
.L38:
	movq	%r15, %rdi
	xorl	%r14d, %r14d
	xorl	%r15d, %r15d
	call	fclose
	movslq	GV+1020(%rip), %rdi
	salq	$3, %rdi
	call	fftw_malloc
	movl	GV+1016(%rip), %edi
	movl	$64, %r9d
	movq	%rax, %r8
	movq	%r12, %rcx
	movq	%rax, %r13
	movq	%rax, 16(%rsp)
	movl	%edi, %edx
	movl	%edi, %esi
	call	fftw_plan_dft_c2r_3d
	movq	%rax, %rdi
	movq	%rax, 24(%rsp)
	call	fftw_execute
	movl	$.LC28, %edi
	call	puts
	movl	$.LC21, %edi
	call	puts
	movl	$.LC17, %esi
	movl	$.LC29, %edi
	call	fopen
	movl	$.LC30, %r9d
	movq	%rax, %rdi
	movq	%rax, %rbx
	movl	$.LC31, %r8d
	xorl	%eax, %eax
	movl	$.LC26, %ecx
	movl	$.LC32, %edx
	movl	$1, %esi
	call	__fprintf_chk
	movl	GV+1020(%rip), %eax
	testl	%eax, %eax
	jle	.L42
.L80:
	movsd	GV+1024(%rip), %xmm2
	movq	gp(%rip), %rax
	movl	%r14d, %ecx
	movsd	0(%r13), %xmm1
	movl	$.LC33, %edx
	mulsd	%xmm2, %xmm2
	movl	$1, %esi
	movq	%rbx, %rdi
	movsd	32(%rax,%r15), %xmm0
	movl	$2, %eax
	addl	$1, %r14d
	addq	$8, %r13
	addq	$296, %r15
	divsd	%xmm2, %xmm1
	call	__fprintf_chk
	cmpl	%r14d, GV+1020(%rip)
	jg	.L80
.L42:
	movq	%rbx, %rdi
	xorl	%r13d, %r13d
	call	fclose
	movl	$.LC34, %edi
	call	puts
	movl	$.LC35, %edi
	call	puts
	movq	%rbp, %rdi
	call	fftw_free
	movq	16(%rsp), %rdi
	call	fftw_free
	movq	%r12, %rdi
	call	fftw_free
	movl	$.LC36, %edi
	call	puts
	movl	$.LC35, %edi
	call	puts
	movq	8(%rsp), %rdi
	call	fftw_destroy_plan
	movl	$.LC37, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	movq	24(%rsp), %rdi
	call	fftw_destroy_plan
	xorl	%eax, %eax
	movl	$.LC37, %esi
	movl	$1, %edi
	call	__printf_chk
	movl	GV+1016(%rip), %ecx
	movsd	.LC38(%rip), %xmm3
	movl	GV+1032(%rip), %eax
	divsd	GV+1008(%rip), %xmm3
	testl	%ecx, %ecx
	jle	.L45
.L81:
	xorl	%r12d, %r12d
	.p2align 4,,10
	.p2align 3
.L57:
	testl	%eax, %eax
	js	.L55
	xorl	%ebx, %ebx
	jmp	.L56
	.p2align 4,,10
	.p2align 3
.L89:
	cvtsi2sd	%r13d, %xmm1
	cmpl	%eax, %r12d
	mulsd	%xmm3, %xmm1
	movsd	%xmm1, 80(%rbp)
	jg	.L49
.L90:
	cvtsi2sd	%r12d, %xmm2
.L50:
	cvtsi2sd	%ebx, %xmm0
	mulsd	%xmm3, %xmm2
	mulsd	%xmm1, %xmm1
	movsd	%xmm2, 88(%rbp)
	mulsd	%xmm2, %xmm2
	addsd	%xmm2, %xmm1
	mulsd	%xmm3, %xmm0
	movsd	%xmm0, 96(%rbp)
	mulsd	%xmm0, %xmm0
	addsd	%xmm0, %xmm1
	sqrtsd	%xmm1, %xmm0
	ucomisd	%xmm0, %xmm0
	jp	.L88
.L51:
	addl	$1, %ebx
	movsd	%xmm0, 104(%rbp)
	cmpl	%ebx, %eax
	jl	.L55
.L56:
	movl	%r13d, %esi
	leal	1(%rax), %edx
	imull	%ecx, %esi
	addl	%r12d, %esi
	imull	%esi, %edx
	addl	%ebx, %edx
	cmpl	%r13d, %eax
	movslq	%edx, %rdx
	leaq	(%rdx,%rdx,8), %rsi
	leaq	(%rdx,%rsi,4), %rsi
	movq	gp(%rip), %rdx
	leaq	(%rdx,%rsi,8), %rbp
	jge	.L89
	movl	%r13d, %edx
	subl	%ecx, %edx
	cmpl	%eax, %r12d
	cvtsi2sd	%edx, %xmm1
	mulsd	%xmm3, %xmm1
	movsd	%xmm1, 80(%rbp)
	jle	.L90
.L49:
	movl	%r12d, %edx
	subl	%ecx, %edx
	cvtsi2sd	%edx, %xmm2
	jmp	.L50
	.p2align 4,,10
	.p2align 3
.L55:
	addl	$1, %r12d
	cmpl	%ecx, %r12d
	jl	.L57
	addl	$1, %r13d
	cmpl	%ecx, %r13d
	jge	.L45
	testl	%ecx, %ecx
	jg	.L81
.L45:
	movl	$.LC39, %edi
	call	puts
	movl	$.LC40, %edi
	call	puts
	movl	$.LC41, %edi
	call	puts
	movl	$.LC40, %edi
	call	puts
	movl	GV+1020(%rip), %eax
	testl	%eax, %eax
	jle	.L67
	subl	$1, %eax
	movq	gp(%rip), %rbx
	movl	GV+1016(%rip), %r12d
	leaq	(%rax,%rax,8), %rdx
	movsd	GV+1008(%rip), %xmm6
	movsd	GV+1056(%rip), %xmm4
	leaq	296(%rbx), %rbp
	leaq	(%rax,%rdx,4), %rax
	movsd	%xmm6, 8(%rsp)
	movsd	.LC44(%rip), %xmm3
	leaq	0(%rbp,%rax,8), %r13
	jmp	.L68
.L91:
	cvtsi2sd	%r12d, %xmm0
	mulsd	8(%rsp), %xmm5
	movapd	%xmm3, 64(%rsp)
	movsd	%xmm4, 48(%rsp)
	movsd	%xmm1, 32(%rsp)
	movsd	%xmm2, 24(%rsp)
	addsd	%xmm0, %xmm0
	divsd	%xmm0, %xmm5
	movapd	%xmm5, %xmm0
	movsd	%xmm5, 16(%rsp)
	call	sin
	movsd	16(%rsp), %xmm5
	movsd	24(%rsp), %xmm2
	divsd	%xmm5, %xmm0
	movapd	64(%rsp), %xmm3
	movsd	32(%rsp), %xmm1
	movsd	48(%rsp), %xmm4
	mulsd	%xmm0, %xmm0
.L63:
	mulsd	%xmm2, %xmm1
	mulsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	movsd	%xmm1, 120(%rbx)
	andpd	%xmm3, %xmm0
	ucomisd	%xmm4, %xmm0
	jbe	.L86
	movsd	40(%rbx), %xmm0
	movsd	48(%rbx), %xmm2
	divsd	%xmm1, %xmm0
	divsd	%xmm1, %xmm2
	movapd	%xmm0, %xmm1
	mulsd	%xmm0, %xmm1
	movapd	%xmm2, %xmm5
	mulsd	%xmm2, %xmm5
	addsd	%xmm5, %xmm1
.L65:
	cmpq	%r13, %rbp
	movsd	%xmm2, 64(%rbx)
	movsd	%xmm0, 56(%rbx)
	movsd	%xmm1, 72(%rbx)
	movq	%rbp, %rbx
	je	.L67
	addq	$296, %rbp
.L68:
	movsd	80(%rbx), %xmm1
	movsd	.LC7(%rip), %xmm2
	movapd	%xmm1, %xmm0
	andpd	%xmm3, %xmm0
	ucomisd	%xmm4, %xmm0
	jbe	.L59
	cvtsi2sd	%r12d, %xmm0
	mulsd	8(%rsp), %xmm1
	movapd	%xmm3, 32(%rsp)
	movsd	%xmm4, 24(%rsp)
	addsd	%xmm0, %xmm0
	divsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	movsd	%xmm1, 16(%rsp)
	call	sin
	movsd	16(%rsp), %xmm1
	movapd	%xmm0, %xmm2
	movsd	24(%rsp), %xmm4
	movapd	32(%rsp), %xmm3
	divsd	%xmm1, %xmm2
	mulsd	%xmm2, %xmm2
.L59:
	movsd	88(%rbx), %xmm5
	movsd	.LC7(%rip), %xmm1
	movapd	%xmm5, %xmm0
	andpd	%xmm3, %xmm0
	ucomisd	%xmm4, %xmm0
	jbe	.L61
	cvtsi2sd	%r12d, %xmm0
	mulsd	8(%rsp), %xmm5
	movapd	%xmm3, 48(%rsp)
	movsd	%xmm4, 32(%rsp)
	movsd	%xmm2, 24(%rsp)
	addsd	%xmm0, %xmm0
	divsd	%xmm0, %xmm5
	movapd	%xmm5, %xmm0
	movsd	%xmm5, 16(%rsp)
	call	sin
	movsd	16(%rsp), %xmm5
	movapd	%xmm0, %xmm1
	movsd	24(%rsp), %xmm2
	movsd	32(%rsp), %xmm4
	divsd	%xmm5, %xmm1
	movapd	48(%rsp), %xmm3
	mulsd	%xmm1, %xmm1
.L61:
	movsd	96(%rbx), %xmm5
	movapd	%xmm5, %xmm0
	andpd	%xmm3, %xmm0
	ucomisd	%xmm4, %xmm0
	ja	.L91
	movsd	.LC7(%rip), %xmm0
	jmp	.L63
.L86:
	xorpd	%xmm1, %xmm1
	movapd	%xmm1, %xmm2
	movapd	%xmm1, %xmm0
	jmp	.L65
.L67:
	movl	$.LC42, %edi
	call	puts
	movl	$.LC21, %edi
	call	puts
	movl	$.LC43, %edi
	call	puts
	movl	$.LC35, %edi
	call	puts
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L88:
	.cfi_restore_state
	movapd	%xmm1, %xmm0
	movsd	%xmm3, 8(%rsp)
	call	sqrt
	movl	GV+1016(%rip), %ecx
	movl	GV+1032(%rip), %eax
	movsd	8(%rsp), %xmm3
	jmp	.L51
	.cfi_endproc
.LFE47:
	.size	transform, .-transform
	.p2align 4,,15
	.globl	Sorting_k
	.type	Sorting_k, @function
Sorting_k:
.LFB48:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movl	$8, %esi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movl	GV+1020(%rip), %ebx
	movslq	%ebx, %r12
	movq	%r12, %rdi
	call	calloc
	leaq	0(,%r12,8), %rdi
	movq	%rax, %rbp
	call	malloc
	xorl	%edx, %edx
	testl	%ebx, %ebx
	movq	%rax, GV+1120(%rip)
	movq	gp(%rip), %r8
	jle	.L94
	.p2align 4,,10
	.p2align 3
.L96:
	movsd	104(%r8), %xmm0
	addq	$296, %r8
	movsd	%xmm0, 0(%rbp,%rdx,8)
	addq	$1, %rdx
	cmpl	%edx, %ebx
	jg	.L96
.L94:
	movq	%r12, %rcx
	movq	%rbp, %rsi
	movq	%rax, %rdi
	movl	$1, %edx
	call	gsl_sort_index
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE48:
	.size	Sorting_k, .-Sorting_k
	.section	.rodata.str1.1
.LC46:
	.string	"Creating bins: %d\n"
.LC49:
	.string	"Vectors initialized"
.LC50:
	.string	"Computing power spectrum"
.LC51:
	.string	"bin j=%d is null\n"
	.section	.rodata.str1.8
	.align 8
.LC52:
	.string	"Divided by the number of counts"
	.section	.rodata.str1.1
.LC53:
	.string	"Printing outfile"
.LC54:
	.string	"Power_Spectrum_lineal.dat"
.LC55:
	.string	"PS(Delta_k)"
.LC56:
	.string	"Delta_k"
.LC57:
	.string	"%s\t %9s\t %10s %10s\n"
.LC58:
	.string	"CountsInBin"
.LC61:
	.string	"%16.8lf %20.10lf %12.6d\n"
.LC62:
	.string	"Total counts = %d\n"
	.text
	.p2align 4,,15
	.globl	power_spectrum
	.type	power_spectrum, @function
power_spectrum:
.LFB49:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	$200, %edx
	movl	$.LC46, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
	movsd	.LC45(%rip), %xmm4
	movsd	%xmm4, GV+1128(%rip)
	call	__printf_chk
	movl	$8, %esi
	movl	$200, %edi
	call	calloc
	movl	$8, %esi
	movl	$200, %edi
	movq	%rax, GV+1136(%rip)
	call	calloc
	movl	$4, %esi
	movl	$200, %edi
	movq	%rax, GV+1144(%rip)
	call	calloc
	movsd	.LC38(%rip), %xmm0
	movq	%rax, GV+1152(%rip)
	movsd	.LC47(%rip), %xmm1
	divsd	GV+1008(%rip), %xmm0
	movsd	%xmm0, GV+1160(%rip)
	movsd	GV+1048(%rip), %xmm0
	divsd	%xmm0, %xmm1
	movsd	%xmm1, GV+1168(%rip)
	movsd	.LC48(%rip), %xmm1
	call	pow
	movq	GV+1136(%rip), %rdx
	movq	GV+1152(%rip), %rsi
	movsd	%xmm0, GV+1176(%rip)
	movq	GV+1144(%rip), %rcx
	leaq	1600(%rdx), %rax
	leaq	800(%rsi), %r8
	cmpq	%rax, %rsi
	setnb	%dil
	cmpq	%r8, %rdx
	setnb	%al
	orl	%eax, %edi
	leaq	1600(%rcx), %rax
	cmpq	%rax, %rsi
	setnb	%al
	cmpq	%r8, %rcx
	setnb	%r8b
	orl	%r8d, %eax
	testb	%al, %dil
	je	.L100
	leaq	32(%rdx), %rax
	cmpq	%rax, %rcx
	leaq	32(%rcx), %rax
	setnb	%dil
	cmpq	%rax, %rdx
	setnb	%al
	orb	%al, %dil
	je	.L100
	pxor	%xmm0, %xmm0
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L102:
	movq	$0, (%rdx,%rax,2)
	movq	$0, 8(%rdx,%rax,2)
	movq	$0, 16(%rdx,%rax,2)
	movq	$0, 24(%rdx,%rax,2)
	movq	$0, (%rcx,%rax,2)
	movq	$0, 8(%rcx,%rax,2)
	movq	$0, 16(%rcx,%rax,2)
	movq	$0, 24(%rcx,%rax,2)
	movdqu	%xmm0, (%rsi,%rax)
	addq	$16, %rax
	cmpq	$800, %rax
	jne	.L102
.L101:
	movl	$.LC49, %edi
	call	puts
	movl	$.LC50, %edi
	call	puts
	movl	GV+1020(%rip), %r8d
	movq	GV+1136(%rip), %r11
	xorl	%edi, %edi
	movq	GV+1152(%rip), %r10
	movq	gp(%rip), %r9
	movq	GV+1120(%rip), %rbp
	movq	GV+1144(%rip), %rbx
	.p2align 4,,10
	.p2align 3
.L110:
	leal	1(%rdi), %eax
	cvtsi2sd	%edi, %xmm1
	movsd	GV+1128(%rip), %xmm0
	testl	%r8d, %r8d
	cvtsi2sd	%eax, %xmm2
	mulsd	%xmm0, %xmm1
	mulsd	%xmm0, %xmm2
	jle	.L104
	movq	%rbp, %rcx
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L108:
	movq	(%rcx), %rax
	leaq	(%rax,%rax,8), %rsi
	leaq	(%rax,%rsi,4), %rax
	leaq	(%r9,%rax,8), %rax
	movsd	104(%rax), %xmm0
	ucomisd	%xmm1, %xmm0
	jb	.L105
	ucomisd	%xmm0, %xmm2
	jbe	.L105
	movsd	(%r11,%rdi,8), %xmm0
	addsd	72(%rax), %xmm0
	movsd	%xmm0, (%r11,%rdi,8)
	movsd	%xmm2, (%rbx,%rdi,8)
	addl	$1, (%r10,%rdi,4)
	movl	GV+1020(%rip), %r8d
.L105:
	addl	$1, %edx
	addq	$8, %rcx
	cmpl	%r8d, %edx
	jl	.L108
.L104:
	addq	$1, %rdi
	cmpq	$200, %rdi
	jne	.L110
	xorl	%ebx, %ebx
	jmp	.L114
	.p2align 4,,10
	.p2align 3
.L111:
	cvtsi2sd	%eax, %xmm1
	leaq	(%r11,%rbx,8), %rdx
	addq	$1, %rbx
	movsd	(%rdx), %xmm0
	cmpq	$201, %rbx
	divsd	%xmm1, %xmm0
	movsd	%xmm0, (%rdx)
	je	.L113
.L133:
	movq	GV+1152(%rip), %r10
	movq	GV+1136(%rip), %r11
.L114:
	movl	(%r10,%rbx,4), %eax
	testl	%eax, %eax
	jne	.L111
	movq	$0, (%r11,%rbx,8)
	movl	%ebx, %edx
	movl	$.LC51, %esi
	movl	$1, %edi
	addq	$1, %rbx
	call	__printf_chk
	cmpq	$201, %rbx
	jne	.L133
.L113:
	movl	$.LC52, %edi
	xorl	%ebx, %ebx
	xorl	%r12d, %r12d
	call	puts
	movl	$.LC53, %edi
	call	puts
	movl	$.LC17, %esi
	movl	$.LC54, %edi
	call	fopen
	movq	$.LC58, (%rsp)
	movq	%rax, %rdi
	movq	%rax, %r13
	movl	$.LC55, %r9d
	movl	$.LC56, %r8d
	movl	$.LC26, %ecx
	movl	$.LC57, %edx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk
	movsd	.LC59(%rip), %xmm2
	jmp	.L117
	.p2align 4,,10
	.p2align 3
.L115:
	addq	$1, %rbx
	cmpq	$201, %rbx
	je	.L134
.L117:
	cvtsi2sd	%ebx, %xmm0
	movsd	GV+1128(%rip), %xmm1
	addsd	%xmm2, %xmm0
	mulsd	%xmm0, %xmm1
	ucomisd	GV+1168(%rip), %xmm1
	ja	.L115
	movsd	GV+1048(%rip), %xmm3
	movq	GV+1136(%rip), %rax
	movsd	%xmm2, 16(%rsp)
	movapd	%xmm3, %xmm1
	leaq	(%rax,%rbx,8), %rbp
	mulsd	%xmm3, %xmm1
	mulsd	%xmm3, %xmm1
	cvtsi2sd	GV+1020(%rip), %xmm3
	divsd	%xmm3, %xmm1
	mulsd	0(%rbp), %xmm1
	movsd	%xmm1, 0(%rbp)
	subsd	GV+1176(%rip), %xmm1
	movsd	%xmm1, 0(%rbp)
	movsd	%xmm1, 24(%rsp)
	mulsd	GV+1128(%rip), %xmm0
	mulsd	GV+1048(%rip), %xmm0
	mulsd	%xmm2, %xmm0
	call	sin
	movsd	.LC60(%rip), %xmm3
	movq	GV+1152(%rip), %rax
	movsd	24(%rsp), %xmm1
	movl	$.LC61, %edx
	mulsd	%xmm0, %xmm3
	movl	$1, %esi
	movq	%r13, %rdi
	movl	(%rax,%rbx,4), %ecx
	movq	GV+1144(%rip), %rax
	mulsd	%xmm0, %xmm3
	movsd	.LC7(%rip), %xmm0
	subsd	%xmm3, %xmm0
	divsd	%xmm0, %xmm1
	movsd	%xmm1, 0(%rbp)
	movsd	(%rax,%rbx,8), %xmm0
	movl	$2, %eax
	call	__fprintf_chk
	movq	GV+1152(%rip), %rdx
	movsd	16(%rsp), %xmm2
	addl	(%rdx,%rbx,4), %r12d
	addq	$1, %rbx
	cmpq	$201, %rbx
	jne	.L117
.L134:
	movq	%r13, %rdi
	call	fclose
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movl	%r12d, %edx
	movl	$.LC62, %esi
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	movl	$1, %edi
	xorl	%eax, %eax
	jmp	__printf_chk
.L100:
	.cfi_restore_state
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L103:
	movq	$0, (%rdx,%rax,2)
	movq	$0, (%rcx,%rax,2)
	movl	$0, (%rsi,%rax)
	addq	$4, %rax
	cmpq	$800, %rax
	jne	.L103
	jmp	.L101
	.cfi_endproc
.LFE49:
	.size	power_spectrum, .-power_spectrum
	.section	.rodata.str1.8
	.align 8
.LC63:
	.string	"Error: Incomplete number of parameters. Execute as follows:"
	.section	.rodata.str1.1
.LC64:
	.string	"%s Parameters_file\n"
.LC66:
	.string	"Variables are ready to use!"
	.section	.rodata.str1.8
	.align 8
.LC67:
	.string	"Ascii data file has been read succesfully!"
	.section	.rodata.str1.1
.LC68:
	.string	"Simulation parameters"
	.section	.rodata.str1.8
	.align 8
.LC69:
	.string	"GV.NCELLS:%12d GV.NTOTALCELLS:%12d\nGV.BoxSize:%16.8lf GV.CellSize:%16.8lf\nGV.NTOTK:%12d GV.PADDING:%12d\nGV.CNMESH:%12d GV.NORM:%16.8lf\n"
	.align 8
.LC70:
	.string	"----------------------------------------------------------------"
	.section	.rodata.str1.1
.LC71:
	.string	"Cosmological parameters"
	.section	.rodata.str1.8
	.align 8
.LC72:
	.string	"GV.z_RS=%lf GV.H0=%lf \nGV.Hz=%lf GV.a_SF=%lf\n"
	.align 8
.LC73:
	.string	"FFT of density contrast finished!"
	.section	.rodata.str1.1
.LC74:
	.string	"ID's according to k sorted!"
.LC75:
	.string	"Computing Power spectrum"
.LC76:
	.string	"Power spectrum computed"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB50:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	cmpl	$1, %edi
	jle	.L142
	movq	8(%rsi), %rdi
	call	read_parameters
	movl	GV+1016(%rip), %ebx
	movsd	.LC65(%rip), %xmm4
	movsd	%xmm4, GV+1056(%rip)
	movl	%ebx, %eax
	shrl	$31, %eax
	addl	%ebx, %eax
	sarl	%eax
	cvtsi2sd	%eax, %xmm0
	call	floor
	cvttsd2si	%xmm0, %edx
	movl	%ebx, %eax
	imull	%ebx, %eax
	movl	%edx, GV+1032(%rip)
	addl	$1, %edx
	imull	%eax, %edx
	imull	%ebx, %eax
	movl	%edx, GV+1040(%rip)
	cvtsi2sd	%eax, %xmm0
	movl	%eax, GV+1020(%rip)
	sqrtsd	%xmm0, %xmm1
	ucomisd	%xmm1, %xmm1
	jp	.L143
.L137:
	imull	%ebx, %ebx
	movl	$.LC66, %edi
	movsd	%xmm1, GV+1024(%rip)
	leal	(%rax,%rbx,2), %eax
	movl	%eax, GV+1036(%rip)
	call	puts
	movl	$.LC21, %edi
	call	puts
	movslq	GV+1020(%rip), %rax
	leaq	(%rax,%rax,8), %rdx
	leaq	(%rax,%rdx,4), %rdi
	salq	$3, %rdi
	call	malloc
	movl	$GV, %edi
	movq	%rax, gp(%rip)
	call	read_data
	movl	$.LC67, %edi
	call	puts
	movl	$.LC21, %edi
	call	puts
	movsd	.LC7(%rip), %xmm0
	movsd	GV+1064(%rip), %xmm5
	addsd	GV+1072(%rip), %xmm0
	movsd	GV+1104(%rip), %xmm6
	movsd	GV+1096(%rip), %xmm7
	movsd	.LC48(%rip), %xmm1
	movsd	%xmm5, 8(%rsp)
	movsd	%xmm6, 16(%rsp)
	movsd	%xmm7, 24(%rsp)
	call	pow
	mulsd	24(%rsp), %xmm0
	addsd	16(%rsp), %xmm0
	sqrtsd	%xmm0, %xmm1
	ucomisd	%xmm1, %xmm1
	jp	.L144
.L139:
	mulsd	8(%rsp), %xmm1
	movl	$.LC68, %edi
	movsd	GV+1008(%rip), %xmm0
	movsd	%xmm1, GV+1088(%rip)
	cvtsi2sd	GV+1016(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, GV+1048(%rip)
	call	puts
	movl	GV+1032(%rip), %eax
	movl	$.LC69, %esi
	movl	$1, %edi
	movl	GV+1036(%rip), %r9d
	movl	GV+1040(%rip), %r8d
	movl	GV+1020(%rip), %ecx
	movl	GV+1016(%rip), %edx
	movsd	GV+1024(%rip), %xmm2
	movl	%eax, (%rsp)
	movl	$3, %eax
	movsd	GV+1048(%rip), %xmm1
	movsd	GV+1008(%rip), %xmm0
	call	__printf_chk
	movl	$.LC70, %edi
	call	puts
	movl	$.LC71, %edi
	call	puts
	movsd	GV+1080(%rip), %xmm3
	movl	$.LC72, %esi
	movsd	GV+1088(%rip), %xmm2
	movl	$1, %edi
	movsd	GV+1064(%rip), %xmm1
	movl	$4, %eax
	movsd	GV+1072(%rip), %xmm0
	call	__printf_chk
	movl	$.LC21, %edi
	call	puts
	xorl	%eax, %eax
	call	transform
	movl	$.LC73, %edi
	call	puts
	movl	$.LC21, %edi
	call	puts
	call	Sorting_k
	movl	$.LC74, %edi
	call	puts
	movl	$.LC21, %edi
	call	puts
	movl	$.LC75, %edi
	call	puts
	movl	$.LC21, %edi
	call	puts
	xorl	%eax, %eax
	call	power_spectrum
	movl	$.LC76, %edi
	call	puts
	movl	$.LC21, %edi
	call	puts
	movq	gp(%rip), %rdi
	call	free
	xorl	%edi, %edi
	call	exit
.L142:
	movl	$.LC63, %edi
	movq	%rsi, 8(%rsp)
	call	puts
	movq	8(%rsp), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	movq	(%rsi), %rdx
	movl	$.LC64, %esi
	call	__printf_chk
	xorl	%edi, %edi
	call	exit
.L144:
	call	sqrt
	movapd	%xmm0, %xmm1
	jmp	.L139
.L143:
	call	sqrt
	movl	GV+1016(%rip), %ebx
	movapd	%xmm0, %xmm1
	movl	GV+1020(%rip), %eax
	jmp	.L137
	.cfi_endproc
.LFE50:
	.size	main, .-main
	.comm	GV,1184,32
	.comm	gp,8,8
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC7:
	.long	0
	.long	1072693248
	.align 8
.LC38:
	.long	1413754136
	.long	1075388923
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC44:
	.long	4294967295
	.long	2147483647
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC45:
	.long	1202590843
	.long	1066695393
	.align 8
.LC47:
	.long	1413754136
	.long	1074340347
	.align 8
.LC48:
	.long	0
	.long	1074266112
	.align 8
.LC59:
	.long	0
	.long	1071644672
	.align 8
.LC60:
	.long	1431658768
	.long	1071994197
	.align 8
.LC65:
	.long	4276863648
	.long	968116299
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4"
	.section	.note.GNU-stack,"",@progbits
