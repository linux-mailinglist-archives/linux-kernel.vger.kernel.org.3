Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE06A4E4ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 03:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbiCWCSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 22:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241167AbiCWCR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:17:58 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94C57006C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:16:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o68-20020a17090a0a4a00b001c686a48263so2812521pjo.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=CgTLARXl73a8vMc6tpwfKmduohAy7WyurFsoKnNWgu0=;
        b=2sfQEpK7D1SE5ouqsUhkZLTMHqUMSnKCN/2E9JN22jvFu5ovcsx4bCza0m4OeTzada
         7GdZ0tJntehuzgc9DlOxEvddk0dmAo07SMfwmI9cyEtnj4x00eORC20VyAAVj7is+nZ3
         D1PymTuxfK5QhA5V0zWjLGwtQ6XYNKBbr57OUK6+SqWbPUL88piEVQpOg6YwNJ0LwKtU
         dXEEN0Sy0stqP0BMLwHwNrHQTxlasB+dkIj1LUs/6YYLT0A5r7Csgp11woy/b6d3EYF/
         V1OEIbkBU2gAva+y70OtK3bApQyRcVS/zsOho9TXC7CKUyQyb2MJrcdPjxr1YoyDUyH9
         A3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=CgTLARXl73a8vMc6tpwfKmduohAy7WyurFsoKnNWgu0=;
        b=p/IB7/94bmHgXaERN4JKb2LSEXx+xV5zJJ96ybwReynWjVFO1+xrNgQv6lCd0PteUP
         5ozvUIGDFhnncmiVomnx2yQk6RUA3nmVfQxbQ4G3o50OGY9C8Ui4c43Hkt4YAM1SY/L4
         zxcnfX3hYse1sbtc5aOBZSEYLE2teIK0phrzJFUeGfqktm8nZ7++/wslMkb8OILwXtiw
         1x7kzsHSLnIegboDU8BvVi7TtnKYHcRA0961tfn5ap4UtWS94FLOViVf76DVPIBMc5Yg
         GruXeaIMDAfvkpES+UJ9AeZzdqm7l4smomDMP6XmWSDeCCcbwUANLv+gofSUYwiwb7ox
         o70g==
X-Gm-Message-State: AOAM530QrNDs0sF0G3Q/JO/Fef7SSOlmMeSVLF8brRORU46xLKDBNr6a
        f6kjznsDstscHDNByne2i/ZUrw==
X-Google-Smtp-Source: ABdhPJzgotRXjhQP3kW38oz7JB3aavGYXp1ugUbmpS1C6w8P28iC2PwkqLg34Gbv+Rx/a6wGjk9rqg==
X-Received: by 2002:a17:90b:4f8c:b0:1c7:2217:e980 with SMTP id qe12-20020a17090b4f8c00b001c72217e980mr8540720pjb.17.1648001789309;
        Tue, 22 Mar 2022 19:16:29 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a199000b001bf4b1b268bsm3819263pji.44.2022.03.22.19.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 19:16:28 -0700 (PDT)
Date:   Tue, 22 Mar 2022 19:16:28 -0700 (PDT)
X-Google-Original-Date: Tue, 22 Mar 2022 19:16:25 PDT (-0700)
Subject:     Re: [PATCH] riscv: Rename "sp_in_global" to "current_stack_pointer"
In-Reply-To: <20220224060411.1855683-1-keescook@chromium.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, keescook@chromium.org,
        aou@eecs.berkeley.edu, peterz@infradead.org, jszhang@kernel.org,
        geert@linux-m68k.org, mark.rutland@arm.com, chenhuang5@huawei.com,
        linux-riscv@lists.infradead.org, wangkefeng.wang@huawei.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     keescook@chromium.org
Message-ID: <mhng-00315cbb-3685-4918-8ea0-539cda5fbc36@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 22:04:11 PST (-0800), keescook@chromium.org wrote:
> To follow the existing per-arch conventions, rename "sp_in_global" to
> "current_stack_pointer". This will let it be used in non-arch places
> (like HARDENED_USERCOPY).
>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jisheng Zhang <jszhang@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Chen Huang <chenhuang5@huawei.com>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/riscv/Kconfig               | 1 +
>  arch/riscv/include/asm/current.h | 2 ++
>  arch/riscv/kernel/stacktrace.c   | 4 +---
>  3 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 5adcbd9b5e88..b120c32697af 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -16,6 +16,7 @@ config RISCV
>  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>  	select ARCH_HAS_BINFMT_FLAT
> +	select ARCH_HAS_CURRENT_STACK_POINTER
>  	select ARCH_HAS_DEBUG_VM_PGTABLE
>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>  	select ARCH_HAS_DEBUG_WX
> diff --git a/arch/riscv/include/asm/current.h b/arch/riscv/include/asm/current.h
> index 1de233d8e8de..21774d868c65 100644
> --- a/arch/riscv/include/asm/current.h
> +++ b/arch/riscv/include/asm/current.h
> @@ -33,6 +33,8 @@ static __always_inline struct task_struct *get_current(void)
>
>  #define current get_current()
>
> +register unsigned long current_stack_pointer __asm__("sp");
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_RISCV_CURRENT_H */
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index 201ee206fb57..278380e2e956 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -14,8 +14,6 @@
>
>  #include <asm/stacktrace.h>
>
> -register unsigned long sp_in_global __asm__("sp");
> -
>  #ifdef CONFIG_FRAME_POINTER
>
>  void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
> @@ -77,7 +75,7 @@ void notrace walk_stackframe(struct task_struct *task,
>  		sp = user_stack_pointer(regs);
>  		pc = instruction_pointer(regs);
>  	} else if (task == NULL || task == current) {
> -		sp = sp_in_global;
> +		sp = current_stack_pointer;
>  		pc = (unsigned long)walk_stackframe;
>  	} else {
>  		/* task blocked in __switch_to */

Sorry to be slow on this one.  This looks good, but another use of 
sp_in_global snuck into fixes and I don't merge fixes into for-next so 
that makes this a bit of a headache.

There's a bunch of stuff in flight, so I'm going to hold off on this 
until after my first week's merge window PR.  I intend on merging the 
following, which is at palmer/riscv-sp for now (I'll probably just 
cherry-pick that, I usually start basing stuff on Linus' merge of my PR 
and just cherry-pick in single patches).

   commit 7c4f6bb6fb352cfa6028191c2888356b9157a332
   gpg: Signature made Tue 22 Mar 2022 11:12:19 AM PDT
   gpg:                using RSA key 2B3C3747446843B24A943A7A2E1319F35FBB1889
   gpg:                issuer "palmer@dabbelt.com"
   gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
   gpg:                 aka "Palmer Dabbelt <palmer@rivosinc.com>" [ultimate]
   Author: Kees Cook <keescook@chromium.org>
   Date:   Wed Feb 23 22:04:11 2022 -0800
   
       riscv: Rename "sp_in_global" to "current_stack_pointer"
   
       To follow the existing per-arch conventions, rename "sp_in_global" to
       "current_stack_pointer". This will let it be used in non-arch places
       (like HARDENED_USERCOPY).
   
       Signed-off-by: Kees Cook <keescook@chromium.org>
       Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
   
   diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
   index 5adcbd9b5e88..b120c32697af 100644
   --- a/arch/riscv/Kconfig
   +++ b/arch/riscv/Kconfig
   @@ -16,6 +16,7 @@ config RISCV
    	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
    	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
    	select ARCH_HAS_BINFMT_FLAT
   +	select ARCH_HAS_CURRENT_STACK_POINTER
    	select ARCH_HAS_DEBUG_VM_PGTABLE
    	select ARCH_HAS_DEBUG_VIRTUAL if MMU
    	select ARCH_HAS_DEBUG_WX
   diff --git a/arch/riscv/include/asm/current.h b/arch/riscv/include/asm/current.h
   index 1de233d8e8de..21774d868c65 100644
   --- a/arch/riscv/include/asm/current.h
   +++ b/arch/riscv/include/asm/current.h
   @@ -33,6 +33,8 @@ static __always_inline struct task_struct *get_current(void)
   
    #define current get_current()
   
   +register unsigned long current_stack_pointer __asm__("sp");
   +
    #endif /* __ASSEMBLY__ */
   
    #endif /* _ASM_RISCV_CURRENT_H */
   diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
   index 14d2b53ec322..08d11a53f39e 100644
   --- a/arch/riscv/kernel/stacktrace.c
   +++ b/arch/riscv/kernel/stacktrace.c
   @@ -14,8 +14,6 @@
   
    #include <asm/stacktrace.h>
   
   -register unsigned long sp_in_global __asm__("sp");
   -
    #ifdef CONFIG_FRAME_POINTER
   
    void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
   @@ -30,7 +28,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
    		pc = instruction_pointer(regs);
    	} else if (task == NULL || task == current) {
    		fp = (unsigned long)__builtin_frame_address(0);
   -		sp = sp_in_global;
   +		sp = current_stack_pointer;
    		pc = (unsigned long)walk_stackframe;
    	} else {
    		/* task blocked in __switch_to */
   @@ -78,7 +76,7 @@ void notrace walk_stackframe(struct task_struct *task,
    		sp = user_stack_pointer(regs);
    		pc = instruction_pointer(regs);
    	} else if (task == NULL || task == current) {
   -		sp = sp_in_global;
   +		sp = current_stack_pointer;
    		pc = (unsigned long)walk_stackframe;
    	} else {
    		/* task blocked in __switch_to */
   
Thanks!
