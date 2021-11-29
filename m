Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B552462614
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhK2Wq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhK2WoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:44:18 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41E8C111CC4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:35:00 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id y5so35691812ual.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIjIIVQ7ixbmozsrjR12LGtgUYz5Lx+js9nwRfEIfrg=;
        b=AmEDvqhfrEDGrX1BMjsYRbs+39o1Cqcb9JBdMjjMmN7M2u6rtZGl3AjbguSjTheOmk
         p0HJs9eVoy4TYLUjFVMnItXYGnpN9HCx7OivXS7PFr9NdVxU//cTUHcthRpy814/fTX6
         Slp6YSPYzPEn2zsejVljLNcYGGVv3aCKv1/hKnCuHUZ1BbfOR8Y1+c0PZKPrJN/IH3sw
         /f42MtBKUJfFtsRI7BwxZFcyE5bylBONRDfaGSOsZUc3W8Gdi812yrk+xaPUtAk5no/k
         AuiEHtCa5/5u8wv4ae6e1MRaLfFvNl4GPez8d7Ja6RMiV36DuYG3eqwRRLfEHFtXbAmV
         FrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIjIIVQ7ixbmozsrjR12LGtgUYz5Lx+js9nwRfEIfrg=;
        b=4XVwDpVxVyinLfbeJ7Zco+ksGqlSPuv8SvQGQ7A2PRM210Gb6Skqv/lvvyMF6rFQaG
         HkI5tBheZ97VAmKe2m2lY3TTy/PtVoVwXOd4aYPmBdtpSuCR8Qd6rkcBNWNZsMIpa/tc
         +thTiB4YcFXmg/jovLA+vrTOajWWXulTxVQnvDskCvxXsqGcL/7GxXingyS7D1Kq/Mu5
         VSZZ45mYt1mjAiq6jaiCmgJLUxl8qJk2V7k4SNWhDSZicakBy9PxdLYERUbRFzQFGlF9
         /kaSu53YwIZW5+UcdwTED/589PxgmNqqRn7xuIfscp9XpOfqF6a2hOJpBRkWe3V9eQ6V
         rZxw==
X-Gm-Message-State: AOAM531NF+lvT/luZ2KOfkfereGtImyBVIRuvLtMi6F9x74mUO9jUgCj
        43RQE8QZu1D/yNg12z6RIJJ0p2+ID0718GQsByotFQ==
X-Google-Smtp-Source: ABdhPJxuhBgPB2YEkaeqdK/gbS/Jsd69sgWzbw+8KZ3pYwtUMiRiS/2drBV7Q8k+ucoGPY3fGhPvsGWzG1SJHJxN3X4=
X-Received: by 2002:ab0:6f4f:: with SMTP id r15mr51378074uat.17.1638207299827;
 Mon, 29 Nov 2021 09:34:59 -0800 (PST)
MIME-Version: 1.0
References: <20211122211327.5931-1-posk@google.com> <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net> <CAFTs51XnN+N74i1XHvRUAUWd04-Fs9uV6ouXo=CQSQs8MaEM5A@mail.gmail.com>
 <YaUCoe07Wl9Stlch@hirez.programming.kicks-ass.net>
In-Reply-To: <YaUCoe07Wl9Stlch@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@posk.io>
Date:   Mon, 29 Nov 2021 09:34:49 -0800
Message-ID: <CAFTs51UzR=m6+vcjTCNOGwGu3ZwB5GMrg+cSQy2ecvCWxhZvEQ@mail.gmail.com>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 8:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Nov 28, 2021 at 04:29:11PM -0800, Peter Oskolkov wrote:
>
> > wait_wake_only is not needed if you have both next_tid and server_tid,
> > as your patch has. In my version of the patch, next_tid is the same as
> > server_tid, so the flag is needed to indicate to the kernel that
> > next_tid is the wakee, not the server.
>
> Ah, okay.
>
> > re: (idle_)server_tid_ptr: it seems that you assume that blocked
> > workers keep their servers, while in my patch they "lose them" once
> > they block, and so there should be a global idle server pointer to
> > wake the server in my scheme (if there is an idle one). The main
> > difference is that in my approach a server has only a single, running,
> > worker assigned to it, while in your approach it can have a number of
> > blocked/idle workers to take care of as well.
>
> Correct; I've been thinking in analogues of the way we schedule CPUs.
> Each CPU has a ready/run queue along with the current task.
> fundamentally the RUNNABLE tasks need to go somewhere when all servers
> are busy. So at that point the previous server is as good a place as
> any.
>
> Now, I sympathise with a blocked task not having a relation; I often
> argue this same, since we have wakeup balancing etc. And I've not really
> thought about how to best do wakeup-balancing, also see below.
>
> > The main difference between our approaches, as I see it: in my
> > approach if a worker is running, its server is sleeping, period. If we
> > have N servers, and N running workers, there are no servers to wake
> > when a previously blocked worker finishes its blocking op. In your
> > approach, it seems that N servers have each a bunch of workers
> > pointing at them, and a single worker running. If a previously blocked
> > worker wakes up, it wakes the server it was assigned to previously,
>
> Right; it does that. It can check the ::state of it's current task,
> possibly set TF_PREEMPT or just go back to sleep.
>
> > and so now we have more than N physical tasks/threads running: N
> > workers and the woken server. This is not ideal: if the process is
> > affined to only N CPUs, that means a worker will be preempted to let
> > the woken server run, which is somewhat against the goal of letting
> > the workers run more or less uninterrupted. This is not deal breaking,
> > but maybe something to keep in mind.
>
> I suppose it's easy enough to make this behaviour configurable though;
> simply enqueue and not wake.... Hmm.. how would this worker know if the
> server was 'busy' or not? The whole 'current' thing is a user-space
> construct. I suppose that's what your pointer was for? Puts an actual
> idle server in there, if there is one. Let me ponder that a bit.

Yes, the idle_server_ptr was there to point to an idle server; this
naturally did wakeup balancing.

>
> However, do note this whole scheme fundamentally has some of that, the
> moment the syscall unblocks until sys_exit is 'unmanaged' runtime for
> all tasks, they can consume however much time the syscall needs there.
>
> Also, timeout on sys_umcg_wait() gets you the exact same situation (or
> worse, multiple running workers).

It should not. Timed out workers should be added to the runnable list
and not become running unless a server chooses so. So sys_umcg_wait()
with a timeout should behave similarly to a normal sleep, in that the
server is woken upon the worker blocking, and upon the worker wakeup
the worker is added to the woken workers list and waits for a server
to run it. The only difference is that in a sleep the worker becomes
BLOCKED, while in sys_umcg_wait() the worker is RUNNABLE the whole
time.

Why then have sys_umcg_wait() with a timeout at all, instead of
calling nanosleep()? Because the worker in sys_umcg_wait() can be
context-switched into by another worker, or made running by a server;
if the worker is in nanosleep(), it just sleeps.

>
> > Another big concern I have is that you removed UMCG_TF_LOCKED. I
>
> OOh yes, I forgot to mention that. I couldn't figure out what it was
> supposed to do.
>
> > definitely needed it to guard workers during "sched work" in the
> > userspace in my approach. I'm not sure if the flag is absolutely
> > needed with your approach, but most likely it is - the kernel-side
> > scheduler does lock tasks and runqueues and disables interrupts and
> > migrations and other things so that the scheduling logic is not
> > hijacked by concurrent stuff. Why do you assume that the userspace
> > scheduling code does not need similar protections?
>
> I've not yet come across a case where this is needed. Migration for
> instance is possible when RUNNABLE, simply write ::server_tid before
> ::state. Userspace just needs to make sure who actually owns the task,
> but it can do that outside of this state.
>
> But like I said; I've not yet done the userspace part (and I lost most
> of today trying to install a new machine), so perhaps I'll run into it
> soon enough.

The most obvious scenario where I needed locking is when worker A
wants to context switch into worker B, while another worker C wants to
context switch into worker A, and worker A pagefaults. This involves:

worker A context: worker A context switches into worker B:

- worker B::server_tid = worker A::server_tid
- worker A::server_tid = none
- worker A::state = runnable
- worker B::state = running
- worker A::next_tid = worker B
- worker A calls sys_umcg_wait()

worker B context: before the above completes, worker C wants to
context switch into worker A, with similar steps.

"interrupt context": in the middle of the mess above, worker A pagefaults

Too many moving parts. UMCG_TF_LOCKED helped me make this mess
manageable. Maybe without pagefaults clever ordering of the operations
listed above could make things work, but pagefaults mess things badly,
so some kind of "preempt_disable()" for the userspace scheduling code
was needed, and UMCG_TF_LOCKED was the solution I had.



>
>
