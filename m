Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D311483814
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 21:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiACUvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 15:51:37 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:46072
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbiACUvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 15:51:36 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AZBxJoai1JhWGmQMxaIZ8jOi9X161dhEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkVTxjcaWziPPfyLajD3fo0ka9+z9koP6p/Vxt43HVNoqXw8FHgiR?=
 =?us-ascii?q?ejtVY3IdB+oV8+xBpSeFxw/t512huEtnanYd1eEzvuWGuWn/SkUOZ2gHOKmUra?=
 =?us-ascii?q?dYnspHmeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYsWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6Wk0DTqTTMA7mZnh+C/Xk3EgE/3ZrlP9kb5Lwam8O49mNt9JszNRE85i5V?=
 =?us-ascii?q?g4tOoXNnv4cWl9WCUmSOIUfpeWeeSXu2SCU5wicG5f2+N10BU8/MIkw+ettB2x?=
 =?us-ascii?q?Ks/sCJ1glZQ2ZneW0zai2WMF2h98uMdGtOo4D0ll71zDfDOgvWtbbSqPG/8JG1?=
 =?us-ascii?q?Ts5rsRPG+vOIcsfdTdrKh/HZnVnPloRAro9kf2ui325dCdXwHqLpLA6+GiVzxF?=
 =?us-ascii?q?02aLFNNvTc8aNA8JPkS6womPA4nS8GhQyKtOS03yG/2iqi+uJmjn0MKoWFbul5?=
 =?us-ascii?q?rtpjUeVy2g7FhIbTx24rOO/h0r4XMhQQ2QR+ywhqoAo+UCrR8W7VBq9yFacswI?=
 =?us-ascii?q?RQch4Eus08giBx6PYpQGDCQAsTCNbaZoiucsyRBQw21OJls+vDjtq2JWLSHSW+?=
 =?us-ascii?q?7GI6zyvODQJKnMqYS4CRBECpd75r+kOYrjnJjp4OPfq1ZusQ2i2nWDM/HV4nbg?=
 =?us-ascii?q?Ny9UFzeO98Eyvvt5lnbCRJiZd2+kddjvNAttFWbOY?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AfaH9kqtVqy7f2yd2VW0LTAXN7skDkdV00zEX?=
 =?us-ascii?q?/kB9WHVpmwKj5rmTdZUgpG3JYVkqNE3Ip+rwT5VoLUmyyXcx2+ks1VnLZniZhI?=
 =?us-ascii?q?OHRLsSnbcK6QeQZxEXz4ZmpNZdm0IXMqyCMbECt7eE3ODaKadD/DDkysGVrMPf?=
 =?us-ascii?q?y3soUg1wcaFn6G5Ce3Om+xZNNXR77PMCffL2jKd6TnibCBcqh+uAdw04toP41q?=
 =?us-ascii?q?X2fefdEHg77mkcmW6zZF2ThoIT0nCjr2wjukt0sNMfGeesqX2C2kz1iYDf9iPh?=
X-IronPort-AV: E=Sophos;i="5.88,258,1635199200"; 
   d="scan'208";a="1521059"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 21:51:34 +0100
Date:   Mon, 3 Jan 2022 21:51:33 +0100 (CET)
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
In-Reply-To: <CAJZ5v0hsCjKA3EisK9s_S8Vb9Tgm4eps1FTKvUSfd9_JPh5wBQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2201032110590.3020@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien> <878rwdse9o.fsf@riseup.net> <alpine.DEB.2.22.394.2112281745240.24929@hadrien> <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com> <alpine.DEB.2.22.394.2112281845180.24929@hadrien>
 <CAJZ5v0grayg9evWsB5ktKSFq=yA_AHoEWSfpSkQ=MVQ-=butfA@mail.gmail.com> <alpine.DEB.2.22.394.2112291012030.24929@hadrien> <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com> <alpine.DEB.2.22.394.2112301840360.15550@hadrien>
 <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com> <alpine.DEB.2.22.394.2112301919240.15550@hadrien> <CAJZ5v0haa5QWvTUUg+wwSHvuWyk8pic1N0kox=E1ZKNrHSFuzw@mail.gmail.com> <alpine.DEB.2.22.394.2112301942360.15550@hadrien>
 <CAJZ5v0im+Cke7tcNRav2VCyf5Qvi7qC29aF+9A1kVZZmt7cu6g@mail.gmail.com> <alpine.DEB.2.22.394.2201031922110.3020@hadrien> <CAJZ5v0hsCjKA3EisK9s_S8Vb9Tgm4eps1FTKvUSfd9_JPh5wBQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Jan 2022, Rafael J. Wysocki wrote:

> On Mon, Jan 3, 2022 at 7:23 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > > > > Can you please run the 32 spinning threads workload (ie. on one
> > > > > package) and with P-state locked to 10 and then to 20 under turbostat
> > > > > and send me the turbostat output for both runs?
> > > >
> > > > Attached.
> > > >
> > > > Pstate 10: spin_minmax_10_dahu-9_5.15.0freq_schedutil_11.turbo
> > > > Pstate 20: spin_minmax_20_dahu-9_5.15.0freq_schedutil_11.turbo
> > >
> > > Well, in  both cases there is only 1 CPU running and it is running at
> > > 1 GHz (ie. P-state 10) all the time as far as I can say.
> >
> > It looks better now.  I included 1 core (core 0) for pstates 10, 20, and
> > 21, and 32 cores (socket 0) for the same pstates.
>
> OK, so let's first consider the runs where 32 cores (entire socket 0)
> are doing the work.
>
> This set of data clearly shows that running the busy cores at 1 GHz
> takes less energy than running them at 2 GHz (the ratio of these
> numbers is roughly 2/3 if I got that right).  This means that P-state
> 10 is more energy efficient than P-state 20, as expected.

Here all the threads always spin for 10 seconds.  But if they had a fixed
amount of work to do, they should finish twice as fast at pstate 20.
Currently, we have 708J at pstate 10 and 905J at pstate 20, but if we can
divide the time at pstate 20 by 2, we should be around 450J, which is much
less than 708J.

turbostat -J sleep 5 shows 105J, so we're still ahead.

I haven't yet tried the actual experiment of spinning for 5 seconds and
then sleeping for 5 seconds, though.

>
> However, the cost of running at 2.1 GHz is much greater than the cost
> of running at 2 GHz and I'm still thinking that this is attributable
> to some kind of voltage increase between P-state 20 and P-state 21
> (which, interestingly enough, affects the second "idle" socket too).
>
> In the other set of data, where only 1 CPU is doing the work, P-state
> 10 is still more energy-efficient than P-state 20,

Actually, this doesn't seem to be the case.  It's surely due to the
approximation of the result, but the consumption is slightly lower for
pstate 20.  With more runs it probably averages out to around the same.

julia

> but it takes more
> time to do the work at 1 GHz, so the energy lost due to leakage
> increases too and it is "leaked" by all of the CPUs in the package
> (including the idle ones in core C-states), so overall this loss
> offsets the gain from using a more energy-efficient P-state.  At the
> same time, socket 1 can spend more time in PC2 when the busy CPU is
> running at 2 GHz (which means less leakage in that socket), so with 1
> CPU doing the work the total cost of running at 2 GHz is slightly
> smaller than the total cost of running at 1 GHz.  [Note how important
> it is to take the other CPUs in the system into account in this case,
> because there are simply enough of them to affect one-CPU measurements
> in a significant way.]
>
> Still, when going from 2 GHz to 2.1 GHz, the voltage jump causes the
> energy to increase significantly again.
>
