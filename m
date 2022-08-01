Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B9A5863B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 07:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbiHAFI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 01:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiHAFIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 01:08:55 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEA612ACE
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 22:08:54 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s206so8754290pgs.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 22:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc;
        bh=FI2slEDL0OuyC3Vag1PYn+ptaAQPjUy3upspXOztAUk=;
        b=gsub5H2rhbM2DFZX8x20b8mFjESBS8BmlfMoexLGK2OHt6mCIlS5vGC/7nJk+cwOyP
         QbB0aBv5uX+qS7z304m6BbcPXQCRAnnlps7v5SNEmU5VWpMgVkWP7WKbQKoMcCvu5Pmh
         2IWDiz5M6kFgDKayUbW+llxLGpAHvpvZ9NA/q9cCAD5lw06AJXtwxwH1qoPVIlZMclKU
         mkUWnq38tBhrTQGTDMFVTyYZHuCAFvouYUEjMCopVXxR4DYOJrvRqD/6dU7UGEH+RFcG
         c7c7RRXBLRYzrWTHUwCNjWhJUVOj/vSzIRYXwqgf1XfGkxcPo8BGLKSlrNfZBLImdjo6
         2v5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc;
        bh=FI2slEDL0OuyC3Vag1PYn+ptaAQPjUy3upspXOztAUk=;
        b=PgY0LZZpf+O7BB+TFs+uGWtq/3BzQQ9nIpm0Rb6VHJrTSvRmENkUiLjam4y0Arn0N1
         1QKyEYgCAhceMY1LuTasEE7UmxMTCFP2cfdLTWhoFdg3+iomNmhw4RoRGaTgVDMIqxpn
         NZds2mQsu3gqlX1gAvDCqqiQHAG9YNrZbZBkU+B2r+AwHcxjMsgCqhXzwpaGTTjd7ZeL
         nQvZuJw++axSmlIolvPzw2v2M9YQTZps4tC6mAD3ko5mw61GebwcWeb/Qj+ikg4+xSFP
         AeaXRJIEo2nqZRMmLBBtg+/h2K2Ll6zJKDCKRQLa+IpozpfrO7buBokLKcxZALRJIXjc
         6swg==
X-Gm-Message-State: AJIora+AC2NZ8o1PuDCKBI9D1gBu0JuGVzbmJqQ99zJU3h+4Syhwbovq
        vQcZoPQ1PnoJRw07G77aLzLdyyRAostXeg==
X-Google-Smtp-Source: AGRyM1u8IDjmNenIskJL/4ifXqk/YzPCpvCHLiR+hZE8kFIlozkZG/hoKkv8dBbqBxpJLz5FgjB4eQ==
X-Received: by 2002:a05:6a00:230d:b0:52b:1819:3a0 with SMTP id h13-20020a056a00230d00b0052b181903a0mr14463443pfh.53.1659330533464;
        Sun, 31 Jul 2022 22:08:53 -0700 (PDT)
Received: from MBP ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903244900b0016dc307aef4sm8467231pls.36.2022.07.31.22.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 22:08:52 -0700 (PDT)
References: <20220707090501.55483-1-schspa@gmail.com>
 <0320c5f9-cbda-1652-1f97-24d1a22fb298@gmail.com>
 <YtAqsyjlvmfDokH/@worktop.programming.kicks-ass.net>
 <m2tu6zxme3.fsf@gmail.com>
 <CAJhGHyBc4HXE8bRFYcqNLoX7oNqdq62tOFWvR0XGCAcBJ9mgsQ@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Schspa Shi <schspa@gmail.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: Use active mask for new worker when pool is
 DISASSOCIATED
Date:   Mon, 01 Aug 2022 12:42:33 +0800
In-reply-to: <CAJhGHyBc4HXE8bRFYcqNLoX7oNqdq62tOFWvR0XGCAcBJ9mgsQ@mail.gmail.com>
Message-ID: <m235egv9d1.fsf@gmail.com>
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

> On Sat, Jul 30, 2022 at 12:19 PM Schspa Shi <schspa@gmail.com> wrote:
>>
>>
>> Peter Zijlstra <peterz@infradead.org> writes:
>>
>> > On Wed, Jul 13, 2022 at 05:52:58PM +0800, Lai Jiangshan wrote:
>> >>
>> >>
>> >> CC Peter.
>> >> Peter has changed the CPU binding code in workqueue.c.
>> >
>> > [ 1622.829091] WARNING: CPU: 3 PID: 31 at kernel/sched/core.c:7756 sched_cpu_dying+0x74/0x204
>> > [ 1622.829374] CPU: 3 PID: 31 Comm: migration/3 Tainted: P           O      5.10.59-rt52 #2
>> >                                                                       ^^^^^^^^^^^^^^^^^^^^^
>> >
>> > I think we can ignore this as being some ancient kernel. Please try
>> > something recent.
>>
>> Hi peter:
>>
>> I spent a few days writing a test case and reproduced the problem on
>> kernel 5.19. I think it's time for us to review the V3 patch for a fix.
>>
>> The V3 patch is at
>> https://lore.kernel.org/all/20220714031645.28004-1-schspa@gmail.com/
>> Please help to review it.
>
> Because of the implementation of is_cpu_allowed(),
> I am still suspicious about how the newly created worker can be woken
> up in the dying cpu since it has no KTHREAD_IS_PER_CPU set.
>

I think the comments of the V3 patch have explained the problem, the
newly created worker runs on the dying CPU because we bind it to the
dying CPU via kthread_bind_mask or set_cpus_allowed_ptr.

Please refer to the following scenarios.

           CPU0                                  CPU1
------------------------------------------------------------------
sched_cpu_deactivate(cpu_active_mask clear)
workqueue_offline_cpu(work pool POOL_DISASSOCIATED)
  -- all worker will migrate to another cpu --
                                    worker_thread
                                    -- will create new worker if
                                       pool->worklist is not empty
                                       create_worker()
                                     -- new kworker will bound to CPU0
                               (pool->attrs->cpumask will be mask of CPU0).
      kworker/0:x will running on rq

sched_cpu_dying
  if (rq->nr_running != 1 || rq_has_pinned_tasks(rq))
    WARN(true, "Dying CPU not properly vacated!");
      ---------OOPS-------------

When CPUHP_HRTIMERS_PREPARE < CPU0's state < CPUHP_AP_WORKQUEUE_ONLINE,
the CPU0 still can schedule a new work, which will add a new work to
pool->worklist of a dying CPU's work pool.

> Is it a dying cpu when onlining a CPU fails?  I think balance_push
> is not set in this case when it fails at some point during online.
> But I haven't looked into the details and linked the clues.
>

Not this case, there is on onlining CPU fails log in my test log.

>
>>
>> Test branch as:
>> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tag/?h=v5.19-rc8-rt8
>>
>
> Can it only be triggered in the rt kernel?
>

I only test on rt kernel, because of I work on RT kernel now, But I
think non-rt kernel have the issues too.

>> I think this code is new enough to demonstrate that the problem persists.
>>
>> The log as fellowing:
>>
>> [ 3103.198684] ------------[ cut here ]------------
>> [ 3103.198684] Dying CPU not properly vacated!
>> [ 3103.198684] WARNING: CPU: 1 PID: 23 at kernel/sched/core.c:9575 sched_cpu_dying.cold+0xc/0xc3
>> [ 3103.198684] Modules linked in: work_test(O)
>
> Could you give me the code of this module?

The module's source code is at
https://github.com/schspa/code_snippet/blob/master/kernel_module/workqueue_test/work-test.c
Kernel defconfig is at
https://github.com/schspa/ktest/blob/main/configs/linux_rt_defconfig

I add a hook to the entry of worker_thread, which add extra 50ms delay
to make it reproduced faster.

-- 
BRs
Schspa Shi
