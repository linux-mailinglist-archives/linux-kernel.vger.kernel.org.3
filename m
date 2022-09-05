Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6B25AC942
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiIEDyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiIEDyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:54:07 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3881A3BA;
        Sun,  4 Sep 2022 20:54:06 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bx38so7917149ljb.10;
        Sun, 04 Sep 2022 20:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=EO9cXvZpaINegPiNkQW8Jq/6uz9vUDKC0ucIfZt4MuU=;
        b=DuE+pMDxJr8BWfHfLyiVSf4CHnvzuqVwOt1OoxmkJKqIko2jTVqD3AWm6u/33u1mWG
         YBnzCGA+wfjkRIuwuMsHLSZU3mIcHFnZS2SMsPQahbWlhD6c4zbRhRBXzACX7Z9rAVJi
         P3pDjqJKjpRM9mN7BVx2QUnn5eBT8y89LpJCBcghUGm6qmlNZwBV8T2RrX86DlqyO1W+
         uuzczll5JmQqHOJ7wnX+13Gik+zhquZ5PQhvlE7hIRyiPetv7rMEkP43AP3RTBtY9NE1
         xCswrqCgAhV3OkxTzm2UwgqWHSqmprJWIs4eoG4c+uuUvmCK8uInJgkhoXp+9wCIwnQ4
         x+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=EO9cXvZpaINegPiNkQW8Jq/6uz9vUDKC0ucIfZt4MuU=;
        b=eRuMKXbi8FSd5LUXkGUrCeg8S+YttIsQW+3ZUNPuBk1QDvuKfy5fhj5j/ffzytFzGb
         irLhKfBfhtN0XIzUTwxmugsOvjgFFLvICQy58b5qCTX+STmRDVBygC3gs5MR5Ef4ZcXs
         cd+YHt4GlaIwOYEkGhyupSda0kfD4AfOW8Nog+U4QwTXKQ2Ht8MQNiuGCzJgb6lcpsxI
         I9VUmvg7nBYIrfmWWqEvmJofHrjPv+U+H2bsFwud83u84a6n5C21h5B9+absQaO9oph7
         J7nAL0LymcxvDdPnUzohiL7VLy8rwtfWkHblEwrzQ2AFOz4ZkXaAjpIny5kPQ9yNucK0
         Cp7A==
X-Gm-Message-State: ACgBeo0HSNPW6OX9gBxE5YNXNsBRO2pQBp4igZyj8evWkoQoICbymviz
        SDXTrxgLqr3s7n2zFLgXg3aDRK7iyamfpTXGAa/17J8BJ7py
X-Google-Smtp-Source: AA6agR7ofiw+M0kfm5zOIunpVJxULlxJQ/yEwVOxRIUYlRpULWr8k5W1qtf4lXQffluXHuitUXkdecmo1MQPzd/8lh8=
X-Received: by 2002:a05:651c:1112:b0:268:a0ad:ac1d with SMTP id
 e18-20020a05651c111200b00268a0adac1dmr5494717ljo.261.1662350044124; Sun, 04
 Sep 2022 20:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220822021520.6996-1-kernelfans@gmail.com> <20220822021520.6996-7-kernelfans@gmail.com>
 <20220822024528.GC6159@paulmck-ThinkPad-P17-Gen-1> <YwQygLBtzqwxuMIJ@piliu.users.ipa.redhat.com>
 <20220823030125.GJ6159@paulmck-ThinkPad-P17-Gen-1> <CAFgQCTup0uTqnKi79Tu+5Q0POYVdcE4UkGes8KfHXBd6VR552A@mail.gmail.com>
 <20220824162050.GA6159@paulmck-ThinkPad-P17-Gen-1> <20220831161522.GA2582451@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220831161522.GA2582451@paulmck-ThinkPad-P17-Gen-1>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 5 Sep 2022 11:53:52 +0800
Message-ID: <CAFgQCTuNw3sdO=X1KNHkTZW8YvK8xo4bmTxyN_uJ9=kkWOW=zw@mail.gmail.com>
Subject: Re: [RFC 06/10] rcu/hotplug: Make rcutree_dead_cpu() parallel
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, boqun.feng@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 12:15 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Aug 24, 2022 at 09:20:50AM -0700, Paul E. McKenney wrote:
> > On Wed, Aug 24, 2022 at 09:53:11PM +0800, Pingfan Liu wrote:
> > > On Tue, Aug 23, 2022 at 11:01 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > On Tue, Aug 23, 2022 at 09:50:56AM +0800, Pingfan Liu wrote:
> > > > > On Sun, Aug 21, 2022 at 07:45:28PM -0700, Paul E. McKenney wrote:
> > > > > > On Mon, Aug 22, 2022 at 10:15:16AM +0800, Pingfan Liu wrote:
> > > > > > > In order to support parallel, rcu_state.n_online_cpus should be
> > > > > > > atomic_dec()
> > > > > > >
> > > > > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > > >
> > > > > > I have to ask...  What testing have you subjected this patch to?
> > > > > >
> > > > >
> > > > > This patch subjects to [1]. The series aims to enable kexec-reboot in
> > > > > parallel on all cpu. As a result, the involved RCU part is expected to
> > > > > support parallel.
> > > >
> > > > I understand (and even sympathize with) the expectation.  But results
> > > > sometimes diverge from expectations.  There have been implicit assumptions
> > > > in RCU about only one CPU going offline at a time, and I am not sure
> > > > that all of them have been addressed.  Concurrent CPU onlining has
> > > > been looked at recently here:
> > > >
> > > > https://docs.google.com/document/d/1jymsaCPQ1PUDcfjIKm0UIbVdrJAaGX-6cXrmcfm0PRU/edit?usp=sharing
> > > >
> > > > You did us atomic_dec() to make rcu_state.n_online_cpus decrementing be
> > > > atomic, which is good.  Did you look through the rest of RCU's CPU-offline
> > > > code paths and related code paths?
> > >
> > > I went through those codes at a shallow level, especially at each
> > > cpuhp_step hook in the RCU system.
> >
> > And that is fine, at least as a first step.
> >
> > > But as you pointed out, there are implicit assumptions about only one
> > > CPU going offline at a time, I will chew the google doc which you
> > > share.  Then I can come to a final result.
> >
> > Boqun Feng, Neeraj Upadhyay, Uladzislau Rezki, and I took a quick look,
> > and rcu_boost_kthread_setaffinity() seems to need some help.  As it
> > stands, it appears that concurrent invocations of this function from the
> > CPU-offline path will cause all but the last outgoing CPU's bit to be
> > (incorrectly) set in the cpumask_var_t passed to set_cpus_allowed_ptr().
> >
> > This should not be difficult to fix, for example, by maintaining a
> > separate per-leaf-rcu_node-structure bitmask of the concurrently outgoing
> > CPUs for that rcu_node structure.  (Similar in structure to the
> > ->qsmask field.)
> >

Sorry to reply late, since I am interrupted by some other things.
I have took a different way and posted a series ([PATCH 1/3] rcu:
remove redundant cpu affinity setting during teardown) for that on
https://lore.kernel.org/rcu/20220905033852.18988-1-kernelfans@gmail.com/T/#t

Besides, for the integration of the concurrency cpu hot-removing into
the rcu torture test, I begin to do it.

> > There are probably more where that one came from.  ;-)
>
> And here is one more from this week's session.
>

Thanks for the update.

> The calls to tick_dep_set() and tick_dep_clear() use atomic operations,
> but they operate on a global variable.  This means that the first call
> to rcutree_offline_cpu() would enable the tick and the first call to
> rcutree_dead_cpu() would disable the tick.  This might be OK, but it
> is at the very least bad practice.  There needs to be a counter
> mediating these calls.
>

I will see what I can do here.

> For more detail, please see the Google document:
>
> https://docs.google.com/document/d/1jymsaCPQ1PUDcfjIKm0UIbVdrJAaGX-6cXrmcfm0PRU/edit?usp=sharing
>

Have read it and hope that both online and offline concurrency can
come to true in near future.

Thanks,

    Pingfan
