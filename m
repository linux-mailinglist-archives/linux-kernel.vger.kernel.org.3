Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F1057B7D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbiGTNse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGTNs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:48:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F6B5F116
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:48:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so2242178pjf.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=18rSbs7d/JpSNyiTxLgkJ7GYY5R87zF+IcF/GENE0J4=;
        b=67O1Fi8UrJgV3Nq/UWYzs2JKLXRcqaq4CPG1/gwUHOcQo7tklMr5cbEbFyy2MP7T0P
         Ue2wdG5Ln6afJpt5avWJli8H6wpJyoJpgtiM1ZTIlf8dWqjJ+PP7XDON19RRT7pp+4Zu
         XpSRMEz2mrmwNGBmK1WdZELOsRl0Y5ettt/4BhGy93D/3TMRjfJCcJLkTd/COwu0HsuJ
         N54t/ICmxVqmfxgP7R8U6ZwmLQJNV0opf227SYyCfLg4m6Mh23jljiyMRKk4hq9pXmKC
         wA+9+aAXK3hIVKQzMCqA61mz5LtNu5E8Dh2XIJfCh2HHjIzVFJGriF3Fosr1dSMTQT/e
         PzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=18rSbs7d/JpSNyiTxLgkJ7GYY5R87zF+IcF/GENE0J4=;
        b=IkcPi0i396cOxy82e973NqFscdaMwkUdZ7aoVaQLnaPmcxam+S6Mvl0X86f0TJM/OD
         VFsUpKAJ6OFz0TZ09MGiFvrZiyr72dn/VtpxtZ4ZjrHtT56iqnT1iE3OJt/a4a11/IvC
         NNshz1A31uuDXIsAd6uomT7F+xkuQnfWK2Rctjd/EsqcdZidqi1w4PQ1qSK9nH0rnXJL
         SQEpnQV/gYE4Pfj+jGyDyDKt0RW6NdIQD+IQjosvCSWLX68hANTq/vNHHPijuiAmvAJz
         9dc6jQT0HUvn02Ra/fBN0EJN2zAWBJx7WtXapcKbJma28q7XSjCndsuqGGtCK3PhOo2Q
         vuXA==
X-Gm-Message-State: AJIora/DLpKB9i1ymsv68HQAsMDsfywK0QRAEiQIyKZ8hZdrDJOzejQj
        5OPogeDutkh/0nenpESbWqaXJA==
X-Google-Smtp-Source: AGRyM1udeA1DCGlNyKn43n1gVBBDhLdKURr17x3EKB4UBSjxIi/rXs8pVZy0vqW9CafAzyk4oF91FQ==
X-Received: by 2002:a17:902:ef48:b0:16a:1d4b:22ca with SMTP id e8-20020a170902ef4800b0016a1d4b22camr38566565plx.6.1658324906639;
        Wed, 20 Jul 2022 06:48:26 -0700 (PDT)
Received: from [10.4.100.137] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id t68-20020a625f47000000b0052aaf7fdf2esm13518406pfb.137.2022.07.20.06.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 06:48:26 -0700 (PDT)
Message-ID: <c17098cb-25ec-bebf-7181-2ca405a4ec7d@bytedance.com>
Date:   Wed, 20 Jul 2022 21:48:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [External] Re: [PATCH v2 08/10] sched/fair: fix load tracking for
 new forked !fair task
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-9-zhouchengming@bytedance.com>
 <CAKfTPtB7BNBG_VTxKfHrb40MzMcnZHsVau7mp8EJev7M=9JHzQ@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKfTPtB7BNBG_VTxKfHrb40MzMcnZHsVau7mp8EJev7M=9JHzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/19 20:35, Vincent Guittot wrote:
> On Wed, 13 Jul 2022 at 06:05, Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> New forked !fair task will set its sched_avg last_update_time to
>> the pelt_clock of cfs_rq, after a while in switched_to_fair():
>>
>> switched_to_fair
>>   attach_task_cfs_rq
>>     attach_entity_cfs_rq
>>       update_load_avg
>>         __update_load_avg_se(now, cfs_rq, se)
>>
>> the delta (now - sa->last_update_time) will contribute/decay sched_avg
>> depends on the task running/runnable status at that time.
>>
>> This patch don't set sched_avg last_update_time of new forked !fair
>> task, leave it to 0. So later in update_load_avg(), we don't need to
>> contribute/decay the wrong delta (now - sa->last_update_time).
> 
> As mentioned in patch 7, I think it's wrong to not decay the init
> value of !fair task because they become obsolete if not used quickly
> (so we are decaying them)
> 
> It would be better to not set them at all in the case of !fair task

So just leave !fair task sched_avg to 0 and last_update_time == 0, right?


Thanks.

> 
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  kernel/sched/fair.c | 18 ++----------------
>>  1 file changed, 2 insertions(+), 16 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 51fc20c161a3..50f65a2ede32 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -849,22 +849,8 @@ void post_init_entity_util_avg(struct task_struct *p)
>>
>>         sa->runnable_avg = sa->util_avg;
>>
>> -       if (p->sched_class != &fair_sched_class) {
>> -               /*
>> -                * For !fair tasks do:
>> -                *
>> -               update_cfs_rq_load_avg(now, cfs_rq);
>> -               attach_entity_load_avg(cfs_rq, se);
>> -               switched_from_fair(rq, p);
>> -                *
>> -                * such that the next switched_to_fair() has the
>> -                * expected state.
>> -                */
>> -               se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
>> -               return;
>> -       }
>> -
>> -       attach_entity_cfs_rq(se);
>> +       if (p->sched_class == &fair_sched_class)
>> +               attach_entity_cfs_rq(se);
>>  }
>>
>>  #else /* !CONFIG_SMP */
>> --
>> 2.36.1
>>
