Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3C54EDE95
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbiCaQTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239777AbiCaQTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:19:30 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E9C8EB6A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:17:39 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d5so34255lfj.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XvOQiTxrSkDE1O7y9Nnnhxp/qhEKorlXOf3Z2Rjc3+Q=;
        b=CZq9cQspPXzmbUE3s0DkhpzbWQVXdbi4fuiFGL/Rh1tDQAnwJyVsKM9eAOr6KeA1uO
         aOeP7VLuYzWXOEwFRT0SsN6v8ebYrzVDnNxrMOd01NivrLK1Qj5XvXBjOlC2C6aNYJeJ
         5MUbI9z6Hq+EQw9f4gGnzjHBBkGhRnKrDhI1ea3iUic6u47BOcIoQu/4pTiLacnwUwSZ
         J7kyUBgSujvFh9L2V6EHJ+PPMmyFHgwcwwZnwQmYkieJ3+qzdSQGIh8roiTz40uYXhbw
         YbppkGon0l+pxrP7ET43mtovPVI48DUqTkmnKFQ0hL5RJlenajcti6B2Q7Z8ha6QH3iX
         UPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XvOQiTxrSkDE1O7y9Nnnhxp/qhEKorlXOf3Z2Rjc3+Q=;
        b=3Sa4AYG8nSDgbl8PLf8mMZIxh+tYOlRVglC3zqcl1jhAw5Sc5PeJtl88TpKgAtmpw7
         WJ+o+220geJhhzXO40k3f/Grp/9fm6534wrLTThZUXlihuScVAPj38LlzJqX9C3yMeFX
         pgkdJTywS5J/hyA7+G07MBGdfwJ/WJZLeC/54flpg/n2/mxXEJKjaTyWb2nhpSwmd6n1
         +CBkWHHthC3MpG9dzwAo9K+jfD8vhlBtRU9CLFw27eUaeD5ja/G0bBGGDVCJZZMaoXhM
         rMOeU8kzHStQlwQHij/jtG+BgfCxGKs/+YJvRu57Z9tKBQ4o+5vc48L6qw5/ckhbSwqD
         MZiA==
X-Gm-Message-State: AOAM533/+pTtBQDRyuwl85r7+0A/kpyBLZaMi6dFPVjh2uEtB58Pq4pM
        F6UuYBi7tGTpKwmmvC/TUH4ZnqYlS+PQPm2RlAgJRA==
X-Google-Smtp-Source: ABdhPJwd4NdUxu5fCQXYydDZqM5jgGL7W8viaSPnRdGR9bff6fLWNRVHPMfv8oQIBMHP2xcRv0IXEfqLNgkt3iwstSc=
X-Received: by 2002:a05:6512:6cf:b0:44a:25d1:a27 with SMTP id
 u15-20020a05651206cf00b0044a25d10a27mr11152267lff.18.1648743457998; Thu, 31
 Mar 2022 09:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220204141941.GE4077@xsang-OptiPlex-9020> <CADjb_WT0fcP2QBjYpsCAJEcVYWKNw1rQ6XZNz33i+KCbD8jB-A@mail.gmail.com>
In-Reply-To: <CADjb_WT0fcP2QBjYpsCAJEcVYWKNw1rQ6XZNz33i+KCbD8jB-A@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 31 Mar 2022 18:17:26 +0200
Message-ID: <CAKfTPtDFhORUyOfqr==ZrOSgBd8=vzvYgWMxw87bvq3pQmq7DQ@mail.gmail.com>
Subject: Re: [sched/pelt] 2d02fa8cc2: stress-ng.pipeherd.ops_per_sec -9.7% regression
To:     Chen Yu <yu.chen.surf@gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 at 16:19, Chen Yu <yu.chen.surf@gmail.com> wrote:
>
> Hi Vincent,
>
> On Wed, Feb 9, 2022 at 1:17 PM kernel test robot <oliver.sang@intel.com> =
wrote:
> >
> >
> >
> > Greeting,
> >
> > FYI, we noticed a -9.7% regression of stress-ng.pipeherd.ops_per_sec du=
e to commit:
> >
> >
> > commit: 2d02fa8cc21a93da35cfba462bf8ab87bf2db651 ("sched/pelt: Relax th=
e sync of load_sum with load_avg")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > in testcase: stress-ng
> > on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 C=
PU @ 2.60GHz with 128G memory
> > with following parameters:
> >
> >         nr_threads: 100%
> >         testtime: 60s
> >         class: memory
> >         test: pipeherd
> >         cpufreq_governor: performance
> >         ucode: 0xd000280
> >
> This week we have re-run the test result and it seems that this
> regression is still there.
> As we are evaluating whether this report is valid or if the
> downgrading is expected, appreciated
> if you could give suggestion on further steps:
>
> 1.  If I understand correctly,
> 2d02fa8cc21a93da35cfba462bf8ab87bf2db651 ("sched/pelt: Relax the sync
> of load_sum with load_avg")
>      fixed the calculating of  load_sum.  Before this patch  the
> contribution part would be 'skipped' and caused the load_sum
>      to be lower than expected.

Yes, you understand it correctly

> 2. If above is true, after this patch, the load_sum becomes higher. Is
> there a scenario that higher load_sum added to 1 cfs_rq brings
>     more imbalance between this group and other sched_group, thus
> brings more task migration/wake up? (because in below perf result,
>     it seems that, with this patch applied, there are slightly more
> take wake up)

This change should not impact load balance as it only does comparison
and I expect the load increase to happen on all cfs rq.
The only place that could be impacted, would be wake_affine_weight()
because it removes task load from previous cfs rq load before
comparing.
The task's load was not impacted by the underestimate which means that
the load of prev cfs  might be seen lower than current cfs after
subtracting the task's load whereas both cfs rqs were similarly
underestimated.
Now the load of prev cfs rq is not underestimated and becomes
comparable or slightly higher than the current cfs and the task
migrate on current cfs instead of staying on prev one at wakeup

One possible test would be to run the test with WA_WEIGHT features
disable and check if there is still a difference

> 3.  Consider the 9.7% downgrading is not that high,  do you think if
> lkp team should continue track this issue or just close it
>     as documented?
>
> Best,
> Yu
> >
> > commit:
> >   95246d1ec8 ("sched/pelt: Relax the sync of runnable_sum with runnable=
_avg")
> >   2d02fa8cc2 ("sched/pelt: Relax the sync of load_sum with load_avg")
> >
> > 95246d1ec80b8d19 2d02fa8cc21a93da35cfba462bf
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >       0.21           +11.0%       0.24 =C4=85  2%  stress-ng.pipeherd.c=
ontext_switches_per_bogo_op
> >  3.869e+09            -9.7%  3.494e+09        stress-ng.pipeherd.ops
> >   64412021            -9.7%   58171101        stress-ng.pipeherd.ops_pe=
r_sec
> >     442.37            -7.2%     410.54        stress-ng.time.user_time
> >       5.49 =C4=85  2%      -0.5        4.94 =C4=85  4%  mpstat.cpu.all.=
usr%
> >      80705 =C4=85  7%     +26.7%     102266 =C4=85 17%  numa-meminfo.no=
de1.Active
> >      80705 =C4=85  7%     +26.7%     102266 =C4=85 17%  numa-meminfo.no=
de1.Active(anon)
> >      12324 =C4=85  3%     -22.1%       9603 =C4=85 25%  softirqs.CPU106=
.RCU
> >      12703 =C4=85  4%     -23.1%       9769 =C4=85 24%  softirqs.CPU27.=
RCU
> >      15.96            +1.0       16.95        perf-profile.calltrace.cy=
cles-pp.prepare_to_wait_event.pipe_read.new_sync_read.vfs_read.ksys_read
> >       6.67            +1.0        7.68 =C4=85  2%  perf-profile.calltra=
ce.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_w=
ake_function.__wake_up_common
> >       6.77            +1.0        7.79 =C4=85  2%  perf-profile.calltra=
ce.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wak=
e_up_common.__wake_up_common_lock
> >      14.46            +1.0       15.48 =C4=85  2%  perf-profile.calltra=
ce.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.new_syn=
c_read.vfs_read
> >      13.73            +1.1       14.79 =C4=85  2%  perf-profile.calltra=
ce.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepar=
e_to_wait_event.pipe_read.new_sync_read
> >      26.95            +1.4       28.34        perf-profile.calltrace.cy=
cles-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write.ksys_writ=
e
> >      25.85            +1.5       27.32        perf-profile.calltrace.cy=
cles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write.vf=
s_write
> >      25.18            +1.5       26.69        perf-profile.calltrace.cy=
cles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pip=
e_write.new_sync_write
> >      24.61            +1.5       26.14        perf-profile.calltrace.cy=
cles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_=
common_lock.pipe_write
