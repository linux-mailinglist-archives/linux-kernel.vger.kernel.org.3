Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E625C4D4664
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbiCJMCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiCJMCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:02:34 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8A613FADE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 04:01:33 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p17so4654746plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 04:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V/aRdxYPIJVnYxbdmjgl/s1XslzjxYjuKKUK+htku64=;
        b=uu92/9AXOEDS62ojNC1Z+JABP02/V+prBGJibHRtUMGqcUz4ZxGuWteQOQm3boGUu0
         700xkBLd0W+SqYU/eCAm804OYPgKannSkwpE8CCWFKuJDU/bNMo6WOBSiPZu/7C1tFCe
         3dpWFwyqfBeym8XBQ6dyGCI7KS6MiQNeLiZa0uKlOcRc3vhPfoJTrL2ygNxd0zmz65DY
         SwCBe13onloRR3elpubRazLTOS1oxtD6c3yoNzwwU8Y3xib4duqHd5uPbE/hNLcASZOH
         7z/g1PNr0sBfNIAUH1Fs53zHXpqFfL+e4+V5+10ZHbTcowJnjBpUwyF4y4O4Bk28Bpdw
         lJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V/aRdxYPIJVnYxbdmjgl/s1XslzjxYjuKKUK+htku64=;
        b=toz13W+yur5SUv+sk7XqIKsJSXBEZT5tYAw40IR9aPlRLU3F6XhlDdeJkJcCLCSC9h
         AX8gusWbXKLIenCI4bo87xg9ZmIw5nB4giuHMhpxBO2zRwNgVxGkPm6gfEGZ/WfNbaNJ
         CGwDAU7I6qNr9LgGBcfNZdfUqgBRjl/ZxtpSS6mdAF6W99ALuQktJjWg8vjGo3dfn6F7
         xXb/6sPquY5TCuu19k7uGn+Om6gKnRv3ObN1KzWS0Qn3kB6O+tKreQlYowJVCLoeZxj8
         e24aJOrG9vWnMrUtsL4yTNhKsozczrSVZXajwJc5mLvoVlwEJVe6dl9j81bo+3j1ylh5
         SJ1g==
X-Gm-Message-State: AOAM533xLBGe8z21GDaC3MGMottIJmPmffQkArcLC1anlc9hRwjfeaYj
        hvDz0Ra0vLnEdD+xAKEEdxktSA==
X-Google-Smtp-Source: ABdhPJxeH3hPBk9w65Cn+mJGQpVKFR7n8qb3mZnBr/E4qDCERU+7Q+69LzhowUc/pvVYsSpZnXP9tw==
X-Received: by 2002:a17:902:bc83:b0:149:b26a:b9c8 with SMTP id bb3-20020a170902bc8300b00149b26ab9c8mr4533957plb.143.1646913692691;
        Thu, 10 Mar 2022 04:01:32 -0800 (PST)
Received: from [10.4.175.235] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id g20-20020a056a000b9400b004f705514955sm6702812pfj.107.2022.03.10.04.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 04:01:32 -0800 (PST)
Message-ID: <e561e36c-cc73-2078-4baa-cb9ab6b6eeac@bytedance.com>
Date:   Thu, 10 Mar 2022 20:01:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [Phishing Risk] [External] Re: [RFC PATCH] perf/core: fix cpuctx
 cgrp warning
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        songmuchun@bytedance.com
References: <20220308135948.55336-1-zhouchengming@bytedance.com>
 <CAM9d7chsbpmVhhtzBgqD29Agb6xTMpxfwvqUdo6RKx2K1WN-DQ@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAM9d7chsbpmVhhtzBgqD29Agb6xTMpxfwvqUdo6RKx2K1WN-DQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2022/3/10 5:25 下午, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Mar 8, 2022 at 6:00 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> There is a race problem that can trigger WARN_ON_ONCE(cpuctx->cgrp)
>> in perf_cgroup_switch().
>>
>> CPU1                                    CPU2
>> (in context_switch)                     (attach running task)
>> perf_cgroup_sched_out(task, next)
>>         if (cgrp1 != cgrp2) True
>>                                         task->cgroups = xxx
>>                                         perf_cgroup_attach()
>> perf_cgroup_sched_in(prev, task)
>>         if (cgrp1 != cgrp2) False
> 
> But perf_cgroup_switch will be synchronized as the context switch
> disables the interrupt.  And right, it still can see the task->cgroups
> is changing in the middle.
> 
>>
>> The commit a8d757ef076f ("perf events: Fix slow and broken cgroup
>> context switch code") would save cpuctx switch in/out when the
>> perf_cgroup of "prev" and "next" are the same.
>>
>> But perf_cgroup of task can change in concurrent with context_switch.
>> If cgrp1 == cgrp2 in sched_out(), cpuctx won't do switch out, then
>> task perf_cgroup changed cause cgrp1 != cgrp2 in sched_in(), cpuctx
>> will do switch in, and trigger WARN_ON_ONCE(cpuctx->cgrp).
>>
>> The perf_cgroup of "prev" and "next" can be changed at any time, so we
>> first have to combine perf_cgroup_sched_in() into perf_cgroup_sched_out(),
>> so we can get a consistent value of condition (cgrp1 == cgrp2).
>>
>> And we introduce a percpu "cpu_perf_cgroups" to track the current used
>> perf_cgroup, instead of using the unstable perf_cgroup of "prev", which
>> maybe not the cpuctx->cgrp we used to schedule cgroup events on cpu.
> 
> Is this really needed?  I think the warning comes because the two
> cgroups were the same when in sched-out, but they became
> different when in sched-in.  So just combining sched-in/out should
> be ok, isn't it?

If we get perf_cgroup from prev->cgroups that can be changed in the
context_switch(), make the condition (cgrp1 == cgrp2) is true, then
we won't do sched_out/in. So the events of prev's previous cgrp will
still be on the CPU.

Even that CPU would receive IPI from perf_cgroup_attach() after
context_switch(), remote_function() will do nothing because prev task
is not current running anymore.

> 
>>
>> Fixes: a8d757ef076f ("perf events: Fix slow and broken cgroup context
>> switch code")
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  kernel/events/core.c | 95 +++++++++++---------------------------------
>>  1 file changed, 23 insertions(+), 72 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 6859229497b1..f3bc2841141f 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -826,6 +826,7 @@ perf_cgroup_set_timestamp(struct task_struct *task,
>>         }
>>  }
>>
>> +static DEFINE_PER_CPU(struct perf_cgroup *, cpu_perf_cgroups);
>>  static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
>>
>>  #define PERF_CGROUP_SWOUT      0x1 /* cgroup switch out every event */
>> @@ -837,8 +838,9 @@ static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
>>   * mode SWOUT : schedule out everything
>>   * mode SWIN : schedule in based on cgroup for next
> 
> You can remove this comment now.

Ok, will do.

> 
>>   */
>> -static void perf_cgroup_switch(struct task_struct *task, int mode)
>> +static void perf_cgroup_switch(struct task_struct *task)
>>  {
>> +       struct perf_cgroup *cgrp;
>>         struct perf_cpu_context *cpuctx, *tmp;
>>         struct list_head *list;
>>         unsigned long flags;
>> @@ -849,6 +851,9 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
>>          */
>>         local_irq_save(flags);
>>
>> +       cgrp = perf_cgroup_from_task(task, NULL);
>> +       __this_cpu_write(cpu_perf_cgroups, cgrp);
>> +
>>         list = this_cpu_ptr(&cgrp_cpuctx_list);
>>         list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
>>                 WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
>> @@ -856,28 +861,15 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
>>                 perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>>                 perf_pmu_disable(cpuctx->ctx.pmu);
>>
>> -               if (mode & PERF_CGROUP_SWOUT) {
>> -                       cpu_ctx_sched_out(cpuctx, EVENT_ALL);
>> -                       /*
>> -                        * must not be done before ctxswout due
>> -                        * to event_filter_match() in event_sched_out()
> 
> Unrelated, but I don't see the event_filter_match() in
> event_sched_out() anymore.  Does it sched-out all
> non-cgroup cpu events here?

Yes, I review the code and don't find event_filter_match(),
so cpu_ctx_sched_out() will sched-out all cpu events.

And I find event_filter_match() won't work here too,
because perf_cgroup_match() return matched for any
non-cgroup event. Maybe we can add another function
like perf_cgroup_match_sched_out() to use when sched-out.

> 
>> -                        */
>> -                       cpuctx->cgrp = NULL;
>> -               }
>> +               cpu_ctx_sched_out(cpuctx, EVENT_ALL);
>> +               /*
>> +                * must not be done before ctxswout due
>> +                * to event_filter_match() in event_sched_out()
>> +                */
>> +               cpuctx->cgrp = cgrp;
> 
> Maybe we can check cpuctx->cgrp is the same as task's
> cgroup before accessing the pmu.  As in the commit message
> it can call perf_cgroup_switch() after the context switch so
> the cgroup events might be scheduled already.

Good point, will do.

Thanks.

> 
> Thanks,
> Namhyung
> 
> 
>> +
>> +               cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
>>
>> -               if (mode & PERF_CGROUP_SWIN) {
>> -                       WARN_ON_ONCE(cpuctx->cgrp);
>> -                       /*
>> -                        * set cgrp before ctxsw in to allow
>> -                        * event_filter_match() to not have to pass
>> -                        * task around
>> -                        * we pass the cpuctx->ctx to perf_cgroup_from_task()
>> -                        * because cgorup events are only per-cpu
>> -                        */
>> -                       cpuctx->cgrp = perf_cgroup_from_task(task,
>> -                                                            &cpuctx->ctx);
>> -                       cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
>> -               }
>>                 perf_pmu_enable(cpuctx->ctx.pmu);
>>                 perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>>         }
