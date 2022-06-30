Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DB5560ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 03:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiF3Bwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 21:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiF3Bwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 21:52:38 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5514B3A71D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 18:52:37 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 68so17022450pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 18:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZqYEdI5TBvbqPVd3WWg/Cu1MxzQ4hi+YMe+pkhtaNfI=;
        b=m8kFgkRDNKp7FgzIfFxjnnheCJIV4hlUldIPu7O4CkGqkPE5b6btAAwGS/Noa33+pb
         gjJW14nFGGnlV+kCqlJ3Sf+rpyHoGH7bL0hDpGWTo7G3Je9jhaFqGM6VGyZ2XgtjtxTI
         39Qy0hxGcLMYDEvvtJ14Oob3IXtoAOFNKuOKLubvLYScdI6BGfVdoU31dIw4+QS+/Pel
         Y8pbWaVawDJz12WSJDR6EbFMRoZlkR6wU5k/3griaGvAKFkOGoXDNDfkftHhLEaq6ZSz
         +Skrj3YwHSITp0GWqn/qoSL5PqVexa56LNTlG3BSsW6TtMre1DgOxV9N8/4xKnplgOs/
         kbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZqYEdI5TBvbqPVd3WWg/Cu1MxzQ4hi+YMe+pkhtaNfI=;
        b=jzO5LRfYa6oKWhFsIbU5Nl/6x6o2PYQi+Osl6XXsruwFREs8oxh6HN75IkJQxPbvIR
         gqBYAkxNM1UzizZLpDfsAPlIsoICZS8gU8y9JinxKWACFmXh7gmc82TW9YEEjXh3NslH
         vqQ0ajYr49TNqwZ/i++g4pzgz/qx2d1eXWkvDck35YdfheYLjEfVheBDmk7XU3e/0XiR
         cjl0l1nJM2rcDEG9+O2lK0twCS8Q9+9FrGNiI7osyrr8vHZjE8AcFilNmpAzEWYIhdz4
         tbj44m1g3NVm7m8MYE5NsxF5iODy+ySskX38LhPxEz31CoopnaBSSsjRdFSGC/sHgdJU
         xrDg==
X-Gm-Message-State: AJIora+HvgVvjMCoHxHOVT+2PwOwXAGhpkZyohVwr/RGT0dtemCMZsoG
        aAxxOxa7SaEsKx7PxUI2EIF5kfhr7rsyVa/K
X-Google-Smtp-Source: AGRyM1tEWw6ok3ns7n2TOqFd/30e11UIMWLejgzsSfgQGhaGpvVZexDmEiyoPHSSr6VazTF9YZOZag==
X-Received: by 2002:a63:a4f:0:b0:401:a0e0:1668 with SMTP id z15-20020a630a4f000000b00401a0e01668mr5369331pgk.21.1656553956707;
        Wed, 29 Jun 2022 18:52:36 -0700 (PDT)
Received: from [10.255.253.104] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id s22-20020a17090aba1600b001ec71be4145sm2921153pjr.2.2022.06.29.18.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 18:52:36 -0700 (PDT)
Message-ID: <079e9660-67d1-0edc-d502-01acbc5441a8@bytedance.com>
Date:   Thu, 30 Jun 2022 09:52:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [External] Re: [PATCH] sched: remove redundant
 cpu_cgrp_subsys->fork()
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        rdunlap@infradead.org, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20220622094831.22948-1-zhouchengming@bytedance.com>
 <CAKfTPtAddY0L9c9V8-ZkmGsRQs_LDK4oB-bJZTFSKxx++2wD1A@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKfTPtAddY0L9c9V8-ZkmGsRQs_LDK4oB-bJZTFSKxx++2wD1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/29 22:05, Vincent Guittot wrote:
> On Wed, 22 Jun 2022 at 11:48, Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> We use cpu_cgrp_subsys->fork() to set task group for the new fair task
>> in cgroup_post_fork().
>>
>> Since commit b1e8206582f9 ("sched: Fix yet more sched_fork() races")
>> has already set task group for the new fair task in sched_cgroup_fork(),
>> so cpu_cgrp_subsys->fork() can be removed.
>>
>>   cgroup_can_fork()     --> pin parent's sched_task_group
>>   sched_cgroup_fork()
>>     __set_task_cpu      --> set task group
>>   cgroup_post_fork()
>>     ss->fork() := cpu_cgroup_fork()     --> set again
>>
>> After this change, task_change_group_fair() only need to care about
>> task cgroup migration, make the code much simplier.
>>
>> This patch move the task se depth setting to set_task_rq(), which
>> is called when task moves across CPUs/groups, is a better place than
>> attach_entity_cfs_rq(). The latter is also used when change task's
>> sched_class, in which case the group/depth doesn't change actually.
>>
> 
> The commit message needs some minor fixes but apart from this
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Ok, I will try to improve and send v2. Thanks for your review.


> 
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  kernel/sched/core.c  | 27 ++++-----------------------
>>  kernel/sched/fair.c  | 31 +------------------------------
>>  kernel/sched/sched.h |  6 ++----
>>  3 files changed, 7 insertions(+), 57 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index c16f8cc5de08..f44bc5b889ab 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -481,8 +481,7 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
>>   *                             p->se.load, p->rt_priority,
>>   *                             p->dl.dl_{runtime, deadline, period, flags, bw, density}
>>   *  - sched_setnuma():         p->numa_preferred_nid
>> - *  - sched_move_task()/
>> - *    cpu_cgroup_fork():       p->sched_task_group
>> + *  - sched_move_task():       p->sched_task_group
>>   *  - uclamp_update_active()   p->uclamp*
>>   *
>>   * p->state <- TASK_*:
>> @@ -10098,7 +10097,7 @@ void sched_release_group(struct task_group *tg)
>>         spin_unlock_irqrestore(&task_group_lock, flags);
>>  }
>>
>> -static void sched_change_group(struct task_struct *tsk, int type)
>> +static void sched_change_group(struct task_struct *tsk)
>>  {
>>         struct task_group *tg;
>>
>> @@ -10114,7 +10113,7 @@ static void sched_change_group(struct task_struct *tsk, int type)
>>
>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>>         if (tsk->sched_class->task_change_group)
>> -               tsk->sched_class->task_change_group(tsk, type);
>> +               tsk->sched_class->task_change_group(tsk);
>>         else
>>  #endif
>>                 set_task_rq(tsk, task_cpu(tsk));
>> @@ -10145,7 +10144,7 @@ void sched_move_task(struct task_struct *tsk)
>>         if (running)
>>                 put_prev_task(rq, tsk);
>>
>> -       sched_change_group(tsk, TASK_MOVE_GROUP);
>> +       sched_change_group(tsk);
>>
>>         if (queued)
>>                 enqueue_task(rq, tsk, queue_flags);
>> @@ -10223,23 +10222,6 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
>>         sched_unregister_group(tg);
>>  }
>>
>> -/*
>> - * This is called before wake_up_new_task(), therefore we really only
>> - * have to set its group bits, all the other stuff does not apply.
>> - */
>> -static void cpu_cgroup_fork(struct task_struct *task)
>> -{
>> -       struct rq_flags rf;
>> -       struct rq *rq;
>> -
>> -       rq = task_rq_lock(task, &rf);
>> -
>> -       update_rq_clock(rq);
>> -       sched_change_group(task, TASK_SET_GROUP);
>> -
>> -       task_rq_unlock(rq, task, &rf);
>> -}
>> -
>>  static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
>>  {
>>         struct task_struct *task;
>> @@ -11136,7 +11118,6 @@ struct cgroup_subsys cpu_cgrp_subsys = {
>>         .css_released   = cpu_cgroup_css_released,
>>         .css_free       = cpu_cgroup_css_free,
>>         .css_extra_stat_show = cpu_extra_stat_show,
>> -       .fork           = cpu_cgroup_fork,
>>         .can_attach     = cpu_cgroup_can_attach,
>>         .attach         = cpu_cgroup_attach,
>>         .legacy_cftypes = cpu_legacy_files,
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 8bed75757e65..fdb9125fe34e 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11325,14 +11325,6 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
>>  {
>>         struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>
>> -#ifdef CONFIG_FAIR_GROUP_SCHED
>> -       /*
>> -        * Since the real-depth could have been changed (only FAIR
>> -        * class maintain depth value), reset depth properly.
>> -        */
>> -       se->depth = se->parent ? se->parent->depth + 1 : 0;
>> -#endif
>> -
>>         /* Synchronize entity with its cfs_rq */
>>         update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
>>         attach_entity_load_avg(cfs_rq, se);
>> @@ -11431,15 +11423,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
>>  }
>>
>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>> -static void task_set_group_fair(struct task_struct *p)
>> -{
>> -       struct sched_entity *se = &p->se;
>> -
>> -       set_task_rq(p, task_cpu(p));
>> -       se->depth = se->parent ? se->parent->depth + 1 : 0;
>> -}
>> -
>> -static void task_move_group_fair(struct task_struct *p)
>> +static void task_change_group_fair(struct task_struct *p)
>>  {
>>         detach_task_cfs_rq(p);
>>         set_task_rq(p, task_cpu(p));
>> @@ -11451,19 +11435,6 @@ static void task_move_group_fair(struct task_struct *p)
>>         attach_task_cfs_rq(p);
>>  }
>>
>> -static void task_change_group_fair(struct task_struct *p, int type)
>> -{
>> -       switch (type) {
>> -       case TASK_SET_GROUP:
>> -               task_set_group_fair(p);
>> -               break;
>> -
>> -       case TASK_MOVE_GROUP:
>> -               task_move_group_fair(p);
>> -               break;
>> -       }
>> -}
>> -
>>  void free_fair_sched_group(struct task_group *tg)
>>  {
>>         int i;
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 317480d535b0..8433e22da3ab 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1901,6 +1901,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
>>         set_task_rq_fair(&p->se, p->se.cfs_rq, tg->cfs_rq[cpu]);
>>         p->se.cfs_rq = tg->cfs_rq[cpu];
>>         p->se.parent = tg->se[cpu];
>> +       p->se.depth = tg->se[cpu] ? tg->se[cpu]->depth + 1 : 0;
>>  #endif
>>
>>  #ifdef CONFIG_RT_GROUP_SCHED
>> @@ -2163,11 +2164,8 @@ struct sched_class {
>>
>>         void (*update_curr)(struct rq *rq);
>>
>> -#define TASK_SET_GROUP         0
>> -#define TASK_MOVE_GROUP                1
>> -
>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>> -       void (*task_change_group)(struct task_struct *p, int type);
>> +       void (*task_change_group)(struct task_struct *p);
>>  #endif
>>  };
>>
>> --
>> 2.36.1
>>
