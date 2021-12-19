Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC5147A175
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 18:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbhLSRD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 12:03:28 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:34358 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229742AbhLSRD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 12:03:27 -0500
IronPort-Data: =?us-ascii?q?A9a23=3Azjp7EKh6gM3ih8gQTQGhNlz5X161GBEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkVRnDAbWG2HMvzZZDOnct9+b97npxlT75TTyNFkGQc4r3w8FHgiR?=
 =?us-ascii?q?ejtVY3IdB+oV8+xBpSeFxw/t512huEtnanYd1eEzvuWGuWn/SkUOZ2gHOKmUbe?=
 =?us-ascii?q?eY3EpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYsWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6Wk0DTqTTMA7mZnh+C/Xk3EgE/3ZrlP9kb5Lwam8O49mNt9JszNRE85i5V?=
 =?us-ascii?q?g4tOoXNnv4cWl9WCUmSOIUfoe+eeybg6qR/yGWDKRMA2c5GFkg4NIAc0uV6G2d?=
 =?us-ascii?q?D8bofMj9lRguZhuS33rugDPFlgMg5MdfiMIo3vnBm0CGfDPA6TJSFSKLPjfdc0?=
 =?us-ascii?q?TE6rsNDB/DTY4weczUHRArBeRBUOhEUFZc3hs+sh3/2aToer0iazYIz4m7O3El?=
 =?us-ascii?q?p1ZDzP9fPPN+HX8NYmgCfvG2u12D4BAwKcd+S0zyI9lqyieLV2yD2QoQfEPu/7?=
 =?us-ascii?q?PECqFiSwGMUIAcbWVuyvb+yjUvWc8pSN0EO6AIvq6Yo/UCmR9W7WAe3yFaGowQ?=
 =?us-ascii?q?dHd5dF+k7wBuAxqrd/0CSAW1sZiBAbtcrstNwSiErykOOg/vtBDpmqrrTTmiSn?=
 =?us-ascii?q?op4Bxva1TM9dDBZI3ZeFE1bs5+z/ccpgwyJVdh5Vqi4krXI9fjL62jihEADa38?=
 =?us-ascii?q?71KbnD5mGwG0=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AiEbXm6BYCxUgWGvlHenZ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?uHocdfU4SKGlfr6V8sjzvCWc4F0ssRob9uxoVpPrfU/h?=
X-IronPort-AV: E=Sophos;i="5.88,218,1635199200"; 
   d="scan'208";a="11812673"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 18:03:25 +0100
Date:   Sun, 19 Dec 2021 18:03:25 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
In-Reply-To: <CAJZ5v0jQysTLSHp533swboHBzX7DVF_0UETLmOqmnc7hTXHWVg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2112191751140.3181@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien> <CAJZ5v0iBU8gw8+-5nxj2cKzf7tyN=p3Adcm4Z5bn=oVYhU28bQ@mail.gmail.com> <alpine.DEB.2.22.394.2112172022100.2968@hadrien> <CAJZ5v0jQysTLSHp533swboHBzX7DVF_0UETLmOqmnc7hTXHWVg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Dec 2021, Rafael J. Wysocki wrote:

> On Fri, Dec 17, 2021 at 8:32 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Fri, 17 Dec 2021, Rafael J. Wysocki wrote:
> >
> > > On Mon, Dec 13, 2021 at 11:52 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > > >
> > > > With HWP, intel_cpufreq_adjust_perf takes the utilization, scales it
> > > > between 0 and the capacity, and then maps everything below min_pstate to
> > > > the lowest frequency.
> > >
> > > Well, it is not just intel_pstate with HWP.  This is how schedutil
> > > works in general; see get_next_freq() in there.
> > >
> > > > On my Intel Xeon Gold 6130 and Intel Xeon Gold
> > > > 5218, this means that more than the bottom quarter of utilizations are all
> > > > mapped to the lowest frequency.  Running slowly doesn't necessarily save
> > > > energy, because it takes more time.
> > >
> > > This is true, but the layout of the available range of performance
> > > values is a property of the processor, not a driver issue.
> > >
> > > Moreover, the role of the driver is not to decide how to respond to
> > > the given utilization value, that is the role of the governor.  The
> > > driver is expected to do what it is asked for by the governor.
> >
> > OK, but what exactly is the goal of schedutil?
>
> The short answer is: minimizing the cost (in terms of energy) of
> allocating an adequate amount of CPU time for a given workload.
>
> Of course, this requires a bit of explanation, so bear with me.
>
> It starts with a question:
>
> Given a steady workload (ie. a workload that uses approximately the
> same amount of CPU time to run in every sampling interval), what is
> the most efficient frequency (or generally, performance level measured
> in some abstract units) to run it at and still ensure that it will get
> as much CPU time as it needs (or wants)?
>
> To answer this question, let's first assume that
>
> (1) Performance is a monotonically increasing (ideally, linear)
> function of frequency.
> (2) CPU idle states have not enough impact on the energy usage for
> them to matter.
>
> Both of these assumptions may not be realistic, but that's how it goes.
>
> Now, consider the "raw" frequency-dependent utilization
>
> util(f) = util_max * (t_{total} - t_{idle}(f)) / t_{total}
>
> where
>
> t_{total} is the total CPU time available in the given time frame.
> t_{idle}(f) is the idle CPU time appearing in the workload when run at
> frequency f in that time frame.
> util_max is a convenience constant allowing an integer data type to be
> used for representing util(f) with sufficient approximation.
>
> Notice that by assumption (1), util(f) is a monotonically decreasing
> function, so if util(f_{max}) = util_max (where f_{max} is the maximum
> frequency available from the hardware), which means that there is no
> idle CPU time in the workload when run at the max available frequency,
> there will be no idle CPU time in it when run at any frequency below
> f_{max}.  Hence, in that case the workload needs to be run at f_{max}.
>
> If util(f_{max}) < util_max, there is some idle CPU time in the
> workload at f_{max} and it may be run at a lower frequency without
> sacrificing performance.  Moreover, the cost should be minimum when
> running the workload at the maximum frequency f_e for which
> t_{idle}(f_e) = 0.  IOW, that is the point at which the workload still
> gets as much CPU time as needed, but the cost of running it is
> maximally reduced.

Thanks for the detailed explanation.  I got lost at this point, though.

Idle time can be either due to I/O, or due to waiting for synchronization
from some other thread perhaps on another core.  How can either of these
disappear?  In the I/O case, no matter what the frequency, the idle time
will be the same (in a simplified world).  In the case of waiting for
another thread on another core, assuming that all the cores are running at
the same frequency, lowering the frequency will cause the both running
time and the idle time to increase, and it will cause util(f) to stay the
same.  Both cases seem to send the application directly to the lowest
frequency.  I guess that's fine if we also assume that the lowest
frequency is also the most efficient one.

julia

>
> In practice, it is better to look for a frequency slightly greater
> than f_e to allow some performance margin to be there in case the
> workload fluctuates or similar, so we get
>
> C * util(f) / util_max = 1
>
> where the constant C is slightly greater than 1.
>
> This equation cannot be solved directly, because the util(f) graph is
> not known, but util(f) can be computed (at least approximately) for a
> given f and the solution can be approximated by computing a series of
> frequencies f_n given by
>
> f_{n+1} = C * f_n * util(f_n) / util_max
>
> under certain additional assumptions regarding the convergence etc.
>
> This is almost what schedutil does, but it also uses the observation
> that if the frequency-invariant utilization util_inv is known, then
> approximately
>
> util(f) = util_inv * f_{max} / f
>
> so finally
>
> f = C * f_{max} * util_inv / util_max
>
> and util_inv is provided by PELT.
>
> This has a few interesting properties that are vitally important:
>
> (a) The current frequency need not be known in order to compute the
> next one (and it is hard to determine in general).
> (b) The response is predictable by the CPU scheduler upfront, so it
> can make decisions based on it in advance.
> (c) If util_inv is properly scaled to reflect differences between
> different types of CPUs in a hybrid system, the same formula can be
> used for each of them regardless of where the workload was running
> previously.
>
> and they need to be maintained.
>
> > I would have expected that it was to give good performance while saving
> > energy, but it's not doing either in many of these cases.
>
> The performance improvement after making the change in question means
> that something is missing.  The assumptions mentioned above (and there
> are quite a few of them) may not hold or the hardware may not behave
> exactly as anticipated.
>
> Generally, there are three directions worth investigating IMV:
>
> 1. The scale-invariance mechanism may cause util_inv to be
> underestimated.  It may be worth trying to use the max non-turbo
> performance instead of the 4-core-turbo performance level in it; see
> intel_set_max_freq_ratio() in smpboot.c.
>
> 2.The hardware's response to the "desired" HWP value may depend on
> some additional factors (eg. the EPP value) that may need to be
> adjusted.
>
> 3. The workloads are not actually steady and running them at higher
> frequencies causes the sections that really need more CPU time to
> complete faster.
>
> At the same time, CPU idle states may actually have measurable impact
> on energy usage which is why you may not see much difference in that
> respect.
>
> > Is it the intent of schedutil that the bottom quarter of utilizations
> > should be mapped to the lowest frequency?
>
> It is not the intent, but a consequence of the scaling algorithm used
> by schedutil.
>
> As you can see from the derivation of that algorithm outlined above,
> if the utilization is mapped to a performance level below min_perf,
> running the workload at min_perf or above it is not expected (under
> all of the the assumptions made) to improve performance, so mapping
> all of the "low" utilization values to min_perf should not hurt
> performance, as the CPU time required by the workload will still be
> provided (and with a surplus for that matter).
>
> The reason why the hardware refuses to run below a certain minimum
> performance level is because it knows that running below that level
> doesn't really improve energy usage (or at least the improvement
> whatever it may be is not worth the effort).  The CPU would run
> slower, but it would still use (almost) as much energy as it uses at
> the "hardware minimum" level, so it may as well run at the min level.
>
