Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB3F48A904
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348767AbiAKH7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbiAKH7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:59:13 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78843C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 23:59:12 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id br17so22129280lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 23:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNtpgItJBIUx2EsKxwE1qB9lXMXL7lSQrxOBWiGduBY=;
        b=pbf6YpWeL4FRSePzvVTnQ1mPlJC9YYhEsysl24wHC8thv0FJEybikgqWhjqbbAhvnX
         ccKMf+sdwlW7vrcc7q8UjKb4k2tr/rp3oshMReXm1RLT8Cz8oxh+fe9FU9xDX0o1OgJh
         YwfH3yDGuAhZoFB0Z7PR2UQ5e5PkfLRMTnrtB+UcdbSzT8xZha5XFSFNoeLUf2ti65Fs
         29SdQ2yxUKVuiyJukj+9GEsxPDoNLOmpqbYbUzoxbWNxn0sqKa6upTNuSG++0kspj4Sv
         M143lbQGUS7D/G6ZpBgKEdk583/NKlACQ5AQvo5m34pmNOP66zxMMqQ6v8xzUspwhw++
         YSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNtpgItJBIUx2EsKxwE1qB9lXMXL7lSQrxOBWiGduBY=;
        b=QBbjuzK1Ku6GOY68MJbBhZQkTrAo7ny3OSxs3Rxnh6kq8QrSeZ1zbX56WRZJcyUKUF
         N3nLO0SmY4WTiLTPclgosN1nxVnURvGC3/zoif7x9CJ6951Po5Ztjv9xYuKK8mjywoz+
         Yh5r93iTWJBcyVoPrEOrlYgvh5i3DaKwhWWWOIWoTlorJsY9W1HzPditecIRxwI3786n
         bXpb60OFcVS26YTN5lKdac8Z/9638ZNzyYhBgu2473FAPDdBBrlvW91CK91pOwEpY9NX
         y4GDyuiLm+Nb2NY0DAUdqmB+EeLAMnu0zSIFhxkRiHICwBN6jz5PwO/XH9RCvQGOrYUq
         9I1w==
X-Gm-Message-State: AOAM5321NRwm+bA88Lm37vpC5jpEGhAja6KAr5ifot3Nv/cOTEUcpUuP
        UYX9m6TS8gdDZlBQ+GFm/igRU0MFTZnVJquxecGeTw==
X-Google-Smtp-Source: ABdhPJzfMr+A0PhrHu2XGLs1czrc3XQJZqSUNm+6v7LuAcKg5sEjALBTASL5kjDeWPAuHdLeccdWlVvQ0rgjeC/DsfQ=
X-Received: by 2002:a2e:968a:: with SMTP id q10mr2054360lji.381.1641887950719;
 Mon, 10 Jan 2022 23:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20211211104324.95957-1-yangyicong@hisilicon.com>
 <CAKfTPtCaxGhpGk348Q8jGcEA13Xv4VHS+nX0aW4C+ba5df_4Lw@mail.gmail.com>
 <12315dc8-4b37-339d-3a41-f3a8b10344d7@huawei.com> <CAKfTPtCPRk+2L6wSHBpN-ewTX1Cj4U7a_m1itsSk9Yav-jE-9Q@mail.gmail.com>
 <a8f0d13a-c2a5-d896-d655-846d373427b8@huawei.com>
In-Reply-To: <a8f0d13a-c2a5-d896-d655-846d373427b8@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 11 Jan 2022 08:58:59 +0100
Message-ID: <CAKfTPtA9WG=nEPdNKgYQzf-Us3-i5+h=+vFcMzaT0yZBmxFeaA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Track target domain's avg_scan_cost in select_idle_cpu
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     yangyicong@hisilicon.com, peterz@infradead.org, mingo@redhat.com,
        juri.lelli@redhat.com, mgorman@techsingularity.net,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        prime.zeng@huawei.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        "tiantao (H)" <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 at 10:10, Yicong Yang <yangyicong@huawei.com> wrote:
>
> On 2022/1/4 22:18, Vincent Guittot wrote:
> > On Thu, 23 Dec 2021 at 09:23, Yicong Yang <yangyicong@huawei.com> wrote:
> >>
> >> On 2021/12/22 18:47, Vincent Guittot wrote:
> >>> On Sat, 11 Dec 2021 at 11:43, Yicong Yang <yangyicong@hisilicon.com> wrote:
> >>>>
> >>>> We regulate the LLC domain scan in select_idle_cpu() by comparing
> >>>> the average scan cost of this_sd against the average idle time of
> >>>> this_rq. This is correct when the domain to scan is the LLC domain
> >>>> of this cpu. But when the domain to scan is different from this
> >>>> LLC domain, we'll have an inaccurate estimation of the scan cost
> >>>> on the target domain as this_sd->avg_scan_cost contains contributions
> >>>> of scanning other domains besides the target domain.
> >>>>
> >>>> Track the avg_scan_cost of the target domain to make the estimation
> >>>> more accurate.
> >>>>
> >>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >>>> ---
> >>>>  kernel/sched/fair.c | 4 ++--
> >>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>> index 6e476f6d9435..6301740d98cb 100644
> >>>> --- a/kernel/sched/fair.c
> >>>> +++ b/kernel/sched/fair.c
> >>>> @@ -6267,7 +6267,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>>>                 }
> >>>>
> >>>>                 avg_idle = this_rq->wake_avg_idle;
> >>>> -               avg_cost = this_sd->avg_scan_cost + 1;
> >>>> +               avg_cost = sd->avg_scan_cost + 1;
> >>>>
> >>>>                 span_avg = sd->span_weight * avg_idle;
> >>>>                 if (span_avg > 4*avg_cost)
> >>>> @@ -6305,7 +6305,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>>>                  */
> >>>>                 this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
> >>>>
> >>>> -               update_avg(&this_sd->avg_scan_cost, time);
> >>>> +               update_avg(&sd->avg_scan_cost, time);
> >>>
> >>> But then you can have several cpus updating the same value simultaneously
> >>>
> >>
> >> yes. sd->avg_scan_cost should includes the contributions of all the cpus scanned the sd.
> >>
> >> We regulated the scanning nr based on two things:
> >> - avg_idle: to indicate how much time we can have for this time scanning
> >> - avg_cost: to indicate how much time we'll spend for scanning the target domain based
> >>             on the history cost
> >>
> >> Previously sd->avg_scan_cost may not reflect the cost as it count the scanning cost
> >> on the domain of the scanner cpu, which may not be the domain the cpu scanned.
> >> For example, cpu 0 on llc A scanned llc B and llc C, we'll count the cost of scanning B
> >> and C on llc A's avg_scan_cost and we'll use this to estimate the cost for scanning
> >> llc A, which is not accurate.
> >
> > I mean that you can now have several CPUs that will read, modify,
> > write sd->avg_scan_cost simultaneously without any protection
> >
>
> uh I misunderstood. not sure I've missed something, but looks like we also have this problem
> when updating &this_sd->avg_scan_cost?

No because this_sd->avg_scan_cost is only used by the local cpu so you
don't have several cpus trying to update it simultaneously.

>
> >>
> >>>>         }
> >>>>
> >>>>         return idle_cpu;
> >>>> --
> >>>> 2.33.0
> >>>>
> >>> .
> >>>
> > .
> >
