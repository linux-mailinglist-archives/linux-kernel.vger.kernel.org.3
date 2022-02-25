Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635BC4C45AA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiBYNPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiBYNPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:15:50 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649C41F983C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:15:17 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id r20so7405770ljj.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QlHbAj9RrieryzK6X4dfpMcrboYIb/l+Y5vjOM0ABOE=;
        b=yaF6E6EGqUddMLTCj4JN8VxQJsH3Z6y6vCtUvxANVE224r5SedlOVPKrPRVw92s01b
         GSu79T/ENkP5XLcN8n7syXBdFIaSJUbZoIxf6Z9xIT/pZjo/72bIsQoPEzr30yIMo7/U
         EtCK1DZzstm6wmRdhk1ZSfV/q0p/2ioosWyolzI80P1WRlRKffgbLduhJ3QnE422k7w6
         VRckoWmWdkaCOghfs0bsKSq8HcEMyW44+AOwXTEcJH/mL9CcaDm81vOONOP6Z65H/6os
         vWHrsVRYj3XxJkmDmuK134tXL/i7Vf6koOQxSUccOWPIpvL1s0gSYuYw3XrJqc++Qw/o
         8jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QlHbAj9RrieryzK6X4dfpMcrboYIb/l+Y5vjOM0ABOE=;
        b=K29peIgnXFYCSW6OttSZY+mJo/n/f2typ23C4Z8Kr+Nu3c4eJlQKnRfDXZsKib0VQp
         SGCdF6/DsBKwkrHxWXuJVOEix4OElpo9LL7WSgfMX8ltGiu14iyezETzEgvrZzFjBQbD
         wOn+4b0YypAIa2WGqvbCmfFbhCSnbqHper9g/y1I2WtgFO+WhKsD6YjJxjYgZlLlU5ro
         UDIRYa6ZK4EyHYoYTnELshQOobe6USi90f1CenrAnb1wEsRyHZZFMLYPvf1+x0M4uOXd
         nYaHZY4MQozYjLj7YoQQf9t+PC7A/Eg7xfEoOPHT6Vmb0GnuekGXTGdu6uMiqE9y8wPp
         XZyw==
X-Gm-Message-State: AOAM531RAzoLwAV8ufIU8IBYYElQ0ct0he84V2ynUydMqcdHp5v+Mgjn
        oTByhZ2TA+6Hm3W7J4ZVqiGITN38keSrxK3QZGG0Zw==
X-Google-Smtp-Source: ABdhPJyi3R6se6gejtpuW+znM8v9nyMMU23FwuRxr0ssOTn95swJdzz/XXmSCdFy3Vcn7z1BvMPysKOKu9PpMeAPLbM=
X-Received: by 2002:a05:651c:32d:b0:246:1293:854e with SMTP id
 b13-20020a05651c032d00b002461293854emr5391704ljp.365.1645794915674; Fri, 25
 Feb 2022 05:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
 <YheiT2pGNDggdFSu@hirez.programming.kicks-ass.net> <9fe00f72-4e2e-38ff-d64a-4ae41e683316@bytedance.com>
 <CAKfTPtD7U7=C8MTLLMtUrGxJFCjpxtU7a_S=HaBhCsZ6SBbVFA@mail.gmail.com> <d4557587-b52c-049d-a0c8-e48aaa8a1c1e@bytedance.com>
In-Reply-To: <d4557587-b52c-049d-a0c8-e48aaa8a1c1e@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 25 Feb 2022 14:15:04 +0100
Message-ID: <CAKfTPtB9Dhg+4sQnFBu3qXiV3vwnfAjf-R2_4qvKXGAGS1pW-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] introduce sched-idle balancing
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 at 11:46, Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> On 2/25/22 4:29 PM, Vincent Guittot Wrote:
> > On Fri, 25 Feb 2022 at 07:46, Abel Wu <wuyun.abel@bytedance.com> wrote:
> >>
> >> Hi Peter,
> >>
> >> On 2/24/22 11:20 PM, Peter Zijlstra Wrote:
> >>> On Thu, Feb 17, 2022 at 11:43:56PM +0800, Abel Wu wrote:
> >>>> Current load balancing is mainly based on cpu capacity
> >>>> and task util, which makes sense in the POV of overall
> >>>> throughput. While there still might be some improvement
> >>>> can be done by reducing number of overloaded cfs rqs if
> >>>> sched-idle or idle rq exists.
> >>>
> >>> I'm much confused, there is an explicit new-idle balancer and a periodic
> >>> idle balancer already there.
> >>
> >> The two balancers are triggered on the rqs that have no tasks on them,
> >> and load_balance() seems don't show a preference for non-idle tasks so
> >
> > The load balance will happen at the idle pace if a sched_idle task is
> > running on the cpu so you will have an ILB on each cpu that run a
> > sched-idle task
>
> I'm afraid I don't quite follow you, since sched-idle balancer doesn't
> touch the ILB part, can you elaborate on this? Thanks.

I was referring to your sentence " The two balancers are triggered on
the rqs that have no tasks on them". When there is only sched-idle
tasks on a rq, the load_balance behave like the Idle Load Balance when
there is no task i.e. as often

>
> >
> >> there might be possibility that only idle tasks are pulled during load
> >> balance while overloaded rqs (rq->cfs.h_nr_running > 1) exist. As a
> >
> > There is a LB_MIN feature (disable by default) that filters task with
> > very low load ( < 16) which includes sched-idle task which has a max
> > load of 3

but we could easily change this like if !sched_idle_cpus then LB can
migrate only cfs tasks otherwise can migrate sched_idle task as well.
Instead of creating another side channel

>
> This feature might not that friendly to the situation that only
> sched-idle tasks are running in the system. And this situation
> can last more than half a day in our co-location systems in which
> the training/batch tasks are placed under idle groups or directly
> assigned to SCHED_IDLE.
>
> >
> >> result the normal tasks, mostly latency-critical ones in our case, on
> >> that overloaded rq still suffer waiting for each other. I observed this
> >> through perf sched.
> >>
> >> IOW the main difference from the POV of load_balance() between the
> >> latency-critical tasks and the idle ones is load.
> >>
> >> The sched-idle balancer is triggered on the sched-idle rqs periodically
> >> and the newly-idle ones. It does a 'fast' pull of non-idle tasks from
> >> the overloaded rqs to the sched-idle/idle ones to let the non-idle tasks
> >> make full use of cpu resources.
> >>
> >> The sched-idle balancer only focuses on non-idle tasks' performance, so
> >> it can introduce overall load imbalance, and that's why I put it before
> >> load_balance().
> >
> > According to the very low weight of a sched-idle task, I don't expect
> > much imbalance because of sched-idle tasks. But this also depends of
> > the number of sched-idle task.
> >
> >
> >>
> >> Best Regards,
> >>          Abel
