Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02383486AAA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 20:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243460AbiAFTtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 14:49:18 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:33228
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243403AbiAFTtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 14:49:12 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AfWW+yKjQReNIGV4j2+sfCa6HX161dhEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUOm2IXD2uCP/yJYTb0KN10atyzox4AupaBz9EwTQttrHw8FHgiR?=
 =?us-ascii?q?ejtVY3IdB+oV8+xBpSeFxw/t512huEtnanYd1eEzvuWGuWn/SkUOZ2gHOKmUra?=
 =?us-ascii?q?dYn4pH2eIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYsWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6Wk0DTqTTMA7mZnh+C/Xk3EgE/3ZrlP9kb5Lwam8O49mNt9JszNRE85i5V?=
 =?us-ascii?q?g4tOoXNnv4cWl9WCUmSOIUfqOKXcSTj2SCU5wicG5f2+N1lEVssOo8V4OtlKXt?=
 =?us-ascii?q?P7vEFMHYLYwzrr/i/zru2TsFvi94lIc2tO5kQ0ll71zDfDOgvWtbbSqPG/8JG1?=
 =?us-ascii?q?Ts5rsRPG+vOIcsfdTdrKh/HZnVnPloRAro9kf2ui325dCdXwHqLpLA6+GiVzxF?=
 =?us-ascii?q?02aLFNNvTc8aNA8JPkS6womPA4nS8GhQyKtOS03yG/2iqi+uJmjn0MKoWFbul5?=
 =?us-ascii?q?rtpjUeVy2g7FhIbTx24rOO/h0r4XMhQQ2QR+ywhqoAo+UCrR8W7VBq9yFacswI?=
 =?us-ascii?q?RQch4Eus08giBx6PYpQGDCQAsTCNbaZoiucsyRBQw21OJls+vDjtq2JWLSHSW+?=
 =?us-ascii?q?7GI6zyvODQJKnMqYS4CRBECpd75r+kOYrjnJjp4OPfq1ZusQ2i2nWDM/HV4nbg?=
 =?us-ascii?q?Ny9UFzeO98Eyvvt5lnbCRJiZd2+kddjvNAttFWbOY?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AiR1I2qAkbITSlhnlHemr55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9HfbyqynDpp4mPFrP6Qr5O0tQ/OxoWpPhfZq0z/cc3WBSB8bAYOCMgg?=
 =?us-ascii?q?WVxe9ZgbcKjweQeRHWx6ptkZ1tdKVzE7TLYGRSh8yS2maFL+o=3D?=
X-IronPort-AV: E=Sophos;i="5.88,267,1635199200"; 
   d="scan'208";a="1858844"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 20:49:09 +0100
Date:   Thu, 6 Jan 2022 20:49:08 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Francisco Jerez <currojerez@riseup.net>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
In-Reply-To: <87a6g9rbje.fsf@riseup.net>
Message-ID: <alpine.DEB.2.22.394.2201062044340.3098@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien> <alpine.DEB.2.22.394.2112291012030.24929@hadrien> <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com> <alpine.DEB.2.22.394.2112301840360.15550@hadrien>
 <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com> <alpine.DEB.2.22.394.2112301919240.15550@hadrien> <CAJZ5v0haa5QWvTUUg+wwSHvuWyk8pic1N0kox=E1ZKNrHSFuzw@mail.gmail.com> <alpine.DEB.2.22.394.2112301942360.15550@hadrien>
 <CAJZ5v0im+Cke7tcNRav2VCyf5Qvi7qC29aF+9A1kVZZmt7cu6g@mail.gmail.com> <alpine.DEB.2.22.394.2201031922110.3020@hadrien> <CAJZ5v0hsCjKA3EisK9s_S8Vb9Tgm4eps1FTKvUSfd9_JPh5wBQ@mail.gmail.com> <alpine.DEB.2.22.394.2201032110590.3020@hadrien>
 <CAJZ5v0hFcRWPO859YWUKLdqkTrVA1WLqRjFWg1=WS8qGG5CTkQ@mail.gmail.com> <alpine.DEB.2.22.394.2201041643520.3020@hadrien> <CAJZ5v0i9Rh0Cm3Mbu3N8w6UmgJEnmThk4znWVcp9qeroabjsNw@mail.gmail.com> <alpine.DEB.2.22.394.2201052107280.48852@hadrien>
 <87a6g9rbje.fsf@riseup.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Jan 2022, Francisco Jerez wrote:

> Julia Lawall <julia.lawall@inria.fr> writes:
>
> > On Tue, 4 Jan 2022, Rafael J. Wysocki wrote:
> >
> >> On Tue, Jan 4, 2022 at 4:49 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >> >
> >> > I tried the whole experiment again on an Intel w2155 (one socket, 10
> >> > physical cores, pstates 12, 33, and 45).
> >> >
> >> > For the CPU there is a small jump a between 32 and 33 - less than for the
> >> > 6130.
> >> >
> >> > For the RAM, there is a big jump between 21 and 22.
> >> >
> >> > Combining them leaves a big jump between 21 and 22.
> >>
> >> These jumps are most likely related to voltage increases.
> >>
> >> > It seems that the definition of efficient is that there is no more cost
> >> > for the computation than the cost of simply having the machine doing any
> >> > computation at all.  It doesn't take into account the time and energy
> >> > required to do some actual amount of work.
> >>
> >> Well, that's not what I wanted to say.
> >
> > I was referring to Francisco's comment that the lowest indicated frequency
> > should be the most efficient one.  Turbostat also reports the lowest
> > frequency as the most efficient one.  In my graph, there are the pstates 7
> > and 10, which give exactly the same energy consumption as 12.  7 and 10
> > are certainly less efficient, because the energy consumption is the same,
> > but the execution speed is lower.
> >
> >> Of course, the configuration that requires less energy to be spent to
> >> do a given amount of work is more energy-efficient.  To measure this,
> >> the system needs to be given exactly the same amount of work for each
> >> run and the energy spent by it during each run needs to be compared.
>
> I disagree that the system needs to be given the exact same amount of
> work in order to measure differences in energy efficiency.  The average
> energy efficiency of Julia's 10s workloads can be calculated easily in
> both cases (e.g. as the W/E ratio below, W will just be a different
> value for each run), and the result will likely approximate the
> instantaneous energy efficiency of the fixed P-states we're comparing,
> since her workload seems to be fairly close to a steady state.
>
> >
> > This is bascially my point of view, but there is a question about it.  If
> > over 10 seconds you consume 10J and by running twice as fast you would
> > consume only 6J, then how do you account for the nest 5 seconds?  If the
> > machine is then idle for the next 5 seconds, maybe you would end up
> > consuming 8J in total over the 10 seconds.  But if you take advantage of
> > the free 5 seconds to pack in another job, then you end up consuming 12J.
> >
>
> Geometrically, such an oscillatory workload with periods of idling and
> periods of activity would give an average power consumption along the
> line that passes through the points corresponding to both states on the
> CPU's power curve -- IOW your average power consumption will just be the
> weighted average of the power consumption of each state (with the duty
> cycle t_i/t_total of each state being its weight):
>
> P_avg = t_0/t_total * P_0 + t_1/t_total * P_1
>
> Your energy usage would just be 10s times that P_avg, since you're
> assuming that the total runtime of the workload is fixed at 10s
> independent of how long the CPU actually takes to complete the
> computation.  In cases where the P-state during the period of activity
> t_1 is equal or lower to the maximum efficiency P-state, that line
> segment is guaranteed to lie below the power curve, indicating that such
> oscillation is more efficient than running the workload fixed to its
> average P-state.
>
> That said, this scenario doesn't really seem very relevant to your case,
> since the last workload you've provided turbostat traces for seems to
> show almost no oscillation.  If there was such an oscillation, your
> total energy usage would still be greater for oscillations between idle
> and some P-state different from the most efficient one.  Such an
> oscillation doesn't explain the anomaly we're seeing on your traces,
> which show more energy-efficient instantaneous behavior for a P-state 2x
> the one reported by your processor as the most energy-efficient.

All the turbostat output and graphs I have sent recently were just for
continuous spinning:

for(;;);

Now I am trying running for the percentage of the time corresponding to
10 / P for pstate P (ie 0.5 of the time for pstate 20), and then sleeping,
to see whether one can just add the sleeping power consumption of the
machine to compute the efficiency as Rafael suggested.

julia

>
> >> However, I think that you are interested in answering a different
> >> question: Given a specific amount of time (say T) to run the workload,
> >> what frequency to run the CPUs doing the work at in order to get the
> >> maximum amount of work done per unit of energy spent by the system (as
> >> a whole)?  Or, given 2 different frequency levels, which of them to
> >> run the CPUs at to get more work done per energy unit?
> >
> > This is the approach where you assume that the machine will be idle in any
> > leftover time.  And it accounts for the energy consumed in that idle time.
> >
> >> The work / energy ratio can be estimated as
> >>
> >> W / E = C * f / P(f)
> >>
> >> where C is a constant and P(f) is the power drawn by the whole system
> >> while the CPUs doing the work are running at frequency f, and of
> >> course for the system discussed previously it is greater in the 2 GHz
> >> case.
> >>
> >> However P(f) can be divided into two parts, P_1(f) that really depends
> >> on the frequency and P_0 that does not depend on it.  If P_0 is large
> >> enough to dominate P(f), which is the case in the 10-20 range of
> >> P-states on the system in question, it is better to run the CPUs doing
> >> the work faster (as long as there is always enough work to do for
> >> them; see below).  This doesn't mean that P(f) is not a convex
> >> function of f, though.
> >>
> >> Moreover, this assumes that there will always be enough work for the
> >> system to do when running the busy CPUs at 2 GHz, or that it can go
> >> completely idle when it doesn't do any work, but let's see what
> >> happens if the amount of work to do is W_1 = C * 1 GHz * T and the
> >> system cannot go completely idle when the work is done.
> >>
> >> Then, nothing changes for the busy CPUs running at 1 GHz, but in the 2
> >> GHz case we get W = W_1 and E = P(2 GHz) * T/2 + P_0 * T/2, because
> >> the busy CPUs are only busy 1/2 of the time, but power P_0 is drawn by
> >> the system regardless.  Hence, in the 2 GHz case (assuming P(2 GHz) =
> >> 120 W and P_0 = 90 W), we get
> >>
> >> W / E = 2 * C * 1 GHz / (P(2 GHz) + P_0) = 0.0095 * C * 1 GHz
> >>
> >> which is slightly less than the W / E ratio at 1 GHz approximately
> >> equal to 0.01 * C * 1 GHz (assuming P(1 GHz) = 100 W), so in these
> >> conditions it would be better to run the busy CPUs at 1 GHz.
> >
> > OK, I'll try to measure this.
> >
> > thanks,
> > julia
>
