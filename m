Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6393B47667B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhLOX0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhLOX0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:26:33 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8449C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:26:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j9so8749290wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWEO4+lOEaRD/eaLAldY1rujZBp501QLD0CtTf2OGKA=;
        b=Wwg0Zje4gwnyDqzh6zBIkVcOEeg1o9Yay/pTmAgzONLQN+nlRUYC1VRinffQ9rwEvZ
         FIy8AVONbOxsS6nJh30y7I9KC2LLiFw/QncF9XjD5vpRyzwCwr7iTUDc9hA1U/Nsph4g
         Jn9hR5KE/kgsIbkRKVgflH0LwhnERJFi0FTSXdkkXKYnfN7nwrV6lYD2vFrNiK8clZIw
         QvGpfmYKPsA44l6MZ8zQZg9O9aLtq4u3AVprrjiUw+rbmHHmnvGNaG5DgZ733L+mBl6q
         I2TKNE66D1maqk92/Ot9v6UO6fzNyG452yZFHwzXovtaKnMahpvNAB3YKpqCRqdCc42I
         ojzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWEO4+lOEaRD/eaLAldY1rujZBp501QLD0CtTf2OGKA=;
        b=Hd719nOGKqc8t+X5xzaZb+q/Udke8QLvo28shzzLrccf3HAm3VAhZ/vXsoTzaiFvy/
         0QVpTSmFF57Oc/lZC7yQSfXXpcW1amxNa6WdmFx6fuIOEBbzsyMpfolSBJVGm0amQC+U
         QkV5y4XvtGk+7yQ2vtFT9XbO/2MVGVa3tvDYMW76G4OZIukKMH2oOXD3kgRlxDkBnJIm
         w7Tx8RQIf1RaUxY8ISXuKYOOjZeXcFQ3ZUkRrAGGzOBXFQywe2dGrj1MRFKCOlBvcTIR
         1DXkebBwtgLlIUj6q4oKx9UT8cimPNP2o4x9W2VxO1QY79abLn9ypqXO38sr0P46KewA
         eMeg==
X-Gm-Message-State: AOAM532uKN+lAL2ZSn06cFO+PHAWRkqeVoR7w63rdr8lhjiuWcyjBuHt
        bKmnJBOEuuphPVa7GjiscHOED7j0hx8HMZmYnGXSpQ==
X-Google-Smtp-Source: ABdhPJwEeohnXfddqmmLfWY+PzER4jE5agUTbIOZPR/cQUXqFmsd9PLsQpxGAjQnucUxh/dXB006eBPsmx3o86OTQeo=
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr6698308wrn.82.1639610790378;
 Wed, 15 Dec 2021 15:26:30 -0800 (PST)
MIME-Version: 1.0
References: <20211214204445.665580974@infradead.org> <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
 <Ybm+HJzkO/0BB4Va@hirez.programming.kicks-ass.net> <CAFTs51Xb6m=htpWsVk577n-h_pRCpqRcBg6-OhBav8OadikHkw@mail.gmail.com>
 <YboxjUM+D9Kg52mO@hirez.programming.kicks-ass.net> <CAPNVh5cJy2y+sTx0cPA1BPSAg=GjXC8XGT7fLzHwzvXH2=xjmw@mail.gmail.com>
 <20211215222524.GH16608@worktop.programming.kicks-ass.net>
In-Reply-To: <20211215222524.GH16608@worktop.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Wed, 15 Dec 2021 15:26:19 -0800
Message-ID: <CAPNVh5cfoehYpOu2PE59L3_yxmZaXgJ6oC1eg923rmaiK4f87A@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] sched: User Managed Concurrency Groups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, x86@kernel.org,
        Paul Turner <pjt@google.com>, Andrei Vagin <avagin@google.com>,
        Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 2:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Dec 15, 2021 at 11:49:51AM -0800, Peter Oskolkov wrote:
>
> > TL;DR: our models are different here. In your model a single server
> > can have a bunch of workers interacting with it; in my model only a
> > single RUNNING worker is assigned to a server, which it wakes when it
> > blocks.
>
> So part of the problem is that none of that was evident from the code.
> It is also completely different from the scheduler code it lives in,
> making it double confusing.
>
> After having read the code, I still had no clue what so ever how it was
> supposed to be used. Which is where my reverse engineering started :/

I posted a doc patch:
https://lore.kernel.org/lkml/20211122211327.5931-6-posk@google.com/
a lib patch with userspace code:
https://lore.kernel.org/lkml/20211122211327.5931-5-posk@google.com/
and a doc patch for the lib/userspace code:
https://lore.kernel.org/lkml/20211122211327.5931-7-posk@google.com/

I spent at least two weeks polishing the lib patch and the docs, much
more if previous patchsets are to be taken into account. Yes, they are
confusing, and most likely answer all of the wrong questions, but I
did try to make my approach as clear as possible... I apologize if
that was not very successful...

>
> > More details:
> >
> > "Working servers" cannot get wakeups, because a "working server" has a
> > single RUNNING worker attached to it. When a worker blocks, it wakes
> > its attached server and becomes a detached blocked worker (same is
> > true if the worker is "preempted": it blocks and wakes its assigned
> > server).
>
> But who would do the preemption if the server isn't allowed to run?
>
> > Blocked workers upon wakeup do this, in order:
> >
> > - always add themselves to the runnable worker list (the list is
> > shared among ALL servers, it is NOT per server);
>
> That seems like a scalability issue. And, as said, it is completely
> alien when compared to the way Linux itself does scheduling.
>
> > - wake a server pointed to by idle_server_ptr, if not NULL;
> > - sleep, waiting for a wakeup from a server;
> >
> > Server S, upon becoming IDLE (no worker to run, or woken on idle
> > server list) does this, in order, in userspace (simplified, see
> > umcg_get_idle_worker() in
> > https://lore.kernel.org/lkml/20211122211327.5931-5-posk@google.com/):
> > - take a userspace (spin) lock (so the steps below are all within a
> > single critical section):
>
> Don't ever suggest userspace spinlocks, they're horrible crap.

This can easily be a mutex, not really important (although for very
short critical sections with only memory reads/writes, like here, spin
locks often perform better, in our experience).

>
> > - compare_xchg(idle_server_ptr, NULL, S);
> >   - if failed, there is another server in idle_server_ptr, so S adds
> > itself to the userspace idle server list, releases the lock, goes to
> > sleep;
> >   - if succeeded:
> >     - check the runnable worker list;
> >         - if empty, release the lock, sleep;
> >         - if not empty:
> >            - get the list
> >            - xchg(idle_server_ptr, NULL) (either S removes itself, or
> > a worker in the kernel does it first, does not matter);
> >            - release the lock;
> >            - wake server S1 on idle server list. S1 goes through all
> > of these steps.
> >
> > The protocol above serializes the userspace dealing with the idle
> > server ptr/list. Wakeups in the kernel will be caught if there are
> > idle servers. Yes, the protocol in the userspace is complicated (more
> > complicated than outlined above, as the reaped idle/runnable worker
> > list from the kernel is added to the userspace idle/runnable worker
> > list), but the kernel side is very simple. I've tested this
> > interaction extensively, I'm reasonably sure that no worker wakeups
> > are lost.
>
> Sure, but also seems somewhat congestion prone :/

The whole critical section under the loc is just several memory
read/write operations, so very short. And workers are removed from the
kernel's list of runnable/woken workers all at once; and the server
processing the runnable worker list knows how many of them are now
available to run, so the appropriate number of idle servers can be
woken (not yet implemented in my lib patch). So yes, this can be a
bottleneck, but there are ways to make it less and less likely (by
making the userspace more complicated; but this is not a concern).
