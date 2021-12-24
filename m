Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74D947EE76
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 12:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344223AbhLXLI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 06:08:57 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:43469
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230375AbhLXLI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 06:08:56 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A1Pb2SajOnN4kMFK2d+OiLfL1X161dxEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUHzzcbXDzSP/aINGL8L9t0aNy+9xxUv8TWz4RmGgppr3w8FHgiR?=
 =?us-ascii?q?ejtVY3IdB+oV8+xBpSeFxw/t512huEtnanYd1eEzvuWGuWn/SkUOZ2gHOKmUbe?=
 =?us-ascii?q?eYHwpH2eIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYsWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6Wk0DTqTTMA7mZnh+C/Xk3EgE/3ZrlP9kb5Lwam8O49mNt9JszNRE85i5V?=
 =?us-ascii?q?g4tOoXNnv4cWl9WCUmSOIUXpeCceifXXcu7iheun2HX6+9nAkg7OaUb9/xxDGU?=
 =?us-ascii?q?I8uYXQBgGcwqZgOC72r+pYvNtnck+NI/tMZ93kmp6zDfYE/89B4jKRanQ+MFR0?=
 =?us-ascii?q?D4YgsFIAOaYZswFZD4pZxPFCzVLN1EdIJEzhuGlgj/4aTIwgEyUv6cs4y7Q0Ql?=
 =?us-ascii?q?4ypDpMdzcYNvMQt9a9m6cp2Tb7yHhBzkEO9GFjzmI6HShgqnIhyyTcIYTEqCos?=
 =?us-ascii?q?/1nmluewkQNBxAME1i2u/+0jgi5Qd03A0kV/CUphbI/+EyiUp/2WBjQiGaJohM?=
 =?us-ascii?q?GSfJRFeMg4Q2Aw6aS5ByWbkAGUyRALtgrsMs3bSYn2l+Ag5XiAjkHmKOUT3mQ8?=
 =?us-ascii?q?KvSoi6zJTQSMUcGZCkNVwxD5MPsyLzfJDqnos1LSfHuyISvQHeuk3ba8W4kiqt?=
 =?us-ascii?q?VlsARkaO24Tj6b/uXjsChZmYICs//BwpJNj9EWbM=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AQneXvqFKfBizBN2dpLqEiceALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKJyC9Hfb5qynDpoV56faWslkssQ8b+OxoUZPoKRi3yXcf2+Us1NmZMTXbhA?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,232,1635199200"; 
   d="scan'208";a="957337"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 12:08:54 +0100
Date:   Fri, 24 Dec 2021 12:08:53 +0100 (CET)
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
In-Reply-To: <CAJZ5v0jyusD4r1eK_hv8CXuaoOXZ6gY8TVdomW5q75dS3wNq5A@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2112241207410.3217@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien> <CAJZ5v0iBU8gw8+-5nxj2cKzf7tyN=p3Adcm4Z5bn=oVYhU28bQ@mail.gmail.com> <alpine.DEB.2.22.394.2112172022100.2968@hadrien> <87r1abt1d2.fsf@riseup.net> <alpine.DEB.2.22.394.2112172258480.2968@hadrien>
 <87fsqqu6by.fsf@riseup.net> <alpine.DEB.2.22.394.2112180654470.3139@hadrien> <878rwitdu3.fsf@riseup.net> <alpine.DEB.2.22.394.2112181138210.3130@hadrien> <871r29tvdj.fsf@riseup.net> <alpine.DEB.2.22.394.2112190734070.3181@hadrien> <87wnk0s0tf.fsf@riseup.net>
 <CAJZ5v0i7gBtm6x+zUUzhxXjmYhPwr=JxvOuMZ0aD9qxnjE9YKw@mail.gmail.com> <878rwdse9o.fsf@riseup.net> <CAJZ5v0jyusD4r1eK_hv8CXuaoOXZ6gY8TVdomW5q75dS3wNq5A@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Dec 2021, Rafael J. Wysocki wrote:

> On Wed, Dec 22, 2021 at 12:57 AM Francisco Jerez <currojerez@riseup.net> wrote:
> >
> > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> >
> > > On Sun, Dec 19, 2021 at 11:10 PM Francisco Jerez <currojerez@riseup.net> wrote:
> > >>
> > >> Julia Lawall <julia.lawall@inria.fr> writes:
> > >>
> > >> > On Sat, 18 Dec 2021, Francisco Jerez wrote:
> > >
> > > [cut]
> > >
> > >> > I did some experiements with forcing different frequencies.  I haven't
> > >> > finished processing the results, but I notice that as the frequency goes
> > >> > up, the utilization (specifically the value of
> > >> > map_util_perf(sg_cpu->util) at the point of the call to
> > >> > cpufreq_driver_adjust_perf in sugov_update_single_perf) goes up as well.
> > >> > Is this expected?
> > >> >
> > >>
> > >> Actually, it *is* expected based on our previous hypothesis that these
> > >> workloads are largely latency-bound: In cases where a given burst of CPU
> > >> work is not parallelizable with any other tasks the thread needs to
> > >> complete subsequently, its overall runtime will decrease monotonically
> > >> with increasing frequency, therefore the number of instructions executed
> > >> per unit of time will increase monotonically with increasing frequency,
> > >> and with it its frequency-invariant utilization.
> > >
> > > But shouldn't these two effects cancel each other if the
> > > frequency-invariance mechanism works well?
> >
> > No, they won't cancel each other out under our hypothesis that these
> > workloads are largely latency-bound, since the performance of the
> > application will increase steadily with increasing frequency, and with
> > it the amount of computational resources it utilizes per unit of time on
> > the average, and therefore its frequency-invariant utilization as well.
>
> OK, so this is a workload in which the maximum performance is only
> achieved at the maximum available frequency.  IOW, there's no
> performance saturation point and increasing the frequency (if
> possible) will always cause more work to be done per unit of time.
>
> For this type of workloads, requirements regarding performance (for
> example, upper bound on the expected time of computations) need to be
> known in order to determine the "most suitable" frequency to run them
> and I agree that schedutil doesn't help much in that respect.
>
> It is probably better to run them with intel_pstate in the active mode
> (ie. "pure HWP") or decrease EPP via sysfs to allow HWP to ramp up
> turbo more aggressively.

active mode + powersave indeed both gives faster runtimes and less energy
consumption for these examples.

thanks,
julia
