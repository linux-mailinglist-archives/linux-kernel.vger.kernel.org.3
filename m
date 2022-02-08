Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF8E4AD134
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiBHFmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiBHFmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:42:44 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6451C0401EA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:42:42 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a8so48864138ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 21:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfdjY9aBBma0CnIsmMEZqL/iFhu1VL7QhWdBvy2tWOs=;
        b=Tw293rtkTBumHe4m2YwdEUZRhKBg9q6u+eBcyR41AbI2FIOqk17aOd4fZVu2F43VC5
         rAqfu3sOCvZDNdjDDCpr47JG8Wstyp9UQnCB9OeSQtiClscyxavwoAyUoD5rHzJ27QWP
         CRgyw6E82Qb44lFY+66DabZTBqYH5iKh2G+b8qxIeEmy0aZz7riDyzVEXvaAFsNB/z4I
         I+L7EGn/AcgNP7qM1WW1Vb31DH+4IEJu17UPaV+fHcFsq6o/9spwOHmnXvQFyJmYR55M
         Ths9Ghv2KLkc8C770v116nfSYndAyG1DAoPVPsrHpn3dwmw4jNVZpZveTsrMjDtUJX74
         FtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfdjY9aBBma0CnIsmMEZqL/iFhu1VL7QhWdBvy2tWOs=;
        b=Kps6AJnJ4wuYsKhm3S4MnRKR1zUTMKByTgDPmyP1qRiVK76RdrsoABBW/lpVE7T3YX
         5PGfFqRlX3u12zhmuWBIcSYmh2LasKjztqKJzUdLH394yMwSZNf78TXMP5dVzyKWTsNZ
         Ly4putj2xoZPpQnlmGlaxB8+m+h7kWAG4WnQnqT6CFtaDphPS+PUdby2WqcDHP1e27nC
         eZhp8R/g8XLwdn2c7NAFNoN1/TZOL4OdoDH7dVPn5I2ODi9U2VpH2mGSHbe7L/GoWLUI
         jfe8VjsZXDfsjyzsBJPvLmngr9lT1+C3gAP75jaVapnn2ar+XYqFwaNMH9v12GjIy+wH
         PgBQ==
X-Gm-Message-State: AOAM5332Gz2ew48T4RT4JjrOB0Qjb+ZIfCMnrNb/mfOAV4E7B78gfCV2
        cy2prbe83tTbhB4Si8y3Qd4QsAZI0oDjaTv6OGg=
X-Google-Smtp-Source: ABdhPJyxIUL3YI1U/4DjrSghyS6PmQ4aLLqyMPfgNj2j0NT8+3aCRxeUU4Xiyn3snSf0cH4QPF76lXsH21d5YORN/Ls=
X-Received: by 2002:a17:907:1115:: with SMTP id qu21mr2350733ejb.192.1644298961223;
 Mon, 07 Feb 2022 21:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20220126080947.4529-1-yangyicong@hisilicon.com>
 <20220126080947.4529-3-yangyicong@hisilicon.com> <YfK9DSMFabjYm/MV@BLR-5CG11610CF.amd.com>
 <CAGsJ_4xL3tynB9P=rKMoX2otW4bMMU5Z-P9zSudMV3+fr2hpXw@mail.gmail.com>
 <20220128071337.GC618915@linux.vnet.ibm.com> <CAGsJ_4yoUONACY-j+9XxSNC0VgmdyRdHC=z87dWvZvVSASzXRQ@mail.gmail.com>
 <20220201093859.GE618915@linux.vnet.ibm.com> <CAGsJ_4z8cer7Y5si+J_=awQetFJZMVeaQ+RDSXQz9EGOPTGMQg@mail.gmail.com>
 <20220204073317.GG618915@linux.vnet.ibm.com> <CAGsJ_4xjgy3D0VzbTdmJihJ+nut_NeTEb4krh8jup4rbvTY_ww@mail.gmail.com>
 <YgE3TrBrB0psljDk@BLR-5CG11610CF.amd.com>
In-Reply-To: <YgE3TrBrB0psljDk@BLR-5CG11610CF.amd.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 8 Feb 2022 18:42:29 +1300
Message-ID: <CAGsJ_4xg6heV-0yqvcwNNEyOcrfwv3uN45YfR1Jcawys0ROrow@mail.gmail.com>
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

On Tue, Feb 8, 2022 at 4:14 AM Gautham R. Shenoy <gautham.shenoy@amd.com> wrote:
>
>
> On Fri, Feb 04, 2022 at 11:28:25PM +1300, Barry Song wrote:
>
> > > We already figured out that there are no idle CPUs in this cluster. So dont
> > > we gain performance by picking a idle CPU/core in the neighbouring cluster.
> > > If there are no idle CPU/core in the neighbouring cluster, then it does make
> > > sense to fallback on the current cluster.
> >
> > What you suggested is exactly the approach we have tried at the first beginning
> > during debugging. but we didn't gain performance according to benchmark, we
> > were actually losing. that is why we added this line to stop ping-pong:
> >          /* Don't ping-pong tasks in and out cluster frequently */
> >          if (cpus_share_resources(target, prev_cpu))
> >             return target;
> >
> > If we delete this, we are seeing a big loss of tbench while system
> > load is medium
> > and above.
>
> Thanks for clarifying this Barry. Indeed, if the workload is sensitive
> to data ping-ponging across L2 clusters, this heuristic makes sense. I
> was thinking of workloads that require lower tail latency, in which
> case exploring the larger LLC would have made more sense, assuming
> that the larger LLC has an idle core/CPU.
>
> In the absence of any hints from the workload, like something that
> Peter had previous suggested
> (https://lore.kernel.org/lkml/YVwnsrZWrnWHaoqN@hirez.programming.kicks-ass.net/),
> optimizing for cache-access seems to be the right thing to do.

Thanks, gautham.

Yep. Peter mentioned some hints like SCHED_BATCH and SCHED_IDLE.
To me, the case we are discussing seems to be more complicated than
applying some scheduling policy on separate tasks by SCHED_BATCH
or IDLE.

For example, in case we have a process, and this process has 20 threads.
thread0-9 might care about cache-coherence latency and want to avoid
ping-ponging, and thread10-thread19 might want to have tail-latency
as small as possible. So we need some way to tell kernel, "hey, bro, please
try to keep thread0-9 still as ping-ponging will hurt them while trying your
best to find idle cpu in a wider range for thread10-19". But it seems
SCHED_XXX as a scheduler policy hint can't tell kernel how to organize tasks
into groups, and is also incapable of telling kernel different groups have
different needs.

So it seems we want some special cgroups to organize tasks and we can apply
some special hints on each different group. for example, putting thread0-9
in a cgroup and thread10-19 in another, then:
1. apply "COMMUNCATION-SENSITVE" on the 1st group
2. apply "TAIL-LATENCY-SENTIVE" on the 2nd one.
I am not quite sure how to do this and if this can find its way into
the mainline.

On the other hand, for this particular patch, the most controversial
part is those
two lines to avoid ping-ponging, and I am seeing dropping this can hurt workload
like tbench only when system load is high, so I wonder if the approach[1] from
Chen Yu and Tim can somehow resolve the problem alternatively, thus we can
avoid the controversial part.
since their patch can also shrink the scanning range while llc load is high.

[1] https://lore.kernel.org/lkml/20220207034013.599214-1-yu.c.chen@intel.com/

>
>
> >
> > Thanks
> > Barry
>
> --
> Thanks and Regards
> gautham.

Thanks
Barry
