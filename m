Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F0C586692
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiHAIsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiHAIsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:48:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BF03AE67
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:48:29 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p10so9028059wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 01:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+yzS+lfQR2EyLvBoAw7LJb1vJYphbgCLh2RqOKDiGLg=;
        b=DZMTutwZm+p+aZ5j2uaKgqWOq0/ijaW5CbQS9FiJytkd6SsDxpDFjmz7TjgVGK/b4B
         QM7IUNVKDxvUvMM4uJLHn2o5TvkPp06UFvWPBwen+Y1F6mn3/M6SExFDPHI574/N4bH0
         D0mP4yvS+aRTMz0nkR9qWTRdWE0hTmUcutjZyysVTQkGDfg1FGMIHZtcvUICIrHijr0/
         Ywq1v3NO85zSoCZ1QhUYQCSdgjj7MHh5Mi2++RgIjQI63WJ0bb1FhKzKzi8Cf9uyYjWg
         daKAkECbeg2TWJfsWfFO1JZUci2OsNXKprFF54hhywEpVoYXeip5LedMpRTtB8ZJ6rCl
         9MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+yzS+lfQR2EyLvBoAw7LJb1vJYphbgCLh2RqOKDiGLg=;
        b=ABjctKQq6Pa98tXq29fSy5bD6+YZROjoXftVdZN51zGJH/buXB1Qyw2s4wNoFvJUzq
         9qNMmHh0xJg/au3FzRe+Uz4nR3tYJbJz8vJXIqRJ7tBOX+/sHkyGlkpDimn40SO9Hn9x
         J4iDU+fSIXlJCGVdtWOsoZ4ZYlFHxhWCQiePAKt6xMoMDR1POqbmiYSiwAGs+Rx5ek8d
         lwms5pRGouMfZFR2aUoqjQ2jJm0ji0Tm/1j0HAFjB4iB4jOmT4LgDwG5FFFpvzXYqy4J
         EC3ouTHCNQtpwW0M+qRDzFZazxgZvos0AL4tBBGrBooNbQvpoWTRAroVh2Kp1mNJgauC
         vgvw==
X-Gm-Message-State: ACgBeo1hON7vEn+7AQR7g7XuKxZOb2OdFTwAIW4MVoS6lXG4tSPRNcP3
        nYOY9oLPKV0GGFArBoP4GS/lT7Z3cle2oDwvSjF93pXOk4s=
X-Google-Smtp-Source: AA6agR6Eq8TV9uYdfWN6cSL0wdNZjGZzsFnaKtD9HYG93T92giRego0cJ/cPBqGHJMcGfNKeUejGwv7LCyL/+J1zJWU=
X-Received: by 2002:a5d:5a9a:0:b0:220:6309:5c87 with SMTP id
 bp26-20020a5d5a9a000000b0022063095c87mr2316170wrb.107.1659343707946; Mon, 01
 Aug 2022 01:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220707090501.55483-1-schspa@gmail.com> <0320c5f9-cbda-1652-1f97-24d1a22fb298@gmail.com>
 <YtAqsyjlvmfDokH/@worktop.programming.kicks-ass.net> <m2tu6zxme3.fsf@gmail.com>
 <CAJhGHyBc4HXE8bRFYcqNLoX7oNqdq62tOFWvR0XGCAcBJ9mgsQ@mail.gmail.com> <m235egv9d1.fsf@gmail.com>
In-Reply-To: <m235egv9d1.fsf@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Mon, 1 Aug 2022 16:48:16 +0800
Message-ID: <CAJhGHyD3RtBqRDgqqrQE-XndHGvxpJ7SjH4FcY1V5+Ad7Bvb0g@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Use active mask for new worker when pool is DISASSOCIATED
To:     Schspa Shi <schspa@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 1:08 PM Schspa Shi <schspa@gmail.com> wrote:
>
>
> Lai Jiangshan <jiangshanlai@gmail.com> writes:
>
> > On Sat, Jul 30, 2022 at 12:19 PM Schspa Shi <schspa@gmail.com> wrote:
> >>
> >>
> >> Peter Zijlstra <peterz@infradead.org> writes:
> >>
> >> > On Wed, Jul 13, 2022 at 05:52:58PM +0800, Lai Jiangshan wrote:
> >> >>
> >> >>
> >> >> CC Peter.
> >> >> Peter has changed the CPU binding code in workqueue.c.
> >> >
> >> > [ 1622.829091] WARNING: CPU: 3 PID: 31 at kernel/sched/core.c:7756 sched_cpu_dying+0x74/0x204
> >> > [ 1622.829374] CPU: 3 PID: 31 Comm: migration/3 Tainted: P           O      5.10.59-rt52 #2
> >> >                                                                       ^^^^^^^^^^^^^^^^^^^^^
> >> >
> >> > I think we can ignore this as being some ancient kernel. Please try
> >> > something recent.
> >>
> >> Hi peter:
> >>
> >> I spent a few days writing a test case and reproduced the problem on
> >> kernel 5.19. I think it's time for us to review the V3 patch for a fix.
> >>
> >> The V3 patch is at
> >> https://lore.kernel.org/all/20220714031645.28004-1-schspa@gmail.com/
> >> Please help to review it.
> >
> > Because of the implementation of is_cpu_allowed(),
> > I am still suspicious about how the newly created worker can be woken
> > up in the dying cpu since it has no KTHREAD_IS_PER_CPU set.
> >
>
> I think the comments of the V3 patch have explained the problem, the
> newly created worker runs on the dying CPU because we bind it to the
> dying CPU via kthread_bind_mask or set_cpus_allowed_ptr.
>

wake_up_process() will modify the task's cpumask and select
a fallback cpu.  The schedule code does it for all kthreads that
happen to have a single CPU affinity which is lost.

> Please refer to the following scenarios.
>
>            CPU0                                  CPU1
> ------------------------------------------------------------------
> sched_cpu_deactivate(cpu_active_mask clear)
> workqueue_offline_cpu(work pool POOL_DISASSOCIATED)
>   -- all worker will migrate to another cpu --
>                                     worker_thread
>                                     -- will create new worker if
>                                        pool->worklist is not empty
>                                        create_worker()
>                                      -- new kworker will bound to CPU0
>                                (pool->attrs->cpumask will be mask of CPU0).
>       kworker/0:x will running on rq
>
> sched_cpu_dying
>   if (rq->nr_running != 1 || rq_has_pinned_tasks(rq))
>     WARN(true, "Dying CPU not properly vacated!");
>       ---------OOPS-------------
>
> When CPUHP_HRTIMERS_PREPARE < CPU0's state < CPUHP_AP_WORKQUEUE_ONLINE,
> the CPU0 still can schedule a new work, which will add a new work to
> pool->worklist of a dying CPU's work pool.
>
> > Is it a dying cpu when onlining a CPU fails?  I think balance_push
> > is not set in this case when it fails at some point during online.
> > But I haven't looked into the details and linked the clues.
> >
>
> Not this case, there is on onlining CPU fails log in my test log.
>
> >
> >>
> >> Test branch as:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tag/?h=v5.19-rc8-rt8
> >>
> >
> > Can it only be triggered in the rt kernel?
> >
>
> I only test on rt kernel, because of I work on RT kernel now, But I
> think non-rt kernel have the issues too.
>
> >> I think this code is new enough to demonstrate that the problem persists.
> >>
> >> The log as fellowing:
> >>
> >> [ 3103.198684] ------------[ cut here ]------------
> >> [ 3103.198684] Dying CPU not properly vacated!
> >> [ 3103.198684] WARNING: CPU: 1 PID: 23 at kernel/sched/core.c:9575 sched_cpu_dying.cold+0xc/0xc3
> >> [ 3103.198684] Modules linked in: work_test(O)
> >
> > Could you give me the code of this module?
>
> The module's source code is at
> https://github.com/schspa/code_snippet/blob/master/kernel_module/workqueue_test/work-test.c
> Kernel defconfig is at
> https://github.com/schspa/ktest/blob/main/configs/linux_rt_defconfig
>

How long will it take to reproduce the bug?
I have tested for a short time on the non-rt kernel, no thing
has happened yet.

> I add a hook to the entry of worker_thread, which add extra 50ms delay
> to make it reproduced faster.
>
> --
> BRs
> Schspa Shi
