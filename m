Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630A7484313
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbiADOKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:10:10 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:40715 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiADOKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:10:08 -0500
Received: by mail-qt1-f173.google.com with SMTP id l17so34096409qtk.7;
        Tue, 04 Jan 2022 06:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSJCpKrzVTZ0DRHEgcn2i6+0lS6LrPG+CWjHR6R6Hnk=;
        b=j7p6y1MLkHA1OP2QJV6TEJWVqiXkLiZI9qs7aBQrXr39yr6zml7H+sQhQchrc11k2F
         zpeWu/TO1r/Ug0FYAR5K6xiG2swn2OkKaaZZc05IeqQi2mfk7geRMYaibQ7oVyCW8XtP
         eYUGUaIjhNSRXDRruPxMRrN1EFAqW4RHCYF0n0xGrlcc1ktEtMhg7boGesdsYc6FbIZ7
         NQGj4mc0yMfdzJoSCdjeZoXPxXo+TBdipssJYY/pBQbCHAKvGBWnThR3AppOi9Uen6Sr
         CjAK6aydpyvIrburcVnWfzMG+6Cd18agG6rDsNp1+d7e7QEXM/41b2PEoh+RN3lW2nmg
         ix3Q==
X-Gm-Message-State: AOAM530obTSz4uGOmhyawWAzWCw/a1hRi6MIEBhLKyWiEVyYyXJbGmcf
        I6j3AhfRQuQGtZvXsvpT7+8OQ3KKO2IYZ/AukV4=
X-Google-Smtp-Source: ABdhPJyCIhpgxTSRTj7lzFPUo7NOOuzxWqEwokm/Ef4PcUgUQzwerLkXpOPHVhFk7snyadHJmzuprBtVuOkv+Cc8sPE=
X-Received: by 2002:ac8:7c4e:: with SMTP id o14mr44069322qtv.80.1641305407638;
 Tue, 04 Jan 2022 06:10:07 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien>
 <878rwdse9o.fsf@riseup.net> <alpine.DEB.2.22.394.2112281745240.24929@hadrien>
 <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com>
 <alpine.DEB.2.22.394.2112281845180.24929@hadrien> <CAJZ5v0grayg9evWsB5ktKSFq=yA_AHoEWSfpSkQ=MVQ-=butfA@mail.gmail.com>
 <alpine.DEB.2.22.394.2112291012030.24929@hadrien> <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301840360.15550@hadrien> <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301919240.15550@hadrien> <CAJZ5v0haa5QWvTUUg+wwSHvuWyk8pic1N0kox=E1ZKNrHSFuzw@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301942360.15550@hadrien> <CAJZ5v0im+Cke7tcNRav2VCyf5Qvi7qC29aF+9A1kVZZmt7cu6g@mail.gmail.com>
 <alpine.DEB.2.22.394.2201031922110.3020@hadrien> <CAJZ5v0hsCjKA3EisK9s_S8Vb9Tgm4eps1FTKvUSfd9_JPh5wBQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2201032110590.3020@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2201032110590.3020@hadrien>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jan 2022 15:09:56 +0100
Message-ID: <CAJZ5v0hFcRWPO859YWUKLdqkTrVA1WLqRjFWg1=WS8qGG5CTkQ@mail.gmail.com>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Francisco Jerez <currojerez@riseup.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 9:51 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Mon, 3 Jan 2022, Rafael J. Wysocki wrote:
>
> > On Mon, Jan 3, 2022 at 7:23 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > >
> > > > > > Can you please run the 32 spinning threads workload (ie. on one
> > > > > > package) and with P-state locked to 10 and then to 20 under turbostat
> > > > > > and send me the turbostat output for both runs?
> > > > >
> > > > > Attached.
> > > > >
> > > > > Pstate 10: spin_minmax_10_dahu-9_5.15.0freq_schedutil_11.turbo
> > > > > Pstate 20: spin_minmax_20_dahu-9_5.15.0freq_schedutil_11.turbo
> > > >
> > > > Well, in  both cases there is only 1 CPU running and it is running at
> > > > 1 GHz (ie. P-state 10) all the time as far as I can say.
> > >
> > > It looks better now.  I included 1 core (core 0) for pstates 10, 20, and
> > > 21, and 32 cores (socket 0) for the same pstates.
> >
> > OK, so let's first consider the runs where 32 cores (entire socket 0)
> > are doing the work.
> >
> > This set of data clearly shows that running the busy cores at 1 GHz
> > takes less energy than running them at 2 GHz (the ratio of these
> > numbers is roughly 2/3 if I got that right).  This means that P-state
> > 10 is more energy efficient than P-state 20, as expected.
>
> Here all the threads always spin for 10 seconds.

That escaped me, sorry.

>  But if they had a fixed
> amount of work to do, they should finish twice as fast at pstate 20.
> Currently, we have 708J at pstate 10 and 905J at pstate 20, but if we can
> divide the time at pstate 20 by 2, we should be around 450J, which is much
> less than 708J.

But socket 1 is idle and only slightly affected by P-state changes in
the range below P-state 21, so the difference that matters here is
between socket 0 running at 1 GHz and that socket running  at 2 GHz,
which is 420 J vs 620 J (rounded to the closest multiple of 10 J).

> turbostat -J sleep 5 shows 105J, so we're still ahead.
>
> I haven't yet tried the actual experiment of spinning for 5 seconds and
> then sleeping for 5 seconds, though.
>
> >
> > However, the cost of running at 2.1 GHz is much greater than the cost
> > of running at 2 GHz and I'm still thinking that this is attributable
> > to some kind of voltage increase between P-state 20 and P-state 21
> > (which, interestingly enough, affects the second "idle" socket too).
> >
> > In the other set of data, where only 1 CPU is doing the work, P-state
> > 10 is still more energy-efficient than P-state 20,
>
> Actually, this doesn't seem to be the case.  It's surely due to the
> approximation of the result, but the consumption is slightly lower for
> pstate 20.  With more runs it probably averages out to around the same.

First of all, the cost of keeping a socket in the state in which CPUs
can execute code (referred to as PS0 sometimes) is relatively large on
that system.

Because socket 1 spending the vast majority of time in PC2 (in which
instructions cannot be executed by the CPUs in it) consistently draws
around 29 W when CPUs in socket 0 run at 1-2 GHz, the power needed to
keep socket 0 in PC0 must be larger than this and it looks like it is
around 30 W for the given range of P-states (because it cannot exceed
the total power needed to run 1 CPU at 1 GHz). Running 1 CPU 100% busy
on top of that makes around 1% of a difference which is likely below
the accuracy of the power meter (ie. in the noise).

In the case when all of the 16 cores (32 CPUs) in socket 0 are running
we have the 29 J drawn by socket 1 (idle), around 30 W drawn by the
memory (on both sockets), 30 W drawn by socket 0 just because it is in
PC0 all the time and the power drawn because the cores are actually
running.  That last part is around 12 W when they are running at 1 GHz
or around 32 W when they are running at 2 GHz, so if the running cores
alone are taken into consideration, the latter is still more expensive
after all even if work is done twice as fast then.

However, in practice everything counts, not just the running cores
alone, so what is more efficient really depends on the use case.

For example, if it is known that at least 1 CPU will be 100% busy all
the time, the power drawn by socket 1 (mostly in PC2), by the memory
and in order to hold socket 0 in PC0 will need to be drawn anyway and
in that case 1 GHz is more efficient.

If the system as a whole can be completely idle at least from time to
time (in which state it will draw much less power as a whole), though,
it is likely more efficient to run the CPUs at 2 GHz.
