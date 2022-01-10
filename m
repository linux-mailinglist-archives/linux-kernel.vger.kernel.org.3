Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68865489CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbiAJPxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbiAJPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:53:40 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BA8C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:53:40 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o12so45963738lfk.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HBW2OstPq6azV/zG0QKD1KFJzNdbnl//l+gZEX+L2L8=;
        b=vrC3hVwjcCaUDWw5jb78HZ4FzrSNFlxZ0FUww4GgyKBYhps+btO0anMO9oav5HGyjG
         /edmtHUWYKJw477iyFlVwSn/VsQDrh9MUnY7Gftf+jYpJH6ls9GtOlfbgZ73Q8w3/az3
         rCow8p3MF6oTstrOqUPTfRfNP/GTUoYon9eJztDZu59YpU0jLhV0a+VPEemor02sg4V5
         IsaMYE9NvCuWkPU7sCfvmbszHUGjD1mFzR2mR0/KNd+W6/Q9cuhvS6HueI6n9y9hqrMt
         SyxKDyo6g4f7a/9eHJ7wwe8Y9AU+E1/Us+DAPsq19cVQOfz6RLw/cSmZfaUcPk0UaR8d
         oOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBW2OstPq6azV/zG0QKD1KFJzNdbnl//l+gZEX+L2L8=;
        b=fooUEnd/3SW422Lzz3K8oRg1jyuG1R4keX3XtMfJoStGcR+MomzKAwvSUPYIIufqZr
         Gv9u4wXfECKnclbJYFpdo+1gLDwNR0+M9yX1XC12FX39XhKDdGQqxjdqXUSCwI28xlk1
         wkDl+eix2yqKa73pQ2ey0oxYuqLSAaJcaocPTTzghFQqVKyf/Qb7kGqn8oXRQAAWC0+T
         FzSxkW/LDrLl4BBo5Ysz/o2zifvRn0j4EJhLpsDQQGVMlqHoPGfE7oL7lqnzoShJmvCM
         4Yy0pAxM94LtqswACyxrQ4cdC7mH6WnoxKj0+PmQiUyxa/RBJJNLu7QK3sR4681gqQ7h
         6Mzg==
X-Gm-Message-State: AOAM530SMCx1enQA5XIkYrUCRaALP7U0BCn6Kwf4IFz6PW3tu5xDJvXh
        7NjBYsL7bv9d1RIGmW1feogWBSd+0Ovr1E7Trdq8IA==
X-Google-Smtp-Source: ABdhPJzteGZSDWns/A/lze9IkSw0eMh8Iv5GOOjAqEZmg0bejCnQby2U46cKetQAVFQdgDmMzryQrUIDGGhwq6ww8i4=
X-Received: by 2002:a05:6512:1593:: with SMTP id bp19mr238516lfb.645.1641830018433;
 Mon, 10 Jan 2022 07:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20211210093307.31701-1-mgorman@techsingularity.net>
 <20211210093307.31701-3-mgorman@techsingularity.net> <YbcEE/mgIAhWuS+A@BLR-5CG11610CF.amd.com>
 <20211213130131.GQ3366@techsingularity.net> <YbddCcGJUpcPc8nS@BLR-5CG11610CF.amd.com>
 <YbnW/vLgE8MmQopN@BLR-5CG11610CF.amd.com> <20211215122550.GR3366@techsingularity.net>
 <YbuGYtxRSqVkOdbj@BLR-5CG11610CF.amd.com> <20211220111243.GS3366@techsingularity.net>
 <CAKfTPtARUODOnL9X-X+09cCu_BeMbZsW9U=kHX2vrXor7Du6qQ@mail.gmail.com> <20220105104207.GV3366@techsingularity.net>
In-Reply-To: <20220105104207.GV3366@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 10 Jan 2022 16:53:26 +0100
Message-ID: <CAKfTPtBCdgKb7gBDoFo3ictVYhgQGcneHViEtYj8o=WVH3kTaA@mail.gmail.com>
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

On Wed, 5 Jan 2022 at 11:42, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Dec 21, 2021 at 06:13:15PM +0100, Vincent Guittot wrote:
> > > <SNIP>
> > >
> > > @@ -9050,9 +9054,9 @@ static bool update_pick_idlest(struct sched_group *idlest,
> > >   * This is an approximation as the number of running tasks may not be
> > >   * related to the number of busy CPUs due to sched_setaffinity.
> > >   */
> > > -static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
> > > +static inline bool allow_numa_imbalance(int dst_running, int imb_numa_nr)
> > >  {
> > > -       return (dst_running < (dst_weight >> 2));
> > > +       return dst_running < imb_numa_nr;
> > >  }
> > >
> > >  /*
> > >
> > > <SNIP>
> > >
> > > @@ -9280,19 +9285,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> > >         }
> > >  }
> > >
> > > -#define NUMA_IMBALANCE_MIN 2
> > > -
> > >  static inline long adjust_numa_imbalance(int imbalance,
> > > -                               int dst_running, int dst_weight)
> > > +                               int dst_running, int imb_numa_nr)
> > >  {
> > > -       if (!allow_numa_imbalance(dst_running, dst_weight))
> > > +       if (!allow_numa_imbalance(dst_running, imb_numa_nr))
> > >                 return imbalance;
> > >
> > > -       /*
> > > -        * Allow a small imbalance based on a simple pair of communicating
> > > -        * tasks that remain local when the destination is lightly loaded.
> > > -        */
> > > -       if (imbalance <= NUMA_IMBALANCE_MIN)
> > > +       if (imbalance <= imb_numa_nr)
> >
> > Isn't this always true ?
> >
> > imbalance is "always" < dst_running as imbalance is usually the number
> > of these tasks that we would like to migrate
> >
>
> It's not necessarily true. allow_numa_imbalanced is checking if
> dst_running < imb_numa_nr and adjust_numa_imbalance is checking the
> imbalance.
>
> imb_numa_nr = 4
> dst_running = 2
> imbalance   = 1
>
> In that case, imbalance of 1 is ok, but 2 is not.

I don't catch your example. Why is imbalance = 2 not ok in your
example above ? allow_numa_imbalance still returns true (dst-running <
imb_numa_nr) and we still have imbalance <= imb_numa_nr

Also the name dst_running is quite confusing; In the case of
calculate_imbalance, busiest->nr_running is passed as dst_running
argument. But the busiest group is the src not the dst of the balance

Then,  imbalance < busiest->nr_running in load_balance because we try
to even the number of task running in each groups without emptying it
and allow_numa_imbalance checks that dst_running < imb_numa_nr. So we
have imbalance < dst_running < imb_numa_nr

>
> >
> > >                 return 0;
> > >
> > >         return imbalance;
> > > @@ -9397,7 +9396,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> > >                 /* Consider allowing a small imbalance between NUMA groups */
> > >                 if (env->sd->flags & SD_NUMA) {
> > >                         env->imbalance = adjust_numa_imbalance(env->imbalance,
> > > -                               busiest->sum_nr_running, env->sd->span_weight);
> > > +                               busiest->sum_nr_running, env->sd->imb_numa_nr);
> > >                 }
> > >
> > >                 return;
> > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > index d201a7052a29..1fa3e977521d 100644
> > > --- a/kernel/sched/topology.c
> > > +++ b/kernel/sched/topology.c
> > > @@ -2242,6 +2242,55 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> > >                 }
> > >         }
> > >
> > > +       /*
> > > +        * Calculate an allowed NUMA imbalance such that LLCs do not get
> > > +        * imbalanced.
> > > +        */
> > > +       for_each_cpu(i, cpu_map) {
> > > +               unsigned int imb = 0;
> > > +               unsigned int imb_span = 1;
> > > +
> > > +               for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> > > +                       struct sched_domain *child = sd->child;
> > > +
> > > +                       if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> > > +                           (child->flags & SD_SHARE_PKG_RESOURCES)) {
> >
> > sched_domains have not been degenerated yet so you found here the DIE domain
> >
>
> Yes
>
> > > +                               struct sched_domain *top, *top_p;
> > > +                               unsigned int llc_sq;
> > > +
> > > +                               /*
> > > +                                * nr_llcs = (sd->span_weight / llc_weight);
> > > +                                * imb = (llc_weight / nr_llcs) >> 2
> >
> > it would be good to add a comment to explain why 25% of LLC weight /
> > number of LLC in a node is the right value.
>
> This?
>
>                                  * The 25% imbalance is an arbitrary cutoff
>                                  * based on SMT-2 to balance between memory
>                                  * bandwidth and avoiding premature sharing
>                                  * of HT resources and SMT-4 or SMT-8 *may*
>                                  * benefit from a different cutoff. nr_llcs
>                                  * are accounted for to mitigate premature
>                                  * cache eviction due to multiple tasks
>                                  * using one cache while a sibling cache
>                                  * remains relatively idle.
>
> > For example, why is it better than just 25% of the LLC weight ?
>
> Because lets say there are 2 LLCs then an imbalance based on just the LLC
> weight might allow 2 tasks to share one cache while another is idle. This
> is the original problem whereby the vanilla imbalance allowed multiple
> LLCs on the same node to be overloaded which hurt workloads that prefer
> to spread wide.

In this case, shouldn't it be (llc_weight >> 2) * nr_llcs to fill each
llc up to 25%  ? instead of dividing by nr_llcs

As an example, you have
1 node with 1 LLC with 128 CPUs will get an imb_numa_nr = 32
1 node with 2 LLC with 64 CPUs each will get an imb_numa_nr = 8
1 node with 4 LLC with 32 CPUs each will get an imb_numa_nr = 2

sd->imb_numa_nr is used at NUMA level so the more LLC you have the
lower imbalance is allowed

>
> > Do you want to allow the same imbalance at node level whatever the
> > number of LLC in the node ?
> >
>
> At this point, it's less clear how the larger domains should be
> balanced and the initial scaling is as good an option as any.
>
> > > +                                *
> > > +                                * is equivalent to
> > > +                                *
> > > +                                * imb = (llc_weight^2 / sd->span_weight) >> 2
> > > +                                *
> > > +                                */
> > > +                               llc_sq = child->span_weight * child->span_weight;
> > > +
> > > +                               imb = max(2U, ((llc_sq / sd->span_weight) >> 2));
> > > +                               sd->imb_numa_nr = imb;
> > > +
> > > +                               /*
> > > +                                * Set span based on top domain that places
> > > +                                * tasks in sibling domains.
> > > +                                */
> > > +                               top = sd;
> > > +                               top_p = top->parent;
> > > +                               while (top_p && (top_p->flags & SD_PREFER_SIBLING)) {
> >
> > Why are you looping on SD_PREFER_SIBLING  instead of SD_NUMA  ?
>
> Because on AMD Zen3, I saw inconsistent treatment of SD_NUMA prior to
> degeneration depending on whether it was NPS-1, NPS-2 or NPS-4 and only
> SD_PREFER_SIBLING gave the current results.

SD_PREFER_SIBLING is not mandatory in childs of NUMA node (look at
heterogenous system as an example) so relying of this flag seems quite
fragile
The fact that you see inconsistency with SD_NUMA depending of NPS-1,
NPS-2 or NPS-4 topology probably means that you don't looks for the
right domain level or you try to compensate side effect of your
formula above

>
> --
> Mel Gorman
> SUSE Labs
