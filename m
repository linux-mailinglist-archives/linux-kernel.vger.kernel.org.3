Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0B05212D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbiEJKzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240299AbiEJKx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:53:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8035F28F1EF;
        Tue, 10 May 2022 03:49:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D86D15A1;
        Tue, 10 May 2022 03:49:20 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.33.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6EAB3F66F;
        Tue, 10 May 2022 03:49:17 -0700 (PDT)
From:   Nick Forrington <nick.forrington@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Nick Forrington <nick.forrington@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
Subject: [PATCH 12/20] perf vendors events arm64: Arm Cortex-A65
Date:   Tue, 10 May 2022 11:47:50 +0100
Message-Id: <20220510104758.64677-13-nick.forrington@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510104758.64677-1-nick.forrington@arm.com>
References: <20220510104758.64677-1-nick.forrington@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PMU events for Arm Cortex-A65
Update mapfile.csv

Event data based on:
https://github.com/ARM-software/data/tree/master/pmu/cortex-a65.json

which is based on PMU event descriptions from the Arm Cortex-A65 Technical
Reference Manual.

Mapping data (for mapfile.csv) based on:
https://github.com/ARM-software/data/blob/master/cpus.json

which is based on Main ID Register (MIDR) information found in the Arm
Technical Reference Manuals for individual CPUs.

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 .../arch/arm64/arm/cortex-a65/branch.json     |  17 ++
 .../arch/arm64/arm/cortex-a65/bus.json        |  17 ++
 .../arch/arm64/arm/cortex-a65/cache.json      | 236 ++++++++++++++++++
 .../arch/arm64/arm/cortex-a65/dpu.json        |  32 +++
 .../arch/arm64/arm/cortex-a65/exception.json  |  14 ++
 .../arch/arm64/arm/cortex-a65/ifu.json        | 122 +++++++++
 .../arm64/arm/cortex-a65/instruction.json     |  71 ++++++
 .../arch/arm64/arm/cortex-a65/memory.json     |  35 +++
 .../arch/arm64/arm/cortex-a65/pipeline.json   |   8 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 10 files changed, 553 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/dpu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/ifu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a65/pipeline.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/branch.json
new file mode 100644
index 000000000000..2f2d137f5f55
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/branch.json
@@ -0,0 +1,17 @@
+[
+    {
+        "ArchStdEvent": "BR_MIS_PRED"
+    },
+    {
+        "ArchStdEvent": "BR_PRED"
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/bus.json
new file mode 100644
index 000000000000..75d850b781ac
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/bus.json
@@ -0,0 +1,17 @@
+[
+    {
+        "ArchStdEvent": "CPU_CYCLES"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS"
+    },
+    {
+        "ArchStdEvent": "BUS_CYCLES"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_RD"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_WR"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/cache.json
new file mode 100644
index 000000000000..118c5cb0674b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/cache.json
@@ -0,0 +1,236 @@
+[
+    {
+        "ArchStdEvent": "L1I_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1I_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_ALLOCATE"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB"
+    },
+    {
+        "ArchStdEvent": "L1I_TLB"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_ALLOCATE"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB"
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK"
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK"
+    },
+    {
+        "ArchStdEvent": "LL_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "LL_CACHE_MISS_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_INNER"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_REFILL_RD"
+    },
+    {
+        "PublicDescription": "Merge in the store buffer",
+        "EventCode": "0xC0",
+        "EventName": "STB_STALL",
+        "BriefDescription": "Merge in the store buffer"
+    },
+    {
+        "PublicDescription": "Level 1 data cache refill started due to prefetch. Counts any linefills from the prefetcher which cause an allocation into the L1 D-cache",
+        "EventCode": "0xC3",
+        "EventName": "L1D_PREF_LINE_FILL",
+        "BriefDescription": "Level 1 data cache refill started due to prefetch. Counts any linefills from the prefetcher which cause an allocation into the L1 D-cache"
+    },
+    {
+        "PublicDescription": "Level 2 cache refill due to prefetch. +//0 If the core is configured with a per-core L2 cache: This event does not count. +//0 If the core is configured without a per-core L2 cache: This event counts the cluster cache event, as defined by L3_PREF_LINE_FILL. +//0 If there is neither a per-core cache nor a cluster cache configured, this event is not implemented",
+        "EventCode": "0xC4",
+        "EventName": "L2D_PREF_LINE_FILL",
+        "BriefDescription": "Level 2 cache refill due to prefetch. +//0 If the core is configured with a per-core L2 cache: This event does not count. +//0 If the core is configured without a per-core L2 cache: This event counts the cluster cache event, as defined by L3_PREF_LINE_FILL. +//0 If there is neither a per-core cache nor a cluster cache configured, this event is not implemented"
+    },
+    {
+        "PublicDescription": "Level 3 cache refill due to prefetch. This event counts any linefills from the hardware prefetcher which cause an allocation into the L3 cache. Note It might not be possible to distinguish between both hardware and software prefetches and also which prefetches cause an allocation. If so, only hardware prefetches should be counted, regardless of whether they allocate. If either the core is configured without a per-core L2 or the cluster is configured without an L3 cache, this event is not implemented",
+        "EventCode": "0xC5",
+        "EventName": "L3_PREF_LINE_FILL",
+        "BriefDescription": "Level 3 cache refill due to prefetch. This event counts any linefills from the hardware prefetcher which cause an allocation into the L3 cache. Note It might not be possible to distinguish between both hardware and software prefetches and also which prefetches cause an allocation. If so, only hardware prefetches should be counted, regardless of whether they allocate. If either the core is configured without a per-core L2 or the cluster is configured without an L3 cache, this event is not implemented"
+    },
+    {
+        "PublicDescription": "L1D entering write stream mode",
+        "EventCode": "0xC6",
+        "EventName": "L1D_WS_MODE_ENTER",
+        "BriefDescription": "L1D entering write stream mode"
+    },
+    {
+        "PublicDescription": "L1D is in write stream mode",
+        "EventCode": "0xC7",
+        "EventName": "L1D_WS_MODE",
+        "BriefDescription": "L1D is in write stream mode"
+    },
+    {
+        "PublicDescription": "Level 2 cache write streaming mode. This event counts for each cycle where the core is in write-streaming mode and not allocating writes into the L2 cache",
+        "EventCode": "0xC8",
+        "EventName": "L2D_WS_MODE",
+        "BriefDescription": "Level 2 cache write streaming mode. This event counts for each cycle where the core is in write-streaming mode and not allocating writes into the L2 cache"
+    },
+    {
+        "PublicDescription": "Level 3 cache write streaming mode. This event counts for each cycle where the core is in write-streaming mode and not allocating writes into the L3 cache",
+        "EventCode": "0xC9",
+        "EventName": "L3D_WS_MODE",
+        "BriefDescription": "Level 3 cache write streaming mode. This event counts for each cycle where the core is in write-streaming mode and not allocating writes into the L3 cache"
+    },
+    {
+        "PublicDescription": "Level 2 TLB last-level walk cache access. This event does not count if the MMU is disabled",
+        "EventCode": "0xCA",
+        "EventName": "TLB_L2TLB_LLWALK_ACCESS",
+        "BriefDescription": "Level 2 TLB last-level walk cache access. This event does not count if the MMU is disabled"
+    },
+    {
+        "PublicDescription": "Level 2 TLB last-level walk cache refill. This event does not count if the MMU is disabled",
+        "EventCode": "0xCB",
+        "EventName": "TLB_L2TLB_LLWALK_REFILL",
+        "BriefDescription": "Level 2 TLB last-level walk cache refill. This event does not count if the MMU is disabled"
+    },
+    {
+        "PublicDescription": "Level 2 TLB level-2 walk cache access. This event counts accesses to the level-2 walk cache where the last-level walk cache has missed. The event only counts when the translation regime of the pagewalk uses level 2 descriptors. This event does not count if the MMU is disabled",
+        "EventCode": "0xCC",
+        "EventName": "TLB_L2TLB_L2WALK_ACCESS",
+        "BriefDescription": "Level 2 TLB level-2 walk cache access. This event counts accesses to the level-2 walk cache where the last-level walk cache has missed. The event only counts when the translation regime of the pagewalk uses level 2 descriptors. This event does not count if the MMU is disabled"
+    },
+    {
+        "PublicDescription": "Level 2 TLB level-2 walk cache refill. This event does not count if the MMU is disabled",
+        "EventCode": "0xCD",
+        "EventName": "TLB_L2TLB_L2WALK_REFILL",
+        "BriefDescription": "Level 2 TLB level-2 walk cache refill. This event does not count if the MMU is disabled"
+    },
+    {
+        "PublicDescription": "Level 2 TLB IPA cache access. This event counts on each access to the IPA cache. +//0 If a single pagewalk needs to make multiple accesses to the IPA cache, each access is counted. +//0 If stage 2 translation is disabled, this event does not count",
+        "EventCode": "0xCE",
+        "EventName": "TLB_L2TLB_S2_ACCESS",
+        "BriefDescription": "Level 2 TLB IPA cache access. This event counts on each access to the IPA cache. +//0 If a single pagewalk needs to make multiple accesses to the IPA cache, each access is counted. +//0 If stage 2 translation is disabled, this event does not count"
+    },
+    {
+        "PublicDescription": "Level 2 TLB IPA cache refill. This event counts on each refill of the IPA cache. +//0 If a single pagewalk needs to make multiple accesses to the IPA cache, each access which causes a refill is counted. +//0 If stage 2 translation is disabled, this event does not count",
+        "EventCode": "0xCF",
+        "EventName": "TLB_L2TLB_S2_REFILL",
+        "BriefDescription": "Level 2 TLB IPA cache refill. This event counts on each refill of the IPA cache. +//0 If a single pagewalk needs to make multiple accesses to the IPA cache, each access which causes a refill is counted. +//0 If stage 2 translation is disabled, this event does not count"
+    },
+    {
+        "PublicDescription": "Unattributable Level 1 data cache write-back. This event occurs when a requestor outside the PE makes a coherency request that results in writeback",
+        "EventCode": "0xF0",
+        "EventName": "L2_L1D_CACHE_WB_UNATT",
+        "BriefDescription": "Unattributable Level 1 data cache write-back. This event occurs when a requestor outside the PE makes a coherency request that results in writeback"
+    },
+    {
+        "PublicDescription": "Unattributable Level 2 data cache access. This event occurs when a requestor outside the PE makes a coherency request that results in level 2 data cache access",
+        "EventCode": "0xF1",
+        "EventName": "L2_L2D_CACHE_UNATT",
+        "BriefDescription": "Unattributable Level 2 data cache access. This event occurs when a requestor outside the PE makes a coherency request that results in level 2 data cache access"
+    },
+    {
+        "PublicDescription": "Unattributable Level 2 data cache access, read. This event occurs when a requestor outside the PE makes a coherency request that results in level 2 data cache read access",
+        "EventCode": "0xF2",
+        "EventName": "L2_L2D_CACHE_RD_UNATT",
+        "BriefDescription": "Unattributable Level 2 data cache access, read. This event occurs when a requestor outside the PE makes a coherency request that results in level 2 data cache read access"
+    },
+    {
+        "PublicDescription": "Unattributable Level 3 data cache access. This event occurs when a requestor outside the PE makes a coherency request that results in level 3 data cache read access",
+        "EventCode": "0xF3",
+        "EventName": "L2_L3D_CACHE_UNATT",
+        "BriefDescription": "Unattributable Level 3 data cache access. This event occurs when a requestor outside the PE makes a coherency request that results in level 3 data cache read access"
+    },
+    {
+        "PublicDescription": "Unattributable Level 3 data cache access, read. This event occurs when a requestor outside the PE makes a coherency request that results in level 3 data cache read access",
+        "EventCode": "0xF4",
+        "EventName": "L2_L3D_CACHE_RD_UNATT",
+        "BriefDescription": "Unattributable Level 3 data cache access, read. This event occurs when a requestor outside the PE makes a coherency request that results in level 3 data cache read access"
+    },
+    {
+        "PublicDescription": "Unattributable Level 3 data or unified cache allocation without refill. This event occurs when a requestor outside the PE makes a coherency request that results in level 3 cache allocate without refill",
+        "EventCode": "0xF5",
+        "EventName": "L2_L3D_CACHE_ALLOC_UNATT",
+        "BriefDescription": "Unattributable Level 3 data or unified cache allocation without refill. This event occurs when a requestor outside the PE makes a coherency request that results in level 3 cache allocate without refill"
+    },
+    {
+        "PublicDescription": "Unattributable Level 3 data or unified cache refill. This event occurs when a requestor outside the PE makes a coherency request that results in level 3 cache refill",
+        "EventCode": "0xF6",
+        "EventName": "L2_L3D_CACHE_REFILL_UNATT",
+        "BriefDescription": "Unattributable Level 3 data or unified cache refill. This event occurs when a requestor outside the PE makes a coherency request that results in level 3 cache refill"
+    },
+    {
+        "PublicDescription": "Level 2 cache stash dropped. This event counts on each stash request received from the interconnect or ACP, that is targeting L2 and gets dropped due to lack of buffer space to hold the request. L2 and L3 cache events (L2D_CACHE*, L3D_CACHE*) The behavior of these events depends on the configuration of the core. If the private L2 cache is present, the L2D_CACHE* events count the activity in the private L2 cache, and the L3D_CACHE* events count the activity in the DSU L3 cache (if present). If the private L2 cache is not present but the DSU L3 cache is present, the L2D_CACHE* events count activity in the DSU L3 cache and the L3D_CACHE* events do not count. The L2D_CACHE_WB, L2D_CACHE_WR and L2D_CACHE_REFILL_WR events do not count in this configuration. If neither the private L2 cache nor the DSU L3 cache are present, neither the L2D_CACHE* or L3D_CACHE* events will count",
+        "EventCode": "0xF7",
+        "EventName": "L2D_CACHE_STASH_DROPPED",
+        "BriefDescription": "Level 2 cache stash dropped. This event counts on each stash request received from the interconnect or ACP, that is targeting L2 and gets dropped due to lack of buffer space to hold the request. L2 and L3 cache events (L2D_CACHE*, L3D_CACHE*) The behavior of these events depends on the configuration of the core. If the private L2 cache is present, the L2D_CACHE* events count the activity in the private L2 cache, and the L3D_CACHE* events count the activity in the DSU L3 cache (if present). If the private L2 cache is not present but the DSU L3 cache is present, the L2D_CACHE* events count activity in the DSU L3 cache and the L3D_CACHE* events do not count. The L2D_CACHE_WB, L2D_CACHE_WR and L2D_CACHE_REFILL_WR events do not count in this configuration. If neither the private L2 cache nor the DSU L3 cache are present, neither the L2D_CACHE* or L3D_CACHE* events will count"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/dpu.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/dpu.json
new file mode 100644
index 000000000000..b8e402a91bdd
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/dpu.json
@@ -0,0 +1,32 @@
+[
+    {
+        "PublicDescription": "Instruction retired, indirect branch, mispredicted",
+        "EventCode": "0xE9",
+        "EventName": "DPU_BR_IND_MIS",
+        "BriefDescription": "Instruction retired, indirect branch, mispredicted"
+    },
+    {
+        "PublicDescription": "Instruction retired, conditional branch, mispredicted",
+        "EventCode": "0xEA",
+        "EventName": "DPU_BR_COND_MIS",
+        "BriefDescription": "Instruction retired, conditional branch, mispredicted"
+    },
+    {
+        "PublicDescription": "Memory error (any type) from IFU",
+        "EventCode": "0xEB",
+        "EventName": "DPU_MEM_ERR_IFU",
+        "BriefDescription": "Memory error (any type) from IFU"
+    },
+    {
+        "PublicDescription": "Memory error (any type) from DCU",
+        "EventCode": "0xEC",
+        "EventName": "DPU_MEM_ERR_DCU",
+        "BriefDescription": "Memory error (any type) from DCU"
+    },
+    {
+        "PublicDescription": "Memory error (any type) from TLB",
+        "EventCode": "0xED",
+        "EventName": "DPU_MEM_ERR_TLB",
+        "BriefDescription": "Memory error (any type) from TLB"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/exception.json
new file mode 100644
index 000000000000..27c3fe9c831a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/exception.json
@@ -0,0 +1,14 @@
+[
+    {
+        "ArchStdEvent": "EXC_TAKEN"
+    },
+    {
+        "ArchStdEvent": "MEMORY_ERROR"
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ"
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/ifu.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/ifu.json
new file mode 100644
index 000000000000..13178c5dca14
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/ifu.json
@@ -0,0 +1,122 @@
+[
+    {
+        "PublicDescription": "I-Cache miss on an access from the prefetch block",
+        "EventCode": "0xD0",
+        "EventName": "IFU_IC_MISS_WAIT",
+        "BriefDescription": "I-Cache miss on an access from the prefetch block"
+    },
+    {
+        "PublicDescription": "Counts the cycles spent on a request for Level 2 TLB lookup after a Level 1l ITLB miss",
+        "EventCode": "0xD1",
+        "EventName": "IFU_IUTLB_MISS_WAIT",
+        "BriefDescription": "Counts the cycles spent on a request for Level 2 TLB lookup after a Level 1l ITLB miss"
+    },
+    {
+        "PublicDescription": "Micro-predictor conditional/direction mispredict, with respect to. if3/if4 predictor",
+        "EventCode": "0xD2",
+        "EventName": "IFU_MICRO_COND_MISPRED",
+        "BriefDescription": "Micro-predictor conditional/direction mispredict, with respect to. if3/if4 predictor"
+    },
+    {
+        "PublicDescription": "Micro-predictor address mispredict, with respect to if3/if4 predictor",
+        "EventCode": "0xD3",
+        "EventName": "IFU_MICRO_CADDR_MISPRED",
+        "BriefDescription": "Micro-predictor address mispredict, with respect to if3/if4 predictor"
+    },
+    {
+        "PublicDescription": "Micro-predictor hit with immediate redirect",
+        "EventCode": "0xD4",
+        "EventName": "IFU_MICRO_HIT",
+        "BriefDescription": "Micro-predictor hit with immediate redirect"
+    },
+    {
+        "PublicDescription": "Micro-predictor negative cache hit",
+        "EventCode": "0xD6",
+        "EventName": "IFU_MICRO_NEG_HIT",
+        "BriefDescription": "Micro-predictor negative cache hit"
+    },
+    {
+        "PublicDescription": "Micro-predictor correction",
+        "EventCode": "0xD7",
+        "EventName": "IFU_MICRO_CORRECTION",
+        "BriefDescription": "Micro-predictor correction"
+    },
+    {
+        "PublicDescription": "A 2nd instruction could have been pushed but was not because it was nonsequential",
+        "EventCode": "0xD8",
+        "EventName": "IFU_MICRO_NO_INSTR1",
+        "BriefDescription": "A 2nd instruction could have been pushed but was not because it was nonsequential"
+    },
+    {
+        "PublicDescription": "Micro-predictor miss",
+        "EventCode": "0xD9",
+        "EventName": "IFU_MICRO_NO_PRED",
+        "BriefDescription": "Micro-predictor miss"
+    },
+    {
+        "PublicDescription": "Thread flushed due to TLB miss",
+        "EventCode": "0xDA",
+        "EventName": "IFU_FLUSHED_TLB_MISS",
+        "BriefDescription": "Thread flushed due to TLB miss"
+    },
+    {
+        "PublicDescription": "Thread flushed due to reasons other than TLB miss",
+        "EventCode": "0xDB",
+        "EventName": "IFU_FLUSHED_EXCL_TLB_MISS",
+        "BriefDescription": "Thread flushed due to reasons other than TLB miss"
+    },
+    {
+        "PublicDescription": "This thread and the other thread both ready for scheduling in if0",
+        "EventCode": "0xDC",
+        "EventName": "IFU_ALL_THRDS_RDY",
+        "BriefDescription": "This thread and the other thread both ready for scheduling in if0"
+    },
+    {
+        "PublicDescription": "This thread was arbitrated when the other thread was also ready for scheduling",
+        "EventCode": "0xDD",
+        "EventName": "IFU_WIN_ARB_OTHER_RDY",
+        "BriefDescription": "This thread was arbitrated when the other thread was also ready for scheduling"
+    },
+    {
+        "PublicDescription": "This thread was arbitrated when the other thread was also active, but not necessarily ready. For example, waiting for I-Cache or TLB",
+        "EventCode": "0xDE",
+        "EventName": "IFU_WIN_ARB_OTHER_ACT",
+        "BriefDescription": "This thread was arbitrated when the other thread was also active, but not necessarily ready. For example, waiting for I-Cache or TLB"
+    },
+    {
+        "PublicDescription": "This thread was not arbitrated because it was not ready for scheduling. For example, due to a cache miss or TLB miss",
+        "EventCode": "0xDF",
+        "EventName": "IFU_NOT_RDY_FOR_ARB",
+        "BriefDescription": "This thread was not arbitrated because it was not ready for scheduling. For example, due to a cache miss or TLB miss"
+    },
+    {
+        "PublicDescription": "The thread moved from an active state to an inactive state (long-term sleep state, causing deallocation of some resources)",
+        "EventCode": "0xE0",
+        "EventName": "IFU_GOTO_IDLE",
+        "BriefDescription": "The thread moved from an active state to an inactive state (long-term sleep state, causing deallocation of some resources)"
+    },
+    {
+        "PublicDescription": "I-Cache lookup under miss from other thread",
+        "EventCode": "0xE1",
+        "EventName": "IFU_IC_LOOKUP_UNDER_MISS",
+        "BriefDescription": "I-Cache lookup under miss from other thread"
+    },
+    {
+        "PublicDescription": "I-Cache miss under miss from other thread",
+        "EventCode": "0xE2",
+        "EventName": "IFU_IC_MISS_UNDER_MISS",
+        "BriefDescription": "I-Cache miss under miss from other thread"
+    },
+    {
+        "PublicDescription": "This thread pushed an instruction into the IQ",
+        "EventCode": "0xE3",
+        "EventName": "IFU_INSTR_PUSHED",
+        "BriefDescription": "This thread pushed an instruction into the IQ"
+    },
+    {
+        "PublicDescription": "I-Cache Speculative line fill",
+        "EventCode": "0xE4",
+        "EventName": "IFU_IC_LF_SP",
+        "BriefDescription": "I-Cache Speculative line fill"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/instruction.json
new file mode 100644
index 000000000000..2e0d60779dce
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/instruction.json
@@ -0,0 +1,71 @@
+[
+    {
+        "ArchStdEvent": "SW_INCR"
+    },
+    {
+        "ArchStdEvent": "LD_RETIRED"
+    },
+    {
+        "ArchStdEvent": "ST_RETIRED"
+    },
+    {
+        "ArchStdEvent": "INST_RETIRED"
+    },
+    {
+        "ArchStdEvent": "EXC_RETURN"
+    },
+    {
+        "ArchStdEvent": "CID_WRITE_RETIRED"
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_RETIRED"
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_RETIRED"
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_RETIRED"
+    },
+    {
+        "ArchStdEvent": "INST_SPEC"
+    },
+    {
+        "ArchStdEvent": "TTBR_WRITE_RETIRED"
+    },
+    {
+        "ArchStdEvent": "BR_RETIRED"
+    },
+    {
+        "ArchStdEvent": "BR_MIS_PRED_RETIRED"
+    },
+    {
+        "ArchStdEvent": "LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "LDST_SPEC"
+    },
+    {
+        "ArchStdEvent": "DP_SPEC"
+    },
+    {
+        "ArchStdEvent": "ASE_SPEC"
+    },
+    {
+        "ArchStdEvent": "VFP_SPEC"
+    },
+    {
+        "ArchStdEvent": "CRYPTO_SPEC"
+    },
+    {
+        "ArchStdEvent": "ISB_SPEC"
+    },
+    {
+        "PublicDescription": "Instruction retired, conditional branch",
+        "EventCode": "0xE8",
+        "EventName": "DPU_BR_COND_RETIRED",
+        "BriefDescription": "Instruction retired, conditional branch"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/memory.json
new file mode 100644
index 000000000000..18d527f7fad4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/memory.json
@@ -0,0 +1,35 @@
+[
+    {
+        "ArchStdEvent": "MEM_ACCESS"
+    },
+    {
+        "ArchStdEvent": "REMOTE_ACCESS_RD"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR"
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_SPEC"
+    },
+    {
+        "PublicDescription": "External memory request",
+        "EventCode": "0xC1",
+        "EventName": "BIU_EXT_MEM_REQ",
+        "BriefDescription": "External memory request"
+    },
+    {
+        "PublicDescription": "External memory request to non-cacheable memory",
+        "EventCode": "0xC2",
+        "EventName": "BIU_EXT_MEM_REQ_NC",
+        "BriefDescription": "External memory request to non-cacheable memory"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/pipeline.json
new file mode 100644
index 000000000000..eeac798d403a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/pipeline.json
@@ -0,0 +1,8 @@
+[
+    {
+        "ArchStdEvent": "STALL_FRONTEND"
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index c464469c4d51..3ad4e991d62b 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -24,6 +24,7 @@
 0x00000000420f1000,v1,arm/cortex-a53,core
 0x00000000410fd040,v1,arm/cortex-a35,core
 0x00000000410fd050,v1,arm/cortex-a55,core
+0x00000000410fd060,v1,arm/cortex-a65,core
 0x00000000410fd070,v1,arm/cortex-a57-a72,core
 0x00000000410fd080,v1,arm/cortex-a57-a72,core
 0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
-- 
2.25.1

