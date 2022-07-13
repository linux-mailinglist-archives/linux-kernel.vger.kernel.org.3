Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43072572E53
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiGMGjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiGMGjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:39:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A950DC8B5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:39:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so2025278pjf.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1nk300hDe6+9dxD4fU2DyWPbSq3Mji3B/qJ3S5ejmfA=;
        b=VQJWSomxcj5wRlQeaHN6+Sd2ObJof3h77MTj6U8O1uC/ZJQVYOyTZp31LL9lrR+01H
         5mFY8jTNGX9/GPWiQYzNdJ+dMoCiwScYRI586MSheSOkpxTQbvhaCOrK0sZNzPs7sgEh
         JzP02VPnFrmmCTqB/4FvKl9Sl0sRExNEwyaS5TpnZ2Tdaq3RktouDuZz5LP8KVPE2qwb
         cdT/ARKLhe9NVYcm/MZo7YucEo9RHZ1Cb2tfpsHZG+pAKmSpo/Ah9kPgY88C1uk8LhsN
         J0E7tk1j50YAspAb34m/pCL2c3NgcFCYCZGW4vajGaZL4bOYbZ9AhIvHTryfd2ZnOeO8
         /Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nk300hDe6+9dxD4fU2DyWPbSq3Mji3B/qJ3S5ejmfA=;
        b=GF7ZojyqIuS4fC+N9eRqEf2pMc/fnqsPsyPJiwk1nyd7jdvWDd4kiG23VCpNbzy3Dg
         0P07B06jzktxqqV3+87mYaKgj0Sgpwh/9gYI3GvwpjO21d14Bb5RN7fTzH40WlspbrXJ
         V1juFA1ScGKdxr554yrrPb0RfN1GqnqhkuPoRE/cyHzeXoQOCBsNiRQ98qOX4bm0G5D9
         CVe9ft5JPjBOUj/TFUELYHCEd9qyR6WrGSDFxiaDGG699fPWrME7zgon/PTxeeGK8qbA
         m3iZ/kD6SrvIQO+47ui9DmIZ4PiZgDOJCD3fNRoosJrO+keRTTl6wgndZi+5q7MmPtTm
         3V+Q==
X-Gm-Message-State: AJIora9kuXE4tHyzUFpWcbOkdX9NEk3zSRROIFYDHOzjrjhfCs7ZRBUJ
        f1Cu6Kag0DestC24FMU5iVFsOfdWtyJmNV6vGhv6SQ==
X-Google-Smtp-Source: AGRyM1vqTyvAlEdePBXMPUrwJYQ57sSRLUeEjXjig517R1tLYjCrnwGKfUIDRcl5Jj2nmiSjXS+uzGBDTyl6AkHvpDY=
X-Received: by 2002:a17:902:c94b:b0:16c:7289:b402 with SMTP id
 i11-20020a170902c94b00b0016c7289b402mr1495400pla.66.1657694384384; Tue, 12
 Jul 2022 23:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
 <87r130b2rh.fsf@yhuang6-desk2.ccr.corp.intel.com> <60e97fa2-0b89-cf42-5307-5a57c956f741@linux.ibm.com>
 <87r12r5dwu.fsf@yhuang6-desk2.ccr.corp.intel.com> <0a55e48a-b4b7-4477-a72f-73644b5fc4cb@linux.ibm.com>
 <80e5308f-bd83-609e-0f23-33cb89fe9141@linux.ibm.com> <CAHbLzkp3JZmovvekqkno4+skm1RDBgSguJS1POdr+FF7nMpS_Q@mail.gmail.com>
 <87a69d65ls.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87a69d65ls.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Tue, 12 Jul 2022 23:39:33 -0700
Message-ID: <CAAPL-u-argwaZQqPDYrjCBDw5BKttorJ-iCNvRMwQo7rELCJgA@mail.gmail.com>
Subject: Re: [PATCH v8 00/12] mm/demotion: Memory tiers and demotion
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
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

On Tue, Jul 12, 2022 at 8:42 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yang Shi <shy828301@gmail.com> writes:
>
> > On Mon, Jul 11, 2022 at 10:10 PM Aneesh Kumar K V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> On 7/12/22 10:12 AM, Aneesh Kumar K V wrote:
> >> > On 7/12/22 6:46 AM, Huang, Ying wrote:
> >> >> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> >> >>
> >> >>> On 7/5/22 9:59 AM, Huang, Ying wrote:
> >> >>>> Hi, Aneesh,
> >> >>>>
> >> >>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> >> >>>>
> >> >>>>> The current kernel has the basic memory tiering support: Inactive
> >> >>>>> pages on a higher tier NUMA node can be migrated (demoted) to a lower
> >> >>>>> tier NUMA node to make room for new allocations on the higher tier
> >> >>>>> NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
> >> >>>>> migrated (promoted) to a higher tier NUMA node to improve the
> >> >>>>> performance.
> >> >>>>>
> >> >>>>> In the current kernel, memory tiers are defined implicitly via a
> >> >>>>> demotion path relationship between NUMA nodes, which is created during
> >> >>>>> the kernel initialization and updated when a NUMA node is hot-added or
> >> >>>>> hot-removed.  The current implementation puts all nodes with CPU into
> >> >>>>> the top tier, and builds the tier hierarchy tier-by-tier by establishing
> >> >>>>> the per-node demotion targets based on the distances between nodes.
> >> >>>>>
> >> >>>>> This current memory tier kernel interface needs to be improved for
> >> >>>>> several important use cases:
> >> >>>>>
> >> >>>>> * The current tier initialization code always initializes
> >> >>>>>   each memory-only NUMA node into a lower tier.  But a memory-only
> >> >>>>>   NUMA node may have a high performance memory device (e.g. a DRAM
> >> >>>>>   device attached via CXL.mem or a DRAM-backed memory-only node on
> >> >>>>>   a virtual machine) and should be put into a higher tier.
> >> >>>>>
> >> >>>>> * The current tier hierarchy always puts CPU nodes into the top
> >> >>>>>   tier. But on a system with HBM (e.g. GPU memory) devices, these
> >> >>>>>   memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
> >> >>>>>   with CPUs are better to be placed into the next lower tier.
> >> >>>>>
> >> >>>>> * Also because the current tier hierarchy always puts CPU nodes
> >> >>>>>   into the top tier, when a CPU is hot-added (or hot-removed) and
> >> >>>>>   triggers a memory node from CPU-less into a CPU node (or vice
> >> >>>>>   versa), the memory tier hierarchy gets changed, even though no
> >> >>>>>   memory node is added or removed.  This can make the tier
> >> >>>>>   hierarchy unstable and make it difficult to support tier-based
> >> >>>>>   memory accounting.
> >> >>>>>
> >> >>>>> * A higher tier node can only be demoted to selected nodes on the
> >> >>>>>   next lower tier as defined by the demotion path, not any other
> >> >>>>>   node from any lower tier.  This strict, hard-coded demotion order
> >> >>>>>   does not work in all use cases (e.g. some use cases may want to
> >> >>>>>   allow cross-socket demotion to another node in the same demotion
> >> >>>>>   tier as a fallback when the preferred demotion node is out of
> >> >>>>>   space), and has resulted in the feature request for an interface to
> >> >>>>>   override the system-wide, per-node demotion order from the
> >> >>>>>   userspace.  This demotion order is also inconsistent with the page
> >> >>>>>   allocation fallback order when all the nodes in a higher tier are
> >> >>>>>   out of space: The page allocation can fall back to any node from
> >> >>>>>   any lower tier, whereas the demotion order doesn't allow that.
> >> >>>>>
> >> >>>>> * There are no interfaces for the userspace to learn about the memory
> >> >>>>>   tier hierarchy in order to optimize its memory allocations.
> >> >>>>>
> >> >>>>> This patch series make the creation of memory tiers explicit under
> >> >>>>> the control of userspace or device driver.
> >> >>>>>
> >> >>>>> Memory Tier Initialization
> >> >>>>> ==========================
> >> >>>>>
> >> >>>>> By default, all memory nodes are assigned to the default tier with
> >> >>>>> tier ID value 200.
> >> >>>>>
> >> >>>>> A device driver can move up or down its memory nodes from the default
> >> >>>>> tier.  For example, PMEM can move down its memory nodes below the
> >> >>>>> default tier, whereas GPU can move up its memory nodes above the
> >> >>>>> default tier.
> >> >>>>>
> >> >>>>> The kernel initialization code makes the decision on which exact tier
> >> >>>>> a memory node should be assigned to based on the requests from the
> >> >>>>> device drivers as well as the memory device hardware information
> >> >>>>> provided by the firmware.
> >> >>>>>
> >> >>>>> Hot-adding/removing CPUs doesn't affect memory tier hierarchy.
> >> >>>>>
> >> >>>>> Memory Allocation for Demotion
> >> >>>>> ==============================
> >> >>>>> This patch series keep the demotion target page allocation logic same.
> >> >>>>> The demotion page allocation pick the closest NUMA node in the
> >> >>>>> next lower tier to the current NUMA node allocating pages from.
> >> >>>>>
> >> >>>>> This will be later improved to use the same page allocation strategy
> >> >>>>> using fallback list.
> >> >>>>>
> >> >>>>> Sysfs Interface:
> >> >>>>> -------------
> >> >>>>> Listing current list of memory tiers details:
> >> >>>>>
> >> >>>>> :/sys/devices/system/memtier$ ls
> >> >>>>> default_tier max_tier  memtier1  power  uevent
> >> >>>>> :/sys/devices/system/memtier$ cat default_tier
> >> >>>>> memtier200
> >> >>>>> :/sys/devices/system/memtier$ cat max_tier
> >> >>>>> 400
> >> >>>>> :/sys/devices/system/memtier$
> >> >>>>>
> >> >>>>> Per node memory tier details:
> >> >>>>>
> >> >>>>> For a cpu only NUMA node:
> >> >>>>>
> >> >>>>> :/sys/devices/system/node# cat node0/memtier
> >> >>>>> :/sys/devices/system/node# echo 1 > node0/memtier
> >> >>>>> :/sys/devices/system/node# cat node0/memtier
> >> >>>>> :/sys/devices/system/node#
> >> >>>>>
> >> >>>>> For a NUMA node with memory:
> >> >>>>> :/sys/devices/system/node# cat node1/memtier
> >> >>>>> 1
> >> >>>>> :/sys/devices/system/node# ls ../memtier/
> >> >>>>> default_tier  max_tier  memtier1  power  uevent
> >> >>>>> :/sys/devices/system/node# echo 2 > node1/memtier
> >> >>>>> :/sys/devices/system/node#
> >> >>>>> :/sys/devices/system/node# ls ../memtier/
> >> >>>>> default_tier  max_tier  memtier1  memtier2  power  uevent
> >> >>>>> :/sys/devices/system/node# cat node1/memtier
> >> >>>>> 2
> >> >>>>> :/sys/devices/system/node#
> >> >>>>>
> >> >>>>> Removing a memory tier
> >> >>>>> :/sys/devices/system/node# cat node1/memtier
> >> >>>>> 2
> >> >>>>> :/sys/devices/system/node# echo 1 > node1/memtier
> >> >>>>
> >> >>>> Thanks a lot for your patchset.
> >> >>>>
> >> >>>> Per my understanding, we haven't reach consensus on
> >> >>>>
> >> >>>> - how to create the default memory tiers in kernel (via abstract
> >> >>>>   distance provided by drivers?  Or use SLIT as the first step?)
> >> >>>>
> >> >>>> - how to override the default memory tiers from user space
> >> >>>>
> >> >>>> As in the following thread and email,
> >> >>>>
> >> >>>> https://lore.kernel.org/lkml/YqjZyP11O0yCMmiO@cmpxchg.org/
> >> >>>>
> >> >>>> I think that we need to finalized on that firstly?
> >> >>>
> >> >>> I did list the proposal here
> >> >>>
> >> >>> https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
> >> >>>
> >> >>> So both the kernel default and driver-specific default tiers now become kernel parameters that can be updated
> >> >>> if the user wants a different tier topology.
> >> >>>
> >> >>> All memory that is not managed by a driver gets added to default_memory_tier which got a default value of 200
> >> >>>
> >> >>> For now, the only driver that is updated is dax kmem, which adds the memory it manages to memory tier 100.
> >> >>> Later as we learn more about the device attributes (HMAT or something similar) that we might want to use
> >> >>> to control the tier assignment this can be a range of memory tiers.
> >> >>>
> >> >>> Based on the above, I guess we can merge what is posted in this series and later fine-tune/update
> >> >>> the memory tier assignment based on device attributes.
> >> >>
> >> >> Sorry for late reply.
> >> >>
> >> >> As the first step, it may be better to skip the parts that we haven't
> >> >> reached consensus yet, for example, the user space interface to override
> >> >> the default memory tiers.  And we can use 0, 1, 2 as the default memory
> >> >> tier IDs.  We can refine/revise the in-kernel implementation, but we
> >> >> cannot change the user space ABI.
> >> >>
> >> >
> >> > Can you help list the use case that will be broken by using tierID as outlined in this series?
> >> > One of the details that were mentioned earlier was the need to track top-tier memory usage in a
> >> > memcg and IIUC the patchset posted https://lore.kernel.org/linux-mm/cover.1655242024.git.tim.c.chen@linux.intel.com
> >> > can work with tier IDs too. Let me know if you think otherwise. So at this point
> >> > I am not sure which area we are still debating w.r.t the userspace interface.
> >> >
> >> > I will still keep the default tier IDs with a large range between them. That will allow
> >> > us to go back to tierID based demotion order if we can. That is much simpler than using tierID and rank
> >> > together. If we still want to go back to rank based approach the tierID value won't have much
> >> > meaning anyway.
> >> >
> >> > Any feedback on patches 1 - 5, so that I can request Andrew to merge them?
> >> >
> >>
> >> Looking at this again, I guess we just need to drop patch 7
> >> mm/demotion: Add per node memory tier attribute to sysfs ?
> >>
> >> We do agree to use the device model to expose memory tiers to userspace so patch 6 can still be included.
> >> It also exposes max_tier, default_tier, and node list of a memory tier. All these are useful
> >> and agreed upon. Hence patch 6 can be merged?
> >>
> >> patch 8 - 10 -> are done based on the request from others and is independent of how memory tiers
> >> are exposed/created from userspace. Hence that can be merged?
> >>
> >> If you agree I can rebase the series moving patch 7,11,12 as the last patches in the series so
> >> that we can skip merging them based on what we conclude w.r.t usage of rank.
> >
> > I think the most controversial part is the user visible interfaces so
> > far. And IIUC the series could be split roughly into two parts, patch
> > 1 - 5 and others. The patch 1 -5 added the explicit memory tier
> > support and fixed the issue reported by Jagdish. I think we are on the
> > same page for this part. But I haven't seen any thorough review on
> > those patches yet since we got distracted by spending most time
> > discussing about the user visible interfaces.
> >
> > So would it help to move things forward to submit patch 1 - 5 as a
> > standalone series to get thorough review then get merged?
>
> Yes.  I think this is a good idea.  We can discuss the in kernel
> implementation (without user space interface) in details and try to make
> it merged.
>
> And we can continue our discussion of user space interface in a separate
> thread.
>
> Best Regards,
> Huang, Ying
>

I also agree that it is a good idea to split this patch series into
the kernel and userspace parts.

The current sysfs interface provides more dynamic memtiers than what I
have expected.  Let's have more discussions on that after the kernel
space changes are finalized.

Wei
