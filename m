Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3294EE769
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 06:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244896AbiDAElG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 00:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiDAElD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 00:41:03 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ADF527C5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:39:14 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id v35so2957405ybi.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ox5Xs8VVjr5sTQccCyZKH6QAT3KTfr65pMMuHLPychQ=;
        b=IsaHx/5fSObUs+7L/C0SyHYi5BXs5cvVVSjvNFe8me+CCc3c1QV5gQi8MChigRzvn8
         fZvDVxIIUe3fsto+W7sE9KQRYKfbFC2ROt+HA1iBteCaU/4TezVju/R9uuwDKU4RR7wS
         nxBNr4vRbZ55ZUlewbplvaUImaFfNMRZXVn7eDE9HCETpwUIYfQl1/Am48mb2s3R3zZg
         sVsjMNVs6V3GfB3BIiCf/kdUZo+RLIvE8qnLVRkL9cYSWtLEF5+Mww+TfIk7o2uEXU1V
         1w7YZTG3lWHGlFbOKBIPOgin/s1AHaCKOBZxkgjmEG2Un7iZuZBRG1evucrzM+vHvIix
         /TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ox5Xs8VVjr5sTQccCyZKH6QAT3KTfr65pMMuHLPychQ=;
        b=bvjdr+vrthc7hQv9CkALTU/Tviu53nOMwiHLvLbLlIe6lDtPbEff0EHg2c47cjTiSK
         5kjd7XOXyCbx+wvoQytB6l0fP4KejUIHbB/NAk27PpBAAzuqYdcVykECUVawS2iXoaoP
         BRNPvQ25pzxbM0J57kaq5YIpWSQdKZbVADJgR7wZyYnNJgMqqdazBR0p4mhsM3MUEZOX
         wKha64M+0r38RuH4lPgJXxtiVVpmvysdurw5niw/M0phfA9Gf+1/d/rBQNi+jgXS0YFg
         OwQ5mSkI6w8bepJPKcXGOJ8dWUa7giFkPAtKgLGQenmatv/iTeETzfX3DZc36v/grfR3
         554A==
X-Gm-Message-State: AOAM533NLgK8uLdPPlXOLNDW9JLsyzBZ0FZoIR8L4q9p+GnFXc8HF7n/
        djMfhiifEz5e1Q3nEtpI2no8x0KggHOSQWoYm7fG+nrM/OCUnA==
X-Google-Smtp-Source: ABdhPJyLekdpGi8wXZNxT0PvJRUEWLHtugRy/PijZGDLWxhO7W3KdwIL0H7lPmuWOMTnh+m2ic4tRqz87XmkctenR3U=
X-Received: by 2002:a05:6902:72a:b0:634:6843:499c with SMTP id
 l10-20020a056902072a00b006346843499cmr7484066ybt.36.1648787953248; Thu, 31
 Mar 2022 21:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKaNEwyNZ=L_PQnkH0LP_XjLYrr_dpyRKNNoDJaWKdrmg@mail.gmail.com>
 <20220331224222.GY4285@paulmck-ThinkPad-P17-Gen-1> <CANn89iJjyp7s1fYB6VCqLhUnF+mmEXyw8GMpFC9Vi22usBsgAQ@mail.gmail.com>
 <CANn89iJaeBneeqiDBUh_ppEQGne_eyPp-BCVYjEyvoYkUxrDxg@mail.gmail.com>
 <20220331231312.GA4285@paulmck-ThinkPad-P17-Gen-1> <CANn89i+rfrkRrdYAq8Baq04n_ACq+VdB+UcsMoq7U-dB-2hKJA@mail.gmail.com>
 <20220401000642.GB4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220401000642.GB4285@paulmck-ThinkPad-P17-Gen-1>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 31 Mar 2022 21:39:02 -0700
Message-ID: <CANn89iJtfTiSz4v+L3YW+b_gzNoPLz_wuAmXGrNJXqNs9BU9cA@mail.gmail.com>
Subject: Re: [BUG] rcu-tasks : should take care of sparse cpu masks
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 5:06 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Mar 31, 2022 at 04:28:04PM -0700, Eric Dumazet wrote:
> > On Thu, Mar 31, 2022 at 4:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > The initial setting of ->percpu_enqueue_shift forces all in-range CPU
> > > IDs to shift down to zero.  The grace-period kthread is allowed to run
> > > where it likes.  The callback lists are protected by locking, even in
> > > the case of local access, so this should be safe.
> > >
> > > Or am I missing your point?
> > >
> >
> > In fact I have been looking at this code, because we bisected a
> > regression back to this patch:
> >
> > 4fe192dfbe5ba9780df699d411aa4f25ba24cf61 rcu-tasks: Shorten
> > per-grace-period sleep for RCU Tasks Trace
> >
> > It is very possible the regression comes because the RCU task thread
> > is using more cpu cycles, from 'CPU 0'  where our system daemons are
> > pinned.
>
> Heh!  I did express that concern when creating that patch, but was
> assured that the latency was much more important.
>
> Yes, that patch most definitely increases CPU utilization during RCU Tasks
> Trace grace periods.  If you can tolerate longer grace-period latencies,
> it might be worth toning it down a bit.  The ask was for about twice
> the latency I achieved in my initial attempt, and I made the mistake of
> forwarding that attempt out for testing.  They liked the shorter latency
> very much, and objected strenuously to the thought that I might detune
> it back to the latency that they originally asked for.  ;-)
>
> But I can easily provide the means to detune it through use of a kernel
> boot parameter or some such, if that would help.
>
> > But I could not spot where the RCU task kthread is forced to run on CPU 0.
>
> I never did intend this kthread be bound anywhere.  RCU's policy is
> that any binding of its kthreads is the responsibility of the sysadm,
> be that carbon-based or otherwise.
>
> But this kthread is spawned early enough that only CPU 0 is online,
> so maybe the question is not "what is binding it to CPU 0?" but rather
> "why isn't something kicking it off of CPU 0?"

I guess the answer to this question can be found in the following
piece of code :)

rcu_read_lock();
for_each_process_thread(g, t)
        rtp->pertask_func(t, &holdouts);
rcu_read_unlock();


With ~150,000 threads on a 256 cpu host, this holds current cpu for
very long times:

 rcu_tasks_trace    11 [017]  5010.544762:
probe:rcu_tasks_wait_gp: (ffffffff963fb4b0)
 rcu_tasks_trace    11 [017]  5010.600396:
probe:rcu_tasks_trace_postscan: (ffffffff963fb7c0)
 rcu_tasks_trace    11 [022]  5010.618783:
probe:check_all_holdout_tasks_trace: (ffffffff963fb850)
 rcu_tasks_trace    11 [022]  5010.618840:
probe:rcu_tasks_trace_postgp: (ffffffff963fba70)

In this case, CPU 22 is the victim, not CPU 0 :)



>
> > I attempted to backport to our kernel all related patches that were
> > not yet backported,
> > and we still see a regression in our tests.
>
> The per-grace-period CPU consumption of rcu_tasks_trace was intentionally
> increased by the above commit, and I never have done anything to reduce
> that CPU consumption.  In part because you are the first to call my
> attention to it.
>
> Oh, and one other issue that I very recently fixed, that has not
> yet reached mainline, just in case it matters.  If you are building a
> CONFIG_PREEMPT_NONE=y or CONFIG_PREEMPT_VOLUNTARY=y kernel, but also have
> CONFIG_RCU_TORTURE_TEST=m (or, for that matter, =y, but please don't in
> production!), then your kernel will use RCU Tasks instead of vanilla RCU.
> (Note well, RCU Tasks, not RCU Tasks Trace, the latter being necessaary
> for sleepable BPF programs regardless of kernel .config).
>
> > Please ignore the sha1 in this current patch series, this is only to
> > show my current attempt to fix the regression in our tree.
> >
> > 450b3244f29b rcu-tasks: Don't remove tasks with pending IPIs from holdout list
> > 5f88f7e9cc36 rcu-tasks: Create per-CPU callback lists
> > 1a943d0041dc rcu-tasks: Introduce ->percpu_enqueue_shift for dynamic
> > queue selection
> > ea5289f12fce rcu-tasks: Convert grace-period counter to grace-period
> > sequence number
> > 22efd5093c3b rcu/segcblist: Prevent useless GP start if no CBs to accelerate
> > 16dee1b3babf rcu: Implement rcu_segcblist_is_offloaded() config dependent
> > 8cafaadb6144 rcu: Add callbacks-invoked counters
> > 323234685765 rcu/tree: Make rcu_do_batch count how many callbacks were executed
> > f48f3386a1cc rcu/segcblist: Add additional comments to explain smp_mb()
> > 4408105116de rcu/segcblist: Add counters to segcblist datastructure
> > 4a0b89a918d6 rcu/tree: segcblist: Remove redundant smp_mb()s
> > 38c0d18e8740 rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_divisor
> > 0b5d1031b509 rcu/segcblist: Add debug checks for segment lengths
> > 8a82886fbf02 rcu_tasks: Convert bespoke callback list to rcu_segcblist structure
> > cbd452a5c01f rcu-tasks: Use spin_lock_rcu_node() and friends
> > 073222be51f3 rcu-tasks: Add a ->percpu_enqueue_lim to the rcu_tasks structure
> > 5af10fb0f8fb rcu-tasks: Abstract checking of callback lists
> > d3e8be598546 rcu-tasks: Abstract invocations of callbacks
> > 65784460a392 rcu-tasks: Use workqueues for multiple
> > rcu_tasks_invoke_cbs() invocations
> > dd6413e355f1 rcu-tasks: Make rcu_barrier_tasks*() handle multiple
> > callback queues
> > 2499cb3c438e rcu-tasks: Add rcupdate.rcu_task_enqueue_lim to set
> > initial queueing
> > a859f409a503 rcu-tasks: Count trylocks to estimate call_rcu_tasks() contention
> > 4ab253ca056e rcu-tasks: Avoid raw-spinlocked wakeups from
> > call_rcu_tasks_generic()
> > e9a3563fe76e rcu-tasks: Use more callback queues if contention encountered
> > 4023187fe31d rcu-tasks: Use separate ->percpu_dequeue_lim for callback
> > dequeueing
> > 533be3bd47c3 rcu: Provide polling interfaces for Tree RCU grace periods
> > f7e5a81d7953 rcu-tasks: Use fewer callbacks queues if callback flood ends
> > bb7ad9078e1b rcu-tasks: Fix computation of CPU-to-list shift counts
> > d9cebde55539 rcu-tasks: Use order_base_2() instead of ilog2()
> > 95606f1248f5 rcu-tasks: Set ->percpu_enqueue_shift to zero upon contention
