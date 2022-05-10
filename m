Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E535212CD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbiEJK4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbiEJKxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:53:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68EB32AF628;
        Tue, 10 May 2022 03:49:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E33D015BF;
        Tue, 10 May 2022 03:49:22 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.33.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 786C93F66F;
        Tue, 10 May 2022 03:49:20 -0700 (PDT)
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
Subject: [PATCH 13/20] perf vendors events arm64: Arm Cortex-A73
Date:   Tue, 10 May 2022 11:47:51 +0100
Message-Id: <20220510104758.64677-14-nick.forrington@arm.com>
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

Add PMU events for Arm Cortex-A73
Update mapfile.csv

Event data based on:
https://github.com/ARM-software/data/tree/master/pmu/cortex-a73.json

which is based on PMU event descriptions from the Arm Cortex-A73 Technical
Reference Manual.

Mapping data (for mapfile.csv) based on:
https://github.com/ARM-software/data/blob/master/cpus.json

which is based on Main ID Register (MIDR) information found in the Arm
Technical Reference Manuals for individual CPUs.

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 .../arch/arm64/arm/cortex-a73/branch.json     |  11 ++
 .../arch/arm64/arm/cortex-a73/bus.json        |  23 ++++
 .../arch/arm64/arm/cortex-a73/cache.json      | 107 ++++++++++++++++++
 .../arch/arm64/arm/cortex-a73/etm.json        |  14 +++
 .../arch/arm64/arm/cortex-a73/exception.json  |  14 +++
 .../arm64/arm/cortex-a73/instruction.json     |  65 +++++++++++
 .../arch/arm64/arm/cortex-a73/memory.json     |  14 +++
 .../arch/arm64/arm/cortex-a73/mmu.json        |  44 +++++++
 .../arch/arm64/arm/cortex-a73/pipeline.json   |  38 +++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 10 files changed, 331 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/etm.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/mmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a73/pipeline.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/branch.json
new file mode 100644
index 000000000000..ece201718284
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/branch.json
@@ -0,0 +1,11 @@
+[
+    {
+        "ArchStdEvent": "BR_MIS_PRED"
+    },
+    {
+        "ArchStdEvent": "BR_PRED"
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/bus.json
new file mode 100644
index 000000000000..103bb2535775
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/bus.json
@@ -0,0 +1,23 @@
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
+        "ArchStdEvent": "BUS_ACCESS_SHARED"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_NORMAL"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_PERIPH"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/cache.json
new file mode 100644
index 000000000000..b9b3d3fb07b2
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/cache.json
@@ -0,0 +1,107 @@
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
+        "ArchStdEvent": "L1D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL"
+    },
+    {
+        "PublicDescription": "Number of ways read in the instruction cache - Tag RAM",
+        "EventCode": "0xC2",
+        "EventName": "I_TAG_RAM_RD",
+        "BriefDescription": "Number of ways read in the instruction cache - Tag RAM"
+    },
+    {
+        "PublicDescription": "Number of ways read in the instruction cache - Data RAM",
+        "EventCode": "0xC3",
+        "EventName": "I_DATA_RAM_RD",
+        "BriefDescription": "Number of ways read in the instruction cache - Data RAM"
+    },
+    {
+        "PublicDescription": "Number of ways read in the instruction BTAC RAM",
+        "EventCode": "0xC4",
+        "EventName": "I_BTAC_RAM_RD",
+        "BriefDescription": "Number of ways read in the instruction BTAC RAM"
+    },
+    {
+        "PublicDescription": "Level 1 PLD TLB refill",
+        "EventCode": "0xE7",
+        "EventName": "PLD_UTLB_REFILL",
+        "BriefDescription": "Level 1 PLD TLB refill"
+    },
+    {
+        "PublicDescription": "Level 1 CP15 TLB refill",
+        "EventCode": "0xE8",
+        "EventName": "CP15_UTLB_REFILL",
+        "BriefDescription": "Level 1 CP15 TLB refill"
+    },
+    {
+        "PublicDescription": "Level 1 TLB flush",
+        "EventCode": "0xE9",
+        "EventName": "UTLB_FLUSH",
+        "BriefDescription": "Level 1 TLB flush"
+    },
+    {
+        "PublicDescription": "Level 2 TLB access",
+        "EventCode": "0xEA",
+        "EventName": "TLB_ACCESS",
+        "BriefDescription": "Level 2 TLB access"
+    },
+    {
+        "PublicDescription": "Level 2 TLB miss",
+        "EventCode": "0xEB",
+        "EventName": "TLB_MISS",
+        "BriefDescription": "Level 2 TLB miss"
+    },
+    {
+        "PublicDescription": "Data cache hit in itself due to VIPT aliasing",
+        "EventCode": "0xEC",
+        "EventName": "DCACHE_SELF_HIT_VIPT",
+        "BriefDescription": "Data cache hit in itself due to VIPT aliasing"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/etm.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/etm.json
new file mode 100644
index 000000000000..fce852e82369
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/etm.json
@@ -0,0 +1,14 @@
+[
+    {
+        "PublicDescription": "ETM trace unit output 0",
+        "EventCode": "0xDE",
+        "EventName": "ETM_EXT_OUT0",
+        "BriefDescription": "ETM trace unit output 0"
+    },
+    {
+        "PublicDescription": "ETM trace unit output 1",
+        "EventCode": "0xDF",
+        "EventName": "ETM_EXT_OUT1",
+        "BriefDescription": "ETM trace unit output 1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/exception.json
new file mode 100644
index 000000000000..b77f1228873d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/exception.json
@@ -0,0 +1,14 @@
+[
+    {
+        "ArchStdEvent": "EXC_TAKEN"
+    },
+    {
+        "ArchStdEvent": "EXC_HVC"
+    },
+    {
+        "PublicDescription": "Number of Traps to hypervisor",
+        "EventCode": "0xDC",
+        "EventName": "EXC_TRAP_HYP",
+        "BriefDescription": "Number of Traps to hypervisor"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/instruction.json
new file mode 100644
index 000000000000..91a7863ddc9a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/instruction.json
@@ -0,0 +1,65 @@
+[
+    {
+        "ArchStdEvent": "SW_INCR"
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
+        "ArchStdEvent": "LDREX_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_FAIL_SPEC"
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
+        "ArchStdEvent": "DSB_SPEC"
+    },
+    {
+        "ArchStdEvent": "DMB_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/memory.json
new file mode 100644
index 000000000000..34e9cab7f0b9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/memory.json
@@ -0,0 +1,14 @@
+[
+    {
+        "ArchStdEvent": "MEM_ACCESS"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR"
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/mmu.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/mmu.json
new file mode 100644
index 000000000000..b85c9cc81f23
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/mmu.json
@@ -0,0 +1,44 @@
+[
+    {
+        "PublicDescription": "Duration of a translation table walk handled by the MMU",
+        "EventCode": "0xE0",
+        "EventName": "MMU_PTW",
+        "BriefDescription": "Duration of a translation table walk handled by the MMU"
+    },
+    {
+        "PublicDescription": "Duration of a Stage 1 translation table walk handled by the MMU",
+        "EventCode": "0xE1",
+        "EventName": "MMU_PTW_ST1",
+        "BriefDescription": "Duration of a Stage 1 translation table walk handled by the MMU"
+    },
+    {
+        "PublicDescription": "Duration of a Stage 2 translation table walk handled by the MMU",
+        "EventCode": "0xE2",
+        "EventName": "MMU_PTW_ST2",
+        "BriefDescription": "Duration of a Stage 2 translation table walk handled by the MMU"
+    },
+    {
+        "PublicDescription": "Duration of a translation table walk requested by the LSU",
+        "EventCode": "0xE3",
+        "EventName": "MMU_PTW_LSU",
+        "BriefDescription": "Duration of a translation table walk requested by the LSU"
+    },
+    {
+        "PublicDescription": "Duration of a translation table walk requested by the Instruction Side",
+        "EventCode": "0xE4",
+        "EventName": "MMU_PTW_ISIDE",
+        "BriefDescription": "Duration of a translation table walk requested by the Instruction Side"
+    },
+    {
+        "PublicDescription": "Duration of a translation table walk requested by a Preload instruction or Prefetch request",
+        "EventCode": "0xE5",
+        "EventName": "MMU_PTW_PLD",
+        "BriefDescription": "Duration of a translation table walk requested by a Preload instruction or Prefetch request"
+    },
+    {
+        "PublicDescription": "Duration of a translation table walk requested by a CP15 operation (maintenance by MVA and VA to PA operations)",
+        "EventCode": "0xE6",
+        "EventName": "MMU_PTW_CP15",
+        "BriefDescription": "Duration of a translation table walk requested by a CP15 operation (maintenance by MVA and VA to PA operations)"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/pipeline.json
new file mode 100644
index 000000000000..1730969e49f7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a73/pipeline.json
@@ -0,0 +1,38 @@
+[
+    {
+        "PublicDescription": "A linefill caused an instruction side stall",
+        "EventCode": "0xC0",
+        "EventName": "LF_STALL",
+        "BriefDescription": "A linefill caused an instruction side stall"
+    },
+    {
+        "PublicDescription": "A translation table walk caused an instruction side stall",
+        "EventCode": "0xC1",
+        "EventName": "PTW_STALL",
+        "BriefDescription": "A translation table walk caused an instruction side stall"
+    },
+    {
+        "PublicDescription": "Duration for which all slots in the Load-Store Unit are busy",
+        "EventCode": "0xD3",
+        "EventName": "D_LSU_SLOT_FULL",
+        "BriefDescription": "Duration for which all slots in the Load-Store Unit are busy"
+    },
+    {
+        "PublicDescription": "Duration for which all slots in the load-store issue queue are busy",
+        "EventCode": "0xD8",
+        "EventName": "LS_IQ_FULL",
+        "BriefDescription": "Duration for which all slots in the load-store issue queue are busy"
+    },
+    {
+        "PublicDescription": "Duration for which all slots in the data processing issue queue are busy",
+        "EventCode": "0xD9",
+        "EventName": "DP_IQ_FULL",
+        "BriefDescription": "Duration for which all slots in the data processing issue queue are busy"
+    },
+    {
+        "PublicDescription": "Duration for which all slots in the Data Engine issue queue are busy",
+        "EventCode": "0xDA",
+        "EventName": "DE_IQ_FULL",
+        "BriefDescription": "Duration for which all slots in the Data Engine issue queue are busy"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 3ad4e991d62b..f413d8b629de 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -27,6 +27,7 @@
 0x00000000410fd060,v1,arm/cortex-a65,core
 0x00000000410fd070,v1,arm/cortex-a57-a72,core
 0x00000000410fd080,v1,arm/cortex-a57-a72,core
+0x00000000410fd090,v1,arm/cortex-a73,core
 0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
 0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
 0x00000000410fd400,v1,arm/neoverse-v1,core
-- 
2.25.1

