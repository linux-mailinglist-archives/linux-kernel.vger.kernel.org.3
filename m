Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AC646208B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348035AbhK2Te6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344825AbhK2Tc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:32:57 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755F3C061D6A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:50:13 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 207so35236399ljf.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPmmzDKvEjC1FznZv9O5Nd5L810sAcBLQi2CDuZWQj8=;
        b=yOOpC93sL7JqfmFVvCibFuWW7waZzi0jMq1mOP6uNzLqAUi0b7u9vheatN3O74eJpy
         trhC9uFqPmtr0Upqwxl1bS+Kpm+LXmR1BKyrrn9jHG2c1c8mvGyanCl7Sc5ejkPGtRBR
         JKvruF3+XirpjxyzA08Z40hyGb6vyvmCXbqQUC8Gw94bdRNxGv1p1tNe7QCaClZ4Ztjg
         IwG2oEgfLb7WYtE5LU7q07Ib+50R8t5eJhM3qkq0J/vQlZm9nPLXzzr/u3cTPtMUhJwH
         825isAkUgDs1o71fNMIJ/JhsW14ui4sZFmWymlXazlEuqE+tb5fIdMoeov426nZj+eWr
         pTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPmmzDKvEjC1FznZv9O5Nd5L810sAcBLQi2CDuZWQj8=;
        b=RzJiNRxyrFFgJLj645smLpOu2xC8/BGw5xnJW/h7Pqu+DBHUtQIdyZzCXVxhfXHSwW
         gXk0mh87aHeATBRi/aH2/ir1XkXo6+qq5V3OH+spRBDu4apt+FMPsa0ZTax8LeoI4dU0
         1wFb9AJO1tiUKlhnnaJLsUeZYzabQlUwgANXnRomo3vNiUff1ZSx5Ii6C86CB2GALUq1
         DFG5qHOLe87f85RZMBgzj4OForENOEtHKAjdfacqsSlvlpvJtwMx+wCBvkO+xkJoIc9X
         TPqpGb2KP7/MKT9R1hGrKtW67PAqC/9UgRTjWTQoRwcVAc2YPiHGa8HKWAOjGoJ3/F9+
         5FvA==
X-Gm-Message-State: AOAM5308q72x8FdM2m4dyz2LkJRlg3F2+RGrpE1n/5k9xzhSkQ77gKY2
        ta/E9nQo1E6AeFRO0wmidBRslgG2x5KVWiG/nMRN/g==
X-Google-Smtp-Source: ABdhPJzU/0XG0SIPrVm+rU/UkZ7u5NlQt35pOFiKqswu7DGFGmIGrKyFVLlkGFiEAqoC8Atvtxsy+lNM9Lffl91DX2s=
X-Received: by 2002:a2e:84c4:: with SMTP id q4mr49336527ljh.266.1638201011657;
 Mon, 29 Nov 2021 07:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20211124154239.3191366-1-vincent.donnefort@arm.com>
 <CAKfTPtDX8sOfguZhJt5QV3j5D_JetcgncuF2w+uLa0XDk7UXkw@mail.gmail.com>
 <8735nkcwov.mognet@arm.com> <CAKfTPtDPskVdEd-KQ_cwe-R_zVFPQOgdbk9x+3eD12pKs8fGFw@mail.gmail.com>
 <87zgpsb6de.mognet@arm.com> <CAKfTPtCnusWJXJLDEudQ_q8MWaZYbPJK-QjAbBYWFW8Nw-J+Ww@mail.gmail.com>
 <87sfvjavqk.mognet@arm.com> <CAKfTPtC4iXXaptm9+2bHvX2E3xAWU4M3xN0ZuwpFQ1RyXAyxyA@mail.gmail.com>
 <87pmqmc16f.mognet@arm.com> <20211126171817.GA3798214@ubiquitous>
In-Reply-To: <20211126171817.GA3798214@ubiquitous>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 29 Nov 2021 16:49:58 +0100
Message-ID: <CAKfTPtCGyp8JZq1EOgEhTeD+PBV2rMnTQ=uV-ZgsaN1RVmPk0w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix detection of per-CPU kthreads waking a task
To:     Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc:     Valentin Schneider <Valentin.Schneider@arm.com>,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 at 18:18, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> On Fri, Nov 26, 2021 at 04:49:12PM +0000, Valentin Schneider wrote:
> > On 26/11/21 15:40, Vincent Guittot wrote:
> > > On Fri, 26 Nov 2021 at 14:32, Valentin Schneider
> > > <Valentin.Schneider@arm.com> wrote:
> > >>         /*
> > >> -        * Allow a per-cpu kthread to stack with the wakee if the
> > >> -        * kworker thread and the tasks previous CPUs are the same.
> > >> -        * The assumption is that the wakee queued work for the
> > >> -        * per-cpu kthread that is now complete and the wakeup is
> > >> -        * essentially a sync wakeup. An obvious example of this
> > >> +        * Allow a per-cpu kthread to stack with the wakee if the kworker thread
> > >> +        * and the tasks previous CPUs are the same.  The assumption is that the
> > >> +        * wakee queued work for the per-cpu kthread that is now complete and
> > >> +        * the wakeup is essentially a sync wakeup. An obvious example of this
> > >>          * pattern is IO completions.
> > >> +        *
> > >> +        * Ensure the wakeup is issued by the kthread itself, and don't match
> > >> +        * against the idle task because that could override the
> > >> +        * available_idle_cpu(target) check done higher up.
> > >>          */
> > >> -       if (is_per_cpu_kthread(current) &&
> > >> +       if (is_per_cpu_kthread(current) && !is_idle_task(current) &&
> > >
> > > still i don't see the need of !is_idle_task(current)
> > >
> >
> > Admittedly, belts and braces. The existing condition checks rq->nr_running <= 1
> > which can lead to coscheduling when the wakeup is issued by the idle task
> > (or even if rq->nr_running == 0, you can have rq->ttwu_pending without
> > having sent an IPI due to polling). Essentially this overrides the first
> > check in sis() that uses idle_cpu(target) (prev == smp_processor_id() ==
> > target).
> >
> > I couldn't prove such wakeups can happen right now, but if/when they do
> > (AIUI it would just take someone to add a wake_up_process() down some
> > smp_call_function() callback) then we'll need the above. If you're still
> > not convinced by now, I won't push it further.
>
> From a quick experiment, even with the asym_fits_capacity(), I can trigger
> the following:
>
> [    0.118855] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> [    0.128214] select_idle_sibling: wakee=rcu_gp:3 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> [    0.137327] select_idle_sibling: wakee=rcu_par_gp:4 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> [    0.147221] select_idle_sibling: wakee=kworker/u16:0:7 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> [    0.156994] select_idle_sibling: wakee=mm_percpu_wq:8 nr_cpus_allowed=8 current=swapper/0:1 in_task=1

Timestamp shows its booting phase and thread name above shows per cpu
thread. Could it happen just while creating per cpu thread at boot and
as a result not relevant ?

Can you see similar things later after booting ?

I have tried to trigger the situation but failed to get wrong
sequence. All are coming from interrupt while idle.
After adding in_task() condition, I haven't been able to trigger the
warn() that I added to catch the wrong situations on SMP, Heterogenous
or NUMA system. Could you share more details on your setup ?


> [    0.171943] select_idle_sibling: wakee=rcu_sched:10 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
>
> So the in_task() condition doesn't appear to be enough to filter wakeups
> while we have the swapper as a current.
>
> >
> > >
> > >> +           in_task() &&
> > >>             prev == smp_processor_id() &&
> > >>             this_rq()->nr_running <= 1) {
> > >>                 return prev;
> > >>
