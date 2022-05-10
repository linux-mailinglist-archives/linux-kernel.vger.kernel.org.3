Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70427520CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 06:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiEJEiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 00:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbiEJEhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 00:37:15 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F221A075C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 21:32:23 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id p1so6212910uak.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 21:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Wbz24k8xjmUuPLei/zNpZK/WIYdnk4llOYq685eLRM=;
        b=mDcPIbNuXIE/Aw2IWNYjGS7CWMKV0V9DdkVv1Z1/BFInvc7e3cabhTTCMRHlVVYDJZ
         cOsJxOGaAuBSMIF1Iv2dLL5gm8PRTUzihr6m5RhpaRr3+jfgaS5PeN392GfwVFpJmlE2
         wqPNo0ugnwx5jL8LvzPat3rJlRAFcu7D7S4mYlXKk96tKy6jr+VzrxEDnl0/n+HQ0DQZ
         RQSFTG+t5tOAwlHduWOXZSJojiZXx9thViC30HpODEGL4n+K/0p+GQeOmMHYKHu9hGAw
         F+ryed9WgCX8HL275PrtaKxA87B/lt9FldnyMCjYSm4FzBcThnpp9Z+w9D5lKhOb4/Z3
         XTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Wbz24k8xjmUuPLei/zNpZK/WIYdnk4llOYq685eLRM=;
        b=Of0cf4swJgBuavLhLSZCcI1HtqYYMXntA+hPlPEpVP6vf50uQJ0bJSS2/lnxBzvxrE
         g9o2ShlnwLpWfxeeR7eXOAd3FBO3jpquRnBv5yCBKFqDeIcC2e/DezPdteV8xfT4eMk/
         ro6zlt0C56xD1HUwtmdQPXLJ1IM4cJAgX9kr5dW1b7pUXJvd2IWVJYvlZWwNuiWJmiuu
         L+aMbo6asHAzyUb7K9aOCsYfYovlPJ2eYcib/Wh8xt4BlDoYS9G/RKj9jpEaEQf2520H
         YWC+cL5BUVM9UPjfAYLVNFvKoSTrXfk4+eLKxSUHCixxzUAF6oZYvtpyAAZ/hR+Uc1Sf
         P+6A==
X-Gm-Message-State: AOAM5318Z1QTXvr7rDcq4qMiSiRLzpxOLo7LmB09l4V4IeLhPllo7ZQ0
        caalxLmTt8z8NkFFdQXhEMhyBmwEJv/VUB73Tq8LCQ==
X-Google-Smtp-Source: ABdhPJzmAbcvtr7lvEBP2nq942xQKZnM9LB74EU0RWqE9iN+VKrVLJmSJEkkdmrV8hpcWwDxVKgXa5pXtn9yyRA+FcU=
X-Received: by 2002:ab0:7643:0:b0:362:833d:5bfb with SMTP id
 s3-20020ab07643000000b00362833d5bfbmr11063151uaq.4.1652157141544; Mon, 09 May
 2022 21:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
 <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com> <87tua3h5r1.fsf@nvdebian.thelocal>
In-Reply-To: <87tua3h5r1.fsf@nvdebian.thelocal>
From:   Wei Xu <weixugc@google.com>
Date:   Mon, 9 May 2022 21:32:10 -0700
Message-ID: <CAAPL-u-0HwL6p1SA73LPfFyywG55QqE9O+q=83fhShoJAVVxyQ@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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

On Thu, May 5, 2022 at 5:19 PM Alistair Popple <apopple@nvidia.com> wrote:
>
> Wei Xu <weixugc@google.com> writes:
>
> [...]
>
> >> >
> >> >
> >> > Tiering Hierarchy Initialization
> >> > `=============================='
> >> >
> >> > By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
> >> >
> >> > A device driver can remove its memory nodes from the top tier, e.g.
> >> > a dax driver can remove PMEM nodes from the top tier.
> >>
> >> With the topology built by firmware we should not need this.
>
> I agree that in an ideal world the hierarchy should be built by firmware based
> on something like the HMAT. But I also think being able to override this will be
> useful in getting there. Therefore a way of overriding the generated hierarchy
> would be good, either via sysfs or kernel boot parameter if we don't want to
> commit to a particular user interface now.
>
> However I'm less sure letting device-drivers override this is a good idea. How
> for example would a GPU driver make sure it's node is in the top tier? By moving
> every node that the driver does not know about out of N_TOPTIER_MEMORY? That
> could get messy if say there were two drivers both of which wanted their node to
> be in the top tier.

The suggestion is to allow a device driver to opt out its memory
devices from the top-tier, not the other way around.

I agree that the kernel should still be responsible for the final
node-tier assignment by taking into account all factors: the firmware
tables, device driver requests, and user-overrides (kernel argument or
sysfs).

> > I agree. But before we have such a firmware, the kernel needs to do
> > its best to initialize memory tiers.
> >
> > Given that we know PMEM is slower than DRAM, but a dax device might
> > not be PMEM, a better place to set the tier for PMEM nodes can be the
> > ACPI code, e.g. acpi_numa_memory_affinity_init() where we can examine
> > the ACPI_SRAT_MEM_NON_VOLATILE bit.
> >
> >> >
> >> > The kernel builds the memory tiering hierarchy and per-node demotion
> >> > order tier-by-tier starting from N_TOPTIER_MEMORY.  For a node N, the
> >> > best distance nodes in the next lower tier are assigned to
> >> > node_demotion[N].preferred and all the nodes in the next lower tier
> >> > are assigned to node_demotion[N].allowed.
> >>
> >> I'm not sure whether it should be allowed to demote to multiple lower
> >> tiers. But it is totally fine to *NOT* allow it at the moment. Once we
> >> figure out a good way to define demotion targets, it could be extended
> >> to support this easily.
> >
> > You mean to only support MAX_TIERS=2 for now.  I am fine with that.
> > There can be systems with 3 tiers, e.g. GPU -> DRAM -> PMEM, but it is
> > not clear yet whether we want to enable transparent memory tiering to
> > all the 3 tiers on such systems.
>
> At some point I think we will need to deal with 3 tiers but I'd be ok with
> limiting it to 2 for now if it makes things simpler.
>
> - Alistair
>
> >> >
> >> > node_demotion[N].preferred can be empty if no preferred demotion node
> >> > is available for node N.
> >> >
> >> > If the userspace overrides the tiers via the memory_tiers sysfs
> >> > interface, the kernel then only rebuilds the per-node demotion order
> >> > accordingly.
> >> >
> >> > Memory tiering hierarchy is rebuilt upon hot-add or hot-remove of a
> >> > memory node, but is NOT rebuilt upon hot-add or hot-remove of a CPU
> >> > node.
> >> >
> >> >
> >> > Memory Allocation for Demotion
> >> > `============================'
> >> >
> >> > When allocating a new demotion target page, both a preferred node
> >> > and the allowed nodemask are provided to the allocation function.
> >> > The default kernel allocation fallback order is used to allocate the
> >> > page from the specified node and nodemask.
> >> >
> >> > The memopolicy of cpuset, vma and owner task of the source page can
> >> > be set to refine the demotion nodemask, e.g. to prevent demotion or
> >> > select a particular allowed node as the demotion target.
> >> >
> >> >
> >> > Examples
> >> > `======'
> >> >
> >> > * Example 1:
> >> >   Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.
> >> >
> >> >   Node 0 has node 2 as the preferred demotion target and can also
> >> >   fallback demotion to node 3.
> >> >
> >> >   Node 1 has node 3 as the preferred demotion target and can also
> >> >   fallback demotion to node 2.
> >> >
> >> >   Set mempolicy to prevent cross-socket demotion and memory access,
> >> >   e.g. cpuset.mems=0,2
> >> >
> >> > node distances:
> >> > node   0    1    2    3
> >> >    0  10   20   30   40
> >> >    1  20   10   40   30
> >> >    2  30   40   10   40
> >> >    3  40   30   40   10
> >> >
> >> > /sys/devices/system/node/memory_tiers
> >> > 0-1
> >> > 2-3
> >> >
> >> > N_TOPTIER_MEMORY: 0-1
> >> >
> >> > node_demotion[]:
> >> >   0: [2], [2-3]
> >> >   1: [3], [2-3]
> >> >   2: [],  []
> >> >   3: [],  []
> >> >
> >> > * Example 2:
> >> >   Node 0 & 1 are DRAM nodes.
> >> >   Node 2 is a PMEM node and closer to node 0.
> >> >
> >> >   Node 0 has node 2 as the preferred and only demotion target.
> >> >
> >> >   Node 1 has no preferred demotion target, but can still demote
> >> >   to node 2.
> >> >
> >> >   Set mempolicy to prevent cross-socket demotion and memory access,
> >> >   e.g. cpuset.mems=0,2
> >> >
> >> > node distances:
> >> > node   0    1    2
> >> >    0  10   20   30
> >> >    1  20   10   40
> >> >    2  30   40   10
> >> >
> >> > /sys/devices/system/node/memory_tiers
> >> > 0-1
> >> > 2
> >> >
> >> > N_TOPTIER_MEMORY: 0-1
> >> >
> >> > node_demotion[]:
> >> >   0: [2], [2]
> >> >   1: [],  [2]
> >> >   2: [],  []
> >> >
> >> >
> >> > * Example 3:
> >> >   Node 0 & 1 are DRAM nodes.
> >> >   Node 2 is a PMEM node and has the same distance to node 0 & 1.
> >> >
> >> >   Node 0 has node 2 as the preferred and only demotion target.
> >> >
> >> >   Node 1 has node 2 as the preferred and only demotion target.
> >> >
> >> > node distances:
> >> > node   0    1    2
> >> >    0  10   20   30
> >> >    1  20   10   30
> >> >    2  30   30   10
> >> >
> >> > /sys/devices/system/node/memory_tiers
> >> > 0-1
> >> > 2
> >> >
> >> > N_TOPTIER_MEMORY: 0-1
> >> >
> >> > node_demotion[]:
> >> >   0: [2], [2]
> >> >   1: [2], [2]
> >> >   2: [],  []
> >> >
> >> >
> >> > * Example 4:
> >> >   Node 0 & 1 are DRAM nodes, Node 2 is a memory-only DRAM node.
> >> >
> >> >   All nodes are top-tier.
> >> >
> >> > node distances:
> >> > node   0    1    2
> >> >    0  10   20   30
> >> >    1  20   10   30
> >> >    2  30   30   10
> >> >
> >> > /sys/devices/system/node/memory_tiers
> >> > 0-2
> >> >
> >> > N_TOPTIER_MEMORY: 0-2
> >> >
> >> > node_demotion[]:
> >> >   0: [],  []
> >> >   1: [],  []
> >> >   2: [],  []
> >> >
> >> >
> >> > * Example 5:
> >> >   Node 0 is a DRAM node with CPU.
> >> >   Node 1 is a HBM node.
> >> >   Node 2 is a PMEM node.
> >> >
> >> >   With userspace override, node 1 is the top tier and has node 0 as
> >> >   the preferred and only demotion target.
> >> >
> >> >   Node 0 is in the second tier, tier 1, and has node 2 as the
> >> >   preferred and only demotion target.
> >> >
> >> >   Node 2 is in the lowest tier, tier 2, and has no demotion targets.
> >> >
> >> > node distances:
> >> > node   0    1    2
> >> >    0  10   21   30
> >> >    1  21   10   40
> >> >    2  30   40   10
> >> >
> >> > /sys/devices/system/node/memory_tiers (userspace override)
> >> > 1
> >> > 0
> >> > 2
> >> >
> >> > N_TOPTIER_MEMORY: 1
> >> >
> >> > node_demotion[]:
> >> >   0: [2], [2]
> >> >   1: [0], [0]
> >> >   2: [],  []
> >> >
> >> > -- Wei
