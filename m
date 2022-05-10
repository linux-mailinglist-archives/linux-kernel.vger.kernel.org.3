Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626EA5212CE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbiEJKzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbiEJKx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:53:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA7842AED88;
        Tue, 10 May 2022 03:49:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC0511596;
        Tue, 10 May 2022 03:49:17 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.33.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 412D13F66F;
        Tue, 10 May 2022 03:49:15 -0700 (PDT)
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
Subject: [PATCH 11/20] perf vendors events arm64: Arm Cortex-A510
Date:   Tue, 10 May 2022 11:47:49 +0100
Message-Id: <20220510104758.64677-12-nick.forrington@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510104758.64677-1-nick.forrington@arm.com>
References: <20220510104758.64677-1-nick.forrington@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PMU events for Arm Cortex-A510
Add corresponding common events
Update mapfile.csv

Event data based on:
https://github.com/ARM-software/data/tree/master/pmu/cortex-a510.json

which is based on PMU event descriptions from the Arm Cortex-A510 Technical
Reference Manual.

Common event data based on:
https://github.com/ARM-software/data/blob/master/pmu/common_armv9.json

which is based on PMU event descriptions found in the Arm Architecture
Reference Manual:
https://developer.arm.com/documentation/ddi0487/

Mapping data (for mapfile.csv) based on:
https://github.com/ARM-software/data/blob/master/cpus.json

which is based on Main ID Register (MIDR) information found in the Arm
Technical Reference Manuals for individual CPUs.

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 .../arch/arm64/arm/cortex-a510/branch.json    |  59 ++++++
 .../arch/arm64/arm/cortex-a510/bus.json       |  17 ++
 .../arch/arm64/arm/cortex-a510/cache.json     | 182 ++++++++++++++++++
 .../arch/arm64/arm/cortex-a510/exception.json |  14 ++
 .../arm64/arm/cortex-a510/instruction.json    |  95 +++++++++
 .../arch/arm64/arm/cortex-a510/memory.json    |  32 +++
 .../arch/arm64/arm/cortex-a510/pipeline.json  | 107 ++++++++++
 .../arch/arm64/arm/cortex-a510/pmu.json       |   8 +
 .../arch/arm64/arm/cortex-a510/trace.json     |  32 +++
 .../arch/arm64/common-and-microarch.json      |  18 ++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 11 files changed, 565 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/trace.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/branch.json
new file mode 100644
index 000000000000..411fcbdbd7e6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/branch.json
@@ -0,0 +1,59 @@
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
+    },
+    {
+        "PublicDescription": "Predicted conditional branch executed. This event counts when any branch that the conditional predictor can predict is retired. This event still counts when branch prediction is disabled due to the Memory Management Unit (MMU) being off",
+        "EventCode": "0xC9",
+        "EventName": "BR_COND_PRED",
+        "BriefDescription": "Predicted conditional branch executed. This event counts when any branch that the conditional predictor can predict is retired. This event still counts when branch prediction is disabled due to the Memory Management Unit (MMU) being off"
+    },
+    {
+        "PublicDescription": "Indirect branch mispredicted. This event counts when any indirect branch that the Branch Target Address Cache (BTAC) can predict is retired and has mispredicted either the condition or the address. This event still counts when branch prediction is disabled due to the MMU being off",
+        "EventCode": "0xCA",
+        "EventName": "BR_INDIRECT_MIS_PRED",
+        "BriefDescription": "Indirect branch mispredicted. This event counts when any indirect branch that the Branch Target Address Cache (BTAC) can predict is retired and has mispredicted either the condition or the address. This event still counts when branch prediction is disabled due to the MMU being off"
+    },
+    {
+        "PublicDescription": "Indirect branch mispredicted due to address miscompare. This event counts when any indirect branch that the BTAC can predict is retired, was taken, correctly predicted the condition, and has mispredicted the address. This event still counts when branch prediction is disabled due to the MMU being off",
+        "EventCode": "0xCB",
+        "EventName": "BR_INDIRECT_ADDR_MIS_PRED",
+        "BriefDescription": "Indirect branch mispredicted due to address miscompare. This event counts when any indirect branch that the BTAC can predict is retired, was taken, correctly predicted the condition, and has mispredicted the address. This event still counts when branch prediction is disabled due to the MMU being off"
+    },
+    {
+        "PublicDescription": "Conditional branch mispredicted. This event counts when any branch that the conditional predictor can predict is retired and has mispredicted the condition. This event still counts when branch prediction is disabled due to the MMU being off. Conditional indirect branches that correctly predict the condition but mispredict the address do not count",
+        "EventCode": "0xCC",
+        "EventName": "BR_COND_MIS_PRED",
+        "BriefDescription": "Conditional branch mispredicted. This event counts when any branch that the conditional predictor can predict is retired and has mispredicted the condition. This event still counts when branch prediction is disabled due to the MMU being off. Conditional indirect branches that correctly predict the condition but mispredict the address do not count"
+    },
+    {
+        "PublicDescription": "Indirect branch with predicted address executed. This event counts when any indirect branch that the BTAC can predict is retired, was taken, and correctly predicted the condition. This event still counts when branch prediction is disabled due to the MMU being off",
+        "EventCode": "0xCD",
+        "EventName": "BR_INDIRECT_ADDR_PRED",
+        "BriefDescription": "Indirect branch with predicted address executed. This event counts when any indirect branch that the BTAC can predict is retired, was taken, and correctly predicted the condition. This event still counts when branch prediction is disabled due to the MMU being off"
+    },
+    {
+        "PublicDescription": "Procedure return with predicted address executed. This event counts when any procedure return that the call-return stack can predict is retired, was taken, and correctly predicted the condition. This event still counts when branch prediction is disabled due to the MMU being off",
+        "EventCode": "0xCE",
+        "EventName": "BR_RETURN_ADDR_PRED",
+        "BriefDescription": "Procedure return with predicted address executed. This event counts when any procedure return that the call-return stack can predict is retired, was taken, and correctly predicted the condition. This event still counts when branch prediction is disabled due to the MMU being off"
+    },
+    {
+        "PublicDescription": "Procedure return mispredicted due to address miscompare. This event counts when any procedure return that the call-return stack can predict is retired, was taken, correctly predicted the condition, and has mispredicted the address. This event still counts when branch prediction is disabled due to the MMU being off",
+        "EventCode": "0xCF",
+        "EventName": "BR_RETURN_ADDR_MIS_PRED",
+        "BriefDescription": "Procedure return mispredicted due to address miscompare. This event counts when any procedure return that the call-return stack can predict is retired, was taken, correctly predicted the condition, and has mispredicted the address. This event still counts when branch prediction is disabled due to the MMU being off"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/bus.json
new file mode 100644
index 000000000000..75d850b781ac
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/bus.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/cache.json
new file mode 100644
index 000000000000..27cd913e186b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/cache.json
@@ -0,0 +1,182 @@
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
+        "ArchStdEvent": "L1D_CACHE_LMISS_RD"
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
+        "PublicDescription": "L2 cache refill due to prefetch. If the complex is configured with a per-complex L2 cache, this event does not count. If the complex is configured without a per-complex L2 cache, this event counts the cluster cache event, as defined by L3D_CACHE_REFILL_PREFETCH. If neither a per-complex cache or a cluster cache is configured, this event is not implemented",
+        "EventCode": "0xC1",
+        "EventName": "L2D_CACHE_REFILL_PREFETCH",
+        "BriefDescription": "L2 cache refill due to prefetch. If the complex is configured with a per-complex L2 cache, this event does not count. If the complex is configured without a per-complex L2 cache, this event counts the cluster cache event, as defined by L3D_CACHE_REFILL_PREFETCH. If neither a per-complex cache or a cluster cache is configured, this event is not implemented"
+    },
+    {
+        "PublicDescription": "L1 data cache refill due to prefetch. This event counts any linefills from the prefetcher that cause an allocation into the L1 data cache",
+        "EventCode": "0xC2",
+        "EventName": "L1D_CACHE_REFILL_PREFETCH",
+        "BriefDescription": "L1 data cache refill due to prefetch. This event counts any linefills from the prefetcher that cause an allocation into the L1 data cache"
+    },
+    {
+        "PublicDescription": "L2 cache write streaming mode. This event counts for each cycle where the core is in write streaming mode and is not allocating writes into the L2 cache",
+        "EventCode": "0xC3",
+        "EventName": "L2D_WS_MODE",
+        "BriefDescription": "L2 cache write streaming mode. This event counts for each cycle where the core is in write streaming mode and is not allocating writes into the L2 cache"
+    },
+    {
+        "PublicDescription": "L1 data cache entering write streaming mode. This event counts for each entry into write streaming mode",
+        "EventCode": "0xC4",
+        "EventName": "L1D_WS_MODE_ENTRY",
+        "BriefDescription": "L1 data cache entering write streaming mode. This event counts for each entry into write streaming mode"
+    },
+    {
+        "PublicDescription": "L1 data cache write streaming mode. This event counts for each cycle where the core is in write streaming mode and is not allocating writes into the L1 data cache",
+        "EventCode": "0xC5",
+        "EventName": "L1D_WS_MODE",
+        "BriefDescription": "L1 data cache write streaming mode. This event counts for each cycle where the core is in write streaming mode and is not allocating writes into the L1 data cache"
+    },
+    {
+        "PublicDescription": "L3 cache write streaming mode. This event counts for each cycle where the core is in write streaming mode and is not allocating writes into the L3 cache",
+        "EventCode": "0xC7",
+        "EventName": "L3D_WS_MODE",
+        "BriefDescription": "L3 cache write streaming mode. This event counts for each cycle where the core is in write streaming mode and is not allocating writes into the L3 cache"
+    },
+    {
+        "PublicDescription": "Last level cache write streaming mode. This event counts for each cycle where the core is in write streaming mode and is not allocating writes into the system cache",
+        "EventCode": "0xC8",
+        "EventName": "LL_WS_MODE",
+        "BriefDescription": "Last level cache write streaming mode. This event counts for each cycle where the core is in write streaming mode and is not allocating writes into the system cache"
+    },
+    {
+        "PublicDescription": "L2 TLB walk cache access. This event does not count if the MMU is disabled",
+        "EventCode": "0xD0",
+        "EventName": "L2D_WALK_TLB",
+        "BriefDescription": "L2 TLB walk cache access. This event does not count if the MMU is disabled"
+    },
+    {
+        "PublicDescription": "L2 TLB walk cache refill. This event does not count if the MMU is disabled",
+        "EventCode": "0xD1",
+        "EventName": "L2D_WALK_TLB_REFILL",
+        "BriefDescription": "L2 TLB walk cache refill. This event does not count if the MMU is disabled"
+    },
+    {
+        "PublicDescription": "L2 TLB IPA cache access. This event counts on each access to the IPA cache. If a single translation table walk needs to make multiple accesses to the IPA cache, each access is counted. If stage 2 translation is disabled, this event does not count",
+        "EventCode": "0xD4",
+        "EventName": "L2D_S2_TLB",
+        "BriefDescription": "L2 TLB IPA cache access. This event counts on each access to the IPA cache. If a single translation table walk needs to make multiple accesses to the IPA cache, each access is counted. If stage 2 translation is disabled, this event does not count"
+    },
+    {
+        "PublicDescription": "L2 TLB IPA cache refill. This event counts on each refill of the IPA cache. If a single translation table walk needs to make multiple accesses to the IPA cache, each access that causes a refill is counted. If stage 2 translation is disabled, this event does not count",
+        "EventCode": "0xD5",
+        "EventName": "L2D_S2_TLB_REFILL",
+        "BriefDescription": "L2 TLB IPA cache refill. This event counts on each refill of the IPA cache. If a single translation table walk needs to make multiple accesses to the IPA cache, each access that causes a refill is counted. If stage 2 translation is disabled, this event does not count"
+    },
+    {
+        "PublicDescription": "L2 cache stash dropped. This event counts on each stash request that is received from the interconnect or the Accelerator Coherency Port (ACP), that targets L2 cache and is dropped due to lack of buffer space to hold the request",
+        "EventCode": "0xD6",
+        "EventName": "L2D_CACHE_STASH_DROPPED",
+        "BriefDescription": "L2 cache stash dropped. This event counts on each stash request that is received from the interconnect or the Accelerator Coherency Port (ACP), that targets L2 cache and is dropped due to lack of buffer space to hold the request"
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_LMISS"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_LMISS_RD"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_LMISS_RD"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/exception.json
new file mode 100644
index 000000000000..27c3fe9c831a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/exception.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/instruction.json
new file mode 100644
index 000000000000..3039d03412df
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/instruction.json
@@ -0,0 +1,95 @@
+[
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
+        "ArchStdEvent": "OP_RETIRED"
+    },
+    {
+        "ArchStdEvent": "OP_SPEC"
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
+        "ArchStdEvent": "PC_WRITE_SPEC"
+    },
+    {
+        "ArchStdEvent": "CRYPTO_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_INST_RETIRED"
+    },
+    {
+        "ArchStdEvent": "SVE_INST_SPEC"
+    },
+    {
+        "ArchStdEvent": "FP_HP_SPEC"
+    },
+    {
+        "ArchStdEvent": "FP_SP_SPEC"
+    },
+    {
+        "ArchStdEvent": "FP_DP_SPEC"
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT8_SPEC"
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT16_SPEC"
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT32_SPEC"
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT64_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/memory.json
new file mode 100644
index 000000000000..38f459502514
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/memory.json
@@ -0,0 +1,32 @@
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
+        "ArchStdEvent": "LDST_ALIGN_LAT"
+    },
+    {
+        "ArchStdEvent": "LD_ALIGN_LAT"
+    },
+    {
+        "ArchStdEvent": "ST_ALIGN_LAT"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED_RD"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED_WR"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pipeline.json
new file mode 100644
index 000000000000..325daaa7b809
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pipeline.json
@@ -0,0 +1,107 @@
+[
+    {
+        "ArchStdEvent": "STALL_FRONTEND"
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND"
+    },
+    {
+        "ArchStdEvent": "STALL"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT_BACKEND"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT_FRONTEND"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT"
+    },
+    {
+        "PublicDescription": "No operation issued due to the frontend, cache miss. This event counts every cycle that the Data Processing Unit (DPU) instruction queue is empty and there is an instruction cache miss being processed",
+        "EventCode": "0xE1",
+        "EventName": "STALL_FRONTEND_CACHE",
+        "BriefDescription": "No operation issued due to the frontend, cache miss. This event counts every cycle that the Data Processing Unit (DPU) instruction queue is empty and there is an instruction cache miss being processed"
+    },
+    {
+        "PublicDescription": "No operation issued due to the frontend, TLB miss. This event counts every cycle that the DPU instruction queue is empty and there is an instruction L1 TLB miss being processed",
+        "EventCode": "0xE2",
+        "EventName": "STALL_FRONTEND_TLB",
+        "BriefDescription": "No operation issued due to the frontend, TLB miss. This event counts every cycle that the DPU instruction queue is empty and there is an instruction L1 TLB miss being processed"
+    },
+    {
+        "PublicDescription": "No operation issued due to the frontend, pre-decode error",
+        "EventCode": "0xE3",
+        "EventName": "STALL_FRONTEND_PDERR",
+        "BriefDescription": "No operation issued due to the frontend, pre-decode error"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend interlock. This event counts every cycle where the issue of an operation is stalled and there is an interlock. Stall cycles due to a stall in the Wr stage are excluded",
+        "EventCode": "0xE4",
+        "EventName": "STALL_BACKEND_ILOCK",
+        "BriefDescription": "No operation issued due to the backend interlock. This event counts every cycle where the issue of an operation is stalled and there is an interlock. Stall cycles due to a stall in the Wr stage are excluded"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, address interlock. This event counts every cycle where the issue of an operation is stalled and there is an interlock on an address operand. This type of interlock is caused by a load/store instruction waiting for data to calculate the address. Stall cycles due to a stall in the Wr stage are excluded",
+        "EventCode": "0xE5",
+        "EventName": "STALL_BACKEND_ILOCK_ADDR",
+        "BriefDescription": "No operation issued due to the backend, address interlock. This event counts every cycle where the issue of an operation is stalled and there is an interlock on an address operand. This type of interlock is caused by a load/store instruction waiting for data to calculate the address. Stall cycles due to a stall in the Wr stage are excluded"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, interlock, or the Vector Processing Unit (VPU). This event counts every cycle where there is a stall or an interlock that is caused by a VPU instruction. Stall cycles due to a stall in the Wr stage are excluded",
+        "EventCode": "0xE6",
+        "EventName": "STALL_BACKEND_ILOCK_VPU",
+        "BriefDescription": "No operation issued due to the backend, interlock, or the Vector Processing Unit (VPU). This event counts every cycle where there is a stall or an interlock that is caused by a VPU instruction. Stall cycles due to a stall in the Wr stage are excluded"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, load. This event counts every cycle where there is a stall in the Wr stage due to a load",
+        "EventCode": "0xE7",
+        "EventName": "STALL_BACKEND_LD",
+        "BriefDescription": "No operation issued due to the backend, load. This event counts every cycle where there is a stall in the Wr stage due to a load"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, store. This event counts every cycle where there is a stall in the Wr stage due to a store",
+        "EventCode": "0xE8",
+        "EventName": "STALL_BACKEND_ST",
+        "BriefDescription": "No operation issued due to the backend, store. This event counts every cycle where there is a stall in the Wr stage due to a store"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, load, cache miss. This event counts every cycle where there is a stall in the Wr stage due to a load that is waiting on data. The event counts for stalls that are caused by missing the cache or where the data is Non-cacheable",
+        "EventCode": "0xE9",
+        "EventName": "STALL_BACKEND_LD_CACHE",
+        "BriefDescription": "No operation issued due to the backend, load, cache miss. This event counts every cycle where there is a stall in the Wr stage due to a load that is waiting on data. The event counts for stalls that are caused by missing the cache or where the data is Non-cacheable"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, load, TLB miss. This event counts every cycle where there is a stall in the Wr stage due to a load that misses in the L1 TLB",
+        "EventCode": "0xEA",
+        "EventName": "STALL_BACKEND_LD_TLB",
+        "BriefDescription": "No operation issued due to the backend, load, TLB miss. This event counts every cycle where there is a stall in the Wr stage due to a load that misses in the L1 TLB"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, store, Store Buffer (STB) full. This event counts every cycle where there is a stall in the Wr stage because of a store operation that is waiting due to the STB being full",
+        "EventCode": "0xEB",
+        "EventName": "STALL_BACKEND_ST_STB",
+        "BriefDescription": "No operation issued due to the backend, store, Store Buffer (STB) full. This event counts every cycle where there is a stall in the Wr stage because of a store operation that is waiting due to the STB being full"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, store, TLB miss. This event counts every cycle where there is a stall in the Wr stage because of a store operation that has missed in the L1 TLB",
+        "EventCode": "0xEC",
+        "EventName": "STALL_BACKEND_ST_TLB",
+        "BriefDescription": "No operation issued due to the backend, store, TLB miss. This event counts every cycle where there is a stall in the Wr stage because of a store operation that has missed in the L1 TLB"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, VPU hazard. This event counts every cycle where the core stalls due to contention for the VPU with the other core",
+        "EventCode": "0xED",
+        "EventName": "STALL_BACKEND_VPU_HAZARD",
+        "BriefDescription": "No operation issued due to the backend, VPU hazard. This event counts every cycle where the core stalls due to contention for the VPU with the other core"
+    },
+    {
+        "PublicDescription": "Issue slot not issued due to interlock. For each cycle, this event counts each dispatch slot that does not issue due to an interlock",
+        "EventCode": "0xEE",
+        "EventName": "STALL_SLOT_BACKEND_ILOCK",
+        "BriefDescription": "Issue slot not issued due to interlock. For each cycle, this event counts each dispatch slot that does not issue due to an interlock"
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_MEM"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
new file mode 100644
index 000000000000..d8b7b9f9e5fa
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
@@ -0,0 +1,8 @@
+[
+    {
+        "ArchStdEvent": "PMU_OVFS"
+    },
+    {
+        "ArchStdEvent": "PMU_HOVFS"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/trace.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/trace.json
new file mode 100644
index 000000000000..33672a8711d4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/trace.json
@@ -0,0 +1,32 @@
+[
+    {
+        "ArchStdEvent": "TRB_WRAP"
+    },
+    {
+        "ArchStdEvent": "TRB_TRIG"
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT0"
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT1"
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT2"
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT3"
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT4"
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT5"
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT6"
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT7"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
index c50b231ce03b..876b51dae92e 100644
--- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
+++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
@@ -401,6 +401,24 @@
         "EventName": "TRB_WRAP",
         "BriefDescription": "Trace buffer current write pointer wrapped"
     },
+    {
+        "PublicDescription": "PMU overflow, counters accessible to EL1 and EL0",
+        "EventCode": "0x400D",
+        "EventName": "PMU_OVFS",
+        "BriefDescription": "PMU overflow, counters accessible to EL1 and EL0"
+    },
+    {
+        "PublicDescription": "Trace buffer Trigger Event",
+        "EventCode": "0x400E",
+        "EventName": "TRB_TRIG",
+        "BriefDescription": "Trace buffer Trigger Event"
+    },
+    {
+        "PublicDescription": "PMU overflow, counters reserved for use by EL2",
+        "EventCode": "0x400F",
+        "EventName": "PMU_HOVFS",
+        "BriefDescription": "PMU overflow, counters reserved for use by EL2"
+    },
     {
         "PublicDescription": "PE Trace Unit external output 0",
         "EventCode": "0x4010",
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index b8f0a299d204..c464469c4d51 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -29,6 +29,7 @@
 0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
 0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
 0x00000000410fd400,v1,arm/neoverse-v1,core
+0x00000000410fd460,v1,arm/cortex-a510,core
 0x00000000410fd490,v1,arm/neoverse-n2,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
-- 
2.25.1

