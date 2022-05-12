Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683BB52448F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348429AbiELEtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348673AbiELEt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:49:28 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380EC3818A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:49:27 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id p1so1584471uak.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZTDnUWLhC6cjTXpBhDBsxqrgSnxn4/8Ogucz8EU94s=;
        b=D4JCCyKL+1RD+XHpB+jmPd5St1jxQqq2hTlRXQmLvp/mQplKm2rSHkWSxjslOs/aws
         DY+FuY8f/UNVG4vnlsFn8uGi6Zly00KYEZ0vGfHnh0zSQcfDdf1Oog+L/d7Lyjkc1YSE
         gKD5dy6CpL5eamPmyQiuMWPEyvZzOukSrH2t680iP4M9f6idiCrNLgvVct1wNxJGwOzw
         wuDtLo/aqerLTd5w9SylSJXEukAl0ZLagVCifcsK9rphdylVwfq32iOP5bsgVBWEnBYo
         xm+8vQEoAHeS2zp2c4gayV1oOyXsPDKdJYTE2mqdA08FGEbcFJ2+Fgbux8asFHByR9MY
         6iYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZTDnUWLhC6cjTXpBhDBsxqrgSnxn4/8Ogucz8EU94s=;
        b=xSmPiKXSCkge9FfpaPJLchNSPK9TgWcOV7mPuAbaRkHrcRGasxN16HJysZpt194MsC
         8rDmXi/loERC8eRowvqrN0kIINRP4Ps23/zajsRSCMfqtBIAK1gQhwTbvw1u+ijhQ5iW
         Myg8NBMWbJ9xSXE5/OyGoF8kvvMJv0e3SPJZFNB5jq2+WRRXAzdcXXQJ9WwlVq3InTBN
         ouFQp04roEGtJ2p+I+tflcYNODS0OcW0m2dnzbRtMzbDmILuc+Mk269ybqcJG8XNtoqp
         6le8fxqBueRY9lizWYT0iFFA+gFMLqYDvoiqIiGZefhgHtXLJjZ0pZjFvQVQTKS/veOF
         2MWg==
X-Gm-Message-State: AOAM533My4EGiZ8WFWVOGCfr0UuJwH2UML5Tl7AfQQRSMVo4V3jVVDgX
        nxcJUeHEHQ7lOZhxAG8AcsQLv2Xq8b2yGnEH2MLD+w==
X-Google-Smtp-Source: ABdhPJyQe63+/h17kay1cN4u1mpqQ7Ry8hCjFIfni3c4e/cCLhNVI8Z2+1O3/9TnmtB3OBOySV9qicWJyZxF/e4c4Ps=
X-Received: by 2002:ab0:e14:0:b0:360:e13:e5d7 with SMTP id g20-20020ab00e14000000b003600e13e5d7mr15545369uak.95.1652330964925;
 Wed, 11 May 2022 21:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
 <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
 <CAHbLzkrit3SDQUWPQ_RtTO_xFqxoqR9LpY=72afERapUgkjxZg@mail.gmail.com>
 <1642ab64-7957-e1e6-71c5-ceab9c23bf41@huawei.com> <CAHbLzkqBVdaT5wwPuCXUMb8DwLEzHPaQwCKXsjsPBRTgZAAgnw@mail.gmail.com>
 <c272e43d-47c5-d7d4-cb17-95dc6f28f5cd@huawei.com> <e1bf6346-fd93-13ee-0b38-c1d956df0e99@linux.ibm.com>
 <CAAPL-u-Q1_19TM-J-QD9QWXGcp6A9xJS126xO54H83u+c569Tg@mail.gmail.com>
 <87o804r08w.fsf@nvdebian.thelocal> <c6a4db88-b27f-0539-b66d-2b67533e0c9b@linux.ibm.com>
In-Reply-To: <c6a4db88-b27f-0539-b66d-2b67533e0c9b@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 11 May 2022 21:49:13 -0700
Message-ID: <CAAPL-u_XHjSqN4gVPmqyqhQuBt_9HOvfj+TveaVp2=75ViN69A@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 9:40 PM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 5/11/22 12:42 PM, Alistair Popple wrote:
> >
> > Wei Xu <weixugc@google.com> writes:
> >
> >> On Tue, May 10, 2022 at 5:10 AM Aneesh Kumar K V
> >> <aneesh.kumar@linux.ibm.com> wrote:
> >>>
> >>> On 5/10/22 3:29 PM, Hesham Almatary wrote:
> >>>> Hello Yang,
> >>>>
> >>>> On 5/10/2022 4:24 AM, Yang Shi wrote:
> >>>>> On Mon, May 9, 2022 at 7:32 AM Hesham Almatary
> >>>>> <hesham.almatary@huawei.com> wrote:
> >>>
> >>>
> >>> ...
> >>>
> >>>>>>
> >>>>>> node 0 has a CPU and DDR memory in tier 0, node 1 has GPU and DDR memory
> >>>>>> in tier 0,
> >>>>>> node 2 has NVMM memory in tier 1, node 3 has some sort of bigger memory
> >>>>>> (could be a bigger DDR or something) in tier 2. The distances are as
> >>>>>> follows:
> >>>>>>
> >>>>>> --------------          --------------
> >>>>>> |   Node 0   |          |   Node 1   |
> >>>>>> |  -------   |          |  -------   |
> >>>>>> | |  DDR  |  |          | |  DDR  |  |
> >>>>>> |  -------   |          |  -------   |
> >>>>>> |            |          |            |
> >>>>>> --------------          --------------
> >>>>>>           | 20               | 120    |
> >>>>>>           v                  v        |
> >>>>>> ----------------------------       |
> >>>>>> | Node 2     PMEM          |       | 100
> >>>>>> ----------------------------       |
> >>>>>>           | 100                       |
> >>>>>>           v                           v
> >>>>>> --------------------------------------
> >>>>>> | Node 3    Large mem                |
> >>>>>> --------------------------------------
> >>>>>>
> >>>>>> node distances:
> >>>>>> node   0    1    2    3
> >>>>>>       0  10   20   20  120
> >>>>>>       1  20   10  120  100
> >>>>>>       2  20  120   10  100
> >>>>>>       3  120 100  100   10
> >>>>>>
> >>>>>> /sys/devices/system/node/memory_tiers
> >>>>>> 0-1
> >>>>>> 2
> >>>>>> 3
> >>>>>>
> >>>>>> N_TOPTIER_MEMORY: 0-1
> >>>>>>
> >>>>>>
> >>>>>> In this case, we want to be able to "skip" the demotion path from Node 1
> >>>>>> to Node 2,
> >>>>>>
> >>>>>> and make demotion go directely to Node 3 as it is closer, distance wise.
> >>>>>> How can
> >>>>>>
> >>>>>> we accommodate this scenario (or at least not rule it out as future
> >>>>>> work) with the
> >>>>>>
> >>>>>> current RFC?
> >>>>> If I remember correctly NUMA distance is hardcoded in SLIT by the
> >>>>> firmware, it is supposed to reflect the latency. So I suppose it is
> >>>>> the firmware's responsibility to have correct information. And the RFC
> >>>>> assumes higher tier memory has better performance than lower tier
> >>>>> memory (latency, bandwidth, throughput, etc), so it sounds like a
> >>>>> buggy firmware to have lower tier memory with shorter distance than
> >>>>> higher tier memory IMHO.
> >>>>
> >>>> You are correct if you're assuming the topology is all hierarchically
> >>>>
> >>>> symmetric, but unfortuantely, in real hardware (e.g., my example above)
> >>>>
> >>>> it is not. The distance/latency between two nodes in the same tier
> >>>>
> >>>> and a third node, is different. The firmware still provides the correct
> >>>>
> >>>> latency, but putting a node in a tier is up to the kernel/user, and
> >>>>
> >>>> is relative: e.g., Node 3 could belong to tier 1 from Node 1's
> >>>>
> >>>> perspective, but to tier 2 from Node 0's.
> >>>>
> >>>>
> >>>> A more detailed example (building on my previous one) is when having
> >>>>
> >>>> the GPU connected to a switch:
> >>>>
> >>>> ----------------------------
> >>>> | Node 2     PMEM          |
> >>>> ----------------------------
> >>>>         ^
> >>>>         |
> >>>> --------------          --------------
> >>>> |   Node 0   |          |   Node 1   |
> >>>> |  -------   |          |  -------   |
> >>>> | |  DDR  |  |          | |  DDR  |  |
> >>>> |  -------   |          |  -------   |
> >>>> |    CPU     |          |    GPU     |
> >>>> --------------          --------------
> >>>>          |                  |
> >>>>          v                  v
> >>>> ----------------------------
> >>>> |         Switch           |
> >>>> ----------------------------
> >>>>          |
> >>>>          v
> >>>> --------------------------------------
> >>>> | Node 3    Large mem                |
> >>>> --------------------------------------
> >>>>
> >>>> Here, demoting from Node 1 to Node 3 directly would be faster as
> >>>>
> >>>> it only has to go through one hub, compared to demoting from Node 1
> >>>>
> >>>> to Node 2, where it goes through two hubs. I hope that example
> >>>>
> >>>> clarifies things a little bit.
> >>>>
> >>>
> >>> Alistair mentioned that we want to consider GPU memory to be expensive
> >>> and want to demote from GPU to regular DRAM. In that case for the above
> >>> case we should end up with
> >>>
> >>>
> >>> tier 0 - > Node3
> >>> tier 1 ->  Node0, Node1
> >>> tier 2 ->  Node2
> >
> > I'm a little bit confused by the tiering here as I don't think it's
> > quite what we want. As pointed out GPU memory is expensive and therefore
> > we don't want anything demoting to it. That implies it should be in the
> > top tier:
> >
>
>
> I didn't look closely at the topology and assumed that Node3 is the GPU
> connected to the switch. Hence all the confusion.
>
>
> > tier 0 -> Node1
> > tier 1 -> Node0, Node3
> > tier 2 -> Node2
> >
> > Hence:
> >
> > node 0: allowed=2
> > node 1: allowed=0,3,2
> > node 2: allowed=empty
> > node 3: allowed=2
>
> looks good to be default and simple.
>
> >
> > Alternatively Node3 could be put in tier 2 which would prevent demotion
> > to PMEM via the switch/CPU:
> >
> > tier 0 -> Node1
> > tier 1 -> Node0
> > tier 2 -> Node2, Node3
> >
> > node 0: allowed=2,3
> > node 1: allowed=0,3,2
> > node 2: allowed=empty
> > node 3: allowed=empty
> >
>
> and this can be configured via userspace?

The per-node tier customization interface that I just mentioned should
support such reconfigurations.

> > Both of these would be an improvement over the current situation
> > upstream, which demotes everything to GPU memory and doesn't support
> > demoting from the GPU (meaning reclaim on GPU memory pages everything to
> > disk).
> >
> >>>
> >>> Hence
> >>>
> >>>    node 0: allowed=2
> >>>    node 1: allowed=2
> >>>    node 2: allowed = empty
> >>>    node 3: allowed = 0-1 , based on fallback order 1, 0
> >>
> >> If we have 3 tiers as defined above, then we'd better to have:
> >>
> >> node 0: allowed = 2
> >> node 1: allowed = 2
> >> node 2: allowed = empty
> >> node 3: allowed = 0-2, based on fallback order: 1,0,2
> >>
> >> The firmware should provide the node distance values to reflect that
> >> PMEM is slowest and should have the largest distance away from node 3.
> >
> > Right. In my above example firmware would have to provide reasonable
> > distance values to ensure optimal fallback order.
> >
> >>> -aneesh
> >>>
> >>>
>
