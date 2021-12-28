Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF14480C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbhL1SQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 13:16:48 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:5093 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233411AbhL1SQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:16:47 -0500
IronPort-Data: =?us-ascii?q?A9a23=3Acj7Gb6vwEd1xHaExr0iN7Qd8zufnVEBfMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3zmQWUT2COPuOMGLyKIxyaN/k/B4CucTSyNNgTwdpq3hgHilAw?=
 =?us-ascii?q?SbnLYTAfx2oZ0t+DeWaERk5t51GAjX4wXFdokb0/n9BCZC86yksvU20buCkUre?=
 =?us-ascii?q?dYHohHVUMpBoJ0nqPpcZo2+aEvvDpW2thifuqyyHuEAfNNwxcagr42IrfwP9bh?=
 =?us-ascii?q?8kejRtD1rAIiV+ni3eF/5UdJMp3yahctBIUSKEMdgKxb76rIL1UYgrkExkR5tO?=
 =?us-ascii?q?Nyt4Xc2UKS7LIPAWI4pZUc/j/xEYS4HVoi+Bia6F0hUR/0l1lm/hz1dFMvNq0Q?=
 =?us-ascii?q?BggOqnkmeIHUhAeHTsW0ahuoeaZeSji6qR/yGWDKRMA2c5GFkg4NIAc0uV6G2d?=
 =?us-ascii?q?D8bofMj9lRhuenfixwr+hR/tEnMU4IdTzeoUSphlI1ivYC/c4SIuFW6zM6cVFw?=
 =?us-ascii?q?j48j+hKHPDDd4wYbyZiaFLLZBgnElMaDpgWn+qygHT7NTpCpzq9u6st7nPTig9?=
 =?us-ascii?q?s1bH3GN7UfNWQQoNShEnwjmbH+XnpRwkfHMKQxCDD8X+2gOLL2yThV+o6ELy+6?=
 =?us-ascii?q?+4vg1CJwGEXIAMZWEH9ovSjjEO6HdVFJCQ8/ysooq8a7kGnTtDhGRa/pRasphM?=
 =?us-ascii?q?AVsBCO+w85huExqfd70CeHGdsZjxcct1gsMIyQT0CzFKFn9r1QzdotdW9V3Ob/?=
 =?us-ascii?q?bqSsXW9JCkJMWgeTSsFSwIf5J/kuo5bs/5lZr6PC4bs0YazQGuphW7a6nhjwa8?=
 =?us-ascii?q?ek4gQ2b/9+13b6w9Ab6PhFmYdjjg7lEr8hu+hWLOYWg=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AnQxveKgw7+GlvNqN6dnA+fVHmXBQXt0ji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1173TJYVoqMk3I3OrgBEDiewK4yXcW2+ks1N6ZNWHbUS?=
 =?us-ascii?q?mTXeJfBODZrQEIdReTygcQ79YDT4FOTOy1N1R8gMrgiTPUL/8ryrC8n5yVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,242,1635199200"; 
   d="scan'208";a="1160853"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 19:16:46 +0100
Date:   Tue, 28 Dec 2021 19:16:45 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Francisco Jerez <currojerez@riseup.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
In-Reply-To: <CAJZ5v0grayg9evWsB5ktKSFq=yA_AHoEWSfpSkQ=MVQ-=butfA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2112281909170.24929@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien> <CAJZ5v0iBU8gw8+-5nxj2cKzf7tyN=p3Adcm4Z5bn=oVYhU28bQ@mail.gmail.com> <alpine.DEB.2.22.394.2112172022100.2968@hadrien> <87r1abt1d2.fsf@riseup.net> <alpine.DEB.2.22.394.2112172258480.2968@hadrien>
 <87fsqqu6by.fsf@riseup.net> <alpine.DEB.2.22.394.2112180654470.3139@hadrien> <878rwitdu3.fsf@riseup.net> <alpine.DEB.2.22.394.2112181138210.3130@hadrien> <871r29tvdj.fsf@riseup.net> <alpine.DEB.2.22.394.2112190734070.3181@hadrien> <87wnk0s0tf.fsf@riseup.net>
 <CAJZ5v0i7gBtm6x+zUUzhxXjmYhPwr=JxvOuMZ0aD9qxnjE9YKw@mail.gmail.com> <878rwdse9o.fsf@riseup.net> <alpine.DEB.2.22.394.2112281745240.24929@hadrien> <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com> <alpine.DEB.2.22.394.2112281845180.24929@hadrien>
 <CAJZ5v0grayg9evWsB5ktKSFq=yA_AHoEWSfpSkQ=MVQ-=butfA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Dec 2021, Rafael J. Wysocki wrote:

> On Tue, Dec 28, 2021 at 6:46 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Tue, 28 Dec 2021, Rafael J. Wysocki wrote:
> >
> > > On Tue, Dec 28, 2021 at 5:58 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > > >
> > > > I looked a bit more into why pstate 20 is always using the least energy. I
> > > > have just one thread spinning for 10 seconds, I use a fixed value for the
> > > > pstate, and I measure the energy usage with turbostat.
> > >
> > > How exactly do you fix the pstate?
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index e7af18857371..19440b15454c 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -400,7 +402,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
> >                 sg_cpu->util = prev_util;
> >
> >         cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
> > -                                  map_util_perf(sg_cpu->util), sg_cpu->max);
> > +                                  sysctl_sched_fixedfreq, sg_cpu->max);
>
> This is just changing the "target" hint given to the processor which
> may very well ignore it, though.

It doesn't seem to ignore it.  I also print the current frequency on every
clock tick, and it is as it should be.  This is done in the function
arch_scale_freq_tick in arch/x86/kernel/smpboot.c, where I added:

        trace_printk("freq %lld\n", div64_u64((cpu_khz * acnt), mcnt));


>
> >
> >         sg_cpu->sg_policy->last_freq_update_time = time;
> >  }
> >
> > ------------------------------
> >
> > sysctl_sched_fixedfreq is a variable that I added to sysfs.
>
> If I were trying to fix a pstate, I would set scaling_max_freq and
> scaling_min_freq in sysfs for all CPUs to the same value.
>
> That would cause intel_pstate to set HWP min and max to the same value
> which should really cause the pstate to be fixed, at least outside the
> turbo range of pstates.

OK, I can try that, thanks.

julia
