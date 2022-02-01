Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB8C4A6593
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiBAUVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiBAUUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:20:45 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41959C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 12:20:45 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w25so35985145edt.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 12:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7J84gzVre3uth30A6Wqqj2kmZeWWwR11/B26K90SEqw=;
        b=aYWGW8RLLe+hlunh5jeyBgdgF2vsqYkwiTyF2LGuNbuxsCotJvzI5yh0KoJvLDXQbg
         XHIRg0aGypjZ34pevDYw17eMUgq0BbFLZpcloYHaJ5RdeCP/JXcpNxj2O4ca9ZEw7tlK
         LfKikgwr/dbxTcerQA+DjuEReiobdRS/QzoR1HqTn7YOEtgpel3nt6OcWE2HY07Arf8D
         BFfTYXcXq2W3olOYOhRHVYj/cfFoei41jEucIDoYN/StVwHLCU44tsQSx2ang5XWiJOS
         UOJvbXq/FPSElz5tq96BpCgrMNBKKFdXan4VMHJ6l2dub3aVNtuujhfF7JdSjNpvzBBp
         38BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7J84gzVre3uth30A6Wqqj2kmZeWWwR11/B26K90SEqw=;
        b=OgxMxyiCJ0IWRDBBEV+EzAr4gHT0RIiKvJ0Zr1tRkveFj/GMg2tf9djSnXVg55DhyH
         7pEyewQZkHDu7axjBZBfDY673jfDzlXQ9lNpGI3Xu06TFfXOuLqUNUIpA6jIby8wVWAE
         OtKt/evoQ2KCz9FguJ3OZpqVjmmIRbJk/kWkl+yBewEssBWtHG+h9WPb2SjHsk6kEuoO
         Y+XAqU27m4r5GlQ9S2X6MRfjvj1eFiNFnEC1s/DjjEuHP3NduAvUQELhHX2pCnn2ly7i
         9c8YwSHztz7L5Gpx/wgEO6WOgN4KwMvX3YEPxrAg1vEbrQtAxdl89QswRe3jcpIdtGZ9
         X09A==
X-Gm-Message-State: AOAM533N2UJZ0SU90c5u14JUkwYXvZGO9oiFYJm4ps5y+GTmXm0DugME
        Kyh+SnDK05H4zka8Ji8JgUNsBtzk9U4/3TWqsBQEUe63qkY=
X-Google-Smtp-Source: ABdhPJzUTiNvcrfZQOc/gQx0j8wU76n0JBwX1aWMyEW3kpiKAHuJkxi/eWxMwB2gP5PXtsOZZ/Ssp/TSm6HBtSIt64o=
X-Received: by 2002:a05:6402:5215:: with SMTP id s21mr26984074edd.387.1643746843571;
 Tue, 01 Feb 2022 12:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20220126080947.4529-1-yangyicong@hisilicon.com>
 <20220126080947.4529-3-yangyicong@hisilicon.com> <YfK9DSMFabjYm/MV@BLR-5CG11610CF.amd.com>
 <CAGsJ_4xL3tynB9P=rKMoX2otW4bMMU5Z-P9zSudMV3+fr2hpXw@mail.gmail.com>
 <20220128071337.GC618915@linux.vnet.ibm.com> <CAGsJ_4yoUONACY-j+9XxSNC0VgmdyRdHC=z87dWvZvVSASzXRQ@mail.gmail.com>
 <20220201093859.GE618915@linux.vnet.ibm.com>
In-Reply-To: <20220201093859.GE618915@linux.vnet.ibm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 2 Feb 2022 09:20:32 +1300
Message-ID: <CAGsJ_4z8cer7Y5si+J_=awQetFJZMVeaQ+RDSXQz9EGOPTGMQg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        prime.zeng@huawei.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        ego@linux.vnet.ibm.com, Linuxarm <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 10:39 PM Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> * Barry Song <21cnbao@gmail.com> [2022-01-28 07:40:15]:
>
> > On Fri, Jan 28, 2022 at 8:13 PM Srikar Dronamraju
> > <srikar@linux.vnet.ibm.com> wrote:
> > >
> > > * Barry Song <21cnbao@gmail.com> [2022-01-28 09:21:08]:
> > >
> > > > On Fri, Jan 28, 2022 at 4:41 AM Gautham R. Shenoy
> > > > <gautham.shenoy@amd.com> wrote:
> > > > >
> > > > > On Wed, Jan 26, 2022 at 04:09:47PM +0800, Yicong Yang wrote:
> > > > > > From: Barry Song <song.bao.hua@hisilicon.com>
> > > > > >
> > > > > > For platforms having clusters like Kunpeng920, CPUs within the same
> > > > > > cluster have lower latency when synchronizing and accessing shared
> > > > > > resources like cache. Thus, this patch tries to find an idle cpu
> > > > > > within the cluster of the target CPU before scanning the whole LLC
> > > > > > to gain lower latency.
> > > > > >
> > > > > > Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so this
> > > > > > patch doesn't consider SMT for this moment.
> > > > > >
> > > > > > Testing has been done on Kunpeng920 by pinning tasks to one numa
> > > > > > and two numa. On Kunpeng920, Each numa has 8 clusters and each
> > > > > > cluster has 4 CPUs.
> > > > > >
> > > > > > With this patch, We noticed enhancement on tbench within one
> > > > > > numa or cross two numa.
> > > > > >
> > > > > > On numa 0:
> > > > > >                             5.17-rc1                patched
> > > > > > Hmean     1        324.73 (   0.00%)      378.01 *  16.41%*
> > > > > > Hmean     2        645.36 (   0.00%)      754.63 *  16.93%*
> > > > > > Hmean     4       1302.09 (   0.00%)     1507.54 *  15.78%*
> > > > > > Hmean     8       2612.03 (   0.00%)     2982.57 *  14.19%*
> > > > > > Hmean     16      5307.12 (   0.00%)     5886.66 *  10.92%*
> > > > > > Hmean     32      9354.22 (   0.00%)     9908.13 *   5.92%*
> > > > > > Hmean     64      7240.35 (   0.00%)     7278.78 *   0.53%*
> > > > > > Hmean     128     6186.40 (   0.00%)     6187.85 (   0.02%)
> > > > > >
> > > > > > On numa 0-1:
> > > > > >                             5.17-rc1                patched
> > > > > > Hmean     1        320.01 (   0.00%)      378.44 *  18.26%*
> > > > > > Hmean     2        643.85 (   0.00%)      752.52 *  16.88%*
> > > > > > Hmean     4       1287.36 (   0.00%)     1505.62 *  16.95%*
> > > > > > Hmean     8       2564.60 (   0.00%)     2955.29 *  15.23%*
> > > > > > Hmean     16      5195.69 (   0.00%)     5814.74 *  11.91%*
> > > > > > Hmean     32      9769.16 (   0.00%)    10872.63 *  11.30%*
> > > > > > Hmean     64     15952.50 (   0.00%)    17281.98 *   8.33%*
> > > > > > Hmean     128    13113.77 (   0.00%)    13895.20 *   5.96%*
> > > > > > Hmean     256    10997.59 (   0.00%)    11244.69 *   2.25%*
> > > > > > Hmean     512    14623.60 (   0.00%)    15526.25 *   6.17%*
> > > > > >
> > > > > > This will also help to improve the MySQL. With MySQL server
> > > > > > running on numa 0 and client running on numa 1, both QPS and
> > > > > > latency is imporved on read-write case:
> > > > > >                         5.17-rc1        patched
> > > > > > QPS-16threads        143333.2633    145077.4033(+1.22%)
> > > > > > QPS-24threads        195085.9367    202719.6133(+3.91%)
> > > > > > QPS-32threads        241165.6867      249020.74(+3.26%)
> > > > > > QPS-64threads        244586.8433    253387.7567(+3.60%)
> > > > > > avg-lat-16threads           2.23           2.19(+1.19%)
> > > > > > avg-lat-24threads           2.46           2.36(+3.79%)
> > > > > > avg-lat-36threads           2.66           2.57(+3.26%)
> > > > > > avg-lat-64threads           5.23           5.05(+3.44%)
> > > > > >
> > > > > > Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> > > > > > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > > > > > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > > > > > ---
> > > > > >  kernel/sched/fair.c | 46 +++++++++++++++++++++++++++++++++++++++++----
> > > > > >  1 file changed, 42 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > > index 5146163bfabb..2f84a933aedd 100644
> > > > > > --- a/kernel/sched/fair.c
> > > > > > +++ b/kernel/sched/fair.c
> > > > > > @@ -6262,12 +6262,46 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
> > > > > >
> > > > > >  #endif /* CONFIG_SCHED_SMT */
> > > > > >
> > > > > > +#ifdef CONFIG_SCHED_CLUSTER
> > > > > > +/*
> > > > > > + * Scan the cluster domain for idle CPUs and clear cluster cpumask after scanning
> > > > > > + */
> > > > > > +static inline int scan_cluster(struct task_struct *p, int prev_cpu, int target)
> > > > > > +{
> > > > > > +     struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> > > > > > +     struct sched_domain *sd = rcu_dereference(per_cpu(sd_cluster, target));
> > > > > > +     int cpu, idle_cpu;
> > > > > > +
> > > > > > +     /* TODO: Support SMT case while a machine with both cluster and SMT born */
> > > > > > +     if (!sched_smt_active() && sd) {
> > > > > > +             for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
> > > > > > +                     idle_cpu = __select_idle_cpu(cpu, p);
> > > > > > +                     if ((unsigned int)idle_cpu < nr_cpumask_bits)
> > > > > > +                             return idle_cpu;
> > > > > > +             }
> > > > > > +
> > > > > > +             /* Don't ping-pong tasks in and out cluster frequently */
> > > > > > +             if (cpus_share_resources(target, prev_cpu))
> > > > > > +                     return target;
> > > > >
> > > > > We reach here when there aren't any idle CPUs within the
> > > > > cluster. However there might be idle CPUs in the MC domain. Is a busy
> > > > > @target preferable to a potentially idle CPU within the larger domain
> > > > > ?
> > > >
> > > > Hi Gautham,
> > > >
> > >
> > > Hi Barry,
> > >
> > >
> > > > My benchmark showed some performance regression while load was medium or above
> > > > if we grabbed idle cpu in and out the cluster. it turned out the
> > > > regression disappeared if
> > > > we blocked the ping-pong. so the logic here is that if we have scanned
> > > > and found an
> > > > idle cpu within the cluster before, we don't let the task jumping back
> > > > and forth frequently
> > > > as cache synchronization is higher cost. but the code still allows
> > > > scanning out of the cluster
> > > > if we haven't packed waker and wakee together yet.
> > > >
> > >
> > > Like what Gautham said, should we choose the same cluster if we find that
> > > there are no idle-cpus in the LLC? This way we avoid ping-pong if there are
> > > no idle-cpus but we still pick an idle-cpu to a busy cpu?
> >
> > Hi Srikar,
> > I am sorry I didn't get your question. Currently the code works as below:
> > if task A wakes up task B, and task A is in LLC0 and task B is in LLC1.
> > we will scan the cluster of A before scanning the whole LLC0, in this case,
> > cluster of A is the closest sibling, so it is the better choice than other CPUs
> > which are in LLC0 but not in the cluster of A.
>
> Yes, this is right.
>
> > But we do scan all cpus of LLC0
> > afterwards if we fail to find an idle CPU in the cluster.
>
> However my reading of the patch, before we can scan other clusters within
> the LLC (aka LLC0), we have a check in scan cluster which says
>
>         /* Don't ping-pong tasks in and out cluster frequently */
>         if (cpus_share_resources(target, prev_cpu))
>            return target;
>
> My reading of this is, ignore other clusters (at this point, we know there
> are no idle CPUs in this cluster. We don't know if there are idle cpus in
> them or not) if the previous CPU and target CPU happen to be from the same
> cluster. This effectively means we are given preference to cache over idle
> CPU.

Note we only ignore other cluster while prev_cpu and target are in same
cluster. if the condition is false, we are not ignoring other cpus. typically,
if waker is the target, and wakee is the prev_cpu, that means if they are
already in one cluster, we don't stupidly spread them in select_idle_cpu() path
as benchmark shows we are losing. so, yes, we are giving preference to
cache over CPU.

>
> Or Am I still missing something?
>
> >
> > After a while, if the cluster of A gets an idle CPU and pulls B into the
> > cluster, we prefer not pushing B out of the cluster of A again though
> > there might be an idle CPU outside. as benchmark shows getting an
> > idle CPU out of the cluster of A doesn't bring performance improvement
> > but performance decreases as B might be getting in and getting out
> > the cluster of A very frequently, then cache coherence ping-pong.
> >
>
> The counter argument can be that Task A and Task B are related and were
> running on the same cluster. But Load balancer moved Task B to a different
> cluster. Now this check may cause them to continue to run on two different
> clusters, even though the underlying load balance issues may have changed.
>
> No?

LB is much slower than select_idle_cpu().  select_idle_cpu() can dynamically
work afterwards. so it is always a dynamic balance and task migration.

>
>
> --
> Thanks and Regards
> Srikar Dronamraju

Thanks
Barry
