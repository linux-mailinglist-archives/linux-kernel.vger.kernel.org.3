Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DBB4D6425
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347486AbiCKOzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239993AbiCKOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:55:49 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01E719CCD6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:54:43 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id r12so7865722pla.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=XBMIuqlUTn5dcMfFoUdFf9zlgQZpGMo+7aVbXLk4wZw=;
        b=c92vbRsqwGIrd8KOBvBRnHPwXJFnJKzvfU0Dzfn5rU0pxu8C1iQ2FvTP3tRzqlCr5B
         zkGQxL4CL94IRycWhO2E2w+roEE7UpZSYOIi1WCgliiAmVk6LGVRUOSc9LQdUYbESXxf
         83nA2Pq08CGE3Y/l35AaD9uS+4DnSFeRZYO7AWzeppMIXZMupZdOHxUuqy85V3l048mu
         f8CglyLArjfeHEbZr3zbD+q5enoda1Ox0tHOF9K6MtFpY55vrg1ZGWzAM7ekgVo1+oxe
         qlJNbAiHBbnbhWi1LyXaSSOxId0CQi718TQpAvIxwAnJEs0xXpYik282AOwFzTgU964N
         JRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=XBMIuqlUTn5dcMfFoUdFf9zlgQZpGMo+7aVbXLk4wZw=;
        b=r6zyUVCBLMWCNNOJ7Sx/PbFRQNPJVFnSse4nEH8SkBdyHWszW18rEygbSNsiGqprcl
         7b5BdyB4wVtwH0T+OoxIaOB9mNnlQG278ngGDzaJOgBBMloE4VNpy9YPlFCueofh6XRw
         R/vIy4wO79GWUEvvR4pCXHQ1QzcBV29ZCv63fR9VReDwTIioJfj82mPhsGfX1Rzcdxdp
         p1vLhtJTPwYggHUQNf0wHqxCGhCwbG1o/e9WisSpLr66H6c4BLc3rHU/9b8enO7c8uSE
         2mGM/LxpnN+g6dVTQT0qTPlxj9Kb2h3iKV1em/0EmLH8KbVFO7zOpfS2H3SzXh29xUQa
         zu/g==
X-Gm-Message-State: AOAM533FTTM5DjP+k21F6VEMZsNabnUT/CNPVX8ltPYd9rfPXm7ST3hI
        LMyZBYgVuJliuxn5rf7NmXA=
X-Google-Smtp-Source: ABdhPJzmr+0dIwKE/VfibhAEn3Gd+h8pFUT6O1OIndl86dljmgNfoI+8v59nDyyD+6kH3LuRyp4LDg==
X-Received: by 2002:a17:90b:4c43:b0:1bf:8585:9baa with SMTP id np3-20020a17090b4c4300b001bf85859baamr11267592pjb.60.1647010481747;
        Fri, 11 Mar 2022 06:54:41 -0800 (PST)
Received: from odroid ([114.29.23.97])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090a4f4500b001bf3bdf39a8sm9846500pjl.4.2022.03.11.06.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:54:40 -0800 (PST)
Date:   Fri, 11 Mar 2022 14:54:27 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Oliver Glitta <glittao@gmail.com>, lkp@lists.01.org, lkp@intel.com,
        LKML <linux-kernel@vger.kernel.org>, vbabka@suse.cz,
        linux-mm@kvack.org
Subject: Re: [mm/slub]  ae107fa919:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <20220311145427.GA1227220@odroid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309021531.GA22223@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:15:31AM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: ae107fa91914f098cd54ab77e68f83dd6259e901 ("mm/slub: use stackdepot to save stack trace in objects")
> https://git.kernel.org/cgit/linux/kernel/git/vbabka/linux.git slub-stackdepot-v3r0
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>

[+Cc Vlastimil and linux-mm]

I _strongly_ suspect that this is because we don't initialize
stack_table[i] = NULL when we allocate it from memblock_alloc().

It was done before this series, not done after this series.
Why does it still work on my test... weird.

I'm trying to reproduce it.

> 
> +---------------------------------------------+------------+------------+
> |                                             | 2b303a7249 | ae107fa919 |
> +---------------------------------------------+------------+------------+
> | boot_successes                              | 10         | 0          |
> | boot_failures                               | 0          | 10         |
> | BUG:unable_to_handle_page_fault_for_address | 0          | 10         |
> | Oops:#[##]                                  | 0          | 10         |
> | EIP:__stack_depot_save                      | 0          | 10         |
> | Kernel_panic-not_syncing:Fatal_exception    | 0          | 10         |
> +---------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [    7.940529][    T0] BUG: unable to handle page fault for address: 003b2aa0
> [    7.941169][    T0] #PF: supervisor read access in kernel mode
> [    7.941688][    T0] #PF: error_code(0x0000) - not-present page
> [    7.942204][    T0] *pdpt = 0000000000000000 *pde = f000ff53f000e2c3
> [    7.943638][    T0] Oops: 0000 [#1] PTI
> [    7.943935][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.17.0-rc1-00003-gae107fa91914 #1 5f73b26000dc0e5442a0589d1a3fdb9ee3bc2185
> [    7.944854][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [ 7.945567][ T0] EIP: __stack_depot_save (lib/stackdepot.c:396) 
> [ 7.946736][ T0] Code: 0f 84 e0 00 00 00 83 fb 03 0f 84 d2 00 00 00 4b 90 0f 84 d4 00 00 00 a1 c0 a2 13 c3 89 f2 81 e2 ff ff 0f 00 8d 04 90 89 45 dc <8b> 18 85 db 0f 84 fd 00 00 00 8b 55 ec eb 12 8d b4 26 00 00 00 00
> All code
> ========
>    0:	0f 84 e0 00 00 00    	je     0xe6
>    6:	83 fb 03             	cmp    $0x3,%ebx
>    9:	0f 84 d2 00 00 00    	je     0xe1
>    f:	4b 90                	rex.WXB xchg %rax,%r8
>   11:	0f 84 d4 00 00 00    	je     0xeb
>   17:	a1 c0 a2 13 c3 89 f2 	movabs 0xe281f289c313a2c0,%eax
>   1e:	81 e2 
>   20:	ff                   	(bad)  
>   21:	ff 0f                	decl   (%rdi)
>   23:*	00 8d 04 90 89 45    	add    %cl,0x45899004(%rbp)		<-- trapping instruction
>   29:	dc 8b 18 85 db 0f    	fmull  0xfdb8518(%rbx)
>   2f:	84 fd                	test   %bh,%ch
>   31:	00 00                	add    %al,(%rax)
>   33:	00 8b 55 ec eb 12    	add    %cl,0x12ebec55(%rbx)
>   39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	8b 18                	mov    (%rax),%ebx
>    2:	85 db                	test   %ebx,%ebx
>    4:	0f 84 fd 00 00 00    	je     0x107
>    a:	8b 55 ec             	mov    -0x14(%rbp),%edx
>    d:	eb 12                	jmp    0x21
>    f:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
> [    7.948207][    T0] EAX: 003b2aa0 EBX: c294c1f7 ECX: dccd1bb1 EDX: 000ecaa8
> [    7.948774][    T0] ESI: 634ecaa8 EDI: c10001d1 EBP: c2449ddc ESP: c2449dac
> [    7.949279][    T0] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00210002
> [    7.949823][    T0] CR0: 80050033 CR2: 003b2aa0 CR3: 029de000 CR4: 000406b0
> [    7.950328][    T0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [    7.950833][    T0] DR6: fffe0ff0 DR7: 00000400
> [    7.951161][    T0] Call Trace:
> [ 7.951389][ T0] stack_depot_save (lib/stackdepot.c:476) 
> [ 7.951719][ T0] set_track (mm/slub.c:742) 
> [ 7.952006][ T0] ? __slab_alloc+0x17/0x30 
> [ 7.952459][ T0] ? kmem_cache_alloc (mm/slub.c:3195 mm/slub.c:3237 mm/slub.c:3242) 
> [ 7.952814][ T0] ? __kmem_cache_create (mm/slub.c:3991 mm/slub.c:4231 mm/slub.c:4900) 
> [ 7.953180][ T0] ? create_boot_cache (mm/slab_common.c:656) 
> [ 7.953532][ T0] ? kmem_cache_init (mm/slub.c:4847) 
> [ 7.953869][ T0] ? start_kernel (init/main.c:845 init/main.c:985) 
> [ 7.954197][ T0] ? i386_start_kernel (arch/x86/kernel/head32.c:57) 
> [ 7.954545][ T0] ? startup_32_smp (arch/x86/kernel/head_32.S:328) 
> [ 7.954889][ T0] alloc_debug_processing (mm/slub.c:1315) 
> [ 7.955260][ T0] ? __kmem_cache_create (mm/slub.c:3991 mm/slub.c:4231 mm/slub.c:4900) 
> [ 7.955625][ T0] ? __kmem_cache_create (mm/slub.c:3991 mm/slub.c:4231 mm/slub.c:4900) 
> [ 7.955988][ T0] ___slab_alloc+0x838/0xc60 
> [ 7.956404][ T0] ? __kmem_cache_create (mm/slub.c:3991 mm/slub.c:4231 mm/slub.c:4900) 
> [ 7.956771][ T0] ? __mutex_unlock_slowpath (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-long.h:523 include/linux/atomic/atomic-instrumented.h:1266 kernel/locking/mutex.c:902) 
> [ 7.957162][ T0] ? __kmem_cache_create (mm/slub.c:3991 mm/slub.c:4231 mm/slub.c:4900) 
> [ 7.957535][ T0] ? rcu_read_lock_sched_held (kernel/rcu/update.c:104 kernel/rcu/update.c:123) 
> [ 7.957970][ T0] ? pcpu_alloc (mm/percpu.c:1917) 
> [ 7.958291][ T0] __slab_alloc+0x17/0x30 
> [ 7.958716][ T0] kmem_cache_alloc (mm/slub.c:3195 mm/slub.c:3237 mm/slub.c:3242) 
> [ 7.959060][ T0] ? calculate_sizes+0x98/0x4b0 
> [ 7.959477][ T0] ? __kmem_cache_create (mm/slub.c:3991 mm/slub.c:4231 mm/slub.c:4900) 
> [ 7.959880][ T0] __kmem_cache_create (mm/slub.c:3991 mm/slub.c:4231 mm/slub.c:4900) 
> [ 7.960283][ T0] ? __kmem_cache_create (mm/slub.c:4905) 
> [ 7.960699][ T0] create_boot_cache (mm/slab_common.c:656) 
> [ 7.961081][ T0] kmem_cache_init (mm/slub.c:4847) 
> [ 7.961413][ T0] start_kernel (init/main.c:845 init/main.c:985) 
> [ 7.961727][ T0] ? early_idt_handler_common (arch/x86/kernel/head_32.S:417) 
> [ 7.962115][ T0] i386_start_kernel (arch/x86/kernel/head32.c:57) 
> [ 7.962463][ T0] startup_32_smp (arch/x86/kernel/head_32.S:328) 
> [    7.962790][    T0] Modules linked in:
> [    7.963063][    T0] CR2: 00000000003b2aa0
> [    7.964125][    T0] ---[ end trace 0000000000000000 ]---
> [ 7.964536][ T0] EIP: __stack_depot_save (lib/stackdepot.c:396) 
> [ 7.964917][ T0] Code: 0f 84 e0 00 00 00 83 fb 03 0f 84 d2 00 00 00 4b 90 0f 84 d4 00 00 00 a1 c0 a2 13 c3 89 f2 81 e2 ff ff 0f 00 8d 04 90 89 45 dc <8b> 18 85 db 0f 84 fd 00 00 00 8b 55 ec eb 12 8d b4 26 00 00 00 00
> All code
> ========
>    0:	0f 84 e0 00 00 00    	je     0xe6
>    6:	83 fb 03             	cmp    $0x3,%ebx
>    9:	0f 84 d2 00 00 00    	je     0xe1
>    f:	4b 90                	rex.WXB xchg %rax,%r8
>   11:	0f 84 d4 00 00 00    	je     0xeb
>   17:	a1 c0 a2 13 c3 89 f2 	movabs 0xe281f289c313a2c0,%eax
>   1e:	81 e2 
>   20:	ff                   	(bad)  
>   21:	ff 0f                	decl   (%rdi)
>   23:*	00 8d 04 90 89 45    	add    %cl,0x45899004(%rbp)		<-- trapping instruction
>   29:	dc 8b 18 85 db 0f    	fmull  0xfdb8518(%rbx)
>   2f:	84 fd                	test   %bh,%ch
>   31:	00 00                	add    %al,(%rax)
>   33:	00 8b 55 ec eb 12    	add    %cl,0x12ebec55(%rbx)
>   39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	8b 18                	mov    (%rax),%ebx
>    2:	85 db                	test   %ebx,%ebx
>    4:	0f 84 fd 00 00 00    	je     0x107
>    a:	8b 55 ec             	mov    -0x14(%rbp),%edx
>    d:	eb 12                	jmp    0x21
>    f:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.17.0-rc1-00003-gae107fa91914 .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/i386 5.17.0-rc1 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=90300
> CONFIG_CLANG_VERSION=0
> CONFIG_AS_IS_GNU=y
> CONFIG_AS_VERSION=23502
> CONFIG_LD_IS_BFD=y
> CONFIG_LD_VERSION=23502
> CONFIG_LLD_VERSION=0
> CONFIG_CC_CAN_LINK=y
> CONFIG_CC_CAN_LINK_STATIC=y
> CONFIG_CC_HAS_ASM_GOTO=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_TABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_BUILD_SALT=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> CONFIG_HAVE_KERNEL_ZSTD=y
> CONFIG_KERNEL_GZIP=y
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> # CONFIG_POSIX_MQUEUE is not set
> # CONFIG_WATCH_QUEUE is not set
> CONFIG_CROSS_MEMORY_ATTACH=y
> # CONFIG_USELIB is not set
> # CONFIG_AUDIT is not set
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_GENERIC_IRQ_CHIP=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_SIM=y
> CONFIG_IRQ_MSI_IOMMU=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
> 
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_INIT=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_HZ_PERIODIC=y
> # CONFIG_NO_HZ_IDLE is not set
> # CONFIG_NO_HZ is not set
> CONFIG_HIGH_RES_TIMERS=y
> # end of Timers subsystem
> 
> CONFIG_BPF=y
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # BPF subsystem
> #
> # CONFIG_BPF_SYSCALL is not set
> # CONFIG_BPF_JIT is not set
> # end of BPF subsystem
> 
> CONFIG_PREEMPT_VOLUNTARY_BUILD=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> # CONFIG_PREEMPT_DYNAMIC is not set
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> # CONFIG_IRQ_TIME_ACCOUNTING is not set
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> CONFIG_PSI=y
> CONFIG_PSI_DEFAULT_DISABLED=y
> # end of CPU/Task time and stats accounting
> 
> #
> # RCU Subsystem
> #
> CONFIG_TINY_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TINY_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_TASKS_RCU=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> # end of RCU Subsystem
> 
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_IKHEADERS=y
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> CONFIG_PRINTK_INDEX=y
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> 
> #
> # Scheduler features
> #
> # end of Scheduler features
> 
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
> CONFIG_CGROUPS=y
> CONFIG_PAGE_COUNTER=y
> CONFIG_MEMCG=y
> CONFIG_MEMCG_SWAP=y
> CONFIG_MEMCG_KMEM=y
> CONFIG_BLK_CGROUP=y
> CONFIG_CGROUP_WRITEBACK=y
> CONFIG_CGROUP_SCHED=y
> CONFIG_FAIR_GROUP_SCHED=y
> CONFIG_CFS_BANDWIDTH=y
> # CONFIG_RT_GROUP_SCHED is not set
> # CONFIG_CGROUP_PIDS is not set
> CONFIG_CGROUP_RDMA=y
> # CONFIG_CGROUP_FREEZER is not set
> CONFIG_CGROUP_DEVICE=y
> CONFIG_CGROUP_CPUACCT=y
> CONFIG_CGROUP_PERF=y
> CONFIG_CGROUP_MISC=y
> CONFIG_CGROUP_DEBUG=y
> CONFIG_NAMESPACES=y
> CONFIG_UTS_NS=y
> CONFIG_TIME_NS=y
> # CONFIG_IPC_NS is not set
> CONFIG_USER_NS=y
> CONFIG_PID_NS=y
> CONFIG_NET_NS=y
> CONFIG_CHECKPOINT_RESTORE=y
> CONFIG_SCHED_AUTOGROUP=y
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> # CONFIG_RD_XZ is not set
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> CONFIG_RD_ZSTD=y
> CONFIG_BOOT_CONFIG=y
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_LD_ORPHAN_WARN=y
> CONFIG_SYSCTL=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> # CONFIG_EXPERT is not set
> CONFIG_UID16=y
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_PCSPKR_PLATFORM=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_IO_URING=y
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> CONFIG_USERFAULTFD=y
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_KCMP=y
> CONFIG_RSEQ=y
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=y
> CONFIG_PERF_USE_VMALLOC=y
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> CONFIG_DEBUG_PERF_USE_VMALLOC=y
> # end of Kernel Performance Events And Counters
> 
> CONFIG_VM_EVENT_COUNTERS=y
> CONFIG_SLUB_DEBUG=y
> CONFIG_COMPAT_BRK=y
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> # CONFIG_SLAB_MERGE_DEFAULT is not set
> # CONFIG_SLAB_FREELIST_RANDOM is not set
> # CONFIG_SLAB_FREELIST_HARDENED is not set
> CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> CONFIG_PROFILING=y
> CONFIG_TRACEPOINTS=y
> # end of General setup
> 
> CONFIG_X86_32=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf32-i386"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_BITS_MAX=16
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HAS_FILTER_PGPROT=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_NR_GPIO=512
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=3
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> 
> #
> # Processor type and features
> #
> # CONFIG_SMP is not set
> CONFIG_X86_FEATURE_NAMES=y
> CONFIG_GOLDFISH=y
> # CONFIG_RETPOLINE is not set
> # CONFIG_X86_CPU_RESCTRL is not set
> # CONFIG_X86_EXTENDED_PLATFORM is not set
> # CONFIG_X86_INTEL_LPSS is not set
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> CONFIG_IOSF_MBI=y
> CONFIG_IOSF_MBI_DEBUG=y
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
> # CONFIG_X86_32_IRIS is not set
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> CONFIG_PARAVIRT_DEBUG=y
> CONFIG_X86_HV_CALLBACK_VECTOR=y
> CONFIG_KVM_GUEST=y
> CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> CONFIG_PVH=y
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_PARAVIRT_CLOCK=y
> # CONFIG_M486SX is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MEFFICEON is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MELAN is not set
> # CONFIG_MGEODEGX1 is not set
> # CONFIG_MGEODE_LX is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> CONFIG_MVIAC7=y
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=6
> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_IA32_FEAT_CTL=y
> CONFIG_X86_VMX_FEATURE_NAMES=y
> CONFIG_CPU_SUP_INTEL=y
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_HYGON=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_CPU_SUP_TRANSMETA_32=y
> CONFIG_CPU_SUP_ZHAOXIN=y
> CONFIG_CPU_SUP_VORTEX_32=y
> CONFIG_HPET_TIMER=y
> CONFIG_DMI=y
> CONFIG_NR_CPUS_RANGE_BEGIN=1
> CONFIG_NR_CPUS_RANGE_END=1
> CONFIG_NR_CPUS_DEFAULT=1
> CONFIG_NR_CPUS=1
> # CONFIG_X86_UP_APIC is not set
> CONFIG_X86_MCE=y
> # CONFIG_X86_MCELOG_LEGACY is not set
> # CONFIG_X86_ANCIENT_MCE is not set
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> CONFIG_PERF_EVENTS_INTEL_RAPL=m
> # CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
> # CONFIG_PERF_EVENTS_AMD_POWER is not set
> # CONFIG_PERF_EVENTS_AMD_UNCORE is not set
> # end of Performance monitoring
> 
> # CONFIG_X86_LEGACY_VM86 is not set
> CONFIG_X86_16BIT=y
> CONFIG_X86_ESPFIX32=y
> CONFIG_X86_IOPL_IOPERM=y
> CONFIG_TOSHIBA=y
> CONFIG_I8K=m
> CONFIG_X86_REBOOTFIXUPS=y
> CONFIG_MICROCODE=y
> CONFIG_MICROCODE_INTEL=y
> # CONFIG_MICROCODE_AMD is not set
> CONFIG_MICROCODE_OLD_INTERFACE=y
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
> # CONFIG_NOHIGHMEM is not set
> # CONFIG_HIGHMEM4G is not set
> CONFIG_HIGHMEM64G=y
> CONFIG_PAGE_OFFSET=0xC0000000
> CONFIG_HIGHMEM=y
> CONFIG_X86_PAE=y
> CONFIG_X86_CPA_STATISTICS=y
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ILLEGAL_POINTER_VALUE=0
> CONFIG_X86_PMEM_LEGACY_DEVICE=y
> CONFIG_X86_PMEM_LEGACY=y
> CONFIG_HIGHPTE=y
> CONFIG_X86_CHECK_BIOS_CORRUPTION=y
> # CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
> CONFIG_MTRR=y
> CONFIG_MTRR_SANITIZER=y
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> CONFIG_X86_PAT=y
> CONFIG_ARCH_USES_PG_UNCACHED=y
> CONFIG_ARCH_RANDOM=y
> CONFIG_X86_SMAP=y
> CONFIG_X86_UMIP=y
> CONFIG_X86_INTEL_TSX_MODE_OFF=y
> # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> # CONFIG_EFI is not set
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> CONFIG_HZ_1000=y
> CONFIG_HZ=1000
> CONFIG_SCHED_HRTICK=y
> CONFIG_KEXEC=y
> CONFIG_CRASH_DUMP=y
> CONFIG_PHYSICAL_START=0x1000000
> # CONFIG_RELOCATABLE is not set
> CONFIG_PHYSICAL_ALIGN=0x200000
> CONFIG_COMPAT_VDSO=y
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=y
> CONFIG_STRICT_SIGALTSTACK_SIZE=y
> # end of Processor type and features
> 
> CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
> 
> #
> # Power management and ACPI options
> #
> # CONFIG_SUSPEND is not set
> # CONFIG_HIBERNATION is not set
> CONFIG_PM=y
> CONFIG_PM_DEBUG=y
> CONFIG_PM_ADVANCED_DEBUG=y
> CONFIG_PM_CLK=y
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> CONFIG_ARCH_SUPPORTS_ACPI=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=y
> # CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
> CONFIG_ACPI_EC_DEBUGFS=y
> CONFIG_ACPI_AC=m
> # CONFIG_ACPI_BATTERY is not set
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_VIDEO=y
> CONFIG_ACPI_FAN=m
> CONFIG_ACPI_DOCK=y
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_PROCESSOR=m
> # CONFIG_ACPI_IPMI is not set
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
> CONFIG_ACPI_THERMAL=m
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> # CONFIG_ACPI_TABLE_UPGRADE is not set
> CONFIG_ACPI_DEBUG=y
> CONFIG_ACPI_PCI_SLOT=y
> CONFIG_ACPI_CONTAINER=y
> CONFIG_ACPI_SBS=m
> CONFIG_ACPI_HED=y
> CONFIG_ACPI_CUSTOM_METHOD=y
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> # CONFIG_ACPI_APEI is not set
> CONFIG_ACPI_DPTF=y
> CONFIG_DPTF_POWER=y
> CONFIG_DPTF_PCH_FIVR=m
> CONFIG_ACPI_WATCHDOG=y
> # CONFIG_ACPI_CONFIGFS is not set
> # CONFIG_ACPI_PCC is not set
> # CONFIG_PMIC_OPREGION is not set
> CONFIG_ACPI_VIOT=y
> CONFIG_X86_PM_TIMER=y
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> CONFIG_CPU_FREQ_STAT=y
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
> CONFIG_CPU_FREQ_GOV_USERSPACE=m
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
> 
> #
> # CPU frequency scaling drivers
> #
> # CONFIG_X86_INTEL_PSTATE is not set
> CONFIG_X86_PCC_CPUFREQ=m
> # CONFIG_X86_AMD_PSTATE is not set
> CONFIG_X86_ACPI_CPUFREQ=m
> # CONFIG_X86_ACPI_CPUFREQ_CPB is not set
> CONFIG_X86_POWERNOW_K6=y
> CONFIG_X86_POWERNOW_K7=m
> CONFIG_X86_POWERNOW_K7_ACPI=y
> CONFIG_X86_POWERNOW_K8=m
> # CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
> # CONFIG_X86_GX_SUSPMOD is not set
> CONFIG_X86_SPEEDSTEP_CENTRINO=y
> CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
> CONFIG_X86_SPEEDSTEP_ICH=y
> CONFIG_X86_SPEEDSTEP_SMI=m
> CONFIG_X86_P4_CLOCKMOD=m
> CONFIG_X86_CPUFREQ_NFORCE2=y
> # CONFIG_X86_LONGRUN is not set
> CONFIG_X86_LONGHAUL=m
> # CONFIG_X86_E_POWERSAVER is not set
> 
> #
> # shared options
> #
> CONFIG_X86_SPEEDSTEP_LIB=y
> CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y
> # end of CPU Frequency scaling
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> # CONFIG_CPU_IDLE_GOV_MENU is not set
> # CONFIG_CPU_IDLE_GOV_TEO is not set
> CONFIG_CPU_IDLE_GOV_HALTPOLL=y
> # CONFIG_HALTPOLL_CPUIDLE is not set
> # end of CPU Idle
> 
> CONFIG_INTEL_IDLE=y
> # end of Power management and ACPI options
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI_GOBIOS=y
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> # CONFIG_PCI_GOANY is not set
> CONFIG_PCI_BIOS=y
> CONFIG_ISA_DMA_API=y
> # CONFIG_ISA is not set
> # CONFIG_SCx200 is not set
> # CONFIG_ALIX is not set
> CONFIG_NET5501=y
> # CONFIG_GEOS is not set
> CONFIG_AMD_NB=y
> # end of Bus options (PCI etc.)
> 
> #
> # Binary Emulations
> #
> CONFIG_COMPAT_32=y
> # end of Binary Emulations
> 
> CONFIG_HAVE_ATOMIC_IOMAP=y
> CONFIG_HAVE_KVM=y
> CONFIG_VIRTUALIZATION=y
> CONFIG_AS_AVX512=y
> CONFIG_AS_SHA1_NI=y
> CONFIG_AS_SHA256_NI=y
> CONFIG_AS_TPAUSE=y
> 
> #
> # General architecture-dependent options
> #
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_GENERIC_ENTRY=y
> CONFIG_KPROBES=y
> CONFIG_JUMP_LABEL=y
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> # CONFIG_STATIC_CALL_SELFTEST is not set
> CONFIG_OPTPROBES=y
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_KRETPROBES=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_ARCH_WANTS_NO_INSTR=y
> CONFIG_ARCH_32BIT_OFF_T=y
> CONFIG_HAVE_ASM_MODVERSIONS=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> CONFIG_MMU_GATHER_TABLE_FREE=y
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> CONFIG_HAVE_ARCH_SECCOMP=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP=y
> CONFIG_SECCOMP_FILTER=y
> # CONFIG_SECCOMP_CACHE_DEBUG is not set
> CONFIG_HAVE_ARCH_STACKLEAK=y
> CONFIG_HAVE_STACKPROTECTOR=y
> # CONFIG_STACKPROTECTOR is not set
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
> CONFIG_LTO_NONE=y
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_MOVE_PUD=y
> CONFIG_HAVE_MOVE_PMD=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_HUGE_VMAP=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_REL=y
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=8
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
> CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
> CONFIG_ISA_BUS_API=y
> CONFIG_CLONE_BACKWARDS=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
> CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> # CONFIG_LOCK_EVENT_COUNTS is not set
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> CONFIG_HAVE_STATIC_CALL=y
> CONFIG_HAVE_PREEMPT_DYNAMIC=y
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_ARCH_SPLIT_ARG64=y
> CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
> CONFIG_DYNAMIC_SIGFRAME=y
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULE_SIG_FORMAT=y
> CONFIG_MODULES=y
> # CONFIG_MODULE_FORCE_LOAD is not set
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_MODULE_SIG=y
> # CONFIG_MODULE_SIG_FORCE is not set
> # CONFIG_MODULE_SIG_ALL is not set
> # CONFIG_MODULE_SIG_SHA1 is not set
> # CONFIG_MODULE_SIG_SHA224 is not set
> CONFIG_MODULE_SIG_SHA256=y
> # CONFIG_MODULE_SIG_SHA384 is not set
> # CONFIG_MODULE_SIG_SHA512 is not set
> CONFIG_MODULE_SIG_HASH="sha256"
> CONFIG_MODULE_COMPRESS_NONE=y
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> # CONFIG_MODULE_COMPRESS_XZ is not set
> # CONFIG_MODULE_COMPRESS_ZSTD is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH="/sbin/modprobe"
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLK_RQ_ALLOC_TIME=y
> CONFIG_BLK_CGROUP_RWSTAT=y
> CONFIG_BLK_ICQ=y
> # CONFIG_BLK_DEV_BSGLIB is not set
> CONFIG_BLK_DEV_INTEGRITY=y
> CONFIG_BLK_DEV_INTEGRITY_T10=m
> CONFIG_BLK_DEV_ZONED=y
> CONFIG_BLK_DEV_THROTTLING=y
> # CONFIG_BLK_DEV_THROTTLING_LOW is not set
> # CONFIG_BLK_WBT is not set
> # CONFIG_BLK_CGROUP_IOLATENCY is not set
> # CONFIG_BLK_CGROUP_FC_APPID is not set
> CONFIG_BLK_CGROUP_IOCOST=y
> CONFIG_BLK_CGROUP_IOPRIO=y
> CONFIG_BLK_DEBUG_FS=y
> CONFIG_BLK_DEBUG_FS_ZONED=y
> CONFIG_BLK_SED_OPAL=y
> CONFIG_BLK_INLINE_ENCRYPTION=y
> CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_AMIGA_PARTITION=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_EFI_PARTITION=y
> # end of Partition Types
> 
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_MQ_VIRTIO=y
> CONFIG_BLK_PM=y
> 
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=y
> CONFIG_MQ_IOSCHED_KYBER=y
> CONFIG_IOSCHED_BFQ=m
> # CONFIG_BFQ_GROUP_IOSCHED is not set
> # end of IO Schedulers
> 
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_BINFMT_MISC=m
> CONFIG_COREDUMP=y
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_FLATMEM_MANUAL=y
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=y
> CONFIG_SPARSEMEM_STATIC=y
> CONFIG_HAVE_FAST_GUP=y
> CONFIG_MEMORY_ISOLATION=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> # CONFIG_COMPACTION is not set
> # CONFIG_PAGE_REPORTING is not set
> CONFIG_MIGRATION=y
> CONFIG_CONTIG_ALLOC=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> # CONFIG_BOUNCE is not set
> CONFIG_VIRT_TO_BUS=y
> CONFIG_MMU_NOTIFIER=y
> # CONFIG_KSM is not set
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
> CONFIG_MEMORY_FAILURE=y
> CONFIG_HWPOISON_INJECT=m
> # CONFIG_TRANSPARENT_HUGEPAGE is not set
> CONFIG_NEED_PER_CPU_KM=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_FRONTSWAP=y
> CONFIG_CMA=y
> CONFIG_CMA_DEBUG=y
> CONFIG_CMA_DEBUGFS=y
> # CONFIG_CMA_SYSFS is not set
> CONFIG_CMA_AREAS=7
> CONFIG_ZSWAP=y
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842=y
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT="842"
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD is not set
> CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD=y
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
> CONFIG_ZSWAP_ZPOOL_DEFAULT="z3fold"
> # CONFIG_ZSWAP_DEFAULT_ON is not set
> CONFIG_ZPOOL=y
> CONFIG_ZBUD=y
> CONFIG_Z3FOLD=y
> CONFIG_ZSMALLOC=y
> # CONFIG_ZSMALLOC_STAT is not set
> CONFIG_GENERIC_EARLY_IOREMAP=y
> CONFIG_PAGE_IDLE_FLAG=y
> CONFIG_IDLE_PAGE_TRACKING=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ZONE_DMA=y
> CONFIG_VMAP_PFN=y
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_TEST is not set
> CONFIG_GUP_GET_PTE_LOW_HIGH=y
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> CONFIG_KMAP_LOCAL=y
> CONFIG_SECRETMEM=y
> CONFIG_ANON_VMA_NAME=y
> 
> #
> # Data Access Monitoring
> #
> # CONFIG_DAMON is not set
> # end of Data Access Monitoring
> # end of Memory Management options
> 
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_DIAG is not set
> CONFIG_UNIX=y
> CONFIG_UNIX_SCM=y
> CONFIG_AF_UNIX_OOB=y
> # CONFIG_UNIX_DIAG is not set
> # CONFIG_TLS is not set
> # CONFIG_XFRM_USER is not set
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE_DEMUX is not set
> CONFIG_NET_IP_TUNNEL=y
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_NET_IPVTI is not set
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> CONFIG_INET_TUNNEL=y
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_INET_UDP_DIAG is not set
> # CONFIG_INET_RAW_DIAG is not set
> # CONFIG_INET_DIAG_DESTROY is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> CONFIG_IPV6=y
> # CONFIG_IPV6_ROUTER_PREF is not set
> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> # CONFIG_IPV6_MIP6 is not set
> # CONFIG_IPV6_VTI is not set
> CONFIG_IPV6_SIT=y
> # CONFIG_IPV6_SIT_6RD is not set
> CONFIG_IPV6_NDISC_NODETYPE=y
> # CONFIG_IPV6_TUNNEL is not set
> # CONFIG_IPV6_MULTIPLE_TABLES is not set
> # CONFIG_IPV6_MROUTE is not set
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> # CONFIG_IPV6_IOAM6_LWTUNNEL is not set
> # CONFIG_NETLABEL is not set
> # CONFIG_MPTCP is not set
> # CONFIG_NETWORK_SECMARK is not set
> CONFIG_NET_PTP_CLASSIFY=y
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_BPFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> # CONFIG_6LOWPAN is not set
> # CONFIG_IEEE802154 is not set
> # CONFIG_NET_SCHED is not set
> # CONFIG_DCB is not set
> CONFIG_DNS_RESOLVER=m
> # CONFIG_BATMAN_ADV is not set
> # CONFIG_OPENVSWITCH is not set
> # CONFIG_VSOCKETS is not set
> # CONFIG_NETLINK_DIAG is not set
> # CONFIG_MPLS is not set
> # CONFIG_NET_NSH is not set
> # CONFIG_HSR is not set
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> # CONFIG_QRTR is not set
> # CONFIG_NET_NCSI is not set
> # CONFIG_CGROUP_NET_PRIO is not set
> # CONFIG_CGROUP_NET_CLASSID is not set
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_NET_DROP_MONITOR is not set
> # end of Network testing
> # end of Networking options
> 
> # CONFIG_HAMRADIO is not set
> # CONFIG_CAN is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> # CONFIG_MCTP is not set
> CONFIG_WIRELESS=y
> # CONFIG_CFG80211 is not set
> 
> #
> # CFG80211 needs to be enabled for MAC80211
> #
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> # CONFIG_RFKILL is not set
> CONFIG_NET_9P=y
> CONFIG_NET_9P_FD=y
> CONFIG_NET_9P_VIRTIO=y
> # CONFIG_NET_9P_DEBUG is not set
> # CONFIG_CAIF is not set
> # CONFIG_CEPH_LIB is not set
> # CONFIG_NFC is not set
> # CONFIG_PSAMPLE is not set
> # CONFIG_NET_IFE is not set
> # CONFIG_LWTUNNEL is not set
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> CONFIG_FAILOVER=m
> CONFIG_ETHTOOL_NETLINK=y
> 
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=y
> # CONFIG_EISA is not set
> CONFIG_HAVE_PCI=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> CONFIG_PCIEPORTBUS=y
> # CONFIG_PCIEAER is not set
> CONFIG_PCIEASPM=y
> # CONFIG_PCIEASPM_DEFAULT is not set
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> CONFIG_PCIEASPM_PERFORMANCE=y
> CONFIG_PCIE_PME=y
> # CONFIG_PCIE_PTM is not set
> # CONFIG_PCI_MSI is not set
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_STUB is not set
> CONFIG_PCI_ATS=y
> CONFIG_PCI_LOCKLESS_CONFIG=y
> # CONFIG_PCI_IOV is not set
> # CONFIG_PCI_PRI is not set
> CONFIG_PCI_PASID=y
> CONFIG_PCI_LABEL=y
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # PCI controller drivers
> #
> 
> #
> # DesignWare PCI Core Support
> #
> # end of DesignWare PCI Core Support
> 
> #
> # Mobiveil PCIe Core Support
> #
> # end of Mobiveil PCIe Core Support
> 
> #
> # Cadence PCIe controllers support
> #
> # end of Cadence PCIe controllers support
> # end of PCI controller drivers
> 
> #
> # PCI Endpoint
> #
> CONFIG_PCI_ENDPOINT=y
> # CONFIG_PCI_ENDPOINT_CONFIGFS is not set
> # CONFIG_PCI_EPF_TEST is not set
> # CONFIG_PCI_EPF_NTB is not set
> # end of PCI Endpoint
> 
> #
> # PCI switch controller drivers
> #
> CONFIG_PCI_SW_SWITCHTEC=y
> # end of PCI switch controller drivers
> 
> CONFIG_CXL_BUS=y
> CONFIG_CXL_MEM=m
> # CONFIG_CXL_MEM_RAW_COMMANDS is not set
> # CONFIG_CXL_ACPI is not set
> # CONFIG_CXL_PMEM is not set
> CONFIG_PCCARD=y
> CONFIG_PCMCIA=m
> CONFIG_PCMCIA_LOAD_CIS=y
> CONFIG_CARDBUS=y
> 
> #
> # PC-card bridges
> #
> CONFIG_YENTA=m
> CONFIG_YENTA_O2=y
> CONFIG_YENTA_RICOH=y
> CONFIG_YENTA_TI=y
> CONFIG_YENTA_ENE_TUNE=y
> CONFIG_YENTA_TOSHIBA=y
> CONFIG_PD6729=m
> # CONFIG_I82092 is not set
> CONFIG_PCCARD_NONSTATIC=y
> # CONFIG_RAPIDIO is not set
> 
> #
> # Generic Driver Options
> #
> CONFIG_AUXILIARY_BUS=y
> CONFIG_UEVENT_HELPER=y
> CONFIG_UEVENT_HELPER_PATH=""
> CONFIG_DEVTMPFS=y
> # CONFIG_DEVTMPFS_MOUNT is not set
> # CONFIG_DEVTMPFS_SAFE is not set
> CONFIG_STANDALONE=y
> # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_EXTRA_FIRMWARE=""
> # CONFIG_FW_LOADER_USER_HELPER is not set
> # CONFIG_FW_LOADER_COMPRESS is not set
> # end of Firmware loader
> 
> CONFIG_WANT_DEV_COREDUMP=y
> CONFIG_ALLOW_DEV_COREDUMP=y
> CONFIG_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> CONFIG_DEBUG_DEVRES=y
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_SLIMBUS=m
> CONFIG_REGMAP_SPI=y
> CONFIG_REGMAP_W1=y
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_REGMAP_SCCB=m
> CONFIG_REGMAP_I3C=m
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> CONFIG_MHI_BUS=m
> CONFIG_MHI_BUS_DEBUG=y
> # CONFIG_MHI_BUS_PCI_GENERIC is not set
> # end of Bus devices
> 
> # CONFIG_CONNECTOR is not set
> 
> #
> # Firmware Drivers
> #
> 
> #
> # ARM System Control and Management Interface Protocol
> #
> # end of ARM System Control and Management Interface Protocol
> 
> # CONFIG_EDD is not set
> CONFIG_FIRMWARE_MEMMAP=y
> CONFIG_DMIID=y
> CONFIG_DMI_SYSFS=m
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> CONFIG_FW_CFG_SYSFS=m
> # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
> CONFIG_SYSFB=y
> CONFIG_SYSFB_SIMPLEFB=y
> CONFIG_GOOGLE_FIRMWARE=y
> CONFIG_GOOGLE_SMI=y
> CONFIG_GOOGLE_COREBOOT_TABLE=m
> CONFIG_GOOGLE_MEMCONSOLE=m
> CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY=m
> CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=m
> # CONFIG_GOOGLE_VPD is not set
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> CONFIG_GNSS=y
> CONFIG_GNSS_SERIAL=m
> CONFIG_GNSS_MTK_SERIAL=m
> CONFIG_GNSS_SIRF_SERIAL=m
> # CONFIG_GNSS_UBX_SERIAL is not set
> CONFIG_MTD=m
> # CONFIG_MTD_TESTS is not set
> 
> #
> # Partition parsers
> #
> CONFIG_MTD_AR7_PARTS=m
> CONFIG_MTD_CMDLINE_PARTS=m
> # CONFIG_MTD_REDBOOT_PARTS is not set
> # end of Partition parsers
> 
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_BLKDEVS=m
> # CONFIG_MTD_BLOCK is not set
> CONFIG_MTD_BLOCK_RO=m
> 
> #
> # Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
> #
> CONFIG_FTL=m
> # CONFIG_NFTL is not set
> CONFIG_INFTL=m
> CONFIG_RFD_FTL=m
> CONFIG_SSFDC=m
> CONFIG_SM_FTL=m
> # CONFIG_MTD_OOPS is not set
> CONFIG_MTD_SWAP=m
> CONFIG_MTD_PARTITIONED_MASTER=y
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=m
> CONFIG_MTD_JEDECPROBE=m
> CONFIG_MTD_GEN_PROBE=m
> # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> CONFIG_MTD_CFI_INTELEXT=m
> CONFIG_MTD_CFI_AMDSTD=m
> CONFIG_MTD_CFI_STAA=m
> CONFIG_MTD_CFI_UTIL=m
> CONFIG_MTD_RAM=m
> # CONFIG_MTD_ROM is not set
> CONFIG_MTD_ABSENT=m
> # end of RAM/ROM/Flash chip drivers
> 
> #
> # Mapping drivers for chip access
> #
> CONFIG_MTD_COMPLEX_MAPPINGS=y
> # CONFIG_MTD_PHYSMAP is not set
> # CONFIG_MTD_SBC_GXX is not set
> CONFIG_MTD_AMD76XROM=m
> # CONFIG_MTD_ICHXROM is not set
> # CONFIG_MTD_ESB2ROM is not set
> # CONFIG_MTD_CK804XROM is not set
> CONFIG_MTD_SCB2_FLASH=m
> CONFIG_MTD_NETtel=m
> # CONFIG_MTD_L440GX is not set
> CONFIG_MTD_PCI=m
> CONFIG_MTD_PCMCIA=m
> # CONFIG_MTD_PCMCIA_ANONYMOUS is not set
> CONFIG_MTD_INTEL_VR_NOR=m
> # CONFIG_MTD_PLATRAM is not set
> # end of Mapping drivers for chip access
> 
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_PMC551 is not set
> CONFIG_MTD_DATAFLASH=m
> # CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
> CONFIG_MTD_DATAFLASH_OTP=y
> CONFIG_MTD_MCHP23K256=m
> CONFIG_MTD_MCHP48L640=m
> # CONFIG_MTD_SST25L is not set
> # CONFIG_MTD_SLRAM is not set
> CONFIG_MTD_PHRAM=m
> # CONFIG_MTD_MTDRAM is not set
> CONFIG_MTD_BLOCK2MTD=m
> 
> #
> # Disk-On-Chip Device Drivers
> #
> CONFIG_MTD_DOCG3=m
> CONFIG_BCH_CONST_M=14
> CONFIG_BCH_CONST_T=4
> # end of Self-contained MTD device drivers
> 
> #
> # NAND
> #
> CONFIG_MTD_NAND_CORE=m
> CONFIG_MTD_ONENAND=m
> CONFIG_MTD_ONENAND_VERIFY_WRITE=y
> # CONFIG_MTD_ONENAND_GENERIC is not set
> CONFIG_MTD_ONENAND_OTP=y
> # CONFIG_MTD_ONENAND_2X_PROGRAM is not set
> CONFIG_MTD_RAW_NAND=m
> 
> #
> # Raw/parallel NAND flash controllers
> #
> CONFIG_MTD_NAND_DENALI=m
> CONFIG_MTD_NAND_DENALI_PCI=m
> CONFIG_MTD_NAND_CAFE=m
> CONFIG_MTD_NAND_CS553X=m
> # CONFIG_MTD_NAND_MXIC is not set
> CONFIG_MTD_NAND_GPIO=m
> CONFIG_MTD_NAND_PLATFORM=m
> # CONFIG_MTD_NAND_ARASAN is not set
> 
> #
> # Misc
> #
> # CONFIG_MTD_NAND_NANDSIM is not set
> # CONFIG_MTD_NAND_RICOH is not set
> CONFIG_MTD_NAND_DISKONCHIP=m
> CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
> CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
> CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH=y
> CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
> CONFIG_MTD_SPI_NAND=m
> 
> #
> # ECC engine support
> #
> CONFIG_MTD_NAND_ECC=y
> CONFIG_MTD_NAND_ECC_SW_HAMMING=y
> CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
> CONFIG_MTD_NAND_ECC_SW_BCH=y
> # end of ECC engine support
> # end of NAND
> 
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> # CONFIG_MTD_LPDDR is not set
> # end of LPDDR & LPDDR2 PCM memory drivers
> 
> CONFIG_MTD_SPI_NOR=m
> CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
> # CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
> CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE=y
> # CONFIG_MTD_SPI_NOR_SWP_KEEP is not set
> CONFIG_SPI_INTEL_SPI=m
> CONFIG_SPI_INTEL_SPI_PCI=m
> CONFIG_SPI_INTEL_SPI_PLATFORM=m
> CONFIG_MTD_UBI=m
> CONFIG_MTD_UBI_WL_THRESHOLD=4096
> CONFIG_MTD_UBI_BEB_LIMIT=20
> CONFIG_MTD_UBI_FASTMAP=y
> CONFIG_MTD_UBI_GLUEBI=m
> CONFIG_MTD_UBI_BLOCK=y
> CONFIG_MTD_HYPERBUS=m
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> CONFIG_PARPORT=m
> # CONFIG_PARPORT_PC is not set
> CONFIG_PARPORT_AX88796=m
> # CONFIG_PARPORT_1284 is not set
> CONFIG_PARPORT_NOT_PC=y
> CONFIG_PNP=y
> # CONFIG_PNP_DEBUG_MESSAGES is not set
> 
> #
> # Protocols
> #
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> CONFIG_BLK_DEV_NULL_BLK=y
> CONFIG_BLK_DEV_FD=y
> CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
> CONFIG_ZRAM=y
> CONFIG_ZRAM_DEF_COMP_LZORLE=y
> # CONFIG_ZRAM_DEF_COMP_LZ4 is not set
> # CONFIG_ZRAM_DEF_COMP_LZO is not set
> # CONFIG_ZRAM_DEF_COMP_842 is not set
> CONFIG_ZRAM_DEF_COMP="lzo-rle"
> # CONFIG_ZRAM_WRITEBACK is not set
> # CONFIG_ZRAM_MEMORY_TRACKING is not set
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
> # CONFIG_BLK_DEV_DRBD is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_ATA_OVER_ETH is not set
> # CONFIG_VIRTIO_BLK is not set
> # CONFIG_BLK_DEV_RBD is not set
> 
> #
> # NVME Support
> #
> CONFIG_NVME_CORE=m
> # CONFIG_BLK_DEV_NVME is not set
> CONFIG_NVME_MULTIPATH=y
> CONFIG_NVME_HWMON=y
> CONFIG_NVME_FABRICS=m
> CONFIG_NVME_FC=m
> # CONFIG_NVME_TCP is not set
> CONFIG_NVME_TARGET=m
> CONFIG_NVME_TARGET_PASSTHRU=y
> CONFIG_NVME_TARGET_LOOP=m
> CONFIG_NVME_TARGET_FC=m
> # CONFIG_NVME_TARGET_FCLOOP is not set
> # CONFIG_NVME_TARGET_TCP is not set
> # end of NVME Support
> 
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=y
> CONFIG_AD525X_DPOT=y
> CONFIG_AD525X_DPOT_I2C=y
> # CONFIG_AD525X_DPOT_SPI is not set
> CONFIG_DUMMY_IRQ=m
> CONFIG_IBM_ASM=m
> CONFIG_PHANTOM=y
> CONFIG_TIFM_CORE=m
> # CONFIG_TIFM_7XX1 is not set
> # CONFIG_ICS932S401 is not set
> # CONFIG_ENCLOSURE_SERVICES is not set
> CONFIG_CS5535_MFGPT=m
> CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
> # CONFIG_CS5535_CLOCK_EVENT_SRC is not set
> # CONFIG_HP_ILO is not set
> CONFIG_APDS9802ALS=y
> CONFIG_ISL29003=m
> CONFIG_ISL29020=m
> CONFIG_SENSORS_TSL2550=y
> CONFIG_SENSORS_BH1770=y
> CONFIG_SENSORS_APDS990X=y
> # CONFIG_HMC6352 is not set
> # CONFIG_DS1682 is not set
> # CONFIG_PCH_PHUB is not set
> # CONFIG_LATTICE_ECP3_CONFIG is not set
> CONFIG_SRAM=y
> # CONFIG_DW_XDATA_PCIE is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> CONFIG_XILINX_SDFEC=m
> CONFIG_C2PORT=m
> CONFIG_C2PORT_DURAMAR_2150=m
> 
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> CONFIG_EEPROM_AT25=m
> CONFIG_EEPROM_LEGACY=y
> # CONFIG_EEPROM_MAX6875 is not set
> CONFIG_EEPROM_93CX6=y
> CONFIG_EEPROM_93XX46=m
> # CONFIG_EEPROM_IDT_89HPESX is not set
> CONFIG_EEPROM_EE1004=y
> # end of EEPROM support
> 
> CONFIG_CB710_CORE=y
> # CONFIG_CB710_DEBUG is not set
> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> # end of Texas Instruments shared transport line discipline
> 
> CONFIG_SENSORS_LIS3_I2C=y
> CONFIG_ALTERA_STAPL=m
> CONFIG_INTEL_MEI=y
> CONFIG_INTEL_MEI_ME=m
> CONFIG_INTEL_MEI_TXE=y
> CONFIG_INTEL_MEI_HDCP=m
> # CONFIG_INTEL_MEI_PXP is not set
> # CONFIG_VMWARE_VMCI is not set
> CONFIG_ECHO=y
> CONFIG_MISC_ALCOR_PCI=y
> # CONFIG_MISC_RTSX_PCI is not set
> # CONFIG_HABANA_AI is not set
> CONFIG_UACCE=y
> # CONFIG_PVPANIC is not set
> # end of Misc devices
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> # CONFIG_RAID_ATTRS is not set
> CONFIG_SCSI_COMMON=m
> # CONFIG_SCSI is not set
> # end of SCSI device support
> 
> # CONFIG_ATA is not set
> # CONFIG_MD is not set
> CONFIG_TARGET_CORE=m
> CONFIG_TCM_IBLOCK=m
> CONFIG_TCM_FILEIO=m
> # CONFIG_TCM_USER2 is not set
> # CONFIG_ISCSI_TARGET is not set
> CONFIG_SBP_TARGET=m
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=m
> CONFIG_FIREWIRE_OHCI=m
> # CONFIG_FIREWIRE_NET is not set
> CONFIG_FIREWIRE_NOSY=m
> # end of IEEE 1394 (FireWire) support
> 
> CONFIG_MACINTOSH_DRIVERS=y
> CONFIG_MAC_EMUMOUSEBTN=y
> CONFIG_NETDEVICES=y
> CONFIG_NET_CORE=y
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> # CONFIG_WIREGUARD is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_IPVLAN is not set
> # CONFIG_VXLAN is not set
> # CONFIG_GENEVE is not set
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_MACSEC is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_TUN is not set
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> CONFIG_VIRTIO_NET=m
> # CONFIG_NLMON is not set
> # CONFIG_MHI_NET is not set
> # CONFIG_ARCNET is not set
> CONFIG_ETHERNET=y
> CONFIG_NET_VENDOR_3COM=y
> # CONFIG_PCMCIA_3C574 is not set
> # CONFIG_PCMCIA_3C589 is not set
> # CONFIG_VORTEX is not set
> # CONFIG_TYPHOON is not set
> CONFIG_NET_VENDOR_ADAPTEC=y
> # CONFIG_ADAPTEC_STARFIRE is not set
> CONFIG_NET_VENDOR_AGERE=y
> # CONFIG_ET131X is not set
> CONFIG_NET_VENDOR_ALACRITECH=y
> # CONFIG_SLICOSS is not set
> CONFIG_NET_VENDOR_ALTEON=y
> # CONFIG_ACENIC is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=y
> # CONFIG_NET_VENDOR_AMD is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> # CONFIG_AQTION is not set
> CONFIG_NET_VENDOR_ARC=y
> CONFIG_NET_VENDOR_ASIX=y
> # CONFIG_SPI_AX88796C is not set
> CONFIG_NET_VENDOR_ATHEROS=y
> # CONFIG_ATL2 is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> # CONFIG_ALX is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> # CONFIG_BNX2 is not set
> # CONFIG_CNIC is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2X is not set
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_BROCADE=y
> # CONFIG_BNA is not set
> CONFIG_NET_VENDOR_CADENCE=y
> # CONFIG_MACB is not set
> CONFIG_NET_VENDOR_CAVIUM=y
> CONFIG_NET_VENDOR_CHELSIO=y
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_CHELSIO_T4 is not set
> # CONFIG_CHELSIO_T4VF is not set
> CONFIG_NET_VENDOR_CISCO=y
> # CONFIG_ENIC is not set
> CONFIG_NET_VENDOR_CORTINA=y
> # CONFIG_CX_ECAT is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=y
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=y
> # CONFIG_DL2K is not set
> # CONFIG_SUNDANCE is not set
> CONFIG_NET_VENDOR_EMULEX=y
> # CONFIG_BE2NET is not set
> CONFIG_NET_VENDOR_ENGLEDER=y
> # CONFIG_TSNEP is not set
> CONFIG_NET_VENDOR_EZCHIP=y
> CONFIG_NET_VENDOR_FUJITSU=y
> # CONFIG_PCMCIA_FMVJ18X is not set
> CONFIG_NET_VENDOR_GOOGLE=y
> CONFIG_NET_VENDOR_HUAWEI=y
> CONFIG_NET_VENDOR_I825XX=y
> CONFIG_NET_VENDOR_INTEL=y
> # CONFIG_E100 is not set
> CONFIG_E1000=y
> # CONFIG_E1000E is not set
> # CONFIG_IGB is not set
> # CONFIG_IGBVF is not set
> # CONFIG_IXGB is not set
> # CONFIG_IXGBE is not set
> # CONFIG_I40E is not set
> # CONFIG_IGC is not set
> CONFIG_NET_VENDOR_MICROSOFT=y
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_LITEX=y
> CONFIG_NET_VENDOR_MARVELL=y
> # CONFIG_MVMDIO is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> # CONFIG_MLX4_EN is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=y
> # CONFIG_KS8842 is not set
> # CONFIG_KS8851 is not set
> # CONFIG_KS8851_MLL is not set
> # CONFIG_KSZ884X_PCI is not set
> CONFIG_NET_VENDOR_MICROCHIP=y
> # CONFIG_ENC28J60 is not set
> # CONFIG_ENCX24J600 is not set
> # CONFIG_LAN743X is not set
> CONFIG_NET_VENDOR_MICROSEMI=y
> CONFIG_NET_VENDOR_MYRI=y
> # CONFIG_MYRI10GE is not set
> # CONFIG_FEALNX is not set
> CONFIG_NET_VENDOR_NATSEMI=y
> # CONFIG_NATSEMI is not set
> # CONFIG_NS83820 is not set
> CONFIG_NET_VENDOR_NETERION=y
> # CONFIG_S2IO is not set
> # CONFIG_VXGE is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> CONFIG_NET_VENDOR_NI=y
> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_8390=y
> # CONFIG_PCMCIA_AXNET is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_PCMCIA_PCNET is not set
> CONFIG_NET_VENDOR_NVIDIA=y
> # CONFIG_FORCEDETH is not set
> CONFIG_NET_VENDOR_OKI=y
> # CONFIG_PCH_GBE is not set
> # CONFIG_ETHOC is not set
> CONFIG_NET_VENDOR_PACKET_ENGINES=y
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> CONFIG_NET_VENDOR_PENSANDO=y
> CONFIG_NET_VENDOR_QLOGIC=y
> # CONFIG_QLA3XXX is not set
> # CONFIG_QLCNIC is not set
> # CONFIG_NETXEN_NIC is not set
> # CONFIG_QED is not set
> CONFIG_NET_VENDOR_QUALCOMM=y
> # CONFIG_QCOM_EMAC is not set
> # CONFIG_RMNET is not set
> CONFIG_NET_VENDOR_RDC=y
> # CONFIG_R6040 is not set
> CONFIG_NET_VENDOR_REALTEK=y
> # CONFIG_ATP is not set
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_R8169 is not set
> CONFIG_NET_VENDOR_RENESAS=y
> CONFIG_NET_VENDOR_ROCKER=y
> CONFIG_NET_VENDOR_SAMSUNG=y
> # CONFIG_SXGBE_ETH is not set
> CONFIG_NET_VENDOR_SEEQ=y
> CONFIG_NET_VENDOR_SOLARFLARE=y
> # CONFIG_SFC is not set
> # CONFIG_SFC_FALCON is not set
> CONFIG_NET_VENDOR_SILAN=y
> # CONFIG_SC92031 is not set
> CONFIG_NET_VENDOR_SIS=y
> # CONFIG_SIS900 is not set
> # CONFIG_SIS190 is not set
> CONFIG_NET_VENDOR_SMSC=y
> # CONFIG_PCMCIA_SMC91C92 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC911X is not set
> # CONFIG_SMSC9420 is not set
> CONFIG_NET_VENDOR_SOCIONEXT=y
> CONFIG_NET_VENDOR_STMICRO=y
> # CONFIG_STMMAC_ETH is not set
> CONFIG_NET_VENDOR_SUN=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NIU is not set
> CONFIG_NET_VENDOR_SYNOPSYS=y
> # CONFIG_DWC_XLGMAC is not set
> CONFIG_NET_VENDOR_TEHUTI=y
> # CONFIG_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=y
> # CONFIG_TI_CPSW_PHY_SEL is not set
> # CONFIG_TLAN is not set
> CONFIG_NET_VENDOR_VERTEXCOM=y
> # CONFIG_MSE102X is not set
> CONFIG_NET_VENDOR_VIA=y
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_NET_VENDOR_WIZNET=y
> # CONFIG_WIZNET_W5100 is not set
> # CONFIG_WIZNET_W5300 is not set
> CONFIG_NET_VENDOR_XILINX=y
> # CONFIG_XILINX_EMACLITE is not set
> # CONFIG_XILINX_AXI_EMAC is not set
> # CONFIG_XILINX_LL_TEMAC is not set
> CONFIG_NET_VENDOR_XIRCOM=y
> # CONFIG_PCMCIA_XIRC2PS is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> # CONFIG_PHYLIB is not set
> # CONFIG_MICREL_KS8995MA is not set
> # CONFIG_MDIO_DEVICE is not set
> 
> #
> # PCS device drivers
> #
> # end of PCS device drivers
> 
> # CONFIG_PLIP is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> 
> #
> # Host-side USB support is needed for USB Network Adapter support
> #
> CONFIG_WLAN=y
> CONFIG_WLAN_VENDOR_ADMTEK=y
> CONFIG_WLAN_VENDOR_ATH=y
> # CONFIG_ATH_DEBUG is not set
> # CONFIG_ATH5K_PCI is not set
> CONFIG_WLAN_VENDOR_ATMEL=y
> CONFIG_WLAN_VENDOR_BROADCOM=y
> CONFIG_WLAN_VENDOR_CISCO=y
> CONFIG_WLAN_VENDOR_INTEL=y
> # CONFIG_IWLMEI is not set
> CONFIG_WLAN_VENDOR_INTERSIL=y
> # CONFIG_HOSTAP is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> CONFIG_WLAN_VENDOR_MEDIATEK=y
> CONFIG_WLAN_VENDOR_MICROCHIP=y
> CONFIG_WLAN_VENDOR_RALINK=y
> CONFIG_WLAN_VENDOR_REALTEK=y
> CONFIG_WLAN_VENDOR_RSI=y
> CONFIG_WLAN_VENDOR_ST=y
> CONFIG_WLAN_VENDOR_TI=y
> CONFIG_WLAN_VENDOR_ZYDAS=y
> CONFIG_WLAN_VENDOR_QUANTENNA=y
> # CONFIG_PCMCIA_RAYCS is not set
> # CONFIG_WAN is not set
> 
> #
> # Wireless WAN
> #
> # CONFIG_WWAN is not set
> # end of Wireless WAN
> 
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> # CONFIG_USB4_NET is not set
> # CONFIG_NETDEVSIM is not set
> CONFIG_NET_FAILOVER=m
> # CONFIG_ISDN is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> CONFIG_INPUT_LEDS=y
> CONFIG_INPUT_FF_MEMLESS=y
> CONFIG_INPUT_SPARSEKMAP=y
> # CONFIG_INPUT_MATRIXKMAP is not set
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=y
> CONFIG_INPUT_EVDEV=y
> CONFIG_INPUT_EVBUG=y
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADC is not set
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1050 is not set
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MCS is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_IQS62X is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_CROS_EC is not set
> # CONFIG_KEYBOARD_MTK_PMIC is not set
> # CONFIG_KEYBOARD_CYPRESS_SF is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=m
> CONFIG_MOUSE_PS2_ALPS=y
> CONFIG_MOUSE_PS2_BYD=y
> CONFIG_MOUSE_PS2_LOGIPS2PP=y
> CONFIG_MOUSE_PS2_SYNAPTICS=y
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
> CONFIG_MOUSE_PS2_CYPRESS=y
> CONFIG_MOUSE_PS2_LIFEBOOK=y
> CONFIG_MOUSE_PS2_TRACKPOINT=y
> CONFIG_MOUSE_PS2_ELANTECH=y
> CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
> CONFIG_MOUSE_PS2_SENTELIC=y
> CONFIG_MOUSE_PS2_TOUCHKIT=y
> CONFIG_MOUSE_PS2_FOCALTECH=y
> # CONFIG_MOUSE_PS2_VMMOUSE is not set
> CONFIG_MOUSE_PS2_SMBUS=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_APPLETOUCH is not set
> # CONFIG_MOUSE_BCM5974 is not set
> # CONFIG_MOUSE_CYAPA is not set
> CONFIG_MOUSE_ELAN_I2C=m
> # CONFIG_MOUSE_ELAN_I2C_I2C is not set
> # CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> CONFIG_MOUSE_GPIO=y
> # CONFIG_MOUSE_SYNAPTICS_I2C is not set
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> # CONFIG_INPUT_JOYSTICK is not set
> CONFIG_INPUT_TABLET=y
> # CONFIG_TABLET_USB_ACECAD is not set
> # CONFIG_TABLET_USB_AIPTEK is not set
> # CONFIG_TABLET_USB_HANWANG is not set
> # CONFIG_TABLET_USB_KBTAB is not set
> # CONFIG_TABLET_USB_PEGASUS is not set
> CONFIG_TABLET_SERIAL_WACOM4=y
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_88PM860X_ONKEY=m
> CONFIG_INPUT_AD714X=m
> CONFIG_INPUT_AD714X_I2C=m
> CONFIG_INPUT_AD714X_SPI=m
> CONFIG_INPUT_BMA150=m
> # CONFIG_INPUT_E3X0_BUTTON is not set
> # CONFIG_INPUT_PCSPKR is not set
> CONFIG_INPUT_MC13783_PWRBUTTON=y
> CONFIG_INPUT_MMA8450=m
> CONFIG_INPUT_APANEL=y
> CONFIG_INPUT_GPIO_BEEPER=m
> CONFIG_INPUT_GPIO_DECODER=m
> CONFIG_INPUT_GPIO_VIBRA=y
> CONFIG_INPUT_WISTRON_BTNS=m
> # CONFIG_INPUT_ATLAS_BTNS is not set
> # CONFIG_INPUT_ATI_REMOTE2 is not set
> # CONFIG_INPUT_KEYSPAN_REMOTE is not set
> # CONFIG_INPUT_KXTJ9 is not set
> # CONFIG_INPUT_POWERMATE is not set
> # CONFIG_INPUT_YEALINK is not set
> # CONFIG_INPUT_CM109 is not set
> # CONFIG_INPUT_REGULATOR_HAPTIC is not set
> # CONFIG_INPUT_AXP20X_PEK is not set
> CONFIG_INPUT_UINPUT=y
> # CONFIG_INPUT_PCF50633_PMU is not set
> # CONFIG_INPUT_PCF8574 is not set
> CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
> CONFIG_INPUT_DA7280_HAPTICS=y
> CONFIG_INPUT_DA9052_ONKEY=m
> # CONFIG_INPUT_DA9063_ONKEY is not set
> CONFIG_INPUT_WM831X_ON=y
> # CONFIG_INPUT_ADXL34X is not set
> # CONFIG_INPUT_IQS269A is not set
> CONFIG_INPUT_IQS626A=y
> CONFIG_INPUT_CMA3000=m
> CONFIG_INPUT_CMA3000_I2C=m
> CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
> CONFIG_INPUT_DRV260X_HAPTICS=m
> CONFIG_INPUT_DRV2665_HAPTICS=y
> CONFIG_INPUT_DRV2667_HAPTICS=y
> CONFIG_INPUT_RAVE_SP_PWRBUTTON=m
> CONFIG_RMI4_CORE=y
> # CONFIG_RMI4_I2C is not set
> # CONFIG_RMI4_SPI is not set
> CONFIG_RMI4_SMB=y
> CONFIG_RMI4_F03=y
> CONFIG_RMI4_F03_SERIO=y
> CONFIG_RMI4_2D_SENSOR=y
> CONFIG_RMI4_F11=y
> CONFIG_RMI4_F12=y
> CONFIG_RMI4_F30=y
> CONFIG_RMI4_F34=y
> CONFIG_RMI4_F3A=y
> # CONFIG_RMI4_F55 is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> CONFIG_SERIO_PARKBD=m
> CONFIG_SERIO_PCIPS2=m
> CONFIG_SERIO_LIBPS2=y
> # CONFIG_SERIO_RAW is not set
> CONFIG_SERIO_ALTERA_PS2=m
> # CONFIG_SERIO_PS2MULT is not set
> CONFIG_SERIO_ARC_PS2=y
> CONFIG_SERIO_GPIO_PS2=y
> CONFIG_USERIO=y
> # CONFIG_GAMEPORT is not set
> # end of Hardware I/O ports
> # end of Input device support
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> # CONFIG_LDISC_AUTOLOAD is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> CONFIG_SERIAL_8250_PNP=y
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_DMA=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> CONFIG_SERIAL_8250_CS=m
> CONFIG_SERIAL_8250_MEN_MCB=m
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> # CONFIG_SERIAL_8250_MANY_PORTS is not set
> # CONFIG_SERIAL_8250_SHARE_IRQ is not set
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> # CONFIG_SERIAL_8250_RSA is not set
> CONFIG_SERIAL_8250_DWLIB=y
> CONFIG_SERIAL_8250_DW=m
> # CONFIG_SERIAL_8250_RT288X is not set
> # CONFIG_SERIAL_8250_LPSS is not set
> CONFIG_SERIAL_8250_MID=y
> # CONFIG_SERIAL_8250_PERICOM is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_MAX3100=m
> CONFIG_SERIAL_MAX310X=m
> CONFIG_SERIAL_UARTLITE=y
> CONFIG_SERIAL_UARTLITE_CONSOLE=y
> CONFIG_SERIAL_UARTLITE_NR_UARTS=1
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_JSM is not set
> CONFIG_SERIAL_LANTIQ=m
> CONFIG_SERIAL_SCCNXP=y
> CONFIG_SERIAL_SCCNXP_CONSOLE=y
> CONFIG_SERIAL_SC16IS7XX_CORE=m
> CONFIG_SERIAL_SC16IS7XX=m
> # CONFIG_SERIAL_SC16IS7XX_I2C is not set
> CONFIG_SERIAL_SC16IS7XX_SPI=y
> CONFIG_SERIAL_TIMBERDALE=y
> # CONFIG_SERIAL_BCM63XX is not set
> CONFIG_SERIAL_ALTERA_JTAGUART=y
> CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
> CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
> # CONFIG_SERIAL_ALTERA_UART is not set
> CONFIG_SERIAL_PCH_UART=m
> CONFIG_SERIAL_ARC=y
> CONFIG_SERIAL_ARC_CONSOLE=y
> CONFIG_SERIAL_ARC_NR_PORTS=1
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> CONFIG_SERIAL_MEN_Z135=y
> # CONFIG_SERIAL_SPRD is not set
> # end of Serial drivers
> 
> CONFIG_SERIAL_MCTRL_GPIO=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> CONFIG_GOLDFISH_TTY=y
> CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
> # CONFIG_N_GSM is not set
> CONFIG_NOZOMI=y
> # CONFIG_NULL_TTY is not set
> CONFIG_RPMSG_TTY=y
> CONFIG_SERIAL_DEV_BUS=y
> CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
> # CONFIG_PRINTER is not set
> CONFIG_PPDEV=m
> # CONFIG_VIRTIO_CONSOLE is not set
> CONFIG_IPMI_HANDLER=y
> CONFIG_IPMI_DMI_DECODE=y
> CONFIG_IPMI_PLAT_DATA=y
> # CONFIG_IPMI_PANIC_EVENT is not set
> CONFIG_IPMI_DEVICE_INTERFACE=y
> CONFIG_IPMI_SI=y
> CONFIG_IPMI_SSIF=y
> CONFIG_IPMI_IPMB=y
> # CONFIG_IPMI_WATCHDOG is not set
> CONFIG_IPMI_POWEROFF=m
> CONFIG_IPMB_DEVICE_INTERFACE=m
> # CONFIG_HW_RANDOM is not set
> # CONFIG_APPLICOM is not set
> CONFIG_SONYPI=y
> 
> #
> # PCMCIA character devices
> #
> CONFIG_SYNCLINK_CS=m
> # CONFIG_CARDMAN_4000 is not set
> CONFIG_CARDMAN_4040=m
> # CONFIG_SCR24X is not set
> # CONFIG_IPWIRELESS is not set
> # end of PCMCIA character devices
> 
> CONFIG_MWAVE=y
> # CONFIG_PC8736x_GPIO is not set
> # CONFIG_NSC_GPIO is not set
> CONFIG_DEVMEM=y
> CONFIG_NVRAM=y
> CONFIG_DEVPORT=y
> # CONFIG_HPET is not set
> CONFIG_HANGCHECK_TIMER=m
> CONFIG_TCG_TPM=y
> CONFIG_TCG_TIS_CORE=m
> # CONFIG_TCG_TIS is not set
> CONFIG_TCG_TIS_SPI=m
> # CONFIG_TCG_TIS_SPI_CR50 is not set
> CONFIG_TCG_TIS_I2C_CR50=m
> CONFIG_TCG_TIS_I2C_ATMEL=m
> CONFIG_TCG_TIS_I2C_INFINEON=y
> # CONFIG_TCG_TIS_I2C_NUVOTON is not set
> # CONFIG_TCG_NSC is not set
> CONFIG_TCG_ATMEL=y
> CONFIG_TCG_INFINEON=m
> # CONFIG_TCG_CRB is not set
> CONFIG_TCG_VTPM_PROXY=y
> CONFIG_TCG_TIS_ST33ZP24=m
> CONFIG_TCG_TIS_ST33ZP24_I2C=m
> # CONFIG_TCG_TIS_ST33ZP24_SPI is not set
> CONFIG_TELCLOCK=y
> # CONFIG_XILLYBUS is not set
> CONFIG_RANDOM_TRUST_CPU=y
> # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> # end of Character devices
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_ACPI_I2C_OPREGION=y
> CONFIG_I2C_BOARDINFO=y
> # CONFIG_I2C_COMPAT is not set
> CONFIG_I2C_CHARDEV=m
> CONFIG_I2C_MUX=m
> 
> #
> # Multiplexer I2C Chip support
> #
> # CONFIG_I2C_MUX_GPIO is not set
> # CONFIG_I2C_MUX_LTC4306 is not set
> CONFIG_I2C_MUX_PCA9541=m
> CONFIG_I2C_MUX_PCA954x=m
> # CONFIG_I2C_MUX_REG is not set
> CONFIG_I2C_MUX_MLXCPLD=m
> # end of Multiplexer I2C Chip support
> 
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_SMBUS=m
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCA=y
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> # CONFIG_I2C_ALI1535 is not set
> CONFIG_I2C_ALI1563=m
> CONFIG_I2C_ALI15X3=y
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_AMD_MP2 is not set
> # CONFIG_I2C_I801 is not set
> CONFIG_I2C_ISCH=m
> # CONFIG_I2C_ISMT is not set
> CONFIG_I2C_PIIX4=m
> CONFIG_I2C_NFORCE2=m
> CONFIG_I2C_NFORCE2_S4985=m
> # CONFIG_I2C_NVIDIA_GPU is not set
> # CONFIG_I2C_SIS5595 is not set
> CONFIG_I2C_SIS630=m
> # CONFIG_I2C_SIS96X is not set
> CONFIG_I2C_VIA=m
> CONFIG_I2C_VIAPRO=y
> 
> #
> # ACPI drivers
> #
> CONFIG_I2C_SCMI=m
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> CONFIG_I2C_CBUS_GPIO=y
> CONFIG_I2C_DESIGNWARE_CORE=y
> CONFIG_I2C_DESIGNWARE_SLAVE=y
> CONFIG_I2C_DESIGNWARE_PLATFORM=y
> CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> CONFIG_I2C_EG20T=m
> CONFIG_I2C_EMEV2=y
> # CONFIG_I2C_GPIO is not set
> # CONFIG_I2C_KEMPLD is not set
> # CONFIG_I2C_OCORES is not set
> CONFIG_I2C_PCA_PLATFORM=y
> # CONFIG_I2C_SIMTEC is not set
> CONFIG_I2C_XILINX=m
> 
> #
> # External I2C/SMBus adapter drivers
> #
> CONFIG_I2C_PARPORT=m
> CONFIG_I2C_TAOS_EVM=y
> 
> #
> # Other I2C/SMBus bus drivers
> #
> # CONFIG_I2C_CROS_EC_TUNNEL is not set
> # CONFIG_SCx200_ACB is not set
> # CONFIG_I2C_VIRTIO is not set
> # end of I2C Hardware Bus support
> 
> CONFIG_I2C_STUB=m
> CONFIG_I2C_SLAVE=y
> # CONFIG_I2C_SLAVE_EEPROM is not set
> CONFIG_I2C_SLAVE_TESTUNIT=y
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
> 
> CONFIG_I3C=y
> CONFIG_CDNS_I3C_MASTER=m
> CONFIG_DW_I3C_MASTER=y
> CONFIG_SVC_I3C_MASTER=y
> CONFIG_MIPI_I3C_HCI=m
> CONFIG_SPI=y
> CONFIG_SPI_DEBUG=y
> CONFIG_SPI_MASTER=y
> CONFIG_SPI_MEM=y
> 
> #
> # SPI Master Controller Drivers
> #
> CONFIG_SPI_ALTERA=m
> CONFIG_SPI_ALTERA_CORE=m
> CONFIG_SPI_ALTERA_DFL=m
> CONFIG_SPI_AXI_SPI_ENGINE=m
> CONFIG_SPI_BITBANG=y
> CONFIG_SPI_BUTTERFLY=m
> # CONFIG_SPI_CADENCE is not set
> # CONFIG_SPI_DESIGNWARE is not set
> CONFIG_SPI_NXP_FLEXSPI=y
> CONFIG_SPI_GPIO=y
> CONFIG_SPI_LM70_LLP=m
> CONFIG_SPI_LANTIQ_SSC=y
> # CONFIG_SPI_OC_TINY is not set
> # CONFIG_SPI_PXA2XX is not set
> CONFIG_SPI_ROCKCHIP=y
> # CONFIG_SPI_SC18IS602 is not set
> CONFIG_SPI_SIFIVE=y
> # CONFIG_SPI_MXIC is not set
> # CONFIG_SPI_TOPCLIFF_PCH is not set
> # CONFIG_SPI_XCOMM is not set
> # CONFIG_SPI_XILINX is not set
> # CONFIG_SPI_ZYNQMP_GQSPI is not set
> # CONFIG_SPI_AMD is not set
> 
> #
> # SPI Multiplexer support
> #
> CONFIG_SPI_MUX=m
> 
> #
> # SPI Protocol Masters
> #
> # CONFIG_SPI_SPIDEV is not set
> # CONFIG_SPI_LOOPBACK_TEST is not set
> # CONFIG_SPI_TLE62X0 is not set
> # CONFIG_SPI_SLAVE is not set
> CONFIG_SPI_DYNAMIC=y
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
> # CONFIG_NTP_PPS is not set
> 
> #
> # PPS clients support
> #
> CONFIG_PPS_CLIENT_KTIMER=m
> CONFIG_PPS_CLIENT_LDISC=y
> CONFIG_PPS_CLIENT_PARPORT=m
> CONFIG_PPS_CLIENT_GPIO=y
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=y
> CONFIG_PTP_1588_CLOCK_OPTIONAL=y
> 
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> # CONFIG_PTP_1588_CLOCK_PCH is not set
> CONFIG_PTP_1588_CLOCK_KVM=y
> # CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
> # CONFIG_PTP_1588_CLOCK_IDTCM is not set
> # CONFIG_PTP_1588_CLOCK_VMW is not set
> # CONFIG_PTP_1588_CLOCK_OCP is not set
> # end of PTP clock support
> 
> CONFIG_PINCTRL=y
> CONFIG_PINMUX=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> CONFIG_DEBUG_PINCTRL=y
> # CONFIG_PINCTRL_AMD is not set
> CONFIG_PINCTRL_DA9062=y
> # CONFIG_PINCTRL_MCP23S08 is not set
> # CONFIG_PINCTRL_SX150X is not set
> CONFIG_PINCTRL_MADERA=m
> CONFIG_PINCTRL_CS47L15=y
> CONFIG_PINCTRL_CS47L35=y
> CONFIG_PINCTRL_CS47L85=y
> CONFIG_PINCTRL_CS47L90=y
> CONFIG_PINCTRL_CS47L92=y
> 
> #
> # Intel pinctrl drivers
> #
> # CONFIG_PINCTRL_BAYTRAIL is not set
> CONFIG_PINCTRL_CHERRYVIEW=m
> CONFIG_PINCTRL_LYNXPOINT=m
> CONFIG_PINCTRL_INTEL=y
> CONFIG_PINCTRL_ALDERLAKE=m
> # CONFIG_PINCTRL_BROXTON is not set
> CONFIG_PINCTRL_CANNONLAKE=y
> CONFIG_PINCTRL_CEDARFORK=y
> # CONFIG_PINCTRL_DENVERTON is not set
> CONFIG_PINCTRL_ELKHARTLAKE=m
> # CONFIG_PINCTRL_EMMITSBURG is not set
> CONFIG_PINCTRL_GEMINILAKE=m
> # CONFIG_PINCTRL_ICELAKE is not set
> CONFIG_PINCTRL_JASPERLAKE=y
> # CONFIG_PINCTRL_LAKEFIELD is not set
> CONFIG_PINCTRL_LEWISBURG=m
> # CONFIG_PINCTRL_SUNRISEPOINT is not set
> CONFIG_PINCTRL_TIGERLAKE=m
> # end of Intel pinctrl drivers
> 
> #
> # Renesas pinctrl drivers
> #
> # end of Renesas pinctrl drivers
> 
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> CONFIG_DEBUG_GPIO=y
> CONFIG_GPIO_CDEV=y
> # CONFIG_GPIO_CDEV_V1 is not set
> CONFIG_GPIO_GENERIC=m
> CONFIG_GPIO_MAX730X=y
> 
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_AMDPT is not set
> CONFIG_GPIO_DWAPB=m
> CONFIG_GPIO_EXAR=m
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> # CONFIG_GPIO_ICH is not set
> CONFIG_GPIO_MB86S7X=y
> CONFIG_GPIO_MENZ127=m
> # CONFIG_GPIO_VX855 is not set
> CONFIG_GPIO_AMD_FCH=y
> # end of Memory mapped GPIO drivers
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> # CONFIG_GPIO_F7188X is not set
> # CONFIG_GPIO_IT87 is not set
> CONFIG_GPIO_SCH=m
> CONFIG_GPIO_SCH311X=y
> CONFIG_GPIO_WINBOND=y
> CONFIG_GPIO_WS16C48=m
> # end of Port-mapped I/O GPIO drivers
> 
> #
> # I2C GPIO expanders
> #
> CONFIG_GPIO_ADP5588=m
> CONFIG_GPIO_MAX7300=y
> CONFIG_GPIO_MAX732X=m
> CONFIG_GPIO_PCA953X=m
> # CONFIG_GPIO_PCA953X_IRQ is not set
> CONFIG_GPIO_PCA9570=y
> CONFIG_GPIO_PCF857X=y
> CONFIG_GPIO_TPIC2810=y
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> CONFIG_GPIO_ARIZONA=y
> CONFIG_GPIO_CRYSTAL_COVE=m
> # CONFIG_GPIO_CS5535 is not set
> # CONFIG_GPIO_DA9052 is not set
> CONFIG_GPIO_JANZ_TTL=y
> CONFIG_GPIO_KEMPLD=m
> # CONFIG_GPIO_MADERA is not set
> CONFIG_GPIO_TIMBERDALE=y
> CONFIG_GPIO_TPS6586X=y
> CONFIG_GPIO_TPS65912=y
> # CONFIG_GPIO_TQMX86 is not set
> CONFIG_GPIO_WM831X=y
> # CONFIG_GPIO_WM8994 is not set
> # end of MFD GPIO expanders
> 
> #
> # PCI GPIO expanders
> #
> CONFIG_GPIO_AMD8111=m
> CONFIG_GPIO_BT8XX=m
> # CONFIG_GPIO_ML_IOH is not set
> CONFIG_GPIO_PCH=y
> CONFIG_GPIO_PCI_IDIO_16=m
> CONFIG_GPIO_PCIE_IDIO_24=y
> CONFIG_GPIO_RDC321X=m
> # end of PCI GPIO expanders
> 
> #
> # SPI GPIO expanders
> #
> CONFIG_GPIO_MAX3191X=y
> # CONFIG_GPIO_MAX7301 is not set
> CONFIG_GPIO_MC33880=y
> CONFIG_GPIO_PISOSR=y
> CONFIG_GPIO_XRA1403=m
> # end of SPI GPIO expanders
> 
> #
> # Virtual GPIO drivers
> #
> # CONFIG_GPIO_AGGREGATOR is not set
> CONFIG_GPIO_MOCKUP=m
> CONFIG_GPIO_VIRTIO=y
> CONFIG_GPIO_SIM=m
> # end of Virtual GPIO drivers
> 
> CONFIG_W1=y
> 
> #
> # 1-wire Bus Masters
> #
> CONFIG_W1_MASTER_MATROX=y
> # CONFIG_W1_MASTER_DS2482 is not set
> # CONFIG_W1_MASTER_DS1WM is not set
> CONFIG_W1_MASTER_GPIO=y
> # CONFIG_W1_MASTER_SGI is not set
> # end of 1-wire Bus Masters
> 
> #
> # 1-wire Slaves
> #
> # CONFIG_W1_SLAVE_THERM is not set
> CONFIG_W1_SLAVE_SMEM=y
> # CONFIG_W1_SLAVE_DS2405 is not set
> CONFIG_W1_SLAVE_DS2408=y
> # CONFIG_W1_SLAVE_DS2408_READBACK is not set
> CONFIG_W1_SLAVE_DS2413=m
> # CONFIG_W1_SLAVE_DS2406 is not set
> CONFIG_W1_SLAVE_DS2423=m
> CONFIG_W1_SLAVE_DS2805=y
> # CONFIG_W1_SLAVE_DS2430 is not set
> CONFIG_W1_SLAVE_DS2431=m
> CONFIG_W1_SLAVE_DS2433=y
> CONFIG_W1_SLAVE_DS2433_CRC=y
> # CONFIG_W1_SLAVE_DS2438 is not set
> CONFIG_W1_SLAVE_DS250X=y
> CONFIG_W1_SLAVE_DS2780=m
> CONFIG_W1_SLAVE_DS2781=m
> # CONFIG_W1_SLAVE_DS28E04 is not set
> CONFIG_W1_SLAVE_DS28E17=m
> # end of 1-wire Slaves
> 
> CONFIG_POWER_RESET=y
> # CONFIG_POWER_RESET_MT6323 is not set
> CONFIG_POWER_RESET_RESTART=y
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> # CONFIG_POWER_SUPPLY_HWMON is not set
> CONFIG_PDA_POWER=y
> # CONFIG_GENERIC_ADC_BATTERY is not set
> CONFIG_WM831X_BACKUP=y
> CONFIG_WM831X_POWER=y
> # CONFIG_TEST_POWER is not set
> # CONFIG_BATTERY_88PM860X is not set
> CONFIG_CHARGER_ADP5061=y
> CONFIG_BATTERY_CW2015=y
> CONFIG_BATTERY_DS2760=m
> # CONFIG_BATTERY_DS2780 is not set
> CONFIG_BATTERY_DS2781=m
> CONFIG_BATTERY_DS2782=m
> CONFIG_BATTERY_SBS=m
> CONFIG_CHARGER_SBS=y
> CONFIG_MANAGER_SBS=m
> CONFIG_BATTERY_BQ27XXX=m
> # CONFIG_BATTERY_BQ27XXX_I2C is not set
> CONFIG_BATTERY_BQ27XXX_HDQ=m
> CONFIG_BATTERY_DA9052=m
> # CONFIG_BATTERY_DA9150 is not set
> # CONFIG_CHARGER_AXP20X is not set
> CONFIG_BATTERY_AXP20X=m
> # CONFIG_AXP20X_POWER is not set
> CONFIG_AXP288_FUEL_GAUGE=m
> CONFIG_BATTERY_MAX17040=y
> CONFIG_BATTERY_MAX17042=m
> CONFIG_BATTERY_MAX1721X=y
> CONFIG_CHARGER_PCF50633=m
> CONFIG_CHARGER_MAX8903=m
> CONFIG_CHARGER_LP8727=y
> CONFIG_CHARGER_GPIO=m
> CONFIG_CHARGER_MANAGER=y
> CONFIG_CHARGER_LT3651=y
> CONFIG_CHARGER_LTC4162L=y
> CONFIG_CHARGER_MAX14577=m
> CONFIG_CHARGER_MAX77693=m
> # CONFIG_CHARGER_MAX77976 is not set
> CONFIG_CHARGER_MAX8998=y
> CONFIG_CHARGER_MP2629=m
> # CONFIG_CHARGER_BQ2415X is not set
> CONFIG_CHARGER_BQ24190=y
> CONFIG_CHARGER_BQ24257=m
> # CONFIG_CHARGER_BQ24735 is not set
> CONFIG_CHARGER_BQ2515X=m
> # CONFIG_CHARGER_BQ25890 is not set
> # CONFIG_CHARGER_BQ25980 is not set
> CONFIG_CHARGER_BQ256XX=y
> CONFIG_CHARGER_SMB347=y
> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> # CONFIG_BATTERY_GOLDFISH is not set
> # CONFIG_BATTERY_RT5033 is not set
> CONFIG_CHARGER_RT9455=m
> CONFIG_CHARGER_BD99954=m
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=y
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> CONFIG_SENSORS_ABITUGURU=m
> CONFIG_SENSORS_ABITUGURU3=y
> CONFIG_SENSORS_AD7314=m
> CONFIG_SENSORS_AD7414=m
> CONFIG_SENSORS_AD7418=m
> CONFIG_SENSORS_ADM1021=y
> # CONFIG_SENSORS_ADM1025 is not set
> CONFIG_SENSORS_ADM1026=m
> CONFIG_SENSORS_ADM1029=m
> CONFIG_SENSORS_ADM1031=y
> CONFIG_SENSORS_ADM1177=m
> CONFIG_SENSORS_ADM9240=m
> # CONFIG_SENSORS_ADT7310 is not set
> # CONFIG_SENSORS_ADT7410 is not set
> # CONFIG_SENSORS_ADT7411 is not set
> CONFIG_SENSORS_ADT7462=m
> CONFIG_SENSORS_ADT7470=m
> # CONFIG_SENSORS_ADT7475 is not set
> # CONFIG_SENSORS_AHT10 is not set
> # CONFIG_SENSORS_AS370 is not set
> # CONFIG_SENSORS_ASC7621 is not set
> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> CONFIG_SENSORS_K8TEMP=m
> CONFIG_SENSORS_K10TEMP=y
> # CONFIG_SENSORS_FAM15H_POWER is not set
> CONFIG_SENSORS_APPLESMC=y
> # CONFIG_SENSORS_ASB100 is not set
> CONFIG_SENSORS_ASPEED=y
> CONFIG_SENSORS_ATXP1=y
> CONFIG_SENSORS_CORSAIR_CPRO=y
> CONFIG_SENSORS_CORSAIR_PSU=y
> # CONFIG_SENSORS_DS620 is not set
> CONFIG_SENSORS_DS1621=y
> CONFIG_SENSORS_DELL_SMM=m
> CONFIG_SENSORS_DA9052_ADC=m
> CONFIG_SENSORS_I5K_AMB=y
> # CONFIG_SENSORS_F71805F is not set
> CONFIG_SENSORS_F71882FG=y
> CONFIG_SENSORS_F75375S=y
> # CONFIG_SENSORS_MC13783_ADC is not set
> CONFIG_SENSORS_FSCHMD=y
> CONFIG_SENSORS_FTSTEUTATES=y
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_GL520SM is not set
> CONFIG_SENSORS_G760A=m
> CONFIG_SENSORS_G762=m
> CONFIG_SENSORS_HIH6130=m
> CONFIG_SENSORS_IBMAEM=m
> CONFIG_SENSORS_IBMPEX=y
> CONFIG_SENSORS_IIO_HWMON=m
> # CONFIG_SENSORS_I5500 is not set
> CONFIG_SENSORS_CORETEMP=m
> CONFIG_SENSORS_IT87=y
> CONFIG_SENSORS_JC42=y
> CONFIG_SENSORS_POWR1220=y
> # CONFIG_SENSORS_LINEAGE is not set
> CONFIG_SENSORS_LTC2945=y
> CONFIG_SENSORS_LTC2947=y
> CONFIG_SENSORS_LTC2947_I2C=y
> # CONFIG_SENSORS_LTC2947_SPI is not set
> CONFIG_SENSORS_LTC2990=m
> CONFIG_SENSORS_LTC2992=y
> CONFIG_SENSORS_LTC4151=m
> CONFIG_SENSORS_LTC4215=m
> CONFIG_SENSORS_LTC4222=y
> CONFIG_SENSORS_LTC4245=m
> CONFIG_SENSORS_LTC4260=y
> CONFIG_SENSORS_LTC4261=y
> CONFIG_SENSORS_MAX1111=m
> CONFIG_SENSORS_MAX127=m
> # CONFIG_SENSORS_MAX16065 is not set
> # CONFIG_SENSORS_MAX1619 is not set
> CONFIG_SENSORS_MAX1668=m
> CONFIG_SENSORS_MAX197=y
> # CONFIG_SENSORS_MAX31722 is not set
> CONFIG_SENSORS_MAX31730=m
> # CONFIG_SENSORS_MAX6620 is not set
> CONFIG_SENSORS_MAX6621=y
> CONFIG_SENSORS_MAX6639=y
> CONFIG_SENSORS_MAX6642=y
> CONFIG_SENSORS_MAX6650=y
> # CONFIG_SENSORS_MAX6697 is not set
> CONFIG_SENSORS_MAX31790=y
> CONFIG_SENSORS_MCP3021=m
> CONFIG_SENSORS_MLXREG_FAN=m
> # CONFIG_SENSORS_TC654 is not set
> # CONFIG_SENSORS_TPS23861 is not set
> CONFIG_SENSORS_MENF21BMC_HWMON=y
> CONFIG_SENSORS_MR75203=m
> CONFIG_SENSORS_ADCXX=y
> CONFIG_SENSORS_LM63=m
> # CONFIG_SENSORS_LM70 is not set
> # CONFIG_SENSORS_LM73 is not set
> CONFIG_SENSORS_LM75=m
> CONFIG_SENSORS_LM77=m
> CONFIG_SENSORS_LM78=m
> CONFIG_SENSORS_LM80=m
> CONFIG_SENSORS_LM83=y
> CONFIG_SENSORS_LM85=y
> # CONFIG_SENSORS_LM87 is not set
> CONFIG_SENSORS_LM90=m
> CONFIG_SENSORS_LM92=m
> CONFIG_SENSORS_LM93=m
> CONFIG_SENSORS_LM95234=y
> # CONFIG_SENSORS_LM95241 is not set
> CONFIG_SENSORS_LM95245=m
> # CONFIG_SENSORS_PC87360 is not set
> CONFIG_SENSORS_PC87427=y
> CONFIG_SENSORS_NTC_THERMISTOR=m
> # CONFIG_SENSORS_NCT6683 is not set
> CONFIG_SENSORS_NCT6775=m
> CONFIG_SENSORS_NCT7802=y
> CONFIG_SENSORS_NCT7904=y
> CONFIG_SENSORS_NPCM7XX=m
> CONFIG_SENSORS_PCF8591=m
> CONFIG_PMBUS=m
> # CONFIG_SENSORS_PMBUS is not set
> CONFIG_SENSORS_ADM1266=m
> CONFIG_SENSORS_ADM1275=m
> CONFIG_SENSORS_BEL_PFE=m
> # CONFIG_SENSORS_BPA_RS600 is not set
> CONFIG_SENSORS_DELTA_AHE50DC_FAN=m
> CONFIG_SENSORS_FSP_3Y=m
> CONFIG_SENSORS_IBM_CFFPS=m
> CONFIG_SENSORS_DPS920AB=m
> CONFIG_SENSORS_INSPUR_IPSPS=m
> CONFIG_SENSORS_IR35221=m
> CONFIG_SENSORS_IR36021=m
> CONFIG_SENSORS_IR38064=m
> CONFIG_SENSORS_IR38064_REGULATOR=y
> CONFIG_SENSORS_IRPS5401=m
> CONFIG_SENSORS_ISL68137=m
> # CONFIG_SENSORS_LM25066 is not set
> # CONFIG_SENSORS_LTC2978 is not set
> # CONFIG_SENSORS_LTC3815 is not set
> CONFIG_SENSORS_MAX15301=m
> CONFIG_SENSORS_MAX16064=m
> # CONFIG_SENSORS_MAX16601 is not set
> CONFIG_SENSORS_MAX20730=m
> CONFIG_SENSORS_MAX20751=m
> CONFIG_SENSORS_MAX31785=m
> CONFIG_SENSORS_MAX34440=m
> # CONFIG_SENSORS_MAX8688 is not set
> CONFIG_SENSORS_MP2888=m
> CONFIG_SENSORS_MP2975=m
> # CONFIG_SENSORS_MP5023 is not set
> CONFIG_SENSORS_PIM4328=m
> # CONFIG_SENSORS_PM6764TR is not set
> # CONFIG_SENSORS_PXE1610 is not set
> CONFIG_SENSORS_Q54SJ108A2=m
> CONFIG_SENSORS_STPDDC60=m
> CONFIG_SENSORS_TPS40422=m
> # CONFIG_SENSORS_TPS53679 is not set
> CONFIG_SENSORS_UCD9000=m
> CONFIG_SENSORS_UCD9200=m
> # CONFIG_SENSORS_XDPE122 is not set
> CONFIG_SENSORS_ZL6100=m
> CONFIG_SENSORS_SBTSI=y
> # CONFIG_SENSORS_SBRMI is not set
> # CONFIG_SENSORS_SHT15 is not set
> CONFIG_SENSORS_SHT21=m
> CONFIG_SENSORS_SHT3x=m
> CONFIG_SENSORS_SHT4x=y
> CONFIG_SENSORS_SHTC1=m
> CONFIG_SENSORS_SIS5595=m
> CONFIG_SENSORS_DME1737=m
> # CONFIG_SENSORS_EMC1403 is not set
> CONFIG_SENSORS_EMC2103=m
> CONFIG_SENSORS_EMC6W201=y
> # CONFIG_SENSORS_SMSC47M1 is not set
> # CONFIG_SENSORS_SMSC47M192 is not set
> CONFIG_SENSORS_SMSC47B397=m
> CONFIG_SENSORS_SCH56XX_COMMON=m
> CONFIG_SENSORS_SCH5627=m
> # CONFIG_SENSORS_SCH5636 is not set
> # CONFIG_SENSORS_STTS751 is not set
> CONFIG_SENSORS_SMM665=y
> CONFIG_SENSORS_ADC128D818=y
> CONFIG_SENSORS_ADS7828=y
> CONFIG_SENSORS_ADS7871=y
> CONFIG_SENSORS_AMC6821=y
> # CONFIG_SENSORS_INA209 is not set
> CONFIG_SENSORS_INA2XX=m
> CONFIG_SENSORS_INA238=y
> # CONFIG_SENSORS_INA3221 is not set
> # CONFIG_SENSORS_TC74 is not set
> CONFIG_SENSORS_THMC50=m
> CONFIG_SENSORS_TMP102=y
> CONFIG_SENSORS_TMP103=y
> # CONFIG_SENSORS_TMP108 is not set
> # CONFIG_SENSORS_TMP401 is not set
> CONFIG_SENSORS_TMP421=y
> # CONFIG_SENSORS_TMP513 is not set
> CONFIG_SENSORS_VIA_CPUTEMP=m
> CONFIG_SENSORS_VIA686A=m
> CONFIG_SENSORS_VT1211=y
> CONFIG_SENSORS_VT8231=m
> # CONFIG_SENSORS_W83773G is not set
> # CONFIG_SENSORS_W83781D is not set
> CONFIG_SENSORS_W83791D=y
> CONFIG_SENSORS_W83792D=y
> CONFIG_SENSORS_W83793=y
> CONFIG_SENSORS_W83795=m
> CONFIG_SENSORS_W83795_FANCTRL=y
> CONFIG_SENSORS_W83L785TS=m
> CONFIG_SENSORS_W83L786NG=y
> CONFIG_SENSORS_W83627HF=m
> CONFIG_SENSORS_W83627EHF=m
> CONFIG_SENSORS_WM831X=y
> # CONFIG_SENSORS_XGENE is not set
> 
> #
> # ACPI drivers
> #
> CONFIG_SENSORS_ACPI_POWER=m
> CONFIG_SENSORS_ATK0110=m
> CONFIG_THERMAL=y
> # CONFIG_THERMAL_NETLINK is not set
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> # CONFIG_THERMAL_HWMON is not set
> CONFIG_THERMAL_WRITABLE_TRIPS=y
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
> CONFIG_THERMAL_GOV_STEP_WISE=y
> # CONFIG_THERMAL_GOV_BANG_BANG is not set
> # CONFIG_THERMAL_GOV_USER_SPACE is not set
> CONFIG_DEVFREQ_THERMAL=y
> # CONFIG_THERMAL_EMULATION is not set
> 
> #
> # Intel thermal drivers
> #
> CONFIG_INTEL_POWERCLAMP=m
> CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
> CONFIG_INTEL_SOC_DTS_THERMAL=y
> 
> #
> # ACPI INT340X thermal drivers
> #
> # end of ACPI INT340X thermal drivers
> 
> CONFIG_INTEL_PCH_THERMAL=y
> # CONFIG_INTEL_TCC_COOLING is not set
> CONFIG_INTEL_MENLOW=m
> # end of Intel thermal drivers
> 
> CONFIG_GENERIC_ADC_THERMAL=m
> CONFIG_WATCHDOG=y
> CONFIG_WATCHDOG_CORE=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> # CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
> CONFIG_WATCHDOG_OPEN_TIMEOUT=0
> # CONFIG_WATCHDOG_SYSFS is not set
> CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y
> 
> #
> # Watchdog Pretimeout Governors
> #
> CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
> # CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP is not set
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=m
> CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y
> 
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=m
> # CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
> CONFIG_DA9052_WATCHDOG=m
> # CONFIG_DA9062_WATCHDOG is not set
> # CONFIG_MENF21BMC_WATCHDOG is not set
> CONFIG_MENZ069_WATCHDOG=m
> CONFIG_WDAT_WDT=m
> # CONFIG_WM831X_WATCHDOG is not set
> CONFIG_XILINX_WATCHDOG=m
> # CONFIG_ZIIRAVE_WATCHDOG is not set
> # CONFIG_RAVE_SP_WATCHDOG is not set
> CONFIG_MLX_WDT=m
> # CONFIG_CADENCE_WATCHDOG is not set
> CONFIG_DW_WATCHDOG=m
> CONFIG_MAX63XX_WATCHDOG=m
> CONFIG_ACQUIRE_WDT=m
> # CONFIG_ADVANTECH_WDT is not set
> CONFIG_ALIM1535_WDT=m
> CONFIG_ALIM7101_WDT=y
> CONFIG_EBC_C384_WDT=y
> # CONFIG_F71808E_WDT is not set
> CONFIG_SP5100_TCO=y
> CONFIG_GEODE_WDT=m
> # CONFIG_SBC_FITPC2_WATCHDOG is not set
> # CONFIG_EUROTECH_WDT is not set
> CONFIG_IB700_WDT=y
> CONFIG_IBMASR=m
> CONFIG_WAFER_WDT=y
> CONFIG_I6300ESB_WDT=y
> CONFIG_IE6XX_WDT=y
> # CONFIG_ITCO_WDT is not set
> CONFIG_IT8712F_WDT=y
> CONFIG_IT87_WDT=m
> CONFIG_HP_WATCHDOG=y
> CONFIG_HPWDT_NMI_DECODING=y
> CONFIG_KEMPLD_WDT=m
> CONFIG_SC1200_WDT=m
> # CONFIG_PC87413_WDT is not set
> CONFIG_NV_TCO=m
> # CONFIG_60XX_WDT is not set
> # CONFIG_SBC8360_WDT is not set
> CONFIG_SBC7240_WDT=m
> # CONFIG_CPU5_WDT is not set
> CONFIG_SMSC_SCH311X_WDT=y
> CONFIG_SMSC37B787_WDT=m
> CONFIG_TQMX86_WDT=y
> # CONFIG_VIA_WDT is not set
> CONFIG_W83627HF_WDT=m
> CONFIG_W83877F_WDT=m
> CONFIG_W83977F_WDT=m
> CONFIG_MACHZ_WDT=m
> CONFIG_SBC_EPX_C3_WATCHDOG=y
> CONFIG_INTEL_MEI_WDT=y
> CONFIG_NI903X_WDT=y
> CONFIG_NIC7018_WDT=m
> # CONFIG_SIEMENS_SIMATIC_IPC_WDT is not set
> # CONFIG_MEN_A21_WDT is not set
> 
> #
> # PCI-based Watchdog Cards
> #
> # CONFIG_PCIPCWATCHDOG is not set
> CONFIG_WDTPCI=y
> CONFIG_SSB_POSSIBLE=y
> CONFIG_SSB=y
> CONFIG_SSB_PCIHOST_POSSIBLE=y
> # CONFIG_SSB_PCIHOST is not set
> CONFIG_SSB_DRIVER_GPIO=y
> CONFIG_BCMA_POSSIBLE=y
> CONFIG_BCMA=m
> CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> # CONFIG_BCMA_HOST_PCI is not set
> # CONFIG_BCMA_HOST_SOC is not set
> # CONFIG_BCMA_DRIVER_PCI is not set
> # CONFIG_BCMA_DRIVER_GMAC_CMN is not set
> CONFIG_BCMA_DRIVER_GPIO=y
> CONFIG_BCMA_DEBUG=y
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> CONFIG_MFD_CS5535=m
> CONFIG_MFD_AS3711=y
> # CONFIG_PMIC_ADP5520 is not set
> CONFIG_MFD_AAT2870_CORE=y
> # CONFIG_MFD_BCM590XX is not set
> # CONFIG_MFD_BD9571MWV is not set
> CONFIG_MFD_AXP20X=m
> CONFIG_MFD_AXP20X_I2C=m
> # CONFIG_MFD_CROS_EC_DEV is not set
> CONFIG_MFD_MADERA=m
> # CONFIG_MFD_MADERA_I2C is not set
> CONFIG_MFD_MADERA_SPI=m
> CONFIG_MFD_CS47L15=y
> CONFIG_MFD_CS47L35=y
> CONFIG_MFD_CS47L85=y
> CONFIG_MFD_CS47L90=y
> CONFIG_MFD_CS47L92=y
> # CONFIG_PMIC_DA903X is not set
> CONFIG_PMIC_DA9052=y
> CONFIG_MFD_DA9052_SPI=y
> CONFIG_MFD_DA9052_I2C=y
> # CONFIG_MFD_DA9055 is not set
> CONFIG_MFD_DA9062=y
> # CONFIG_MFD_DA9063 is not set
> CONFIG_MFD_DA9150=m
> CONFIG_MFD_MC13XXX=y
> CONFIG_MFD_MC13XXX_SPI=y
> # CONFIG_MFD_MC13XXX_I2C is not set
> CONFIG_MFD_MP2629=y
> CONFIG_HTC_PASIC3=y
> CONFIG_HTC_I2CPLD=y
> CONFIG_MFD_INTEL_QUARK_I2C_GPIO=m
> CONFIG_LPC_ICH=m
> CONFIG_LPC_SCH=y
> CONFIG_INTEL_SOC_PMIC=y
> # CONFIG_INTEL_SOC_PMIC_BXTWC is not set
> # CONFIG_INTEL_SOC_PMIC_CHTWC is not set
> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> CONFIG_MFD_INTEL_LPSS=y
> CONFIG_MFD_INTEL_LPSS_ACPI=y
> # CONFIG_MFD_INTEL_LPSS_PCI is not set
> CONFIG_MFD_INTEL_PMC_BXT=y
> CONFIG_MFD_IQS62X=m
> CONFIG_MFD_JANZ_CMODIO=y
> CONFIG_MFD_KEMPLD=m
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> CONFIG_MFD_88PM860X=y
> CONFIG_MFD_MAX14577=m
> CONFIG_MFD_MAX77693=y
> # CONFIG_MFD_MAX77843 is not set
> # CONFIG_MFD_MAX8907 is not set
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> CONFIG_MFD_MAX8998=y
> # CONFIG_MFD_MT6360 is not set
> CONFIG_MFD_MT6397=m
> CONFIG_MFD_MENF21BMC=y
> # CONFIG_EZX_PCAP is not set
> # CONFIG_MFD_RETU is not set
> CONFIG_MFD_PCF50633=y
> CONFIG_PCF50633_ADC=y
> # CONFIG_PCF50633_GPIO is not set
> CONFIG_MFD_RDC321X=y
> CONFIG_MFD_RT4831=y
> # CONFIG_MFD_RT5033 is not set
> # CONFIG_MFD_RC5T583 is not set
> CONFIG_MFD_SI476X_CORE=y
> # CONFIG_MFD_SM501 is not set
> CONFIG_MFD_SKY81452=m
> CONFIG_MFD_SYSCON=y
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_LP3943 is not set
> CONFIG_MFD_LP8788=y
> # CONFIG_MFD_TI_LMU is not set
> # CONFIG_MFD_PALMAS is not set
> CONFIG_TPS6105X=m
> # CONFIG_TPS65010 is not set
> CONFIG_TPS6507X=m
> # CONFIG_MFD_TPS65086 is not set
> # CONFIG_MFD_TPS65090 is not set
> # CONFIG_MFD_TI_LP873X is not set
> CONFIG_MFD_TPS6586X=y
> # CONFIG_MFD_TPS65910 is not set
> CONFIG_MFD_TPS65912=y
> CONFIG_MFD_TPS65912_I2C=y
> CONFIG_MFD_TPS65912_SPI=m
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_TWL6040_CORE is not set
> CONFIG_MFD_WL1273_CORE=m
> # CONFIG_MFD_LM3533 is not set
> CONFIG_MFD_TIMBERDALE=y
> CONFIG_MFD_TQMX86=m
> CONFIG_MFD_VX855=m
> CONFIG_MFD_ARIZONA=y
> CONFIG_MFD_ARIZONA_I2C=y
> CONFIG_MFD_ARIZONA_SPI=y
> # CONFIG_MFD_CS47L24 is not set
> # CONFIG_MFD_WM5102 is not set
> CONFIG_MFD_WM5110=y
> CONFIG_MFD_WM8997=y
> CONFIG_MFD_WM8998=y
> CONFIG_MFD_WM8400=y
> CONFIG_MFD_WM831X=y
> CONFIG_MFD_WM831X_I2C=y
> # CONFIG_MFD_WM831X_SPI is not set
> # CONFIG_MFD_WM8350_I2C is not set
> CONFIG_MFD_WM8994=y
> CONFIG_MFD_WCD934X=m
> # CONFIG_MFD_ATC260X_I2C is not set
> CONFIG_RAVE_SP_CORE=y
> # CONFIG_MFD_INTEL_M10_BMC is not set
> # end of Multifunction device drivers
> 
> CONFIG_REGULATOR=y
> # CONFIG_REGULATOR_DEBUG is not set
> CONFIG_REGULATOR_FIXED_VOLTAGE=m
> CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
> CONFIG_REGULATOR_USERSPACE_CONSUMER=m
> CONFIG_REGULATOR_88PG86X=y
> CONFIG_REGULATOR_88PM8607=m
> # CONFIG_REGULATOR_ACT8865 is not set
> CONFIG_REGULATOR_AD5398=m
> CONFIG_REGULATOR_AAT2870=y
> CONFIG_REGULATOR_AS3711=y
> CONFIG_REGULATOR_AXP20X=m
> # CONFIG_REGULATOR_DA9052 is not set
> # CONFIG_REGULATOR_DA9062 is not set
> # CONFIG_REGULATOR_DA9210 is not set
> # CONFIG_REGULATOR_DA9211 is not set
> CONFIG_REGULATOR_FAN53555=y
> CONFIG_REGULATOR_GPIO=m
> CONFIG_REGULATOR_ISL9305=y
> # CONFIG_REGULATOR_ISL6271A is not set
> CONFIG_REGULATOR_LP3971=m
> CONFIG_REGULATOR_LP3972=y
> CONFIG_REGULATOR_LP872X=y
> CONFIG_REGULATOR_LP8755=m
> # CONFIG_REGULATOR_LP8788 is not set
> CONFIG_REGULATOR_LTC3589=y
> # CONFIG_REGULATOR_LTC3676 is not set
> CONFIG_REGULATOR_MAX14577=m
> CONFIG_REGULATOR_MAX1586=m
> # CONFIG_REGULATOR_MAX8649 is not set
> CONFIG_REGULATOR_MAX8660=y
> CONFIG_REGULATOR_MAX8893=m
> CONFIG_REGULATOR_MAX8952=y
> CONFIG_REGULATOR_MAX8998=y
> # CONFIG_REGULATOR_MAX20086 is not set
> CONFIG_REGULATOR_MAX77693=m
> # CONFIG_REGULATOR_MAX77826 is not set
> CONFIG_REGULATOR_MC13XXX_CORE=y
> CONFIG_REGULATOR_MC13783=y
> # CONFIG_REGULATOR_MC13892 is not set
> # CONFIG_REGULATOR_MP8859 is not set
> # CONFIG_REGULATOR_MT6311 is not set
> CONFIG_REGULATOR_MT6323=m
> # CONFIG_REGULATOR_MT6358 is not set
> CONFIG_REGULATOR_MT6359=m
> CONFIG_REGULATOR_MT6397=m
> CONFIG_REGULATOR_PCA9450=m
> CONFIG_REGULATOR_PCF50633=m
> CONFIG_REGULATOR_PV88060=m
> CONFIG_REGULATOR_PV88080=y
> CONFIG_REGULATOR_PV88090=m
> CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
> # CONFIG_REGULATOR_RT4801 is not set
> CONFIG_REGULATOR_RT4831=y
> CONFIG_REGULATOR_RT6160=m
> CONFIG_REGULATOR_RT6245=y
> # CONFIG_REGULATOR_RTQ2134 is not set
> CONFIG_REGULATOR_RTMV20=y
> CONFIG_REGULATOR_RTQ6752=y
> # CONFIG_REGULATOR_SKY81452 is not set
> CONFIG_REGULATOR_SLG51000=m
> CONFIG_REGULATOR_TPS51632=m
> # CONFIG_REGULATOR_TPS6105X is not set
> # CONFIG_REGULATOR_TPS62360 is not set
> # CONFIG_REGULATOR_TPS65023 is not set
> CONFIG_REGULATOR_TPS6507X=y
> # CONFIG_REGULATOR_TPS65132 is not set
> CONFIG_REGULATOR_TPS6524X=m
> CONFIG_REGULATOR_TPS6586X=m
> CONFIG_REGULATOR_TPS65912=y
> # CONFIG_REGULATOR_WM831X is not set
> # CONFIG_REGULATOR_WM8400 is not set
> CONFIG_REGULATOR_WM8994=y
> CONFIG_RC_CORE=y
> CONFIG_RC_MAP=m
> CONFIG_LIRC=y
> CONFIG_RC_DECODERS=y
> CONFIG_IR_NEC_DECODER=m
> # CONFIG_IR_RC5_DECODER is not set
> # CONFIG_IR_RC6_DECODER is not set
> # CONFIG_IR_JVC_DECODER is not set
> # CONFIG_IR_SONY_DECODER is not set
> CONFIG_IR_SANYO_DECODER=y
> CONFIG_IR_SHARP_DECODER=y
> CONFIG_IR_MCE_KBD_DECODER=y
> CONFIG_IR_XMP_DECODER=y
> CONFIG_IR_IMON_DECODER=y
> # CONFIG_IR_RCMM_DECODER is not set
> # CONFIG_RC_DEVICES is not set
> 
> #
> # CEC support
> #
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> # end of CEC support
> 
> CONFIG_MEDIA_SUPPORT=m
> # CONFIG_MEDIA_SUPPORT_FILTER is not set
> CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
> 
> #
> # Media device types
> #
> CONFIG_MEDIA_CAMERA_SUPPORT=y
> CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
> CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> CONFIG_MEDIA_RADIO_SUPPORT=y
> CONFIG_MEDIA_SDR_SUPPORT=y
> CONFIG_MEDIA_PLATFORM_SUPPORT=y
> CONFIG_MEDIA_TEST_SUPPORT=y
> # end of Media device types
> 
> #
> # Media core support
> #
> CONFIG_VIDEO_DEV=m
> CONFIG_MEDIA_CONTROLLER=y
> CONFIG_DVB_CORE=m
> # end of Media core support
> 
> #
> # Video4Linux options
> #
> CONFIG_VIDEO_V4L2=m
> CONFIG_VIDEO_V4L2_I2C=y
> CONFIG_VIDEO_V4L2_SUBDEV_API=y
> # CONFIG_VIDEO_ADV_DEBUG is not set
> # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> CONFIG_VIDEO_TUNER=m
> CONFIG_V4L2_MEM2MEM_DEV=m
> CONFIG_V4L2_FWNODE=m
> CONFIG_V4L2_ASYNC=m
> CONFIG_VIDEOBUF_GEN=m
> CONFIG_VIDEOBUF_DMA_SG=m
> # end of Video4Linux options
> 
> #
> # Media controller options
> #
> # CONFIG_MEDIA_CONTROLLER_DVB is not set
> # end of Media controller options
> 
> #
> # Digital TV options
> #
> CONFIG_DVB_MMAP=y
> CONFIG_DVB_NET=y
> CONFIG_DVB_MAX_ADAPTERS=16
> # CONFIG_DVB_DYNAMIC_MINORS is not set
> # CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
> # CONFIG_DVB_ULE_DEBUG is not set
> # end of Digital TV options
> 
> #
> # Media drivers
> #
> CONFIG_MEDIA_PCI_SUPPORT=y
> 
> #
> # Media capture support
> #
> # CONFIG_VIDEO_TW5864 is not set
> CONFIG_VIDEO_TW68=m
> 
> #
> # Media capture/analog TV support
> #
> CONFIG_VIDEO_IVTV=m
> CONFIG_VIDEO_FB_IVTV=m
> CONFIG_VIDEO_FB_IVTV_FORCE_PAT=y
> CONFIG_VIDEO_HEXIUM_GEMINI=m
> CONFIG_VIDEO_HEXIUM_ORION=m
> # CONFIG_VIDEO_MXB is not set
> CONFIG_VIDEO_DT3155=m
> 
> #
> # Media capture/analog/hybrid TV support
> #
> # CONFIG_VIDEO_CX18 is not set
> CONFIG_VIDEO_CX25821=m
> # CONFIG_VIDEO_CX88 is not set
> # CONFIG_VIDEO_BT848 is not set
> CONFIG_VIDEO_SAA7134=m
> CONFIG_VIDEO_SAA7134_RC=y
> # CONFIG_VIDEO_SAA7134_DVB is not set
> CONFIG_VIDEO_SAA7164=m
> 
> #
> # Media digital TV PCI Adapters
> #
> # CONFIG_DVB_BUDGET_CORE is not set
> # CONFIG_DVB_B2C2_FLEXCOP_PCI is not set
> # CONFIG_DVB_PLUTO2 is not set
> # CONFIG_DVB_DM1105 is not set
> # CONFIG_DVB_PT1 is not set
> # CONFIG_DVB_PT3 is not set
> CONFIG_MANTIS_CORE=m
> CONFIG_DVB_MANTIS=m
> # CONFIG_DVB_HOPPER is not set
> CONFIG_DVB_NGENE=m
> CONFIG_DVB_DDBRIDGE=m
> CONFIG_DVB_SMIPCIE=m
> CONFIG_DVB_NETUP_UNIDVB=m
> CONFIG_VIDEO_IPU3_CIO2=m
> CONFIG_CIO2_BRIDGE=y
> # CONFIG_VIDEO_PCI_SKELETON is not set
> CONFIG_RADIO_ADAPTERS=y
> CONFIG_RADIO_TEA575X=m
> # CONFIG_RADIO_SI470X is not set
> # CONFIG_RADIO_SI4713 is not set
> CONFIG_RADIO_MAXIRADIO=m
> CONFIG_RADIO_TEA5764=m
> CONFIG_RADIO_SAA7706H=m
> CONFIG_RADIO_TEF6862=m
> CONFIG_RADIO_TIMBERDALE=m
> CONFIG_RADIO_WL1273=m
> CONFIG_VIDEO_CX2341X=m
> CONFIG_VIDEO_TVEEPROM=m
> CONFIG_TTPCI_EEPROM=m
> CONFIG_VIDEOBUF2_CORE=m
> CONFIG_VIDEOBUF2_V4L2=m
> CONFIG_VIDEOBUF2_MEMOPS=m
> CONFIG_VIDEOBUF2_DMA_CONTIG=m
> CONFIG_VIDEOBUF2_VMALLOC=m
> CONFIG_VIDEOBUF2_DMA_SG=m
> CONFIG_VIDEOBUF2_DVB=m
> CONFIG_VIDEO_SAA7146=m
> CONFIG_VIDEO_SAA7146_VV=m
> CONFIG_V4L_PLATFORM_DRIVERS=y
> # CONFIG_VIDEO_CAFE_CCIC is not set
> CONFIG_VIDEO_VIA_CAMERA=m
> CONFIG_VIDEO_CADENCE=y
> CONFIG_VIDEO_CADENCE_CSI2RX=m
> CONFIG_VIDEO_CADENCE_CSI2TX=m
> CONFIG_VIDEO_ASPEED=m
> CONFIG_V4L_MEM2MEM_DRIVERS=y
> CONFIG_VIDEO_MEM2MEM_DEINTERLACE=m
> CONFIG_DVB_PLATFORM_DRIVERS=y
> # CONFIG_SDR_PLATFORM_DRIVERS is not set
> # CONFIG_V4L_TEST_DRIVERS is not set
> # CONFIG_DVB_TEST_DRIVERS is not set
> 
> #
> # FireWire (IEEE 1394) Adapters
> #
> CONFIG_DVB_FIREDTV=m
> CONFIG_DVB_FIREDTV_INPUT=y
> # end of Media drivers
> 
> CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y
> 
> #
> # Media ancillary drivers
> #
> CONFIG_MEDIA_ATTACH=y
> 
> #
> # IR I2C driver auto-selected by 'Autoselect ancillary drivers'
> #
> CONFIG_VIDEO_IR_I2C=m
> 
> #
> # audio, video and radio I2C drivers auto-selected by 'Autoselect ancillary drivers'
> #
> CONFIG_VIDEO_MSP3400=m
> CONFIG_VIDEO_CS53L32A=m
> CONFIG_VIDEO_WM8775=m
> CONFIG_VIDEO_WM8739=m
> CONFIG_VIDEO_VP27SMPX=m
> CONFIG_VIDEO_SAA6588=m
> CONFIG_VIDEO_BT819=m
> CONFIG_VIDEO_BT856=m
> CONFIG_VIDEO_SAA7110=m
> CONFIG_VIDEO_SAA711X=m
> CONFIG_VIDEO_VPX3220=m
> 
> #
> # Video and audio decoders
> #
> CONFIG_VIDEO_SAA717X=m
> CONFIG_VIDEO_CX25840=m
> CONFIG_VIDEO_SAA7127=m
> CONFIG_VIDEO_ADV7175=m
> CONFIG_VIDEO_UPD64031A=m
> CONFIG_VIDEO_UPD64083=m
> CONFIG_VIDEO_SAA6752HS=m
> CONFIG_VIDEO_M52790=m
> 
> #
> # Camera sensor devices
> #
> CONFIG_VIDEO_APTINA_PLL=m
> CONFIG_VIDEO_CCS_PLL=m
> CONFIG_VIDEO_HI556=m
> CONFIG_VIDEO_HI846=m
> # CONFIG_VIDEO_IMX208 is not set
> # CONFIG_VIDEO_IMX214 is not set
> # CONFIG_VIDEO_IMX219 is not set
> CONFIG_VIDEO_IMX258=m
> # CONFIG_VIDEO_IMX274 is not set
> CONFIG_VIDEO_IMX290=m
> CONFIG_VIDEO_IMX319=m
> CONFIG_VIDEO_IMX355=m
> CONFIG_VIDEO_OV02A10=m
> # CONFIG_VIDEO_OV2640 is not set
> CONFIG_VIDEO_OV2659=m
> CONFIG_VIDEO_OV2680=m
> # CONFIG_VIDEO_OV2685 is not set
> CONFIG_VIDEO_OV2740=m
> CONFIG_VIDEO_OV5647=m
> CONFIG_VIDEO_OV5648=m
> # CONFIG_VIDEO_OV6650 is not set
> # CONFIG_VIDEO_OV5670 is not set
> # CONFIG_VIDEO_OV5675 is not set
> CONFIG_VIDEO_OV5693=m
> # CONFIG_VIDEO_OV5695 is not set
> CONFIG_VIDEO_OV7251=m
> CONFIG_VIDEO_OV772X=m
> CONFIG_VIDEO_OV7640=m
> CONFIG_VIDEO_OV7670=m
> CONFIG_VIDEO_OV7740=m
> # CONFIG_VIDEO_OV8856 is not set
> CONFIG_VIDEO_OV8865=m
> # CONFIG_VIDEO_OV9640 is not set
> # CONFIG_VIDEO_OV9650 is not set
> CONFIG_VIDEO_OV9734=m
> CONFIG_VIDEO_OV13858=m
> # CONFIG_VIDEO_OV13B10 is not set
> # CONFIG_VIDEO_VS6624 is not set
> # CONFIG_VIDEO_MT9M001 is not set
> CONFIG_VIDEO_MT9M032=m
> CONFIG_VIDEO_MT9M111=m
> # CONFIG_VIDEO_MT9P031 is not set
> # CONFIG_VIDEO_MT9T001 is not set
> # CONFIG_VIDEO_MT9T112 is not set
> CONFIG_VIDEO_MT9V011=m
> # CONFIG_VIDEO_MT9V032 is not set
> # CONFIG_VIDEO_MT9V111 is not set
> CONFIG_VIDEO_SR030PC30=m
> CONFIG_VIDEO_NOON010PC30=m
> CONFIG_VIDEO_M5MOLS=m
> CONFIG_VIDEO_MAX9271_LIB=m
> CONFIG_VIDEO_RDACM20=m
> # CONFIG_VIDEO_RDACM21 is not set
> CONFIG_VIDEO_RJ54N1=m
> CONFIG_VIDEO_S5K6AA=m
> CONFIG_VIDEO_S5K6A3=m
> CONFIG_VIDEO_S5K4ECGX=m
> CONFIG_VIDEO_S5K5BAF=m
> CONFIG_VIDEO_CCS=m
> # CONFIG_VIDEO_ET8EK8 is not set
> # CONFIG_VIDEO_S5C73M3 is not set
> # end of Camera sensor devices
> 
> #
> # Lens drivers
> #
> CONFIG_VIDEO_AD5820=m
> CONFIG_VIDEO_AK7375=m
> # CONFIG_VIDEO_DW9714 is not set
> CONFIG_VIDEO_DW9768=m
> # CONFIG_VIDEO_DW9807_VCM is not set
> # end of Lens drivers
> 
> #
> # Flash devices
> #
> # CONFIG_VIDEO_ADP1653 is not set
> # CONFIG_VIDEO_LM3560 is not set
> CONFIG_VIDEO_LM3646=m
> # end of Flash devices
> 
> #
> # SPI I2C drivers auto-selected by 'Autoselect ancillary drivers'
> #
> 
> #
> # Media SPI Adapters
> #
> CONFIG_CXD2880_SPI_DRV=m
> # end of Media SPI Adapters
> 
> CONFIG_MEDIA_TUNER=m
> 
> #
> # Tuner drivers auto-selected by 'Autoselect ancillary drivers'
> #
> CONFIG_MEDIA_TUNER_SIMPLE=m
> CONFIG_MEDIA_TUNER_TDA8290=m
> CONFIG_MEDIA_TUNER_TDA827X=m
> CONFIG_MEDIA_TUNER_TDA18271=m
> CONFIG_MEDIA_TUNER_TDA9887=m
> CONFIG_MEDIA_TUNER_TEA5761=m
> CONFIG_MEDIA_TUNER_TEA5767=m
> CONFIG_MEDIA_TUNER_MT20XX=m
> CONFIG_MEDIA_TUNER_MT2131=m
> CONFIG_MEDIA_TUNER_XC2028=m
> CONFIG_MEDIA_TUNER_XC5000=m
> CONFIG_MEDIA_TUNER_XC4000=m
> CONFIG_MEDIA_TUNER_MC44S803=m
> CONFIG_MEDIA_TUNER_TDA18212=m
> CONFIG_MEDIA_TUNER_M88RS6000T=m
> CONFIG_MEDIA_TUNER_SI2157=m
> 
> #
> # DVB Frontend drivers auto-selected by 'Autoselect ancillary drivers'
> #
> 
> #
> # Multistandard (satellite) frontends
> #
> CONFIG_DVB_STB0899=m
> CONFIG_DVB_STB6100=m
> CONFIG_DVB_STV090x=m
> CONFIG_DVB_STV0910=m
> CONFIG_DVB_STV6110x=m
> CONFIG_DVB_STV6111=m
> CONFIG_DVB_MXL5XX=m
> CONFIG_DVB_M88DS3103=m
> 
> #
> # Multistandard (cable + terrestrial) frontends
> #
> CONFIG_DVB_DRXK=m
> CONFIG_DVB_TDA18271C2DD=m
> 
> #
> # DVB-S (satellite) frontends
> #
> CONFIG_DVB_STV0299=m
> CONFIG_DVB_TDA8083=m
> CONFIG_DVB_VES1X93=m
> CONFIG_DVB_TS2020=m
> CONFIG_DVB_MB86A16=m
> 
> #
> # DVB-T (terrestrial) frontends
> #
> CONFIG_DVB_L64781=m
> CONFIG_DVB_ZL10353=m
> CONFIG_DVB_TDA10048=m
> CONFIG_DVB_STV0367=m
> CONFIG_DVB_CXD2841ER=m
> CONFIG_DVB_SI2168=m
> 
> #
> # DVB-C (cable) frontends
> #
> CONFIG_DVB_VES1820=m
> CONFIG_DVB_TDA10021=m
> CONFIG_DVB_TDA10023=m
> CONFIG_DVB_STV0297=m
> 
> #
> # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> #
> CONFIG_DVB_LGDT330X=m
> CONFIG_DVB_S5H1411=m
> 
> #
> # ISDB-T (terrestrial) frontends
> #
> 
> #
> # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> #
> 
> #
> # Digital terrestrial only tuners/PLL
> #
> CONFIG_DVB_PLL=m
> 
> #
> # SEC control devices for DVB-S
> #
> CONFIG_DVB_LNBH25=m
> CONFIG_DVB_LNBP21=m
> CONFIG_DVB_TDA665x=m
> CONFIG_DVB_HORUS3A=m
> CONFIG_DVB_ASCOT2E=m
> CONFIG_DVB_HELENE=m
> 
> #
> # Common Interface (EN50221) controller drivers
> #
> CONFIG_DVB_CXD2099=m
> 
> #
> # Tools to develop new frontends
> #
> CONFIG_DVB_DUMMY_FE=m
> # end of Media ancillary drivers
> 
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
> CONFIG_INTEL_GTT=m
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> # CONFIG_VGA_SWITCHEROO is not set
> CONFIG_DRM=y
> CONFIG_DRM_MIPI_DBI=y
> CONFIG_DRM_MIPI_DSI=y
> # CONFIG_DRM_DP_AUX_CHARDEV is not set
> CONFIG_DRM_DEBUG_MM=y
> # CONFIG_DRM_DEBUG_SELFTEST is not set
> CONFIG_DRM_KMS_HELPER=y
> # CONFIG_DRM_FBDEV_EMULATION is not set
> # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
> # CONFIG_DRM_DP_CEC is not set
> CONFIG_DRM_TTM=y
> CONFIG_DRM_VRAM_HELPER=y
> CONFIG_DRM_TTM_HELPER=y
> CONFIG_DRM_GEM_CMA_HELPER=y
> CONFIG_DRM_GEM_SHMEM_HELPER=y
> CONFIG_DRM_SCHED=y
> 
> #
> # I2C encoder or helper chips
> #
> # CONFIG_DRM_I2C_CH7006 is not set
> CONFIG_DRM_I2C_SIL164=y
> CONFIG_DRM_I2C_NXP_TDA998X=y
> # CONFIG_DRM_I2C_NXP_TDA9950 is not set
> # end of I2C encoder or helper chips
> 
> #
> # ARM devices
> #
> # end of ARM devices
> 
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_AMDGPU is not set
> # CONFIG_DRM_NOUVEAU is not set
> CONFIG_DRM_I915=m
> CONFIG_DRM_I915_FORCE_PROBE=""
> CONFIG_DRM_I915_CAPTURE_ERROR=y
> CONFIG_DRM_I915_COMPRESS_ERROR=y
> CONFIG_DRM_I915_USERPTR=y
> CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
> CONFIG_DRM_I915_FENCE_TIMEOUT=10000
> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
> CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
> CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
> CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
> CONFIG_DRM_I915_STOP_TIMEOUT=100
> CONFIG_DRM_I915_TIMESLICE_DURATION=1
> CONFIG_DRM_VGEM=m
> CONFIG_DRM_VKMS=m
> # CONFIG_DRM_VMWGFX is not set
> CONFIG_DRM_GMA500=y
> CONFIG_DRM_AST=y
> CONFIG_DRM_MGAG200=y
> CONFIG_DRM_QXL=y
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> # CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
> # CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
> # end of Display Panels
> 
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> CONFIG_DRM_ANALOGIX_ANX78XX=m
> CONFIG_DRM_ANALOGIX_DP=m
> # end of Display Interface Bridges
> 
> CONFIG_DRM_ETNAVIV=y
> CONFIG_DRM_ETNAVIV_THERMAL=y
> CONFIG_DRM_BOCHS=y
> CONFIG_DRM_CIRRUS_QEMU=y
> CONFIG_DRM_SIMPLEDRM=y
> CONFIG_TINYDRM_HX8357D=y
> # CONFIG_TINYDRM_ILI9163 is not set
> # CONFIG_TINYDRM_ILI9225 is not set
> CONFIG_TINYDRM_ILI9341=m
> # CONFIG_TINYDRM_ILI9486 is not set
> CONFIG_TINYDRM_MI0283QT=y
> CONFIG_TINYDRM_REPAPER=y
> CONFIG_TINYDRM_ST7586=y
> CONFIG_TINYDRM_ST7735R=m
> # CONFIG_DRM_VBOXVIDEO is not set
> # CONFIG_DRM_LEGACY is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> CONFIG_DRM_NOMODESET=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB=y
> CONFIG_FIRMWARE_EDID=y
> CONFIG_FB_DDC=y
> CONFIG_FB_BOOT_VESA_SUPPORT=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SYS_FILLRECT=y
> CONFIG_FB_SYS_COPYAREA=y
> CONFIG_FB_SYS_IMAGEBLIT=y
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=y
> CONFIG_FB_DEFERRED_IO=y
> CONFIG_FB_HECUBA=m
> CONFIG_FB_SVGALIB=m
> CONFIG_FB_BACKLIGHT=y
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> 
> #
> # Frame buffer hardware drivers
> #
> CONFIG_FB_CIRRUS=y
> CONFIG_FB_PM2=m
> # CONFIG_FB_PM2_FIFO_DISCONNECT is not set
> CONFIG_FB_CYBER2000=y
> # CONFIG_FB_CYBER2000_DDC is not set
> # CONFIG_FB_ARC is not set
> CONFIG_FB_ASILIANT=y
> CONFIG_FB_IMSTT=y
> # CONFIG_FB_VGA16 is not set
> CONFIG_FB_VESA=y
> CONFIG_FB_N411=m
> CONFIG_FB_HGA=y
> CONFIG_FB_OPENCORES=y
> CONFIG_FB_S1D13XXX=y
> CONFIG_FB_NVIDIA=y
> # CONFIG_FB_NVIDIA_I2C is not set
> # CONFIG_FB_NVIDIA_DEBUG is not set
> CONFIG_FB_NVIDIA_BACKLIGHT=y
> CONFIG_FB_RIVA=m
> CONFIG_FB_RIVA_I2C=y
> # CONFIG_FB_RIVA_DEBUG is not set
> CONFIG_FB_RIVA_BACKLIGHT=y
> # CONFIG_FB_I740 is not set
> CONFIG_FB_LE80578=y
> CONFIG_FB_CARILLO_RANCH=y
> # CONFIG_FB_MATROX is not set
> CONFIG_FB_RADEON=m
> CONFIG_FB_RADEON_I2C=y
> # CONFIG_FB_RADEON_BACKLIGHT is not set
> CONFIG_FB_RADEON_DEBUG=y
> CONFIG_FB_ATY128=y
> CONFIG_FB_ATY128_BACKLIGHT=y
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> CONFIG_FB_VIA=m
> CONFIG_FB_VIA_DIRECT_PROCFS=y
> # CONFIG_FB_VIA_X_COMPATIBILITY is not set
> CONFIG_FB_NEOMAGIC=m
> CONFIG_FB_KYRO=y
> CONFIG_FB_3DFX=m
> CONFIG_FB_3DFX_ACCEL=y
> CONFIG_FB_3DFX_I2C=y
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_VT8623 is not set
> CONFIG_FB_TRIDENT=y
> CONFIG_FB_ARK=m
> CONFIG_FB_PM3=y
> CONFIG_FB_CARMINE=y
> # CONFIG_FB_CARMINE_DRAM_EVAL is not set
> CONFIG_CARMINE_DRAM_CUSTOM=y
> # CONFIG_FB_GEODE is not set
> # CONFIG_FB_IBM_GXT4500 is not set
> # CONFIG_FB_GOLDFISH is not set
> # CONFIG_FB_VIRTUAL is not set
> CONFIG_FB_METRONOME=y
> CONFIG_FB_MB862XX=y
> CONFIG_FB_MB862XX_PCI_GDC=y
> # CONFIG_FB_MB862XX_I2C is not set
> # CONFIG_FB_SSD1307 is not set
> # CONFIG_FB_SM712 is not set
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> CONFIG_LCD_CLASS_DEVICE=m
> CONFIG_LCD_L4F00242T03=m
> # CONFIG_LCD_LMS283GF05 is not set
> CONFIG_LCD_LTV350QV=m
> CONFIG_LCD_ILI922X=m
> CONFIG_LCD_ILI9320=m
> CONFIG_LCD_TDO24M=m
> CONFIG_LCD_VGG2432A4=m
> CONFIG_LCD_PLATFORM=m
> CONFIG_LCD_AMS369FG06=m
> # CONFIG_LCD_LMS501KF03 is not set
> CONFIG_LCD_HX8357=m
> # CONFIG_LCD_OTM3225A is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> CONFIG_BACKLIGHT_KTD253=m
> CONFIG_BACKLIGHT_CARILLO_RANCH=m
> CONFIG_BACKLIGHT_DA9052=m
> CONFIG_BACKLIGHT_APPLE=y
> # CONFIG_BACKLIGHT_QCOM_WLED is not set
> CONFIG_BACKLIGHT_RT4831=y
> CONFIG_BACKLIGHT_SAHARA=y
> # CONFIG_BACKLIGHT_WM831X is not set
> CONFIG_BACKLIGHT_ADP8860=m
> CONFIG_BACKLIGHT_ADP8870=m
> CONFIG_BACKLIGHT_88PM860X=y
> CONFIG_BACKLIGHT_PCF50633=y
> # CONFIG_BACKLIGHT_AAT2870 is not set
> # CONFIG_BACKLIGHT_LM3639 is not set
> CONFIG_BACKLIGHT_SKY81452=m
> CONFIG_BACKLIGHT_AS3711=y
> CONFIG_BACKLIGHT_GPIO=m
> # CONFIG_BACKLIGHT_LV5207LP is not set
> # CONFIG_BACKLIGHT_BD6107 is not set
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> CONFIG_BACKLIGHT_RAVE_SP=y
> # end of Backlight & LCD device support
> 
> CONFIG_VGASTATE=y
> CONFIG_HDMI=y
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_DUMMY_CONSOLE_COLUMNS=80
> CONFIG_DUMMY_CONSOLE_ROWS=25
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
> # end of Console display driver support
> 
> CONFIG_LOGO=y
> CONFIG_LOGO_LINUX_MONO=y
> # CONFIG_LOGO_LINUX_VGA16 is not set
> # CONFIG_LOGO_LINUX_CLUT224 is not set
> # end of Graphics support
> 
> # CONFIG_SOUND is not set
> 
> #
> # HID support
> #
> CONFIG_HID=y
> CONFIG_HID_BATTERY_STRENGTH=y
> # CONFIG_HIDRAW is not set
> CONFIG_UHID=y
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=m
> CONFIG_HID_ACRUX=y
> CONFIG_HID_ACRUX_FF=y
> CONFIG_HID_APPLE=m
> CONFIG_HID_AUREAL=m
> CONFIG_HID_BELKIN=m
> CONFIG_HID_CHERRY=m
> CONFIG_HID_COUGAR=y
> CONFIG_HID_MACALLY=m
> CONFIG_HID_CMEDIA=y
> # CONFIG_HID_CYPRESS is not set
> # CONFIG_HID_DRAGONRISE is not set
> CONFIG_HID_EMS_FF=m
> CONFIG_HID_ELECOM=y
> # CONFIG_HID_EZKEY is not set
> CONFIG_HID_GEMBIRD=y
> # CONFIG_HID_GFRM is not set
> CONFIG_HID_GLORIOUS=y
> CONFIG_HID_VIVALDI=m
> CONFIG_HID_KEYTOUCH=m
> CONFIG_HID_KYE=y
> CONFIG_HID_WALTOP=m
> CONFIG_HID_VIEWSONIC=m
> # CONFIG_HID_XIAOMI is not set
> CONFIG_HID_GYRATION=y
> # CONFIG_HID_ICADE is not set
> CONFIG_HID_ITE=y
> CONFIG_HID_JABRA=m
> # CONFIG_HID_TWINHAN is not set
> CONFIG_HID_KENSINGTON=m
> CONFIG_HID_LCPOWER=y
> CONFIG_HID_LED=y
> CONFIG_HID_LENOVO=y
> # CONFIG_HID_MAGICMOUSE is not set
> # CONFIG_HID_MALTRON is not set
> CONFIG_HID_MAYFLASH=m
> CONFIG_HID_REDRAGON=y
> # CONFIG_HID_MICROSOFT is not set
> # CONFIG_HID_MONTEREY is not set
> # CONFIG_HID_MULTITOUCH is not set
> # CONFIG_HID_NINTENDO is not set
> # CONFIG_HID_NTI is not set
> CONFIG_HID_ORTEK=y
> # CONFIG_HID_PANTHERLORD is not set
> CONFIG_HID_PETALYNX=m
> # CONFIG_HID_PICOLCD is not set
> CONFIG_HID_PLANTRONICS=y
> CONFIG_HID_PRIMAX=m
> # CONFIG_HID_SAITEK is not set
> CONFIG_HID_SEMITEK=y
> CONFIG_HID_SPEEDLINK=m
> CONFIG_HID_STEAM=m
> # CONFIG_HID_STEELSERIES is not set
> CONFIG_HID_SUNPLUS=y
> CONFIG_HID_RMI=m
> CONFIG_HID_GREENASIA=y
> CONFIG_GREENASIA_FF=y
> CONFIG_HID_SMARTJOYPLUS=y
> CONFIG_SMARTJOYPLUS_FF=y
> # CONFIG_HID_TIVO is not set
> CONFIG_HID_TOPSEED=m
> CONFIG_HID_THINGM=y
> # CONFIG_HID_UDRAW_PS3 is not set
> CONFIG_HID_WIIMOTE=m
> CONFIG_HID_XINMO=y
> # CONFIG_HID_ZEROPLUS is not set
> CONFIG_HID_ZYDACRON=y
> CONFIG_HID_SENSOR_HUB=y
> CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
> # CONFIG_HID_ALPS is not set
> # end of Special HID drivers
> 
> #
> # I2C HID support
> #
> CONFIG_I2C_HID_ACPI=y
> # end of I2C HID support
> 
> CONFIG_I2C_HID_CORE=y
> # end of HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> # CONFIG_USB_ULPI_BUS is not set
> # CONFIG_USB_CONN_GPIO is not set
> CONFIG_USB_ARCH_HAS_HCD=y
> # CONFIG_USB is not set
> CONFIG_USB_PCI=y
> 
> #
> # USB port drivers
> #
> 
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_GPIO_VBUS is not set
> # end of USB Physical Layer drivers
> 
> # CONFIG_USB_GADGET is not set
> # CONFIG_TYPEC is not set
> # CONFIG_USB_ROLE_SWITCH is not set
> # CONFIG_MMC is not set
> CONFIG_MEMSTICK=y
> CONFIG_MEMSTICK_DEBUG=y
> 
> #
> # MemoryStick drivers
> #
> # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> CONFIG_MSPRO_BLOCK=y
> CONFIG_MS_BLOCK=m
> 
> #
> # MemoryStick Host Controller Drivers
> #
> CONFIG_MEMSTICK_TIFM_MS=m
> CONFIG_MEMSTICK_JMICRON_38X=y
> CONFIG_MEMSTICK_R592=y
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> # CONFIG_LEDS_CLASS_FLASH is not set
> # CONFIG_LEDS_CLASS_MULTICOLOR is not set
> CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
> 
> #
> # LED drivers
> #
> CONFIG_LEDS_88PM860X=y
> # CONFIG_LEDS_APU is not set
> CONFIG_LEDS_LM3530=m
> # CONFIG_LEDS_LM3532 is not set
> CONFIG_LEDS_LM3642=y
> # CONFIG_LEDS_MT6323 is not set
> CONFIG_LEDS_PCA9532=y
> # CONFIG_LEDS_PCA9532_GPIO is not set
> CONFIG_LEDS_GPIO=m
> CONFIG_LEDS_LP3944=y
> CONFIG_LEDS_LP3952=m
> CONFIG_LEDS_LP50XX=y
> CONFIG_LEDS_LP8788=y
> CONFIG_LEDS_CLEVO_MAIL=m
> CONFIG_LEDS_PCA955X=y
> # CONFIG_LEDS_PCA955X_GPIO is not set
> # CONFIG_LEDS_PCA963X is not set
> # CONFIG_LEDS_WM831X_STATUS is not set
> # CONFIG_LEDS_DA9052 is not set
> CONFIG_LEDS_DAC124S085=m
> CONFIG_LEDS_REGULATOR=y
> CONFIG_LEDS_BD2802=y
> CONFIG_LEDS_INTEL_SS4200=y
> CONFIG_LEDS_LT3593=m
> CONFIG_LEDS_MC13783=y
> CONFIG_LEDS_TCA6507=m
> # CONFIG_LEDS_TLC591XX is not set
> CONFIG_LEDS_LM355x=m
> CONFIG_LEDS_OT200=m
> CONFIG_LEDS_MENF21BMC=y
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=m
> CONFIG_LEDS_MLXCPLD=m
> # CONFIG_LEDS_MLXREG is not set
> CONFIG_LEDS_USER=m
> # CONFIG_LEDS_NIC78BX is not set
> CONFIG_LEDS_TI_LMU_COMMON=y
> # CONFIG_LEDS_TPS6105X is not set
> 
> #
> # Flash and Torch LED drivers
> #
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> # CONFIG_LEDS_TRIGGER_TIMER is not set
> CONFIG_LEDS_TRIGGER_ONESHOT=m
> # CONFIG_LEDS_TRIGGER_MTD is not set
> CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> CONFIG_LEDS_TRIGGER_BACKLIGHT=m
> CONFIG_LEDS_TRIGGER_CPU=y
> CONFIG_LEDS_TRIGGER_ACTIVITY=y
> # CONFIG_LEDS_TRIGGER_GPIO is not set
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> CONFIG_LEDS_TRIGGER_TRANSIENT=m
> # CONFIG_LEDS_TRIGGER_CAMERA is not set
> # CONFIG_LEDS_TRIGGER_PANIC is not set
> # CONFIG_LEDS_TRIGGER_NETDEV is not set
> CONFIG_LEDS_TRIGGER_PATTERN=y
> CONFIG_LEDS_TRIGGER_AUDIO=m
> CONFIG_LEDS_TRIGGER_TTY=y
> 
> #
> # Simple LED drivers
> #
> CONFIG_LEDS_SIEMENS_SIMATIC_IPC=m
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_EDAC=m
> CONFIG_EDAC_LEGACY_SYSFS=y
> # CONFIG_EDAC_DEBUG is not set
> # CONFIG_EDAC_AMD76X is not set
> CONFIG_EDAC_E7XXX=m
> # CONFIG_EDAC_E752X is not set
> CONFIG_EDAC_I82875P=m
> # CONFIG_EDAC_I82975X is not set
> # CONFIG_EDAC_I3000 is not set
> CONFIG_EDAC_I3200=m
> CONFIG_EDAC_IE31200=m
> # CONFIG_EDAC_X38 is not set
> CONFIG_EDAC_I5400=m
> CONFIG_EDAC_I82860=m
> CONFIG_EDAC_R82600=m
> CONFIG_EDAC_I5000=m
> CONFIG_EDAC_I5100=m
> CONFIG_EDAC_I7300=m
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> # CONFIG_RTC_CLASS is not set
> CONFIG_DMADEVICES=y
> CONFIG_DMADEVICES_DEBUG=y
> # CONFIG_DMADEVICES_VDEBUG is not set
> 
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=y
> CONFIG_DMA_VIRTUAL_CHANNELS=y
> CONFIG_DMA_ACPI=y
> # CONFIG_ALTERA_MSGDMA is not set
> CONFIG_INTEL_IDMA64=m
> # CONFIG_PCH_DMA is not set
> # CONFIG_PLX_DMA is not set
> # CONFIG_TIMB_DMA is not set
> CONFIG_QCOM_HIDMA_MGMT=y
> CONFIG_QCOM_HIDMA=m
> CONFIG_DW_DMAC_CORE=y
> CONFIG_DW_DMAC=y
> CONFIG_DW_DMAC_PCI=m
> CONFIG_HSU_DMA=y
> CONFIG_SF_PDMA=m
> # CONFIG_INTEL_LDMA is not set
> 
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=y
> CONFIG_DMATEST=y
> CONFIG_DMA_ENGINE_RAID=y
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> CONFIG_SW_SYNC=y
> CONFIG_UDMABUF=y
> # CONFIG_DMABUF_MOVE_NOTIFY is not set
> CONFIG_DMABUF_DEBUG=y
> # CONFIG_DMABUF_SELFTESTS is not set
> CONFIG_DMABUF_HEAPS=y
> CONFIG_DMABUF_SYSFS_STATS=y
> CONFIG_DMABUF_HEAPS_SYSTEM=y
> CONFIG_DMABUF_HEAPS_CMA=y
> # end of DMABUF options
> 
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_PANEL is not set
> CONFIG_UIO=y
> # CONFIG_UIO_CIF is not set
> CONFIG_UIO_PDRV_GENIRQ=y
> CONFIG_UIO_DMEM_GENIRQ=y
> CONFIG_UIO_AEC=y
> CONFIG_UIO_SERCOS3=y
> CONFIG_UIO_PCI_GENERIC=m
> CONFIG_UIO_NETX=m
> CONFIG_UIO_PRUSS=y
> # CONFIG_UIO_MF624 is not set
> CONFIG_UIO_DFL=m
> CONFIG_VFIO=m
> CONFIG_VFIO_IOMMU_TYPE1=m
> CONFIG_VFIO_NOIOMMU=y
> CONFIG_VFIO_PCI_MMAP=y
> CONFIG_VFIO_PCI_INTX=y
> # CONFIG_VFIO_PCI is not set
> CONFIG_VFIO_MDEV=m
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO=y
> # CONFIG_VIRTIO_MENU is not set
> # CONFIG_VDPA is not set
> CONFIG_VHOST_IOTLB=m
> CONFIG_VHOST=m
> CONFIG_VHOST_MENU=y
> # CONFIG_VHOST_NET is not set
> CONFIG_VHOST_SCSI=m
> CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
> 
> #
> # Microsoft Hyper-V guest support
> #
> # end of Microsoft Hyper-V guest support
> 
> CONFIG_GREYBUS=m
> # CONFIG_COMEDI is not set
> CONFIG_STAGING=y
> # CONFIG_RTLLIB is not set
> 
> #
> # IIO staging drivers
> #
> 
> #
> # Accelerometers
> #
> CONFIG_ADIS16203=m
> CONFIG_ADIS16240=m
> # end of Accelerometers
> 
> #
> # Analog to digital converters
> #
> CONFIG_AD7816=m
> CONFIG_AD7280=m
> # end of Analog to digital converters
> 
> #
> # Analog digital bi-direction converters
> #
> CONFIG_ADT7316=m
> # CONFIG_ADT7316_SPI is not set
> # CONFIG_ADT7316_I2C is not set
> # end of Analog digital bi-direction converters
> 
> #
> # Capacitance to digital converters
> #
> CONFIG_AD7746=m
> # end of Capacitance to digital converters
> 
> #
> # Direct Digital Synthesis
> #
> CONFIG_AD9832=m
> # CONFIG_AD9834 is not set
> # end of Direct Digital Synthesis
> 
> #
> # Network Analyzer, Impedance Converters
> #
> CONFIG_AD5933=m
> # end of Network Analyzer, Impedance Converters
> 
> #
> # Active energy metering IC
> #
> CONFIG_ADE7854=m
> # CONFIG_ADE7854_I2C is not set
> # CONFIG_ADE7854_SPI is not set
> # end of Active energy metering IC
> 
> #
> # Resolver to digital converters
> #
> # CONFIG_AD2S1210 is not set
> # end of Resolver to digital converters
> # end of IIO staging drivers
> 
> # CONFIG_FB_SM750 is not set
> CONFIG_STAGING_MEDIA=y
> CONFIG_VIDEO_ZORAN=m
> CONFIG_VIDEO_ZORAN_DC30=m
> CONFIG_VIDEO_ZORAN_ZR36060=m
> # CONFIG_VIDEO_ZORAN_BUZ is not set
> CONFIG_VIDEO_ZORAN_DC10=m
> CONFIG_VIDEO_ZORAN_LML33=m
> # CONFIG_VIDEO_ZORAN_LML33R10 is not set
> # CONFIG_VIDEO_ZORAN_AVS6EYES is not set
> CONFIG_VIDEO_IPU3_IMGU=m
> CONFIG_DVB_AV7110_IR=y
> CONFIG_DVB_AV7110=m
> # CONFIG_DVB_AV7110_OSD is not set
> CONFIG_DVB_SP8870=m
> 
> #
> # Android
> #
> CONFIG_ASHMEM=y
> # end of Android
> 
> # CONFIG_FIREWIRE_SERIAL is not set
> # CONFIG_GS_FPGABOOT is not set
> # CONFIG_UNISYSSPAR is not set
> # CONFIG_FB_TFT is not set
> CONFIG_MOST_COMPONENTS=y
> # CONFIG_MOST_NET is not set
> CONFIG_MOST_VIDEO=m
> CONFIG_MOST_I2C=y
> # CONFIG_GREYBUS_BOOTROM is not set
> # CONFIG_GREYBUS_FIRMWARE is not set
> # CONFIG_GREYBUS_HID is not set
> CONFIG_GREYBUS_LIGHT=m
> CONFIG_GREYBUS_LOG=m
> CONFIG_GREYBUS_LOOPBACK=m
> CONFIG_GREYBUS_POWER=m
> # CONFIG_GREYBUS_RAW is not set
> CONFIG_GREYBUS_VIBRATOR=m
> CONFIG_GREYBUS_BRIDGED_PHY=m
> CONFIG_GREYBUS_GPIO=m
> # CONFIG_GREYBUS_I2C is not set
> CONFIG_GREYBUS_SPI=m
> CONFIG_GREYBUS_UART=m
> CONFIG_PI433=m
> CONFIG_FIELDBUS_DEV=m
> # CONFIG_QLGE is not set
> CONFIG_X86_PLATFORM_DEVICES=y
> # CONFIG_ACPI_WMI is not set
> # CONFIG_ACERHDF is not set
> # CONFIG_ACER_WIRELESS is not set
> CONFIG_ADV_SWBUTTON=y
> CONFIG_APPLE_GMUX=y
> # CONFIG_ASUS_LAPTOP is not set
> CONFIG_ASUS_WIRELESS=y
> CONFIG_ASUS_TF103C_DOCK=y
> # CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
> # CONFIG_FUJITSU_LAPTOP is not set
> CONFIG_FUJITSU_TABLET=m
> # CONFIG_GPD_POCKET_FAN is not set
> CONFIG_HP_ACCEL=m
> CONFIG_WIRELESS_HOTKEY=m
> CONFIG_IBM_RTL=y
> # CONFIG_SENSORS_HDAPS is not set
> CONFIG_INTEL_ATOMISP2_PDX86=y
> CONFIG_INTEL_ATOMISP2_LED=m
> CONFIG_INTEL_ATOMISP2_PM=y
> # CONFIG_INTEL_SAR_INT1092 is not set
> # CONFIG_INTEL_SKL_INT3472 is not set
> # CONFIG_INTEL_PMC_CORE is not set
> CONFIG_INTEL_PMT_CLASS=m
> CONFIG_INTEL_PMT_TELEMETRY=m
> CONFIG_INTEL_PMT_CRASHLOG=m
> # CONFIG_INTEL_HID_EVENT is not set
> CONFIG_INTEL_VBTN=y
> CONFIG_INTEL_PUNIT_IPC=m
> # CONFIG_INTEL_RST is not set
> # CONFIG_INTEL_SMARTCONNECT is not set
> CONFIG_INTEL_VSEC=m
> # CONFIG_PCENGINES_APU2 is not set
> CONFIG_BARCO_P50_GPIO=m
> CONFIG_SAMSUNG_LAPTOP=m
> CONFIG_SAMSUNG_Q10=y
> CONFIG_TOSHIBA_BT_RFKILL=y
> # CONFIG_TOSHIBA_HAPS is not set
> # CONFIG_ACPI_CMPC is not set
> CONFIG_PANASONIC_LAPTOP=y
> CONFIG_TOPSTAR_LAPTOP=y
> # CONFIG_I2C_MULTI_INSTANTIATE is not set
> CONFIG_MLX_PLATFORM=m
> CONFIG_X86_ANDROID_TABLETS=y
> # CONFIG_INTEL_IPS is not set
> CONFIG_INTEL_SCU_IPC=y
> # CONFIG_INTEL_SCU_PCI is not set
> # CONFIG_INTEL_SCU_PLATFORM is not set
> CONFIG_SIEMENS_SIMATIC_IPC=y
> CONFIG_PMC_ATOM=y
> # CONFIG_GOLDFISH_PIPE is not set
> CONFIG_CHROME_PLATFORMS=y
> # CONFIG_CHROMEOS_LAPTOP is not set
> CONFIG_CHROMEOS_PSTORE=m
> CONFIG_CHROMEOS_TBMC=y
> CONFIG_CROS_EC=m
> CONFIG_CROS_EC_I2C=m
> CONFIG_CROS_EC_SPI=m
> # CONFIG_CROS_EC_LPC is not set
> CONFIG_CROS_EC_PROTO=y
> # CONFIG_CROS_KBD_LED_BACKLIGHT is not set
> CONFIG_MELLANOX_PLATFORM=y
> CONFIG_MLXREG_HOTPLUG=m
> CONFIG_MLXREG_IO=m
> CONFIG_MLXREG_LC=y
> CONFIG_SURFACE_PLATFORMS=y
> # CONFIG_SURFACE_3_POWER_OPREGION is not set
> # CONFIG_SURFACE_GPE is not set
> # CONFIG_SURFACE_HOTPLUG is not set
> CONFIG_SURFACE_PRO3_BUTTON=m
> # CONFIG_SURFACE_AGGREGATOR is not set
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> # CONFIG_COMMON_CLK_WM831X is not set
> CONFIG_LMK04832=m
> CONFIG_COMMON_CLK_MAX9485=y
> CONFIG_COMMON_CLK_SI5341=y
> # CONFIG_COMMON_CLK_SI5351 is not set
> CONFIG_COMMON_CLK_SI544=y
> CONFIG_COMMON_CLK_CDCE706=m
> CONFIG_COMMON_CLK_CS2000_CP=m
> # CONFIG_COMMON_CLK_LAN966X is not set
> # CONFIG_XILINX_VCU is not set
> # CONFIG_HWSPINLOCK is not set
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKSRC_I8253=y
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> # end of Clock Source drivers
> 
> CONFIG_MAILBOX=y
> CONFIG_PCC=y
> CONFIG_ALTERA_MBOX=m
> CONFIG_IOMMU_IOVA=y
> CONFIG_IOMMU_API=y
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> # end of Generic IOMMU Pagetable Support
> 
> CONFIG_IOMMU_DEBUGFS=y
> # CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
> # CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
> CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
> CONFIG_IOMMU_DMA=y
> CONFIG_VIRTIO_IOMMU=m
> 
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=y
> # CONFIG_RPMSG_CHAR is not set
> CONFIG_RPMSG_NS=y
> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
> CONFIG_RPMSG_VIRTIO=y
> # end of Rpmsg drivers
> 
> CONFIG_SOUNDWIRE=y
> 
> #
> # SoundWire Devices
> #
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
> 
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
> 
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
> 
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # end of Enable LiteX SoC Builder specific drivers
> 
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
> 
> # CONFIG_SOC_TI is not set
> 
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> CONFIG_PM_DEVFREQ=y
> 
> #
> # DEVFREQ Governors
> #
> CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
> # CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
> # CONFIG_DEVFREQ_GOV_POWERSAVE is not set
> CONFIG_DEVFREQ_GOV_USERSPACE=y
> CONFIG_DEVFREQ_GOV_PASSIVE=y
> 
> #
> # DEVFREQ Drivers
> #
> CONFIG_PM_DEVFREQ_EVENT=y
> CONFIG_EXTCON=y
> 
> #
> # Extcon Device Drivers
> #
> # CONFIG_EXTCON_ADC_JACK is not set
> # CONFIG_EXTCON_AXP288 is not set
> # CONFIG_EXTCON_FSA9480 is not set
> CONFIG_EXTCON_GPIO=y
> CONFIG_EXTCON_INTEL_INT3496=y
> CONFIG_EXTCON_MAX14577=m
> # CONFIG_EXTCON_MAX3355 is not set
> CONFIG_EXTCON_MAX77693=m
> CONFIG_EXTCON_PTN5150=m
> CONFIG_EXTCON_RT8973A=y
> # CONFIG_EXTCON_SM5502 is not set
> # CONFIG_EXTCON_USB_GPIO is not set
> # CONFIG_EXTCON_USBC_CROS_EC is not set
> CONFIG_EXTCON_USBC_TUSB320=y
> CONFIG_MEMORY=y
> # CONFIG_FPGA_DFL_EMIF is not set
> CONFIG_IIO=m
> CONFIG_IIO_BUFFER=y
> # CONFIG_IIO_BUFFER_CB is not set
> CONFIG_IIO_BUFFER_DMA=m
> # CONFIG_IIO_BUFFER_DMAENGINE is not set
> CONFIG_IIO_BUFFER_HW_CONSUMER=m
> CONFIG_IIO_KFIFO_BUF=m
> CONFIG_IIO_TRIGGERED_BUFFER=m
> CONFIG_IIO_CONFIGFS=m
> CONFIG_IIO_TRIGGER=y
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> # CONFIG_IIO_SW_DEVICE is not set
> # CONFIG_IIO_SW_TRIGGER is not set
> CONFIG_IIO_TRIGGERED_EVENT=m
> 
> #
> # Accelerometers
> #
> # CONFIG_ADIS16201 is not set
> CONFIG_ADIS16209=m
> CONFIG_ADXL313=m
> CONFIG_ADXL313_I2C=m
> CONFIG_ADXL313_SPI=m
> CONFIG_ADXL345=m
> CONFIG_ADXL345_I2C=m
> CONFIG_ADXL345_SPI=m
> CONFIG_ADXL355=m
> # CONFIG_ADXL355_I2C is not set
> CONFIG_ADXL355_SPI=m
> CONFIG_ADXL372=m
> # CONFIG_ADXL372_SPI is not set
> CONFIG_ADXL372_I2C=m
> CONFIG_BMA220=m
> CONFIG_BMA400=m
> CONFIG_BMA400_I2C=m
> CONFIG_BMA400_SPI=m
> CONFIG_BMC150_ACCEL=m
> CONFIG_BMC150_ACCEL_I2C=m
> CONFIG_BMC150_ACCEL_SPI=m
> # CONFIG_BMI088_ACCEL is not set
> CONFIG_DA280=m
> CONFIG_DA311=m
> CONFIG_DMARD09=m
> CONFIG_DMARD10=m
> CONFIG_FXLS8962AF=m
> # CONFIG_FXLS8962AF_I2C is not set
> CONFIG_FXLS8962AF_SPI=m
> # CONFIG_HID_SENSOR_ACCEL_3D is not set
> # CONFIG_KXSD9 is not set
> # CONFIG_KXCJK1013 is not set
> # CONFIG_MC3230 is not set
> CONFIG_MMA7455=m
> CONFIG_MMA7455_I2C=m
> # CONFIG_MMA7455_SPI is not set
> CONFIG_MMA7660=m
> CONFIG_MMA8452=m
> CONFIG_MMA9551_CORE=m
> CONFIG_MMA9551=m
> CONFIG_MMA9553=m
> # CONFIG_MXC4005 is not set
> CONFIG_MXC6255=m
> CONFIG_SCA3000=m
> CONFIG_SCA3300=m
> CONFIG_STK8312=m
> # CONFIG_STK8BA50 is not set
> # end of Accelerometers
> 
> #
> # Analog to digital converters
> #
> CONFIG_AD_SIGMA_DELTA=m
> CONFIG_AD7091R5=m
> CONFIG_AD7124=m
> # CONFIG_AD7192 is not set
> # CONFIG_AD7266 is not set
> CONFIG_AD7291=m
> CONFIG_AD7292=m
> CONFIG_AD7298=m
> CONFIG_AD7476=m
> CONFIG_AD7606=m
> # CONFIG_AD7606_IFACE_PARALLEL is not set
> CONFIG_AD7606_IFACE_SPI=m
> CONFIG_AD7766=m
> # CONFIG_AD7768_1 is not set
> CONFIG_AD7780=m
> # CONFIG_AD7791 is not set
> CONFIG_AD7793=m
> CONFIG_AD7887=m
> CONFIG_AD7923=m
> CONFIG_AD7949=m
> CONFIG_AD799X=m
> CONFIG_AXP20X_ADC=m
> CONFIG_AXP288_ADC=m
> # CONFIG_CC10001_ADC is not set
> # CONFIG_DA9150_GPADC is not set
> CONFIG_HI8435=m
> # CONFIG_HX711 is not set
> CONFIG_INA2XX_ADC=m
> # CONFIG_LP8788_ADC is not set
> CONFIG_LTC2471=m
> # CONFIG_LTC2485 is not set
> # CONFIG_LTC2496 is not set
> # CONFIG_LTC2497 is not set
> CONFIG_MAX1027=m
> CONFIG_MAX11100=m
> # CONFIG_MAX1118 is not set
> CONFIG_MAX1241=m
> # CONFIG_MAX1363 is not set
> # CONFIG_MAX9611 is not set
> CONFIG_MCP320X=m
> CONFIG_MCP3422=m
> # CONFIG_MCP3911 is not set
> CONFIG_MEN_Z188_ADC=m
> CONFIG_MP2629_ADC=m
> # CONFIG_NAU7802 is not set
> CONFIG_TI_ADC081C=m
> CONFIG_TI_ADC0832=m
> CONFIG_TI_ADC084S021=m
> CONFIG_TI_ADC12138=m
> CONFIG_TI_ADC108S102=m
> CONFIG_TI_ADC128S052=m
> CONFIG_TI_ADC161S626=m
> CONFIG_TI_ADS1015=m
> CONFIG_TI_ADS7950=m
> CONFIG_TI_ADS8344=m
> # CONFIG_TI_ADS8688 is not set
> CONFIG_TI_ADS124S08=m
> CONFIG_TI_ADS131E08=m
> CONFIG_TI_TLC4541=m
> CONFIG_TI_TSC2046=m
> CONFIG_XILINX_XADC=m
> # end of Analog to digital converters
> 
> #
> # Analog to digital and digital to analog converters
> #
> CONFIG_AD74413R=m
> # end of Analog to digital and digital to analog converters
> 
> #
> # Analog Front Ends
> #
> # end of Analog Front Ends
> 
> #
> # Amplifiers
> #
> CONFIG_AD8366=m
> CONFIG_HMC425=m
> # end of Amplifiers
> 
> #
> # Capacitance to digital converters
> #
> CONFIG_AD7150=m
> # end of Capacitance to digital converters
> 
> #
> # Chemical Sensors
> #
> # CONFIG_ATLAS_PH_SENSOR is not set
> CONFIG_ATLAS_EZO_SENSOR=m
> CONFIG_BME680=m
> CONFIG_BME680_I2C=m
> CONFIG_BME680_SPI=m
> # CONFIG_CCS811 is not set
> CONFIG_IAQCORE=m
> # CONFIG_PMS7003 is not set
> # CONFIG_SCD30_CORE is not set
> CONFIG_SCD4X=m
> CONFIG_SENSIRION_SGP30=m
> # CONFIG_SENSIRION_SGP40 is not set
> CONFIG_SPS30=m
> CONFIG_SPS30_I2C=m
> # CONFIG_SPS30_SERIAL is not set
> # CONFIG_SENSEAIR_SUNRISE_CO2 is not set
> CONFIG_VZ89X=m
> # end of Chemical Sensors
> 
> #
> # Hid Sensor IIO Common
> #
> CONFIG_HID_SENSOR_IIO_COMMON=m
> CONFIG_HID_SENSOR_IIO_TRIGGER=m
> # end of Hid Sensor IIO Common
> 
> CONFIG_IIO_MS_SENSORS_I2C=m
> 
> #
> # IIO SCMI Sensors
> #
> # end of IIO SCMI Sensors
> 
> #
> # SSP Sensor Common
> #
> CONFIG_IIO_SSP_SENSORS_COMMONS=m
> CONFIG_IIO_SSP_SENSORHUB=m
> # end of SSP Sensor Common
> 
> CONFIG_IIO_ST_SENSORS_I2C=m
> CONFIG_IIO_ST_SENSORS_SPI=m
> CONFIG_IIO_ST_SENSORS_CORE=m
> 
> #
> # Digital to analog converters
> #
> CONFIG_AD3552R=m
> CONFIG_AD5064=m
> CONFIG_AD5360=m
> CONFIG_AD5380=m
> CONFIG_AD5421=m
> CONFIG_AD5446=m
> CONFIG_AD5449=m
> CONFIG_AD5592R_BASE=m
> CONFIG_AD5592R=m
> CONFIG_AD5593R=m
> CONFIG_AD5504=m
> # CONFIG_AD5624R_SPI is not set
> CONFIG_AD5686=m
> # CONFIG_AD5686_SPI is not set
> CONFIG_AD5696_I2C=m
> CONFIG_AD5755=m
> # CONFIG_AD5758 is not set
> CONFIG_AD5761=m
> CONFIG_AD5764=m
> CONFIG_AD5766=m
> CONFIG_AD5770R=m
> # CONFIG_AD5791 is not set
> # CONFIG_AD7293 is not set
> CONFIG_AD7303=m
> CONFIG_AD8801=m
> CONFIG_DS4424=m
> CONFIG_LTC1660=m
> CONFIG_LTC2632=m
> # CONFIG_M62332 is not set
> CONFIG_MAX517=m
> CONFIG_MAX5821=m
> CONFIG_MCP4725=m
> # CONFIG_MCP4922 is not set
> CONFIG_TI_DAC082S085=m
> # CONFIG_TI_DAC5571 is not set
> CONFIG_TI_DAC7311=m
> CONFIG_TI_DAC7612=m
> # end of Digital to analog converters
> 
> #
> # IIO dummy driver
> #
> # end of IIO dummy driver
> 
> #
> # Filters
> #
> # end of Filters
> 
> #
> # Frequency Synthesizers DDS/PLL
> #
> 
> #
> # Clock Generator/Distribution
> #
> CONFIG_AD9523=m
> # end of Clock Generator/Distribution
> 
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> CONFIG_ADF4350=m
> CONFIG_ADF4371=m
> # CONFIG_ADMV1013 is not set
> CONFIG_ADRF6780=m
> # end of Phase-Locked Loop (PLL) frequency synthesizers
> # end of Frequency Synthesizers DDS/PLL
> 
> #
> # Digital gyroscope sensors
> #
> CONFIG_ADIS16080=m
> # CONFIG_ADIS16130 is not set
> # CONFIG_ADIS16136 is not set
> # CONFIG_ADIS16260 is not set
> # CONFIG_ADXRS290 is not set
> # CONFIG_ADXRS450 is not set
> CONFIG_BMG160=m
> CONFIG_BMG160_I2C=m
> CONFIG_BMG160_SPI=m
> CONFIG_FXAS21002C=m
> CONFIG_FXAS21002C_I2C=m
> CONFIG_FXAS21002C_SPI=m
> CONFIG_HID_SENSOR_GYRO_3D=m
> CONFIG_MPU3050=m
> CONFIG_MPU3050_I2C=m
> CONFIG_IIO_ST_GYRO_3AXIS=m
> CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
> CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
> # CONFIG_ITG3200 is not set
> # end of Digital gyroscope sensors
> 
> #
> # Health Sensors
> #
> 
> #
> # Heart Rate Monitors
> #
> # CONFIG_AFE4403 is not set
> CONFIG_AFE4404=m
> # CONFIG_MAX30100 is not set
> CONFIG_MAX30102=m
> # end of Heart Rate Monitors
> # end of Health Sensors
> 
> #
> # Humidity sensors
> #
> CONFIG_AM2315=m
> CONFIG_DHT11=m
> CONFIG_HDC100X=m
> CONFIG_HDC2010=m
> # CONFIG_HID_SENSOR_HUMIDITY is not set
> CONFIG_HTS221=m
> CONFIG_HTS221_I2C=m
> CONFIG_HTS221_SPI=m
> # CONFIG_HTU21 is not set
> CONFIG_SI7005=m
> CONFIG_SI7020=m
> # end of Humidity sensors
> 
> #
> # Inertial measurement units
> #
> CONFIG_ADIS16400=m
> # CONFIG_ADIS16460 is not set
> CONFIG_ADIS16475=m
> CONFIG_ADIS16480=m
> CONFIG_BMI160=m
> CONFIG_BMI160_I2C=m
> CONFIG_BMI160_SPI=m
> CONFIG_FXOS8700=m
> CONFIG_FXOS8700_I2C=m
> CONFIG_FXOS8700_SPI=m
> # CONFIG_KMX61 is not set
> # CONFIG_INV_ICM42600_I2C is not set
> # CONFIG_INV_ICM42600_SPI is not set
> CONFIG_INV_MPU6050_IIO=m
> # CONFIG_INV_MPU6050_I2C is not set
> CONFIG_INV_MPU6050_SPI=m
> CONFIG_IIO_ST_LSM6DSX=m
> CONFIG_IIO_ST_LSM6DSX_I2C=m
> CONFIG_IIO_ST_LSM6DSX_SPI=m
> CONFIG_IIO_ST_LSM6DSX_I3C=m
> # end of Inertial measurement units
> 
> CONFIG_IIO_ADIS_LIB=m
> CONFIG_IIO_ADIS_LIB_BUFFER=y
> 
> #
> # Light sensors
> #
> CONFIG_ACPI_ALS=m
> # CONFIG_ADJD_S311 is not set
> CONFIG_ADUX1020=m
> CONFIG_AL3010=m
> CONFIG_AL3320A=m
> CONFIG_APDS9300=m
> CONFIG_APDS9960=m
> CONFIG_AS73211=m
> CONFIG_BH1750=m
> # CONFIG_BH1780 is not set
> CONFIG_CM32181=m
> CONFIG_CM3232=m
> # CONFIG_CM3323 is not set
> CONFIG_CM36651=m
> # CONFIG_GP2AP002 is not set
> # CONFIG_GP2AP020A00F is not set
> # CONFIG_IQS621_ALS is not set
> CONFIG_SENSORS_ISL29018=m
> # CONFIG_SENSORS_ISL29028 is not set
> # CONFIG_ISL29125 is not set
> CONFIG_HID_SENSOR_ALS=m
> CONFIG_HID_SENSOR_PROX=m
> # CONFIG_JSA1212 is not set
> # CONFIG_RPR0521 is not set
> # CONFIG_LTR501 is not set
> # CONFIG_LV0104CS is not set
> CONFIG_MAX44000=m
> CONFIG_MAX44009=m
> CONFIG_NOA1305=m
> CONFIG_OPT3001=m
> CONFIG_PA12203001=m
> CONFIG_SI1133=m
> CONFIG_SI1145=m
> CONFIG_STK3310=m
> CONFIG_ST_UVIS25=m
> CONFIG_ST_UVIS25_I2C=m
> CONFIG_ST_UVIS25_SPI=m
> # CONFIG_TCS3414 is not set
> # CONFIG_TCS3472 is not set
> CONFIG_SENSORS_TSL2563=m
> CONFIG_TSL2583=m
> CONFIG_TSL2591=m
> CONFIG_TSL2772=m
> CONFIG_TSL4531=m
> CONFIG_US5182D=m
> CONFIG_VCNL4000=m
> CONFIG_VCNL4035=m
> # CONFIG_VEML6030 is not set
> CONFIG_VEML6070=m
> # CONFIG_VL6180 is not set
> CONFIG_ZOPT2201=m
> # end of Light sensors
> 
> #
> # Magnetometer sensors
> #
> CONFIG_AK8975=m
> CONFIG_AK09911=m
> CONFIG_BMC150_MAGN=m
> # CONFIG_BMC150_MAGN_I2C is not set
> CONFIG_BMC150_MAGN_SPI=m
> CONFIG_MAG3110=m
> # CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
> CONFIG_MMC35240=m
> # CONFIG_IIO_ST_MAGN_3AXIS is not set
> CONFIG_SENSORS_HMC5843=m
> CONFIG_SENSORS_HMC5843_I2C=m
> CONFIG_SENSORS_HMC5843_SPI=m
> CONFIG_SENSORS_RM3100=m
> CONFIG_SENSORS_RM3100_I2C=m
> CONFIG_SENSORS_RM3100_SPI=m
> # CONFIG_YAMAHA_YAS530 is not set
> # end of Magnetometer sensors
> 
> #
> # Multiplexers
> #
> # end of Multiplexers
> 
> #
> # Inclinometer sensors
> #
> CONFIG_HID_SENSOR_INCLINOMETER_3D=m
> CONFIG_HID_SENSOR_DEVICE_ROTATION=m
> # end of Inclinometer sensors
> 
> #
> # Triggers - standalone
> #
> CONFIG_IIO_INTERRUPT_TRIGGER=m
> CONFIG_IIO_SYSFS_TRIGGER=m
> # end of Triggers - standalone
> 
> #
> # Linear and angular position sensors
> #
> CONFIG_IQS624_POS=m
> CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=m
> # end of Linear and angular position sensors
> 
> #
> # Digital potentiometers
> #
> # CONFIG_AD5110 is not set
> # CONFIG_AD5272 is not set
> CONFIG_DS1803=m
> CONFIG_MAX5432=m
> CONFIG_MAX5481=m
> CONFIG_MAX5487=m
> # CONFIG_MCP4018 is not set
> # CONFIG_MCP4131 is not set
> CONFIG_MCP4531=m
> CONFIG_MCP41010=m
> # CONFIG_TPL0102 is not set
> # end of Digital potentiometers
> 
> #
> # Digital potentiostats
> #
> # CONFIG_LMP91000 is not set
> # end of Digital potentiostats
> 
> #
> # Pressure sensors
> #
> # CONFIG_ABP060MG is not set
> # CONFIG_BMP280 is not set
> CONFIG_DLHL60D=m
> # CONFIG_DPS310 is not set
> CONFIG_HID_SENSOR_PRESS=m
> # CONFIG_HP03 is not set
> CONFIG_ICP10100=m
> CONFIG_MPL115=m
> CONFIG_MPL115_I2C=m
> # CONFIG_MPL115_SPI is not set
> CONFIG_MPL3115=m
> CONFIG_MS5611=m
> CONFIG_MS5611_I2C=m
> CONFIG_MS5611_SPI=m
> CONFIG_MS5637=m
> CONFIG_IIO_ST_PRESS=m
> CONFIG_IIO_ST_PRESS_I2C=m
> CONFIG_IIO_ST_PRESS_SPI=m
> CONFIG_T5403=m
> # CONFIG_HP206C is not set
> CONFIG_ZPA2326=m
> CONFIG_ZPA2326_I2C=m
> CONFIG_ZPA2326_SPI=m
> # end of Pressure sensors
> 
> #
> # Lightning sensors
> #
> CONFIG_AS3935=m
> # end of Lightning sensors
> 
> #
> # Proximity and distance sensors
> #
> # CONFIG_CROS_EC_MKBP_PROXIMITY is not set
> # CONFIG_ISL29501 is not set
> CONFIG_LIDAR_LITE_V2=m
> CONFIG_MB1232=m
> # CONFIG_PING is not set
> CONFIG_RFD77402=m
> CONFIG_SRF04=m
> CONFIG_SX9310=m
> CONFIG_SX9500=m
> CONFIG_SRF08=m
> CONFIG_VCNL3020=m
> CONFIG_VL53L0X_I2C=m
> # end of Proximity and distance sensors
> 
> #
> # Resolver to digital converters
> #
> CONFIG_AD2S90=m
> CONFIG_AD2S1200=m
> # end of Resolver to digital converters
> 
> #
> # Temperature sensors
> #
> CONFIG_IQS620AT_TEMP=m
> # CONFIG_LTC2983 is not set
> CONFIG_MAXIM_THERMOCOUPLE=m
> # CONFIG_HID_SENSOR_TEMP is not set
> CONFIG_MLX90614=m
> CONFIG_MLX90632=m
> CONFIG_TMP006=m
> CONFIG_TMP007=m
> CONFIG_TMP117=m
> CONFIG_TSYS01=m
> CONFIG_TSYS02D=m
> CONFIG_MAX31856=m
> CONFIG_MAX31865=m
> # end of Temperature sensors
> 
> # CONFIG_NTB is not set
> # CONFIG_VME_BUS is not set
> # CONFIG_PWM is not set
> 
> #
> # IRQ chip support
> #
> CONFIG_MADERA_IRQ=m
> # end of IRQ chip support
> 
> CONFIG_IPACK_BUS=y
> CONFIG_BOARD_TPCI200=m
> CONFIG_SERIAL_IPOCTAL=m
> CONFIG_RESET_CONTROLLER=y
> CONFIG_RESET_TI_SYSCON=y
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> # CONFIG_USB_LGM_PHY is not set
> CONFIG_PHY_CAN_TRANSCEIVER=y
> 
> #
> # PHY drivers for Broadcom platforms
> #
> CONFIG_BCM_KONA_USB2_PHY=y
> # end of PHY drivers for Broadcom platforms
> 
> CONFIG_PHY_PXA_28NM_HSIC=y
> CONFIG_PHY_PXA_28NM_USB2=y
> # CONFIG_PHY_CPCAP_USB is not set
> CONFIG_PHY_INTEL_LGM_EMMC=y
> # end of PHY Subsystem
> 
> CONFIG_POWERCAP=y
> CONFIG_INTEL_RAPL_CORE=y
> CONFIG_INTEL_RAPL=y
> # CONFIG_IDLE_INJECT is not set
> # CONFIG_DTPM is not set
> CONFIG_MCB=y
> CONFIG_MCB_PCI=y
> # CONFIG_MCB_LPC is not set
> 
> #
> # Performance monitor support
> #
> # end of Performance monitor support
> 
> CONFIG_RAS=y
> CONFIG_RAS_CEC=y
> CONFIG_RAS_CEC_DEBUG=y
> CONFIG_USB4=y
> # CONFIG_USB4_DEBUGFS_WRITE is not set
> # CONFIG_USB4_DMA_TEST is not set
> 
> #
> # Android
> #
> CONFIG_ANDROID=y
> # CONFIG_ANDROID_BINDER_IPC is not set
> # end of Android
> 
> CONFIG_LIBNVDIMM=y
> CONFIG_BLK_DEV_PMEM=m
> # CONFIG_ND_BLK is not set
> CONFIG_ND_CLAIM=y
> CONFIG_ND_BTT=m
> CONFIG_BTT=y
> CONFIG_NVDIMM_KEYS=y
> CONFIG_DAX=y
> CONFIG_NVMEM=y
> CONFIG_NVMEM_SYSFS=y
> CONFIG_RAVE_SP_EEPROM=m
> # CONFIG_NVMEM_RMEM is not set
> 
> #
> # HW tracing support
> #
> CONFIG_STM=m
> CONFIG_STM_PROTO_BASIC=m
> CONFIG_STM_PROTO_SYS_T=m
> CONFIG_STM_DUMMY=m
> # CONFIG_STM_SOURCE_CONSOLE is not set
> CONFIG_STM_SOURCE_HEARTBEAT=m
> # CONFIG_STM_SOURCE_FTRACE is not set
> # CONFIG_INTEL_TH is not set
> # end of HW tracing support
> 
> CONFIG_FPGA=y
> CONFIG_ALTERA_PR_IP_CORE=y
> # CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
> # CONFIG_FPGA_MGR_ALTERA_CVP is not set
> # CONFIG_FPGA_MGR_XILINX_SPI is not set
> CONFIG_FPGA_MGR_MACHXO2_SPI=y
> CONFIG_FPGA_BRIDGE=m
> CONFIG_ALTERA_FREEZE_BRIDGE=m
> CONFIG_XILINX_PR_DECOUPLER=m
> CONFIG_FPGA_REGION=m
> CONFIG_FPGA_DFL=m
> CONFIG_FPGA_DFL_FME=m
> CONFIG_FPGA_DFL_FME_MGR=m
> CONFIG_FPGA_DFL_FME_BRIDGE=m
> CONFIG_FPGA_DFL_FME_REGION=m
> CONFIG_FPGA_DFL_AFU=m
> # CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000 is not set
> # CONFIG_FPGA_DFL_PCI is not set
> CONFIG_TEE=m
> 
> #
> # TEE drivers
> #
> # end of TEE drivers
> 
> CONFIG_MULTIPLEXER=m
> 
> #
> # Multiplexer drivers
> #
> # CONFIG_MUX_ADG792A is not set
> # CONFIG_MUX_ADGS1408 is not set
> CONFIG_MUX_GPIO=m
> # end of Multiplexer drivers
> 
> CONFIG_PM_OPP=y
> # CONFIG_SIOX is not set
> CONFIG_SLIMBUS=y
> CONFIG_SLIM_QCOM_CTRL=m
> CONFIG_INTERCONNECT=y
> CONFIG_COUNTER=m
> CONFIG_INTERRUPT_CNT=m
> # CONFIG_INTEL_QEP is not set
> CONFIG_MOST=y
> CONFIG_MOST_CDEV=y
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_IOMAP=y
> CONFIG_EXT2_FS=m
> # CONFIG_EXT2_FS_XATTR is not set
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> # CONFIG_EXT4_FS_SECURITY is not set
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=y
> CONFIG_JBD2_DEBUG=y
> CONFIG_FS_MBCACHE=y
> CONFIG_REISERFS_FS=m
> # CONFIG_REISERFS_CHECK is not set
> CONFIG_REISERFS_PROC_INFO=y
> CONFIG_REISERFS_FS_XATTR=y
> # CONFIG_REISERFS_FS_POSIX_ACL is not set
> # CONFIG_REISERFS_FS_SECURITY is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_XFS_FS is not set
> CONFIG_GFS2_FS=y
> # CONFIG_OCFS2_FS is not set
> # CONFIG_BTRFS_FS is not set
> CONFIG_NILFS2_FS=m
> # CONFIG_F2FS_FS is not set
> CONFIG_ZONEFS_FS=y
> CONFIG_FS_DAX=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_EXPORTFS_BLOCK_OPS=y
> CONFIG_FILE_LOCKING=y
> CONFIG_FS_ENCRYPTION=y
> CONFIG_FS_ENCRYPTION_ALGS=y
> CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
> CONFIG_FS_VERITY=y
> CONFIG_FS_VERITY_DEBUG=y
> CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
> CONFIG_FSNOTIFY=y
> # CONFIG_DNOTIFY is not set
> CONFIG_INOTIFY_USER=y
> CONFIG_FANOTIFY=y
> # CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
> # CONFIG_QUOTA is not set
> # CONFIG_QUOTA_NETLINK_INTERFACE is not set
> CONFIG_QUOTACTL=y
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_AUTOFS_FS is not set
> CONFIG_FUSE_FS=m
> CONFIG_CUSE=m
> CONFIG_VIRTIO_FS=m
> CONFIG_FUSE_DAX=y
> # CONFIG_OVERLAY_FS is not set
> 
> #
> # Caches
> #
> # CONFIG_FSCACHE is not set
> # end of Caches
> 
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> CONFIG_UDF_FS=y
> # end of CD-ROM/DVD Filesystems
> 
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> # CONFIG_MSDOS_FS is not set
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> CONFIG_EXFAT_FS=y
> CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
> CONFIG_NTFS_FS=y
> # CONFIG_NTFS_DEBUG is not set
> CONFIG_NTFS_RW=y
> CONFIG_NTFS3_FS=m
> CONFIG_NTFS3_LZX_XPRESS=y
> CONFIG_NTFS3_FS_POSIX_ACL=y
> # end of DOS/FAT/EXFAT/NT Filesystems
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> # CONFIG_PROC_VMCORE is not set
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> CONFIG_PROC_CHILDREN=y
> CONFIG_PROC_PID_ARCH_STATUS=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_TMPFS_POSIX_ACL is not set
> CONFIG_TMPFS_XATTR=y
> # CONFIG_HUGETLBFS is not set
> CONFIG_MEMFD_CREATE=y
> CONFIG_CONFIGFS_FS=y
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> CONFIG_ORANGEFS_FS=y
> CONFIG_ADFS_FS=y
> # CONFIG_ADFS_FS_RW is not set
> CONFIG_AFFS_FS=y
> CONFIG_ECRYPT_FS=m
> CONFIG_ECRYPT_FS_MESSAGING=y
> CONFIG_HFS_FS=y
> CONFIG_HFSPLUS_FS=y
> CONFIG_BEFS_FS=m
> CONFIG_BEFS_DEBUG=y
> CONFIG_BFS_FS=m
> # CONFIG_EFS_FS is not set
> # CONFIG_JFFS2_FS is not set
> # CONFIG_UBIFS_FS is not set
> CONFIG_CRAMFS=y
> CONFIG_CRAMFS_BLOCKDEV=y
> CONFIG_SQUASHFS=m
> # CONFIG_SQUASHFS_FILE_CACHE is not set
> CONFIG_SQUASHFS_FILE_DIRECT=y
> CONFIG_SQUASHFS_DECOMP_SINGLE=y
> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> # CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
> CONFIG_SQUASHFS_XATTR=y
> # CONFIG_SQUASHFS_ZLIB is not set
> # CONFIG_SQUASHFS_LZ4 is not set
> # CONFIG_SQUASHFS_LZO is not set
> CONFIG_SQUASHFS_XZ=y
> # CONFIG_SQUASHFS_ZSTD is not set
> CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> CONFIG_VXFS_FS=m
> CONFIG_MINIX_FS=y
> CONFIG_OMFS_FS=y
> # CONFIG_HPFS_FS is not set
> CONFIG_QNX4FS_FS=y
> CONFIG_QNX6FS_FS=y
> CONFIG_QNX6FS_DEBUG=y
> # CONFIG_ROMFS_FS is not set
> # CONFIG_PSTORE is not set
> CONFIG_SYSV_FS=m
> CONFIG_UFS_FS=m
> CONFIG_UFS_FS_WRITE=y
> # CONFIG_UFS_DEBUG is not set
> CONFIG_EROFS_FS=y
> CONFIG_EROFS_FS_DEBUG=y
> CONFIG_EROFS_FS_XATTR=y
> CONFIG_EROFS_FS_POSIX_ACL=y
> # CONFIG_EROFS_FS_SECURITY is not set
> CONFIG_EROFS_FS_ZIP=y
> CONFIG_EROFS_FS_ZIP_LZMA=y
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V2=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> CONFIG_NFS_V4=m
> # CONFIG_NFS_SWAP is not set
> # CONFIG_NFS_V4_1 is not set
> # CONFIG_ROOT_NFS is not set
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=y
> CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> # CONFIG_NFSD is not set
> CONFIG_GRACE_PERIOD=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=m
> # CONFIG_SUNRPC_DEBUG is not set
> # CONFIG_CEPH_FS is not set
> CONFIG_CIFS=m
> CONFIG_CIFS_STATS2=y
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
> # CONFIG_CIFS_UPCALL is not set
> # CONFIG_CIFS_XATTR is not set
> CONFIG_CIFS_DEBUG=y
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> # CONFIG_CIFS_DFS_UPCALL is not set
> # CONFIG_CIFS_SWN_UPCALL is not set
> # CONFIG_SMB_SERVER is not set
> CONFIG_SMBFS_COMMON=m
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> # CONFIG_NLS_CODEPAGE_437 is not set
> # CONFIG_NLS_CODEPAGE_737 is not set
> CONFIG_NLS_CODEPAGE_775=m
> CONFIG_NLS_CODEPAGE_850=m
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> CONFIG_NLS_CODEPAGE_857=y
> CONFIG_NLS_CODEPAGE_860=m
> CONFIG_NLS_CODEPAGE_861=y
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> CONFIG_NLS_CODEPAGE_865=m
> CONFIG_NLS_CODEPAGE_866=m
> # CONFIG_NLS_CODEPAGE_869 is not set
> CONFIG_NLS_CODEPAGE_936=m
> CONFIG_NLS_CODEPAGE_950=m
> CONFIG_NLS_CODEPAGE_932=y
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> CONFIG_NLS_ISO8859_8=m
> # CONFIG_NLS_CODEPAGE_1250 is not set
> CONFIG_NLS_CODEPAGE_1251=y
> # CONFIG_NLS_ASCII is not set
> # CONFIG_NLS_ISO8859_1 is not set
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> CONFIG_NLS_ISO8859_6=y
> CONFIG_NLS_ISO8859_7=y
> # CONFIG_NLS_ISO8859_9 is not set
> CONFIG_NLS_ISO8859_13=y
> CONFIG_NLS_ISO8859_14=m
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> CONFIG_NLS_KOI8_U=y
> CONFIG_NLS_MAC_ROMAN=y
> CONFIG_NLS_MAC_CELTIC=m
> CONFIG_NLS_MAC_CENTEURO=y
> CONFIG_NLS_MAC_CROATIAN=y
> CONFIG_NLS_MAC_CYRILLIC=y
> CONFIG_NLS_MAC_GAELIC=y
> # CONFIG_NLS_MAC_GREEK is not set
> CONFIG_NLS_MAC_ICELAND=y
> # CONFIG_NLS_MAC_INUIT is not set
> CONFIG_NLS_MAC_ROMANIAN=m
> CONFIG_NLS_MAC_TURKISH=y
> CONFIG_NLS_UTF8=y
> # CONFIG_DLM is not set
> CONFIG_UNICODE=y
> CONFIG_UNICODE_UTF8_DATA=y
> # CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
> CONFIG_IO_WQ=y
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> # CONFIG_KEYS_REQUEST_CACHE is not set
> CONFIG_PERSISTENT_KEYRINGS=y
> CONFIG_BIG_KEYS=y
> # CONFIG_TRUSTED_KEYS is not set
> CONFIG_ENCRYPTED_KEYS=y
> # CONFIG_KEY_DH_OPERATIONS is not set
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_SECURITY=y
> CONFIG_SECURITYFS=y
> CONFIG_SECURITY_NETWORK=y
> CONFIG_PAGE_TABLE_ISOLATION=y
> # CONFIG_SECURITY_PATH is not set
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> CONFIG_FORTIFY_SOURCE=y
> CONFIG_STATIC_USERMODEHELPER=y
> CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> # CONFIG_SECURITY_APPARMOR is not set
> # CONFIG_SECURITY_LOADPIN is not set
> CONFIG_SECURITY_YAMA=y
> # CONFIG_SECURITY_SAFESETID is not set
> # CONFIG_SECURITY_LOCKDOWN_LSM is not set
> # CONFIG_SECURITY_LANDLOCK is not set
> CONFIG_INTEGRITY=y
> CONFIG_INTEGRITY_SIGNATURE=y
> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
> # CONFIG_INTEGRITY_TRUSTED_KEYRING is not set
> # CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
> # CONFIG_IMA is not set
> # CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
> # CONFIG_EVM is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"
> 
> #
> # Kernel hardening options
> #
> 
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=y
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> CONFIG_INIT_ON_FREE_DEFAULT_ON=y
> # end of Memory initialization
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_XOR_BLOCKS=y
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_SKCIPHER=y
> CONFIG_CRYPTO_SKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> CONFIG_CRYPTO_CRYPTD=y
> CONFIG_CRYPTO_AUTHENC=y
> # CONFIG_CRYPTO_TEST is not set
> CONFIG_CRYPTO_SIMD=y
> 
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> # CONFIG_CRYPTO_DH is not set
> CONFIG_CRYPTO_ECC=y
> # CONFIG_CRYPTO_ECDH is not set
> CONFIG_CRYPTO_ECDSA=y
> # CONFIG_CRYPTO_ECRDSA is not set
> # CONFIG_CRYPTO_SM2 is not set
> # CONFIG_CRYPTO_CURVE25519 is not set
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=m
> CONFIG_CRYPTO_GCM=y
> CONFIG_CRYPTO_CHACHA20POLY1305=m
> CONFIG_CRYPTO_AEGIS128=y
> # CONFIG_CRYPTO_SEQIV is not set
> # CONFIG_CRYPTO_ECHAINIV is not set
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CFB=y
> CONFIG_CRYPTO_CTR=y
> # CONFIG_CRYPTO_CTS is not set
> CONFIG_CRYPTO_ECB=m
> CONFIG_CRYPTO_LRW=m
> CONFIG_CRYPTO_OFB=y
> CONFIG_CRYPTO_PCBC=m
> # CONFIG_CRYPTO_XTS is not set
> # CONFIG_CRYPTO_KEYWRAP is not set
> CONFIG_CRYPTO_NHPOLY1305=y
> CONFIG_CRYPTO_ADIANTUM=y
> CONFIG_CRYPTO_ESSIV=y
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=y
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_XCBC=m
> # CONFIG_CRYPTO_VMAC is not set
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> # CONFIG_CRYPTO_CRC32C_INTEL is not set
> CONFIG_CRYPTO_CRC32=m
> CONFIG_CRYPTO_CRC32_PCLMUL=m
> # CONFIG_CRYPTO_XXHASH is not set
> # CONFIG_CRYPTO_BLAKE2B is not set
> # CONFIG_CRYPTO_BLAKE2S is not set
> CONFIG_CRYPTO_CRCT10DIF=m
> CONFIG_CRYPTO_GHASH=y
> CONFIG_CRYPTO_POLY1305=m
> CONFIG_CRYPTO_MD4=m
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_MICHAEL_MIC=y
> CONFIG_CRYPTO_RMD160=m
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> # CONFIG_CRYPTO_SHA3 is not set
> CONFIG_CRYPTO_SM3=m
> CONFIG_CRYPTO_STREEBOG=y
> # CONFIG_CRYPTO_WP512 is not set
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_AES_TI=m
> CONFIG_CRYPTO_AES_NI_INTEL=y
> CONFIG_CRYPTO_BLOWFISH=m
> CONFIG_CRYPTO_BLOWFISH_COMMON=m
> # CONFIG_CRYPTO_CAMELLIA is not set
> CONFIG_CRYPTO_CAST_COMMON=y
> CONFIG_CRYPTO_CAST5=m
> CONFIG_CRYPTO_CAST6=y
> CONFIG_CRYPTO_DES=y
> CONFIG_CRYPTO_FCRYPT=y
> CONFIG_CRYPTO_CHACHA20=y
> # CONFIG_CRYPTO_SERPENT is not set
> # CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
> # CONFIG_CRYPTO_SM4 is not set
> CONFIG_CRYPTO_TWOFISH=y
> CONFIG_CRYPTO_TWOFISH_COMMON=y
> CONFIG_CRYPTO_TWOFISH_586=y
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=m
> CONFIG_CRYPTO_LZO=y
> CONFIG_CRYPTO_842=y
> CONFIG_CRYPTO_LZ4=y
> # CONFIG_CRYPTO_LZ4HC is not set
> # CONFIG_CRYPTO_ZSTD is not set
> 
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=m
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> CONFIG_CRYPTO_DRBG_HASH=y
> # CONFIG_CRYPTO_DRBG_CTR is not set
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> # CONFIG_CRYPTO_USER_API_RNG is not set
> # CONFIG_CRYPTO_USER_API_AEAD is not set
> CONFIG_CRYPTO_HASH_INFO=y
> # CONFIG_CRYPTO_HW is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_X509_CERTIFICATE_PARSER=y
> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
> CONFIG_PKCS7_MESSAGE_PARSER=y
> # CONFIG_PKCS7_TEST_KEY is not set
> # CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
> 
> #
> # Certificates for signature checking
> #
> CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
> CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
> # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> CONFIG_SECONDARY_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> CONFIG_SYSTEM_REVOCATION_LIST=y
> CONFIG_SYSTEM_REVOCATION_KEYS=""
> # end of Certificates for signature checking
> 
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> CONFIG_LINEAR_RANGES=y
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_CORDIC=y
> CONFIG_PRIME_NUMBERS=y
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_AES=y
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> CONFIG_CRYPTO_LIB_CHACHA=y
> CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
> CONFIG_CRYPTO_LIB_CURVE25519=m
> CONFIG_CRYPTO_LIB_DES=y
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> CONFIG_CRYPTO_LIB_POLY1305=y
> CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
> CONFIG_CRYPTO_LIB_SHA256=y
> # end of Crypto library routines
> 
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=m
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> # CONFIG_CRC32_SLICEBY8 is not set
> CONFIG_CRC32_SLICEBY4=y
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> # CONFIG_CRC64 is not set
> CONFIG_CRC4=m
> # CONFIG_CRC7 is not set
> CONFIG_LIBCRC32C=y
> CONFIG_CRC8=y
> CONFIG_XXHASH=y
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_842_COMPRESS=y
> CONFIG_842_DECOMPRESS=y
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_COMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> CONFIG_XZ_DEC_ARM=y
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_SPARC=y
> CONFIG_XZ_DEC_MICROLZMA=y
> CONFIG_XZ_DEC_BCJ=y
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_DECOMPRESS_ZSTD=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_REED_SOLOMON=m
> CONFIG_REED_SOLOMON_DEC16=y
> CONFIG_BCH=m
> CONFIG_INTERVAL_TREE=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_DMA_OPS=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_SWIOTLB=y
> CONFIG_DMA_CMA=y
> CONFIG_DMA_PERNUMA_CMA=y
> 
> #
> # Default contiguous memory area size:
> #
> CONFIG_CMA_SIZE_MBYTES=0
> CONFIG_CMA_SIZE_PERCENTAGE=0
> # CONFIG_CMA_SIZE_SEL_MBYTES is not set
> # CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
> # CONFIG_CMA_SIZE_SEL_MIN is not set
> CONFIG_CMA_SIZE_SEL_MAX=y
> CONFIG_CMA_ALIGNMENT=8
> # CONFIG_DMA_API_DEBUG is not set
> CONFIG_DMA_MAP_BENCHMARK=y
> CONFIG_SGL_ALLOC=y
> CONFIG_CHECK_SIGNATURE=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> # CONFIG_IRQ_POLL is not set
> CONFIG_MPILIB=y
> CONFIG_SIGNATURE=y
> CONFIG_OID_REGISTRY=y
> CONFIG_HAVE_GENERIC_VDSO=y
> CONFIG_GENERIC_GETTIMEOFDAY=y
> CONFIG_GENERIC_VDSO_32=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> CONFIG_FONT_SUPPORT=y
> CONFIG_FONTS=y
> # CONFIG_FONT_8x8 is not set
> CONFIG_FONT_8x16=y
> # CONFIG_FONT_6x11 is not set
> # CONFIG_FONT_7x14 is not set
> # CONFIG_FONT_PEARL_8x8 is not set
> # CONFIG_FONT_ACORN_8x8 is not set
> # CONFIG_FONT_MINI_4x6 is not set
> # CONFIG_FONT_6x10 is not set
> # CONFIG_FONT_10x18 is not set
> CONFIG_FONT_SUN8x16=y
> CONFIG_FONT_SUN12x22=y
> CONFIG_FONT_TER16x32=y
> CONFIG_FONT_6x8=y
> CONFIG_SG_POOL=y
> CONFIG_MEMREGION=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_STACKDEPOT=y
> CONFIG_STACK_HASH_ORDER=20
> CONFIG_SBITMAP=y
> # end of Library routines
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_PRINTK_CALLER=y
> CONFIG_STACKTRACE_BUILD_ID=y
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> CONFIG_BOOT_PRINTK_DELAY=y
> # CONFIG_DYNAMIC_DEBUG is not set
> # CONFIG_DYNAMIC_DEBUG_CORE is not set
> CONFIG_SYMBOLIC_ERRNAME=y
> CONFIG_DEBUG_BUGVERBOSE=y
> # end of printk and dmesg options
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_INFO_REDUCED=y
> # CONFIG_DEBUG_INFO_COMPRESSED is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_FRAME_WARN=1024
> CONFIG_STRIP_ASM_SYMS=y
> CONFIG_READABLE_ASM=y
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_FRAME_POINTER=y
> CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> # end of Compile-time checks and compiler options
> 
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
> CONFIG_DEBUG_FS=y
> # CONFIG_DEBUG_FS_ALLOW_ALL is not set
> CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_UBSAN=y
> # CONFIG_UBSAN_TRAP is not set
> CONFIG_CC_HAS_UBSAN_BOUNDS=y
> CONFIG_UBSAN_BOUNDS=y
> CONFIG_UBSAN_ONLY_BOUNDS=y
> CONFIG_UBSAN_SHIFT=y
> # CONFIG_UBSAN_DIV_ZERO is not set
> # CONFIG_UBSAN_UNREACHABLE is not set
> # CONFIG_UBSAN_BOOL is not set
> # CONFIG_UBSAN_ENUM is not set
> # CONFIG_UBSAN_ALIGNMENT is not set
> CONFIG_UBSAN_SANITIZE_ALL=y
> # CONFIG_TEST_UBSAN is not set
> # end of Generic Kernel Debugging Instruments
> 
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_MISC=y
> 
> #
> # Networking Debugging
> #
> # CONFIG_NET_DEV_REFCNT_TRACKER is not set
> # CONFIG_NET_NS_REFCNT_TRACKER is not set
> # end of Networking Debugging
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_PAGE_OWNER is not set
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=y
> # CONFIG_DEBUG_WX is not set
> CONFIG_GENERIC_PTDUMP=y
> # CONFIG_PTDUMP_DEBUGFS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> CONFIG_SLUB_DEBUG_ON=y
> # CONFIG_SLUB_STATS is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> CONFIG_DEBUG_STACK_USAGE=y
> # CONFIG_SCHED_STACK_END_CHECK is not set
> CONFIG_DEBUG_VM=y
> # CONFIG_DEBUG_VM_VMACACHE is not set
> # CONFIG_DEBUG_VM_RB is not set
> # CONFIG_DEBUG_VM_PGFLAGS is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> # CONFIG_DEBUG_VIRTUAL is not set
> CONFIG_DEBUG_MEMORY_INIT=y
> CONFIG_DEBUG_KMAP_LOCAL=y
> CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
> # CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
> # CONFIG_DEBUG_HIGHMEM is not set
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> CONFIG_HAVE_ARCH_KFENCE=y
> CONFIG_KFENCE=y
> CONFIG_KFENCE_SAMPLE_INTERVAL=100
> CONFIG_KFENCE_NUM_OBJECTS=255
> CONFIG_KFENCE_STRESS_TEST_FAULTS=0
> # end of Memory Debugging
> 
> CONFIG_DEBUG_SHIRQ=y
> 
> #
> # Debug Oops, Lockups and Hangs
> #
> CONFIG_PANIC_ON_OOPS=y
> CONFIG_PANIC_ON_OOPS_VALUE=1
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> # CONFIG_HARDLOCKUP_DETECTOR is not set
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
> CONFIG_WQ_WATCHDOG=y
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
> 
> #
> # Scheduler Debugging
> #
> # CONFIG_SCHED_DEBUG is not set
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> # end of Scheduler Debugging
> 
> CONFIG_DEBUG_TIMEKEEPING=y
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> CONFIG_PROVE_LOCKING=y
> # CONFIG_PROVE_RAW_LOCK_NESTING is not set
> # CONFIG_LOCK_STAT is not set
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> CONFIG_DEBUG_RWSEMS=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_LOCKDEP=y
> CONFIG_LOCKDEP_BITS=15
> CONFIG_LOCKDEP_CHAINS_BITS=16
> CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> # CONFIG_DEBUG_LOCKDEP is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> CONFIG_LOCK_TORTURE_TEST=m
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_TRACE_IRQFLAGS_NMI=y
> CONFIG_DEBUG_IRQFLAGS=y
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> 
> #
> # Debug kernel data structures
> #
> CONFIG_DEBUG_LIST=y
> # CONFIG_DEBUG_PLIST is not set
> CONFIG_DEBUG_SG=y
> # CONFIG_DEBUG_NOTIFIERS is not set
> CONFIG_BUG_ON_DATA_CORRUPTION=y
> # end of Debug kernel data structures
> 
> CONFIG_DEBUG_CREDENTIALS=y
> 
> #
> # RCU Debugging
> #
> CONFIG_PROVE_RCU=y
> CONFIG_TORTURE_TEST=m
> CONFIG_RCU_SCALE_TEST=m
> CONFIG_RCU_TORTURE_TEST=m
> # CONFIG_RCU_REF_SCALE_TEST is not set
> # CONFIG_RCU_TRACE is not set
> CONFIG_RCU_EQS_DEBUG=y
> # end of RCU Debugging
> 
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> CONFIG_LATENCYTOP=y
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_BUILDTIME_MCOUNT_SORT=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_PREEMPTIRQ_TRACEPOINTS=y
> CONFIG_TRACING=y
> CONFIG_TRACING_SUPPORT=y
> # CONFIG_FTRACE is not set
> CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
> CONFIG_SAMPLES=y
> CONFIG_SAMPLE_AUXDISPLAY=y
> # CONFIG_SAMPLE_TRACE_EVENTS is not set
> # CONFIG_SAMPLE_TRACE_PRINTK is not set
> # CONFIG_SAMPLE_TRACE_ARRAY is not set
> # CONFIG_SAMPLE_KOBJECT is not set
> CONFIG_SAMPLE_KPROBES=m
> CONFIG_SAMPLE_KRETPROBES=m
> CONFIG_SAMPLE_HW_BREAKPOINT=m
> # CONFIG_SAMPLE_KFIFO is not set
> # CONFIG_SAMPLE_RPMSG_CLIENT is not set
> CONFIG_SAMPLE_CONFIGFS=m
> # CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
> # CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
> # CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
> CONFIG_SAMPLE_VFIO_MDEV_MBOCHS=m
> # CONFIG_SAMPLE_WATCHDOG is not set
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> # CONFIG_STRICT_DEVMEM is not set
> 
> #
> # x86 Debugging
> #
> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
> CONFIG_EARLY_PRINTK_USB=y
> CONFIG_X86_VERBOSE_BOOTUP=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_EARLY_PRINTK_DBGP=y
> CONFIG_EARLY_PRINTK_USB_XDBC=y
> CONFIG_DEBUG_TLBFLUSH=y
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> # CONFIG_X86_DECODER_SELFTEST is not set
> CONFIG_IO_DELAY_0X80=y
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEBUG_BOOT_PARAMS=y
> # CONFIG_CPA_DEBUG is not set
> CONFIG_DEBUG_ENTRY=y
> CONFIG_X86_DEBUG_FPU=y
> CONFIG_PUNIT_ATOM_DEBUG=m
> CONFIG_UNWINDER_FRAME_POINTER=y
> # end of x86 Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> CONFIG_NOTIFIER_ERROR_INJECTION=y
> # CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
> # CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
> CONFIG_FUNCTION_ERROR_INJECTION=y
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> # CONFIG_RUNTIME_TESTING_MENU is not set
> CONFIG_ARCH_USE_MEMTEST=y
> CONFIG_MEMTEST=y
> # end of Kernel Testing and Coverage
> # end of Kernel hacking

> #!/bin/sh
> 
> export_top_env()
> {
> 	export suite='boot'
> 	export testcase='boot'
> 	export category='functional'
> 	export timeout='10m'
> 	export job_origin='boot.yaml'
> 	export queue_cmdline_keys='branch
> commit'
> 	export queue='bisect'
> 	export testbox='vm-snb-115'
> 	export tbox_group='vm-snb'
> 	export branch='linux-devel/devel-hourly-20220307-175616'
> 	export commit='ae107fa91914f098cd54ab77e68f83dd6259e901'
> 	export kconfig='i386-randconfig-a003-20220307'
> 	export nr_vm=160
> 	export submit_id='62275a9928b0c1b9dc62fb4e'
> 	export job_file='/lkp/jobs/scheduled/vm-snb-115/boot-1-debian-i386-20191205.cgz-ae107fa91914f098cd54ab77e68f83dd6259e901-20220308-47580-1l9smxf-2.yaml'
> 	export id='5828da01136d5f9f1f59f5f03d9ab388281784b7'
> 	export queuer_version='/lkp-src'
> 	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
> 	export nr_cpu=2
> 	export memory='16G'
> 	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
> 	export ssh_base_port=23032
> 	export kernel_cmdline='vmalloc=128M initramfs_async=0 page_owner=on'
> 	export rootfs='debian-i386-20191205.cgz'
> 	export compiler='gcc-9'
> 	export enqueue_time='2022-03-08 21:31:06 +0800'
> 	export _id='62275e3f28b0c1b9dc62fb50'
> 	export _rt='/result/boot/1/vm-snb/debian-i386-20191205.cgz/i386-randconfig-a003-20220307/gcc-9/ae107fa91914f098cd54ab77e68f83dd6259e901'
> 	export user='lkp'
> 	export LKP_SERVER='internal-lkp-server'
> 	export result_root='/result/boot/1/vm-snb/debian-i386-20191205.cgz/i386-randconfig-a003-20220307/gcc-9/ae107fa91914f098cd54ab77e68f83dd6259e901/3'
> 	export scheduler_version='/lkp/lkp/.src-20220308-102049'
> 	export arch='i386'
> 	export max_uptime=600
> 	export initrd='/osimage/debian/debian-i386-20191205.cgz'
> 	export bootloader_append='root=/dev/ram0
> RESULT_ROOT=/result/boot/1/vm-snb/debian-i386-20191205.cgz/i386-randconfig-a003-20220307/gcc-9/ae107fa91914f098cd54ab77e68f83dd6259e901/3
> BOOT_IMAGE=/pkg/linux/i386-randconfig-a003-20220307/gcc-9/ae107fa91914f098cd54ab77e68f83dd6259e901/vmlinuz-5.17.0-rc1-00003-gae107fa91914
> branch=linux-devel/devel-hourly-20220307-175616
> job=/lkp/jobs/scheduled/vm-snb-115/boot-1-debian-i386-20191205.cgz-ae107fa91914f098cd54ab77e68f83dd6259e901-20220308-47580-1l9smxf-2.yaml
> user=lkp
> ARCH=i386
> kconfig=i386-randconfig-a003-20220307
> commit=ae107fa91914f098cd54ab77e68f83dd6259e901
> vmalloc=128M initramfs_async=0 page_owner=on
> max_uptime=600
> LKP_SERVER=internal-lkp-server
> selinux=0
> debug
> apic=debug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0
> printk.devkmsg=on
> panic=-1
> softlockup_panic=1
> nmi_watchdog=panic
> oops=panic
> load_ramdisk=2
> prompt_ramdisk=0
> drbd.minor_count=8
> systemd.log_level=err
> ignore_loglevel
> console=tty0
> earlyprintk=ttyS0,115200
> console=ttyS0,115200
> vga=normal
> rw'
> 	export modules_initrd='/pkg/linux/i386-randconfig-a003-20220307/gcc-9/ae107fa91914f098cd54ab77e68f83dd6259e901/modules.cgz'
> 	export bm_initrd='/osimage/deps/debian-i386-20191205.cgz/lkp_20201203.cgz'
> 	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
> 	export site='inn'
> 	export LKP_CGI_PORT=80
> 	export LKP_CIFS_PORT=139
> 	export schedule_notify_address=
> 	export kernel='/pkg/linux/i386-randconfig-a003-20220307/gcc-9/ae107fa91914f098cd54ab77e68f83dd6259e901/vmlinuz-5.17.0-rc1-00003-gae107fa91914'
> 	export dequeue_time='2022-03-08 21:47:36 +0800'
> 	export job_initrd='/lkp/jobs/scheduled/vm-snb-115/boot-1-debian-i386-20191205.cgz-ae107fa91914f098cd54ab77e68f83dd6259e901-20220308-47580-1l9smxf-2.cgz'
> 
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=/lkp/${user:-lkp}/src
> }
> 
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
> 
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
> 
> 	export_top_env
> 
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
> 	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
> 
> 	run_test $LKP_SRC/tests/wrapper sleep 1
> }
> 
> extract_stats()
> {
> 	export stats_part_begin=
> 	export stats_part_end=
> 
> 	$LKP_SRC/stats/wrapper boot-slabinfo
> 	$LKP_SRC/stats/wrapper boot-meminfo
> 	$LKP_SRC/stats/wrapper memmap
> 	$LKP_SRC/stats/wrapper boot-memory
> 	$LKP_SRC/stats/wrapper boot-time
> 	$LKP_SRC/stats/wrapper kernel-size
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper sleep
> 	$LKP_SRC/stats/wrapper meminfo
> 
> 	$LKP_SRC/stats/wrapper time sleep.time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper last_state
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper time
> }
> 
> "$@"


