Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86904D478A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242240AbiCJNCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiCJNCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:02:10 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC3814A236;
        Thu, 10 Mar 2022 05:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=70R22vwzhtLg0RUkMuxpW44PSeqNDUBN6BLNKNfbnG4=; b=XlQNuq71CUdhCu80QW/JOZertY
        3EQLNtADyxvQS/k3oI06CLbNAVfAcx5TQe7iTyCMEnjkQyADQubBMFAw0+2n+ttdfU4RYMzt9RUg3
        FKcUxGmd9bVIaL2WXwC5AIXZ/1MXidq0spESB9VWiwKQ+tzHXdQhrSd2vFP8jSTRb/7EC15fGxrPe
        QDHIgP7CnICV9KqPBrphjWvZT1GHVHblK8xKy6FC0R+KUmjzRj78F5faWTiUe8W5GGpPqij2ql4rt
        UlP+RRhMvRh2mWsbJPfG42eelvHNtleeW6WNQvwTrOHFTinh7GKCz+BmLMbiL5ZJpj3JS6miEVUpI
        te5dO4aA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57768)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nSIPf-00019l-33; Thu, 10 Mar 2022 13:01:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nSIPd-0000aV-KZ; Thu, 10 Mar 2022 13:01:01 +0000
Date:   Thu, 10 Mar 2022 13:01:01 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [next] arm: Internal error: Oops: 5 PC is at
 __read_once_word_nocheck
Message-ID: <Yin2jQqW+pUWJZ7E@shell.armlinux.org.uk>
References: <CAMj1kXEFZVeWLaRQJmwO+Nn6uW4q6vXJOaNNTVKju1p2bMQksA@mail.gmail.com>
 <YijCkHHhpleeADAO@shell.armlinux.org.uk>
 <CA+G9fYtjrAMg8TykZdRyZEfRthyqom_73x87F-60C_QFeEL8Bg@mail.gmail.com>
 <YijfzAhWAgfGGqCO@shell.armlinux.org.uk>
 <CAMj1kXFvjawvOzeTb2m1H=P-_aXgW-ozvaOK1FtjBv7G0sCDFA@mail.gmail.com>
 <Yij2cZVKwPexGsTf@shell.armlinux.org.uk>
 <CAMj1kXE02HH7vRUjF3iKAL+1idKTy-oOYyGnBd3g90m6eObBxg@mail.gmail.com>
 <YikByJteDEtKi4Xv@shell.armlinux.org.uk>
 <CAMj1kXGnwbe=YYWaRxaXioEfTJOdXg9JYcNddO8iifpWLRZCWg@mail.gmail.com>
 <Yinwq3Z9l0selLLS@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yinwq3Z9l0selLLS@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 12:35:55PM +0000, Russell King (Oracle) wrote:
> On Wed, Mar 09, 2022 at 09:42:29PM +0100, Ard Biesheuvel wrote:
> > On Wed, 9 Mar 2022 at 20:39, Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Wed, Mar 09, 2022 at 08:14:30PM +0100, Ard Biesheuvel wrote:
> > > > The backtrace dumped by __die() uses the pt_regs from the exception
> > > > context as the starting point, so the exception entry code that deals
> > > > with the condition that triggered the oops is omitted, and does not
> > > > have to be unwound.
> > >
> > > That is true, but that's not really the case I was thinking about.
> > > I was thinking more about cases such as RCU stalls, soft lockups,
> > > etc.
> > >
> > > For example:
> > >
> > > https://www.linuxquestions.org/questions/linux-kernel-70/kenel-v4-4-60-panic-in-igmp6_send-and-and-__neigh_create-4175704721/
> > >
> > > In that stack trace, the interesting bits are not the beginning of
> > > the stack trace down to __irq_svc, but everything beyond __irq_svc,
> > > since the lockup is probably caused by being stuck in
> > > _raw_write_lock_bh().
> > >
> > > It's these situations that we will totally destroy debuggability for,
> > > and the only way around that would be to force frame pointers and
> > > ARM builds (not Thumb-2 as that requires the unwinder... which means
> > > a Thumb-2 kernel soft lockup would be undebuggable.
> > >
> > 
> > Indeed.
> > 
> > But that means that the only other choice we have is to retain the
> > imprecise nature of the current solution (which usually works fine
> > btw), and simply deal with the faulting double dereference of vsp in
> > the unwinder code. We simply don't know whether the exception was
> > taken at a point where the stack frame is consistent with the unwind
> > data.
> 
> Okay, further analysis (for the record, since I've said much of this on
> IRC):
> 
> What we have currently is a robust unwinder that will cope when things
> go wrong, such as an interrupt taken during the prologue of a function.
> The way it copes is by two mechanisms:
> 
>         /* store the highest address on the stack to avoid crossing it*/
>         low = frame->sp;
>         ctrl.sp_high = ALIGN(low, THREAD_SIZE);
> 
> These two represent the allowable bounds of the kernel stack. When we
> run the unwinder, before each unwind instruction we check whether the
> current SP value is getting close to the top of the kernel stack, and
> if so, turn on additional checking:
> 
>                 if ((ctrl.sp_high - ctrl.vrs[SP]) < sizeof(ctrl.vrs))
>                         ctrl.check_each_pop = 1;
> 
> that will ensure if we go off the top of the kernel stack, the
> unwinder will report failure, and not access those addresses.
> 
> After each instruction, we check whether the SP value is within the
> above bounds:
> 
>                 if (ctrl.vrs[SP] < low || ctrl.vrs[SP] >= ctrl.sp_high)
>                         return -URC_FAILURE;
> 
> This means that the unwinder can never modify SP to point outside of
> the kernel stack region identified by low..ctrl.sp_high, thereby
> protecting the load inside unwind_pop_register() from ever
> dereferencing something outside of the kernel stack. Moreover, it also
> prevents the unwinder modifying SP to point below the current stack
> frame.
> 
> The problem has been introduced by trying to make the unwinder cope
> with IRQ stacks in b6506981f880 ("ARM: unwind: support unwinding across
> multiple stacks"):
> 
> -       if (!load_sp)
> +       if (!load_sp) {
>                 ctrl->vrs[SP] = (unsigned long)vsp;
> +       } else {
> +               ctrl->sp_low = ctrl->vrs[SP];
> +               ctrl->sp_high = ALIGN(ctrl->sp_low, THREAD_SIZE);
> +       }
> 
> Now, whenever SP is loaded, we reset the allowable range for the SP
> value, and this completely defeats the protections we previously had
> which were ensuring that:
> 
> 1) the SP value doesn't jump back _down_ the kernel stack resulting
>    in an infinite unwind loop.
> 2) the SP value doesn't end up outside the kernel stack.
> 
> We need those protections to prevent these problems that are being
> reported - and the most efficient way I can think of doing that is to
> somehow valudate the new SP value _before_ we modify sp_low and
> sp_high, so these two limits are always valid.
> 
> Merely changing the READ_ONCE_NOCHECK() to be get_kernel_nocheck()
> will only partly fix this problem - it will stop the unwinder oopsing
> the kernel, but definitely doesn't protect against (1) and doesn't
> protect against SP pointing at some thing that is accessible (e.g.
> a device or other kernel memory.)
> 
> We're yet again at Thursday, with the last linux-next prior to the
> merge window being created this evening, which really doesn't leave
> much time to get this sorted... and we can't say "this code should
> have been in earlier in the cycle" this time around, because these
> changes to the unwinder have been present in linux-next prior to
> 5.17-rc2. Annoyingly, it seems merging stuff earlier in the cycle
> doesn't actually solve the problem of these last minute debugging
> panics.
> 
> Any suggestions for what we should do? Can we come up with some way
> to validate the new SP value before 6pm UTC this evening?

Also, looking deeper at the last linaro job report:

https://lkft.validation.linaro.org/scheduler/job/4688599#L684

the dumped memory doesn't look like an exception stack. If it was,
e82aab40 would be the saved CPSR value and c388eb80 would be the PC
value, both of which are nonsense.

The stack that we were in (and we dumped out in full) was:

Stack: (0xc381bb30 to 0xc381c000)

and the exception stack (the saved pt_regs) is:

                                    r0       r1       r2       r3       r4
bfa0: c2ba47c0 0000000a c2ba1358 ffff9537 c2c05d00 00400140 c62d5624 c1948b20
         r5       r6       r7       r8       r9       r10      fp       ip
bfc0: e82ab498 c62d5400 c35377a0 c62d5404 25706000 c381bfe8 c62d5400 00000001
         sp       lr       pc      cpsr    orig_r0
bfe0: c5fcfc48 c036251c c0995a14 20040013 ffffffff c5fcfc7c c62d5400 c0300bf0

but, we end up dumping out:

Exception stack(0xc5fcfc98 to 0xc5fcfce0)
fc80:                                                       b6a3ab70 00000004
fca0: 00000000 00000004 b6a3ab70 c055f928 c388eb80 c5fcfd40 00000000 c5fcfd50
fcc0: 00000005 00000051 e82aad1c c03ae570 00000000 c388eb80 c3512a20 e82aab40

Firstly, that's in the wrong stack to be dumping for the exception
stack, and secondly, why is it 0x50 bytes above the saved SP value from
the real exception stack - that makes no sense in itself.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
