Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC11F476687
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhLOXbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLOXbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:31:19 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93957C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:31:18 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o29so17792457wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R01CyzImEjFqZlRPtnyEgfL839FtsDcyz8TSbqLjGFA=;
        b=evsTmw35JcLTmGyu4ktOcI/D45kYtnqmxiTtsjofteT1Ro0kvTt1TsvD/g5gOhFwaZ
         vXr6Yx/o/RL60AI/wSekM2lWX7wXUX8DChM9E7f17YuqyDZzlQc7ReFSaFyBoV1lfZIX
         dLsDMg3duOSvIJWYjdCUwfA9eLIq1+hDnWq1+IucqX34XvvSYioZxDPLVrjhfAgQkgc8
         CPoIpYbjCk6LzRVvYxmXWOFhRXfNx8JwGFceZsS9YzPiYlsBgJYEBlOkJsV7SfZWXAGv
         OP2WTSNa0SxJ23gIuAX/4r1ycpBqyhBJ7trFQtdKQR0mTlQBqA7h+43bF5ir2An2avwB
         LdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R01CyzImEjFqZlRPtnyEgfL839FtsDcyz8TSbqLjGFA=;
        b=wEBM05Fiau7dhqD+AN6ZBngWrrYfu7oOSfMKn8SqOUGcDXMFs6wPmk/JyOs8kHjWQT
         7dP4h9+/6Lq6F7Os49F3RqILFkE+mTu7zHLBJYbR4UXsSuCTfKUyjU7vrDGKJ6Inpw1y
         FvJHYbLx4ovtIhyi6CwlnO02u3kwfASEpQmbww2CQOxCSXbLfatzdF/euvJISjkqp2RO
         nEzWSBERzNwpEPUgtQ2xGCJammL567rg7AmqSMdHtFY3Wt76rFP3b7mwAdqKoqBguhRA
         h7Lib9mwdlHI7jl0hZJplUcMeZG2v65XMaK/dGi+lbEixHI81NtjFIwUJr6RKVyoUZQZ
         HUaA==
X-Gm-Message-State: AOAM531waUwzmb8tn9SyptsIeXdMOTEcBZIJz+Fh9NFMm3/kne2Ut1Q5
        1mxk4NugTllEM/zV9UdGXAUBYVyi53KsLYMteK2k5A==
X-Google-Smtp-Source: ABdhPJwNpfYJQt9YTrP3W12SE2315MvdZQZm2bvTPjAl3TvpeWxQZRls3fMraY5/+CEZyDhvHM2aOMB2ZazAa1IHThk=
X-Received: by 2002:a7b:ce9a:: with SMTP id q26mr2382597wmj.145.1639611076818;
 Wed, 15 Dec 2021 15:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20211214204445.665580974@infradead.org> <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
 <Ybm+HJzkO/0BB4Va@hirez.programming.kicks-ass.net> <CAFTs51Xb6m=htpWsVk577n-h_pRCpqRcBg6-OhBav8OadikHkw@mail.gmail.com>
 <YbozBSLk4PytGp0J@hirez.programming.kicks-ass.net> <CAPNVh5fenLG7uvdF1tjyfcOe8Ff3_L0-UqeCu9=tn-NMaJ3ikA@mail.gmail.com>
 <20211215231610.GI16608@worktop.programming.kicks-ass.net>
In-Reply-To: <20211215231610.GI16608@worktop.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Wed, 15 Dec 2021 15:31:05 -0800
Message-ID: <CAPNVh5cpsxiyDr45hzuUsmbEcTTQbVSug91H48x197a6__RjaQ@mail.gmail.com>
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

On Wed, Dec 15, 2021 at 3:16 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Dec 15, 2021 at 01:04:33PM -0800, Peter Oskolkov wrote:
> > On Wed, Dec 15, 2021 at 10:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Dec 15, 2021 at 09:56:06AM -0800, Peter Oskolkov wrote:
> > > > On Wed, Dec 15, 2021 at 2:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > >  /*
> > > > > + * Enqueue tsk to it's server's runnable list and wake the server for pickup if
> > > > > + * so desired. Notable LAZY workers will not wake the server and rely on the
> > > > > + * server to do pickup whenever it naturally runs next.
> > > >
> > > > No, I never suggested we needed per-server runnable queues: in all my
> > > > patchsets I had a single list of idle (runnable) workers.
> > >
> > > This is not about the idle servers..
> > >
> > > So without the LAZY thing on, a previously blocked task hitting sys_exit
> > > will enqueue itself on the runnable list and wake the server for pickup.
> >
> > How can a blocked task hit sys_exit()? Shouldn't it be RUNNING?
>
> Task was RUNNING, hits schedule() after passing through sys_enter().
> this marks it BLOCKED. Task wakes again and proceeds to sys_exit(), at
> which point it's marked RUNNABLE and put on the runnable list. After
> which it'll kick the server to process said list.
>

Ah, you are talking about sys_exit hook; sorry, I thought you talked
about the exit() syscall.

[...]

>
> Well, that's *your* use-case. I'm fairly sure there's more people that
> want to use this thing.
>
> > multiple
> > priorities and work isolation: these are easy to address directly with
> > a scheduler that has a global view rather than multiple
> > per-cpu/per-server schedulers/queues that try to coordinate.
>
> You can trivially create this, even if the underlying thing is
> per-server. Simply have a lock and shared data structure between the
> servers.
>
> Even in the kernel, it should be mostly trivial to create a global
> policy. The only tricky bit (in the kernel) is the whole affinity muck,
> but userspace doesn't *need* to do even that.
>
> > > LAZY enables that.. *however* it does need to wake the server when it is
> > > idle, otherwise they'll all sit there waiting for one another.
> >
> > If all servers are busy running workers, then it is not up to the
> > kernel to "preempt" them in my model: the userspace can set up another
> > thread/task to preempt a misbehaving worker, which will wake the
> > server attached to it.
>
> So the way I'm seeing things is that the server *is* the 'CPU'. A UP
> machine cannot rely on another CPU to make preemption happen.
>
> Also, preemption is very much not about misbehaviour. Wakeup can cause a
> preemption event if the woken task is deemed higher priority than the
> current running one for example.
>
> And time based preemption is definitely also a thing wrt resource
> distribution.
>
> > But in practice there are always workers
> > blocking in the kernel, which wakes their servers, which then reap the
> > woken/runnable workers list, so well-behaving code does not need this.
>
> This seems to discount pure computational workloads.
>
> > And so we need to figure out this high-level thing first: do we go
> > with the per-server worker queues/lists, or do we go with the approach
> > I use in my patchset? It seems to me that the kernel-side code in my
> > patchset is not more complicated than your patchset is shaping up to
> > be, and some things are actually easier to accomplish, like having a
> > single idle_server_ptr vs this LAZY and/or server "preemption"
> > behavior that you have.
> >
> > Again, I'm OK with having it your way if all needed features are
> > covered, but I think we should be explicit about why
> > per-server/per-cpu model is chosen vs the one I proposed, especially
> > as it seems the kernel side code is not really simpler in the end.
>
> So I went with a UP first approach. I made single server preemption
> driven scheduling work first (both tick and wakeup-preemption are
> supported).

I agree that the UP approach is better than the LAZY one if we have
per-server/per-cpu worker queues.

>
> The whole LAZY thing is only meant to supress some of that (notably
> wakeup preemption), but you're right in that it's not really nice. I got
> it working, but I'm not particularly happy with it either.
>
> Having the sys_enter/sys_exit hooks also made the page pins short lived,
> and signals much simpler to handle. You're destroying signals IIUC.
>
>
> So I see no fundamental reason why userspace cannot do something like:
>
>         struct umcg_task *current = NULL;
>
>         for (;;) {
>                 self->state = UMCG_TASK_RUNNABLE | UMCG_TF_COND_WAIT;
>
>                 runnable_ptr = (void *)__atomic_exchange_n(&self->runnable_workers_ptr,
>                                                            NULL, __ATOMIC_SEQ_CST);
>
>                 pthread_mutex_lock(&global_queue.lock);
>                 while (runnable_ptr) {
>                         next = (void *)runnable_ptr->runnable_workers_ptr;
>                         enqueue_task(&global_queue, runnable_ptr);
>                         runnable_ptr = next;
>                 }
>
>                 /* complicated bit about current already running goes here */
>
>                 current = pick_task(&global_queue);
>                 self->next_tid = current ? current->tid : 0;
> unlock:
>                 pthread_mutex_unlock(&global_queue.lock);
>
>                 ret = sys_umcg_wait(0, 0);
>
>                 pthread_mutex_lock(&global_queue.lock);
>                 /* umcg_wait() didn't switch, make sure to return the task */
>                 if (self->next_tid) {
>                         enqueue_task(&global_queue, current);
>                         current = NULL;
>                 }
>                 pthread_mutex_unlock(&global_queue.lock);
>
>                 // do something with @ret
>         }
>
> to get global scheduling and all the contention^Wgoodness related to it.
> Except, of course, it's more complicated, but I think the idea's clear
> enough.

Let me spend some time and see if I can make all of this work together
beyond simple tests. With the upcoming holidays and some other things
I am busy with, this may take more than a week, I'm afraid...
