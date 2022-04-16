Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849EF5033B3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiDPCuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiDPCuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:50:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D706F7C7B4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:47:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x33so16471823lfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V3LIHqF3oscICve/hilgFmF41QgpiFdqSHo8qeg4J4Q=;
        b=OcLUVpaYcM44DwyBQd+/0Oc+lTN66tR2jOZQu6PqplzzTtExcEyMKSmHqmZvYnhalD
         +ycocsANftAqq4AJuiVfryd78ih65P7CEydsUhXoaf7Dbz2oJGvoJKbN9K7T4LdutP0C
         3VteAW5X3mXeFzjfFLXe/+SF0j759jH/Q+jKvpf5KTV295WocizvU77o27n1DD968OGg
         xhA8vMzPs/KEP2gADEvZ/bHe1wClamttRaRkvmbGrP/f6O+wLrElQoBfrp+OGvevVXgU
         M3E65XNlLTeHoAMEyd7ymOZzn2QK8to8YmZHoGOxWvBoIR4xPxI6S7m/8TvWV2RQTHy3
         BpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3LIHqF3oscICve/hilgFmF41QgpiFdqSHo8qeg4J4Q=;
        b=2jewVu2D3OLfZJrSA9CMQkzNOG7RfMnD6+wmzTVXqpF6OtrXWZPx5jDHI858B0J9CP
         ZbJMeF91NZJ7o05vZ+l1CI8Td4tHq5fbj4nJ8uCcLuFqMGJ1ZGvTfQylbZcsWG+px/JE
         lM9qwuzmR4Elspe4Y9g8ORKfCz+E71F6090U94o1WCG/kjAGf0A6Kt3wXek1ne0lgSWf
         4li1LJGQpmOa//aZMGQC8MzXwKNIixpxlcG3sQdOt2wz27IDPAuQ8beXlKxBbG4D//pA
         NE9vhZGXPMmQLOx1ue18XLKoxHT3nrDHOxfp3BI7WT0sJvkW3Etqcq7zy0vdfhDrAD3n
         Uybw==
X-Gm-Message-State: AOAM531knQZy5kGkHLDu+sPJb7yrMACBjd9Bd/uskVsAMFtMS/66YeSV
        zVQLb680HnWK4l26dKeVaACUAZVjjfw6q9ZbIYk=
X-Google-Smtp-Source: ABdhPJxQEbUkDVLZi2f8EzAML8pUw0aJsWfJ5/tzvpgU8eTQNBB0zD8qflpEGmAaPcQDRXyQBqZzcN8/qkWY/YJt1cc=
X-Received: by 2002:a05:6512:280e:b0:44a:7d31:5081 with SMTP id
 cf14-20020a056512280e00b0044a7d315081mr1132059lfb.225.1650077249959; Fri, 15
 Apr 2022 19:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220407051932.4071-1-xuewen.yan@unisoc.com> <02350916-aa36-ea53-2c98-91b97f49d27e@arm.com>
 <CAB8ipk-KenZaVWQwWqVMksQXLP5r19BQ1OGAdmwHRbjwv3qFHg@mail.gmail.com>
 <9bb00bcb-f984-1cf6-39aa-c11dcf7f07cb@arm.com> <f100bd49-7a1d-5265-29ce-1092195bb2dd@arm.com>
In-Reply-To: <f100bd49-7a1d-5265-29ce-1092195bb2dd@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Sat, 16 Apr 2022 10:47:18 +0800
Message-ID: <CAB8ipk8v1-jyU0Q0k-EXCArsS6Sh=U+fW6NutW+6m+kQ=LKrJA@mail.gmail.com>
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
To:     Lukasz Luba <Lukasz.Luba@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luba  / Dietmar

On Wed, Apr 13, 2022 at 9:26 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 4/11/22 15:07, Dietmar Eggemann wrote:
> > On 11/04/2022 10:52, Xuewen Yan wrote:
> >> HI Dietmar
> >>
> >> On Mon, Apr 11, 2022 at 4:21 PM Dietmar Eggemann
> >> <dietmar.eggemann@arm.com> wrote:
> >>>
> >>> On 07/04/2022 07:19, Xuewen Yan wrote:
> >>>> There are cases when the cpu max capacity might be reduced due to thermal.
> >>>> Take into the thermal pressure into account when judge whether the rt task
> >>>> fits the cpu. And when schedutil govnor get cpu util, the thermal pressure
> >>>> also should be considered.
> >>>>
> >>>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> >>>> ---
> >>>>   kernel/sched/cpufreq_schedutil.c | 1 +
> >>>>   kernel/sched/rt.c                | 1 +
> >>>>   2 files changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> >>>> index 3dbf351d12d5..285ad51caf0f 100644
> >>>> --- a/kernel/sched/cpufreq_schedutil.c
> >>>> +++ b/kernel/sched/cpufreq_schedutil.c
> >>>> @@ -159,6 +159,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
> >>>>        struct rq *rq = cpu_rq(sg_cpu->cpu);
> >>>>        unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
> >>>>
> >>>> +     max -= arch_scale_thermal_pressure(sg_cpu->cpu);
> >>>
> >>> max' = arch_scale_cpu_capacity() - arch_scale_thermal_pressure()
> >>>
> >>> For the energy part (A) we use max' in compute_energy() to cap sum_util
> >>> and max_util at max' and to call em_cpu_energy(..., max_util, sum_util,
> >>> max'). This was done to match (B)'s `policy->max` capping.
> >>>
> >>> For the frequency part (B) we have freq_qos_update_request() in:
> >>>
> >>> power_actor_set_power()
> >>>    ...
> >>>    cdev->ops->set_cur_state()
> >>>
> >>>      cpufreq_set_cur_state()
> >>>        freq_qos_update_request()      <-- !
> >>>        arch_update_thermal_pressure()
> >>>
> >>> restricting `policy->max` which then clamps `target_freq` in:
> >>>
> >>>    cpufreq_update_util()
> >>>      ...
> >>>      get_next_freq()
> >>>        cpufreq_driver_resolve_freq()
> >>>          __resolve_freq()
> >>>
> >>
> >> Do you mean that the "max" here will not affect the frequency
> >> conversion, so there is no need to change it?
> >> But is it better to reflect the influence of thermal here?
> >
> > I guess your point is that even though max' has no effect on frequency
> > since QOS caps policy->max anyway, it is still easier to understand the
> > dependency between schedutil and EAS/EM when it comes to the use of
> > thermal pressure.
> >
> > I agree. The way how the "hidden" policy->max capping guarantees that
> > schedutil and EAS/EM are doing the same even when only the latter uses
> > max' is not obvious.
>
> +1 here, IMO we shouldn't rely on hidden stuff. There are two which set
> the thermal pressure, but one is not setting the freq_qos which causes
> the update of the 'policy->max'. So the schedutil will send that high
> frequency but that driver would just ignore and clamp internally. In the
> end we might argue it still works, but is it clean and visible from the
> code? Funny thing might start to happen then the driver, which might be
> the last safety net cannot capture this.
>
> We also should be OK with energy estimation and the CPU capacity vs.
> task utilization comparisons, since the thermal pressure is accounted
> there* (until the thermal is controlled in kernel not in FW, which is
> something where we are heading with scmi-cpufreq mentioned in this
> cover letter [1]).

IMO, If so, we don't want to modify the original code, but also need to
consider the impact of thermal, maybe it is possible to add a new
macro definition
like this:

#define arch_scale_cpu_capacity_except_thermal()
(arch_scale_cpu_capacity() - arch_scale_thermal_pressure())

>
> >
> > I just wanted to mention the historical reason why the code looks like
> > it does today.
> >
> >>> [...]
> >>>
> >>>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> >>>> index a32c46889af8..d9982ebd4821 100644
> >>>> --- a/kernel/sched/rt.c
> >>>> +++ b/kernel/sched/rt.c
> >>>> @@ -466,6 +466,7 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
> >>>>        max_cap = uclamp_eff_value(p, UCLAMP_MAX);
> >>>>
> >>>>        cpu_cap = capacity_orig_of(cpu);
> >>>> +     cpu_cap -= arch_scale_thermal_pressure(cpu);
> >>>>
> >>>>        return cpu_cap >= min(min_cap, max_cap);
> >>>>   }
> >>>
> >>> IMHO, this should follow what we do with rq->cpu_capacity
> >>> (capacity_of(), the remaining capacity for CFS). E.g. we use
> >>> capacity_of() in find_energy_efficient_cpu() and select_idle_capacity()
> >>> to compare capacities. So we would need a function like
> >>> scale_rt_capacity() for RT (minus the rq->avg_rt.util_avg) but then also
> >>> one for DL (minus rq->avg_dl.util_avg and rq->avg_rt.util_avg).
> >>
> >> It's a really good idea. And do you already have the corresponding patch?
> >> If there is, can you tell me the corresponding link?
> >
> > No, I don't have any code for this. Should be trivial though. But the
> > issue is that the update would probably have to be decoupled from CFS
> > load_balance (update_group_capacity()) and the use cases in RT/DL are
> > only valid for asymmetric CPU capacity systems.
>
> Having in mind those I would vote for fixing it incrementally.
> Thus, IMHO this patch is good for taking it. Later we might think how
> to better estimate the real CPU capacity visible from RT and DL classes.
> In this shape it is good for many systems which only use RT,
> but not DL class. Those systems w/ RT and w/o DL might suffer on some
> asymmetric CPU platforms where medium cores have capacity e.g. 850 and
> thermal pressure reduced the big cores capacity by 250 making them 774.
>

Your mean is that before there is better way to handle RT capacity, we
can take this patch temporarily?
If so, I can update the patch which will just fix the rt.c.

In fact, in the mobile phone usage scenario where the cpu contains 3
clusters (small/middle/big),
the capacity of the big core's capacity will be smaller than that of
the middle core due to the thermal effect.
At this time, we do not want the big core CPU to be used as an RT
task's alternative cpu.

> Regards,
> Lukasz
>
> [1]
> https://lore.kernel.org/linux-pm/20211007080729.8262-1-lukasz.luba@arm.com/


BR
xuewen.yan
