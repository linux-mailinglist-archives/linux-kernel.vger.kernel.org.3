Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7424DA07A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350255AbiCOQxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350361AbiCOQxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:53:08 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA09D574BA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:51:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w12so34030986lfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jin/dil8Y86UR6g39ryXWBgMORg2mX23wERJrXq3qYs=;
        b=kc/qG/9lO+a+365TCdbU1o0PeaKoSB0mj6zzCjftJK9qVvd5NAC+/Qci6BQ90IXwSK
         pahG1K44yw9TqzAf+aL7d9CzxJpVdcNSa1eqCzO3SuELcJfTsgGhR0nfJJGZcQ2TKeWk
         K9L+hPzKLkTtsvAr/W8zLfVBVMy8hnBo62pGqit96BFtjFZj2wIg34Z8+64MhBikw6Qk
         4kWPjwUONA7ZjehvbTYXdxXYiPgNzy4IJzbgPkrvbi8rAEvZI2WN4FkfbwpA2EC8SwuX
         ZqJlLadZcY2CKOjk4QEnjxddQNKzT7v00mqOlVsm4KwmWzDUhZ2JRZDuSSTvtR3QKf49
         1YXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jin/dil8Y86UR6g39ryXWBgMORg2mX23wERJrXq3qYs=;
        b=ba2MhF2RvB6xPqeW3t2fDcqpwlsIvEvNIa6S3UoeIjiQZJ+s5X4hDHAy+3dOaWspZm
         Q7+2N8HjVJnJfXwQYiIbb+tPzCWWuQEylxr8jiNCcmIYI6D48amrkuTnof7pAXr1/cwT
         9vDNCCh//XbaCQNE9UrVpmmSEee4y73RQgbdQP43KzGvRqGTsxF9VCLHZEDJKbTwqdhh
         gkB/O1vncCEkP68i8DTZ1+IqtdYLCZpnZU23+P/zrrdrIxh0N2yVMpkpycaMNksvSvWG
         8VvD4SGxLTay4G9waMSgXREPM8LZV2vXDGiuME47G5QoD/deCtM60kDmYTV6VmY6HwjX
         9Jwg==
X-Gm-Message-State: AOAM530b20hu/rDy/p2jppzNJzmeWwtzuQoeL++tyQ3AXyArAJYN/fH9
        RqAsnUozFodx8/G19saQs2ufHYLDkFhHkbQuMtPw7Q==
X-Google-Smtp-Source: ABdhPJzznWwaoHhflgnj7fau8TNneR1LHsKYbfmHkHxkn8CpceZfDhdwHToVp+U5IS5vdTDofm/cyd7V89JoycaqrVk=
X-Received: by 2002:ac2:554a:0:b0:448:2a09:66eb with SMTP id
 l10-20020ac2554a000000b004482a0966ebmr17464548lfk.645.1647363113677; Tue, 15
 Mar 2022 09:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
 <CAKfTPtAvbpUUaOqP3gmOT7fLk8-7v70LzBUiQ-vgDvc7ZZujag@mail.gmail.com>
 <SL2PR06MB30828CF9FF2879AFC9DC53D2BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtBM9WBEgP_PpRHNaATvp9FrBeV2NXhg_EAp4xYtBZYCWQ@mail.gmail.com>
 <SL2PR06MB30826C314139509EC4778C1BBD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtA=dy4M2OK+GqvPDo9D8YBZAHbEpM-YPVZEyEUjEJKU5g@mail.gmail.com>
 <SL2PR06MB308268BDF646BFA0FC9A4590BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtCVV_cpBty7xH8Gea8HdjNzfiE3Kd882i7Pffvrv3p1zw@mail.gmail.com> <SL2PR06MB3082ED191BF8892367A3465EBD109@SL2PR06MB3082.apcprd06.prod.outlook.com>
In-Reply-To: <SL2PR06MB3082ED191BF8892367A3465EBD109@SL2PR06MB3082.apcprd06.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 15 Mar 2022 17:51:41 +0100
Message-ID: <CAKfTPtCn0As7Kbj7aHtmu++RDyo8proM6k9DLa1AMAc7iSSQXg@mail.gmail.com>
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

On Tue, 15 Mar 2022 at 02:58, =E7=8E=8B=E6=93=8E <wangqing@vivo.com> wrote:
>
>
> >>
> >>
> >> >>
> >> >>
> >> >> >>
> >> >> >>
> >> >> >> >On Thu, 10 Mar 2022 at 13:59, Qing Wang <wangqing@vivo.com> wro=
te:
> >> >> >> >>
> >> >> >> >> From: Wang Qing <wangqing@vivo.com>
> >> >> >> >>
> >> >> >> >> Some architectures(e.g. ARM64), caches are implemented below:
> >> >> >> >> cluster:                     ****** cluster 0 *****      ****=
** cluster 1 *****
> >> >> >> >> core:                         0      1          2      3     =
     4      5           6      7
> >> >> >> (add cache level 1)        c0    c1        c2    c3         c4  =
  c5         c6    c7
> >> >> >> >> cache(Leveln):         **cache0**  **cache1**  **cache2**  **=
cache3**
> >> >> >> (add cache level 3)        *************share level 3 cache ****=
***********
> >> >> >> >> sd_llc_id(current):     0      0          0      0          4=
      4           4      4
> >> >> >> >> sd_llc_id(should be): 0      0          2      2          4  =
    4           6      6
> >> >> >> >>
> >> >> >> Here, n always be 2 in ARM64, but others are also possible.
> >> >> >> core[0,1] form a complex(ARMV9),  which share L2 cache, core[2,3=
] is the same.
> >> >> >>
> >> >> >> >> Caches and cpus have different topology, this causes cpus_sha=
re_cache()
> >> >> >> >> return the wrong value, which will affect the CPU load balanc=
e.
> >> >> >> >>
> >> >> >> >What does your current scheduler topology  look like?
> >> >> >> >
> >> >> >> >For CPU 0 to 3, do you have the below ?
> >> >> >> >DIE [0     -     3] [4-7]
> >> >> >> >MC  [0] [1] [2] [3]
> >> >> >>
> >> >> >> The current scheduler topology consistent with CPU topology:
> >> >> >> DIE  [0-7]
> >> >> >> MC  [0-3] [4-7]  (SD_SHARE_PKG_RESOURCES)
> >> >> >> Most Android phones have this topology.
> >> >> >> >
> >> >> >> >But you would like something like below for cpu 0-1 instead ?
> >> >> >> >DIE [0     -     3] [4-7]
> >> >> >> >CLS [0 - 1] [2 - 3]
> >> >> >> >MC  [0] [1]
> >> >> >> >
> >> >> >> >with SD_SHARE_PKG_RESOURCES only set to MC level ?
> >> >> >>
> >> >> >> We don't change the current scheduler topology, but the
> >> >> >> cache topology should be separated like below:
> >> >> >
> >> >> >The scheduler topology is not only cpu topology but a mixed of cpu=
 and
> >> >> >cache/memory cache topology
> >> >> >
> >> >> >> [0-7]                          (shared level 3 cache )
> >> >> >> [0-1] [2-3][4-5][6-7]   (shared level 2 cache )
> >> >> >
> >> >> >So you don't  bother the intermediate cluster level which is even =
simpler.
> >> >> >you have to modify generic arch topology so that cpu_coregroup_mas=
k
> >> >> >returns the correct cpu mask directly.
> >> >> >
> >> >> >You will notice a llc_sibling field that is currently used by acpi=
 but
> >> >> >not DT to return llc cpu mask
> >> >> >
> >> >> cpu_topology[].llc_sibling describe the last level cache of whole s=
ystem,
> >> >> not in the sched_domain.
> >> >>
> >> >> in the above cache topology, llc_sibling is 0xff([0-7]) , it descri=
bes
> >> >
> >> >If llc_sibling was 0xff([0-7] on your system, you would have only one=
 level:
> >> >MC[0-7]
> >>
> >> Sorry, but I don't get it, why llc_sibling was 0xff([0-7] means MC[0-7=
]?
> >> In our system(Android), llc_sibling is indeed 0xff([0-7]) , because th=
ey
> >> shared the llc(L3), but we also have two level:
> >> DIE [0-7]
> >> MC [0-3][4-6]
> >> It makes sense, [0-3] are little cores, [4-7] are bit cores, se only u=
p migrate
> >> when misfit. We won't change it.
> >>
> >> >
> >> >> the L3 cache sibling, but sd_llc_id describes the maximum shared ca=
che
> >> >> in sd, which should be [0-1] instead of [0-3].
> >> >
> >> >sd_llc_id describes the last sched_domain with SD_SHARE_PKG_RESOURCES=
.
> >> >If you want llc to be [0-3] make sure that the
> >> >sched_domain_topology_level array returns the correct cpumask with
> >> >this flag
> >>
> >> Acturely, we want sd_llc to be [0-1] [2-3], but if the MC domain don't=
 have
> >
> >sd_llc_id refers to a scheduler domain but your patch breaks this so
> >if you want a llc that reflects this topo:  [0-1] [2-3] you must
> >provide a sched_domain level with this topo
>
> Maybe we should add a shared-cache level(SC), like what CLS does:
>
> DIE  [0-7] (shared level 3 cache, SD_SHARE_PKG_RESOURCES)
> MC  [0-3] [4-7]  (not SD_SHARE_PKG_RESOURCES)
> CLS  (if necessary)
> SC    [0-1][2-3][4-5][6-7] (shared level 2 cache, SD_SHARE_PKG_RESOURCES)
> SMT (if necessary)
>
> SC means a couple of CPUs which are placed closely by sharing
> mid-level caches, but not enough to be a cluster.

what you name SC above looks the same as CLS which should not be mixed
with Arm cluster terminology

> >
> >side question, why don't you want llc to be the L3 one ?
>
> Yes, we should set SD_SHARE_PKG_RESOURCES to DIE, but we also want to
> represent the mid-level caches to improve throughput.

so your topology (from a scheduler poV) should be for cpu0:
DIE [0   -       3] [4   -   7] (SD_SHARE_PKG_RESOURCES)
MC  [0 - 1] [2 - 3]             (SD_SHARE_PKG_RESOURCES)
CLS [0] [1]                     (SD_SHARE_PKG_RESOURCES)

so the llc will be the DIE level and load balance will spread tasks in
the different  group of cpus

And regarding EAS, it will look at DIE level for task placement

And of course, this doesn't need any change in scheduler but the
arch_topology.c to return the correct cpumask for your system

>
> Thanks,
> Wang
> >
> >> SD_SHARE_PKG_RESOURCES flag, the sd_llc will be [0][1][2][3]. It's not=
 true.
> >
> >The only entry point for describing the scheduler domain is the
> >sched_domain_topology_level array which provides some cpumask and some
> >associated flags. By default, SD_SHARE_PKG_RESOURCES is set for
> >scheduler MC level which implies that the cpus shared their cache. If
> >this is not the case for your system, you should either remove this
> >flag or update the cpumask to reflect which CPUs really share their
> >caches.
> >
> >>
> >> So we must separate sd_llc from sd topology, or the demand cannot be
> >> met in any case under the existing mechanism.
> >
> >There is a default array with DIE, MC, CLS and SMT levels with
> >SD_SHARE_PKG_RESOURCES set up to MC which is considered to be the LLC
> >but a different array than the default one can be provided with
> >set_sched_topology()
> >
> >Thanks
> >Vincent
> >
> >>
> >> Thanks,
> >> Wang
> >>
