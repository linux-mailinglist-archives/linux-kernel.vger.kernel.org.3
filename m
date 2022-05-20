Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6278452E52F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbiETGoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345947AbiETGoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:44:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A0C14CA37
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653029071; x=1684565071;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BFOIGS+UO6yNQ6oDUnVrSS743SJ5o0AGPw625gUfsq0=;
  b=NhmqhG7eABAOF8eG3/jhcmTXvoG//z6BvKmfWusFJ2jhr4wpxzXa9yEW
   Y/IVYV4NfeOT7Jii2/JfoalSHt+6gWDHiHeQvAwF0W8wwJeYuSaT9MvZr
   RneYAaRMv/w8V/Sz0mQV/u4YDD4CPJ2pfFcUyrmL0gHOg2Y6cc4fS7PoM
   q+3nj4nr8cFzCx9uKrCCn6Fa4nWK2Vz24Jhvt1EpM5I5Ie4GBuPl4ksBl
   wIwfa3vwT6ZzUr1snddHw0kX9Ql+E8TEijNSf236J9EKEKHmHNvy4Z6ij
   YM8j560cKDaejKgJ3q1bQyDWVSXfmGaONB1EDOo7SI9vxQaryPQNlUpQ3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272483819"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272483819"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:44:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="546529712"
Received: from xinyutan-mobl.ccr.corp.intel.com ([10.254.215.154])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:44:28 -0700
Message-ID: <4977e67c975723c98a441e08cc9f001b69f5668e.camel@intel.com>
Subject: Re: [LKP] Re: [sched/numa]  bb2dee337b:  unixbench.score -11.2%
 regression
From:   Ying Huang <ying.huang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, fengwei.yin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>, yu.c.chen@intel.com
Date:   Fri, 20 May 2022 14:44:26 +0800
In-Reply-To: <5941ce856343c314f829852d3a831cdd19f06573.camel@intel.com>
References: <20220511143038.4620-4-mgorman@techsingularity.net>
         <20220518092414.GA15472@xsang-OptiPlex-9020>
         <20220518152258.GR3441@techsingularity.net>
         <5941ce856343c314f829852d3a831cdd19f06573.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-19 at 15:54 +0800, ying.huang@intel.com wrote:
> Hi, Mel,
> 
> On Wed, 2022-05-18 at 16:22 +0100, Mel Gorman wrote:
> > On Wed, May 18, 2022 at 05:24:14PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed a -11.2% regression of unixbench.score due to commit:
> > > 
> > > 
> > > commit: bb2dee337bd7d314eb7c7627e1afd754f86566bc ("[PATCH 3/4] sched/numa: Apply imbalance limitations consistently")
> > > url: https://github.com/intel-lab-lkp/linux/commits/Mel-Gorman/Mitigate-inconsistent-NUMA-imbalance-behaviour/20220511-223233
> > > base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git d70522fc541224b8351ac26f4765f2c6268f8d72
> > > patch link: https://lore.kernel.org/lkml/20220511143038.4620-4-mgorman@techsingularity.net
> > > 
> > > in testcase: unixbench
> > > on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz with 256G memory
> > > with following parameters:
> > > 
> > > 	runtime: 300s
> > > 	nr_task: 1
> > > 	test: shell8
> > > 	cpufreq_governor: performance
> > > 	ucode: 0xd000331
> > > 
> > > test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
> > > test-url: https://github.com/kdlucas/byte-unixbench
> > 
> > I think what is happening for unixbench is that it prefers to run all
> > instances on a local node if possible. shell8 is creating 8 scripts,
> > each of which spawn more processes. The total number of tasks may exceed
> > the allowed imbalance at fork time of 16 tasks. Some spill over to a
> > remote node and as they are using files, some accesses are remote and it
> > suffers. It's not memory bandwidth bound but is sensitive to locality.
> > The stats somewhat support this idea
> > 
> > >      83590 ± 13%     -73.7%      21988 ± 32%  numa-meminfo.node0.AnonHugePages
> > >     225657 ± 18%     -58.0%      94847 ± 18%  numa-meminfo.node0.AnonPages
> > >     231652 ± 17%     -55.3%     103657 ± 16%  numa-meminfo.node0.AnonPages.max
> > >     234525 ± 17%     -55.5%     104341 ± 18%  numa-meminfo.node0.Inactive
> > >     234397 ± 17%     -55.5%     104267 ± 18%  numa-meminfo.node0.Inactive(anon)
> > >      11724 ±  7%     +17.5%      13781 ±  5%  numa-meminfo.node0.KernelStack
> > >       4472 ± 34%    +117.1%       9708 ± 31%  numa-meminfo.node0.PageTables
> > >      15239 ± 75%    +401.2%      76387 ± 10%  numa-meminfo.node1.AnonHugePages
> > >      67256 ± 63%    +206.3%     205994 ±  6%  numa-meminfo.node1.AnonPages
> > >      73568 ± 58%    +193.1%     215644 ±  6%  numa-meminfo.node1.AnonPages.max
> > >      75737 ± 53%    +183.9%     215053 ±  6%  numa-meminfo.node1.Inactive
> > >      75709 ± 53%    +183.9%     214971 ±  6%  numa-meminfo.node1.Inactive(anon)
> > >       3559 ± 42%    +187.1%      10216 ±  8%  numa-meminfo.node1.PageTables
> > 
> > There is less memory used on one node and more on the other so it's
> > getting split.
> 
> This makes sense.  I will also check CPU utilization per node to verify
> this directly.

I run this workload 3 times for the commit and its parent with mpstat
node statistics.

For the parent commit,

  "mpstat.node.0.usr%": [
    0.1396875,
    3.0806153846153848,
    0.05303030303030303
  ],
  "mpstat.node.0.sys%": [
    0.10515625,
    5.597692307692308,
    0.1340909090909091
  ],

  "mpstat.node.1.usr%": [
    3.1015625,
    0.1306153846153846,
    3.0275757575757574
  ],
  "mpstat.node.1.sys%": [
    5.66703125,
    0.11676923076923076,
    5.498181818181818
  ],

The difference between two nodes are quite large.

For the commit,

  "mpstat.node.0.usr%": [
    1.42109375,
    1.4725,
    1.5140625
  ],
  "mpstat.node.0.sys%": [
    3.00125,
    3.16390625,
    3.1284375
  ],

  "mpstat.node.1.usr%": [
    1.4909375,
    1.41609375,
    1.3740625
  ],
  "mpstat.node.1.sys%": [
    3.1671875,
    3.00109375,
    3.044375
  ],

The difference between 2 nodes reduces greatly.  So this proves your
theory directly.

Best Regards,
Huang, Ying


[snip]

