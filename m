Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8F252F264
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352542AbiETSPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352539AbiETSPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:15:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B70D1900E1;
        Fri, 20 May 2022 11:15:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D13A01480;
        Fri, 20 May 2022 11:15:21 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.32.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2DB9A3F718;
        Fri, 20 May 2022 11:15:19 -0700 (PDT)
From:   Nick Forrington <nick.forrington@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Nick Forrington <nick.forrington@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 01/13] perf vendors events arm64: Arm Cortex-A34
Date:   Fri, 20 May 2022 19:14:43 +0100
Message-Id: <20220520181455.340344-2-nick.forrington@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520181455.340344-1-nick.forrington@arm.com>
References: <20220520181455.340344-1-nick.forrington@arm.com>
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

Add PMU events for Arm Cortex-A34
Add corresponding common events
Update mapfile.csv

Event data based on:
https://github.com/ARM-software/data/tree/master/pmu/cortex-a34.json

which is based on PMU event descriptions from the Arm Cortex-A34 Technical
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

Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 .../arch/arm64/arm/cortex-a34/branch.json     | 11 ++++++
 .../arch/arm64/arm/cortex-a34/bus.json        | 17 +++++++++
 .../arch/arm64/arm/cortex-a34/cache.json      | 32 +++++++++++++++++
 .../arch/arm64/arm/cortex-a34/exception.json  | 14 ++++++++
 .../arm64/arm/cortex-a34/instruction.json     | 29 +++++++++++++++
 .../arch/arm64/arm/cortex-a34/memory.json     |  8 +++++
 .../arch/arm64/common-and-microarch.json      | 36 +++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |  1 +
 8 files changed, 148 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a34/memory.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/branch.json
new file mode 100644
index 000000000000..ece201718284
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/branch.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/bus.json
new file mode 100644
index 000000000000..75d850b781ac
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/bus.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/cache.json
new file mode 100644
index 000000000000..8a9a95e05c32
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/cache.json
@@ -0,0 +1,32 @@
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
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/exception.json
new file mode 100644
index 000000000000..27c3fe9c831a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/exception.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/instruction.json
new file mode 100644
index 000000000000..7c018f439206
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/instruction.json
@@ -0,0 +1,29 @@
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
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/memory.json
new file mode 100644
index 000000000000..2c319f936957
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a34/memory.json
@@ -0,0 +1,8 @@
+[
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_RETIRED"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
index 80d7a70829a0..20923bf10adc 100644
--- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
+++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
@@ -35,6 +35,18 @@
         "EventName": "L1D_TLB_REFILL",
         "BriefDescription": "Attributable Level 1 data TLB refill"
     },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition code check pass, load",
+        "EventCode": "0x06",
+        "EventName": "LD_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, load"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition code check pass, store",
+        "EventCode": "0x07",
+        "EventName": "ST_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, store"
+    },
     {
         "PublicDescription": "Instruction architecturally executed",
         "EventCode": "0x08",
@@ -59,6 +71,30 @@
         "EventName": "CID_WRITE_RETIRED",
         "BriefDescription": "Instruction architecturally executed, condition code check pass, write to CONTEXTIDR"
     },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition code check pass, software change of the PC",
+        "EventCode": "0x0C",
+        "EventName": "PC_WRITE_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, software change of the PC"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, immediate branch",
+        "EventCode": "0x0D",
+        "EventName": "BR_IMMED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, immediate branch"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition code check pass, procedure return",
+        "EventCode": "0x0E",
+        "EventName": "BR_RETURN_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, procedure return"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition code check pass, unaligned",
+        "EventCode": "0x0F",
+        "EventName": "UNALIGNED_LDST_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, unaligned"
+    },
     {
         "PublicDescription": "Mispredicted or not predicted branch speculatively executed",
         "EventCode": "0x10",
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index b899db48c12a..461bb8b845d6 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -12,6 +12,7 @@
 #
 #
 #Family-model,Version,Filename,EventType
+0x00000000410fd020,v1,arm/cortex-a34,core
 0x00000000410fd030,v1,arm/cortex-a53,core
 0x00000000420f1000,v1,arm/cortex-a53,core
 0x00000000410fd070,v1,arm/cortex-a57-a72,core
-- 
2.25.1

