Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B473246352B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239242AbhK3NPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:15:51 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55782 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbhK3NPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:15:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 664F6CE19FE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 13:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CA8C53FC7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 13:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638277946;
        bh=7Jp5scVEy5mI/G2kiMqwA+jZ6W9F59pkGVYXY6aCCqU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ebp0csiwXCfFkjkSH/kmmBzdS7Xpq5X43oB7pgouteHAOxHFAETknmbrGu8l4ezbV
         /JLTx8BPtfe5bQKJ6ht8DAmwhR6GmgBN7CgmmjWIwrUMxBLk9RObedAclI8/boa6PL
         84lF8aNxn8o3iWU2DmlpW++dwKh2gxnUOHCBoHgb/8FANBaK7ufnvkP8r0rRBsJvJm
         K9ZXFNmoYs/AVforritNuPLvGy/Dj8balwbTIW49w4byJ5YC7yw6KU2sivqalaVOyE
         CaGrg5djHWWD5/pl0IaSaLc/QD8yvX7RjY+VdR9agYqsZvQRGYmBchAmm+hGJJJ5Nv
         DCFZnKh1C6/rQ==
Received: by mail-oo1-f46.google.com with SMTP id w5-20020a4a2745000000b002c2649b8d5fso6677160oow.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:12:26 -0800 (PST)
X-Gm-Message-State: AOAM530ct9qml+e6ora/Pi2N2asAjtULWhw5ZTTzzafGp8arHEbHG3+1
        cQuUiTHnkB/ymRt6tF1prftu5hxHRZGeoHY/TaE=
X-Google-Smtp-Source: ABdhPJwAZ391NHSXEptRBPTPOpfcyKVJmW0+b+XHnPKjZQ/TvLVpV1LohJo16UbYFKDNPEPol8PoCmZJ7ZvVgIuvyWk=
X-Received: by 2002:a4a:a641:: with SMTP id j1mr35370708oom.63.1638277945792;
 Tue, 30 Nov 2021 05:12:25 -0800 (PST)
MIME-Version: 1.0
References: <202111250918.ErFZktQF-lkp@intel.com>
In-Reply-To: <202111250918.ErFZktQF-lkp@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 30 Nov 2021 14:12:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHrRYagSVniSetHdG15rkQS+fm4zVOtN=Zda3W0QaEoJA@mail.gmail.com>
Message-ID: <CAMj1kXHrRYagSVniSetHdG15rkQS+fm4zVOtN=Zda3W0QaEoJA@mail.gmail.com>
Subject: Re: [ardb:for-kernelci 25/25] arch/arm/kernel/traps.c:865:17:
 warning: no previous prototype for function 'handle_bad_stack'
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 at 02:35, kernel test robot <lkp@intel.com> wrote:
>
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git for-kernelci
> head:   5da04a8b7050432b72f6551b6c95e4b5b5fd68d1
> commit: 5da04a8b7050432b72f6551b6c95e4b5b5fd68d1 [25/25] ARM: implement THREAD_INFO_IN_TASK for uniprocessor systems
> config: arm-randconfig-r024-20211124 (https://download.01.org/0day-ci/archive/20211125/202111250918.ErFZktQF-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 67a1c45def8a75061203461ab0060c75c864df1c)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=5da04a8b7050432b72f6551b6c95e4b5b5fd68d1
>         git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
>         git fetch --no-tags ardb for-kernelci
>         git checkout 5da04a8b7050432b72f6551b6c95e4b5b5fd68d1
>         # save the config file to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>

This is yet another false positive. asmlinkage routines don't need a
prototype because they are called from assembler. This is not going to
get fixed, so please don't report this error anymore.



>    arch/arm/kernel/traps.c:95:6: warning: no previous prototype for function 'dump_backtrace_stm' [-Wmissing-prototypes]
>    void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
>         ^
>    arch/arm/kernel/traps.c:95:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
>    ^
>    static
>    arch/arm/kernel/traps.c:446:17: warning: no previous prototype for function 'do_undefinstr' [-Wmissing-prototypes]
>    asmlinkage void do_undefinstr(struct pt_regs *regs)
>                    ^
>    arch/arm/kernel/traps.c:446:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    asmlinkage void do_undefinstr(struct pt_regs *regs)
>               ^
>               static
>    arch/arm/kernel/traps.c:511:39: warning: no previous prototype for function 'handle_fiq_as_nmi' [-Wmissing-prototypes]
>    asmlinkage void __exception_irq_entry handle_fiq_as_nmi(struct pt_regs *regs)
>                                          ^
>    arch/arm/kernel/traps.c:511:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    asmlinkage void __exception_irq_entry handle_fiq_as_nmi(struct pt_regs *regs)
>               ^
>               static
>    arch/arm/kernel/traps.c:530:17: warning: no previous prototype for function 'bad_mode' [-Wmissing-prototypes]
>    asmlinkage void bad_mode(struct pt_regs *regs, int reason)
>                    ^
>    arch/arm/kernel/traps.c:530:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    asmlinkage void bad_mode(struct pt_regs *regs, int reason)
>               ^
>               static
>    arch/arm/kernel/traps.c:603:16: warning: no previous prototype for function 'arm_syscall' [-Wmissing-prototypes]
>    asmlinkage int arm_syscall(int no, struct pt_regs *regs)
>                   ^
>    arch/arm/kernel/traps.c:603:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    asmlinkage int arm_syscall(int no, struct pt_regs *regs)
>               ^
>               static
>    arch/arm/kernel/traps.c:729:1: warning: no previous prototype for function 'baddataabort' [-Wmissing-prototypes]
>    baddataabort(int code, unsigned long instr, struct pt_regs *regs)
>    ^
>    arch/arm/kernel/traps.c:728:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    asmlinkage void
>               ^
>               static
>    arch/arm/kernel/traps.c:769:17: warning: no previous prototype for function '__div0' [-Wmissing-prototypes]
>    asmlinkage void __div0(void)
>                    ^
>    arch/arm/kernel/traps.c:769:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    asmlinkage void __div0(void)
>               ^
>               static
> >> arch/arm/kernel/traps.c:865:17: warning: no previous prototype for function 'handle_bad_stack' [-Wmissing-prototypes]
>    asmlinkage void handle_bad_stack(struct pt_regs *regs)
>                    ^
>    arch/arm/kernel/traps.c:865:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    asmlinkage void handle_bad_stack(struct pt_regs *regs)
>               ^
>               static
>    8 warnings generated.
>
>
> vim +/handle_bad_stack +865 arch/arm/kernel/traps.c
>
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  864
> adc7d753de62f2 Ard Biesheuvel 2021-09-23 @865  asmlinkage void handle_bad_stack(struct pt_regs *regs)
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  866  {
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  867   unsigned long tsk_stk = (unsigned long)current->stack;
> 5da04a8b705043 Ard Biesheuvel 2021-11-24  868  #ifdef CONFIG_IRQSTACKS
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  869   unsigned long irq_stk = (unsigned long)this_cpu_read(irq_stack_ptr);
> 5da04a8b705043 Ard Biesheuvel 2021-11-24  870  #endif
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  871   unsigned long ovf_stk = (unsigned long)this_cpu_read(overflow_stack_ptr);
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  872
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  873   console_verbose();
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  874   pr_emerg("Insufficient stack space to handle exception!");
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  875
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  876   pr_emerg("Task stack:     [0x%08lx..0x%08lx]\n",
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  877            tsk_stk, tsk_stk + THREAD_SIZE);
> 5da04a8b705043 Ard Biesheuvel 2021-11-24  878  #ifdef CONFIG_IRQSTACKS
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  879   pr_emerg("IRQ stack:      [0x%08lx..0x%08lx]\n",
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  880            irq_stk - THREAD_SIZE, irq_stk);
> 5da04a8b705043 Ard Biesheuvel 2021-11-24  881  #endif
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  882   pr_emerg("Overflow stack: [0x%08lx..0x%08lx]\n",
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  883            ovf_stk - OVERFLOW_STACK_SIZE, ovf_stk);
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  884
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  885   die("kernel stack overflow", regs, 0);
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  886  }
> adc7d753de62f2 Ard Biesheuvel 2021-09-23  887
>
> :::::: The code at line 865 was first introduced by commit
> :::::: adc7d753de62f220505f528106a6d618104302c5 ARM: implement support for vmap'ed stacks
>
> :::::: TO: Ard Biesheuvel <ardb@kernel.org>
> :::::: CC: Ard Biesheuvel <ardb@kernel.org>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
