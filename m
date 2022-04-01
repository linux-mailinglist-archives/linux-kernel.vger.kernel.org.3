Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9866E4EF9E6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351178AbiDASew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351110AbiDASes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:34:48 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA781E3E09
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:32:58 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id b18so2856028qtk.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QdjP5eL6wqVuYQFvSLjoK/gyvy1RDHKnZfpcdl7Aqog=;
        b=Xk+z9kd8y8iy0gPnYL82eIlVzg1YWbqowgyeJYK1RWneZ8wxKrAhzHLrblzf3Gv9bq
         0le9uM6JCN6CUd4ljTb6gjazJbv8gjql1KO5u4SF6e52mVTzy++DJR3JzF1RWXc5JA59
         OohSXg18kCDVjZKk52WMHb4u7Qkwu0xee4KJ70MWVNxaNXuiYqRLX+AiagO2g22FAg4E
         4cHewUHJF+fibyOBLAY2BgiNUmqep2MgZRSyq9znHCafGo6p5L87ApR2IWdtu4MTiIjt
         +YFHqMLvX7kCZogMeF1wnvgNF80Nip3IBbIM4Uc7o+ebYOGReRa+riSU/vY4l+xnx0NC
         vIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdjP5eL6wqVuYQFvSLjoK/gyvy1RDHKnZfpcdl7Aqog=;
        b=izelk4Z0lrXRTYoNNe20E/qY2KVz+Wz4sePxLlMrziz3JlJEBppCt99lgvTKT0CAoH
         MBYU800xGvAFzRLsdoZv0fQLNoJlGW/0F4TIKDC8k7XtfzAgMgn9wBofxSU4U2W1r+94
         kqv38T2xjSD1pVtqnTkeFv4D3mNBJvbcftYQXLIAMfXT4yoDMQ7gKAoBoQCcBLyXF3kA
         Ixn0DPYjl4rf3qdd6raqrbB3j3V2bh5GGHQ27TI0szn2ExRpThEuRmq7lEwI/LpMfnZE
         1J05EOBBJa0Ib7bpUbsFjZ8ejbhE5JbG+H5kU0IKTBrtQFMj0cWnjsKQXgAFB4nVim4c
         PBdQ==
X-Gm-Message-State: AOAM532eOYBa2bA2F/BwUtRzV48p979Cjsy1ucH3Xn4E6f3DnpzhMLtv
        dK/aEHQkMEKRzYvykdB3aVhtsNOQ+qQWYpYOOog=
X-Google-Smtp-Source: ABdhPJwqKiqybx8STxtQEqOy7DxjjtVzt3uK6DRMy/5/jLT7e109dkp5DFvQgDdtqluFDmUUFohK+MDCvEo6/Oo+wCY=
X-Received: by 2002:a05:622a:594:b0:2e1:d59e:68ed with SMTP id
 c20-20020a05622a059400b002e1d59e68edmr9605953qtb.204.1648837977164; Fri, 01
 Apr 2022 11:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220204141941.GE4077@xsang-OptiPlex-9020> <CADjb_WT0fcP2QBjYpsCAJEcVYWKNw1rQ6XZNz33i+KCbD8jB-A@mail.gmail.com>
 <CAKfTPtDFhORUyOfqr==ZrOSgBd8=vzvYgWMxw87bvq3pQmq7DQ@mail.gmail.com>
In-Reply-To: <CAKfTPtDFhORUyOfqr==ZrOSgBd8=vzvYgWMxw87bvq3pQmq7DQ@mail.gmail.com>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Sat, 2 Apr 2022 02:32:45 +0800
Message-ID: <CADjb_WQL7ZTSrThgFHtoF2apwwqio8wgwGYmCOq9LBfamo3D0Q@mail.gmail.com>
Subject: Re: [sched/pelt] 2d02fa8cc2: stress-ng.pipeherd.ops_per_sec -9.7% regression
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, Huang Ying <ying.huang@intel.com>,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Aubrey Li <aubrey.li@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
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

On Fri, Apr 1, 2022 at 12:17 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 31 Mar 2022 at 16:19, Chen Yu <yu.chen.surf@gmail.com> wrote:
> >
> > Hi Vincent,
> >
> > On Wed, Feb 9, 2022 at 1:17 PM kernel test robot <oliver.sang@intel.com> wrote:
> > >
> > >
> > >
> > > Greeting,
> > >
> > > FYI, we noticed a -9.7% regression of stress-ng.pipeherd.ops_per_sec due to commit:
> > >
> > >
> > > commit: 2d02fa8cc21a93da35cfba462bf8ab87bf2db651 ("sched/pelt: Relax the sync of load_sum with load_avg")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > >
> > > in testcase: stress-ng
> > > on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
> > > with following parameters:
> > >
> > >         nr_threads: 100%
> > >         testtime: 60s
> > >         class: memory
> > >         test: pipeherd
> > >         cpufreq_governor: performance
> > >         ucode: 0xd000280
> > >
> > This week we have re-run the test result and it seems that this
> > regression is still there.
> > As we are evaluating whether this report is valid or if the
> > downgrading is expected, appreciated
> > if you could give suggestion on further steps:
> >
> > 1.  If I understand correctly,
> > 2d02fa8cc21a93da35cfba462bf8ab87bf2db651 ("sched/pelt: Relax the sync
> > of load_sum with load_avg")
> >      fixed the calculating of  load_sum.  Before this patch  the
> > contribution part would be 'skipped' and caused the load_sum
> >      to be lower than expected.
>
> Yes, you understand it correctly
>
> > 2. If above is true, after this patch, the load_sum becomes higher. Is
> > there a scenario that higher load_sum added to 1 cfs_rq brings
> >     more imbalance between this group and other sched_group, thus
> > brings more task migration/wake up? (because in below perf result,
> >     it seems that, with this patch applied, there are slightly more
> > take wake up)
>
> This change should not impact load balance as it only does comparison
> and I expect the load increase to happen on all cfs rq.
> The only place that could be impacted, would be wake_affine_weight()
> because it removes task load from previous cfs rq load before
> comparing.
> The task's load was not impacted by the underestimate which means that
> the load of prev cfs  might be seen lower than current cfs after
> subtracting the task's load whereas both cfs rqs were similarly
> underestimated.
> Now the load of prev cfs rq is not underestimated and becomes
> comparable or slightly higher than the current cfs and the task
> migrate on current cfs instead of staying on prev one at wakeup
>
Could you please elaborate a little more on this scenario, since both current
and previous cfs rqs were underestimated, how could previous cfs rq has
lower load than the current one before applying this patch?

Say, suppose the previous cfs rq has a load of L1, and current cfs rq has
a load of L2, the waken task has a load of h, then wake_affine_weight()
compares L1 - h  with L2 + h ,  when L1 < L2 + 2h, the task will remain on
previous CPU.  Since L1 and L2 were underestimated in the same scale,
I'm not quite sure how this patch would affect the choice between
prev and current CPU.
> One possible test would be to run the test with WA_WEIGHT features
> disable and check if there is still a difference
>
Yes, after disabling WA_WEIGHT, the performance came back.
The following score is the output of stress-ng.pipeherd.ops_per_sec

WA_WEIGHT                 yes                        no
-------------------
patched
        yes                      58069733.01          69940547.7*
        no                        64591593.69          73503396.9

-- 
Thanks,
Chenyu
