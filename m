Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824D148059D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 03:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhL1CBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 21:01:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42420 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbhL1CBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 21:01:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE6CC6115A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B60C36AEC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640656883;
        bh=r+dAir1sykGQ+G7hdyINnqPGq/pc71Yys3hELKYuqoU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C1LX6UcDnEJ2cWhYUmYoaZxb2mnQ8RKyoCIzz9XZkU1+L6TQAKAc2KG6cQqHpmqmt
         d/FiPpQIcIJYzrowD0FboLMtXLpY5HdEOuhXU9peBSYSo6EpfSLH9Nvo8mxcxNJMcj
         1yukxOdQvDGXt5/NImFDesr7xjaRJkKU//XA+m4t4uDKZ4Z1+s34k9s4Qf09I7lplF
         /u8ttsaLSfwgq1tZ5D8ghVPTgCuKnOd0xXQ2TxOEmNNsSzrnPPzwyMm9FLUJI6pKTS
         gMhbCd5wPft7XXMyHa9E2ydADH494pPzkdQeAlyLk+1dsRJRGpuwrrkvfCAcLq9R5o
         3mW27FM9y4Orw==
Received: by mail-ua1-f44.google.com with SMTP id o1so29675874uap.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 18:01:23 -0800 (PST)
X-Gm-Message-State: AOAM531zGkEOTfSomgfnqHb8g8LKRkxjJwBVG5Y1nBK6eLMJHvCPC2C4
        b5bnef1ee8A+5fArqDgmVBURxVQTJsqq49GkGPE=
X-Google-Smtp-Source: ABdhPJz+Vo+KIW36CWbnCibLfofPJMOQFteAIHr1zyECkVjyb3WwK5RZz8LCmFaWaA7j6yS4KD3on/zbGUAGMjvlO4c=
X-Received: by 2002:a05:6102:316e:: with SMTP id l14mr5435552vsm.8.1640656882322;
 Mon, 27 Dec 2021 18:01:22 -0800 (PST)
MIME-Version: 1.0
References: <20211227184851.2297759-1-nathan@kernel.org> <20211227184851.2297759-4-nathan@kernel.org>
 <CAJF2gTSB8rT=g_v=NAE1YmM_qNWAVj=H5mrnty-zPVXOKYCARg@mail.gmail.com>
 <CAJF2gTQJ1JoYm5P15jWOou8yDayERUuNj_caWxdcFQ=vDm30KA@mail.gmail.com> <CAJF2gTQdk4ZfTnNsXX4m8KoSTgJ+0-CEJ9AKD4R=8oNvs=espA@mail.gmail.com>
In-Reply-To: <CAJF2gTQdk4ZfTnNsXX4m8KoSTgJ+0-CEJ9AKD4R=8oNvs=espA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 28 Dec 2021 10:01:11 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTcYTn_SDkG7cDVbsOTLeF03Kt-xLzgxd8Z7PwHYmmZRg@mail.gmail.com>
Message-ID: <CAJF2gTTcYTn_SDkG7cDVbsOTLeF03Kt-xLzgxd8Z7PwHYmmZRg@mail.gmail.com>
Subject: Re: [PATCH 3/3] csky: Fix function name in csky_alignment() and die()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Brian Cain <bcain@codeaurora.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan & Eric,

Seems Eric's patch is not in Linus tree, right? Abandoned?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e25498f8cd43c1b5aa327f373dd094e9a006da7

On Tue, Dec 28, 2021 at 9:53 AM Guo Ren <guoren@kernel.org> wrote:
>
> I would pick up csky's & make pull-request immediately.
>
> On Tue, Dec 28, 2021 at 9:47 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > Sorry mm/fault.c is okay.
> >
> > Reviewed-by: Guo Ren <guoren@kernel.org>
> >
> > On Tue, Dec 28, 2021 at 9:46 AM Guo Ren <guoren@kernel.org> wrote:
> > >
> > > Hi Nathan,
> > >
> > > Three wrong parts in csky! you forgot mm/fault.c.
> > >
> > > Eric's patch seems not to cc me? Why arm64 is correct, csky is wrong. -_*!
> > >
> > > here is the wrong patch part:
> > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > index 9ae24e3b72be1..11a28cace2d25 100644
> > > --- a/arch/arm64/mm/fault.c
> > > +++ b/arch/arm64/mm/fault.c
> > > @@ -302,7 +302,7 @@ static void die_kernel_fault(const char *msg,
> > > unsigned long addr,
> > > show_pte(addr);
> > > die("Oops", regs, esr);
> > > bust_spinlocks(0);
> > > - do_exit(SIGKILL);
> > > + make_task_dead(SIGKILL);
> > > }
> > > #ifdef CONFIG_KASAN_HW_TAGS
> > > diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
> > > index cb2a0d94a144d..5e2fb45d605cf 100644
> > > --- a/arch/csky/abiv1/alignment.c
> > > +++ b/arch/csky/abiv1/alignment.c
> > > @@ -294,7 +294,7 @@ bad_area:
> > > __func__, opcode, rz, rx, imm, addr);
> > > show_regs(regs);
> > > bust_spinlocks(0);
> > > - do_exit(SIGKILL);
> > > + make_dead_task(SIGKILL);
> > > }
> > > force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr);
> > > diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
> > > index e5fbf8653a215..88a47035b9256 100644
> > > --- a/arch/csky/kernel/traps.c
> > > +++ b/arch/csky/kernel/traps.c
> > > @@ -109,7 +109,7 @@ void die(struct pt_regs *regs, const char *str)
> > > if (panic_on_oops)
> > > panic("Fatal exception");
> > > if (ret != NOTIFY_STOP)
> > > - do_exit(SIGSEGV);
> > > + make_dead_task(SIGSEGV);
> > > }
> > > void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
> > > diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> > > index 466ad949818a6..7215a46b6b8eb 100644
> > > --- a/arch/csky/mm/fault.c
> > > +++ b/arch/csky/mm/fault.c
> > > @@ -67,7 +67,7 @@ static inline void no_context(struct pt_regs *regs,
> > > unsigned long addr)
> > > pr_alert("Unable to handle kernel paging request at virtual "
> > > "addr 0x%08lx, pc: 0x%08lx\n", addr, regs->pc);
> > > die(regs, "Oops");
> > > - do_exit(SIGKILL);
> > > + make_task_dead(SIGKILL);
> > > }
> > >
> > > On Tue, Dec 28, 2021 at 2:50 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > > >
> > > > When building ARCH=csky defconfig:
> > > >
> > > > arch/csky/kernel/traps.c: In function 'die':
> > > > arch/csky/kernel/traps.c:112:17: error: implicit declaration of function
> > > > 'make_dead_task' [-Werror=implicit-function-declaration]
> > > >   112 |                 make_dead_task(SIGSEGV);
> > > >       |                 ^~~~~~~~~~~~~~
> > > >
> > > > The function's name is make_task_dead(), change it so there is no more
> > > > build error.
> > > >
> > > > Fixes: 0e25498f8cd4 ("exit: Add and use make_task_dead.")
> > > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > > ---
> > > >  arch/csky/abiv1/alignment.c | 2 +-
> > > >  arch/csky/kernel/traps.c    | 2 +-
> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
> > > > index 5e2fb45d605c..2df115d0e210 100644
> > > > --- a/arch/csky/abiv1/alignment.c
> > > > +++ b/arch/csky/abiv1/alignment.c
> > > > @@ -294,7 +294,7 @@ void csky_alignment(struct pt_regs *regs)
> > > >                                 __func__, opcode, rz, rx, imm, addr);
> > > >                 show_regs(regs);
> > > >                 bust_spinlocks(0);
> > > > -               make_dead_task(SIGKILL);
> > > > +               make_task_dead(SIGKILL);
> > > >         }
> > > >
> > > >         force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr);
> > > > diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
> > > > index 88a47035b925..50481d12d236 100644
> > > > --- a/arch/csky/kernel/traps.c
> > > > +++ b/arch/csky/kernel/traps.c
> > > > @@ -109,7 +109,7 @@ void die(struct pt_regs *regs, const char *str)
> > > >         if (panic_on_oops)
> > > >                 panic("Fatal exception");
> > > >         if (ret != NOTIFY_STOP)
> > > > -               make_dead_task(SIGSEGV);
> > > > +               make_task_dead(SIGSEGV);
> > > >  }
> > > >
> > > >  void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
> > > > --
> > > > 2.34.1
> > > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> > >
> > > ML: https://lore.kernel.org/linux-csky/
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
