Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FF2493F07
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356389AbiASR0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbiASR0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:26:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E05C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:26:54 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c66so6507085wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SEZuid1kBdUhkeCpk54LJW3gbPrX55D+4zhbEvARjRw=;
        b=OsIaM/vzswRNN97ZqsOpKgGxJry0M6NaTwqFj/J27sTZw9N/4c0NNC5JB5nDiKbJQL
         YCHveYFW1+VXOK9vxJ1IiTxp5XSkgGU/v6O3O/jJzcKGPweZlZWLmtbdOX0SHCzloYms
         YYQNCuemIOJ+46aZwsoV6I3/bR8wpoLpoQmafarZM5abWGoeJ+XVWAS3pya/vctHbgen
         li7iEOhHp67hE7vCd/93AllAkBK32Bp49EPEpE8VlhW85EGfUwiV43i67meEOCNHCHYb
         HO5yvEAHZP2zoDrmSb1Os+71jKUmhOJ9ZXpQT/IDnh379Cl8HmoQbNvGre+E4gqqvzlm
         KG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEZuid1kBdUhkeCpk54LJW3gbPrX55D+4zhbEvARjRw=;
        b=yNDLvy2ZkgKtyIiP38x7dlgDmkfcJ6cuZI2AaMMyNw1knEKzmL22RNO8sMbb+PFMid
         9FXjFwurSBirclKl/yk6SQvn4613OQnh5X64ccIjGH+RAuX+wkN6baHhkZSnFcsHPrUv
         p1KSfn3Y4H99z12Yj7vfVKij+Ll4jnapS4WTxXBJe5wJfyCBAe+BsvScb3W7FPZksZG/
         LKmaXFpqI7aPREQsW22nte1dbW8cE5NnpH9s8BSBqr5pVswrGKVKLkpD9Uig2Lg56+gY
         4VuNdcmCI9/tCeRbQD2zc9gaDdYvCsM++QOPpoFkWe7S9Y3y+1B+vz7WZCpPwg/T2Oup
         gOGg==
X-Gm-Message-State: AOAM5334kkdWmU5mmc8fJXgtJ/KCRI7GbSzCTXrmk3keKmZOTyMig/um
        +s34/hbopvgbuxRzRcyVAP+5dTsSpC9Ak5zmPMe6lw==
X-Google-Smtp-Source: ABdhPJygQoMrxaannmaE5oT8T2OCMfl70EeVNcl0JCuLJ00UC5fpSLM5m4bqGDsG3gjYlaSNGCjT/Cf2e9JudNHX1SE=
X-Received: by 2002:a1c:a70f:: with SMTP id q15mr4540357wme.78.1642613212579;
 Wed, 19 Jan 2022 09:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20211122211327.5931-1-posk@google.com> <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net> <CAFTs51XnN+N74i1XHvRUAUWd04-Fs9uV6ouXo=CQSQs8MaEM5A@mail.gmail.com>
 <YaUCoe07Wl9Stlch@hirez.programming.kicks-ass.net> <CAFTs51UzR=m6+vcjTCNOGwGu3ZwB5GMrg+cSQy2ecvCWxhZvEQ@mail.gmail.com>
 <Ya34S2JCQg+81h4t@hirez.programming.kicks-ass.net>
In-Reply-To: <Ya34S2JCQg+81h4t@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Wed, 19 Jan 2022 09:26:41 -0800
Message-ID: <CAPNVh5eYinGEK2Ece45fLYzU8hMWiqAzVdVbdFxd-P5fPXuFSA@mail.gmail.com>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 3:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 29, 2021 at 09:34:49AM -0800, Peter Oskolkov wrote:
> > On Mon, Nov 29, 2021 at 8:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > Also, timeout on sys_umcg_wait() gets you the exact same situation (or
> > > worse, multiple running workers).
> >
> > It should not. Timed out workers should be added to the runnable list
> > and not become running unless a server chooses so. So sys_umcg_wait()
> > with a timeout should behave similarly to a normal sleep, in that the
> > server is woken upon the worker blocking, and upon the worker wakeup
> > the worker is added to the woken workers list and waits for a server
> > to run it. The only difference is that in a sleep the worker becomes
> > BLOCKED, while in sys_umcg_wait() the worker is RUNNABLE the whole
> > time.
> >
> > Why then have sys_umcg_wait() with a timeout at all, instead of
> > calling nanosleep()? Because the worker in sys_umcg_wait() can be
> > context-switched into by another worker, or made running by a server;
> > if the worker is in nanosleep(), it just sleeps.
>
> I've been trying to figure out the semantics of that timeout thing, and
> I can't seem to make sense of it.
>
> Consider two workers:
>
>         S0 running A                            S1 running B
>
> therefore:
>
>         S0::state == RUNNABLE                   S1::state == RUNNABLE
>         A::server_tid == S0.tid                 B::server_tid = S1.tid
>         A::state == RUNNING                     B::state == RUNNING
>
> Doing:
>
>         self->state = RUNNABLE;                 self->state = RUNNABLE;
>         sys_umcg_wait(0);                       sys_umcg_wait(10);
>           umcg_enqueue_runnable()                 umcg_enqueue_runnable()

sys_umcg_wait() should not enqueue the worker as runnable; workers are
enqueued to indicate wakeup events.

>           umcg_wake()                             umcg_wake()
>           umcg_wait()                             umcg_wait()
>                                                     hrtimer_start()
>
> In both cases we get the exact same outcome:
>
>         A::state == RUNNABLE                    B::state == RUNNABLE
>         S0::state == RUNNING                    S1::state == RUNNING
>         S0::runnable_ptr == &A                  S1::runnable_ptr = &B

So without sys_umcg_wait enqueueing into the queue, the state now is

         A::state == RUNNABLE                    B::state == RUNNABLE
         S0::state == RUNNING                    S1::state == RUNNING
         S0::runnable_ptr == NULL                  S1::runnable_ptr = NULL

>
>
> Which is, AFAICT, the exact state you wanted to achieve, except B now
> has an active timer, but what do you want it to do when that goes?

When the timer goes off, _then_ B is enqueued into the queue, so the
state becomes

         A::state == RUNNABLE                    B::state == RUNNABLE
         S0::state == RUNNING                    S1::state == RUNNING
         S0::runnable_ptr == NULL                  S1::runnable_ptr = &B

So worker timeouts in sys_umcg_wait are treated as wakeup events, with
the difference that when the worker is eventually scheduled by a
server, sys_umcg_wait returns with ETIMEDOUT.

>
> I'm tempted to say workers cannot have timeout, and servers can use it
> to wake themselves.
