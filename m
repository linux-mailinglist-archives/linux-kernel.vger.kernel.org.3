Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399934D276B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiCIDJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiCIDJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:09:48 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C9DAE4C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 19:08:50 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so1087080pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 19:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fafGdH7RVKoIoF9ehJ0GG1R/Gdj0oNIYkbLYA8cJcns=;
        b=n0mUsJHOEua/lwijnfiK7NlcIJnJoR8Ol+DPJOgawyy2eqC46XuQUUdlVTMkTcJnhC
         N5BJfrSvLYClKMVOIiuZq+01ndVm990uWRrqVMfE1ZShwitlC5sX2kNR/RFQe1Q6hiNX
         7WHDQnUw7Zdt1kBoQNw8bluu0cV0meDQOnNDmt1cRfim+pYy3qhc+wbylDbWQp9VEjHp
         U/SFS7O/yU2dHUL5kSdbfeIkY5t+5rber4qQ0c04Erq9AbZI3HoyV6jfEYSQTGR2lkOF
         3ktAkEjRMjQFKh6IZeXQUUOQoxiQcTgf4oCibhktb5GUZmEjYI40kXUoYje5IixoPMdo
         qNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fafGdH7RVKoIoF9ehJ0GG1R/Gdj0oNIYkbLYA8cJcns=;
        b=Gf0F/oJ9k0oZoG5aQg6/01DLWMD6GW0ZfPCfRF7GQ8l0IiCgL2IwZC3EJ0wVGCi+nW
         fGDLfuf8HfjfefhhqafIAnMOYUnZ8mdkWgHUHId1tVpL4jRQPVZgNVBDMMtmt9wTfycE
         lT1Ao5a1VrAVy5dQ5WCHZscFZ+irH1ntKU1shAHAXiPN0u6ExsT8FaaG+E4l/ehZ3ND/
         VYf1dd7aLNQ3/824OkyWJBIlL9LVWwO7LMX9wA4h/ldOfsalCtKYuLJdJgJFIOirpmyR
         XslewW19dxuvKquj//UQsOqXQwUFquTHCoVPTXSnJKWVNKt7EtndYXfyz0yH0zNMUHdd
         pXUQ==
X-Gm-Message-State: AOAM533lriSmQmF7Mf9BnjpEiVIxQgiyDVLtdjASFs9iAqMNSQkB7LPR
        PR0aGMzMp6WimCwXFnD73Fu6VA==
X-Google-Smtp-Source: ABdhPJzoEgiPlXNtVVWNCvumVkEyRdIdGFc167/d10qWzgVMzRdTj4d2BQQB4cljs/KMP3/ZXh5Wmw==
X-Received: by 2002:a17:90b:314d:b0:1bf:1dc5:8e8d with SMTP id ip13-20020a17090b314d00b001bf1dc58e8dmr8170467pjb.204.1646795330331;
        Tue, 08 Mar 2022 19:08:50 -0800 (PST)
Received: from [10.255.244.211] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id b2-20020a639302000000b003808dc4e133sm443130pge.81.2022.03.08.19.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 19:08:50 -0800 (PST)
Message-ID: <7054def3-4f69-cf9f-546c-02a7435924d8@bytedance.com>
Date:   Wed, 9 Mar 2022 11:08:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [External] Re: [PATCH v3 2/3] sched/cpuacct: optimize away RCU
 read lock
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        bristot@redhat.com, zhaolei@cn.fujitsu.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org
References: <20220220051426.5274-1-zhouchengming@bytedance.com>
 <20220220051426.5274-2-zhouchengming@bytedance.com>
 <CGME20220308232034eucas1p2b0f39cee0f462af6004ebdfbe5bacb9f@eucas1p2.samsung.com>
 <f4bc652b-115f-35b5-91db-bad3b30fed9b@samsung.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <f4bc652b-115f-35b5-91db-bad3b30fed9b@samsung.com>
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

On 2022/3/9 7:20 上午, Marek Szyprowski wrote:
> On 20.02.2022 06:14, Chengming Zhou wrote:
>> Since cpuacct_charge() is called from the scheduler update_curr(),
>> we must already have rq lock held, then the RCU read lock can
>> be optimized away.
>>
>> And do the same thing in it's wrapper cgroup_account_cputime(),
>> but we can't use lockdep_assert_rq_held() there, which defined
>> in kernel/sched/sched.h.
>>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> This patch landed recently in linux-next as commit dc6e0818bc9a 
> ("sched/cpuacct: Optimize away RCU read lock"). On my test systems I 
> found that it triggers a following warning in the early boot stage:

Hi, thanks for the report. I've send a fix patch[1] for review.

[1] https://lore.kernel.org/lkml/20220305034103.57123-1-zhouchengming@bytedance.com/

> 
> Calibrating delay loop (skipped), value calculated using timer 
> frequency.. 48.00 BogoMIPS (lpj=240000)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> CPU: Testing write buffer coherency: ok
> CPU0: Spectre v2: using BPIALL workaround
> 
> =============================
> WARNING: suspicious RCU usage
> 5.17.0-rc5-00050-gdc6e0818bc9a #11458 Not tainted
> -----------------------------
> ./include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 1, debug_locks = 1
> 2 locks held by kthreadd/2:
>   #0: c1d7972c (&p->pi_lock){....}-{2:2}, at: task_rq_lock+0x30/0x118
>   #1: ef7b52d0 (&rq->__lock){-...}-{2:2}, at: 
> raw_spin_rq_lock_nested+0x24/0x34
> 
> stack backtrace:
> CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.17.0-rc5-00050-gdc6e0818bc9a 
> #11458
> Hardware name: Samsung Exynos (Flattened Device Tree)
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x58/0x70
>   dump_stack_lvl from update_curr+0x1bc/0x35c
>   update_curr from dequeue_task_fair+0xb0/0x8e8
>   dequeue_task_fair from __do_set_cpus_allowed+0x19c/0x258
>   __do_set_cpus_allowed from __set_cpus_allowed_ptr_locked+0x130/0x1d8
>   __set_cpus_allowed_ptr_locked from __set_cpus_allowed_ptr+0x48/0x64
>   __set_cpus_allowed_ptr from kthreadd+0x44/0x16c
>   kthreadd from ret_from_fork+0x14/0x2c
> Exception stack(0xc1cb9fb0 to 0xc1cb9ff8)
> 9fa0:                                     00000000 00000000 00000000 
> 00000000
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
> 00000000
> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> CPU0: thread -1, cpu 0, socket 9, mpidr 80000900
> cblist_init_generic: Setting adjustable number of callback queues.
> cblist_init_generic: Setting shift to 1 and lim to 1.
> Running RCU-tasks wait API self tests
> Setting up static identity map for 0x40100000 - 0x40100060
> rcu: Hierarchical SRCU implementation.
> 
> =============================
> WARNING: suspicious RCU usage
> 5.17.0-rc5-00050-gdc6e0818bc9a #11458 Not tainted
> -----------------------------
> ./include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 1, debug_locks = 1
> 1 lock held by migration/0/13:
>   #0: ef7b52d0 (&rq->__lock){-...}-{2:2}, at: 
> raw_spin_rq_lock_nested+0x24/0x34
> 
> stack backtrace:
> CPU: 0 PID: 13 Comm: migration/0 Not tainted 
> 5.17.0-rc5-00050-gdc6e0818bc9a #11458
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Stopper: 0x0 <- 0x0
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x58/0x70
>   dump_stack_lvl from put_prev_task_stop+0x16c/0x25c
>   put_prev_task_stop from __schedule+0x698/0x964
>   __schedule from schedule+0x54/0xe0
>   schedule from smpboot_thread_fn+0x218/0x288
>   smpboot_thread_fn from kthread+0xf0/0x134
>   kthread from ret_from_fork+0x14/0x2c
> Exception stack(0xc1ccffb0 to 0xc1ccfff8)
> ffa0:                                     00000000 00000000 00000000 
> 00000000
> ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
> 00000000
> ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
> smp: Bringing up secondary CPUs ...
> CPU1: thread -1, cpu 1, socket 9, mpidr 80000901
> CPU1: Spectre v2: using BPIALL workaround
> smp: Brought up 1 node, 2 CPUs
> SMP: Total of 2 processors activated (96.00 BogoMIPS).
> 
> The above log comes from ARM 32bit Samsung Exnyos4210 based Trats board.
> 
>> ---
>>   include/linux/cgroup.h | 2 --
>>   kernel/sched/cpuacct.c | 4 +---
>>   2 files changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
>> index 75c151413fda..9a109c6ac0e0 100644
>> --- a/include/linux/cgroup.h
>> +++ b/include/linux/cgroup.h
>> @@ -791,11 +791,9 @@ static inline void cgroup_account_cputime(struct task_struct *task,
>>   
>>   	cpuacct_charge(task, delta_exec);
>>   
>> -	rcu_read_lock();
>>   	cgrp = task_dfl_cgroup(task);
>>   	if (cgroup_parent(cgrp))
>>   		__cgroup_account_cputime(cgrp, delta_exec);
>> -	rcu_read_unlock();
>>   }
>>   
>>   static inline void cgroup_account_cputime_field(struct task_struct *task,
>> diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
>> index 307800586ac8..f79f88456d72 100644
>> --- a/kernel/sched/cpuacct.c
>> +++ b/kernel/sched/cpuacct.c
>> @@ -337,12 +337,10 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
>>   	unsigned int cpu = task_cpu(tsk);
>>   	struct cpuacct *ca;
>>   
>> -	rcu_read_lock();
>> +	lockdep_assert_rq_held(cpu_rq(cpu));
>>   
>>   	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
>>   		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
>> -
>> -	rcu_read_unlock();
>>   }
>>   
>>   /*
> 
> Best regards
