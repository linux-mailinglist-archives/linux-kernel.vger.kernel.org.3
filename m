Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E894D4A97BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbiBDK2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiBDK2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:28:39 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2CCC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 02:28:39 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id d10so17971303eje.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 02:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1CfMQMigwkGR1IB7p9uGOmMajPIHEL1bLvGuRNWUP0o=;
        b=OQsxv5Ot8uQxfCAR/0XgAbAFOYOfXvcQalH+/zizDJAXw0GNTx0cKKjJUevcmXSS0d
         myg/GBqkAXf6TUljgbmTm1yaOZSK2B8iONtK/CUOf0VxjGQWXqcb/wmcvDEWTyxhyEme
         9GRJIKhMb8A9lFbPrCGFeWEGZkWgpv/nrULXeE9YC5VfQJ0voTPtgnclZB6PDoWA/+vo
         7M6F9VHjI6guAcfma4W4t1Gsw5HUvKO4GqBetuwX0oOtYmfkE4R1/Y7hceH/bOkS2joi
         /VV1Bz6ZH3r5cWEyUhkAxaKQKE2ttK99p1yJba1szgCuDvHbZSHWdWkWLUuYKhqOzklP
         wIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1CfMQMigwkGR1IB7p9uGOmMajPIHEL1bLvGuRNWUP0o=;
        b=sEwivtc05DzA4amQr9Wk6RODiYR5KfSiSpuhDP50XE2h3IAnLdrZwVTWS1ajsaqsUr
         gWOY7BhTVB/zuq80tGU0jkc5gZJCBldgFlYk7XrlzhdgiEgRVRV/0EyBfW21iJiWnasO
         Mc9n7pwdl1y89P5/Hke7ndK2idzwWlNtU9BcgnIliRHv8hX+/+314Xw3Ky7MldP4SsZK
         ZPNhtKofxBPLqUrGkDXMk2IYaw7+y1XJ0RvnGQm8uUJwercORPYY7QkWIzMe1y4bEpKo
         JghJeFmSafp+yGOzgdTcqbXELgpwRfnwslVv7ibrwJ9oUp6zneQ/rS4IV5XOTqggp8mn
         ptkw==
X-Gm-Message-State: AOAM530ghNcmtYYfcDsCpDMNZehXbmwVqObcgBnCCKdY/AhHRY5CxR/M
        MTUs74l3vbvqB7X53SVF+vzJapjVIuD/sVL4bHRqbUETr/Y=
X-Google-Smtp-Source: ABdhPJyqLn4G+ja2SNOWqOB+DkFu07RTZUuf7D/AJjU7yON08wIUK9nyfJM+qfjBijUd9f6056AloS8Tvlo44ejTM4o=
X-Received: by 2002:a17:907:60cf:: with SMTP id hv15mr1841279ejc.702.1643970517911;
 Fri, 04 Feb 2022 02:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20220126080947.4529-1-yangyicong@hisilicon.com>
 <20220126080947.4529-3-yangyicong@hisilicon.com> <YfK9DSMFabjYm/MV@BLR-5CG11610CF.amd.com>
 <CAGsJ_4xL3tynB9P=rKMoX2otW4bMMU5Z-P9zSudMV3+fr2hpXw@mail.gmail.com>
 <20220128071337.GC618915@linux.vnet.ibm.com> <CAGsJ_4yoUONACY-j+9XxSNC0VgmdyRdHC=z87dWvZvVSASzXRQ@mail.gmail.com>
 <20220201093859.GE618915@linux.vnet.ibm.com> <CAGsJ_4z8cer7Y5si+J_=awQetFJZMVeaQ+RDSXQz9EGOPTGMQg@mail.gmail.com>
 <20220204073317.GG618915@linux.vnet.ibm.com>
In-Reply-To: <20220204073317.GG618915@linux.vnet.ibm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 4 Feb 2022 23:28:25 +1300
Message-ID: <CAGsJ_4xjgy3D0VzbTdmJihJ+nut_NeTEb4krh8jup4rbvTY_ww@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 8:33 PM Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> * Barry Song <21cnbao@gmail.com> [2022-02-02 09:20:32]:
>
> > On Tue, Feb 1, 2022 at 10:39 PM Srikar Dronamraju
> > <srikar@linux.vnet.ibm.com> wrote:
> > >
> > > * Barry Song <21cnbao@gmail.com> [2022-01-28 07:40:15]:
> > >
> > > > On Fri, Jan 28, 2022 at 8:13 PM Srikar Dronamraju
> > > > <srikar@linux.vnet.ibm.com> wrote:
> > > > >
> > > > > * Barry Song <21cnbao@gmail.com> [2022-01-28 09:21:08]:
> > > > >
> > > > > > On Fri, Jan 28, 2022 at 4:41 AM Gautham R. Shenoy
> > > > > > <gautham.shenoy@amd.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jan 26, 2022 at 04:09:47PM +0800, Yicong Yang wrote:
> > > > > > > > From: Barry Song <song.bao.hua@hisilicon.com>
> > > > > > > >
> > > > I am sorry I didn't get your question. Currently the code works as below:
> > > > if task A wakes up task B, and task A is in LLC0 and task B is in LLC1.
> > > > we will scan the cluster of A before scanning the whole LLC0, in this case,
> > > > cluster of A is the closest sibling, so it is the better choice than other CPUs
> > > > which are in LLC0 but not in the cluster of A.
> > >
> > > Yes, this is right.
> > >
> > > > But we do scan all cpus of LLC0
> > > > afterwards if we fail to find an idle CPU in the cluster.
> > >
> > > However my reading of the patch, before we can scan other clusters within
> > > the LLC (aka LLC0), we have a check in scan cluster which says
> > >
> > >         /* Don't ping-pong tasks in and out cluster frequently */
> > >         if (cpus_share_resources(target, prev_cpu))
> > >            return target;
> > >
> > > My reading of this is, ignore other clusters (at this point, we know there
> > > are no idle CPUs in this cluster. We don't know if there are idle cpus in
> > > them or not) if the previous CPU and target CPU happen to be from the same
> > > cluster. This effectively means we are given preference to cache over idle
> > > CPU.
> >
> > Note we only ignore other cluster while prev_cpu and target are in same
> > cluster. if the condition is false, we are not ignoring other cpus. typically,
> > if waker is the target, and wakee is the prev_cpu, that means if they are
> > already in one cluster, we don't stupidly spread them in select_idle_cpu() path
> > as benchmark shows we are losing. so, yes, we are giving preference to
> > cache over CPU.
>
> We already figured out that there are no idle CPUs in this cluster. So dont
> we gain performance by picking a idle CPU/core in the neighbouring cluster.
> If there are no idle CPU/core in the neighbouring cluster, then it does make
> sense to fallback on the current cluster.

What you suggested is exactly the approach we have tried at the first beginning
during debugging. but we didn't gain performance according to benchmark, we
were actually losing. that is why we added this line to stop ping-pong:
         /* Don't ping-pong tasks in and out cluster frequently */
         if (cpus_share_resources(target, prev_cpu))
            return target;

If we delete this, we are seeing a big loss of tbench while system
load is medium
and above.

>
> >
> > >
> > > Or Am I still missing something?
> > >
> > > >
> > > > After a while, if the cluster of A gets an idle CPU and pulls B into the
> > > > cluster, we prefer not pushing B out of the cluster of A again though
> > > > there might be an idle CPU outside. as benchmark shows getting an
> > > > idle CPU out of the cluster of A doesn't bring performance improvement
> > > > but performance decreases as B might be getting in and getting out
> > > > the cluster of A very frequently, then cache coherence ping-pong.
> > > >
> > >
> > > The counter argument can be that Task A and Task B are related and were
> > > running on the same cluster. But Load balancer moved Task B to a different
> > > cluster. Now this check may cause them to continue to run on two different
> > > clusters, even though the underlying load balance issues may have changed.
> > >
> > > No?
> >
> > LB is much slower than select_idle_cpu().  select_idle_cpu() can dynamically
> > work afterwards. so it is always a dynamic balance and task migration.
> >
> > >
> > >
> > > --
> > > Thanks and Regards
> > > Srikar Dronamraju
> >
> > Thanks
> > Barry
>
> --

Thanks
Barry
