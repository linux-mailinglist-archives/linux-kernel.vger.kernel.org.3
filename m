Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748E048A965
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346437AbiAKIcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348925AbiAKIcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:32:09 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46025C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:32:09 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z22so18966161edd.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1q/Y969nvFm7u4DzLvP6zLYk7SBgpRktXR1+uoGKjp0=;
        b=A399pBxMUF3yiKhM/gQ3GLBzJpzTyJwPX1N9F+6WnftPujlrA+0M2aDJno4FftLw6q
         Xz1Eur02ZY7lt/9iFoCcFk/njKoUEJaHxRCYrSG5fmpLyQX8ba6RWWQudilcIU0NkhV6
         5IjzCXQUrZpXKnCE8NqKsD08SMEoqltTAlUNNaGQy/PE9om0OKOMKCiqT9olZlCfbvtG
         iOT7ZlLmJXmZCsJ38OY1+8+iEJz9kAQrR9+x0Hsnkf1R/YcXvNn/od++VR8tro/hQZb0
         E7oBx8OZYxM+qTZGH7GaPmXd0AGt63swL/UHAG5TffkI2m3oE5kize6k47Upqr6UthGu
         XQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1q/Y969nvFm7u4DzLvP6zLYk7SBgpRktXR1+uoGKjp0=;
        b=MU9JjaxrjPcJ6OYnrbAOxR9tKL8nxR7/pvhvvLHNTCAaFVQ48xf6Vl15zCFZUt2Aid
         xHjBSlRWzciLU9cLX96Xs1gJTy39Yz4Crz+fo1Aqm9IQhh/Qe7PUIeNqdl7p/tuBAf/x
         c9UiY1NaIG87cKhXcGznDfTREZWuqXFrbrYsrfavTYeUpBBuhZOxZZQnecDK87oHx4de
         UdRj0lB+9dfU3WqxUzisydLRWpjuHxkmYbftk5k6N4GgDoFYj2dE1f0rBs4ramU15HXo
         RxQ8GITuyO+SIyCcEi9LIbsu03B4p65zBUOBOJ7tAXbP24ROwJx0sK0kN+GAnI+WfSc1
         ZpuA==
X-Gm-Message-State: AOAM532MJfQsGNl8rU7DUIGsFyiwXTPQ3FUgU3Hj71T/SknFawZuiuzg
        Zl95XHrn/Ns33qfzeV63/qJJ5dnhydf54z4rato=
X-Google-Smtp-Source: ABdhPJx666+TnpHmJpprqu/03qW1LKn8dtAC1cbPDAlmOftAP5nWmuDgGq/XZwaSRh7r5RceUWV0I1QAMKnRCKkzXds=
X-Received: by 2002:aa7:d60f:: with SMTP id c15mr3302663edr.197.1641889927866;
 Tue, 11 Jan 2022 00:32:07 -0800 (PST)
MIME-Version: 1.0
References: <20211211104324.95957-1-yangyicong@hisilicon.com>
 <CAKfTPtCaxGhpGk348Q8jGcEA13Xv4VHS+nX0aW4C+ba5df_4Lw@mail.gmail.com>
 <12315dc8-4b37-339d-3a41-f3a8b10344d7@huawei.com> <CAKfTPtCPRk+2L6wSHBpN-ewTX1Cj4U7a_m1itsSk9Yav-jE-9Q@mail.gmail.com>
 <a8f0d13a-c2a5-d896-d655-846d373427b8@huawei.com> <CAKfTPtA9WG=nEPdNKgYQzf-Us3-i5+h=+vFcMzaT0yZBmxFeaA@mail.gmail.com>
In-Reply-To: <CAKfTPtA9WG=nEPdNKgYQzf-Us3-i5+h=+vFcMzaT0yZBmxFeaA@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 11 Jan 2022 21:31:54 +1300
Message-ID: <CAGsJ_4zf=BOo0NxvpO4sHKaaeHar_Lmnkz3Eu=d7=1nOgjTwcQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Track target domain's avg_scan_cost in select_idle_cpu
To:     Vincent Guittot <vincent.guittot@linaro.org>
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

On Tue, Jan 11, 2022 at 8:59 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 6 Jan 2022 at 10:10, Yicong Yang <yangyicong@huawei.com> wrote:
> >
> > On 2022/1/4 22:18, Vincent Guittot wrote:
> > > On Thu, 23 Dec 2021 at 09:23, Yicong Yang <yangyicong@huawei.com> wrote:
> > >>
> > >> On 2021/12/22 18:47, Vincent Guittot wrote:
> > >>> On Sat, 11 Dec 2021 at 11:43, Yicong Yang <yangyicong@hisilicon.com> wrote:
> > >>>>
> > >>>> We regulate the LLC domain scan in select_idle_cpu() by comparing
> > >>>> the average scan cost of this_sd against the average idle time of
> > >>>> this_rq. This is correct when the domain to scan is the LLC domain
> > >>>> of this cpu. But when the domain to scan is different from this
> > >>>> LLC domain, we'll have an inaccurate estimation of the scan cost
> > >>>> on the target domain as this_sd->avg_scan_cost contains contributions
> > >>>> of scanning other domains besides the target domain.
> > >>>>
> > >>>> Track the avg_scan_cost of the target domain to make the estimation
> > >>>> more accurate.
> > >>>>
> > >>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > >>>> ---
> > >>>>  kernel/sched/fair.c | 4 ++--
> > >>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> > >>>>
> > >>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > >>>> index 6e476f6d9435..6301740d98cb 100644
> > >>>> --- a/kernel/sched/fair.c
> > >>>> +++ b/kernel/sched/fair.c
> > >>>> @@ -6267,7 +6267,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > >>>>                 }
> > >>>>
> > >>>>                 avg_idle = this_rq->wake_avg_idle;
> > >>>> -               avg_cost = this_sd->avg_scan_cost + 1;
> > >>>> +               avg_cost = sd->avg_scan_cost + 1;
> > >>>>
> > >>>>                 span_avg = sd->span_weight * avg_idle;
> > >>>>                 if (span_avg > 4*avg_cost)
> > >>>> @@ -6305,7 +6305,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > >>>>                  */
> > >>>>                 this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
> > >>>>
> > >>>> -               update_avg(&this_sd->avg_scan_cost, time);
> > >>>> +               update_avg(&sd->avg_scan_cost, time);
> > >>>
> > >>> But then you can have several cpus updating the same value simultaneously
> > >>>
> > >>
> > >> yes. sd->avg_scan_cost should includes the contributions of all the cpus scanned the sd.
> > >>
> > >> We regulated the scanning nr based on two things:
> > >> - avg_idle: to indicate how much time we can have for this time scanning
> > >> - avg_cost: to indicate how much time we'll spend for scanning the target domain based
> > >>             on the history cost
> > >>
> > >> Previously sd->avg_scan_cost may not reflect the cost as it count the scanning cost
> > >> on the domain of the scanner cpu, which may not be the domain the cpu scanned.
> > >> For example, cpu 0 on llc A scanned llc B and llc C, we'll count the cost of scanning B
> > >> and C on llc A's avg_scan_cost and we'll use this to estimate the cost for scanning
> > >> llc A, which is not accurate.
> > >
> > > I mean that you can now have several CPUs that will read, modify,
> > > write sd->avg_scan_cost simultaneously without any protection
> > >
> >
> > uh I misunderstood. not sure I've missed something, but looks like we also have this problem
> > when updating &this_sd->avg_scan_cost?
>
> No because this_sd->avg_scan_cost is only used by the local cpu so you
> don't have several cpus trying to update it simultaneously.

Though this is a problem, does the original idea in this patch make some sense?
CPUx might scan its own LLC and it might scan other LLCs.  the scan cost should
be depending on how busy the target LLC is?

it seems improper to have one single scan cost for all targets/LLCs?

>
> >
> > >>
> > >>>>         }
> > >>>>
> > >>>>         return idle_cpu;
> > >>>> --
> > >>>> 2.33.0
> > >>>>
> > >>> .
> > >>>
> > > .
> > >

Thanks
Barry
