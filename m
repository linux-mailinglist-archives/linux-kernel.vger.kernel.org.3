Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B518586723
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiHAJxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiHAJxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:53:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCA43B96A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:53:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t22so2304720pjy.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc;
        bh=Vg+XF74QgwXLcFwwmuHkomAZXEmSb5+gCwljDdSVN28=;
        b=O+8hSrqG7dGJjhTo39tqVmMHiAXNP7z5pFxNQX5m1ITmuzhI5qW4sUhhlnZqA51kB5
         ZKpaGDxOj2NXPzRULvbfBzxsSicm5pWS9rJGLUjR0zPZhoRFhcCpRBId8neGswvcUp0i
         tMCsYnjwMaXs39o8O1BVBCuedEjl4KCnglDDC9qXQNpn/oV8acUjLPyHEabeRUx1aSL+
         pnPnIJ6NvhaaHhwxzZqfHBpAV0T/2980UmZhBa2Uk/gTxekT+zQPd/pm2EAgOGTO+OlV
         6liT7ZbqpPck+fh0DK2zfaLFmBIQIiFIsz/pn9OoSegZxioUMy829Cx9ham4AYGWIQI9
         ibZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc;
        bh=Vg+XF74QgwXLcFwwmuHkomAZXEmSb5+gCwljDdSVN28=;
        b=lfQ4k7dFyk0VUqhL54LEe8dn1kEQksFpvQN4S7dyJaZDeyr1I5ha8uoq+yaQJBxLAi
         ZsIEIsxZftERlqS8ycPvG3MAWNao0gS7cn7bSShusMUkFt0Q3bhlwTQxcT5pbzkaP6iU
         SB1lqMVTEL5x89nbOecPn544wi/cRZvFHYGsooi/XBO2mhadncBJ/m4gvv6T+pSAGJfd
         4YSpTNi/4kr4TY9pEvar7zxgErQUXvh4yHEAZFQBbLFxjTZG/nuQJOp1vLA5G5pdLLjz
         d6BsbcOcRh+Kvq2MjTU6BnYZl/gA83/JSgXjJFyYFvm54dhjjf60ZIyL17snNtvlhgep
         dI8w==
X-Gm-Message-State: ACgBeo25gVCc5dlKjEi6VNdPmVS2QkdCXPXxq3bYSVMV8WFbT/1u9vBv
        aHLrpQ6IyfNIf+gl+R5GCqiyfswXX+whHQ==
X-Google-Smtp-Source: AA6agR7iT/BfQVBOUyEvaJmqA51e4SBb41uOAWX0FaR/FLIPUXLlh/Zp2utiOGSo8YicP6U5mwmSYA==
X-Received: by 2002:a17:90b:1a8c:b0:1ef:c1b2:b2cd with SMTP id ng12-20020a17090b1a8c00b001efc1b2b2cdmr18293158pjb.190.1659347592079;
        Mon, 01 Aug 2022 02:53:12 -0700 (PDT)
Received: from MBP ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id g18-20020aa796b2000000b0052ab5a740aesm8022915pfk.162.2022.08.01.02.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 02:53:11 -0700 (PDT)
References: <20220707090501.55483-1-schspa@gmail.com>
 <0320c5f9-cbda-1652-1f97-24d1a22fb298@gmail.com>
 <YtAqsyjlvmfDokH/@worktop.programming.kicks-ass.net>
 <m2tu6zxme3.fsf@gmail.com>
 <CAJhGHyBc4HXE8bRFYcqNLoX7oNqdq62tOFWvR0XGCAcBJ9mgsQ@mail.gmail.com>
 <m235egv9d1.fsf@gmail.com>
 <CAJhGHyD3RtBqRDgqqrQE-XndHGvxpJ7SjH4FcY1V5+Ad7Bvb0g@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Schspa Shi <schspa@gmail.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: Use active mask for new worker when pool is
 DISASSOCIATED
Date:   Mon, 01 Aug 2022 17:32:30 +0800
In-reply-to: <CAJhGHyD3RtBqRDgqqrQE-XndHGvxpJ7SjH4FcY1V5+Ad7Bvb0g@mail.gmail.com>
Message-ID: <m235egqohv.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

I'm not very familiar with this part of the code, I'll check the code
here first.

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

Test host machine:
4 core virtual machines with nested KVM support.
16GB memory.

Test VM:
3 * 4core KVM virtual machine.

With 3 test instances, it will reproduce in one day.

This needs some stress to make it reproduce, you can use my script to
compile & launch the test automatically.

https://github.com/schspa/ktest/blob/main/test-lnx.sh
~/work/src/ktest/test-lnx.sh ~/src/linux linux-rt-devel/linux-5.18.y-rt ~/test/linux-5.18.y-rt wq-test

>> I add a hook to the entry of worker_thread, which add extra 50ms delay
>> to make it reproduced faster.
>>
>> --
>> BRs
>> Schspa Shi


-- 
BRs
Schspa Shi
