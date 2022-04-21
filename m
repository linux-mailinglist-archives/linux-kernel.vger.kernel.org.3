Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C3850A6F2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384833AbiDURW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390729AbiDURWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:22:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9845849F97
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:19:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so8308652pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AbrAgTuOHuSFvVLu+FxwQe0L1i24p9oP36C6BGa4L9w=;
        b=l6/LXh17bunh8O2uxngpbbIqFaCcmR/chYHKdEjHBbFyFFUQKVlxfn+b344LeogsIF
         b1VNKzLlMVuELXjXgN7LmG0YeOF5j2IeS+tFDxSqzO2TtNSLXNQD77MOsNrYFrPGOtFM
         5gSCKKEoawZP+tULlaJbatdtzIdZV2M1SZ8Cd3MO4SbRmFG5nwO1EcEwBwJY62LiPPAo
         XIRN+ys7H6CC1xDX5UWPJ4/VeHAoKBMFxjuBMWlTLtXdePSzY19vrfPzoPgzkFWnHP0u
         0omehIgs+Hl8fs5vnKYt0RynTzeA/MmrmLPDguXRkJwQL0FpyUX6jQO5BBaI345XfZtQ
         LAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AbrAgTuOHuSFvVLu+FxwQe0L1i24p9oP36C6BGa4L9w=;
        b=l2gBKtCN5arVkBLkqnZB44fKxZ3xVyVaCi4VVe24eUz3upWSrRFHtua5nIW+qkMmoY
         rA/jr6jAN9kv3tfMrsf+JZBBe6yoo2PUb5JVoPBqVcjD8NAD7cv07K+sU19Gyp4TeDnj
         hj8m1Z9eZ1Dgc6kFBQz7KoNgithEd+X3rIcZ8xOr1TAlpFNGiqqLXpWBDqz0SIWdJDKW
         /DC4UDEIzj6iwwjjDSb+vHVrkP6bDdKIzFg6baDjNx4bDuC+qfYATdHhW21KlZYir2S2
         T0DHSq9v6+pSXnTBdGSXye7pKq82r33+ek/+yVTiAYuEANtUefgsgDr7EXY3d5VNetO9
         Qk6Q==
X-Gm-Message-State: AOAM532xRdQ39q+GC3qagjCxEYKfM+kLK+GTn6m6ZAkeiIBvgi4VXPpi
        1SvXna0SwJKdsPct/hSkBSxH4wrkxRwpij4Jwyg=
X-Google-Smtp-Source: ABdhPJzgZBs9MdKT8UNJORX5Br/7o81raOVhGzJmuR7XhRqvLbUY0ITH3K7ab0YkazTk2YMPzbFsxrvfS8+oXU+9oa8=
X-Received: by 2002:a17:902:eb84:b0:158:8a72:bbdd with SMTP id
 q4-20020a170902eb8400b001588a72bbddmr269701plg.117.1650561590127; Thu, 21 Apr
 2022 10:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220407020953.475626-1-shy828301@gmail.com> <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
 <CAHbLzkq+eKcKCsxXDTiOcBxk8FjMdWBqOxwi4N_NG7PZWbAAkA@mail.gmail.com>
 <Yl/FS9enAD4V8jG3@ziqianlu-nuc9qn> <f27ec36beb3cf1dbbfc3b8835e586d5d6fe7f561.camel@intel.com>
 <YmFmL42W+OrORElV@ziqianlu-nuc9qn>
In-Reply-To: <YmFmL42W+OrORElV@ziqianlu-nuc9qn>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 21 Apr 2022 10:19:37 -0700
Message-ID: <CAHbLzkqU7T_ABvQEmLe382JtwcB=m2-Y+smo8ZBDdQF4C=b_yQ@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 7:12 AM Aaron Lu <aaron.lu@intel.com> wrote:
>
> On Thu, Apr 21, 2022 at 03:49:21PM +0800, ying.huang@intel.com wrote:
> > On Wed, 2022-04-20 at 16:33 +0800, Aaron Lu wrote:
> > > On Thu, Apr 07, 2022 at 10:36:54AM -0700, Yang Shi wrote:
> > > > On Thu, Apr 7, 2022 at 1:12 AM Aaron Lu <aaron.lu@intel.com> wrote:
> > > > >
> > > > > On Wed, Apr 06, 2022 at 07:09:53PM -0700, Yang Shi wrote:
> > > > > > The swap devices are linked to per node priority lists, the swap device
> > > > > > closer to the node has higher priority on that node's priority list.
> > > > > > This is supposed to improve I/O latency, particularly for some fast
> > > > > > devices.  But the current code gets nid by calling numa_node_id() which
> > > > > > actually returns the nid that the reclaimer is running on instead of the
> > > > > > nid that the page belongs to.
> > > > > >
> > > > >
> > > > > Right.
> > > > >
> > > > > > Pass the page's nid dow to get_swap_pages() in order to pick up the
> > > > > > right swap device.  But it doesn't work for the swap slots cache which
> > > > > > is per cpu.  We could skip swap slots cache if the current node is not
> > > > > > the page's node, but it may be overkilling. So keep using the current
> > > > > > node's swap slots cache.  The issue was found by visual code inspection
> > > > > > so it is not sure how much improvement could be achieved due to lack of
> > > > > > suitable testing device.  But anyway the current code does violate the
> > > > > > design.
> > > > > >
> > > > >
> > > > > I intentionally used the reclaimer's nid because I think when swapping
> > > > > out to a device, it is faster when the device is on the same node as
> > > > > the cpu.
> > > >
> > > > OK, the offline discussion with Huang Ying showed the design was to
> > > > have page's nid in order to achieve better I/O performance (more
> > > > noticeable on faster devices) since the reclaimer may be running on a
> > > > different node from the reclaimed page.
> > > >
> > > > >
> > > > > Anyway, I think I can make a test case where the workload allocates all
> > > > > its memory on the remote node and its workingset memory is larger then
> > > > > the available memory so swap is triggered, then we can see which way
> > > > > achieves better performance. Sounds reasonable to you?
> > > >
> > > > Yeah, definitely, thank you so much. I don't have a fast enough device
> > > > by hand to show the difference right now. If you could get some data
> > > > it would be perfect.
> > > >
> > >
> > > Failed to find a test box that has two NVMe disks attached to different
> > > nodes and since Shanghai is locked down right now, we couldn't install
> > > another NVMe on the box so I figured it might be OK to test on a box that
> > > has a single NVMe attached to node 0 like this:
> > >
> > > 1) restrict the test processes to run on node 0 and allocate on node 1;
> > > 2) restrict the test processes to run on node 1 and allocate on node 0.
> > >
> > > In case 1), the reclaimer's node id is the same as the swap device's so
> > > it's the same as current behaviour and in case 2), the page's node id is
> > > the same as the swap device's so it's what your patch proposed.
> > >
> > > The test I used is vm-scalability/case-swap-w-rand:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-swap-w-seq
> > > which spawns $nr_task processes and each will mmap $size and then
> > > randomly write to that area. I set nr_task=32 and $size=4G, so a total
> > > of 128G memory will be needed and I used memory.limit_in_bytes to
> > > restrict the available memory to 64G, to make sure swap is triggered.
> > >
> > > The reason why cgroup is used is to avoid waking up the per-node kswapd
> > > which can trigger swapping with reclaimer/page/swap device all having the
> > > same node id.
> > >
> > > And I don't see a measuable difference from the result:
> > > case1(using reclaimer's node id) vm-scalability.throughput: 10574 KB/s
> > > case2(using page's node id)      vm-scalability.throughput: 10567 KB/s
> > >
> > > My interpretation of the result is, when reclaiming a remote page, it
> > > doesn't matter much which swap device to use if the swap device is a IO
> > > device.
> > >
> > > Later Ying reminded me we have test box that has optane installed on
> > > different nodes so I also tested there: Icelake 2 sockets server with 2
> > > optane installed on each node. I did the test there like this:
> > > 1) restrict the test processes to run on node 0 and allocate on node 1
> > >    and only swapon pmem0, which is the optane backed swap device on node 0;
> > > 2) restrict the test processes to run on node 0 and allocate on node 1
> > >    and only swapon pmem1, which is the optane backed swap device on node 1.
> > >
> > > So case 1) is current behaviour and case 2) is what your patch proposed.
> > >
> > > With the same test and the same nr_task/size, the result is:
> > > case1(using reclaimer's node id) vm-scalability.throughput: 71033 KB/s
> > > case2(using page's node id)      vm-scalability.throughput: 58753 KB/s
> > >
> >
> > The per-node swap device support is more about swap-in latency than
> > swap-out throughput.  I suspect the test case is more about swap-out
> > throughput.  perf profiling can show this.
> >
>
> On another thought, swap out can very well affect swap in latency:
> since swap is involved, the available memory is in short supply and swap
> in may very likely need to reclaim a page and that reclaim can involve a
> swap out, so swap out performance can also affect swap in latency.

If you count in page allocation latency, yes. I think we could just
measure the I/O latency, for example, swap_readpage()? I'm supposed
the per-node swap device is aimed to minimize I/O latency.

>
> > For swap-in latency, we can use pmbench, which can output latency
> > information.
> >
> > Best Regards,
> > Huang, Ying
> >
> >
> > [snip]
> >
>
