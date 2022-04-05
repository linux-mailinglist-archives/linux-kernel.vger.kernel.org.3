Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7813D4F49E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452114AbiDEWbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447712AbiDEPrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:47:00 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608506D859
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:23:00 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id e22so10107033qvf.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xx5gx4w8t+oU2Q+J4ryYbmDk+89cyoetlo+Bnhy1LeA=;
        b=XkQOGiMXUsF9TPZWicv0RgI67aXGcwzDuR9xtcZWsvoYq+yAH2ZHCogzF3SxjuN5QD
         rraHJXEiK3FnmnKcW9NptiU2y1wr/TjKPtGcUOFI+L5LZAWelHgtaz45UVop5r/JAkNi
         J8qZAgKbYH2kwlgA39dYC3IEMG+xD7qnx/NEahsP023HFetZFn0qEH0F3gxVTuzITUhR
         dpmAVfZGU7UHhyfL28tQla2r4kKAhQX9z6fG++y9fy507N0bcmXqissXvVlQCp93y8+s
         db4xZSwSMgEde5OzPmmNNquSnRhwrAaIgJC3jD0Yn3lsDpJx9CaiP16K6En9uy8Ah6de
         kLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xx5gx4w8t+oU2Q+J4ryYbmDk+89cyoetlo+Bnhy1LeA=;
        b=MIZ1kALQMMRc3nYqgjQXPZgtVcHusHsw+RBpdlQitG0O3UKD4GFUy+oNV+ug8KmoKG
         uf2BO1Aa/5ZPN2onvfTfV9ziJamql1nXWL5QKREICj/sdF8/y42lS8ORpAvWe2ZvaLrc
         O7brNMB9Wk2cD/y8KSBlNRaMwDTffZW3GVxZhPRiyZAKYLxFod7uc/XkGGPqBMmYayJh
         CbSX+sattCxmaDwYUUQ507RUtuqMeXx/Vi7xkhU9ZiZqrPI6VgIiKX2IY1b5hZetKs9d
         E0qQsvGEIvxHmK08C5uyrkwVvplUZuFGJiMzSlj3cts3hw+IgYwraTVQi9RDprh+9mHp
         c1/Q==
X-Gm-Message-State: AOAM531epWkY8gJl1sVri4JcYKH9yBoSgdswiIovW2R6GXAGUUYAIj52
        72pxO0pMBoJCLpGxhYk1EMquJyAuZYZKsUQfdcc=
X-Google-Smtp-Source: ABdhPJzWofIeL2fzxXAz4gQ4L/CV/ZE2lnO8gUjfX13b5ZrfmZSF/iWAdMeGQzsfqMkGAfJV1YvBvTlXAfHBs5jTmMM=
X-Received: by 2002:ad4:5f4b:0:b0:441:4d40:f8d2 with SMTP id
 p11-20020ad45f4b000000b004414d40f8d2mr2883511qvg.33.1649168579428; Tue, 05
 Apr 2022 07:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220204141941.GE4077@xsang-OptiPlex-9020> <CADjb_WT0fcP2QBjYpsCAJEcVYWKNw1rQ6XZNz33i+KCbD8jB-A@mail.gmail.com>
 <CAKfTPtDFhORUyOfqr==ZrOSgBd8=vzvYgWMxw87bvq3pQmq7DQ@mail.gmail.com>
 <CADjb_WQL7ZTSrThgFHtoF2apwwqio8wgwGYmCOq9LBfamo3D0Q@mail.gmail.com> <CAKfTPtBEcbiqaOjY9jEAWoJH5VSixunQ_r6DcDHcp2cej9QFVA@mail.gmail.com>
In-Reply-To: <CAKfTPtBEcbiqaOjY9jEAWoJH5VSixunQ_r6DcDHcp2cej9QFVA@mail.gmail.com>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Tue, 5 Apr 2022 22:22:48 +0800
Message-ID: <CADjb_WRbm3pt9kqhPKhTRSAcJFt1whaKw2MMMyYzkdW=rDXFdA@mail.gmail.com>
Subject: Re: [sched/pelt] 2d02fa8cc2: stress-ng.pipeherd.ops_per_sec -9.7% regression
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        0day robot <lkp@intel.com>, Huang Ying <ying.huang@intel.com>,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Aubrey Li <aubrey.li@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>, tim.c.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 5:53 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 1 Apr 2022 at 20:32, Chen Yu <yu.chen.surf@gmail.com> wrote:
> >
> > On Fri, Apr 1, 2022 at 12:17 AM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Thu, 31 Mar 2022 at 16:19, Chen Yu <yu.chen.surf@gmail.com> wrote:
> > > >
> > > > Hi Vincent,
> > > >
> > > > On Wed, Feb 9, 2022 at 1:17 PM kernel test robot <oliver.sang@intel.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > Greeting,
> > > > >
> > > > > FYI, we noticed a -9.7% regression of stress-ng.pipeherd.ops_per_sec due to commit:
> > > > >
> > > > >
> > > > > commit: 2d02fa8cc21a93da35cfba462bf8ab87bf2db651 ("sched/pelt: Relax the sync of load_sum with load_avg")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > >
> > > > > in testcase: stress-ng
> > > > > on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
> > > > > with following parameters:
> > > > >
> > > > >         nr_threads: 100%
> > > > >         testtime: 60s
> > > > >         class: memory
> > > > >         test: pipeherd
> > > > >         cpufreq_governor: performance
> > > > >         ucode: 0xd000280
> > > > >
> > > > This week we have re-run the test result and it seems that this
> > > > regression is still there.
> > > > As we are evaluating whether this report is valid or if the
> > > > downgrading is expected, appreciated
> > > > if you could give suggestion on further steps:
> > > >
> > > > 1.  If I understand correctly,
> > > > 2d02fa8cc21a93da35cfba462bf8ab87bf2db651 ("sched/pelt: Relax the sync
> > > > of load_sum with load_avg")
> > > >      fixed the calculating of  load_sum.  Before this patch  the
> > > > contribution part would be 'skipped' and caused the load_sum
> > > >      to be lower than expected.
> > >
> > > Yes, you understand it correctly
> > >
> > > > 2. If above is true, after this patch, the load_sum becomes higher. Is
> > > > there a scenario that higher load_sum added to 1 cfs_rq brings
> > > >     more imbalance between this group and other sched_group, thus
> > > > brings more task migration/wake up? (because in below perf result,
> > > >     it seems that, with this patch applied, there are slightly more
> > > > take wake up)
> > >
> > > This change should not impact load balance as it only does comparison
> > > and I expect the load increase to happen on all cfs rq.
> > > The only place that could be impacted, would be wake_affine_weight()
> > > because it removes task load from previous cfs rq load before
> > > comparing.
> > > The task's load was not impacted by the underestimate which means that
> > > the load of prev cfs  might be seen lower than current cfs after
> > > subtracting the task's load whereas both cfs rqs were similarly
> > > underestimated.
> > > Now the load of prev cfs rq is not underestimated and becomes
> > > comparable or slightly higher than the current cfs and the task
> > > migrate on current cfs instead of staying on prev one at wakeup
> > >
> > Could you please elaborate a little more on this scenario, since both current
> > and previous cfs rqs were underestimated, how could previous cfs rq has
> > lower load than the current one before applying this patch?
> >
> > Say, suppose the previous cfs rq has a load of L1, and current cfs rq has
> > a load of L2, the waken task has a load of h, then wake_affine_weight()
> > compares L1 - h  with L2 + h ,  when L1 < L2 + 2h, the task will remain on
> > previous CPU.  Since L1 and L2 were underestimated in the same scale,
> > I'm not quite sure how this patch would affect the choice between
> > prev and current CPU.
>
> Let's take the example of  this_cpu load L1 = 0 and prev_cpu load L2 =
> 2h'+d. h' reflects h in the cpu load and d is a small delta load. The
> task will migrate if we have the condition below:
>
>     h < 2h'-h+d
>
> With this patch, we assume that h' == h as we don't underestimate the
> load of cfs rqs anymore. The condition for migrating the task is :
>     h < h+d
> And the task will migrate on this cpu as soon as there is a small load
> on prev_cpu in addition to the 2h.
>
> Without the patch, the load of cfs_rqs are underestimated which means
> that the task's load is underestimated in the cfs rq. This can be
> described as h'  == h-U. U being the underestimated part. In this case
> the condition to migrate the task becomes:
>     h < h-2U+d
> The task will migrate on this cpu is d is large enough to compensate
> the underestimation so we will migrate less often
>
I see. Thanks for this example! So in this scenario when previous CPU
has some higher load than the current CPU, without this patch applied,
the OS would have more chances to keep the task on the previous CPU,
thus less migration and less rq lock contention(according to the perf result).
I don't have a good idea in mind on how to deal with this case, except that
by disabling WA_WEIGHT or WA_BIAS(prefer 'this' CPU I suppose).

--
Thanks,
Chenyu
