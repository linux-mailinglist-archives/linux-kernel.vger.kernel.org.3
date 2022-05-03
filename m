Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C772E517D7B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiECGkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiECGkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:40:12 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EE121811
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 23:36:41 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id 63so6052062uaw.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 23:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u86aQVHE0YFRCOAXwD0Lj1Q5WX8rv8Wdn7lFhRDk8T4=;
        b=EG9OoauTSQf1V/WWgNjp/LVUiVAquxw61d3vyxT5MtCeBtnGc0q/L6g5LqYuU+4GbA
         vRkrFQnEhxvEnDbPfWpWsuh5VRXTWiv4xWF+qOT976IBFgReJj/Jh1E+dTI4NljfOfex
         s9Gg7hDl919BI0IDcMKYZGWTn5eUffOtI179wUNipICzAHU/sjgrzbbivNuS6li+jV7y
         qF0CVWwsQwG424ps5RZN4VmzuP+ZyZ/PPxBgrkqX9hChX+JAvEsPsSGnmuxN6s/lL0Tz
         ozDLXOFRUM+WfMpf/xin9Un+5oKdGhB2ij/sYIjMMNFJDNQRK2eBClBAvUNJ1t4BxQ5J
         GDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u86aQVHE0YFRCOAXwD0Lj1Q5WX8rv8Wdn7lFhRDk8T4=;
        b=XeqdSoV7t5EazQEYfI97SNCsITAO2dCmuF4r5Ye1bmpQnZGT7SE9DYGEMSKs85C1g8
         68Uyjioe23GViHWyz6J2AiqYIbuP2plwnPrLtJjRHbR39Tov5a9goDAd/pOenbepg0pK
         E3awy2/CH97wgoGXkkxAmVbiTDOIefLMGD8NLCVXRcdBsSA1llPnHUKbT1compuXJS2A
         NUgPUv6ZOGfl51IuG4YTsibtSZC+mrg6596dGHkX37RXjsf2i0wjZ7ZMUMWhv83MEndB
         TZCSyDSqs4XNcCdd6j+ziPzgqgP5NCBZec3lFCoKdpV4LxcHmYc8ORbO/0H4qwUMBOKH
         1Y+g==
X-Gm-Message-State: AOAM530HGZYSoaNuKkAPn8GfL/p/9JoHfL49tdTsV5k/WPDtVOsSph+/
        T+/UehuMlcPubS/gEakFavI7rsSSrYM2Kn+Hj43glw==
X-Google-Smtp-Source: ABdhPJyC+d1398MY/r3CNy5+vr0F03VvuWn3HbON/3UtBav7rsXAW9341lvfNA5RTGpHb5/y0HxGg9FwUbnx1nDLlmQ=
X-Received: by 2002:a9f:356c:0:b0:359:5bee:d1f8 with SMTP id
 o99-20020a9f356c000000b003595beed1f8mr4238703uao.60.1651559800098; Mon, 02
 May 2022 23:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com> <CAPcyv4g7kyPsSKGT1rR4yy680VD6UJ8V7wzj0OUqN2y2-PjOpQ@mail.gmail.com>
In-Reply-To: <CAPcyv4g7kyPsSKGT1rR4yy680VD6UJ8V7wzj0OUqN2y2-PjOpQ@mail.gmail.com>
From:   Wei Xu <weixugc@google.com>
Date:   Mon, 2 May 2022 23:36:29 -0700
Message-ID: <CAAPL-u8yLxwJKB=O9eKRP5YMWTdrCR5HG4dy6owYbwpvjs976A@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
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
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Sun, May 1, 2022 at 11:35 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Apr 29, 2022 at 8:59 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > Hi Wei,
> >
> > Thanks for the nice writing. Please see the below inline comments.
> >
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
> Just want to note here that the platform firmware can only describe
> the tiers of static memory present at boot. CXL hotplug breaks this
> model and the kernel is left to dynamically determine the device's
> performance characteristics and the performance of the topology to
> reach that device. Now, the platform firmware does set expectations
> for the perfomance class of different memory ranges, but there is no
> way to know in advance the performance of devices that will be asked
> to be physically or logically added to the memory configuration. That
> said, it's probably still too early to define ABI for those
> exceptional cases where the kernel needs to make a policy decision
> about a device that does not fit into the firmware's performance
> expectations, but just note that there are limits to the description
> that platform firmware can provide.
>
> I agree that NUMA distance alone is inadequate and the kernel needs to
> make better use of data like ACPI HMAT to determine the default
> tiering order.

Very useful clarification. It should be fine for the kernel to
dynamically determine the memory tier of each node.  I expect that it
can also be fine even if a node gets attached to a different memory
device and needs to be assigned into a different tier after another
round of hot-remove/hot-add.

What can be problematic is that a hot-added node not only changes its
own iter, but also causes other existing nodes to change their tiers.
This can mess up any tier-based memory accounting.

One approach to address this is to:

- have tiers being well-defined and stable, e.g. HBM is always in
tier-0, direct-attached DRAM and high-performance CXL.mem devices are
always in tier-1, slower CXL.mem devices are always in tier-2, and
PMEM is always in tier-3.  The tier definition is based on the device
performance, something similar to the class rating of storage devices
(e.g. SD cards).

- allow tiers being absent in the system, e.g. a machine may have only
tier-1 and tier-3, but have neither tier-0 nor tier-2.

- allow demotion to not only the immediate next lower tier, but all
lower tiers.  The actual selection of demotion order follows the
allocation fallback order.   This allows tier-1 to directly demote to
tier-3 without requiring the presence of tier-2.

This approach can ensure that the tiers of existing nodes are stable
and permit that the tier of a hot-plugged node is determined
dynamically.
