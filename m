Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CE14837DB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiACT7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:59:01 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]:34741 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiACT7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:59:00 -0500
Received: by mail-qv1-f46.google.com with SMTP id ke6so32054684qvb.1;
        Mon, 03 Jan 2022 11:59:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKB1Oi91f6KvIqp2AxsAOCYi2Log+4aZ60rW4FxHnFY=;
        b=NOP4VwFcwxQQGSTvJAUiBZXRbnOUt3QByaGdhA+WGyP71DZxbuRPdKK5ezUpJujh81
         u00L8lhEuy76UE02g9G2iS/Uth+vdNyKUUsQTBWE05iPACE3PZoKWyt8xygpduq1y5Zl
         YkrcOLofPbJqKI8Vn1278Eg1J0J/IulqxqMbKXzD2CvVK+Q9+3WvvfN8YBk8iJdYQwun
         DI2I7oNunnO5t5m4ij5xOHGh3g7V8JnjPte8d+qQliny+k22CRVhCnyMrdaz71W1q2xL
         ibONjTI1wLjQjYw1Kl7xgIFmKYen37zOs1FBvU1LBEb8L6C2RD1ufesQpQbXbKmFinoK
         PJ+w==
X-Gm-Message-State: AOAM533us76B1cVOR/8/myJn6OEq6lrv5O4EkPglNnWwOMBEDGrqq+Od
        Oow8nSldYfDC82Tzz5y8y5GtV3BzH64Cy/Man38=
X-Google-Smtp-Source: ABdhPJxzQiqGAYN2+YHxjayMyF9epaOrJg19JLzEhfCXYiawtKXRq5dI7vTa4ZfZTKVPYumKCbyma0KyT71hC/J6JEc=
X-Received: by 2002:a05:6214:224a:: with SMTP id c10mr8699766qvc.35.1641239939785;
 Mon, 03 Jan 2022 11:58:59 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien>
 <alpine.DEB.2.22.394.2112190734070.3181@hadrien> <87wnk0s0tf.fsf@riseup.net>
 <CAJZ5v0i7gBtm6x+zUUzhxXjmYhPwr=JxvOuMZ0aD9qxnjE9YKw@mail.gmail.com>
 <878rwdse9o.fsf@riseup.net> <alpine.DEB.2.22.394.2112281745240.24929@hadrien>
 <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com>
 <alpine.DEB.2.22.394.2112281845180.24929@hadrien> <CAJZ5v0grayg9evWsB5ktKSFq=yA_AHoEWSfpSkQ=MVQ-=butfA@mail.gmail.com>
 <alpine.DEB.2.22.394.2112291012030.24929@hadrien> <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301840360.15550@hadrien> <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301919240.15550@hadrien> <CAJZ5v0haa5QWvTUUg+wwSHvuWyk8pic1N0kox=E1ZKNrHSFuzw@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301942360.15550@hadrien> <CAJZ5v0im+Cke7tcNRav2VCyf5Qvi7qC29aF+9A1kVZZmt7cu6g@mail.gmail.com>
 <alpine.DEB.2.22.394.2201031922110.3020@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2201031922110.3020@hadrien>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Jan 2022 20:58:48 +0100
Message-ID: <CAJZ5v0hsCjKA3EisK9s_S8Vb9Tgm4eps1FTKvUSfd9_JPh5wBQ@mail.gmail.com>
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

On Mon, Jan 3, 2022 at 7:23 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > > > Can you please run the 32 spinning threads workload (ie. on one
> > > > package) and with P-state locked to 10 and then to 20 under turbostat
> > > > and send me the turbostat output for both runs?
> > >
> > > Attached.
> > >
> > > Pstate 10: spin_minmax_10_dahu-9_5.15.0freq_schedutil_11.turbo
> > > Pstate 20: spin_minmax_20_dahu-9_5.15.0freq_schedutil_11.turbo
> >
> > Well, in  both cases there is only 1 CPU running and it is running at
> > 1 GHz (ie. P-state 10) all the time as far as I can say.
>
> It looks better now.  I included 1 core (core 0) for pstates 10, 20, and
> 21, and 32 cores (socket 0) for the same pstates.

OK, so let's first consider the runs where 32 cores (entire socket 0)
are doing the work.

This set of data clearly shows that running the busy cores at 1 GHz
takes less energy than running them at 2 GHz (the ratio of these
numbers is roughly 2/3 if I got that right).  This means that P-state
10 is more energy efficient than P-state 20, as expected.

However, the cost of running at 2.1 GHz is much greater than the cost
of running at 2 GHz and I'm still thinking that this is attributable
to some kind of voltage increase between P-state 20 and P-state 21
(which, interestingly enough, affects the second "idle" socket too).

In the other set of data, where only 1 CPU is doing the work, P-state
10 is still more energy-efficient than P-state 20, but it takes more
time to do the work at 1 GHz, so the energy lost due to leakage
increases too and it is "leaked" by all of the CPUs in the package
(including the idle ones in core C-states), so overall this loss
offsets the gain from using a more energy-efficient P-state.  At the
same time, socket 1 can spend more time in PC2 when the busy CPU is
running at 2 GHz (which means less leakage in that socket), so with 1
CPU doing the work the total cost of running at 2 GHz is slightly
smaller than the total cost of running at 1 GHz.  [Note how important
it is to take the other CPUs in the system into account in this case,
because there are simply enough of them to affect one-CPU measurements
in a significant way.]

Still, when going from 2 GHz to 2.1 GHz, the voltage jump causes the
energy to increase significantly again.
