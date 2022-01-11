Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D2E48B238
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350010AbiAKQad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350003AbiAKQab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:30:31 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF4DC061751
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:30:30 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x6so58286380lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9eaenoAWNeSLzKA3UI5JWr0kNWUc7UBSImBTjqz+Omg=;
        b=pvD3KNB9pduFBsZD3k89Sn1eF7lrCYnZLu0EZLYw8/UMVChril7XNlNr3mnDd+eC1z
         q5nIgtRpf3136cLNWQ8H/wLbBIb6UeQjS4t4v1TvqV4BXTRaHEM6WI0Ab4ygFBVPGDQE
         UvcxCPcDzdmuTejvIuk2sdeHwWFkzTt99Z0AhgjNZnvthKgqwLnBUtBvfAZxNAjT9Dod
         itrXuaawOGgwQ6yd3v/KD5e9d8HOT3nKA/ke91YA0nNdT+lEn8+qQmLrYaG3W28RaNSI
         w6AZ5y/2nVREZ2S3YB2V+9PvvYSkttq7aeILYePHwzsbC7jmcarclj1Tp0NJUGxSKr3b
         vFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eaenoAWNeSLzKA3UI5JWr0kNWUc7UBSImBTjqz+Omg=;
        b=n4dcrqGomIJZi6FhitAIg6HRNvl8weWH7aPyooTIw9s5vQPpFNOJSQNXc9VPtXmGhE
         qerzv2h88hCsL2FZ2dJmmy2Edr53Xb0vmzqqjbe7N1KG4e1WdIxs/zPwVQ9wDvI+EhC6
         oFpaDr7eIm3+dCEMF7x3S5fVmJvMauy23bOVwdl7cF2wPlj2c8Bj7tyqykOGUZ8UAFKA
         NW5bfDQ2loigWnLnh0N/bfYPnIUOrMM5UtY1a48HB21qFThj3xIU8IOMg0aDCjcF9ghw
         ZxQtoovwtHnsjqDi3ds7SzSgFIQitG/G/L0wN1eNJELNhiEnhaDJC1xDLIcKwDV/kvH3
         UYsA==
X-Gm-Message-State: AOAM530Gxpah/YvlL2KTK4GkiGFt6JDlnEhzDMFr38KXDyS/4miUEMip
        GlndHYes9MhRT+19uoc3VQ4epmLFkyHbqwd13Er9Ew==
X-Google-Smtp-Source: ABdhPJw2L6gRiKtGU5TLt4+aiVQ9916RRDKiZnKnW1AOlNZ4VfcqStHQSSaJksxnr3pEDpjT4DtMHrdOrRXrYNu8DlQ=
X-Received: by 2002:ac2:5690:: with SMTP id 16mr3107379lfr.430.1641918628752;
 Tue, 11 Jan 2022 08:30:28 -0800 (PST)
MIME-Version: 1.0
References: <20211211104324.95957-1-yangyicong@hisilicon.com>
 <CAKfTPtCaxGhpGk348Q8jGcEA13Xv4VHS+nX0aW4C+ba5df_4Lw@mail.gmail.com>
 <12315dc8-4b37-339d-3a41-f3a8b10344d7@huawei.com> <CAKfTPtCPRk+2L6wSHBpN-ewTX1Cj4U7a_m1itsSk9Yav-jE-9Q@mail.gmail.com>
 <a8f0d13a-c2a5-d896-d655-846d373427b8@huawei.com> <CAKfTPtA9WG=nEPdNKgYQzf-Us3-i5+h=+vFcMzaT0yZBmxFeaA@mail.gmail.com>
 <CAGsJ_4zf=BOo0NxvpO4sHKaaeHar_Lmnkz3Eu=d7=1nOgjTwcQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zf=BOo0NxvpO4sHKaaeHar_Lmnkz3Eu=d7=1nOgjTwcQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 11 Jan 2022 17:30:17 +0100
Message-ID: <CAKfTPtBh+_gKBudNLMzS3ReykSQjnfqx++Z_ErUwfT4Ly+tOSQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Track target domain's avg_scan_cost in select_idle_cpu
To:     Barry Song <21cnbao@gmail.com>
Cc:     Yicong Yang <yangyicong@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        prime.zeng@huawei.com, Linuxarm <linuxarm@huawei.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 at 09:32, Barry Song <21cnbao@gmail.com> wrote:
>
> On Tue, Jan 11, 2022 at 8:59 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Thu, 6 Jan 2022 at 10:10, Yicong Yang <yangyicong@huawei.com> wrote:
> > >
> > > On 2022/1/4 22:18, Vincent Guittot wrote:
> > > > On Thu, 23 Dec 2021 at 09:23, Yicong Yang <yangyicong@huawei.com> wrote:
> > > >>
> > > >> On 2021/12/22 18:47, Vincent Guittot wrote:
> > > >>> On Sat, 11 Dec 2021 at 11:43, Yicong Yang <yangyicong@hisilicon.com> wrote:
> > > >>>>
> > > >>>> We regulate the LLC domain scan in select_idle_cpu() by comparing
> > > >>>> the average scan cost of this_sd against the average idle time of
> > > >>>> this_rq. This is correct when the domain to scan is the LLC domain
> > > >>>> of this cpu. But when the domain to scan is different from this
> > > >>>> LLC domain, we'll have an inaccurate estimation of the scan cost
> > > >>>> on the target domain as this_sd->avg_scan_cost contains contributions
> > > >>>> of scanning other domains besides the target domain.
> > > >>>>
> > > >>>> Track the avg_scan_cost of the target domain to make the estimation
> > > >>>> more accurate.
> > > >>>>
> > > >>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > > >>>> ---
> > > >>>>  kernel/sched/fair.c | 4 ++--
> > > >>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >>>>
> > > >>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > >>>> index 6e476f6d9435..6301740d98cb 100644
> > > >>>> --- a/kernel/sched/fair.c
> > > >>>> +++ b/kernel/sched/fair.c
> > > >>>> @@ -6267,7 +6267,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > > >>>>                 }
> > > >>>>
> > > >>>>                 avg_idle = this_rq->wake_avg_idle;
> > > >>>> -               avg_cost = this_sd->avg_scan_cost + 1;
> > > >>>> +               avg_cost = sd->avg_scan_cost + 1;
> > > >>>>
> > > >>>>                 span_avg = sd->span_weight * avg_idle;
> > > >>>>                 if (span_avg > 4*avg_cost)
> > > >>>> @@ -6305,7 +6305,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > > >>>>                  */
> > > >>>>                 this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
> > > >>>>
> > > >>>> -               update_avg(&this_sd->avg_scan_cost, time);
> > > >>>> +               update_avg(&sd->avg_scan_cost, time);
> > > >>>
> > > >>> But then you can have several cpus updating the same value simultaneously
> > > >>>
> > > >>
> > > >> yes. sd->avg_scan_cost should includes the contributions of all the cpus scanned the sd.
> > > >>
> > > >> We regulated the scanning nr based on two things:
> > > >> - avg_idle: to indicate how much time we can have for this time scanning
> > > >> - avg_cost: to indicate how much time we'll spend for scanning the target domain based
> > > >>             on the history cost
> > > >>
> > > >> Previously sd->avg_scan_cost may not reflect the cost as it count the scanning cost
> > > >> on the domain of the scanner cpu, which may not be the domain the cpu scanned.
> > > >> For example, cpu 0 on llc A scanned llc B and llc C, we'll count the cost of scanning B
> > > >> and C on llc A's avg_scan_cost and we'll use this to estimate the cost for scanning
> > > >> llc A, which is not accurate.
> > > >
> > > > I mean that you can now have several CPUs that will read, modify,
> > > > write sd->avg_scan_cost simultaneously without any protection
> > > >
> > >
> > > uh I misunderstood. not sure I've missed something, but looks like we also have this problem
> > > when updating &this_sd->avg_scan_cost?
> >
> > No because this_sd->avg_scan_cost is only used by the local cpu so you
> > don't have several cpus trying to update it simultaneously.
>
> Though this is a problem, does the original idea in this patch make some sense?
> CPUx might scan its own LLC and it might scan other LLCs.  the scan cost should
> be depending on how busy the target LLC is?
>
> it seems improper to have one single scan cost for all targets/LLCs?

I'm not sure that this would make any real difference. We use local
cpu to prevent costly protection and cache line bouncing between cpus.
There are several shortfalls in the current way to estimate how many
cores we should scan.

>
> >
> > >
> > > >>
> > > >>>>         }
> > > >>>>
> > > >>>>         return idle_cpu;
> > > >>>> --
> > > >>>> 2.33.0
> > > >>>>
> > > >>> .
> > > >>>
> > > > .
> > > >
>
> Thanks
> Barry
