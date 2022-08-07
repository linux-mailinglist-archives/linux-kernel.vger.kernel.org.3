Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C861258BB21
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 16:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiHGOFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 10:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiHGOFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:05:11 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7248E5F8C
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 07:05:10 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id h16so3596838ilc.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc;
        bh=z2SfEDbJqWTl2t2EIGjWq5X2j4ArWVTlukHwW6+Es1M=;
        b=WuYKW7+EL5d52Iz7AR5uxzS4g8ElFFv9/P03XQfr2e4tC4OucO02rs/edTNdS0j+Qg
         oex1wQGowVkpKdqmn3lKzZB/YUT6qRIOiuVvbYWWTiXXmppLLBlz6D+auHSXZTEir6pW
         bkyvazZ5ronkvaLUEfZ/FEALN/taCxYhGo5qnlqcrkMKJSUA13p4QxYVM0XmobwhsHRq
         TtrmnFwyfpwEYENkr+o1LUuPG3aVTgZcsXbgk90Bf2qjk3mh3ftLeqd6c0Zlm2GFINhL
         usFOYNPKX4RWjMKjQSBFULoas75zVT/cDKpv8XchL4tcqPohz6ZBtHQd45FIWuNTlW52
         d3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc;
        bh=z2SfEDbJqWTl2t2EIGjWq5X2j4ArWVTlukHwW6+Es1M=;
        b=n/jXDkRJDlWgWI2ovmlkaqNBXbvK8X/i3dIqarF4RjvthwQkW6Y7piOcvpHjhHyIiA
         KvXWURRpp4Sm65FsGTCRtLc6XujI/A4ZNdNuMrcfVFtVavEcPpbPwC35MtJNmNU/1yWN
         eTNWjkGppmiC+zwVsuXoIL7IKxVBFt7Z5W8VlCF0TNrMLNQvMutFXW4wPP47Iqb/wWmF
         vVWrbI1F24Svh7c9cfANKDDuzlT//ZTV4pWMXyXSqJAK99F5LTxg7rYcej5VzU+jKe1S
         k97fsxCY1fPUpMzGCVqnJPSCOLwjrXkyUQ6N1MBeOTxWQBpu6Aa63fZzonbHm9xwCTmO
         XPpg==
X-Gm-Message-State: ACgBeo1HrN2HHO+chs1u2vzc/tCFfHkUb039JNZGs0+wdJXajpfnJizo
        9ZT1vNbnjLrC4qLzXLYw3nGR39RhledD4xQN
X-Google-Smtp-Source: AA6agR5YaBQ3E5+5U3RZSxvVJPxkpGhAXhottrRLI9QPPLWylMFgguw8kM2XFZoIUiD1FqCelQdIXg==
X-Received: by 2002:a92:c568:0:b0:2de:e010:36f1 with SMTP id b8-20020a92c568000000b002dee01036f1mr6566694ilj.255.1659881109420;
        Sun, 07 Aug 2022 07:05:09 -0700 (PDT)
Received: from ArchLinux (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id f66-20020a0284c8000000b00341755dc45csm3968965jai.106.2022.08.07.07.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 07:05:08 -0700 (PDT)
References: <20220707090501.55483-1-schspa@gmail.com>
 <0320c5f9-cbda-1652-1f97-24d1a22fb298@gmail.com>
 <YtAqsyjlvmfDokH/@worktop.programming.kicks-ass.net>
 <m2tu6zxme3.fsf@gmail.com>
 <CAJhGHyBc4HXE8bRFYcqNLoX7oNqdq62tOFWvR0XGCAcBJ9mgsQ@mail.gmail.com>
 <m235egv9d1.fsf@gmail.com>
 <CAJhGHyD3RtBqRDgqqrQE-XndHGvxpJ7SjH4FcY1V5+Ad7Bvb0g@mail.gmail.com>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: Use active mask for new worker when pool is
 DISASSOCIATED
Date:   Sun, 07 Aug 2022 21:52:27 +0800
In-reply-to: <CAJhGHyD3RtBqRDgqqrQE-XndHGvxpJ7SjH4FcY1V5+Ad7Bvb0g@mail.gmail.com>
Message-ID: <m2v8r4qhde.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lai Jiangshan <jiangshanlai@gmail.com> writes:

> On Mon, Aug 1, 2022 at 1:08 PM Schspa Shi <schspa@gmail.com> wrote:
>>
>>
>> Lai Jiangshan <jiangshanlai@gmail.com> writes:
>>
>> > On Sat, Jul 30, 2022 at 12:19 PM Schspa Shi <schspa@gmail.com> wrote:
>> >>
>> >>
>> >> Peter Zijlstra <peterz@infradead.org> writes:
>> >>
>> >> > On Wed, Jul 13, 2022 at 05:52:58PM +0800, Lai Jiangshan wrote:
>> >> >>
>> >> >>
>> >> >> CC Peter.
>> >> >> Peter has changed the CPU binding code in workqueue.c.
>> >> >
>> >> > [ 1622.829091] WARNING: CPU: 3 PID: 31 at kernel/sched/core.c:7756 sched_cpu_dying+0x74/0x204
>> >> > [ 1622.829374] CPU: 3 PID: 31 Comm: migration/3 Tainted: P           O      5.10.59-rt52 #2
>> >> >                                                                       ^^^^^^^^^^^^^^^^^^^^^
>> >> >
>> >> > I think we can ignore this as being some ancient kernel. Please try
>> >> > something recent.
>> >>
>> >> Hi peter:
>> >>
>> >> I spent a few days writing a test case and reproduced the problem on
>> >> kernel 5.19. I think it's time for us to review the V3 patch for a fix.
>> >>
>> >> The V3 patch is at
>> >> https://lore.kernel.org/all/20220714031645.28004-1-schspa@gmail.com/
>> >> Please help to review it.
>> >
>> > Because of the implementation of is_cpu_allowed(),
>> > I am still suspicious about how the newly created worker can be woken
>> > up in the dying cpu since it has no KTHREAD_IS_PER_CPU set.
>> >
>>
>> I think the comments of the V3 patch have explained the problem, the
>> newly created worker runs on the dying CPU because we bind it to the
>> dying CPU via kthread_bind_mask or set_cpus_allowed_ptr.
>>
>
> wake_up_process() will modify the task's cpumask and select
> a fallback cpu.  The schedule code does it for all kthreads that
> happen to have a single CPU affinity which is lost.
>

There are two exceptions I can think of here:
1. For tasks that are prohibited from migration, the system uses
cpu_online_mask, and will not select the fallback cpu.
2. When the scheduling code judges cpu_dying, there is no means of
synchronization. At this time, cpu_dying_mask is an unstable variable.
The scheduler does not guarantee that the above migration will be possible.

In the case of PREEMPT_RT, spin_lock will prohibit migration, which also
causes this problem to be easily reproduced in the RT version.
In view of some of the above limitations, I think we should not rely on
the implementation of the above scheduler, but handle this when creating
threads.

>> Please refer to the following scenarios.
>>
>>            CPU0                                  CPU1
>> ------------------------------------------------------------------
>> sched_cpu_deactivate(cpu_active_mask clear)
>> workqueue_offline_cpu(work pool POOL_DISASSOCIATED)
>>   -- all worker will migrate to another cpu --
>>                                     worker_thread
>>                                     -- will create new worker if
>>                                        pool->worklist is not empty
>>                                        create_worker()
>>                                      -- new kworker will bound to CPU0
>>                                (pool->attrs->cpumask will be mask of CPU0).
>>       kworker/0:x will running on rq
>>
>> sched_cpu_dying
>>   if (rq->nr_running != 1 || rq_has_pinned_tasks(rq))
>>     WARN(true, "Dying CPU not properly vacated!");
>>       ---------OOPS-------------
>>
>> When CPUHP_HRTIMERS_PREPARE < CPU0's state < CPUHP_AP_WORKQUEUE_ONLINE,
>> the CPU0 still can schedule a new work, which will add a new work to
>> pool->worklist of a dying CPU's work pool.
>>
>> > Is it a dying cpu when onlining a CPU fails?  I think balance_push
>> > is not set in this case when it fails at some point during online.
>> > But I haven't looked into the details and linked the clues.
>> >
>>
>> Not this case, there is on onlining CPU fails log in my test log.
>>
>> >
>> >>
>> >> Test branch as:
>> >> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tag/?h=v5.19-rc8-rt8
>> >>
>> >
>> > Can it only be triggered in the rt kernel?
>> >
>>
>> I only test on rt kernel, because of I work on RT kernel now, But I
>> think non-rt kernel have the issues too.
>>
>> >> I think this code is new enough to demonstrate that the problem persists.
>> >>
>> >> The log as fellowing:
>> >>
>> >> [ 3103.198684] ------------[ cut here ]------------
>> >> [ 3103.198684] Dying CPU not properly vacated!
>> >> [ 3103.198684] WARNING: CPU: 1 PID: 23 at kernel/sched/core.c:9575 sched_cpu_dying.cold+0xc/0xc3
>> >> [ 3103.198684] Modules linked in: work_test(O)
>> >
>> > Could you give me the code of this module?
>>
>> The module's source code is at
>> https://github.com/schspa/code_snippet/blob/master/kernel_module/workqueue_test/work-test.c
>> Kernel defconfig is at
>> https://github.com/schspa/ktest/blob/main/configs/linux_rt_defconfig
>>
>
> How long will it take to reproduce the bug?
> I have tested for a short time on the non-rt kernel, no thing
> has happened yet.
>
>> I add a hook to the entry of worker_thread, which add extra 50ms delay
>> to make it reproduced faster.
>>
>> --
>> BRs
>> Schspa Shi


-- 
BRs
Schspa Shi
