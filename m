Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C772F4F14E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345688AbiDDMeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343745AbiDDMeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:34:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725E82529A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:32:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h7so16999336lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 05:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j6h9thN+7oY5ueLRnZbtIPPTXZUrKfKADH6aXdeYKFk=;
        b=ZJAWYvDrEMDIKfSpYv4MCRVuVRvdQNDRuLDqRGVefLyctLbaTzHVsSs0yHr35fOov7
         ttur+1J7CzKdOBDkv34PxW7uaB3fBwTtLdWQPqZyw+hEPJ7cb4gb213EnZo5Uz6gZeke
         0MBUa+8NrqbwuSyxvxbvz+eVOxIrXsT+JYQMQOkYZHCT3jc3e+rjij4tynQayFvRKwpP
         OU0amm62WR1Puzbc4drHhK+CO2Yn85AR8wnhTSSeVpFumwhGctPox6baMGqyBh8nHfwR
         tV1Sy6Wd2Kzs9MEzpN5Fuyaxl8lGGnTMmluL6CHp8JrAul/vsQvxksRjHMrX1h+Jo0XJ
         u68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j6h9thN+7oY5ueLRnZbtIPPTXZUrKfKADH6aXdeYKFk=;
        b=4EFGra0EE/u0TeMosZpOM8JVxR21wzGNK9aXFYVYryW9SZk7PhYjS4xOLDq5oKppca
         pdoEB4KkYaXtKJUPgEHE8EGrNOs7PN7hKgkVw5HbUM3vvWkKQyqWNcmjfh9Csj5wrvt/
         1SZ1YyZ8ZiQCYjeV0P061uPzZv4IlzrHv3H961UcpuDReuqqDkUF/zc052dhtr5YN4Zi
         /1DLMC0++d8WykKanVFgFLmBPaf2fZxFzKlF1xBncJQtXwnP0JWsS2cGJTFG4S3FC7KL
         PTA1644RbojYP9XR9tU4QI7PQ1fTfR6y7j83mGuc9N607T//BbDLOizyj333CEJ2T3sq
         RTxQ==
X-Gm-Message-State: AOAM530i0ZoBjeBNffRryvGlios5xgRop9jERGS7dZWP5pUS4JNDDM8R
        pIMIecyPQjpK9Ip/Wh09fngUX+v74SduATOU1EIJZg==
X-Google-Smtp-Source: ABdhPJw5xSVuAeFHOneJSr7H4loYzkOqYCBAhcfIaE0c3S7QqWxpsoBzlvZCGGCGrr0RGHOcehlPXPFwg0tuv72aAKY=
X-Received: by 2002:ac2:5f19:0:b0:44a:f3de:58bd with SMTP id
 25-20020ac25f19000000b0044af3de58bdmr6643242lfq.645.1649075528642; Mon, 04
 Apr 2022 05:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
 <CAKfTPtAvbpUUaOqP3gmOT7fLk8-7v70LzBUiQ-vgDvc7ZZujag@mail.gmail.com>
 <SL2PR06MB30828CF9FF2879AFC9DC53D2BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtBM9WBEgP_PpRHNaATvp9FrBeV2NXhg_EAp4xYtBZYCWQ@mail.gmail.com>
 <SL2PR06MB30826C314139509EC4778C1BBD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtA=dy4M2OK+GqvPDo9D8YBZAHbEpM-YPVZEyEUjEJKU5g@mail.gmail.com>
 <SL2PR06MB308268BDF646BFA0FC9A4590BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtCVV_cpBty7xH8Gea8HdjNzfiE3Kd882i7Pffvrv3p1zw@mail.gmail.com>
 <SL2PR06MB3082ED191BF8892367A3465EBD109@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtCn0As7Kbj7aHtmu++RDyo8proM6k9DLa1AMAc7iSSQXg@mail.gmail.com> <SL2PR06MB308281BAC7D7F7CBF136DCD3BDE39@SL2PR06MB3082.apcprd06.prod.outlook.com>
In-Reply-To: <SL2PR06MB308281BAC7D7F7CBF136DCD3BDE39@SL2PR06MB3082.apcprd06.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 4 Apr 2022 14:31:57 +0200
Message-ID: <CAKfTPtD9T4CF3QzE_ES9cwHa2VgRsuSx6bKyM4d69poxp7ou2w@mail.gmail.com>
Subject: Re: [PATCH] sched: topology: make cache topology separate from cpu topology
To:     =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Sat, 2 Apr 2022 at 11:34, =E7=8E=8B=E6=93=8E <wangqing@vivo.com> wrote:
>
>
> >>
> >>
> >> >>
> >> >>
> >> >> >>
> >> >> >>
> >> >> >> >>
> >> >> >> >>
> >> >> >> >> >On Thu, 10 Mar 2022 at 13:59, Qing Wang <wangqing@vivo.com> =
wrote:
> >> >> >> >> >>
> >> >> >> >> >> From: Wang Qing <wangqing@vivo.com>
> >> >> >> >> >>
> >> >> >> >> >> Some architectures(e.g. ARM64), caches are implemented bel=
ow:
> >> >> >> >> >> cluster:                     ****** cluster 0 *****      *=
***** cluster 1 *****
> >> >> >> >> >> core:                         0      1          2      3  =
        4      5           6      7
> >> >> >> >> (add cache level 1)        c0    c1        c2    c3         c=
4    c5         c6    c7
> >> >> >> >> >> cache(Leveln):         **cache0**  **cache1**  **cache2** =
 **cache3**
> >> >> >> >> (add cache level 3)        *************share level 3 cache *=
**************
> >> >> >> >> >> sd_llc_id(current):     0      0          0      0        =
  4      4           4      4
> >> >> >> >> >> sd_llc_id(should be): 0      0          2      2          =
4      4           6      6
> >> >> >> >> >>
> >> >> >> >> Here, n always be 2 in ARM64, but others are also possible.
> >> >> >> >> core[0,1] form a complex(ARMV9),  which share L2 cache, core[=
2,3] is the same.
> >> >> >> >>
> >> >> >> >> >> Caches and cpus have different topology, this causes cpus_=
share_cache()
> >> >> >> >> >> return the wrong value, which will affect the CPU load bal=
ance.
> >> >> >> >> >>
> >> >> >> >> >What does your current scheduler topology  look like?
> >> >> >> >> >
> >> >> >> >> >For CPU 0 to 3, do you have the below ?
> >> >> >> >> >DIE [0     -     3] [4-7]
> >> >> >> >> >MC  [0] [1] [2] [3]
> >> >> >> >>
> >> >> >> >> The current scheduler topology consistent with CPU topology:
> >> >> >> >> DIE  [0-7]
> >> >> >> >> MC  [0-3] [4-7]  (SD_SHARE_PKG_RESOURCES)
> >> >> >> >> Most Android phones have this topology.
> >> >> >> >> >
> >> >> >> >> >But you would like something like below for cpu 0-1 instead =
?
> >> >> >> >> >DIE [0     -     3] [4-7]
> >> >> >> >> >CLS [0 - 1] [2 - 3]
> >> >> >> >> >MC  [0] [1]
> >> >> >> >> >
> >> >> >> >> >with SD_SHARE_PKG_RESOURCES only set to MC level ?
> >> >> >> >>
> >> >> >> >> We don't change the current scheduler topology, but the
> >> >> >> >> cache topology should be separated like below:
> >> >> >> >
> >> >> >> >The scheduler topology is not only cpu topology but a mixed of =
cpu and
> >> >> >> >cache/memory cache topology
> >> >> >> >
> >> >> >> >> [0-7]                          (shared level 3 cache )
> >> >> >> >> [0-1] [2-3][4-5][6-7]   (shared level 2 cache )
> >> >> >> >
> >> >> >> >So you don't  bother the intermediate cluster level which is ev=
en simpler.
> >> >> >> >you have to modify generic arch topology so that cpu_coregroup_=
mask
> >> >> >> >returns the correct cpu mask directly.
> >> >> >> >
> >> >> >> >You will notice a llc_sibling field that is currently used by a=
cpi but
> >> >> >> >not DT to return llc cpu mask
> >> >> >> >
> >> >> >> cpu_topology[].llc_sibling describe the last level cache of whol=
e system,
> >> >> >> not in the sched_domain.
> >> >> >>
> >> >> >> in the above cache topology, llc_sibling is 0xff([0-7]) , it des=
cribes
> >> >> >
> >> >> >If llc_sibling was 0xff([0-7] on your system, you would have only =
one level:
> >> >> >MC[0-7]
> >> >>
> >> >> Sorry, but I don't get it, why llc_sibling was 0xff([0-7] means MC[=
0-7]?
> >> >> In our system(Android), llc_sibling is indeed 0xff([0-7]) , because=
 they
> >> >> shared the llc(L3), but we also have two level:
> >> >> DIE [0-7]
> >> >> MC [0-3][4-6]
> >> >> It makes sense, [0-3] are little cores, [4-7] are bit cores, se onl=
y up migrate
> >> >> when misfit. We won't change it.
> >> >>
> >> >> >
> >> >> >> the L3 cache sibling, but sd_llc_id describes the maximum shared=
 cache
> >> >> >> in sd, which should be [0-1] instead of [0-3].
> >> >> >
> >> >> >sd_llc_id describes the last sched_domain with SD_SHARE_PKG_RESOUR=
CES.
> >> >> >If you want llc to be [0-3] make sure that the
> >> >> >sched_domain_topology_level array returns the correct cpumask with
> >> >> >this flag
> >> >>
> >> >> Acturely, we want sd_llc to be [0-1] [2-3], but if the MC domain do=
n't have
> >> >
> >> >sd_llc_id refers to a scheduler domain but your patch breaks this so
> >> >if you want a llc that reflects this topo:  [0-1] [2-3] you must
> >> >provide a sched_domain level with this topo
> >>
> >> Maybe we should add a shared-cache level(SC), like what CLS does:
> >>
> >> DIE  [0-7] (shared level 3 cache, SD_SHARE_PKG_RESOURCES)
> >> MC  [0-3] [4-7]  (not SD_SHARE_PKG_RESOURCES)
> >> CLS  (if necessary)
> >> SC    [0-1][2-3][4-5][6-7] (shared level 2 cache, SD_SHARE_PKG_RESOURC=
ES)
> >> SMT (if necessary)
> >>
> >> SC means a couple of CPUs which are placed closely by sharing
> >> mid-level caches, but not enough to be a cluster.
> >
> >what you name SC above looks the same as CLS which should not be mixed
> >with Arm cluster terminology
>
> Do you mean cluster is equal to shared cache instead of containing, SC ju=
st
> means shared cache, but not form a cluster, a CLS can contain many SCs.

CLS in the scheduler topology is not strictly tied to the "Arm
cluster" but it's the generic name to describe an intermediate group
of CPUs with common properties. CLS is also used by some intel
platforms as an example. What I mean is that you can use the scheduler
CLS level to describe what you call an Arm SC level.

>
> If as you said, SC looks the same as CLS, should we rename CLS to SC to
> avoid confusion?

CLS is a generic scheduler name and I don't think that we need to
rename it to a Arm specific label

Thanks,
Vincent

>
> Thanks,
> Wang
