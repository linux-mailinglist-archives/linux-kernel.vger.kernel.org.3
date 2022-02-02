Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CB04A6C90
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbiBBIAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiBBIAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:00:15 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41465C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 00:00:15 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id z4so38967770lft.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 00:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P2nYUPty6npzIPJSOn+ItpOaTOlsER8woDmxJG1XffM=;
        b=lGz2CISmA7peCMW0SiIw0kVSH+Hu+fr5zHWlSX7G95nDMs3p7jNdxPfr/BnDjjkr+9
         EdemfJe2d3A/KTMD/rrxhds0tKBqH+vheVK8T3JcRUaGfFFbWQ8FpRR6biph7K6ezmax
         nmc4g3A4ZlkyoELjEtqnC++AB8FfxfWn/cF61ogOIUZJK3nRq5K2LUyfhUx+ESxbWDuf
         3+VsPvIVp4oqqxobgJMY3pZcUueudjF/FdXpP8xEjQ1lJeY7wI5io2cKzpU+qbkg8kIh
         MIfwLt/qnLxkOZVMNVmJHyI4PwjrJlWbFGMGdW2WqgakQMSiSEsbeVu3B+9JtGHcSqhj
         B9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2nYUPty6npzIPJSOn+ItpOaTOlsER8woDmxJG1XffM=;
        b=EhF7odVxy/p+Iv22Ye84Nf12IURB/ikpn1aukC68LjqwkDKBghLyB8r2H0bwpti1ot
         zuyyFmiyxuRtVkCImsbmk3sRQdTczZigMuZ7KkANB8RxtIRmkypdugFt/TN5Y6RYU8A2
         inBZli7rEZWfGlHVha+VVp+YYE1Zd997aqugAli20njtxNka63IWDaIQIbRltKNdKBvR
         jwK/HU030dzL7P8nCYoK13r8WkrPfr/Ev7CJ5qxVnakAlbk7C3NZo1TbEctOja33XPp2
         MYR1t06zVDnnz+ZOYMaONebmRtvHADp++dX1u6KyO/kvHv/kfi08tUFGTd3ZZR2nk1LM
         wWqA==
X-Gm-Message-State: AOAM532+sbfMGb3zDaPFonlOfqIAWBlfUdyTkdODCQcgtP1/9jPmS6Qw
        UdlQdeUKlasF6PV1HwfdnseAgT5YR5Pla4ZjvSz7Ow==
X-Google-Smtp-Source: ABdhPJw+flcER7w5ooSWNVLZRSfkYCFp5V/UiwmbKlmcsdkdlI8LiWBRV/aMg4lUOPWfrh6TF+Ek3w3dIcR5+Mn+dP0=
X-Received: by 2002:ac2:4c4b:: with SMTP id o11mr22030108lfk.253.1643788813251;
 Wed, 02 Feb 2022 00:00:13 -0800 (PST)
MIME-Version: 1.0
References: <CAHTsKTdSyC7Jwk56tDR8QwM_oO13ByBRaA78VpHymOZ7J4NQ9Q@mail.gmail.com>
 <CAJZ5v0jrU4Xw2wzdUL9Vd2C6u8NVx5J79DeiRY6KU1xT6ZSuqw@mail.gmail.com>
 <CAJZ5v0gLMSPsaS7Jnsr8DhevaQamsVk=pu=BfXZxrT+SBAM=fQ@mail.gmail.com>
 <CAHTsKTc0M0wDLVJovzO01z1B9iOSc4cHcS4tNffykna3c=9eJQ@mail.gmail.com> <CAJZ5v0i9GFvWTpyREjA+Czs_1xvVzFo8XGY=dKeor6Dgy5EOcg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i9GFvWTpyREjA+Czs_1xvVzFo8XGY=dKeor6Dgy5EOcg@mail.gmail.com>
From:   Kelly Rossmoyer <krossmo@google.com>
Date:   Tue, 1 Feb 2022 23:59:36 -0800
Message-ID: <CAHTsKTfJz3xaU9Fao=ftf+eevHaRcBPJ2GROdDSgNMZifvd+qg@mail.gmail.com>
Subject: Re: [RFC] PM: suspend: Upstreaming wakeup reason capture support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Vijay Nayak <nayakvij@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zichar Zhang <zichar.zhang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Zichar, to try to pull the threads together.

On Sun, Jan 30, 2022 at 6:46 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Jan 29, 2022 at 9:27 AM Kelly Rossmoyer <krossmo@google.com> wrote:
> >
> > On Thu, Jan 27, 2022 at 12:10 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > That said, the general idea behind wakeup_source objects is that every
> > > system wakeup event should be recorded in one of them which then can
> > > be used for later analysis.
> > >
> > > If there are reasons why this cannot work in general, what are they?
> >
> > I won't presume to say that it "cannot work in general."  Nearly everyone on
> > this thread has more expertise here than I do, and I'm keenly aware of how
> > much I don't know.  :-)
> >
> > What I will say is that - across the chips and architectures I've worked upon
> > over the last few years - that concept has not appeared to match observed
> > reality.  From what I've seen (which is a very narrow slice of the Linux
> > universe, but I suspect is at least pretty representative of Android):
> > * resumes from successful suspends are typically accompanied by a flurry of
> >   wakesource activity from which it is not possible to determine what actually
> >   caused the resume (despite last changed timestamps)
>
> So I wonder how you are going to determine what actually caused the
> resume reliably.

I don't have the cross-platform/cross-arch experience to know if this is
broadly applicable, but right now what we're doing is taking:
* the first suspend abort reason that was captured if there was one, or if
  not...
* all pending wakeup-armed IRQs, if there are any, or if not...
* the first non-IRQ, non-abort reason logged, which mostly tends to emerge
  from platform-specific code (e.g. the Foo logic block decided it was
  time to power on for reasons that aren't reflected in any IRQs)

> > * resumes that aren't accompanied by wakeup-armed IRQs can be even
> >   less well-reflected by wakesource activity
>
> Do you have examples of these other than the aborts mentioned below?

Nothing super detailed, as my area of power work has only gotten down to
relatively high-level portions of the kernel as opposed to lower-level SOC
architecture.  But two examples that come to mind include:
* a secure watchdog interrupt fires, which wakes up a hypervisor that
  handles and clears the interrupt, leaving no IRQ pending by the time
  kernel execution resumes
* power control logic outside of the CPUs decides to turn CPU clusters
  back on to support a use case currently driven by other logic on the
  chip that doesn't involve any wakeup-armed IRQs (this could plausibly be
  something like a low-power logic block that handles audio playback
  causing the CPUs to be woken up so it can receive the next several
  seconds of audio data to buffer up before the kernel suspends again)

> > * I believe inferring wakeup reasons from wakesource stats would require
> >   having a snapshot from the last moment prior to suspend, which seems
> >   unsolvable from userspace
>
> That can be addressed by extending the wakeup sources in principle.
>
> > * suspend aborts (which can be even more harmful for battery life than
> >   "true" wakeups) are often caused by things that aren't reflected by specific
> >   wakesources (e.g. a driver failing to suspend)
>
> Which again can be addressed by using special wakeup sources for
> registering these "wakeups"  or similar.

Do you have the outline of a concept in mind, or is this more about the
general principle of extending what's there vs. adding something new?
(Apologies if what you're alluding to should be clear to me... I'm afraid
I don't have the relevant experience to envision what this could look like.)

> > And as I mentioned in my reply to Zichar, this isn't solely about
> > troubleshooting.  There's a lot of room to improve on user-focused power
> > attribution, and I'm hoping to build change in that direction upon the same
> > foundation.  Having the best possible data about "why we're awake" serves both
> > goals.
>
> Generally speaking, there is one wakeup-related framework in the
> kernel (wakeup sources) and you want to add another one sort of on top
> of it and it is still quite unclear to me what can be done with the
> new framework that cannot be achieved with the old one (possibly with
> some extensions),

I guess my (neophytic) impression has been that there are actually already
three frameworks (not just one) for wakeup-related data (where "wakeup" in
this sense is "the reason(s) we aren't suspended", including aborts):
* wakeup_source stats
* pm_wakeup_irq
* suspend_stats

And if those were extended, such that:
* the name of the last active wakeup_source was exposed to userspace
  to decode suspend aborts due to wakeup_count changes
* pm_wakeup_irq captured potentially multiple pending wakeup_armed
  IRQs during resume instead of just one
* some sense of causation was added to wakeup_sources to enable their
  use for non-IRQ resume causes (e.g. PM core outside of the CPUs
  turned CPUs back on for reasons that only platform logic can decode
  and report)
* the userspace interface to wakeup_source stats wasn't so flawed

Then very determined userspace code could combine those things with their
pre-suspend-attempt states and the fourth key piece of data (the return
value from the write to /sys/power/state, assuming kernel autosuspend
isn't used) to put together something that would be close to what the
Android wakeup_reason code is doing.  And then it would break because
there's nothing in the kernel tying those different pieces together in a
cohesive way that's guaranteed to work with some degree of stability.

> Let's first talk about the specific problems to address and then we'll
> decide whether or not we need yet another piece of infrastructure to
> address them.

I'm probably being overly optimistic, but my intention is more to tie
together and shore up the gaps in existing pieces that are currently
disjoint and incomplete, as opposed to just throwing yet another
framework into the mix.

--

Kelly Rossmoyer | Software Engineer | krossmo@google.com
