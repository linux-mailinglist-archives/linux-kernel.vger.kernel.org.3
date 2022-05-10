Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E395212D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbiEJK53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbiEJKyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:54:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 808812AC6D7;
        Tue, 10 May 2022 03:49:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C8A41688;
        Tue, 10 May 2022 03:49:41 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.33.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C40753F66F;
        Tue, 10 May 2022 03:49:38 -0700 (PDT)
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
Subject: [PATCH 20/20] perf vendors events arm64: Arm Neoverse E1
Date:   Tue, 10 May 2022 11:47:58 +0100
Message-Id: <20220510104758.64677-21-nick.forrington@arm.com>
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

Add PMU events for Arm Neoverse E1
Update mapfile.csv

Event data based on:
https://github.com/ARM-software/data/tree/master/pmu/neoverse-e1.json

which is based on PMU event descriptions from the Arm Neoverse E1 Technical
Reference Manual.

Mapping data (for mapfile.csv) based on:
https://github.com/ARM-software/data/blob/master/cpus.json

which is based on Main ID Register (MIDR) information found in the Arm
Technical Reference Manuals for individual CPUs.

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 .../arch/arm64/arm/neoverse-e1/branch.json    |  17 +++
 .../arch/arm64/arm/neoverse-e1/bus.json       |  17 +++
 .../arch/arm64/arm/neoverse-e1/cache.json     | 107 ++++++++++++++++++
 .../arch/arm64/arm/neoverse-e1/exception.json |  14 +++
 .../arm64/arm/neoverse-e1/instruction.json    |  65 +++++++++++
 .../arch/arm64/arm/neoverse-e1/memory.json    |  23 ++++
 .../arch/arm64/arm/neoverse-e1/pipeline.json  |   8 ++
 .../arch/arm64/arm/neoverse-e1/spe.json       |  14 +++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 9 files changed, 266 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/branch.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/branch.json
new file mode 100644
index 000000000000..2f2d137f5f55
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/branch.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/bus.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/bus.json
new file mode 100644
index 000000000000..75d850b781ac
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/bus.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json
new file mode 100644
index 000000000000..3ad15e3a93a9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json
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
+        "ArchStdEvent": "L1D_CACHE_ALLOCATE"
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
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/exception.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/exception.json
new file mode 100644
index 000000000000..27c3fe9c831a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/exception.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json
new file mode 100644
index 000000000000..6c3b8f772e7f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json
@@ -0,0 +1,65 @@
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
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json
new file mode 100644
index 000000000000..78ed6dfcedc1
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json
@@ -0,0 +1,23 @@
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
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/pipeline.json
new file mode 100644
index 000000000000..eeac798d403a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/pipeline.json
@@ -0,0 +1,8 @@
+[
+    {
+        "ArchStdEvent": "STALL_FRONTEND"
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json
new file mode 100644
index 000000000000..20f2165c85fe
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json
@@ -0,0 +1,14 @@
+[
+    {
+        "ArchStdEvent": "SAMPLE_POP"
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED"
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FILTRATE"
+    },
+    {
+        "ArchStdEvent": "SAMPLE_COLLISION"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index eeed048e407b..9ff3b8065370 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -39,6 +39,7 @@
 0x00000000410fd470,v1,arm/cortex-a710,core
 0x00000000410fd480,v1,arm/cortex-x2,core
 0x00000000410fd490,v1,arm/neoverse-n2,core
+0x00000000410fd4a0,v1,arm/neoverse-e1,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000460f0010,v1,fujitsu/a64fx,core
-- 
2.25.1

