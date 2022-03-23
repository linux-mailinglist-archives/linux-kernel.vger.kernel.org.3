Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D156A4E4A79
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 02:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiCWB3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 21:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241124AbiCWB3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:29:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6A7286C5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:28:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so340991pjm.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WV3eF61Zwnp61XzMLW09JKvh3rwrncLt1x2lt/Qi/H0=;
        b=tuPDH7+hT1eh/++WptIX4DbzHnTISFrX/kxoy7IcSLM0jQhtTQCcEG303WkiaULr5t
         4KC7VUkDRUjr5KB0KCO+5KwDq+LoDn6Ov5qEIjUBVHr0/Ph6IrCwfYSAei8055zKOFRI
         rBjxG74o5GguXUb0l7zPgBeoXV/p6A1DOqJX8yIaniUFnGc0DWxJzhRG0QuLkJnONbor
         GBMYd85VHVJjBXD+hTP6BVBh9O4O/jLFWy0lvmAycb7lwVsYtixcSfM7VTVnFRoOUexP
         6H342G0bH8vFB9iXEOIjfcxsqt/W1YCrY1Zbuq3QmOoCRB72GxV44akEUK9wpg5Ku997
         2z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WV3eF61Zwnp61XzMLW09JKvh3rwrncLt1x2lt/Qi/H0=;
        b=meMkDNlWz8G/AFI9Zx+SQtzNTPeYDXZZXtj0Yco5Y9NeqHtXf8xvUGP4j3PHWwgA4y
         Yk30pe+5OsP8I4b8J8vWSNOxPSSUGM4Q35YFyjx1lQN0eQWHGrZ28s1LO/C+iVa71YdN
         Sh+gvQUbIIAezMVOXb+DUxv0qp9jazC0Rl1ZP+/YcGSAePKibWWzUUirplw/dKy8S+ka
         LyEftWcy4/nu6C8ZSwW9ETDHjtJ6ISNWsjPY/DUWm2Z4ER6BuntQvhp1kz4et0/p612i
         TfMNibW8g503ziSeT88A0ahJ9AXXWsyEfmKXXOTNIAN9juz4IelktYOltUXwUDl/FfBV
         wZbA==
X-Gm-Message-State: AOAM531JiiPj6HOXzPzMyTq29tXut1bQCF4ojlXSkWrkad9JVCMgNix9
        3oMOSOMOHUKvLAzXcsWGSRXuEQ==
X-Google-Smtp-Source: ABdhPJydpCbrksD12KbKABOioDMiTAUiuGWNa5w3dwLs/rjk1S3g0ODcglHnDEVIQKUiS2FdM9ZAKg==
X-Received: by 2002:a17:90a:541:b0:1c6:68cc:8b68 with SMTP id h1-20020a17090a054100b001c668cc8b68mr8354001pjf.172.1647998891500;
        Tue, 22 Mar 2022 18:28:11 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e62:3990:2892:f403:3c99:a07? ([2409:8a28:e62:3990:2892:f403:3c99:a07])
        by smtp.gmail.com with ESMTPSA id h11-20020a056a00170b00b004f7a83058d5sm26479285pfc.16.2022.03.22.18.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 18:28:11 -0700 (PDT)
Message-ID: <e226cd02-005a-92c7-20bd-cf4fb9fb0071@bytedance.com>
Date:   Wed, 23 Mar 2022 09:27:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [Phishing Risk] [External] Re: [PATCH v2 2/6] perf/core:
 Introduce percpu perf_cgroup
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
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-3-zhouchengming@bytedance.com>
 <CAM9d7cjwuQmuxwMG7HP3QDw0ckKcUqfT5A8JGg2JkcrZuQhWUg@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAM9d7cjwuQmuxwMG7HP3QDw0ckKcUqfT5A8JGg2JkcrZuQhWUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On 2022/3/23 6:18 上午, Namhyung Kim wrote:
> On Tue, Mar 22, 2022 at 5:10 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> Although we don't have incosistency problem any more, we can
>> have other problem like:
>>
>> CPU1                                    CPU2
>> (in context_switch)                     (attach running task)
>>                                         prev->cgroups = cgrp2
>> perf_cgroup_sched_switch(prev, next)
>>         cgrp2 == cgrp2 is True
>>
>> If perf_cgroup of prev task changes from cgrp1 to cgrp2,
>> perf_cgroup_sched_switch() will skip perf_cgroup_switch(),
>> so the CPU would still schedule the cgrp1 events, but we should
>> schedule the cgrp2 events.
> 
> Ah ok, now I see the problem in changing prev->cgroup too.
> 
>>
>> The reason of this problem is that we shouldn't use the changeable
>> prev->cgroups to decide whether skip perf_cgroup_switch().
>>
>> This patch introduces a percpu perf_cgroup to cache the perf_cgroup
>> that scheduled in cpuctxes, which later used to compare with the
>> perf_cgroup of next task to decide whether skip perf_cgroup_switch().
>>
>> Since the perf_cgroup_switch() can be called after the context switch,
>> the cgroup events might be scheduled already. So we put the comparison
>> of perf_cgroups in perf_cgroup_switch(), and delete the unused function
>> perf_cgroup_sched_switch().
>>
>> We must clear the percpu perf_cgroup cache when the last cgroup event
>> disabled.
>>
>> Fixes: a8d757ef076f ("perf events: Fix slow and broken cgroup context switch code")
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  kernel/events/core.c | 63 ++++++++++++++++----------------------------
>>  1 file changed, 22 insertions(+), 41 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 8b5cf2aedfe6..848a3bfa9513 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -826,6 +826,7 @@ perf_cgroup_set_timestamp(struct task_struct *task,
>>         }
>>  }
>>
>> +static DEFINE_PER_CPU(struct perf_cgroup *, cpu_perf_cgroup);
>>  static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
>>
>>  /*
>> @@ -833,6 +834,7 @@ static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
>>   */
>>  static void perf_cgroup_switch(struct task_struct *task)
>>  {
>> +       struct perf_cgroup *cgrp;
>>         struct perf_cpu_context *cpuctx, *tmp;
>>         struct list_head *list;
>>         unsigned long flags;
>> @@ -843,11 +845,21 @@ static void perf_cgroup_switch(struct task_struct *task)
>>          */
>>         local_irq_save(flags);
>>
>> +       cgrp = perf_cgroup_from_task(task, NULL);
>> +       if (cgrp == __this_cpu_read(cpu_perf_cgroup))
>> +               goto out;
>> +
>> +       __this_cpu_write(cpu_perf_cgroup, cgrp);
>> +
>>         list = this_cpu_ptr(&cgrp_cpuctx_list);
>>         list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
>>                 WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
>>
>>                 perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>> +
>> +               if (cpuctx->cgrp == cgrp)
> 
> Missing perf_ctx_unlock().

Thank you, will fix next version.

> 
> Thanks,
> Namhyung
> 
>> +                       continue;
>> +
>>                 perf_pmu_disable(cpuctx->ctx.pmu);
>>
>>                 cpu_ctx_sched_out(cpuctx, EVENT_ALL);
>> @@ -855,14 +867,11 @@ static void perf_cgroup_switch(struct task_struct *task)
>>                  * must not be done before ctxswout due
>>                  * to event_filter_match() in event_sched_out()
>>                  */
>> -               cpuctx->cgrp = perf_cgroup_from_task(task,
>> -                                                    &cpuctx->ctx);
>> +               cpuctx->cgrp = cgrp;
>>                 /*
>>                  * set cgrp before ctxsw in to allow
>>                  * event_filter_match() to not have to pass
>>                  * task around
>> -                * we pass the cpuctx->ctx to perf_cgroup_from_task()
>> -                * because cgroup events are only per-cpu
>>                  */
>>                 cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
>>
>> @@ -870,35 +879,10 @@ static void perf_cgroup_switch(struct task_struct *task)
>>                 perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>>         }
>>
>> +out:
>>         local_irq_restore(flags);
>>  }
