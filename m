Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCCC48486E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbiADTWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:22:44 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:43604 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiADTWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:22:43 -0500
Received: by mail-qt1-f172.google.com with SMTP id q14so35115965qtx.10;
        Tue, 04 Jan 2022 11:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wp74GlQdrHZUygQJsO+V0bS9xXwZMpUvkf88JMzgtUI=;
        b=S9psh+zuay378HkrkoVBwVMzUiFZvB008JltiJbik1WBW23oBJs/5dCq6X/EuiVNc5
         5hUWdLiYt2NBQo3sl0WRoIN/oPOvjQpLFkzxVfq+pezVUD9hxyoYdQEYacMa2zFt0x0m
         Wrj2qXf3EhlGUAAQ6OPva3ce+O8Ilt+pMP5C2eSouIpDKFiCPobS24RB3JSjHM6M3I2D
         lGzEd3mvRw5CNoHiY44z2ElMNI0LzYHCx1kWxLbDYhPhvBCJILHSag8qi0rclwGTh4Pj
         rtBhxfpaLZJRxOANjkUjXERR/TpGhsySpnpMWxlq8BfN5KNw49jYb/+qsEM6+AqIBHXN
         ZtOg==
X-Gm-Message-State: AOAM533F/YqNAWyUsbMfcSfYR73Og7oPBlYDIJTNeQ2oYYM27Sdhs4hE
        B8NL/oxNU48ORw1DVbpcOBzxp1ZDjU/wqdJ1iNU=
X-Google-Smtp-Source: ABdhPJzEFbxzrYC0TOyO80xhUAfOpsOBwCh1vn3/vws42BMFnEhUDI8aBrqEEwT36cOuDAUZHDvVOj03sasQmfmfc/A=
X-Received: by 2002:ac8:7c4e:: with SMTP id o14mr45310625qtv.80.1641324162737;
 Tue, 04 Jan 2022 11:22:42 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien>
 <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com>
 <alpine.DEB.2.22.394.2112281845180.24929@hadrien> <CAJZ5v0grayg9evWsB5ktKSFq=yA_AHoEWSfpSkQ=MVQ-=butfA@mail.gmail.com>
 <alpine.DEB.2.22.394.2112291012030.24929@hadrien> <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301840360.15550@hadrien> <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301919240.15550@hadrien> <CAJZ5v0haa5QWvTUUg+wwSHvuWyk8pic1N0kox=E1ZKNrHSFuzw@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301942360.15550@hadrien> <CAJZ5v0im+Cke7tcNRav2VCyf5Qvi7qC29aF+9A1kVZZmt7cu6g@mail.gmail.com>
 <alpine.DEB.2.22.394.2201031922110.3020@hadrien> <CAJZ5v0hsCjKA3EisK9s_S8Vb9Tgm4eps1FTKvUSfd9_JPh5wBQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2201032110590.3020@hadrien> <CAJZ5v0hFcRWPO859YWUKLdqkTrVA1WLqRjFWg1=WS8qGG5CTkQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2201041643520.3020@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2201041643520.3020@hadrien>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jan 2022 20:22:31 +0100
Message-ID: <CAJZ5v0i9Rh0Cm3Mbu3N8w6UmgJEnmThk4znWVcp9qeroabjsNw@mail.gmail.com>
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

On Tue, Jan 4, 2022 at 4:49 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> I tried the whole experiment again on an Intel w2155 (one socket, 10
> physical cores, pstates 12, 33, and 45).
>
> For the CPU there is a small jump a between 32 and 33 - less than for the
> 6130.
>
> For the RAM, there is a big jump between 21 and 22.
>
> Combining them leaves a big jump between 21 and 22.

These jumps are most likely related to voltage increases.

> It seems that the definition of efficient is that there is no more cost
> for the computation than the cost of simply having the machine doing any
> computation at all.  It doesn't take into account the time and energy
> required to do some actual amount of work.

Well, that's not what I wanted to say.

Of course, the configuration that requires less energy to be spent to
do a given amount of work is more energy-efficient.  To measure this,
the system needs to be given exactly the same amount of work for each
run and the energy spent by it during each run needs to be compared.

However, I think that you are interested in answering a different
question: Given a specific amount of time (say T) to run the workload,
what frequency to run the CPUs doing the work at in order to get the
maximum amount of work done per unit of energy spent by the system (as
a whole)?  Or, given 2 different frequency levels, which of them to
run the CPUs at to get more work done per energy unit?

The work / energy ratio can be estimated as

W / E = C * f / P(f)

where C is a constant and P(f) is the power drawn by the whole system
while the CPUs doing the work are running at frequency f, and of
course for the system discussed previously it is greater in the 2 GHz
case.

However P(f) can be divided into two parts, P_1(f) that really depends
on the frequency and P_0 that does not depend on it.  If P_0 is large
enough to dominate P(f), which is the case in the 10-20 range of
P-states on the system in question, it is better to run the CPUs doing
the work faster (as long as there is always enough work to do for
them; see below).  This doesn't mean that P(f) is not a convex
function of f, though.

Moreover, this assumes that there will always be enough work for the
system to do when running the busy CPUs at 2 GHz, or that it can go
completely idle when it doesn't do any work, but let's see what
happens if the amount of work to do is W_1 = C * 1 GHz * T and the
system cannot go completely idle when the work is done.

Then, nothing changes for the busy CPUs running at 1 GHz, but in the 2
GHz case we get W = W_1 and E = P(2 GHz) * T/2 + P_0 * T/2, because
the busy CPUs are only busy 1/2 of the time, but power P_0 is drawn by
the system regardless.  Hence, in the 2 GHz case (assuming P(2 GHz) =
120 W and P_0 = 90 W), we get

W / E = 2 * C * 1 GHz / (P(2 GHz) + P_0) = 0.0095 * C * 1 GHz

which is slightly less than the W / E ratio at 1 GHz approximately
equal to 0.01 * C * 1 GHz (assuming P(1 GHz) = 100 W), so in these
conditions it would be better to run the busy CPUs at 1 GHz.
