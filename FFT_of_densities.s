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
	addq	$288, %rbp
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
	leaq	136(%r8), %rax
	movq	%rax, 24(%rsp)
	leaq	128(%r8), %rax
	movq	%rax, 16(%rsp)
	leaq	120(%r8), %rax
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
	movsd	136(%rax), %xmm5
	movsd	128(%rax), %xmm4
	movsd	120(%rax), %xmm3
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
	addq	$288, %rbx
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
	addq	$208, %rdi
	call	fwrite
	movq	%rbx, %rdi
	addq	gp(%rip), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$8, %esi
	addq	$240, %rdi
	call	fwrite
	movq	%rbx, %rdi
	addq	gp(%rip), %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$8, %esi
	addq	$288, %rbx
	addq	$264, %rdi
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
	movq	%rax, %rbx
	salq	$4, %rdi
	call	fftw_malloc
	movl	GV+1020(%rip), %ecx
	movq	%rax, %r13
	xorl	%eax, %eax
	movq	gp(%rip), %rdx
	testl	%ecx, %ecx
	jle	.L39
.L78:
	movsd	32(%rdx), %xmm0
	addq	$288, %rdx
	movsd	%xmm0, (%rbx,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %ecx
	jg	.L78
.L39:
	movl	$.LC20, %edi
	xorl	%r14d, %r14d
	xorl	%r12d, %r12d
	call	puts
	movl	$.LC21, %edi
	movq	%r13, %rbp
	call	puts
	movl	GV+1016(%rip), %edi
	movl	$64, %r9d
	movq	%r13, %r8
	movq	%rbx, %rcx
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
	movsd	0(%rbp), %xmm0
	movl	%r12d, %ecx
	movl	$.LC33, %edx
	movl	$1, %esi
	movq	%r15, %rdi
	divsd	%xmm1, %xmm0
	addl	$1, %r12d
	addq	$288, %r14
	addq	$16, %rbp
	movsd	%xmm0, 40(%rax)
	movsd	-8(%rbp), %xmm0
	divsd	%xmm1, %xmm0
	movsd	%xmm0, 48(%rax)
	movl	$2, %eax
	movsd	-8(%rbp), %xmm1
	movsd	-16(%rbp), %xmm0
	call	__fprintf_chk
	cmpl	%r12d, GV+1040(%rip)
	jg	.L79
.L38:
	movq	%r15, %rdi
	xorl	%r14d, %r14d
	call	fclose
	movslq	GV+1020(%rip), %rdi
	salq	$3, %rdi
	call	fftw_malloc
	movl	GV+1016(%rip), %edi
	movl	$64, %r9d
	movq	%rax, %r8
	movq	%r13, %rcx
	movq	%rax, %rbp
	movl	%edi, %edx
	movl	%edi, %esi
	call	fftw_plan_dft_c2r_3d
	movq	%rax, %rdi
	movq	%rax, %r15
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
	movq	%rax, %r12
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
	leaq	(%r14,%r14,8), %rax
	movl	%r14d, %ecx
	movsd	0(%rbp,%r14,8), %xmm1
	movl	$.LC33, %edx
	mulsd	%xmm2, %xmm2
	salq	$5, %rax
	addq	gp(%rip), %rax
	movl	$1, %esi
	movq	%r12, %rdi
	divsd	%xmm2, %xmm1
	movsd	32(%rax), %xmm0
	movl	$2, %eax
	call	__fprintf_chk
	leal	1(%r14), %eax
	addq	$1, %r14
	cmpl	%eax, GV+1020(%rip)
	jg	.L80
.L42:
	movq	%r12, %rdi
	call	fclose
	movl	$.LC34, %edi
	call	puts
	movl	$.LC35, %edi
	call	puts
	movq	%rbx, %rdi
	call	fftw_free
	movq	%rbp, %rdi
	call	fftw_free
	movq	%r13, %rdi
	xorl	%r13d, %r13d
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
	movq	%r15, %rdi
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
	xorl	%ebp, %ebp
	jmp	.L56
	.p2align 4,,10
	.p2align 3
.L89:
	cvtsi2sd	%r13d, %xmm1
	cmpl	%eax, %r12d
	mulsd	%xmm3, %xmm1
	movsd	%xmm1, 72(%rbx)
	jg	.L49
.L90:
	cvtsi2sd	%r12d, %xmm2
.L50:
	cvtsi2sd	%ebp, %xmm0
	mulsd	%xmm3, %xmm2
	mulsd	%xmm1, %xmm1
	movsd	%xmm2, 80(%rbx)
	mulsd	%xmm2, %xmm2
	addsd	%xmm2, %xmm1
	mulsd	%xmm3, %xmm0
	movsd	%xmm0, 88(%rbx)
	mulsd	%xmm0, %xmm0
	addsd	%xmm0, %xmm1
	sqrtsd	%xmm1, %xmm0
	ucomisd	%xmm0, %xmm0
	jp	.L88
.L51:
	addl	$1, %ebp
	movsd	%xmm0, 96(%rbx)
	cmpl	%ebp, %eax
	jl	.L55
.L56:
	movl	%r13d, %esi
	leal	1(%rax), %edx
	imull	%ecx, %esi
	addl	%r12d, %esi
	imull	%esi, %edx
	addl	%ebp, %edx
	movslq	%edx, %rdx
	leaq	(%rdx,%rdx,8), %rbx
	salq	$5, %rbx
	addq	gp(%rip), %rbx
	cmpl	%r13d, %eax
	jge	.L89
	movl	%r13d, %edx
	subl	%ecx, %edx
	cmpl	%eax, %r12d
	cvtsi2sd	%edx, %xmm1
	mulsd	%xmm3, %xmm1
	movsd	%xmm1, 72(%rbx)
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
	movq	gp(%rip), %rbx
	subl	$1, %eax
	movl	GV+1016(%rip), %r12d
	leaq	(%rax,%rax,8), %r13
	movsd	GV+1008(%rip), %xmm6
	movsd	GV+1056(%rip), %xmm4
	leaq	288(%rbx), %rbp
	salq	$5, %r13
	movsd	%xmm6, 8(%rsp)
	movsd	.LC44(%rip), %xmm3
	addq	%rbp, %r13
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
	movsd	%xmm1, 112(%rbx)
	andpd	%xmm3, %xmm0
	ucomisd	%xmm4, %xmm0
	jbe	.L86
	movsd	40(%rbx), %xmm0
	movsd	48(%rbx), %xmm2
	divsd	%xmm1, %xmm0
	divsd	%xmm1, %xmm2
.L65:
	cmpq	%r13, %rbp
	movsd	%xmm2, 64(%rbx)
	movsd	%xmm0, 56(%rbx)
	movq	%rbp, %rbx
	je	.L67
	addq	$288, %rbp
.L68:
	movsd	72(%rbx), %xmm1
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
	movsd	80(%rbx), %xmm5
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
	movsd	88(%rbx), %xmm5
	movapd	%xmm5, %xmm0
	andpd	%xmm3, %xmm0
	ucomisd	%xmm4, %xmm0
	ja	.L91
	movsd	.LC7(%rip), %xmm0
	jmp	.L63
.L86:
	xorpd	%xmm2, %xmm2
	movapd	%xmm2, %xmm0
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
	.section	.rodata.str1.8
	.align 8
.LC45:
	.string	"Computing potential in k-space"
	.align 8
.LC46:
	.string	"-----------------------------------------"
	.section	.rodata.str1.1
.LC48:
	.string	"Potential in k-space saved!"
.LC49:
	.string	"FFT potential k2r finished!"
	.section	.rodata.str1.8
	.align 8
.LC50:
	.string	"---------------------------------------"
	.section	.rodata.str1.1
.LC51:
	.string	"./../Potential_r_out.dat"
.LC52:
	.string	"Poten(r)"
.LC53:
	.string	"ID"
	.section	.rodata.str1.8
	.align 8
.LC54:
	.string	"Potential in r space from an out-of-place transform saved!"
	.align 8
.LC55:
	.string	"Recreated input of potential in k-space from out-of-place transform performed"
	.align 8
.LC56:
	.string	"./../Testing_potential_k_space.dat"
	.section	.rodata.str1.1
.LC57:
	.string	"Im_Pot(k)"
.LC58:
	.string	"Re_Pot(k)"
.LC59:
	.string	"%s%14s %15s %15s %15s\n"
.LC60:
	.string	"Reconst_Im"
.LC61:
	.string	"Reconst_Re"
.LC62:
	.string	"%10d %16.8lf\n"
	.section	.rodata.str1.8
	.align 8
.LC63:
	.string	"Recreated input of potential in k-space from out-of-place transform saved"
	.section	.rodata.str1.1
.LC64:
	.string	"FFT_potential code finished!"
.LC65:
	.string	"----------------------------"
	.section	.rodata.str1.8
	.align 8
.LC66:
	.string	"%10d %20.8lf %20.8lf %20.8lf %20.8lf\n"
	.text
	.p2align 4,,15
	.globl	potential
	.type	potential, @function
potential:
.LFB48:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	$.LC45, %edi
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
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	call	puts
	movl	$.LC46, %edi
	call	puts
	movsd	GV+1064(%rip), %xmm2
	movl	GV+1040(%rip), %ecx
	mulsd	%xmm2, %xmm2
	testl	%ecx, %ecx
	mulsd	.LC47(%rip), %xmm2
	mulsd	GV+1096(%rip), %xmm2
	divsd	GV+1080(%rip), %xmm2
	jle	.L98
	movq	gp(%rip), %rax
	subl	$1, %ecx
	leaq	(%rcx,%rcx,8), %rcx
	leaq	288(%rax), %rdx
	salq	$5, %rcx
	addq	%rdx, %rcx
	movsd	GV+1056(%rip), %xmm5
	xorpd	%xmm4, %xmm4
	jmp	.L99
	.p2align 4,,10
	.p2align 3
.L114:
	movapd	%xmm0, %xmm3
	movsd	64(%rax), %xmm1
	mulsd	%xmm0, %xmm3
	movsd	56(%rax), %xmm0
	mulsd	%xmm2, %xmm1
	mulsd	%xmm2, %xmm0
	divsd	%xmm3, %xmm1
	divsd	%xmm3, %xmm0
.L96:
	cmpq	%rcx, %rdx
	movsd	%xmm1, 200(%rax)
	movsd	%xmm0, 192(%rax)
	movq	%rdx, %rax
	je	.L98
	addq	$288, %rdx
.L99:
	movsd	96(%rax), %xmm0
	ucomisd	%xmm5, %xmm0
	ja	.L114
	movapd	%xmm4, %xmm1
	movapd	%xmm4, %xmm0
	jmp	.L96
	.p2align 4,,10
	.p2align 3
.L98:
	movl	$.LC48, %edi
	call	puts
	movl	$.LC46, %edi
	call	puts
	movslq	GV+1040(%rip), %rdi
	salq	$4, %rdi
	call	fftw_malloc
	movslq	GV+1020(%rip), %rdi
	movq	%rax, 24(%rsp)
	salq	$3, %rdi
	call	fftw_malloc
	movl	GV+1040(%rip), %esi
	movq	%rax, %rbp
	testl	%esi, %esi
	jle	.L95
	movq	gp(%rip), %rcx
	subl	$1, %esi
	movq	24(%rsp), %rax
	leaq	(%rsi,%rsi,8), %rsi
	leaq	288(%rcx), %rdx
	salq	$5, %rsi
	addq	%rdx, %rsi
	jmp	.L102
	.p2align 4,,10
	.p2align 3
.L115:
	addq	$288, %rdx
.L102:
	movsd	192(%rcx), %xmm0
	addq	$16, %rax
	movsd	%xmm0, -16(%rax)
	movsd	200(%rcx), %xmm0
	movq	%rdx, %rcx
	movsd	%xmm0, -8(%rax)
	cmpq	%rsi, %rdx
	jne	.L115
.L95:
	movl	GV+1016(%rip), %edi
	movq	24(%rsp), %rcx
	xorl	%r9d, %r9d
	movq	%rbp, %r8
	xorl	%ebx, %ebx
	movl	%edi, %edx
	movl	%edi, %esi
	call	fftw_plan_dft_c2r_3d
	movq	%rax, %rdi
	movq	%rax, 32(%rsp)
	call	fftw_execute
	movl	$.LC49, %edi
	call	puts
	movl	$.LC50, %edi
	call	puts
	movl	$.LC17, %esi
	movl	$.LC51, %edi
	call	fopen
	movl	$.LC27, %edx
	movq	%rax, %rdi
	movq	%rax, %r14
	movl	$.LC52, %r9d
	xorl	%eax, %eax
	movl	$.LC53, %r8d
	movl	$.LC26, %ecx
	movl	$1, %esi
	call	__fprintf_chk
	movl	GV+1020(%rip), %edx
	testl	%edx, %edx
	jle	.L101
	.p2align 4,,10
	.p2align 3
.L109:
	movsd	0(%rbp,%rbx,8), %xmm0
	leaq	(%rbx,%rbx,8), %rdx
	movl	%ebx, %ecx
	movl	$1, %esi
	movq	%r14, %rdi
	movl	$1, %eax
	divsd	GV+1024(%rip), %xmm0
	salq	$5, %rdx
	addq	gp(%rip), %rdx
	movsd	%xmm0, 208(%rdx)
	movl	$.LC62, %edx
	call	__fprintf_chk
	leal	1(%rbx), %eax
	addq	$1, %rbx
	cmpl	%eax, GV+1020(%rip)
	jg	.L109
.L101:
	movq	%r14, %rdi
	xorl	%r15d, %r15d
	xorl	%r13d, %r13d
	call	fclose
	movl	$.LC50, %edi
	call	puts
	movl	$.LC54, %edi
	call	puts
	movl	$.LC50, %edi
	call	puts
	movslq	GV+1040(%rip), %rdi
	salq	$4, %rdi
	call	fftw_malloc
	movl	GV+1016(%rip), %edi
	movl	$64, %r9d
	movq	%rax, %r8
	movq	%rbp, %rcx
	movq	%rax, %r14
	movq	%r14, %r12
	movl	%edi, %edx
	movl	%edi, %esi
	call	fftw_plan_dft_r2c_3d
	movq	%rax, %rdi
	movq	%rax, 40(%rsp)
	call	fftw_execute
	movl	$.LC55, %edi
	call	puts
	movl	$.LC50, %edi
	call	puts
	movl	$.LC17, %esi
	movl	$.LC56, %edi
	call	fopen
	movq	$.LC60, 8(%rsp)
	movq	%rax, %rdi
	movq	%rax, %rbx
	movq	$.LC61, (%rsp)
	xorl	%eax, %eax
	movl	$.LC57, %r9d
	movl	$.LC58, %r8d
	movl	$.LC26, %ecx
	movl	$.LC59, %edx
	movl	$1, %esi
	call	__fprintf_chk
	movl	GV+1040(%rip), %eax
	testl	%eax, %eax
	jle	.L104
	.p2align 4,,10
	.p2align 3
.L110:
	movsd	GV+1024(%rip), %xmm1
	movq	%r15, %rax
	addq	gp(%rip), %rax
	movsd	8(%r12), %xmm3
	movl	%r13d, %ecx
	mulsd	%xmm1, %xmm1
	movl	$.LC66, %edx
	movl	$1, %esi
	movsd	(%r12), %xmm2
	movq	%rbx, %rdi
	movsd	192(%rax), %xmm0
	addl	$1, %r13d
	addq	$16, %r12
	addq	$288, %r15
	divsd	%xmm1, %xmm3
	divsd	%xmm1, %xmm2
	movsd	200(%rax), %xmm1
	movl	$4, %eax
	call	__fprintf_chk
	cmpl	%r13d, GV+1040(%rip)
	jg	.L110
.L104:
	movq	%rbx, %rdi
	call	fclose
	movl	$.LC63, %edi
	call	puts
	movl	$.LC50, %edi
	call	puts
	movq	32(%rsp), %rdi
	call	fftw_destroy_plan
	movq	40(%rsp), %rdi
	call	fftw_destroy_plan
	movq	24(%rsp), %rdi
	call	fftw_free
	movq	%r14, %rdi
	call	fftw_free
	movq	%rbp, %rdi
	call	fftw_free
	movl	$.LC64, %edi
	call	puts
	movl	$.LC65, %edi
	call	puts
	addq	$56, %rsp
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
	.cfi_endproc
.LFE48:
	.size	potential, .-potential
	.section	.rodata.str1.8
	.align 8
.LC67:
	.string	"Error: Incomplete number of parameters. Execute as follows:"
	.section	.rodata.str1.1
.LC68:
	.string	"%s Parameters_file\n"
.LC70:
	.string	"Variables are ready to use!"
	.section	.rodata.str1.8
	.align 8
.LC71:
	.string	"Ascii data file has been read succesfully!"
	.section	.rodata.str1.1
.LC73:
	.string	"Simulation parameters"
	.section	.rodata.str1.8
	.align 8
.LC74:
	.string	"GV.NCELLS:%12d GV.NTOTALCELLS:%12d\nGV.BoxSize:%16.8lf GV.CellSize:%16.8lf\nGV.NTOTK:%12d GV.PADDING:%12d\nGV.CNMESH:%12d GV.NORM:%16.8lf\n"
	.align 8
.LC75:
	.string	"----------------------------------------------------------------"
	.section	.rodata.str1.1
.LC76:
	.string	"Cosmological parameters"
	.section	.rodata.str1.8
	.align 8
.LC77:
	.string	"GV.z_RS=%lf GV.H0=%lf \nGV.Hz=%lf GV.a_SF=%lf\n"
	.align 8
.LC78:
	.string	"FFT of density contrast finished!"
	.align 8
.LC79:
	.string	"FFT of gravitational potential finished!"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB49:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	cmpl	$1, %edi
	jle	.L123
	movq	8(%rsi), %rdi
	call	read_parameters
	movl	GV+1016(%rip), %ebx
	movsd	.LC69(%rip), %xmm4
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
	jp	.L124
.L118:
	imull	%ebx, %ebx
	movl	$.LC70, %edi
	movsd	%xmm1, GV+1024(%rip)
	leal	(%rax,%rbx,2), %eax
	movl	%eax, GV+1036(%rip)
	call	puts
	movl	$.LC21, %edi
	call	puts
	movslq	GV+1020(%rip), %rax
	leaq	(%rax,%rax,8), %rdi
	salq	$5, %rdi
	call	malloc
	movl	$GV, %edi
	movq	%rax, gp(%rip)
	call	read_data
	movl	$.LC71, %edi
	call	puts
	movl	$.LC21, %edi
	call	puts
	movsd	.LC7(%rip), %xmm0
	movsd	GV+1064(%rip), %xmm5
	addsd	GV+1072(%rip), %xmm0
	movsd	GV+1104(%rip), %xmm6
	movsd	GV+1096(%rip), %xmm7
	movsd	.LC72(%rip), %xmm1
	movsd	%xmm5, 8(%rsp)
	movsd	%xmm6, 16(%rsp)
	movsd	%xmm7, 24(%rsp)
	call	pow
	mulsd	24(%rsp), %xmm0
	addsd	16(%rsp), %xmm0
	sqrtsd	%xmm0, %xmm1
	ucomisd	%xmm1, %xmm1
	jp	.L125
.L120:
	mulsd	8(%rsp), %xmm1
	movl	$.LC73, %edi
	movsd	GV+1008(%rip), %xmm0
	movsd	%xmm1, GV+1088(%rip)
	cvtsi2sd	GV+1016(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, GV+1048(%rip)
	call	puts
	movl	GV+1032(%rip), %eax
	movl	$.LC74, %esi
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
	movl	$.LC75, %edi
	call	puts
	movl	$.LC76, %edi
	call	puts
	movsd	GV+1080(%rip), %xmm3
	movl	$.LC77, %esi
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
	movl	$.LC78, %edi
	call	puts
	movl	$.LC21, %edi
	call	puts
	xorl	%eax, %eax
	call	potential
	movl	$.LC79, %edi
	call	puts
	movl	$.LC21, %edi
	call	puts
	movq	gp(%rip), %rdi
	call	free
	xorl	%edi, %edi
	call	exit
.L123:
	movl	$.LC67, %edi
	movq	%rsi, 8(%rsp)
	call	puts
	movq	8(%rsp), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	movq	(%rsi), %rdx
	movl	$.LC68, %esi
	call	__printf_chk
	xorl	%edi, %edi
	call	exit
.L125:
	call	sqrt
	movapd	%xmm0, %xmm1
	jmp	.L120
.L124:
	call	sqrt
	movl	GV+1016(%rip), %ebx
	movapd	%xmm0, %xmm1
	movl	GV+1020(%rip), %eax
	jmp	.L118
	.cfi_endproc
.LFE49:
	.size	main, .-main
	.comm	GV,1120,32
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
.LC47:
	.long	0
	.long	-1074266112
	.align 8
.LC69:
	.long	4276863648
	.long	968116299
	.align 8
.LC72:
	.long	0
	.long	1074266112
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4"
	.section	.note.GNU-stack,"",@progbits
