Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A154F51DF66
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389168AbiEFTAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiEFTAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:00:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0058E5F8E8
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 11:57:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e24so7793582pjt.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 11:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvNnGD1Ca/S3gPVO3jCou0HL8O+SUqD06xfN+hLCHeQ=;
        b=gUmFjNanITNvi3yCB40DENwqSAptvDykHnJaIKa0tV04msbb5L67Qa1VgkqvF/COjP
         1i2pQNgdy/khyDwK85uiRbN+0c8Si/Kz8zzas6HgKkVopHmntDmPaJmsU/tRVZvO+OXK
         /1/K6WxfuIy4VYq+KerertxFnzZmTBDlBMsaB8KuWfuQno26+O+wkRlBW+qDIdUgPdoL
         hA6MMONGULb+oO3UsEFI5zg/IX9EYI7wHPLgSBhL+8OrJcei9bA592VIgCu+It53PFkM
         o9/AcA7rdgvrMJhEBiA+A7DK6JJ8rZJeGps776ulNP9G2SwEdHupvTnZhFfEhVCEQQtD
         tNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvNnGD1Ca/S3gPVO3jCou0HL8O+SUqD06xfN+hLCHeQ=;
        b=06q+CCLJtVJIcv5Ibirr5ez/oIjxKFldq9PFQW31vFoNdnzyM+W/2PP+aXRyo1uLkq
         C1SwaomVyVqo47cn/qQgNwAViGmRwB8KWymRZ76avAEDYOrQt8+UAnOvGRQVrUpGqWFw
         Lf/9xcPrIqsDcGBOHxkWMSKslAHunJgSvSI+7Uei664PPCE3pduwTCTnii3soGsT8YN6
         tB6g6CEJYZPt3a0u0GLBxHtda2vgJBHsdC/GCFORRSqY52bqyzQLc56zO1qcO6ebFhhV
         L7Blg44C4WCqFYdIuzJK2xN1iHadjXcJdtllJtHv6imkiR30MieAoSsz7GPOKlBRzeHz
         EynQ==
X-Gm-Message-State: AOAM533aFnqizjM78ADpU/61GeJQ0wwach0Bi6SXhtfCfnXjIpigcXd6
        w0nK0ptHqLIQxc58QHNO1t0kCFdPOH4Na8iE5Wo=
X-Google-Smtp-Source: ABdhPJx6pNO9Sp4A4kYOi4AIIw1uqGz48eZtXz9KYrnT413SNRygz3Mxvkl1TfaEbqy0odnLRhn4Oh9yRpILQFLJrng=
X-Received: by 2002:a17:90b:1b52:b0:1dc:54ea:ac00 with SMTP id
 nv18-20020a17090b1b5200b001dc54eaac00mr14029398pjb.99.1651863427320; Fri, 06
 May 2022 11:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com> <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
In-Reply-To: <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 6 May 2022 11:56:54 -0700
Message-ID: <CAHbLzkrit3SDQUWPQ_RtTO_xFqxoqR9LpY=72afERapUgkjxZg@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     Wei Xu <weixugc@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>, Jonathan.Cameron@huawei.com,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 11:37 PM Wei Xu <weixugc@google.com> wrote:
>
> On Fri, Apr 29, 2022 at 8:59 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > Hi Wei,
> >
> > Thanks for the nice writing. Please see the below inline comments.
>
> Thanks for the quick response and comments.
>
> > On Fri, Apr 29, 2022 at 7:10 PM Wei Xu <weixugc@google.com> wrote:
> > >
> > > The current kernel has the basic memory tiering support: Inactive
> > > pages on a higher tier NUMA node can be migrated (demoted) to a lower
> > > tier NUMA node to make room for new allocations on the higher tier
> > > NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
> > > migrated (promoted) to a higher tier NUMA node to improve the
> > > performance.
> > >
> > > A tiering relationship between NUMA nodes in the form of demotion path
> > > is created during the kernel initialization and updated when a NUMA
> > > node is hot-added or hot-removed.  The current implementation puts all
> > > nodes with CPU into the top tier, and then builds the tiering hierarchy
> > > tier-by-tier by establishing the per-node demotion targets based on
> > > the distances between nodes.
> > >
> > > The current memory tiering interface needs to be improved to address
> > > several important use cases:
> > >
> > > * The current tiering initialization code always initializes
> > >   each memory-only NUMA node into a lower tier.  But a memory-only
> > >   NUMA node may have a high performance memory device (e.g. a DRAM
> > >   device attached via CXL.mem or a DRAM-backed memory-only node on
> > >   a virtual machine) and should be put into the top tier.
> > >
> > > * The current tiering hierarchy always puts CPU nodes into the top
> > >   tier. But on a system with HBM (e.g. GPU memory) devices, these
> > >   memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
> > >   with CPUs are better to be placed into the next lower tier.
> > >
> > > * Also because the current tiering hierarchy always puts CPU nodes
> > >   into the top tier, when a CPU is hot-added (or hot-removed) and
> > >   triggers a memory node from CPU-less into a CPU node (or vice
> > >   versa), the memory tiering hierarchy gets changed, even though no
> > >   memory node is added or removed.  This can make the tiering
> > >   hierarchy much less stable.
> >
> > I'd prefer the firmware builds up tiers topology then passes it to
> > kernel so that kernel knows what nodes are in what tiers. No matter
> > what nodes are hot-removed/hot-added they always stay in their tiers
> > defined by the firmware. I think this is important information like
> > numa distances. NUMA distance alone can't satisfy all the usecases
> > IMHO.
>
> I agree that the firmware needs to play a bigger role in tier
> topology, though it is not clear to me yet that we should require the
> tier topology be fully defined by the firmware.  If yes, a standard
> needs to be established. Alternatively, with additional hardware
> information provided by the firmware (e.g. HMAT), the kernel can be in
> a much better position to initialize the proper tier topology by
> itself.
>
> It is important to keep tier topology stable, especially if we want to
> account and limit memory usage based on tiers.  So I agree that the
> nodes should not change their tiers no matter what nodes are
> hot-added/hot-removed.
>
> Given that the additional tier-related information is not yet
> available from the firmware and NUMA distance alone is not sufficient
> for all the tiering use cases, and also that we want to keep tier
> topology stable after the kernel boots, I suggest that we add a kernel
> boot parameter to override the default tier topology (which nodes are
> in which tiers). An example is: tier=2:0-1;2-3, which defines two
> tiers: tier 0 includes node 0 & 1, and tier 1 includes node 2 & 3.
>
> > >
> > > * A higher tier node can only be demoted to selected nodes on the
> > >   next lower tier, not any other node from the next lower tier.  This
> > >   strict, hard-coded demotion order does not work in all use cases
> > >   (e.g. some use cases may want to allow cross-socket demotion to
> > >   another node in the same demotion tier as a fallback when the
> > >   preferred demotion node is out of space), and has resulted in the
> > >   feature request for an interface to override the system-wide,
> > >   per-node demotion order from the userspace.
> > >
> > > * There are no interfaces for the userspace to learn about the memory
> > >   tiering hierarchy in order to optimize its memory allocations.
> > >
> > > I'd like to propose revised memory tiering kernel interfaces based on
> > > the discussions in the threads:
> > >
> > > - https://lore.kernel.org/lkml/20220425201728.5kzm4seu7rep7ndr@offworld/T/
> > > - https://lore.kernel.org/linux-mm/20220426114300.00003ad8@Huawei.com/t/
> > >
> > >
> > > Sysfs Interfaces
> > > ================
> > >
> > > * /sys/devices/system/node/memory_tiers
> > >
> > >   Format: node list (one tier per line, in the tier order)
> > >
> > >   When read, list memory nodes by tiers.
> > >
> > >   When written (one tier per line), take the user-provided node-tier
> > >   assignment as the new tiering hierarchy and rebuild the per-node
> > >   demotion order.  It is allowed to only override the top tiers, in
> > >   which cases, the kernel will establish the lower tiers automatically.
> >
> > TBH I still think it is too soon to define proper user visible
> > interfaces for now, particularly for override.
>
> I agree, but there are also needs to make use of tiering even as it
> evolves.  This is why only a minimal sysfs interface is proposed.  We
> can make it read-only and resort to a kernel boot parameter to
> override tiers.
>
> > >
> > >
> > > Kernel Representation
> > > =====================
> > >
> > > * nodemask_t node_states[N_TOPTIER_MEMORY]
> > >
> > >   Store all top-tier memory nodes.
> > >
> > > * nodemask_t memory_tiers[MAX_TIERS]
> > >
> > >   Store memory nodes by tiers.
> >
> > I'd prefer nodemask_t node_states[MAX_TIERS][]. Tier 0 is always the
> > top tier. The kernel could build this with the topology built by
> > firmware.
>
> node_states[N_TOPTIER_MEMORY] is for convenience and can be removed.
>
> node_states is already an existing kernel array (defined as nodemask_t
> node_states[NR_NODE_STATES]).  We need an array for memory tiers, too,
> which is why a new array, memory_tiers, is proposed.
>
> Are you proposing that we make node_states a 2-dimensional array?
> That can duplicate the information already in node_states, which is
> not ideal.

Sorry for the late reply.

Yes, 2-dimensional array. With it we could know what nodes in what tiers.

>
> > >
> > > * struct demotion_nodes node_demotion[]
> > >
> > >   where: struct demotion_nodes { nodemask_t preferred; nodemask_t allowed; }
> > >
> > >   For a node N:
> > >
> > >   node_demotion[N].preferred lists all preferred demotion targets;
> > >
> > >   node_demotion[N].allowed lists all allowed demotion targets
> > >   (initialized to be all the nodes in the same demotion tier).
> >
> > It seems unnecessary to define preferred and allowed IMHO. Why not
> > just use something like the allocation fallback list? The first node
> > in the list is the preferred one. When allocating memory for demotion,
> > convert the list to a nodemask, then call __alloc_pages(gfp, order,
> > first_node, nodemask). So the allocation could fallback to the allowed
> > nodes automatically.
>
> The nodemask "preferred" is an attempt to preserve a current feature
> in node_demotion[]: load balancing among multiple equally-close target
> nodes via random selection.  We can remove it to keep things simple.
>
> The idea of defining "preferred" and "allowed" is exactly to use
> __alloc_pages(gfp, order, preferred_node, allowed_nodemask).  Given
> that the page allocator already computes the allocation fallback list,
> it should be unnecessary to maintain an ordered demotion node list for
> each node and convert such a list to a nodemask for demotion
> allocation.  This is why allowed is stored as a nodemask.

Yeah, it doesn't have to be ordered.

>
> When demoting a page from node N, I think we can just call
> __alloc_pages(gfp, order, N, memory_tiers[node_to_tier(N) + 1]).  If
> so, we can remove node_demotion[] entirely and add a tier field to
> NODE_DATA for node_to_tier().
>
> > >
> > >
> > > Tiering Hierarchy Initialization
> > > ================================
> > >
> > > By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
> > >
> > > A device driver can remove its memory nodes from the top tier, e.g.
> > > a dax driver can remove PMEM nodes from the top tier.
> >
> > With the topology built by firmware we should not need this.
>
> I agree. But before we have such a firmware, the kernel needs to do
> its best to initialize memory tiers.
>
> Given that we know PMEM is slower than DRAM, but a dax device might
> not be PMEM, a better place to set the tier for PMEM nodes can be the
> ACPI code, e.g. acpi_numa_memory_affinity_init() where we can examine
> the ACPI_SRAT_MEM_NON_VOLATILE bit.

This is why I hope firmware could chime in, for example, we may have a
new field, called "Tier", in HMAT. Then kernel just reads the field
and put the node into proper tier. But of course override by kernel
could be allowed.

>
> > >
> > > The kernel builds the memory tiering hierarchy and per-node demotion
> > > order tier-by-tier starting from N_TOPTIER_MEMORY.  For a node N, the
> > > best distance nodes in the next lower tier are assigned to
> > > node_demotion[N].preferred and all the nodes in the next lower tier
> > > are assigned to node_demotion[N].allowed.
> >
> > I'm not sure whether it should be allowed to demote to multiple lower
> > tiers. But it is totally fine to *NOT* allow it at the moment. Once we
> > figure out a good way to define demotion targets, it could be extended
> > to support this easily.
>
> You mean to only support MAX_TIERS=2 for now.  I am fine with that.
> There can be systems with 3 tiers, e.g. GPU -> DRAM -> PMEM, but it is
> not clear yet whether we want to enable transparent memory tiering to
> all the 3 tiers on such systems.

Just start from something simple. And we should fully utilize the
nearest lower tier before demoting to lower lower tiers.

>
> > >
> > > node_demotion[N].preferred can be empty if no preferred demotion node
> > > is available for node N.
> > >
> > > If the userspace overrides the tiers via the memory_tiers sysfs
> > > interface, the kernel then only rebuilds the per-node demotion order
> > > accordingly.
> > >
> > > Memory tiering hierarchy is rebuilt upon hot-add or hot-remove of a
> > > memory node, but is NOT rebuilt upon hot-add or hot-remove of a CPU
> > > node.
> > >
> > >
> > > Memory Allocation for Demotion
> > > ==============================
> > >
> > > When allocating a new demotion target page, both a preferred node
> > > and the allowed nodemask are provided to the allocation function.
> > > The default kernel allocation fallback order is used to allocate the
> > > page from the specified node and nodemask.
> > >
> > > The memopolicy of cpuset, vma and owner task of the source page can
> > > be set to refine the demotion nodemask, e.g. to prevent demotion or
> > > select a particular allowed node as the demotion target.
> > >
> > >
> > > Examples
> > > ========
> > >
> > > * Example 1:
> > >   Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.
> > >
> > >   Node 0 has node 2 as the preferred demotion target and can also
> > >   fallback demotion to node 3.
> > >
> > >   Node 1 has node 3 as the preferred demotion target and can also
> > >   fallback demotion to node 2.
> > >
> > >   Set mempolicy to prevent cross-socket demotion and memory access,
> > >   e.g. cpuset.mems=0,2
> > >
> > > node distances:
> > > node   0    1    2    3
> > >    0  10   20   30   40
> > >    1  20   10   40   30
> > >    2  30   40   10   40
> > >    3  40   30   40   10
> > >
> > > /sys/devices/system/node/memory_tiers
> > > 0-1
> > > 2-3
> > >
> > > N_TOPTIER_MEMORY: 0-1
> > >
> > > node_demotion[]:
> > >   0: [2], [2-3]
> > >   1: [3], [2-3]
> > >   2: [],  []
> > >   3: [],  []
> > >
> > > * Example 2:
> > >   Node 0 & 1 are DRAM nodes.
> > >   Node 2 is a PMEM node and closer to node 0.
> > >
> > >   Node 0 has node 2 as the preferred and only demotion target.
> > >
> > >   Node 1 has no preferred demotion target, but can still demote
> > >   to node 2.
> > >
> > >   Set mempolicy to prevent cross-socket demotion and memory access,
> > >   e.g. cpuset.mems=0,2
> > >
> > > node distances:
> > > node   0    1    2
> > >    0  10   20   30
> > >    1  20   10   40
> > >    2  30   40   10
> > >
> > > /sys/devices/system/node/memory_tiers
> > > 0-1
> > > 2
> > >
> > > N_TOPTIER_MEMORY: 0-1
> > >
> > > node_demotion[]:
> > >   0: [2], [2]
> > >   1: [],  [2]
> > >   2: [],  []
> > >
> > >
> > > * Example 3:
> > >   Node 0 & 1 are DRAM nodes.
> > >   Node 2 is a PMEM node and has the same distance to node 0 & 1.
> > >
> > >   Node 0 has node 2 as the preferred and only demotion target.
> > >
> > >   Node 1 has node 2 as the preferred and only demotion target.
> > >
> > > node distances:
> > > node   0    1    2
> > >    0  10   20   30
> > >    1  20   10   30
> > >    2  30   30   10
> > >
> > > /sys/devices/system/node/memory_tiers
> > > 0-1
> > > 2
> > >
> > > N_TOPTIER_MEMORY: 0-1
> > >
> > > node_demotion[]:
> > >   0: [2], [2]
> > >   1: [2], [2]
> > >   2: [],  []
> > >
> > >
> > > * Example 4:
> > >   Node 0 & 1 are DRAM nodes, Node 2 is a memory-only DRAM node.
> > >
> > >   All nodes are top-tier.
> > >
> > > node distances:
> > > node   0    1    2
> > >    0  10   20   30
> > >    1  20   10   30
> > >    2  30   30   10
> > >
> > > /sys/devices/system/node/memory_tiers
> > > 0-2
> > >
> > > N_TOPTIER_MEMORY: 0-2
> > >
> > > node_demotion[]:
> > >   0: [],  []
> > >   1: [],  []
> > >   2: [],  []
> > >
> > >
> > > * Example 5:
> > >   Node 0 is a DRAM node with CPU.
> > >   Node 1 is a HBM node.
> > >   Node 2 is a PMEM node.
> > >
> > >   With userspace override, node 1 is the top tier and has node 0 as
> > >   the preferred and only demotion target.
> > >
> > >   Node 0 is in the second tier, tier 1, and has node 2 as the
> > >   preferred and only demotion target.
> > >
> > >   Node 2 is in the lowest tier, tier 2, and has no demotion targets.
> > >
> > > node distances:
> > > node   0    1    2
> > >    0  10   21   30
> > >    1  21   10   40
> > >    2  30   40   10
> > >
> > > /sys/devices/system/node/memory_tiers (userspace override)
> > > 1
> > > 0
> > > 2
> > >
> > > N_TOPTIER_MEMORY: 1
> > >
> > > node_demotion[]:
> > >   0: [2], [2]
> > >   1: [0], [0]
> > >   2: [],  []
> > >
> > > -- Wei
