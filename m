Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168B947C4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbhLURNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbhLURNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:13:30 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B214CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:13:29 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bt1so30763300lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=12dcJuvCHbrqEuGjZHrbvg5DKcpEVHqkDCNV4U9OhRs=;
        b=A3RLGqajl0TeHtr1c5Vv0kFB3FbWPw1WUaG7hsuHBG+Dfp7qKFdR0RNkwrrGotvNJx
         r2jgZlKzpqwjpdpyawyyQY+lbpDbv3z+iVHyGB+JXztHoLo8bLDsCQrDLfQ8o3bJ+iDa
         tkDb8NT40HcQcfPVSlVXl6mEKSWmcgKnD+GtwdZo/hQAl963SMePXW5ShHFA/KKB5ruK
         KKKqplNuEmZlnsXIG2+bdL6lT5SMTWQH5L0hK6y6CmcD05u8QJkflrRbF8cyd8+6ujWp
         5bRo+E0TWWGWSQZafKNs2hg4octWjQAFMWRFsVE/wfEStqAaB9EuMIkLZts2JdO/E+TZ
         67iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12dcJuvCHbrqEuGjZHrbvg5DKcpEVHqkDCNV4U9OhRs=;
        b=tTdQlhXIvRFhVeqOWdjlCSX0E9Ag0pZ3KfjPSlNUuaP+1zX3Pp0gL0Q2O3GDu061/h
         J+haxT29P0uINY1hRgUtYAad9BqLRUuU8fcpHxgHR/pKBnR7rlaPvXoFkaY4N5MHDlNw
         bZw9KC8kSynT2TbS62Ah++sTegITg6jartGuLELqZXy2Waw44Mp9V8vLeO1GE8y8muW0
         vb5R4mSSLV6hX+OMroQUi/wHD0PF2rnjW/wX4xTb9rQ9pnVnE20hXCakosIywPOUVjbi
         jrPlR0KTRyTfgCNbPr9JsUKmoYQyJFks8foTSPY+mSR+Lojq1vYYuIcvrVVQKkSsF/tX
         iBpg==
X-Gm-Message-State: AOAM5339E4J9SdD7dwZhD37Q0yWFczL6yYcnTg7M+p7dcmPnsCu9wRco
        veoZmTzqG5ynP5ePQZWsBa8aV9uH+R8sfJ71+b+uOQ==
X-Google-Smtp-Source: ABdhPJy0SMRbANoYsvRK8C4mSbAOUg6sVhbLSzzhXMKUy+ikltxRcSgtxT9puTj7+7PiFFDsCXH6PJOEWr+NPrC9DO8=
X-Received: by 2002:ac2:52a4:: with SMTP id r4mr3812262lfm.645.1640106807496;
 Tue, 21 Dec 2021 09:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20211210093307.31701-1-mgorman@techsingularity.net>
 <20211210093307.31701-3-mgorman@techsingularity.net> <YbcEE/mgIAhWuS+A@BLR-5CG11610CF.amd.com>
 <20211213130131.GQ3366@techsingularity.net> <YbddCcGJUpcPc8nS@BLR-5CG11610CF.amd.com>
 <YbnW/vLgE8MmQopN@BLR-5CG11610CF.amd.com> <20211215122550.GR3366@techsingularity.net>
 <YbuGYtxRSqVkOdbj@BLR-5CG11610CF.amd.com> <20211220111243.GS3366@techsingularity.net>
In-Reply-To: <20211220111243.GS3366@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Dec 2021 18:13:15 +0100
Message-ID: <CAKfTPtARUODOnL9X-X+09cCu_BeMbZsW9U=kHX2vrXor7Du6qQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 at 12:12, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> (sorry for the delay, was offline for a few days)
>
> On Fri, Dec 17, 2021 at 12:03:06AM +0530, Gautham R. Shenoy wrote:
> > Hello Mel,
> >
> > On Wed, Dec 15, 2021 at 12:25:50PM +0000, Mel Gorman wrote:
> > > On Wed, Dec 15, 2021 at 05:22:30PM +0530, Gautham R. Shenoy wrote:
> >
> > [..SNIP..]
> >

[snip]

>
> To avoid the corner case, we'd need to explicitly favour spreading early
> and assume wakeup will pull communicating tasks together and NUMA
> balancing migrate the data after some time which looks like
>
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index c07bfa2d80f2..54f5207154d3 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -93,6 +93,7 @@ struct sched_domain {
>         unsigned int busy_factor;       /* less balancing by factor if busy */
>         unsigned int imbalance_pct;     /* No balance until over watermark */
>         unsigned int cache_nice_tries;  /* Leave cache hot tasks for # tries */
> +       unsigned int imb_numa_nr;       /* Nr imbalanced tasks allowed between nodes */

So now you compute an allowed imbalance level instead of using
25% of sd->span_weight
or
25% of busiest->group_weight

And you adjust this new imb_numa_nr according to the topology.

That makes sense.

>
>         int nohz_idle;                  /* NOHZ IDLE status */
>         int flags;                      /* See SD_* */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0a969affca76..df0e84462e62 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1489,6 +1489,7 @@ struct task_numa_env {
>
>         int src_cpu, src_nid;
>         int dst_cpu, dst_nid;
> +       int imb_numa_nr;
>
>         struct numa_stats src_stats, dst_stats;
>
> @@ -1504,7 +1505,8 @@ static unsigned long cpu_load(struct rq *rq);
>  static unsigned long cpu_runnable(struct rq *rq);
>  static unsigned long cpu_util(int cpu);
>  static inline long adjust_numa_imbalance(int imbalance,
> -                                       int dst_running, int dst_weight);
> +                                       int dst_running,
> +                                       int imb_numa_nr);
>
>  static inline enum
>  numa_type numa_classify(unsigned int imbalance_pct,
> @@ -1885,7 +1887,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>                 dst_running = env->dst_stats.nr_running + 1;
>                 imbalance = max(0, dst_running - src_running);
>                 imbalance = adjust_numa_imbalance(imbalance, dst_running,
> -                                                       env->dst_stats.weight);
> +                                                 env->imb_numa_nr);
>
>                 /* Use idle CPU if there is no imbalance */
>                 if (!imbalance) {
> @@ -1950,8 +1952,10 @@ static int task_numa_migrate(struct task_struct *p)
>          */
>         rcu_read_lock();
>         sd = rcu_dereference(per_cpu(sd_numa, env.src_cpu));
> -       if (sd)
> +       if (sd) {
>                 env.imbalance_pct = 100 + (sd->imbalance_pct - 100) / 2;
> +               env.imb_numa_nr = sd->imb_numa_nr;
> +       }
>         rcu_read_unlock();
>
>         /*
> @@ -9050,9 +9054,9 @@ static bool update_pick_idlest(struct sched_group *idlest,
>   * This is an approximation as the number of running tasks may not be
>   * related to the number of busy CPUs due to sched_setaffinity.
>   */
> -static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
> +static inline bool allow_numa_imbalance(int dst_running, int imb_numa_nr)
>  {
> -       return (dst_running < (dst_weight >> 2));
> +       return dst_running < imb_numa_nr;
>  }
>
>  /*
> @@ -9186,12 +9190,13 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>                                 return idlest;
>  #endif
>                         /*
> -                        * Otherwise, keep the task on this node to stay close
> -                        * its wakeup source and improve locality. If there is
> -                        * a real need of migration, periodic load balance will
> -                        * take care of it.
> +                        * Otherwise, keep the task on this node to stay local
> +                        * to its wakeup source if the number of running tasks
> +                        * are below the allowed imbalance. If there is a real
> +                        * need of migration, periodic load balance will take
> +                        * care of it.
>                          */
> -                       if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
> +                       if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->imb_numa_nr))
>                                 return NULL;
>                 }
>
> @@ -9280,19 +9285,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>         }
>  }
>
> -#define NUMA_IMBALANCE_MIN 2
> -
>  static inline long adjust_numa_imbalance(int imbalance,
> -                               int dst_running, int dst_weight)
> +                               int dst_running, int imb_numa_nr)
>  {
> -       if (!allow_numa_imbalance(dst_running, dst_weight))
> +       if (!allow_numa_imbalance(dst_running, imb_numa_nr))
>                 return imbalance;
>
> -       /*
> -        * Allow a small imbalance based on a simple pair of communicating
> -        * tasks that remain local when the destination is lightly loaded.
> -        */
> -       if (imbalance <= NUMA_IMBALANCE_MIN)
> +       if (imbalance <= imb_numa_nr)

Isn't this always true ?

imbalance is "always" < dst_running as imbalance is usually the number
of these tasks that we would like to migrate


>                 return 0;
>
>         return imbalance;
> @@ -9397,7 +9396,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>                 /* Consider allowing a small imbalance between NUMA groups */
>                 if (env->sd->flags & SD_NUMA) {
>                         env->imbalance = adjust_numa_imbalance(env->imbalance,
> -                               busiest->sum_nr_running, env->sd->span_weight);
> +                               busiest->sum_nr_running, env->sd->imb_numa_nr);
>                 }
>
>                 return;
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d201a7052a29..1fa3e977521d 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2242,6 +2242,55 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>                 }
>         }
>
> +       /*
> +        * Calculate an allowed NUMA imbalance such that LLCs do not get
> +        * imbalanced.
> +        */
> +       for_each_cpu(i, cpu_map) {
> +               unsigned int imb = 0;
> +               unsigned int imb_span = 1;
> +
> +               for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> +                       struct sched_domain *child = sd->child;
> +
> +                       if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> +                           (child->flags & SD_SHARE_PKG_RESOURCES)) {

sched_domains have not been degenerated yet so you found here the DIE domain

> +                               struct sched_domain *top, *top_p;
> +                               unsigned int llc_sq;
> +
> +                               /*
> +                                * nr_llcs = (sd->span_weight / llc_weight);
> +                                * imb = (llc_weight / nr_llcs) >> 2

it would be good to add a comment to explain why 25% of LLC weight /
number of LLC in a node is the right value.
For example, why is it better than just 25% of the LLC weight ?
Do you want to allow the same imbalance at node level whatever the
number of LLC in the node ?

> +                                *
> +                                * is equivalent to
> +                                *
> +                                * imb = (llc_weight^2 / sd->span_weight) >> 2
> +                                *
> +                                */
> +                               llc_sq = child->span_weight * child->span_weight;
> +
> +                               imb = max(2U, ((llc_sq / sd->span_weight) >> 2));
> +                               sd->imb_numa_nr = imb;
> +
> +                               /*
> +                                * Set span based on top domain that places
> +                                * tasks in sibling domains.
> +                                */
> +                               top = sd;
> +                               top_p = top->parent;
> +                               while (top_p && (top_p->flags & SD_PREFER_SIBLING)) {

Why are you looping on SD_PREFER_SIBLING  instead of SD_NUMA  ?
Apart the heterogeneous domain (SD_ASYM_CPUCAPACITY) but I'm not sure
that you want to take this case into account, only numa node don't
have SD_PREFER_SIBLING

> +                                       top = top->parent;
> +                                       top_p = top->parent;
> +                               }
> +                               imb_span = top_p ? top_p->span_weight : sd->span_weight;
> +                       } else {
> +                               int factor = max(1U, (sd->span_weight / imb_span));
> +
> +                               sd->imb_numa_nr = imb * factor;
> +                       }
> +               }
> +       }
> +
>         /* Calculate CPU capacity for physical packages and nodes */
>         for (i = nr_cpumask_bits-1; i >= 0; i--) {
>                 if (!cpumask_test_cpu(i, cpu_map))
