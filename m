Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B595657C2A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiGUDXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiGUDXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:23:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0878481FB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:23:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68B8D6164C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E86C341CE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658373780;
        bh=DdibQXcG1qxMfukbbexNfVDVxosF719OiLp85Kn1U34=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NN4ihKtDTx4i3T8YsVnbFtqq6/oMl9Kjeaz8XAlAeArWomLn+yDR/OUTOhEkxBlvr
         613TsNsygixtBMU8a3eLTeZcF9qGpUUHuCMvoNoIS7eIM0hHgOioV2LzDEaLHRSvt8
         b8IJdHAHMPV8389H523wrWtqxhCTS9EIgCJai0FoSDYJ0HzaXiV2Tj0/e7HOv5MdcZ
         +EDWpyKr6iUcXG9yw7hwEYvO6sL+0Nug/CDulI8zvW8Rg4ku/GUy+RxTOTan2xH+31
         QpHLdpJSSYTeZpmgCYNHMz+J3lhqxfCMGBTI63+OCLVPvbBroTy/oCeVuvVQ3onzYA
         J7xNgmMwn54QA==
Received: by mail-vk1-f178.google.com with SMTP id a24so171330vkm.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:23:00 -0700 (PDT)
X-Gm-Message-State: AJIora8TUnLYI9yN3dI+Z4dlZaNh2HAcg9teZueDlAITaw+Us3Kn0HVF
        erPES8CMCzgKXoSPgwY4BKfKW7pdwhirsaHleJU=
X-Google-Smtp-Source: AGRyM1sStRWJzrcW3MrL2zJryAgF4a4wTQhnxv3jIiZ/mPz5GJUkj7LyCU5htYfcT0rBry11AIZSXfbda4VYFIR1ezI=
X-Received: by 2002:a05:6122:1825:b0:376:78:5015 with SMTP id
 ay37-20020a056122182500b0037600785015mr122502vkb.18.1658373779680; Wed, 20
 Jul 2022 20:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220721021127.1086628-1-yijun@loongson.cn> <CAAhV-H4YL-8tj+-329tWguwxrPaL7DpiTT2QkXBPh_feT7M5jA@mail.gmail.com>
 <dcfac9ad-d6e0-b157-4f11-cc2d3e2f1376@xen0n.name>
In-Reply-To: <dcfac9ad-d6e0-b157-4f11-cc2d3e2f1376@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 21 Jul 2022 11:22:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6RGZwKjV4Shm9fvH_XJ1+yqq9KpxkXNEWwOaPRmahSLQ@mail.gmail.com>
Message-ID: <CAAhV-H6RGZwKjV4Shm9fvH_XJ1+yqq9KpxkXNEWwOaPRmahSLQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Remove unused header compiler.h
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Jun Yi <yijun@loongson.cn>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xuerui,

On Thu, Jul 21, 2022 at 11:17 AM WANG Xuerui <kernel@xen0n.name> wrote:
>
> Hi YI Jun and Huacai,
>
> On 2022/7/21 10:52, Huacai Chen wrote:
> > Hi, Jun,
> >
> > On Thu, Jul 21, 2022 at 10:11 AM Jun Yi <yijun@loongson.cn> wrote:
> >> Loongarch not used arch-specific compiler.h
> > I'm not sure whether compiler.h will be used in future. If it will be
> > used, I want to keep it as is. Xuerui, what do you think about it?
>
> I surveyed all the existing arch compiler.h in the tree:
>
> $ find ./arch -name compiler.h
> ./arch/alpha/include/asm/compiler.h
> ./arch/alpha/include/uapi/asm/compiler.h
> ./arch/arm/include/asm/compiler.h
> ./arch/arm64/include/asm/compiler.h
> ./arch/mips/include/asm/compiler.h
> ./arch/loongarch/include/asm/compiler.h
>
> Of all these occurrences:
>
> - alpha needs to ensure a certain insn is being emitted from time to
> time, with plain C constructs (or built-ins) on compiler versions with
> said support, falling back to inline asm otherwise;
> - arm and arm64 both need some inline assembly help (of different sort),
> with arm64 stuffing some pointer authentication helpers into this file too;
> - mips, which is obviously what the loongarch version is based on, needs
> (1) a kludge for older compilers to fix delay slot filling around
> __builtin_unreachable, (2) definitions for explicit arch level
> selection. There is also the historical GCC_OFF_SMALL_ASM() constraint
> definition that was rendered redundant by commit 4abaacc704729 ("MIPS:
> remove GCC < 4.9 support").
>
> For loongarch, the "ZC" constraint (I don't think it was a coincidence
> BTW) should be usable for all present and future hardware, so I do think
> the GCC_OFF_SMALL_ASM() here is redundant. We may want to remove the
> mips one too. And the arch level thing is not currently needed either,
> future revisions to the LoongArch ISA should be largely backwards
> compatible, so it could be a long time before such explicit selection of
> arch level is necessary, for exact control over emitted insn.
>
> So overall, I'm in favor of removing this header for now.
Have you considered the new relocation types will be added in the near
future? I think we need compiler.h at that time.

Huacai
>
> > Huacai
> >> Signed-off-by: Jun Yi <yijun@loongson.cn>
> >> ---
> >>   arch/loongarch/Kconfig                |  1 -
> >>   arch/loongarch/include/asm/atomic.h   |  9 ++++-----
> >>   arch/loongarch/include/asm/compiler.h | 15 ---------------
> >>   arch/loongarch/include/asm/futex.h    |  5 ++---
> >>   arch/loongarch/include/asm/irqflags.h |  1 -
> >>   arch/loongarch/include/asm/local.h    |  1 -
> >>   arch/loongarch/kernel/reset.c         |  1 -
> >>   arch/loongarch/lib/delay.c            |  1 -
> >>   8 files changed, 6 insertions(+), 28 deletions(-)
> >>   delete mode 100644 arch/loongarch/include/asm/compiler.h
> >>
> >> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> >> index 53a912befb62..89da3e09084e 100644
> >> --- a/arch/loongarch/Kconfig
> >> +++ b/arch/loongarch/Kconfig
> >> @@ -69,7 +69,6 @@ config LOONGARCH
> >>          select GENERIC_TIME_VSYSCALL
> >>          select GPIOLIB
> >>          select HAVE_ARCH_AUDITSYSCALL
> >> -       select HAVE_ARCH_COMPILER_H
> >>          select HAVE_ARCH_MMAP_RND_BITS if MMU
> >>          select HAVE_ARCH_SECCOMP_FILTER
> >>          select HAVE_ARCH_TRACEHOOK
> >> diff --git a/arch/loongarch/include/asm/atomic.h b/arch/loongarch/include/asm/atomic.h
> >> index 979367ad4e2c..b5e2e3201af1 100644
> >> --- a/arch/loongarch/include/asm/atomic.h
> >> +++ b/arch/loongarch/include/asm/atomic.h
> >> @@ -10,7 +10,6 @@
> >>   #include <linux/types.h>
> >>   #include <asm/barrier.h>
> >>   #include <asm/cmpxchg.h>
> >> -#include <asm/compiler.h>
> >>
> >>   #if __SIZEOF_LONG__ == 4
> >>   #define __LL           "ll.w   "
> >> @@ -164,7 +163,7 @@ static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
> >>                  "2:                                                     \n"
> >>                  __WEAK_LLSC_MB
> >>                  : "=&r" (result), "=&r" (temp),
> >> -                 "+" GCC_OFF_SMALL_ASM() (v->counter)
> >> +                 "+ZC" (v->counter)
> >>                  : "I" (-i));
> >>          } else {
> >>                  __asm__ __volatile__(
> >> @@ -177,7 +176,7 @@ static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
> >>                  "2:                                                     \n"
> >>                  __WEAK_LLSC_MB
> >>                  : "=&r" (result), "=&r" (temp),
> >> -                 "+" GCC_OFF_SMALL_ASM() (v->counter)
> >> +                 "+ZC" (v->counter)
> >>                  : "r" (i));
> >>          }
> >>
> >> @@ -327,7 +326,7 @@ static inline long arch_atomic64_sub_if_positive(long i, atomic64_t *v)
> >>                  "2:                                                     \n"
> >>                  __WEAK_LLSC_MB
> >>                  : "=&r" (result), "=&r" (temp),
> >> -                 "+" GCC_OFF_SMALL_ASM() (v->counter)
> >> +                 "+ZC" (v->counter)
> >>                  : "I" (-i));
> >>          } else {
> >>                  __asm__ __volatile__(
> >> @@ -340,7 +339,7 @@ static inline long arch_atomic64_sub_if_positive(long i, atomic64_t *v)
> >>                  "2:                                                     \n"
> >>                  __WEAK_LLSC_MB
> >>                  : "=&r" (result), "=&r" (temp),
> >> -                 "+" GCC_OFF_SMALL_ASM() (v->counter)
> >> +                 "+ZC" (v->counter)
> >>                  : "r" (i));
> >>          }
> >>
> >> diff --git a/arch/loongarch/include/asm/compiler.h b/arch/loongarch/include/asm/compiler.h
> >> deleted file mode 100644
> >> index 657cebe70ace..000000000000
> >> --- a/arch/loongarch/include/asm/compiler.h
> >> +++ /dev/null
> >> @@ -1,15 +0,0 @@
> >> -/* SPDX-License-Identifier: GPL-2.0 */
> >> -/*
> >> - * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> >> - */
> >> -#ifndef _ASM_COMPILER_H
> >> -#define _ASM_COMPILER_H
> >> -
> >> -#define GCC_OFF_SMALL_ASM() "ZC"
> >> -
> >> -#define LOONGARCH_ISA_LEVEL "loongarch"
> >> -#define LOONGARCH_ISA_ARCH_LEVEL "arch=loongarch"
> >> -#define LOONGARCH_ISA_LEVEL_RAW loongarch
> >> -#define LOONGARCH_ISA_ARCH_LEVEL_RAW LOONGARCH_ISA_LEVEL_RAW
> >> -
> >> -#endif /* _ASM_COMPILER_H */
> >> diff --git a/arch/loongarch/include/asm/futex.h b/arch/loongarch/include/asm/futex.h
> >> index 9de8231694ec..e28b65d9c67a 100644
> >> --- a/arch/loongarch/include/asm/futex.h
> >> +++ b/arch/loongarch/include/asm/futex.h
> >> @@ -8,7 +8,6 @@
> >>   #include <linux/futex.h>
> >>   #include <linux/uaccess.h>
> >>   #include <asm/barrier.h>
> >> -#include <asm/compiler.h>
> >>   #include <asm/errno.h>
> >>
> >>   #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)             \
> >> @@ -95,8 +94,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr, u32 oldval, u32 newv
> >>          "       "__UA_ADDR "\t1b, 4b                            \n"
> >>          "       "__UA_ADDR "\t2b, 4b                            \n"
> >>          "       .previous                                       \n"
> >> -       : "+r" (ret), "=&r" (val), "=" GCC_OFF_SMALL_ASM() (*uaddr)
> >> -       : GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
> >> +       : "+r" (ret), "=&r" (val), "=ZC" (*uaddr)
> >> +       : "ZC" (*uaddr), "Jr" (oldval), "Jr" (newval),
> >>            "i" (-EFAULT)
> >>          : "memory", "t0");
> >>
> >> diff --git a/arch/loongarch/include/asm/irqflags.h b/arch/loongarch/include/asm/irqflags.h
> >> index 52121cd791fe..319a8c616f1f 100644
> >> --- a/arch/loongarch/include/asm/irqflags.h
> >> +++ b/arch/loongarch/include/asm/irqflags.h
> >> @@ -9,7 +9,6 @@
> >>
> >>   #include <linux/compiler.h>
> >>   #include <linux/stringify.h>
> >> -#include <asm/compiler.h>
> >>   #include <asm/loongarch.h>
> >>
> >>   static inline void arch_local_irq_enable(void)
> >> diff --git a/arch/loongarch/include/asm/local.h b/arch/loongarch/include/asm/local.h
> >> index 2052a2267337..65fbbae9fc4d 100644
> >> --- a/arch/loongarch/include/asm/local.h
> >> +++ b/arch/loongarch/include/asm/local.h
> >> @@ -9,7 +9,6 @@
> >>   #include <linux/bitops.h>
> >>   #include <linux/atomic.h>
> >>   #include <asm/cmpxchg.h>
> >> -#include <asm/compiler.h>
> >>
> >>   typedef struct {
> >>          atomic_long_t a;
> >> diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/reset.c
> >> index 2b86469e4718..800c965a17ea 100644
> >> --- a/arch/loongarch/kernel/reset.c
> >> +++ b/arch/loongarch/kernel/reset.c
> >> @@ -13,7 +13,6 @@
> >>   #include <linux/console.h>
> >>
> >>   #include <acpi/reboot.h>
> >> -#include <asm/compiler.h>
> >>   #include <asm/idle.h>
> >>   #include <asm/loongarch.h>
> >>   #include <asm/reboot.h>
> >> diff --git a/arch/loongarch/lib/delay.c b/arch/loongarch/lib/delay.c
> >> index 5d856694fcfe..831d4761f385 100644
> >> --- a/arch/loongarch/lib/delay.c
> >> +++ b/arch/loongarch/lib/delay.c
> >> @@ -7,7 +7,6 @@
> >>   #include <linux/smp.h>
> >>   #include <linux/timex.h>
> >>
> >> -#include <asm/compiler.h>
> >>   #include <asm/processor.h>
> >>
> >>   void __delay(unsigned long cycles)
> >> --
> >> 2.31.1
> >>
> >>
