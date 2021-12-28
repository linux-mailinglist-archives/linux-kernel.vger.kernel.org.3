Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200EB4805B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 03:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhL1CTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 21:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhL1CS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 21:18:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707A8C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 18:18:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E12D061153
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086F7C36AE7;
        Tue, 28 Dec 2021 02:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640657938;
        bh=tkqYB3cND6mLNggS7Cy/4weofwgCs2OO4lH4L+5xA8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cV0fn7rcHqTMUhgTRsCmxsDYiNwOupSM+wqzYPlXy53XinHDrAcQDo4doTrxRgEiN
         ixVnIefLTySV4Dw9rBMkvdj1ZAOXIQtvSPhnJJxa+u6hAhfOyHoXZIz7aG4hGICFHo
         gDHTJOASqbGpGlaIpxhBe3RrUA2M+5ZzPU89xqtyDv4UHzBya11zmmg+XaAnop/m+z
         27rb94O9S/J/xD44jOr6vOiuvtNcnzSmQhuAql4+FVOsWuwMPHweviWhPM0KNLJSoj
         Qo8r8X3pc4Et/J6Gcy7xvk0TaCDAi8nEJJyR7nblyuByx3Xeq3slcXGSaYXA1aqZKR
         xWygtrBdX3KIg==
Date:   Mon, 27 Dec 2021 19:18:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Brian Cain <bcain@codeaurora.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] csky: Fix function name in csky_alignment() and die()
Message-ID: <Ycp0DsB68GWQ1eD6@archlinux-ax161>
References: <20211227184851.2297759-1-nathan@kernel.org>
 <20211227184851.2297759-4-nathan@kernel.org>
 <CAJF2gTSB8rT=g_v=NAE1YmM_qNWAVj=H5mrnty-zPVXOKYCARg@mail.gmail.com>
 <CAJF2gTQJ1JoYm5P15jWOou8yDayERUuNj_caWxdcFQ=vDm30KA@mail.gmail.com>
 <CAJF2gTQdk4ZfTnNsXX4m8KoSTgJ+0-CEJ9AKD4R=8oNvs=espA@mail.gmail.com>
 <CAJF2gTTcYTn_SDkG7cDVbsOTLeF03Kt-xLzgxd8Z7PwHYmmZRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTcYTn_SDkG7cDVbsOTLeF03Kt-xLzgxd8Z7PwHYmmZRg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

On Tue, Dec 28, 2021 at 10:01:11AM +0800, Guo Ren wrote:
> Hi Nathan & Eric,
> 
> Seems Eric's patch is not in Linus tree, right? Abandoned?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e25498f8cd43c1b5aa327f373dd094e9a006da7

Correct, Eric's patch is not in Linus' tree. It is in his
signal-for-v5.17 branch, which is currently flowing into -next:

https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/log/?h=signal-for-v5.17

Apologies for not spelling this out in the cover letter. Aside from a
review/ack/test, there should not be anything else that you need to do.

Cheers,
Nathan

> On Tue, Dec 28, 2021 at 9:53 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > I would pick up csky's & make pull-request immediately.
> >
> > On Tue, Dec 28, 2021 at 9:47 AM Guo Ren <guoren@kernel.org> wrote:
> > >
> > > Sorry mm/fault.c is okay.
> > >
> > > Reviewed-by: Guo Ren <guoren@kernel.org>
> > >
> > > On Tue, Dec 28, 2021 at 9:46 AM Guo Ren <guoren@kernel.org> wrote:
> > > >
> > > > Hi Nathan,
> > > >
> > > > Three wrong parts in csky! you forgot mm/fault.c.
> > > >
> > > > Eric's patch seems not to cc me? Why arm64 is correct, csky is wrong. -_*!
> > > >
> > > > here is the wrong patch part:
> > > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > > index 9ae24e3b72be1..11a28cace2d25 100644
> > > > --- a/arch/arm64/mm/fault.c
> > > > +++ b/arch/arm64/mm/fault.c
> > > > @@ -302,7 +302,7 @@ static void die_kernel_fault(const char *msg,
> > > > unsigned long addr,
> > > > show_pte(addr);
> > > > die("Oops", regs, esr);
> > > > bust_spinlocks(0);
> > > > - do_exit(SIGKILL);
> > > > + make_task_dead(SIGKILL);
> > > > }
> > > > #ifdef CONFIG_KASAN_HW_TAGS
> > > > diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
> > > > index cb2a0d94a144d..5e2fb45d605cf 100644
> > > > --- a/arch/csky/abiv1/alignment.c
> > > > +++ b/arch/csky/abiv1/alignment.c
> > > > @@ -294,7 +294,7 @@ bad_area:
> > > > __func__, opcode, rz, rx, imm, addr);
> > > > show_regs(regs);
> > > > bust_spinlocks(0);
> > > > - do_exit(SIGKILL);
> > > > + make_dead_task(SIGKILL);
> > > > }
> > > > force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr);
> > > > diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
> > > > index e5fbf8653a215..88a47035b9256 100644
> > > > --- a/arch/csky/kernel/traps.c
> > > > +++ b/arch/csky/kernel/traps.c
> > > > @@ -109,7 +109,7 @@ void die(struct pt_regs *regs, const char *str)
> > > > if (panic_on_oops)
> > > > panic("Fatal exception");
> > > > if (ret != NOTIFY_STOP)
> > > > - do_exit(SIGSEGV);
> > > > + make_dead_task(SIGSEGV);
> > > > }
> > > > void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
> > > > diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> > > > index 466ad949818a6..7215a46b6b8eb 100644
> > > > --- a/arch/csky/mm/fault.c
> > > > +++ b/arch/csky/mm/fault.c
> > > > @@ -67,7 +67,7 @@ static inline void no_context(struct pt_regs *regs,
> > > > unsigned long addr)
> > > > pr_alert("Unable to handle kernel paging request at virtual "
> > > > "addr 0x%08lx, pc: 0x%08lx\n", addr, regs->pc);
> > > > die(regs, "Oops");
> > > > - do_exit(SIGKILL);
> > > > + make_task_dead(SIGKILL);
> > > > }
> > > >
> > > > On Tue, Dec 28, 2021 at 2:50 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > >
> > > > > When building ARCH=csky defconfig:
> > > > >
> > > > > arch/csky/kernel/traps.c: In function 'die':
> > > > > arch/csky/kernel/traps.c:112:17: error: implicit declaration of function
> > > > > 'make_dead_task' [-Werror=implicit-function-declaration]
> > > > >   112 |                 make_dead_task(SIGSEGV);
> > > > >       |                 ^~~~~~~~~~~~~~
> > > > >
> > > > > The function's name is make_task_dead(), change it so there is no more
> > > > > build error.
> > > > >
> > > > > Fixes: 0e25498f8cd4 ("exit: Add and use make_task_dead.")
> > > > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > > > ---
> > > > >  arch/csky/abiv1/alignment.c | 2 +-
> > > > >  arch/csky/kernel/traps.c    | 2 +-
> > > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
> > > > > index 5e2fb45d605c..2df115d0e210 100644
> > > > > --- a/arch/csky/abiv1/alignment.c
> > > > > +++ b/arch/csky/abiv1/alignment.c
> > > > > @@ -294,7 +294,7 @@ void csky_alignment(struct pt_regs *regs)
> > > > >                                 __func__, opcode, rz, rx, imm, addr);
> > > > >                 show_regs(regs);
> > > > >                 bust_spinlocks(0);
> > > > > -               make_dead_task(SIGKILL);
> > > > > +               make_task_dead(SIGKILL);
> > > > >         }
> > > > >
> > > > >         force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr);
> > > > > diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
> > > > > index 88a47035b925..50481d12d236 100644
> > > > > --- a/arch/csky/kernel/traps.c
> > > > > +++ b/arch/csky/kernel/traps.c
> > > > > @@ -109,7 +109,7 @@ void die(struct pt_regs *regs, const char *str)
> > > > >         if (panic_on_oops)
> > > > >                 panic("Fatal exception");
> > > > >         if (ret != NOTIFY_STOP)
> > > > > -               make_dead_task(SIGSEGV);
> > > > > +               make_task_dead(SIGSEGV);
> > > > >  }
> > > > >
> > > > >  void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
> > > > > --
> > > > > 2.34.1
> > > > >
> > > >
> > > >
> > > > --
> > > > Best Regards
> > > >  Guo Ren
> > > >
> > > > ML: https://lore.kernel.org/linux-csky/
> > >
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
