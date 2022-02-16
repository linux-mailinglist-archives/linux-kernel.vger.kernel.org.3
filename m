Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8394B83C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiBPJNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:13:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiBPJNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:13:09 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8F01EEF2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:12:54 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id c6so4112237ybk.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FAATwtUo+tcRU4ypGqZNcgc4PswNwsO76knsZ3DsUT0=;
        b=masBcKTzXJW8jGb1hRyXvUqhC4QxlixbN2fFjdHvjfdSxAOp4qDogAi9MQW4t1G1gw
         2P0rzjowFHh1GDBRaHcVyEeoeU1TSBOyKzj00pZSK1QtP4TYtIwZF7jEWhQl1cUdz6AM
         zaptp41NSoc3Eoqeyv3C0cgNM/L2gbsVdR2nvDGo5iLrJZ2yXoiW8JITosED1yRQGrd4
         vxYvLQjEnbKqTga70EhF2s8g1k1pe0ow0pi2+fjFQsn6vBFYXHaWdeJUowJA1yLxA23L
         yjWa11EjbXPffBypYto85zI44BDxquwatoSP0bREkOrmKSSVqKiCtxT6P1u8zU7RiinN
         BT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FAATwtUo+tcRU4ypGqZNcgc4PswNwsO76knsZ3DsUT0=;
        b=zP2Xt0DZ1kpJF9gzajm8Jl6Mq+6sCzFUs0r5gwViMuDjrmYf48Y6LTiTpyVreodUHA
         0cwYUuRRHNFB7z0z7aMf6PMg3iRSG4f9c4YbaAXposb0Ocjktkws7EW84LUgpsOQ0RvE
         E5Q+Efd8P+h7hkBYQp4+hStzEal6AZQar6WjH66f/laUIhJ04XkQ0yBzbocb7h2Gkm0t
         O+Vafudmo/epsnBX1SkZA6EBIaJjo3b5oS5IqnPMqAEKiJjgZmOJj3ykg9orCc5XgTU6
         cR+25I7Zr9DAUE62WO9+Wcc8t/dKjrN5xETfy+/4030wYEKhs+KKoECOmKp8Hjperk4X
         uZvA==
X-Gm-Message-State: AOAM5323/b9ZNUy3yNS1ed+a8970G1zhf2hNWIYL3kncTdYNFDHw9tHA
        V8wwnXhhhp/BqxPxtn+SibHsyVgEOvTW8+Zs+Ts=
X-Google-Smtp-Source: ABdhPJyEs3B71tLo0LBZx6EVsSJkTMYURLRnFZMfUey7UVslKnLuqSwDMDssqHoPwahAvUymxFLTgPL/T9U+U1EHqRQ=
X-Received: by 2002:a25:bd14:0:b0:61d:87ce:8b6c with SMTP id
 f20-20020a25bd14000000b0061d87ce8b6cmr1264452ybk.690.1645002773725; Wed, 16
 Feb 2022 01:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20220126080947.4529-1-yangyicong@hisilicon.com>
 <20220126080947.4529-3-yangyicong@hisilicon.com> <YfK9DSMFabjYm/MV@BLR-5CG11610CF.amd.com>
 <CAGsJ_4xL3tynB9P=rKMoX2otW4bMMU5Z-P9zSudMV3+fr2hpXw@mail.gmail.com>
 <20220128071337.GC618915@linux.vnet.ibm.com> <CAGsJ_4yoUONACY-j+9XxSNC0VgmdyRdHC=z87dWvZvVSASzXRQ@mail.gmail.com>
 <20220201093859.GE618915@linux.vnet.ibm.com> <CAGsJ_4z8cer7Y5si+J_=awQetFJZMVeaQ+RDSXQz9EGOPTGMQg@mail.gmail.com>
 <20220204073317.GG618915@linux.vnet.ibm.com> <CAGsJ_4xjgy3D0VzbTdmJihJ+nut_NeTEb4krh8jup4rbvTY_ww@mail.gmail.com>
 <YgE3TrBrB0psljDk@BLR-5CG11610CF.amd.com> <CAGsJ_4xg6heV-0yqvcwNNEyOcrfwv3uN45YfR1Jcawys0ROrow@mail.gmail.com>
In-Reply-To: <CAGsJ_4xg6heV-0yqvcwNNEyOcrfwv3uN45YfR1Jcawys0ROrow@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 16 Feb 2022 22:12:42 +1300
Message-ID: <CAGsJ_4z-YxcPytzmGViRzEueL1F7HEE4OEuezvDg6TvEs1HJEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        prime.zeng@huawei.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        ego@linux.vnet.ibm.com, Linuxarm <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>
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

On Tue, Feb 8, 2022 at 6:42 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Tue, Feb 8, 2022 at 4:14 AM Gautham R. Shenoy <gautham.shenoy@amd.com> wrote:
> >
> >
> > On Fri, Feb 04, 2022 at 11:28:25PM +1300, Barry Song wrote:
> >
> > > > We already figured out that there are no idle CPUs in this cluster. So dont
> > > > we gain performance by picking a idle CPU/core in the neighbouring cluster.
> > > > If there are no idle CPU/core in the neighbouring cluster, then it does make
> > > > sense to fallback on the current cluster.
> > >
> > > What you suggested is exactly the approach we have tried at the first beginning
> > > during debugging. but we didn't gain performance according to benchmark, we
> > > were actually losing. that is why we added this line to stop ping-pong:
> > >          /* Don't ping-pong tasks in and out cluster frequently */
> > >          if (cpus_share_resources(target, prev_cpu))
> > >             return target;
> > >
> > > If we delete this, we are seeing a big loss of tbench while system
> > > load is medium
> > > and above.
> >
> > Thanks for clarifying this Barry. Indeed, if the workload is sensitive
> > to data ping-ponging across L2 clusters, this heuristic makes sense. I
> > was thinking of workloads that require lower tail latency, in which
> > case exploring the larger LLC would have made more sense, assuming
> > that the larger LLC has an idle core/CPU.
> >
> > In the absence of any hints from the workload, like something that
> > Peter had previous suggested
> > (https://lore.kernel.org/lkml/YVwnsrZWrnWHaoqN@hirez.programming.kicks-ass.net/),
> > optimizing for cache-access seems to be the right thing to do.
>
> Thanks, gautham.
>
> Yep. Peter mentioned some hints like SCHED_BATCH and SCHED_IDLE.
> To me, the case we are discussing seems to be more complicated than
> applying some scheduling policy on separate tasks by SCHED_BATCH
> or IDLE.
>
> For example, in case we have a process, and this process has 20 threads.
> thread0-9 might care about cache-coherence latency and want to avoid
> ping-ponging, and thread10-thread19 might want to have tail-latency
> as small as possible. So we need some way to tell kernel, "hey, bro, please
> try to keep thread0-9 still as ping-ponging will hurt them while trying your
> best to find idle cpu in a wider range for thread10-19". But it seems
> SCHED_XXX as a scheduler policy hint can't tell kernel how to organize tasks
> into groups, and is also incapable of telling kernel different groups have
> different needs.
>
> So it seems we want some special cgroups to organize tasks and we can apply
> some special hints on each different group. for example, putting thread0-9
> in a cgroup and thread10-19 in another, then:
> 1. apply "COMMUNCATION-SENSITVE" on the 1st group
> 2. apply "TAIL-LATENCY-SENTIVE" on the 2nd one.
> I am not quite sure how to do this and if this can find its way into
> the mainline.
>
> On the other hand, for this particular patch, the most controversial
> part is those
> two lines to avoid ping-ponging, and I am seeing dropping this can hurt workload
> like tbench only when system load is high, so I wonder if the approach[1] from
> Chen Yu and Tim can somehow resolve the problem alternatively, thus we can
> avoid the controversial part.
> since their patch can also shrink the scanning range while llc load is high.
>
> [1] https://lore.kernel.org/lkml/20220207034013.599214-1-yu.c.chen@intel.com/

Yicong's testing shows the patch from Chen Yu and Tim can somehow resolve the
problem and make sure there is no performance regression for tbench
while load is
high after we remove the code to avoid ping-pong:

5.17-rc1: vanilla
rc1 + chenyu: vanilla + chenyu's LLC overload patch
rc1+chenyu+cls: vanilla + chenyu's  patch + my this patchset
rc1+chenyu+cls-pingpong: vanilla + chenyu's patch + my this patchset -
the code avoiding ping-pong
rc1+cls: vanilla + my this patchset

tbench running on numa 0 &1:
                            5.17-rc1          rc1 + chenyu
rc1+chenyu+cls     rc1+chenyu+cls-pingpong  rc1+cls
Hmean     1        320.01 (   0.00%)      318.03 *  -0.62%*
357.15 *  11.61%*      375.43 *  17.32%*      378.44 *  18.26%*
Hmean     2        643.85 (   0.00%)      637.74 *  -0.95%*
714.36 *  10.95%*      745.82 *  15.84%*      752.52 *  16.88%*
Hmean     4       1287.36 (   0.00%)     1285.20 *  -0.17%*
1431.35 *  11.18%*     1481.71 *  15.10%*     1505.62 *  16.95%*
Hmean     8       2564.60 (   0.00%)     2551.02 *  -0.53%*
2812.74 *   9.68%*     2921.51 *  13.92%*     2955.29 *  15.23%*
Hmean     16      5195.69 (   0.00%)     5163.39 *  -0.62%*
5583.28 *   7.46%*     5726.08 *  10.21%*     5814.74 *  11.91%*
Hmean     32      9769.16 (   0.00%)     9815.63 *   0.48%*
10518.35 *   7.67%*    10852.89 *  11.09%*    10872.63 *  11.30%*
Hmean     64     15952.50 (   0.00%)    15780.41 *  -1.08%*
10608.36 * -33.50%*    17503.42 *   9.72%*    17281.98 *   8.33%*
Hmean     128    13113.77 (   0.00%)    12000.12 *  -8.49%*
13095.50 *  -0.14%*    13991.90 *   6.70%*    13895.20 *   5.96%*
Hmean     256    10997.59 (   0.00%)    12229.20 *  11.20%*
11902.60 *   8.23%*    12214.29 *  11.06%*    11244.69 *   2.25%*
Hmean     512    14623.60 (   0.00%)    15863.25 *   8.48%*
14103.38 *  -3.56%*    16422.56 *  12.30%*    15526.25 *   6.17%*

tbench running on numa 0 only:

                            5.17-rc1          rc1 + chenyu
rc1+chenyu+cls     rc1+chenyu+cls-pingpong   rc1+cls
Hmean     1        324.73 (   0.00%)      330.96 *   1.92%*
358.97 *  10.54%*      376.05 *  15.80%*      378.01 *  16.41%*
Hmean     2        645.36 (   0.00%)      643.13 *  -0.35%*
710.78 *  10.14%*      744.34 *  15.34%*      754.63 *  16.93%*
Hmean     4       1302.09 (   0.00%)     1297.11 *  -0.38%*
1425.22 *   9.46%*     1484.92 *  14.04%*     1507.54 *  15.78%*
Hmean     8       2612.03 (   0.00%)     2623.60 *   0.44%*
2843.15 *   8.85%*     2937.81 *  12.47%*     2982.57 *  14.19%*
Hmean     16      5307.12 (   0.00%)     5304.14 *  -0.06%*
5610.46 *   5.72%*     5763.24 *   8.59%*     5886.66 *  10.92%*
Hmean     32      9354.22 (   0.00%)     9738.21 *   4.11%*
9360.21 *   0.06%*     9699.05 *   3.69%*     9908.13 *   5.92%*
Hmean     64      7240.35 (   0.00%)     7210.75 *  -0.41%*
6992.70 *  -3.42%*     7321.52 *   1.12%*     7278.78 *   0.53%*
Hmean     128     6186.40 (   0.00%)     6314.89 *   2.08%*
6166.44 *  -0.32%*     6279.85 *   1.51%*     6187.85 (   0.02%)
Hmean     256     9231.40 (   0.00%)     9469.26 *   2.58%*
9134.42 *  -1.05%*     9322.88 *   0.99%*     9448.61 *   2.35%*
Hmean     512     8907.13 (   0.00%)     9130.46 *   2.51%*
9023.87 *   1.31%*     9276.19 *   4.14%*     9397.22 *   5.50%*

as you can see rc1+chenyu+cls-pingpong still shows similar improvement
like rc1+cls, in some
cases(256, 512 threads on numa0&1), it is even much better.

Thanks
Barry
