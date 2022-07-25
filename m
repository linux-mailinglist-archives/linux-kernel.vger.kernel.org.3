Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A711C5807AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbiGYWkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiGYWjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:39:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609122715A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:38:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31edbd801b5so44550537b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Ma9Oq//nu3k6sW/IeldAYXRE3Caqk0B5vRLj+oGkLnE=;
        b=KLAiIteKYIdyRX6XuqvYaEdLi5tOxfatZuK9NUBc67Il6zyf8JgwUWniNcaIrpiDQi
         JhGTww1gNYsmwKm1zZP38vkyg2Msx067gYH2s0Zr/ZAAiK/6v1YaZytA22RB9lzefMBN
         kmTiPG1smfwBzqtxe0W9ASSHWTBJLwKB17uNdUeUaK6K2MArLbcF0MhsqlC5JIkQRztT
         Ok8y6s8oyFmaNfdAkk28M1Qcgf0vnuFO7gVnS3sOVn6YZNmTtfY3PLgi4Qxfgq7MqyHY
         90lYX06om0nfpf15jAwpPbStG8d5Y4T6KjZd0yNmPxQYTd3SagtnKy9i0WoixMDNp2D0
         HjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Ma9Oq//nu3k6sW/IeldAYXRE3Caqk0B5vRLj+oGkLnE=;
        b=wVL7WsEAKbVdDhVz+fBaH3vsxOofkexj+FTS1H7DWrCY83dj9qIRE/bfejw7IAVYUE
         D5+/AuwC81xSKSdrLzKDf0DZ7Jys76mGtnOZgmMIICq/w1nJU5gBXpnJCPEMWlAYQ1N4
         QIMe1hUF9CPZjnDd9DnpSPagDLtvJRpFnwiQIcPDc0z6jjV0G6R8H6qOXTJKhi+uFvPi
         FQyu4i5swIVSwjmmMsy8SLT7leIx7TbKicb2XMzJq/rZa7mRuUetLFSUE1ZmfmgfEbQg
         A2C8SRGBdBBTXVtGztREVk9iEJeh7MlfesPWV20MGSBCqz8uZCjmcZDrckMzJV8evlzg
         0GYg==
X-Gm-Message-State: AJIora+Wrts3OYSELvgD1bJZsfUbdUViY3YPNT/HnW53jfbsouHSoRwN
        4DwA1ar1k+IPZjmkArRj8nCfIQRaBmil
X-Google-Smtp-Source: AGRyM1u+TN22s14/70niDSSb/+nVYGIQaP2QwNdK7dGTxvAQh+pQwYq6FuX+NCJVguObpDbUdzsCzhrbrytq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a81:d542:0:b0:31e:c878:7565 with SMTP id
 l2-20020a81d542000000b0031ec8787565mr10894539ywj.382.1658788676609; Mon, 25
 Jul 2022 15:37:56 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:28 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-28-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 27/32] perf vendor events: Update Intel tigerlake
From:   Ian Rogers <irogers@google.com>
To:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to v1.07, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

to download and generate the latest events and metrics. Manually copy
the tigerlake files into perf and update mapfile.csv.

Tested on a non-tigerlake with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../pmu-events/arch/x86/tigerlake/cache.json  |  48 ++-
 .../arch/x86/tigerlake/floating-point.json    |   2 +-
 .../arch/x86/tigerlake/frontend.json          |   2 +-
 .../pmu-events/arch/x86/tigerlake/memory.json |   2 +-
 .../pmu-events/arch/x86/tigerlake/other.json  |   1 -
 .../arch/x86/tigerlake/pipeline.json          |   4 +-
 .../arch/x86/tigerlake/tgl-metrics.json       | 378 +++++++++++++++---
 .../arch/x86/tigerlake/uncore-other.json      |  65 +++
 .../arch/x86/tigerlake/virtual-memory.json    |   2 +-
 10 files changed, 439 insertions(+), 67 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.j=
son

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index bdf5f7f1c516..ddb504a626d3 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -24,10 +24,10 @@ GenuineIntel-6-8F,v1.04,sapphirerapids,core
 GenuineIntel-6-(37|4C|4D),v14,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v53,skylake,core
 GenuineIntel-6-55-[01234],v1.28,skylakex,core
+GenuineIntel-6-8[CD],v1.07,tigerlake,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
-GenuineIntel-6-8[CD],v1,tigerlake,core
 GenuineIntel-6-86,v1,tremontx,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/tigerlake/cache.json
index 0569b2c704ca..5ccf0edc29ac 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/cache.json
@@ -112,6 +112,17 @@
         "SampleAfterValue": "200003",
         "UMask": "0xe4"
     },
+    {
+        "BriefDescription": "Demand Data Read access L2 cache",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe1"
+    },
     {
         "BriefDescription": "RFO requests to L2 cache",
         "CollectPEBSRecord": "2",
@@ -157,16 +168,38 @@
         "UMask": "0xc1"
     },
     {
-        "BriefDescription": "All requests that miss L2 cache",
+        "BriefDescription": "Demand Data Read miss L2 cache",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "Read requests with true-miss in L2 cache",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts all requests that miss L2 cache.",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses.",
         "SampleAfterValue": "200003",
         "UMask": "0x3f"
     },
+    {
+        "BriefDescription": "All accesses to L2 cache",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.REFERENCES",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xff"
+    },
     {
         "BriefDescription": "RFO requests that hit L2 cache",
         "CollectPEBSRecord": "2",
@@ -353,7 +386,7 @@
         "UMask": "0x12"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "Snoop hit a modified(HITM) or clean line(HIT_=
W_FWD) in another on-pkg core which forwarded the data back due to a retire=
d load instruction.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
@@ -361,6 +394,7 @@
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions where a cro=
ss-core snoop hit in another cores caches on this socket, the data was forw=
arded back to the requesting core as the data was modified (SNOOP_HITM) or =
the L3 did not have the data(SNOOP_HIT_WITH_FWD).",
         "SampleAfterValue": "20011",
         "UMask": "0x4"
     },
@@ -391,7 +425,7 @@
         "UMask": "0x8"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "Snoop hit without forwarding in another on-pk=
g core due to a retired load instruction, data was supplied by the L3.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
@@ -399,6 +433,7 @@
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions in which th=
e L3 supplied the data and a cross-core snoop hit in another cores caches o=
n this socket but that other core did not forward the data back (SNOOP_HIT_=
NO_FWD).",
         "SampleAfterValue": "20011",
         "UMask": "0x2"
     },
@@ -503,7 +538,6 @@
         "MSRValue": "0x10003C0001",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -517,7 +551,6 @@
         "MSRValue": "0x8003C0001",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -531,7 +564,6 @@
         "MSRValue": "0x10003C0002",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -714,4 +746,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/floating-point.json b=
/tools/perf/pmu-events/arch/x86/tigerlake/floating-point.json
index de8eb2b34a3a..978b494c7458 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/floating-point.json
@@ -98,4 +98,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/frontend.json b/tools=
/perf/pmu-events/arch/x86/tigerlake/frontend.json
index 2eaa33cc574e..ccdd8fd99556 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/frontend.json
@@ -475,4 +475,4 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/tigerlake/memory.json
index 0948de0b160c..6071794cbd32 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/memory.json
@@ -292,4 +292,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/tigerlake/other.json
index 65539490e18f..3ed22dbd0982 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/other.json
@@ -42,7 +42,6 @@
         "MSRValue": "0x10800",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/tigerlake/pipeline.json
index a8aa1b455c77..1f273144f8e8 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
@@ -432,13 +432,13 @@
         "UMask": "0x40"
     },
     {
-        "BriefDescription": "Cycles where no uops were executed, the Reser=
vation Station was not empty, the Store Buffer was full and there was no ou=
tstanding load.",
+        "BriefDescription": "Cycles no uop executed while RS was not empty=
, the SB was not full and there was no outstanding load.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
-        "PublicDescription": "Counts cycles during which no uops were exec=
uted on all ports and Reservation Station (RS) was not empty.",
+        "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load.",
         "SampleAfterValue": "1000003",
         "UMask": "0x80"
     },
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
index 00a16f1a0f44..03c97bd74ad9 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
@@ -1,20 +1,26 @@
 [
+    {
+        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
+        "MetricExpr": "100 * (( BR_INST_RETIRED.COND + 3 * BR_INST_RETIRED=
.NEAR_CALL + (BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_TAKEN - 2 *=
 BR_INST_RETIRED.NEAR_CALL) ) / TOPDOWN.SLOTS)",
+        "MetricGroup": "Ret",
+        "MetricName": "Branching_Overhead"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
+        "MetricExpr": "100 * (( 5 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_D=
ELIV.CORE - INT_MISC.UOP_DROPPING ) / TOPDOWN.SLOTS) * ( (ICACHE_64B.IFTAG_=
STALL / CPU_CLK_UNHALTED.THREAD) + (ICACHE_16B.IFDATA_STALL / CPU_CLK_UNHAL=
TED.THREAD) + (10 * BACLEARS.ANY / CPU_CLK_UNHALTED.THREAD) ) / #(( 5 * IDQ=
_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE - INT_MISC.UOP_DROPPING ) / TO=
PDOWN.SLOTS)",
+        "MetricGroup": "BigFoot;Fed;Frontend;IcMiss;MemoryTLB",
+        "MetricName": "Big_Code"
+    },
     {
         "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
-        "MetricGroup": "Summary",
+        "MetricGroup": "Ret;Summary",
         "MetricName": "IPC"
     },
-    {
-        "BriefDescription": "Instruction per taken branch",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
-        "MetricGroup": "Branches;FetchBW;PGO",
-        "MetricName": "IpTB"
-    },
     {
         "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
-        "MetricExpr": "1 / IPC",
-        "MetricGroup": "Pipeline",
+        "MetricExpr": "1 / (INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD)",
+        "MetricGroup": "Pipeline;Mem",
         "MetricName": "CPI"
     },
     {
@@ -24,28 +30,48 @@
         "MetricName": "CLKS"
     },
     {
-        "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.DISTRIBUTED",
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
+        "MetricExpr": "TOPDOWN.SLOTS",
+        "MetricGroup": "TmaL1",
+        "MetricName": "SLOTS"
+    },
+    {
+        "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
+        "MetricExpr": "TOPDOWN.SLOTS / ( TOPDOWN.SLOTS / 2 ) if #SMT_on el=
se 1",
         "MetricGroup": "SMT;TmaL1",
+        "MetricName": "Slots_Utilization"
+    },
+    {
+        "BriefDescription": "The ratio of Executed- by Issued-Uops",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
+        "MetricGroup": "Cor;Pipeline",
+        "MetricName": "Execute_per_Issue",
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
+    },
+    {
+        "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.DISTRIBUTED",
+        "MetricGroup": "Ret;SMT;TmaL1",
         "MetricName": "CoreIPC"
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
         "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_AR=
ITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DO=
UBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIR=
ED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + =
FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512=
B_PACKED_SINGLE ) / CPU_CLK_UNHALTED.DISTRIBUTED",
-        "MetricGroup": "Flops",
+        "MetricGroup": "Ret;Flops",
         "MetricName": "FLOPc"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is at least 1 uop executed)",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / ( UOPS_EXECUTED.CORE_CYCLES_=
GE_1 / 2 )",
-        "MetricGroup": "Pipeline;PortsUtil",
-        "MetricName": "ILP"
+        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
+        "MetricExpr": "( (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_I=
NST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP=
_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_=
DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.5=
12B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) ) / ( 2 * CPU=
_CLK_UNHALTED.DISTRIBUTED )",
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "FP_Arith_Utilization",
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
     },
     {
-        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "BrMispredicts",
-        "MetricName": "IpMispredict"
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES=
_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
+        "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
+        "MetricName": "ILP"
     },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
@@ -68,99 +94,279 @@
     {
         "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Branches;InsType",
+        "MetricGroup": "Branches;Fed;InsType",
         "MetricName": "IpBranch"
     },
     {
         "BriefDescription": "Instructions per (near) call (lower number me=
ans higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
-        "MetricGroup": "Branches",
+        "MetricGroup": "Branches;Fed;PGO",
         "MetricName": "IpCall"
     },
+    {
+        "BriefDescription": "Instruction per taken branch",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO",
+        "MetricName": "IpTB"
+    },
     {
         "BriefDescription": "Branch instructions per taken branch. ",
         "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
-        "MetricGroup": "Branches;PGO",
+        "MetricGroup": "Branches;Fed;PGO",
         "MetricName": "BpTkBranch"
     },
     {
         "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / ( 1 * ( FP_ARITH_INST_RETIRED.SC=
ALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RET=
IRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + =
FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.25=
6B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARI=
TH_INST_RETIRED.512B_PACKED_SINGLE )",
-        "MetricGroup": "Flops;FpArith;InsType",
+        "MetricGroup": "Flops;InsType",
         "MetricName": "IpFLOP"
     },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / ( (FP_ARITH_INST_RETIRED.SCALAR_=
SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B=
_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_R=
ETIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_A=
RITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SI=
NGLE) )",
+        "MetricGroup": "Flops;InsType",
+        "MetricName": "IpArith",
+        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). May undercount due to FMA doubl=
e counting. Approximated prior to BDW."
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_SIN=
GLE",
+        "MetricGroup": "Flops;FpScalar;InsType",
+        "MetricName": "IpArith_Scalar_SP",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting."
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_DOU=
BLE",
+        "MetricGroup": "Flops;FpScalar;InsType",
+        "MetricName": "IpArith_Scalar_DP",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). May und=
ercount due to FMA double counting."
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / ( FP_ARITH_INST_RETIRED.128B_PAC=
KED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE )",
+        "MetricGroup": "Flops;FpVector;InsType",
+        "MetricName": "IpArith_AVX128",
+        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). May undercount =
due to FMA double counting."
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / ( FP_ARITH_INST_RETIRED.256B_PAC=
KED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )",
+        "MetricGroup": "Flops;FpVector;InsType",
+        "MetricName": "IpArith_AVX256",
+        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). May undercount due=
 to FMA double counting."
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic AVX 512-bit in=
struction (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / ( FP_ARITH_INST_RETIRED.512B_PAC=
KED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )",
+        "MetricGroup": "Flops;FpVector;InsType",
+        "MetricName": "IpArith_AVX512",
+        "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). May undercount due =
to FMA double counting."
+    },
+    {
+        "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
+        "MetricExpr": "INST_RETIRED.ANY / cpu@SW_PREFETCH_ACCESS.T0\\,umas=
k\\=3D0xF@",
+        "MetricGroup": "Prefetches",
+        "MetricName": "IpSWPF"
+    },
     {
         "BriefDescription": "Total number of retired Instructions, Sample =
with: INST_RETIRED.PREC_DIST",
         "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary;TmaL1",
         "MetricName": "Instructions"
     },
+    {
+        "BriefDescription": "",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
+        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
+        "MetricName": "Execute"
+    },
+    {
+        "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
+        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D1=
@",
+        "MetricGroup": "Fed;FetchBW",
+        "MetricName": "Fetch_UpC"
+    },
     {
         "BriefDescription": "Fraction of Uops delivered by the LSD (Loop S=
tream Detector; aka Loop Cache)",
         "MetricExpr": "LSD.UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS=
 + IDQ.MS_UOPS)",
-        "MetricGroup": "LSD",
+        "MetricGroup": "Fed;LSD",
         "MetricName": "LSD_Coverage"
     },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
         "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_=
UOPS + IDQ.MS_UOPS)",
-        "MetricGroup": "DSB;FetchBW",
+        "MetricGroup": "DSB;Fed;FetchBW",
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand loads (in core cycles)",
+        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu@DSB2MITE_SWI=
TCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
+        "MetricGroup": "DSBmiss",
+        "MetricName": "DSB_Switch_Cost"
+    },
+    {
+        "BriefDescription": "Number of Instructions per non-speculative DS=
B miss (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
+        "MetricGroup": "DSBmiss;Fed",
+        "MetricName": "IpDSB_Miss_Ret"
+    },
+    {
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "IpMispredict"
+    },
+    {
+        "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
+        "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL_B=
RANCHES",
+        "MetricGroup": "Bad;Branches;CodeGen;PGO",
+        "MetricName": "Cond_NT"
+    },
+    {
+        "BriefDescription": "Fraction of branches that are taken condition=
als",
+        "MetricExpr": "BR_INST_RETIRED.COND_TAKEN / BR_INST_RETIRED.ALL_BR=
ANCHES",
+        "MetricGroup": "Bad;Branches;CodeGen;PGO",
+        "MetricName": "Cond_TK"
+    },
+    {
+        "BriefDescription": "Fraction of branches that are CALL or RET",
+        "MetricExpr": "( BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_=
RETURN ) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "CallRet"
+    },
+    {
+        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
+        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.COND_=
TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "Jump"
+    },
+    {
+        "BriefDescription": "Fraction of branches of other types (not indi=
vidually covered by other metrics in Info.Branches group)",
+        "MetricExpr": "1 - ( (BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRE=
D.ALL_BRANCHES) + (BR_INST_RETIRED.COND_TAKEN / BR_INST_RETIRED.ALL_BRANCHE=
S) + (( BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR_RETURN ) / BR_INST=
_RETIRED.ALL_BRANCHES) + ((BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.CON=
D_TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES) )"=
,
+        "MetricGroup": "Bad;Branches",
+        "MetricName": "Other_Branches"
+    },
+    {
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS =
+ MEM_LOAD_RETIRED.FB_HIT )",
-        "MetricGroup": "MemoryBound;MemoryLat",
+        "MetricGroup": "Mem;MemoryBound;MemoryLat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
         "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss. Per-Logical Proces=
sor)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
-        "MetricGroup": "MemoryBound;MemoryBW",
+        "MetricGroup": "Mem;MemoryBound;MemoryBW",
         "MetricName": "MLP"
     },
+    {
+        "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY"=
,
+        "MetricGroup": "Mem;CacheMisses",
+        "MetricName": "L1MPKI"
+    },
+    {
+        "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
+        "MetricExpr": "1000 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.A=
NY",
+        "MetricGroup": "Mem;CacheMisses",
+        "MetricName": "L1MPKI_Load"
+    },
+    {
+        "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY"=
,
+        "MetricGroup": "Mem;Backend;CacheMisses",
+        "MetricName": "L2MPKI"
+    },
+    {
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
+        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Mem;CacheMisses;Offcore",
+        "MetricName": "L2MPKI_All"
+    },
+    {
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
+        "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.=
ANY",
+        "MetricGroup": "Mem;CacheMisses",
+        "MetricName": "L2MPKI_Load"
+    },
+    {
+        "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
+        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / IN=
ST_RETIRED.ANY",
+        "MetricGroup": "Mem;CacheMisses",
+        "MetricName": "L2HPKI_All"
+    },
+    {
+        "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
+        "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.A=
NY",
+        "MetricGroup": "Mem;CacheMisses",
+        "MetricName": "L2HPKI_Load"
+    },
+    {
+        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY"=
,
+        "MetricGroup": "Mem;CacheMisses",
+        "MetricName": "L3MPKI"
+    },
+    {
+        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
+        "MetricGroup": "Mem;CacheMisses",
+        "MetricName": "FB_HPKI"
+    },
     {
         "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
         "MetricConstraint": "NO_NMI_WATCHDOG",
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_=
PENDING + DTLB_STORE_MISSES.WALK_PENDING ) / ( 2 * CORE_CLKS )",
-        "MetricGroup": "MemoryTLB",
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_=
PENDING + DTLB_STORE_MISSES.WALK_PENDING ) / ( 2 * CPU_CLK_UNHALTED.DISTRIB=
UTED )",
+        "MetricGroup": "Mem;MemoryTLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "BriefDescription": "Average data fill bandwidth to the L1 data ca=
che [GB / sec]",
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
         "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
-        "MetricGroup": "MemoryBW",
+        "MetricGroup": "Mem;MemoryBW",
         "MetricName": "L1D_Cache_Fill_BW"
     },
     {
-        "BriefDescription": "Average data fill bandwidth to the L2 cache [=
GB / sec]",
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
         "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
-        "MetricGroup": "MemoryBW",
+        "MetricGroup": "Mem;MemoryBW",
         "MetricName": "L2_Cache_Fill_BW"
     },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration=
_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L3_Cache_Fill_BW"
+    },
     {
         "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
         "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / d=
uration_time",
-        "MetricGroup": "MemoryBW;Offcore",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
         "MetricName": "L3_Cache_Access_BW"
     },
     {
-        "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY"=
,
-        "MetricGroup": "CacheMisses",
-        "MetricName": "L1MPKI"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
+        "MetricExpr": "(64 * L1D.REPLACEMENT / 1000000000 / duration_time)=
",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L1D_Cache_Fill_BW_1T"
     },
     {
-        "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY"=
,
-        "MetricGroup": "CacheMisses",
-        "MetricName": "L2MPKI"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
+        "MetricExpr": "(64 * L2_LINES_IN.ALL / 1000000000 / duration_time)=
",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L2_Cache_Fill_BW_1T"
     },
     {
-        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY"=
,
-        "MetricGroup": "CacheMisses",
-        "MetricName": "L3MPKI"
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "(64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duratio=
n_time)",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L3_Cache_Fill_BW_1T"
+    },
+    {
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
+        "MetricExpr": "(64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / =
duration_time)",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "L3_Cache_Access_BW_1T"
     },
     {
         "BriefDescription": "Average CPU Utilization",
@@ -177,8 +383,9 @@
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
         "MetricExpr": "( ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_=
ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_=
DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RET=
IRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE =
+ FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.5=
12B_PACKED_SINGLE ) / 1000000000 ) / duration_time",
-        "MetricGroup": "Flops;HPC",
-        "MetricName": "GFLOPs"
+        "MetricGroup": "Cor;Flops;HPC",
+        "MetricName": "GFLOPs",
+        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
     },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
@@ -186,9 +393,30 @@
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
+    {
+        "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for baseline license level 0",
+        "MetricExpr": "CORE_POWER.LVL0_TURBO_LICENSE / CPU_CLK_UNHALTED.DI=
STRIBUTED",
+        "MetricGroup": "Power",
+        "MetricName": "Power_License0_Utilization",
+        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for baseline license level 0.  This includes non=
-AVX codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes."
+    },
+    {
+        "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 1",
+        "MetricExpr": "CORE_POWER.LVL1_TURBO_LICENSE / CPU_CLK_UNHALTED.DI=
STRIBUTED",
+        "MetricGroup": "Power",
+        "MetricName": "Power_License1_Utilization",
+        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 1.  This includes high current=
 AVX 256-bit instructions as well as low current AVX 512-bit instructions."
+    },
+    {
+        "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 2 (introduced in SKX)",
+        "MetricExpr": "CORE_POWER.LVL2_TURBO_LICENSE / CPU_CLK_UNHALTED.DI=
STRIBUTED",
+        "MetricGroup": "Power",
+        "MetricName": "Power_License2_Utilization",
+        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 2 (introduced in SKX).  This i=
ncludes high current AVX 512-bit instructions."
+    },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
-        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UN=
HALTED.REF_DISTRIBUTED",
+        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UN=
HALTED.REF_DISTRIBUTED if #SMT_on else 0",
         "MetricGroup": "SMT",
         "MetricName": "SMT_2T_Utilization"
     },
@@ -198,6 +426,24 @@
         "MetricGroup": "OS",
         "MetricName": "Kernel_Utilization"
     },
+    {
+        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
+        "MetricGroup": "OS",
+        "MetricName": "Kernel_CPI"
+    },
+    {
+        "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
+        "MetricExpr": "64 * ( arb@event\\=3D0x81\\,umask\\=3D0x1@ + arb@ev=
ent\\=3D0x84\\,umask\\=3D0x1@ ) / 1000000 / duration_time / 1000",
+        "MetricGroup": "HPC;Mem;MemoryBW;SoC",
+        "MetricName": "DRAM_BW_Use"
+    },
+    {
+        "BriefDescription": "Average number of parallel requests to extern=
al memory. Accounts for all requests",
+        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.ALL / arb@event\\=3D0x81\\,um=
ask\\=3D0x1@",
+        "MetricGroup": "Mem;SoC",
+        "MetricName": "MEM_Parallel_Requests"
+    },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
@@ -216,6 +462,18 @@
         "MetricGroup": "Power",
         "MetricName": "C7_Core_Residency"
     },
+    {
+        "BriefDescription": "C2 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C2_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "C3 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C3_Pkg_Residency"
+    },
     {
         "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
@@ -227,5 +485,23 @@
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
         "MetricName": "C7_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "C8 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c8\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C8_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "C9 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c9\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C9_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "C10 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c10\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C10_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json b/t=
ools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json
new file mode 100644
index 000000000000..734b1845c8e2
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json
@@ -0,0 +1,65 @@
+[
+    {
+        "BriefDescription": "Each cycle count number of all outgoing valid=
 entries in ReqTrk. Such entry is defined as valid from it's allocation in =
ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Counts every read (RdCAS) issued by the Memor=
y Controller to DRAM (sum of all channels). All requests result in 64 byte =
data transfers from DRAM.",
+        "Counter": "1",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_MC0_RDCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_MC0_RDCAS_COUNT_FREERUN",
+        "Unit": "h_imc"
+    },
+    {
+        "BriefDescription": "Counts every 64B read and write request enter=
ing the Memory Controller to DRAM (sum of all channels). Each write request=
 counts as a new request incrementing this counter. However, same cache lin=
e write requests (both full and partial) are combined to a single 64 byte d=
ata transfer to DRAM.",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_MC0_TOTAL_REQCOUNT_FREERUN",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_MC0_TOTAL_REQCOUNT_FREERUN",
+        "Unit": "h_imc"
+    },
+    {
+        "BriefDescription": "Counts every write (WrCAS) issued by the Memo=
ry Controller to DRAM (sum of all channels). All requests result in 64 byte=
 data transfers from DRAM.",
+        "Counter": "2",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_MC0_WRCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_MC0_WRCAS_COUNT_FREERUN",
+        "Unit": "h_imc"
+    },
+    {
+        "BriefDescription": "Counts every read (RdCAS) issued by the Memor=
y Controller to DRAM (sum of all channels). All requests result in 64 byte =
data transfers from DRAM.",
+        "Counter": "4",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_MC1_RDCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_MC1_RDCAS_COUNT_FREERUN",
+        "Unit": "h_imc"
+    },
+    {
+        "BriefDescription": "Counts every 64B read and write request enter=
ing the Memory Controller to DRAM (sum of all channels). Each write request=
 counts as a new request incrementing this counter. However, same cache lin=
e write requests (both full and partial) are combined to a single 64 byte d=
ata transfer to DRAM.",
+        "Counter": "3",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_MC1_TOTAL_REQCOUNT_FREERUN",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_MC1_TOTAL_REQCOUNT_FREERUN",
+        "Unit": "h_imc"
+    },
+    {
+        "BriefDescription": "Counts every write (WrCAS) issued by the Memo=
ry Controller to DRAM (sum of all channels). All requests result in 64 byte=
 data transfers from DRAM.",
+        "Counter": "5",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_MC1_WRCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_MC1_WRCAS_COUNT_FREERUN",
+        "Unit": "h_imc"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/virtual-memory.json b=
/tools/perf/pmu-events/arch/x86/tigerlake/virtual-memory.json
index 3ebec78969b0..fd364abf8002 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/virtual-memory.json
@@ -222,4 +222,4 @@
         "SampleAfterValue": "100007",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
--=20
2.37.1.359.gd136c6c3e2-goog

