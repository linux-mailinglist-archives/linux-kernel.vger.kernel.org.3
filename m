Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9472753D264
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349283AbiFCTdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345106AbiFCTdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:33:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDE85AED6;
        Fri,  3 Jun 2022 12:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 48D72CE24B8;
        Fri,  3 Jun 2022 19:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8C4C385A9;
        Fri,  3 Jun 2022 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654284792;
        bh=2ByfKvFYvZhMqrUp+rYahiUIhOnNW0Ea7GJcrPcUbxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXQ/XCIXd1STmxHiUoqepOTnaqT1SSVUk/hEp2I6lxl3rlFVA6HoZGBoJijXDVvlH
         naPUVt+vUVxz4jCjHVVmJ+iFuoJLHTMdMNloaJQcdXKS4B9ZcDzMfoyohpn7LkvlUg
         axU5unijPz+ObcYze3mRqiw828jlyk+jRHy/x7dTuF1cZOxT4J+xFibBME0kspmVEL
         zuWtsysWkCDwQqU5RCJm79KnU80a2hGlixqc/YdmoBZQVDZcXSL0kipCPOuKss0sbi
         NQkdpBdDdQkbHRWd8JeMjFrEheYAmjCo9ktMKvqN3iC8xehlE8jpfucOyGKaHhU5kc
         OZER2Pvx3DCHQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2050A4096F; Fri,  3 Jun 2022 21:33:10 +0200 (CEST)
Date:   Fri, 3 Jun 2022 21:33:10 +0200
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Alyssa Ross <hi@alyssa.is>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/12] perf c2c: Support display for Arm64
Message-ID: <Ypph9lA1qavXXZI5@kernel.org>
References: <20220530114036.3225544-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530114036.3225544-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 30, 2022 at 07:40:24PM +0800, Leo Yan escreveu:
> Arm64 Neoverse CPUs supports data source in Arm SPE trace, this allows
> us to detect cache line contention and transfers.
> 
> This patch set is based on Ali Said's patch set v9 "perf: arm-spe: Decode SPE
> source and use for perf c2c" [1] and Ali's patch set doesn't need any
> change in this new round.

IIRC there is a kernel part there, please let me know when that part
gets merged so that I can process this 12 patches long set.

- Arnaldo
 
> To clearly show peer loads and express the local peer loads and remote
> peer lodes, this patch introduces three new metrics 'lcl_peer',
> 'rmt_peer' and 'tot_peer'.  The display 'peer' mode uses metric
> 'tot_peer' for sorting cache lines.
> 
> Patches 01-05 adds statistics for memory samples, and add dimensions for
> peer metrics.
> 
> Patches 06-09 are for refactoring, it refines the code with more general
> naming so this can allow us to easier to extend display modes but not
> strictly bound to HITM tags.
> 
> Patches 10-11 are to extend display 'peer' mode, and also changes to use
> 'peer' mode as default mode for Arm64 arches.
> 
> Patch 12 updates document to describe the new dimensions for peer
> metrics.
> 
> This patch set has been verified for both x86 and Arm64 memory samples.
> 
> Known issues:  Joe reminded there have an issue in patch set v3 that the
> cache line metric shows 'N/A' for node, this is because Arm SPE trace
> data doesn't contain physical address and leads to perf c2c tool fails
> to find matched node range if physical address is zero.  This issue is
> addressed in a separte patch [2].  Since I am still using the old
> perf data file (I have no Neoverse platforms), the output result still
> shows the Node field is 'N/A'.
> 
> Another thing is we need to enhance data source setting for old Arm
> platforms.  As discussed, German would follow up this task later.
> 
> The latest patch set has been uploaded on the git server [3].
> 
> The display result with x86 memory samples:
> 
>   =================================================
>              Shared Data Cache Line Table          
>   =================================================
>   #
>   #        ----------- Cacheline ----------      Tot  ------- Load Hitm -------    Total    Total    Total  --------- Stores --------  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
>   # Index             Address  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads   Stores    L1Hit   L1Miss      N/A       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
>   # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
>   #
>         0      0x55c8971f0080     0    1967   66.14%      252      252        0     6044     3550     2494     2024      470        0      528     2672       78        20      252         0        0         0         0
>         1      0x55c8971f00c0     0       1   33.86%      129      129        0      914      914        0        0        0        0      272      374       52        87      129         0        0         0         0
> 
>   =================================================
>         Shared Cache Line Distribution Pareto      
>   =================================================
>   #
>   #        ----- HITM -----  ------- Store Refs ------  --------- Data address ---------                      ---------- cycles ----------    Total       cpu                                     Shared                               
>   #   Num  RmtHitm  LclHitm   L1 Hit  L1 Miss      N/A              Offset  Node  PA cnt        Code address  rmt hitm  lcl hitm      load  records       cnt                  Symbol             Object              Source:Line  Node
>   # .....  .......  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  .......  ........  ......................  .................  .......................  ....
>   #
>     ----------------------------------------------------------------------
>         0        0      252     2024      470        0      0x55c8971f0080
>     ----------------------------------------------------------------------
>              0.00%   12.30%    0.00%    0.00%    0.00%                 0x0     0       1      0x55c8971ed3e9         0      1313       863     1222         3  [.] 0x00000000000013e9  false_sharing.exe  false_sharing.exe[13e9]   0
>              0.00%    0.79%   90.51%    0.00%    0.00%                 0x0     0       1      0x55c8971ed3e2         0      1800       878     3029         3  [.] 0x00000000000013e2  false_sharing.exe  false_sharing.exe[13e2]   0
>              0.00%    0.00%    9.49%  100.00%    0.00%                 0x0     0       1      0x55c8971ed3f4         0         0         0      662         3  [.] 0x00000000000013f4  false_sharing.exe  false_sharing.exe[13f4]   0
>              0.00%   86.90%    0.00%    0.00%    0.00%                0x20     0       1      0x55c8971ed447         0       141       103     1131         2  [.] 0x0000000000001447  false_sharing.exe  false_sharing.exe[1447]   0
> 
>     ----------------------------------------------------------------------
>         1        0      129        0        0        0      0x55c8971f00c0
>     ----------------------------------------------------------------------
>              0.00%  100.00%    0.00%    0.00%    0.00%                0x20     0       1      0x55c8971ed455         0        88        94      914         2  [.] 0x0000000000001455  false_sharing.exe  false_sharing.exe[1455]   0
> 
> 
> The display result with Arm SPE:
> 
>   =================================================
>              Shared Data Cache Line Table          
>   =================================================
>   #
>   #        ----------- Cacheline ----------     Peer  ------- Load Peer -------    Total    Total    Total  --------- Stores --------  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
>   # Index             Address  Node  PA cnt    Snoop    Total    Local   Remote  records    Loads   Stores    L1Hit   L1Miss      N/A       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
>   # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
>   #
>         0      0xaaaac17d6000   N/A       0  100.00%       99       99        0    18851    18851        0        0        0        0        0    18752        0        99        0         0        0         0         0
> 
>   =================================================
>         Shared Cache Line Distribution Pareto      
>   =================================================
>   #
>   #        -- Peer Snoop --  ------- Store Refs ------  --------- Data address ---------                      ---------- cycles ----------    Total       cpu                                    Shared                       
>   #   Num      Rmt      Lcl   L1 Hit  L1 Miss      N/A              Offset  Node  PA cnt        Code address  rmt peer  lcl peer      load  records       cnt                  Symbol            Object      Source:Line  Node{cpus %peers %stores}
>   # .....  .......  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  .......  ........  ......................  ................  ...............  ....
>   #
>     ----------------------------------------------------------------------
>         0        0       99        0        0        0      0xaaaac17d6000
>     ----------------------------------------------------------------------
>              0.00%    6.06%    0.00%    0.00%    0.00%                0x20   N/A       0      0xaaaac17c25ac         0       375        43    18469         2  [.] 0x00000000000025ac  memstress         memstress[25ac]   0{ 2 100.0%    n/a}
>              0.00%   93.94%    0.00%    0.00%    0.00%                0x29   N/A       0      0xaaaac17c3e88         0       180       173      135         2  [.] 0x0000000000003e88  memstress         memstress[3e88]   0{ 2 100.0%    n/a}
> 
> 
> Changes from v3:
> * Changed to display remote and local peer accesses (Joe);
> * Fixed the usage info for display types (Joe);
> * Do not display HITM dimensions when use 'peer' display, and HITM
>   display doesn't show any 'peer' dimensions (James);
> * Split to smaller patches for adding dimensions of peer operations;
> * Updated documentation to reflect the latest GUI and stdio.
> 
> Changes from v2:
> * Updated patch 04 to account metrics for both cache level and ld_peer
>   for PEER flag;
> * Updated document for metric 'rmt_hit' which is accounted for all
>   remote accesses (include remote DRAM and any upward caches).
> 
> Changes from v1:
> * Updated patches 01, 02 and 03 to support 'N/A' metrics for store
>   operations, so can align with the patch set [1] for store samples.
> 
> 
> [1] https://lore.kernel.org/lkml/20220517020326.18580-1-alisaidi@amazon.com/
> [2] https://lore.kernel.org/lkml/20220530083645.253432-1-leo.yan@linaro.org/
> [3] https://git.linaro.org/people/leo.yan/linux-spe.git/ branch: perf_c2c_arm_spe_peer_v4
> 
> 
> Leo Yan (12):
>   perf mem: Add statistics for peer snooping
>   perf c2c: Output statistics for peer snooping
>   perf c2c: Add dimensions for peer load operations
>   perf c2c: Add dimensions of peer metrics for cache line view
>   perf c2c: Add mean dimensions for peer operations
>   perf c2c: Use explicit names for display macros
>   perf c2c: Rename dimension from 'percent_hitm' to
>     'percent_costly_snoop'
>   perf c2c: Refactor node header
>   perf c2c: Refactor display string
>   perf c2c: Sort on peer snooping for load operations
>   perf c2c: Use 'peer' as default display for Arm64
>   perf c2c: Update documentation for new display option 'peer'
> 
>  tools/perf/Documentation/perf-c2c.txt |  30 +-
>  tools/perf/builtin-c2c.c              | 454 ++++++++++++++++++++------
>  tools/perf/util/mem-events.c          |  28 +-
>  tools/perf/util/mem-events.h          |   3 +
>  4 files changed, 403 insertions(+), 112 deletions(-)
> 
> -- 
> 2.25.1

-- 

- Arnaldo
