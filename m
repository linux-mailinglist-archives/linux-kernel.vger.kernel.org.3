Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD63481136
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 10:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbhL2JNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 04:13:07 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:16859
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239474AbhL2JNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 04:13:06 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AH65ZeaPQ5yobGJrvrR2zlsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdVTrhmsk1GZVzWUZXGrQOarbYWunKY0kat6+/BsC7cLWm99gGjLY11k9FiMQ8?=
 =?us-ascii?q?ZKt6fexdxqrYXvKdqUvdK/WhiknQoGowPscEzmM9n9BDpC79SMljPvSF+KlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5W31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFCtq?=
 =?us-ascii?q?piLf2dCXmQJaCYE7Q2jwPAfHk20cZzsAx+v9T2P40a1pTijzPm9luwdFJnZ22U?=
 =?us-ascii?q?wYgeKPW8AgYe0ABQ3AgYfUuFLjvZCLXXdao51fPfXLhx91tAVswMIle/fx4aUl?=
 =?us-ascii?q?F6OYCLzIAdB2Rr/i327+mUq9qi9hLBNLxPYUepHh7iynQC/o8XI7KT6zi4d5ew?=
 =?us-ascii?q?Sd2h8ZSEPKYbM0cARJrYRLKSx5CIFEaDNQ5hujArmf+aTBDqBSWuK8++UDXzQp?=
 =?us-ascii?q?4yr+rN8DaEvSORMNIjgOAo0rY8GnjRBIXLtqSzXyC6H3EruvOmz7rHYEfDru18?=
 =?us-ascii?q?tZ0j1CJgG8eEhsbUR28u/bRoku/Xd1YA1YZ9ionse4580nDZsHwQxCislaFuBA?=
 =?us-ascii?q?GUtZdGuF87xuCooLW/hyYQGwJSjpAQMYruM8/WXoh0Vrht83oAzditqHTRm+c6?=
 =?us-ascii?q?quTsRu2OC4cN2hEYjULJTbpSfGLTJob102UCI85Sejr3pulRHfqzi7MtyYkwbM?=
 =?us-ascii?q?ekaY2O2yA1Qivq1qRSlLhF2bZPjnqY18=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AFZAgBa1vBM7/vU568ycoowqjBKckLtp133Aq?=
 =?us-ascii?q?2lEZdPWaSKylfqGV8cjzuiWbtN98YhodcJW7WZVoP0m3yXcF2+Us1N6ZNWHbUS?=
 =?us-ascii?q?mTXeNfBODZrAEIdReOldK1rZ0QFpRDNA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,244,1635199200"; 
   d="scan'208";a="1189640"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 10:13:05 +0100
Date:   Wed, 29 Dec 2021 10:13:04 +0100 (CET)
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
Message-ID: <alpine.DEB.2.22.394.2112291012030.24929@hadrien>
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

The effect is the same.  But that approach is indeed simpler than patching
the kernel.

julia

>
> > >
> > > > I tried this on a
> > > > 2-socket Intel 6130 and a 4-socket Intel 6130.  The experiment runs 40
> > > > times.
> > > >
> > > > There seem to be only two levels of CPU energy usage.  On the 2-socket
> > > > machine the energy usage is around 600J up to pstate 20 and around 1000J
> > > > after that.  On the 4-socket machine it is twice that.
> > >
> > > These are the package power numbers from turbostat, aren't they?
> >
> > Yes.
>
> OK
>
