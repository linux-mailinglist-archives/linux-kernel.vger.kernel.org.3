Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5347657E9C8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbiGVWf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiGVWeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:34:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA697BE9D7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k13-20020a056902024d00b0066fa7f50b97so4589814ybs.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=fhmlSnevk2xhbvSRKkpKsIxH/ax8aDA03SJUh705U1w=;
        b=frApLwHTjeB5byNydbwczt9avG1/RskucEakX5bajheA6ODJGReRQsy7UxHjUIDot/
         3tCQdqRGZSZRMBWBOjsvE2hr/vdMNMqmsbdPDxDLbagncCZTmgzN51ZLn96Wp4lDA/rV
         4lju+VaGI+LCBo8WHn3kJAft61YdHFxM2OV2L2Fkt2IelyP0RuRKqTL0zF5d8SS/1h6t
         8Zft4nhsIwN+w7TSGoIAGDKKTRm6NvdAROsvHzUSGoHmPMxs+XWYtTdwXKduo3Irl78j
         hT9GfypuogkxYbM9hd8Tt6KS3ppmMVHdW5z+0nef0DAyS/N0tCGrQJxzwgKOmZWAeLgo
         22GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=fhmlSnevk2xhbvSRKkpKsIxH/ax8aDA03SJUh705U1w=;
        b=mJNgxv0EZG2AqjYxU2JO/OSrA2k0GLOy8IdZf+q+jXNeck18wXk0nneKIoWITBB+3m
         DScYXMd1Y+gXSUfMr4UMBSyuhejr5HvSvVfN2AbWvmzKNos35kd2C4gd8ajMLQhnLWvK
         wRuISjOtV/KTnKbKqtjgCIdf8EGnGAPbFJWL5Vag6SF6b4j7Hwtyub7KQJAdCY5pu1Xq
         JPlsYcdwiL5K8qw34BQRho+PXdAeHxXBnJlRx12zdUe0LKvPh7qztQPd9wAVnpuaxaJZ
         b0WOq95NWFi/37rxAuWgaJ9G9fUgLR/2xWyea4Vs/xe/EZ4j/lqBGbHPfs6OxTxerau0
         s7bw==
X-Gm-Message-State: AJIora+gEjvoet8cp3UGX5Zul5pWEmjxho3pxG9pRCCpFj0D4g1fnx/p
        /hWe7XwO/XAMb3lR6ZNNbprMs/3GQtof
X-Google-Smtp-Source: AGRyM1sPa9Wy4Ff5Zh/e3w2Cn0Qx0affFdOu0d0zigLs6wuWnIALux+1j+cmawlX/8VrzGPXWAlclZ5b/Qf/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a25:bcc6:0:b0:670:c602:ade5 with SMTP id
 l6-20020a25bcc6000000b00670c602ade5mr1780782ybm.209.1658529216098; Fri, 22
 Jul 2022 15:33:36 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:26 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-18-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 17/31] perf vendor events: Update Intel jaketown
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

to download and generate the latest events and metrics. Manually copy
the jaketown files into perf and update mapfile.csv.

Tested on a non-jaketown with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/jaketown/cache.json   |    2 +-
 .../arch/x86/jaketown/floating-point.json     |    2 +-
 .../arch/x86/jaketown/frontend.json           |    2 +-
 .../arch/x86/jaketown/jkt-metrics.json        |   11 +-
 .../pmu-events/arch/x86/jaketown/memory.json  |    2 +-
 .../pmu-events/arch/x86/jaketown/other.json   |    2 +-
 .../arch/x86/jaketown/pipeline.json           |   16 +-
 .../arch/x86/jaketown/uncore-cache.json       | 1960 ++++++++++++++++-
 .../x86/jaketown/uncore-interconnect.json     |  824 ++++++-
 .../arch/x86/jaketown/uncore-memory.json      |  445 +++-
 .../arch/x86/jaketown/uncore-other.json       | 1551 +++++++++++++
 .../arch/x86/jaketown/uncore-power.json       |  362 +--
 .../arch/x86/jaketown/virtual-memory.json     |    2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
 14 files changed, 4910 insertions(+), 273 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/uncore-other.js=
on

diff --git a/tools/perf/pmu-events/arch/x86/jaketown/cache.json b/tools/per=
f/pmu-events/arch/x86/jaketown/cache.json
index 97c7e0ceed18..f98649fb92b4 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/cache.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/cache.json
@@ -1263,4 +1263,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/floating-point.json b/=
tools/perf/pmu-events/arch/x86/jaketown/floating-point.json
index 713878fd062b..eb2ff2cfdf6b 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/floating-point.json
@@ -135,4 +135,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/frontend.json b/tools/=
perf/pmu-events/arch/x86/jaketown/frontend.json
index 4bc0954448d2..0b4dbce2f1c0 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/frontend.json
@@ -311,4 +311,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/too=
ls/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
index 2800264c12aa..2711cbe536b8 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
@@ -124,7 +124,7 @@
         "MetricName": "FLOPc_SMT"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is at least 1 uop executed)",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
         "MetricExpr": "UOPS_DISPATCHED.THREAD / (( cpu@UOPS_DISPATCHED.COR=
E\\,cmask\\=3D1@ / 2 ) if #SMT_on else cpu@UOPS_DISPATCHED.CORE\\,cmask\\=
=3D1@)",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "ILP"
@@ -141,6 +141,12 @@
         "MetricGroup": "Summary;TmaL1",
         "MetricName": "Instructions"
     },
+    {
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "Retire"
+    },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
         "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MIT=
E_UOPS + IDQ.MS_UOPS ) )",
@@ -163,7 +169,8 @@
         "BriefDescription": "Giga Floating Point Operations Per Second",
         "MetricExpr": "( ( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_CO=
MP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 =
* ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * S=
IMD_FP_256.PACKED_SINGLE ) / 1000000000 ) / duration_time",
         "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "GFLOPs"
+        "MetricName": "GFLOPs",
+        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
     },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/memory.json b/tools/pe=
rf/pmu-events/arch/x86/jaketown/memory.json
index 29b70f21a44b..23756ca9b7da 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/memory.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/memory.json
@@ -419,4 +419,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/other.json b/tools/per=
f/pmu-events/arch/x86/jaketown/other.json
index e251f535ec09..2f873ab14156 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/other.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/other.json
@@ -55,4 +55,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json b/tools/=
perf/pmu-events/arch/x86/jaketown/pipeline.json
index 87737c92c067..61a3db4d67d5 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
@@ -410,8 +410,8 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
-        "Counter": "Fixed counter 3",
-        "CounterHTOff": "Fixed counter 3",
+        "Counter": "Fixed counter 2",
+        "CounterHTOff": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "This event counts the number of reference cy=
cles when the core is not in a halt state. The core enters the halt state w=
hen it is running the HLT instruction or the MWAIT instruction. This event =
is not affected by core frequency changes (for example, P states, TM2 trans=
itions) but has the same incrementing frequency as the time stamp counter. =
This event can approximate elapsed time while the core was not in a halt st=
ate. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK eve=
nt. It is counted on a dedicated fixed counter, leaving the four (eight whe=
n Hyperthreading is disabled) programmable counters available for other eve=
nts.",
         "SampleAfterValue": "2000003",
@@ -439,8 +439,8 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt st=
ate.",
-        "Counter": "Fixed counter 2",
-        "CounterHTOff": "Fixed counter 2",
+        "Counter": "Fixed counter 1",
+        "CounterHTOff": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "This event counts the number of core cycles =
while the thread is not in a halt state. The thread enters the halt state w=
hen it is running the HLT instruction. This event is a component in many ke=
y event ratios. The core frequency may change from time to time due to tran=
sitions associated with Enhanced Intel SpeedStep Technology or TM2. For thi=
s reason this event may have a changing ratio with regards to time. When th=
e core frequency is constant, this event can approximate elapsed time while=
 the core was not in the halt state. It is counted on a dedicated fixed cou=
nter, leaving the four (eight when Hyperthreading is disabled) programmable=
 counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -542,8 +542,8 @@
     },
     {
         "BriefDescription": "Instructions retired from execution.",
-        "Counter": "Fixed counter 1",
-        "CounterHTOff": "Fixed counter 1",
+        "Counter": "Fixed counter 0",
+        "CounterHTOff": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "This event counts the number of instructions=
 retired from execution. For instructions that consist of multiple micro-op=
s, this event counts the retirement of the last micro-op of the instruction=
. Counting continues during hardware interrupts, traps, and inside interrup=
t handlers.",
         "SampleAfterValue": "2000003",
@@ -599,7 +599,7 @@
         "UMask": "0x3"
     },
     {
-        "BriefDescription": "Number of occurences waiting for the checkpoi=
nts in Resource Allocation Table (RAT) to be recovered after Nuke due to al=
l other cases except JEClear (e.g. whenever a ucode assist is needed like S=
SE exception, memory disambiguation, etc...).",
+        "BriefDescription": "Number of occurrences waiting for the checkpo=
ints in Resource Allocation Table (RAT) to be recovered after Nuke due to a=
ll other cases except JEClear (e.g. whenever a ucode assist is needed like =
SSE exception, memory disambiguation, etc...).",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
@@ -1199,4 +1199,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
index 3fa61d962607..cf28ffa778ba 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
@@ -1,210 +1,1976 @@
 [
     {
-        "BriefDescription": "Uncore cache clock ticks",
+        "BriefDescription": "Uncore Clocks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "All LLC Misses (code+ data rd + data wr - inc=
luding demand and prefetch)",
+        "BriefDescription": "Counter 0 Occupancy",
+        "Counter": "1,2,3",
+        "EventCode": "0x1f",
+        "EventName": "UNC_C_COUNTER0_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Since occupancy counts can only be captured =
in the Cbo's 0 counter, this event allows a user to capture occupancy relat=
ed information by filtering the Cb0 occupancy count captured in Counter 0. =
  The filtering available is found in the control register - threshold, inv=
ert and edge detect.   E.g. setting threshold to 1 can effectively monitor =
how many cycles the monitored queue has an entry.",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Cache Lookups; Data Read Request",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
+        "Filter": "CBoFilter[22:18]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:18] bits correspond to [FMESI] state.",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Cache Lookups; RTID",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.NID",
+        "Filter": "CBoFilter[22:18], CBoFilter[17:10]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:18] bits correspond to [FMESI] state.",
+        "UMask": "0x41",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Cache Lookups; External Snoop Request",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
+        "Filter": "CBoFilter[22:18]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:18] bits correspond to [FMESI] state.",
+        "UMask": "0x9",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Cache Lookups; Write Requests",
         "Counter": "0,1",
         "EventCode": "0x34",
-        "EventName": "UNC_C_LLC_LOOKUP.ANY",
-        "Filter": "filter_state=3D0x1",
+        "EventName": "UNC_C_LLC_LOOKUP.WRITE",
+        "Filter": "CBoFilter[22:18]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:18] bits correspond to [FMESI] state.",
+        "UMask": "0x5",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Lines in E state",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.E_STATE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Lines Victimized",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.MISS",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x11",
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x8",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "M line evictions from LLC (writebacks to memo=
ry)",
+        "BriefDescription": "Lines Victimized; Lines in M state",
         "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.M_STATE",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC misses - demand and prefetch data reads -=
 excludes LLC prefetches. Derived from unc_c_tor_inserts.miss_opcode.demand=
",
+        "BriefDescription": "Lines Victimized; Victimized Lines that Match=
 NID",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.DATA_READ",
-        "Filter": "filter_opc=3D0x182",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.NID",
+        "Filter": "CBoFilter[17:10]",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x40",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC misses - Uncacheable reads. Derived from =
unc_c_tor_inserts.miss_opcode.uncacheable",
+        "BriefDescription": "Lines Victimized; Lines in S State",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.UNCACHEABLE",
-        "Filter": "filter_opc=3D0x187",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.S_STATE",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x4",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe allocating writes that miss LLC - DDIO m=
isses. Derived from unc_c_tor_inserts.miss_opcode.ddio_miss",
+        "BriefDescription": "Cbo Misc; RFO HitS",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.PCIE_WRITE",
-        "Filter": "filter_opc=3D0x19c",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.RFO_HIT_S",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Miscellaneous events in the Cbo.",
+        "UMask": "0x8",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC misses for ItoM writes (as part of fast s=
tring memcpy stores). Derived from unc_c_tor_inserts.miss_opcode.itom_write=
",
+        "BriefDescription": "Cbo Misc; Silent Snoop Eviction",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.ITOM_WRITE",
-        "Filter": "filter_opc=3D0x1c8",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.RSPI_WAS_FSE",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Miscellaneous events in the Cbo.",
+        "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Streaming stores (full cache line). Derived f=
rom unc_c_tor_inserts.opcode.streaming_full",
+        "BriefDescription": "Cbo Misc",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.STREAMING_FULL",
-        "Filter": "filter_opc=3D0x18c",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.STARTED",
+        "PerPkg": "1",
+        "PublicDescription": "Miscellaneous events in the Cbo.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Cbo Misc; Write Combining Aliasing",
+        "Counter": "0,1",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.WC_ALIASING",
+        "PerPkg": "1",
+        "PublicDescription": "Miscellaneous events in the Cbo.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Down and Even",
+        "Counter": "2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_C_RING_AD_USED.DOWN_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the 'UP=
' direction is on the clockwise ring and 'DN' is on the counter-clockwise r=
ing.  On the right side of the ring, this is reversed.  The first half of t=
he CBos are on the left side of the ring, and the 2nd half are on the right=
 side of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD=
 is NOT the same ring as CBo 2 UP AD because they are on opposite sides of =
the ring.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Down and Odd",
+        "Counter": "2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_C_RING_AD_USED.DOWN_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the 'UP=
' direction is on the clockwise ring and 'DN' is on the counter-clockwise r=
ing.  On the right side of the ring, this is reversed.  The first half of t=
he CBos are on the left side of the ring, and the 2nd half are on the right=
 side of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD=
 is NOT the same ring as CBo 2 UP AD because they are on opposite sides of =
the ring.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Up and Even",
+        "Counter": "2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_C_RING_AD_USED.UP_EVEN",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the 'UP=
' direction is on the clockwise ring and 'DN' is on the counter-clockwise r=
ing.  On the right side of the ring, this is reversed.  The first half of t=
he CBos are on the left side of the ring, and the 2nd half are on the right=
 side of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD=
 is NOT the same ring as CBo 2 UP AD because they are on opposite sides of =
the ring.",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Streaming stores (partial cache line). Derive=
d from unc_c_tor_inserts.opcode.streaming_partial",
+        "BriefDescription": "AD Ring In Use; Up and Odd",
+        "Counter": "2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_C_RING_AD_USED.UP_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the 'UP=
' direction is on the clockwise ring and 'DN' is on the counter-clockwise r=
ing.  On the right side of the ring, this is reversed.  The first half of t=
he CBos are on the left side of the ring, and the 2nd half are on the right=
 side of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD=
 is NOT the same ring as CBo 2 UP AD because they are on opposite sides of =
the ring.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Down and Even",
+        "Counter": "2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_C_RING_AK_USED.DOWN_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the 'UP' =
direction is on the clockwise ring and 'DN' is on the counter-clockwise rin=
g.  On the right side of the ring, this is reversed.  The first half of the=
 CBos are on the left side of the ring, and the 2nd half are on the right s=
ide of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD i=
s NOT the same ring as CBo 2 UP AD because they are on opposite sides of th=
e ring.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Down and Odd",
+        "Counter": "2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_C_RING_AK_USED.DOWN_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the 'UP' =
direction is on the clockwise ring and 'DN' is on the counter-clockwise rin=
g.  On the right side of the ring, this is reversed.  The first half of the=
 CBos are on the left side of the ring, and the 2nd half are on the right s=
ide of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD i=
s NOT the same ring as CBo 2 UP AD because they are on opposite sides of th=
e ring.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Up and Even",
+        "Counter": "2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_C_RING_AK_USED.UP_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the 'UP' =
direction is on the clockwise ring and 'DN' is on the counter-clockwise rin=
g.  On the right side of the ring, this is reversed.  The first half of the=
 CBos are on the left side of the ring, and the 2nd half are on the right s=
ide of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD i=
s NOT the same ring as CBo 2 UP AD because they are on opposite sides of th=
e ring.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Up and Odd",
+        "Counter": "2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_C_RING_AK_USED.UP_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the 'UP' =
direction is on the clockwise ring and 'DN' is on the counter-clockwise rin=
g.  On the right side of the ring, this is reversed.  The first half of the=
 CBos are on the left side of the ring, and the 2nd half are on the right s=
ide of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD i=
s NOT the same ring as CBo 2 UP AD because they are on opposite sides of th=
e ring.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Down and Even",
+        "Counter": "2,3",
+        "EventCode": "0x1d",
+        "EventName": "UNC_C_RING_BL_USED.DOWN_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from  the ring stop.We really have two rings in JKT -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the 'UP'=
 direction is on the clockwise ring and 'DN' is on the counter-clockwise ri=
ng.  On the right side of the ring, this is reversed.  The first half of th=
e CBos are on the left side of the ring, and the 2nd half are on the right =
side of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD =
is NOT the same ring as CBo 2 UP AD because they are on opposite sides of t=
he ring.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Down and Odd",
+        "Counter": "2,3",
+        "EventCode": "0x1d",
+        "EventName": "UNC_C_RING_BL_USED.DOWN_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from  the ring stop.We really have two rings in JKT -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the 'UP'=
 direction is on the clockwise ring and 'DN' is on the counter-clockwise ri=
ng.  On the right side of the ring, this is reversed.  The first half of th=
e CBos are on the left side of the ring, and the 2nd half are on the right =
side of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD =
is NOT the same ring as CBo 2 UP AD because they are on opposite sides of t=
he ring.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Up and Even",
+        "Counter": "2,3",
+        "EventCode": "0x1d",
+        "EventName": "UNC_C_RING_BL_USED.UP_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from  the ring stop.We really have two rings in JKT -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the 'UP'=
 direction is on the clockwise ring and 'DN' is on the counter-clockwise ri=
ng.  On the right side of the ring, this is reversed.  The first half of th=
e CBos are on the left side of the ring, and the 2nd half are on the right =
side of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD =
is NOT the same ring as CBo 2 UP AD because they are on opposite sides of t=
he ring.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Up and Odd",
+        "Counter": "2,3",
+        "EventCode": "0x1d",
+        "EventName": "UNC_C_RING_BL_USED.UP_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from  the ring stop.We really have two rings in JKT -- a clockwise=
 ring and a counter-clockwise ring.  On the left side of the ring, the 'UP'=
 direction is on the clockwise ring and 'DN' is on the counter-clockwise ri=
ng.  On the right side of the ring, this is reversed.  The first half of th=
e CBos are on the left side of the ring, and the 2nd half are on the right =
side of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD =
is NOT the same ring as CBo 2 UP AD because they are on opposite sides of t=
he ring.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Acknowledgements to core",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
-        "Filter": "filter_opc=3D0x18d",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.AK_CORE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Data Responses to core",
+        "Counter": "0,1",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.BL_CORE",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Snoops of processor's cache.",
+        "Counter": "0,1",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.IV_CORE",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Any",
+        "Counter": "2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_C_RING_IV_USED.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in JKT.  Therefore, i=
f one wants to monitor the 'Even' ring, they should select both UP_EVEN and=
 DN_EVEN.  To monitor the 'Odd' ring, they should select both UP_ODD and DN=
_ODD.",
+        "UMask": "0xf",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Arbiter Blocking Cycles; IRQ",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_C_RxR_EXT_STARVED.IPQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Arbiter Blocking Cycles; IPQ",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_C_RxR_EXT_STARVED.IRQ",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Partial PCIe reads. Derived from unc_c_tor_in=
serts.opcode.pcie_partial",
+        "BriefDescription": "Ingress Arbiter Blocking Cycles; ISMQ",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_PARTIAL_READ",
-        "Filter": "filter_opc=3D0x195",
+        "EventCode": "0x12",
+        "EventName": "UNC_C_RxR_EXT_STARVED.ISMQ",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Arbiter Blocking Cycles; ISMQ_BID",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_C_RxR_EXT_STARVED.ISMQ_BIDS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; IPQ",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.IPQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; IRQ",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.IRQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe allocating writes that hit in LLC (DDIO =
hits). Derived from unc_c_tor_inserts.opcode.ddio_hit",
+        "BriefDescription": "Ingress Allocations; IRQ Rejected",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_WRITE",
-        "Filter": "filter_opc=3D0x19c",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.IRQ_REJECTED",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; VFIFO",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.VFIFO",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Internal Starvation Cycles; IPQ",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_C_RxR_INT_STARVED.IPQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Internal Starvation Cycles; IRQ",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_C_RxR_INT_STARVED.IRQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe read current. Derived from unc_c_tor_ins=
erts.opcode.pcie_read_current",
+        "BriefDescription": "Ingress Internal Starvation Cycles; ISMQ",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_READ",
-        "Filter": "filter_opc=3D0x19e",
+        "EventCode": "0x14",
+        "EventName": "UNC_C_RxR_INT_STARVED.ISMQ",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Probe Queue Retries; Address Conflict",
+        "Counter": "0,1",
+        "EventCode": "0x31",
+        "EventName": "UNC_C_RxR_IPQ_RETRY.ADDR_CONFLICT",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Probe Queue Retries; Any Reject",
+        "Counter": "0,1",
+        "EventCode": "0x31",
+        "EventName": "UNC_C_RxR_IPQ_RETRY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "ItoM write hits (as part of fast string memcp=
y stores). Derived from unc_c_tor_inserts.opcode.itom_write_hit",
+        "BriefDescription": "Probe Queue Retries; No Egress Credits",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.ITOM_WRITE",
-        "Filter": "filter_opc=3D0x1c8",
+        "EventCode": "0x31",
+        "EventName": "UNC_C_RxR_IPQ_RETRY.FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Probe Queue Retries; No QPI Credits",
+        "Counter": "0,1",
+        "EventCode": "0x31",
+        "EventName": "UNC_C_RxR_IPQ_RETRY.QPI_CREDITS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; Address Confli=
ct",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.ADDR_CONFLICT",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; Any Reject",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.ANY",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe non-snoop reads. Derived from unc_c_tor_=
inserts.opcode.pcie_read",
+        "BriefDescription": "Ingress Request Queue Rejects; No Egress Cred=
its",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_NS_READ",
-        "Filter": "filter_opc=3D0x1e4",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.FULL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; No QPI Credits=
",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.QPI_CREDITS",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; No RTIDs",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.RTID",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; Any Reject",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe non-snoop writes (partial). Derived from=
 unc_c_tor_inserts.opcode.pcie_partial_write",
+        "BriefDescription": "ISMQ Retries; No Egress Credits",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_NS_PARTIAL_WRITE",
-        "Filter": "filter_opc=3D0x1e5",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; No IIO Credits",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.IIO_CREDITS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.",
+        "UMask": "0x20",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; No QPI Credits",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.QPI_CREDITS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; No RTIDs",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.RTID",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; IPQ",
+        "EventCode": "0x11",
+        "EventName": "UNC_C_RxR_OCCUPANCY.IPQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; IRQ",
+        "EventCode": "0x11",
+        "EventName": "UNC_C_RxR_OCCUPANCY.IRQ",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe non-snoop writes (full line). Derived fr=
om unc_c_tor_inserts.opcode.pcie_full_write",
+        "BriefDescription": "Ingress Occupancy; IRQ Rejected",
+        "EventCode": "0x11",
+        "EventName": "UNC_C_RxR_OCCUPANCY.IRQ_REJECTED",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; VFIFO",
+        "EventCode": "0x11",
+        "EventName": "UNC_C_RxR_OCCUPANCY.VFIFO",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Evictions",
         "Counter": "0,1",
         "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_NS_WRITE",
-        "Filter": "filter_opc=3D0x1e6",
+        "EventName": "UNC_C_TOR_INSERTS.EVICTION",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "UMask": "0x4",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Occupancy counter for all LLC misses; we divi=
de this by UNC_C_CLOCKTICKS to get average Q depth",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_ALL",
-        "Filter": "filter_opc=3D0x182",
-        "MetricExpr": "(UNC_C_TOR_OCCUPANCY.MISS_ALL / UNC_C_CLOCKTICKS) *=
 100.",
-        "MetricName": "tor_occupancy.miss_all %",
+        "BriefDescription": "TOR Inserts; Miss All",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_ALL",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0xa",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Occupancy counter for LLC data reads (demand =
and L2 prefetch). Derived from unc_c_tor_occupancy.miss_opcode.llc_data_rea=
d",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.LLC_DATA_READ",
+        "BriefDescription": "TOR Inserts; Miss Opcode Match",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
+        "Filter": "CBoFilter[31:23]",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x3",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "read requests to home agent",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_H_REQUESTS.READS",
+        "BriefDescription": "TOR Inserts; NID Matched",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
+        "Filter": "CBoFilter[17:10]",
         "PerPkg": "1",
-        "UMask": "0x3",
-        "Unit": "HA"
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "UMask": "0x48",
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "write requests to home agent",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_H_REQUESTS.WRITES",
+        "BriefDescription": "TOR Inserts; NID Matched Evictions",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
+        "Filter": "CBoFilter[17:10]",
         "PerPkg": "1",
-        "UMask": "0xc",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "UMask": "0x44",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; NID Matched Miss All",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
+        "Filter": "CBoFilter[17:10]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "UMask": "0x4a",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; NID and Opcode Matched Miss",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
+        "Filter": "CBoFilter[31:23], CBoFilter[17:10]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "UMask": "0x43",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; NID and Opcode Matched",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
+        "Filter": "CBoFilter[31:23], CBoFilter[17:10]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "UMask": "0x41",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; NID Matched Writebacks",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_WB",
+        "Filter": "CBoFilter[17:10]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "UMask": "0x50",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Opcode Match",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
+        "Filter": "CBoFilter[31:23]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Writebacks",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.WB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Any",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Evictions",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.EVICTION",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Miss All",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_ALL",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
+        "UMask": "0xa",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Miss Opcode Match",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE",
+        "Filter": "CBoFilter[31:23]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID Matched",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_ALL",
+        "Filter": "CBoFilter[17:10]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
+        "UMask": "0x48",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID Matched Evictions",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_EVICTION",
+        "Filter": "CBoFilter[17:10]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
+        "UMask": "0x44",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID Matched",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_ALL",
+        "Filter": "CBoFilter[17:10]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
+        "UMask": "0x4a",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID and Opcode Matched Miss",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_OPCODE",
+        "Filter": "CBoFilter[31:23], CBoFilter[17:10]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
+        "UMask": "0x43",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID and Opcode Matched",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_OPCODE",
+        "Filter": "CBoFilter[31:23], CBoFilter[17:10]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
+        "UMask": "0x41",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Opcode Match",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.OPCODE",
+        "Filter": "CBoFilter[31:23]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; AD - Cachebo",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.AD_CACHE",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; AD - Corebo",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.AD_CORE",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; AK - Cachebo",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.AK_CACHE",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; AK - Corebo",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.AK_CORE",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
+        "UMask": "0x20",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; BL - Cacheno",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.BL_CACHE",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; BL - Corebo",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.BL_CORE",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
+        "UMask": "0x40",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; IV - Cachebo",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.IV_CACHE",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; Onto AK Ring",
+        "Counter": "0,1",
+        "EventCode": "0x3",
+        "EventName": "UNC_C_TxR_STARVED.AK",
+        "PerPkg": "1",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; Onto BL Ring",
+        "Counter": "0,1",
+        "EventCode": "0x3",
+        "EventName": "UNC_C_TxR_STARVED.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "QPI Address/Opcode Match; Address & Opcode Ma=
tch",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_ADDR_OPC_MATCH.FILT",
+        "Filter": "HA_AddrMatch0[31:6], HA_AddrMatch1[13:0], HA_OpcodeMatc=
h[5:0]",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Bypass; Not Taken",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_H_BYPASS_IMC.NOT_TAKEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when the HA was a=
ble to bypass was attempted.  This is a latency optimization for situations=
 when there is light loadings on the memory subsystem.  This can be filted =
by when the bypass was taken and when it was not.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Bypass; Taken",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_H_BYPASS_IMC.TAKEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when the HA was a=
ble to bypass was attempted.  This is a latency optimization for situations=
 when there is light loadings on the memory subsystem.  This can be filted =
by when the bypass was taken and when it was not.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "uclks",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_H_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of uclks in the HA.  This =
will be slightly different than the count in the Ubox because of enable/fre=
eze delays.  The HA is on the other side of the die from the fixed Ubox ucl=
k counter, so the drift could be somewhat larger than in units that are clo=
ser like the QPI Agent.",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Conflict Checks; Conflict Detected",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb",
+        "EventName": "UNC_H_CONFLICT_CYCLES.CONFLICT",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Conflict Checks; No Conflict",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb",
+        "EventName": "UNC_H_CONFLICT_CYCLES.NO_CONFLICT",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Direct2Core Messages Sent",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_H_DIRECT2CORE_COUNT",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Direct2Core messages sent",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles when Direct2Core was Disabled",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_H_DIRECT2CORE_CYCLES_DISABLED",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles in which Direct2Core was di=
sabled",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Number of Reads that had Direct2Core Overridd=
en",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_H_DIRECT2CORE_TXN_OVERRIDE",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Reads where Direct2Core overridden=
",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Lookups; Snoop Not Needed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc",
+        "EventName": "UNC_H_DIRECTORY_LOOKUP.NO_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that looke=
d up the directory.  Can be filtered by requests that had to snoop and thos=
e that did not have to.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Lookups; Snoop Needed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc",
+        "EventName": "UNC_H_DIRECTORY_LOOKUP.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that looke=
d up the directory.  Can be filtered by requests that had to snoop and thos=
e that did not have to.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Updates; Any Directory Update",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd",
+        "EventName": "UNC_H_DIRECTORY_UPDATE.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of directory updates that =
were required.  These result in writes to the memory controller.  This can =
be filtered by directory sets and directory clears.",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Updates; Directory Clear",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd",
+        "EventName": "UNC_H_DIRECTORY_UPDATE.CLEAR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of directory updates that =
were required.  These result in writes to the memory controller.  This can =
be filtered by directory sets and directory clears.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Updates; Directory Set",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd",
+        "EventName": "UNC_H_DIRECTORY_UPDATE.SET",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of directory updates that =
were required.  These result in writes to the memory controller.  This can =
be filtered by directory sets and directory clears.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles without QPI Ingress Credits; AD to QPI=
 Link 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.AD_QPI0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the HA does=
 not have credits to send messages to the QPI Agent.  This can be filtered =
by the different credit pools and the different links.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles without QPI Ingress Credits; AD to QPI=
 Link 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.AD_QPI1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the HA does=
 not have credits to send messages to the QPI Agent.  This can be filtered =
by the different credit pools and the different links.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles without QPI Ingress Credits; BL to QPI=
 Link 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.BL_QPI0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the HA does=
 not have credits to send messages to the QPI Agent.  This can be filtered =
by the different credit pools and the different links.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles without QPI Ingress Credits; BL to QPI=
 Link 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.BL_QPI1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the HA does=
 not have credits to send messages to the QPI Agent.  This can be filtered =
by the different credit pools and the different links.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Retry Events",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_H_IMC_RETRY",
+        "PerPkg": "1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Full Line Writes Issued; All Writes=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1a",
+        "EventName": "UNC_H_IMC_WRITES.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of full line writes =
issued from the HA into the memory controller.  This counts for all four ch=
annels.  It can be filtered by full/partial and ISOCH/non-ISOCH.",
+        "UMask": "0xf",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Full Line Writes Issued; Full Line =
Non-ISOCH",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1a",
+        "EventName": "UNC_H_IMC_WRITES.FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of full line writes =
issued from the HA into the memory controller.  This counts for all four ch=
annels.  It can be filtered by full/partial and ISOCH/non-ISOCH.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Full Line Writes Issued; ISOCH Full=
 Line",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1a",
+        "EventName": "UNC_H_IMC_WRITES.FULL_ISOCH",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of full line writes =
issued from the HA into the memory controller.  This counts for all four ch=
annels.  It can be filtered by full/partial and ISOCH/non-ISOCH.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Full Line Writes Issued; Partial No=
n-ISOCH",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1a",
+        "EventName": "UNC_H_IMC_WRITES.PARTIAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of full line writes =
issued from the HA into the memory controller.  This counts for all four ch=
annels.  It can be filtered by full/partial and ISOCH/non-ISOCH.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Full Line Writes Issued; ISOCH Part=
ial",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1a",
+        "EventName": "UNC_H_IMC_WRITES.PARTIAL_ISOCH",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of full line writes =
issued from the HA into the memory controller.  This counts for all four ch=
annels.  It can be filtered by full/partial and ISOCH/non-ISOCH.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.READS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of read requests mad=
e into the Home Agent. Reads include all read opcodes (including RFO).  Wri=
tes include all writes (streaming, evictions, HitM, etc).",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.WRITES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of read requests mad=
e into the Home Agent. Reads include all read opcodes (including RFO).  Wri=
tes include all writes (streaming, evictions, HitM, etc).",
+        "UMask": "0xc",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3e",
+        "EventName": "UNC_H_RING_AD_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3e",
+        "EventName": "UNC_H_RING_AD_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3e",
+        "EventName": "UNC_H_RING_AD_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3e",
+        "EventName": "UNC_H_RING_AD_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3f",
+        "EventName": "UNC_H_RING_AK_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3f",
+        "EventName": "UNC_H_RING_AK_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3f",
+        "EventName": "UNC_H_RING_AK_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3f",
+        "EventName": "UNC_H_RING_AK_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o 'regular' credits available for posting reads from the HA into the iMC.  =
In order to send reads into the memory controller, the HA must first acquir=
e a credit for the iMC's RPQ (read pending queue).  This queue is broken in=
to regular credits/buffers that are used by general reads, and 'special' re=
quests such as ISOCH reads.  This count only tracks the regular credits  Co=
mmon high banwidth workloads should be able to make use of all of the regul=
ar buffers, but it will be difficult (and uncommon) to make use of both the=
 regular and special buffers at the same time.  One can filter based on the=
 memory controller channel.  One or more channels can be tracked at a given=
 time.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o 'regular' credits available for posting reads from the HA into the iMC.  =
In order to send reads into the memory controller, the HA must first acquir=
e a credit for the iMC's RPQ (read pending queue).  This queue is broken in=
to regular credits/buffers that are used by general reads, and 'special' re=
quests such as ISOCH reads.  This count only tracks the regular credits  Co=
mmon high banwidth workloads should be able to make use of all of the regul=
ar buffers, but it will be difficult (and uncommon) to make use of both the=
 regular and special buffers at the same time.  One can filter based on the=
 memory controller channel.  One or more channels can be tracked at a given=
 time.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN2",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o 'regular' credits available for posting reads from the HA into the iMC.  =
In order to send reads into the memory controller, the HA must first acquir=
e a credit for the iMC's RPQ (read pending queue).  This queue is broken in=
to regular credits/buffers that are used by general reads, and 'special' re=
quests such as ISOCH reads.  This count only tracks the regular credits  Co=
mmon high banwidth workloads should be able to make use of all of the regul=
ar buffers, but it will be difficult (and uncommon) to make use of both the=
 regular and special buffers at the same time.  One can filter based on the=
 memory controller channel.  One or more channels can be tracked at a given=
 time.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN3",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o 'regular' credits available for posting reads from the HA into the iMC.  =
In order to send reads into the memory controller, the HA must first acquir=
e a credit for the iMC's RPQ (read pending queue).  This queue is broken in=
to regular credits/buffers that are used by general reads, and 'special' re=
quests such as ISOCH reads.  This count only tracks the regular credits  Co=
mmon high banwidth workloads should be able to make use of all of the regul=
ar buffers, but it will be difficult (and uncommon) to make use of both the=
 regular and special buffers at the same time.  One can filter based on the=
 memory controller channel.  One or more channels can be tracked at a given=
 time.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o 'special' credits available for posting reads from the HA into the iMC.  =
In order to send reads into the memory controller, the HA must first acquir=
e a credit for the iMC's RPQ (read pending queue).  This queue is broken in=
to regular credits/buffers that are used by general reads, and 'special' re=
quests such as ISOCH reads.  This count only tracks the 'special' credits. =
 This statistic is generally not interesting for general IA workloads, but =
may be of interest for understanding the characteristics of systems using I=
SOCH.  One can filter based on the memory controller channel.  One or more =
channels can be tracked at a given time.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o 'special' credits available for posting reads from the HA into the iMC.  =
In order to send reads into the memory controller, the HA must first acquir=
e a credit for the iMC's RPQ (read pending queue).  This queue is broken in=
to regular credits/buffers that are used by general reads, and 'special' re=
quests such as ISOCH reads.  This count only tracks the 'special' credits. =
 This statistic is generally not interesting for general IA workloads, but =
may be of interest for understanding the characteristics of systems using I=
SOCH.  One can filter based on the memory controller channel.  One or more =
channels can be tracked at a given time.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN2",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o 'special' credits available for posting reads from the HA into the iMC.  =
In order to send reads into the memory controller, the HA must first acquir=
e a credit for the iMC's RPQ (read pending queue).  This queue is broken in=
to regular credits/buffers that are used by general reads, and 'special' re=
quests such as ISOCH reads.  This count only tracks the 'special' credits. =
 This statistic is generally not interesting for general IA workloads, but =
may be of interest for understanding the characteristics of systems using I=
SOCH.  One can filter based on the memory controller channel.  One or more =
channels can be tracked at a given time.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN3",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o 'special' credits available for posting reads from the HA into the iMC.  =
In order to send reads into the memory controller, the HA must first acquir=
e a credit for the iMC's RPQ (read pending queue).  This queue is broken in=
to regular credits/buffers that are used by general reads, and 'special' re=
quests such as ISOCH reads.  This count only tracks the 'special' credits. =
 This statistic is generally not interesting for general IA workloads, but =
may be of interest for understanding the characteristics of systems using I=
SOCH.  One can filter based on the memory controller channel.  One or more =
channels can be tracked at a given time.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 0 to 7.  This event is usef=
ul for understanding how applications are using the memory that is spread a=
cross the different memory regions.  It is particularly useful for 'Monroe'=
 systems that use the TAD to enable individual channels to enter self-refre=
sh to save power.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 0 to 7.  This event is usef=
ul for understanding how applications are using the memory that is spread a=
cross the different memory regions.  It is particularly useful for 'Monroe'=
 systems that use the TAD to enable individual channels to enter self-refre=
sh to save power.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION2",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 0 to 7.  This event is usef=
ul for understanding how applications are using the memory that is spread a=
cross the different memory regions.  It is particularly useful for 'Monroe'=
 systems that use the TAD to enable individual channels to enter self-refre=
sh to save power.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION3",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 0 to 7.  This event is usef=
ul for understanding how applications are using the memory that is spread a=
cross the different memory regions.  It is particularly useful for 'Monroe'=
 systems that use the TAD to enable individual channels to enter self-refre=
sh to save power.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION4",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 0 to 7.  This event is usef=
ul for understanding how applications are using the memory that is spread a=
cross the different memory regions.  It is particularly useful for 'Monroe'=
 systems that use the TAD to enable individual channels to enter self-refre=
sh to save power.",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION5",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 0 to 7.  This event is usef=
ul for understanding how applications are using the memory that is spread a=
cross the different memory regions.  It is particularly useful for 'Monroe'=
 systems that use the TAD to enable individual channels to enter self-refre=
sh to save power.",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION6",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 0 to 7.  This event is usef=
ul for understanding how applications are using the memory that is spread a=
cross the different memory regions.  It is particularly useful for 'Monroe'=
 systems that use the TAD to enable individual channels to enter self-refre=
sh to save power.",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION7",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 0 to 7.  This event is usef=
ul for understanding how applications are using the memory that is spread a=
cross the different memory regions.  It is particularly useful for 'Monroe'=
 systems that use the TAD to enable individual channels to enter self-refre=
sh to save power.",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_H_TAD_REQUESTS_G1.REGION10",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 8 to 10.  This event is use=
ful for understanding how applications are using the memory that is spread =
across the different memory regions.  It is particularly useful for 'Monroe=
' systems that use the TAD to enable individual channels to enter self-refr=
esh to save power.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_H_TAD_REQUESTS_G1.REGION11",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 8 to 10.  This event is use=
ful for understanding how applications are using the memory that is spread =
across the different memory regions.  It is particularly useful for 'Monroe=
' systems that use the TAD to enable individual channels to enter self-refr=
esh to save power.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_H_TAD_REQUESTS_G1.REGION8",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 8 to 10.  This event is use=
ful for understanding how applications are using the memory that is spread =
across the different memory regions.  It is particularly useful for 'Monroe=
' systems that use the TAD to enable individual channels to enter self-refr=
esh to save power.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_H_TAD_REQUESTS_G1.REGION9",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 8 to 10.  This event is use=
ful for understanding how applications are using the memory that is spread =
across the different memory regions.  It is particularly useful for 'Monroe=
' systems that use the TAD to enable individual channels to enter self-refr=
esh to save power.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Allocations; All Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_H_TRACKER_INSERTS.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the lo=
cal HA tracker pool.  This can be used in conjunction with the occupancy ac=
cumulation event in order to calculate average latency.  One cannot filter =
between reads and writes.  HA trackers are allocated as soon as a request e=
nters the HA and is released after the snoop response and data return (or p=
ost in the case of a write) and the response is returned on the ring.",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Outbound NDR Ring Transactions; Non-data Resp=
onses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xf",
+        "EventName": "UNC_H_TxR_AD.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of outbound transactions o=
n the AD ring.  This can be filtered by the NDR and SNP message classes.  S=
ee the filter descriptions for more details.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Outbound NDR Ring Transactions; Snoops",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xf",
+        "EventName": "UNC_H_TxR_AD.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of outbound transactions o=
n the AD ring.  This can be filtered by the NDR and SNP message classes.  S=
ee the filter descriptions for more details.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Full; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2a",
+        "EventName": "UNC_H_TxR_AD_CYCLES_FULL.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Full",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Full; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2a",
+        "EventName": "UNC_H_TxR_AD_CYCLES_FULL.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Full",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Full; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2a",
+        "EventName": "UNC_H_TxR_AD_CYCLES_FULL.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Full",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Not Empty; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_H_TxR_AD_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Not Empty",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Not Empty; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_H_TxR_AD_CYCLES_NE.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Not Empty",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Not Empty; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_H_TxR_AD_CYCLES_NE.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Not Empty",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Allocations; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_H_TxR_AD_INSERTS.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Allocations",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Allocations; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_H_TxR_AD_INSERTS.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Allocations",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Allocations; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_H_TxR_AD_INSERTS.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Allocations",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Occupancy; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_H_TxR_AD_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Occupancy",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Occupancy; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_H_TxR_AD_OCCUPANCY.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Occupancy",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Occupancy; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_H_TxR_AD_OCCUPANCY.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Occupancy",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Full; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_H_TxR_AK_CYCLES_FULL.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Full",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Full; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_H_TxR_AK_CYCLES_FULL.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Full",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Full; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_H_TxR_AK_CYCLES_FULL.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Full",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Not Empty; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_H_TxR_AK_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Not Empty",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Not Empty; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_H_TxR_AK_CYCLES_NE.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Not Empty",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Not Empty; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_H_TxR_AK_CYCLES_NE.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Not Empty",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Allocations; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2f",
+        "EventName": "UNC_H_TxR_AK_INSERTS.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Allocations",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Allocations; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2f",
+        "EventName": "UNC_H_TxR_AK_INSERTS.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Allocations",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Allocations; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2f",
+        "EventName": "UNC_H_TxR_AK_INSERTS.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Allocations",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Outbound NDR Ring Transactions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xe",
+        "EventName": "UNC_H_TxR_AK_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of outbound NDR transactio=
ns sent on the AK ring.  NDR stands for 'non-data response' and is generall=
y used for completions that do not include data.  AK NDR is used for messag=
es to the local socket.",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Occupancy; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_H_TxR_AK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Occupancy",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Occupancy; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_H_TxR_AK_OCCUPANCY.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Occupancy",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Occupancy; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_H_TxR_AK_OCCUPANCY.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Occupancy",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to Cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_H_TxR_BL.DRS_CACHE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS messages sent out o=
n the BL ring.   This can be filtered by the destination.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to Core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_H_TxR_BL.DRS_CORE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS messages sent out o=
n the BL ring.   This can be filtered by the destination.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to QPI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_H_TxR_BL.DRS_QPI",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS messages sent out o=
n the BL ring.   This can be filtered by the destination.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Full; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TxR_BL_CYCLES_FULL.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Full",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Full; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TxR_BL_CYCLES_FULL.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Full",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Full; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TxR_BL_CYCLES_FULL.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Full",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Not Empty; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_H_TxR_BL_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Not Empty",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Not Empty; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_H_TxR_BL_CYCLES_NE.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Not Empty",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Not Empty; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_H_TxR_BL_CYCLES_NE.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Not Empty",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Allocations; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_H_TxR_BL_INSERTS.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Allocations",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Allocations; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_H_TxR_BL_INSERTS.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Allocations",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Allocations; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_H_TxR_BL_INSERTS.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Allocations",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Occupancy; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_H_TxR_BL_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Occupancy",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Occupancy; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_H_TxR_BL_OCCUPANCY.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Occupancy",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Occupancy; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_H_TxR_BL_OCCUPANCY.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Occupancy",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o 'regular' credits available for posting writes from the HA into the iMC. =
 In order to send writes into the memory controller, the HA must first acqu=
ire a credit for the iMC's WPQ (write pending queue).  This queue is broken=
 into regular credits/buffers that are used by general writes, and 'special=
' requests such as ISOCH writes.  This count only tracks the regular credit=
s  Common high banwidth workloads should be able to make use of all of the =
regular buffers, but it will be difficult (and uncommon) to make use of bot=
h the regular and special buffers at the same time.  One can filter based o=
n the memory controller channel.  One or more channels can be tracked at a =
given time.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o 'regular' credits available for posting writes from the HA into the iMC. =
 In order to send writes into the memory controller, the HA must first acqu=
ire a credit for the iMC's WPQ (write pending queue).  This queue is broken=
 into regular credits/buffers that are used by general writes, and 'special=
' requests such as ISOCH writes.  This count only tracks the regular credit=
s  Common high banwidth workloads should be able to make use of all of the =
regular buffers, but it will be difficult (and uncommon) to make use of bot=
h the regular and special buffers at the same time.  One can filter based o=
n the memory controller channel.  One or more channels can be tracked at a =
given time.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN2",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o 'regular' credits available for posting writes from the HA into the iMC. =
 In order to send writes into the memory controller, the HA must first acqu=
ire a credit for the iMC's WPQ (write pending queue).  This queue is broken=
 into regular credits/buffers that are used by general writes, and 'special=
' requests such as ISOCH writes.  This count only tracks the regular credit=
s  Common high banwidth workloads should be able to make use of all of the =
regular buffers, but it will be difficult (and uncommon) to make use of bot=
h the regular and special buffers at the same time.  One can filter based o=
n the memory controller channel.  One or more channels can be tracked at a =
given time.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN3",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o 'regular' credits available for posting writes from the HA into the iMC. =
 In order to send writes into the memory controller, the HA must first acqu=
ire a credit for the iMC's WPQ (write pending queue).  This queue is broken=
 into regular credits/buffers that are used by general writes, and 'special=
' requests such as ISOCH writes.  This count only tracks the regular credit=
s  Common high banwidth workloads should be able to make use of all of the =
regular buffers, but it will be difficult (and uncommon) to make use of bot=
h the regular and special buffers at the same time.  One can filter based o=
n the memory controller channel.  One or more channels can be tracked at a =
given time.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o 'special' credits available for posting writes from the HA into the iMC. =
 In order to send writes into the memory controller, the HA must first acqu=
ire a credit for the iMC's WPQ (write pending queue).  This queue is broken=
 into regular credits/buffers that are used by general writes, and 'special=
' requests such as ISOCH writes.  This count only tracks the 'special' cred=
its.  This statistic is generally not interesting for general IA workloads,=
 but may be of interest for understanding the characteristics of systems us=
ing ISOCH.  One can filter based on the memory controller channel.  One or =
more channels can be tracked at a given time.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o 'special' credits available for posting writes from the HA into the iMC. =
 In order to send writes into the memory controller, the HA must first acqu=
ire a credit for the iMC's WPQ (write pending queue).  This queue is broken=
 into regular credits/buffers that are used by general writes, and 'special=
' requests such as ISOCH writes.  This count only tracks the 'special' cred=
its.  This statistic is generally not interesting for general IA workloads,=
 but may be of interest for understanding the characteristics of systems us=
ing ISOCH.  One can filter based on the memory controller channel.  One or =
more channels can be tracked at a given time.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN2",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o 'special' credits available for posting writes from the HA into the iMC. =
 In order to send writes into the memory controller, the HA must first acqu=
ire a credit for the iMC's WPQ (write pending queue).  This queue is broken=
 into regular credits/buffers that are used by general writes, and 'special=
' requests such as ISOCH writes.  This count only tracks the 'special' cred=
its.  This statistic is generally not interesting for general IA workloads,=
 but may be of interest for understanding the characteristics of systems us=
ing ISOCH.  One can filter based on the memory controller channel.  One or =
more channels can be tracked at a given time.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN3",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o 'special' credits available for posting writes from the HA into the iMC. =
 In order to send writes into the memory controller, the HA must first acqu=
ire a credit for the iMC's WPQ (write pending queue).  This queue is broken=
 into regular credits/buffers that are used by general writes, and 'special=
' requests such as ISOCH writes.  This count only tracks the 'special' cred=
its.  This statistic is generally not interesting for general IA workloads,=
 but may be of interest for understanding the characteristics of systems us=
ing ISOCH.  One can filter based on the memory controller channel.  One or =
more channels can be tracked at a given time.",
+        "UMask": "0x8",
         "Unit": "HA"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
index 1b53c0e609e3..750870fd1cb1 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
@@ -1,48 +1,850 @@
 [
     {
-        "BriefDescription": "QPI clock ticks. Used to get percentages of Q=
PI cycles events",
+        "BriefDescription": "Number of qfclks",
         "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_Q_CLOCKTICKS",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of clocks in the QPI LL.  =
This clock runs at 1/8th the 'GT/s' speed of the QPI link.  For example, a =
8GT/s link will have qfclk or 1GHz.  JKT does not support dynamic link spee=
ds, so this frequency is fixed.",
         "Unit": "QPI LL"
     },
     {
-        "BriefDescription": "Cycles where receiving QPI link is in half-wi=
dth mode",
+        "BriefDescription": "Count of CTO Events",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_CTO_COUNT",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of CTO (cluster trigger ou=
ts) events that were asserted across the two slots.  If both slots trigger =
in a given cycle, the event will increment by 2.  You can use edge detect t=
o count the number of cases when both events triggered.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT N=
ot Set",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Success",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.SUCCESS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in L1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_Q_L1_POWER_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI qfclk cycles spent in L1 power=
 mode.  L1 is a mode that totally shuts down a QPI link.  Use edge detect t=
o count the number of instances when the QPI link entered L1.  Link power s=
tates are per link and per direction, so for example the Tx direction could=
 be in one state while Rx was in another. Because L1 totally shuts down the=
 link, it takes a good amount of time to exit this mode.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in L0p",
         "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_Q_RxL0P_POWER_CYCLES",
-        "MetricExpr": "(UNC_Q_RxL0P_POWER_CYCLES / UNC_Q_CLOCKTICKS) * 100=
.",
-        "MetricName": "rxl0p_power_cycles %",
         "PerPkg": "1",
+        "PublicDescription": "Number of QPI qfclk cycles spent in L0p powe=
r mode.  L0p is a mode where we disable 1/2 of the QPI lanes, decreasing ou=
r bandwidth in order to save power.  It increases snoop and data transfer l=
atencies and decreases overall bandwidth.  This mode can be very useful in =
NUMA optimized workloads that largely only utilize QPI for snoops and their=
 responses.  Use edge detect to count the number of instances when the QPI =
link entered L0p.  Link power states are per link and per direction, so for=
 example the Tx direction could be in one state while Rx was in another.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in L0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xf",
+        "EventName": "UNC_Q_RxL0_POWER_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI qfclk cycles spent in L0 power=
 mode in the Link Layer.  L0 is the default mode which provides the highest=
 performance with the most power.  Use edge detect to count the number of i=
nstances that the link entered L0.  Link power states are per link and per =
direction, so for example the Tx direction could be in one state while Rx w=
as in another.  The phy layer  sometimes leaves L0 for training, which will=
 not be captured by this event.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Bypassed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_Q_RxL_BYPASSED",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the flit buffer and pass directly across the BGF an=
d into the Egress.  This is a latency optimization, and should generally be=
 the common case.  If this value is less than the number of flits transfere=
d, it implies that there was queueing getting onto the ring, and thus the t=
ransactions saw higher latency.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "CRC Errors Detected; LinkInit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_CRC_ERRORS.LINK_INIT",
+        "PerPkg": "1",
+        "PublicDescription": "Number of CRC errors detected in the QPI Age=
nt.  Each QPI flit incorporates 8 bits of CRC for error detection.  This co=
unts the number of flits where the CRC was able to detect an error.  After =
an error has been detected, the QPI agent will send a request to the transm=
itting socket to resend the flit (as well as any flits that came after it).=
",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "CRC Errors Detected; Normal Operations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_CRC_ERRORS.NORMAL_OP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of CRC errors detected in the QPI Age=
nt.  Each QPI flit incorporates 8 bits of CRC for error detection.  This co=
unts the number of flits where the CRC was able to detect an error.  After =
an error has been detected, the QPI agent will send a request to the transm=
itting socket to resend the flit (as well as any flits that came after it).=
",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; DRS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; HOM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; NCB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; NCS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; NDR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NDR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
+        "UMask": "0x20",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; SNP",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VNA Credit Consumed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1d",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VNA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VNA c=
redit was consumed (i.e. message uses a VNA credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xa",
+        "EventName": "UNC_Q_RxL_CYCLES_NE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 0; Data Tx Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_RxL_FLITS_G0.DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ing a 64B cacheline across QPI, we will break it into 9 flits -- 1 with hea=
der information and 8 with 64 bits of actual 'data' and an additional 16 bi=
ts of other information.  To calculate 'data' bandwidth, one should therefo=
re do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 0; Idle and Null Flits=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_RxL_FLITS_G0.IDLE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ing a 64B cacheline across QPI, we will break it into 9 flits -- 1 with hea=
der information and 8 with 64 bits of actual 'data' and an additional 16 bi=
ts of other information.  To calculate 'data' bandwidth, one should therefo=
re do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 0; Non-Data protocol T=
x Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_RxL_FLITS_G0.NON_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ing a 64B cacheline across QPI, we will break it into 9 flits -- 1 with hea=
der information and 8 with 64 bits of actual 'data' and an additional 16 bi=
ts of other information.  To calculate 'data' bandwidth, one should therefo=
re do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; DRS Flits (both Hea=
der and Data)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "UMask": "0x18",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; DRS Data Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.DRS_DATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; DRS Header Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.DRS_NONDATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; HOM Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "UMask": "0x6",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; HOM Non-Request Fli=
ts",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.HOM_NONREQ",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; HOM Request Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.HOM_REQ",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; SNP Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Coherent Rx Fli=
ts",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "UMask": "0xc",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Coherent data R=
x Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NCB_DATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Coherent non-da=
ta Rx Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NCB_NONDATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Coherent standa=
rd Rx Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Data Response R=
x Flits - AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AD",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Data Response R=
x Flits - AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AK",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_Q_RxL_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - DRS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_Q_RxL_INSERTS_DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only DRS flits.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - HOM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc",
+        "EventName": "UNC_Q_RxL_INSERTS_HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only HOM flits.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NCB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xa",
+        "EventName": "UNC_Q_RxL_INSERTS_NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCB flits.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NCS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb",
+        "EventName": "UNC_Q_RxL_INSERTS_NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCS flits.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NDR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xe",
+        "EventName": "UNC_Q_RxL_INSERTS_NDR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NDR flits.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - SNP",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd",
+        "EventName": "UNC_Q_RxL_INSERTS_SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only SNP flits.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - All Packets",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb",
+        "EventName": "UNC_Q_RxL_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - DRS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors DRS flits only.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - HOM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors HOM flits only.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NCB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCB flits only.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NCS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCS flits only.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NDR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1a",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NDR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NDR flits only.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - SNP",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors SNP flits only.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - HOM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS.BGF_DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - DRS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS.BGF_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI.",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - SNP",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS.BGF_NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - NDR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS.BGF_NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - NCS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS.BGF_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI.",
+        "UMask": "0x20",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI; BGF Stall - NCB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS.BGF_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI.",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI; Egress Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS.EGRESS_CREDITS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI.",
+        "UMask": "0x40",
         "Unit": "QPI LL"
     },
     {
-        "BriefDescription": "Cycles where transmitting QPI link is in half=
-width mode",
+        "BriefDescription": "Stalls Sending to R3QPI; GV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS.GV",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI.",
+        "UMask": "0x80",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in L0p",
         "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_Q_TxL0P_POWER_CYCLES",
-        "MetricExpr": "(UNC_Q_TxL0P_POWER_CYCLES / UNC_Q_CLOCKTICKS) * 100=
.",
-        "MetricName": "txl0p_power_cycles %",
         "PerPkg": "1",
+        "PublicDescription": "Number of QPI qfclk cycles spent in L0p powe=
r mode.  L0p is a mode where we disable 1/2 of the QPI lanes, decreasing ou=
r bandwidth in order to save power.  It increases snoop and data transfer l=
atencies and decreases overall bandwidth.  This mode can be very useful in =
NUMA optimized workloads that largely only utilize QPI for snoops and their=
 responses.  Use edge detect to count the number of instances when the QPI =
link entered L0p.  Link power states are per link and per direction, so for=
 example the Tx direction could be in one state while Rx was in another.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in L0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc",
+        "EventName": "UNC_Q_TxL0_POWER_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI qfclk cycles spent in L0 power=
 mode in the Link Layer.  L0 is the default mode which provides the highest=
 performance with the most power.  Use edge detect to count the number of i=
nstances that the link entered L0.  Link power states are per link and per =
direction, so for example the Tx direction could be in one state while Rx w=
as in another.  The phy layer  sometimes leaves L0 for training, which will=
 not be captured by this event.",
         "Unit": "QPI LL"
     },
     {
-        "BriefDescription": "Number of data flits transmitted ",
+        "BriefDescription": "Tx Flit Buffer Bypassed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_Q_TxL_BYPASSED",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the Tx flit buffer and pass directly out the QPI Li=
nk. Generally, when data is transmitted across QPI, it will bypass the TxQ =
and pass directly to the link.  However, the TxQ will be used with L0p and =
when LLR occurs, increasing latency to transfer out to the link.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is al=
most full",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_TxL_CRC_NO_CREDITS.ALMOST_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles when the Tx side ran out of=
 Link Layer Retry credits, causing the Tx to stall.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is fu=
ll",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_TxL_CRC_NO_CREDITS.FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles when the Tx side ran out of=
 Link Layer Retry credits, causing the Tx to stall.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Cycles not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_Q_TxL_CYCLES_NE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the TxQ is =
not empty. Generally, when data is transmitted across QPI, it will bypass t=
he TxQ and pass directly to the link.  However, the TxQ will be used with L=
0p and when LLR occurs, increasing latency to transfer out to the link.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits",
         "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
         "PerPkg": "1",
-        "ScaleUnit": "8Bytes",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsfering a 64B cacheline across QPI, we will break it into 9 flits -- 1 wit=
h header information and 8 with 64 bits of actual 'data' and an additional =
16 bits of other information.  To calculate 'data' bandwidth, one should th=
erefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
     {
-        "BriefDescription": "Number of non data (control) flits transmitte=
d ",
+        "BriefDescription": "Flits Transferred - Group 0; Idle and Null Fl=
its",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G0.IDLE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsfering a 64B cacheline across QPI, we will break it into 9 flits -- 1 wit=
h header information and 8 with 64 bits of actual 'data' and an additional =
16 bits of other information.  To calculate 'data' bandwidth, one should th=
erefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 0; Non-Data protoco=
l Tx Flits",
         "Counter": "0,1,2,3",
         "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
-        "ScaleUnit": "8Bytes",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsfering a 64B cacheline across QPI, we will break it into 9 flits -- 1 wit=
h header information and 8 with 64 bits of actual 'data' and an additional =
16 bits of other information.  To calculate 'data' bandwidth, one should th=
erefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; DRS Flits (both =
Header and Data)",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "UMask": "0x18",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; DRS Header Flits=
",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "UMask": "0x6",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; HOM Non-Request =
Flits",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
         "UMask": "0x4",
         "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; HOM Request Flit=
s",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Coherent Byp=
ass Tx Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "UMask": "0xc",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Coherent dat=
a Tx Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NCB_DATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Coherent non=
-data Tx Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NCB_NONDATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Coherent sta=
ndard Tx Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Data Respons=
e Tx Flits - AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AD",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Data Respons=
e Tx Flits - AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AK",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_Q_TxL_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Tx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
TxQ and pass directly to the link.  However, the TxQ will be used with L0p =
and when LLR occurs, increasing latency to transfer out to the link.  This =
event can be used in conjunction with the Flit Buffer Occupancy event in or=
der to calculate the average flit buffer lifetime.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_Q_TxL_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of flits in the TxQ. =
 Generally, when data is transmitted across QPI, it will bypass the TxQ and=
 pass directly to the link.  However, the TxQ will be used with L0p and whe=
n LLR occurs, increasing latency to transfer out to the link. This can be u=
sed with the cycles not empty event to track average occupancy, or the allo=
cations event to track average lifetime in the TxQ.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VNA Credits Returned",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_Q_VNA_CREDIT_RETURNS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of VNA credits returned.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VNA Credits Pending Return - Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_Q_VNA_CREDIT_RETURN_OCCUPANCY",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of VNA credits in the Rx side that ar=
e waitng to be returned back across the link.",
+        "Unit": "QPI LL"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json b/t=
ools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
index 8551cebeba23..a165a77947a0 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
@@ -1,82 +1,493 @@
 [
     {
-        "BriefDescription": "Memory page activates",
+        "BriefDescription": "DRAM Activate Count",
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_M_ACT_COUNT",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRAM Activate commands =
sent on this channel.  Activate commands are issued to open up a page on th=
e DRAM devices so that it can be read or written to with a CAS.  One can ca=
lculate the number of Page Misses by subtracting the number of Page Miss pr=
echarges from the number of Activates.",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "read requests to memory controller. Derived f=
rom unc_m_cas_count.rd",
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM WR=
_CAS (w/ and w/out auto-pre)",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
-        "EventName": "LLC_MISSES.MEM_READ",
+        "EventName": "UNC_M_CAS_COUNT.ALL",
         "PerPkg": "1",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
+        "UMask": "0xf",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM Re=
ads (RD_CAS + Underfills)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.RD",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
         "UMask": "0x3",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "write requests to memory controller. Derived =
from unc_m_cas_count.wr",
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM RD=
_CAS (w/ and w/out auto-pre)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.RD_REG",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; Underfill R=
ead Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.RD_UNDERFILL",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM WR=
_CAS (both Modes)",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
-        "EventName": "LLC_MISSES.MEM_WRITE",
+        "EventName": "UNC_M_CAS_COUNT.WR",
         "PerPkg": "1",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
         "UMask": "0xc",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Memory controller clock ticks. Used to get pe=
rcentages of memory controller cycles events",
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; DRAM WR_CAS=
 (w/ and w/out auto-pre) in Read Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.WR_RMM",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; DRAM WR_CAS=
 (w/ and w/out auto-pre) in Write Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.WR_WMM",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "uclks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_M_CLOCKTICKS",
         "PerPkg": "1",
+        "PublicDescription": "Uncore Fixed Counter - uclks",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge All Commands",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_M_DRAM_PRE_ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that the precharg=
e all command was sent.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_M_DRAM_REFRESH.HIGH",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of refreshes issued.",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_M_DRAM_REFRESH.PANIC",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of refreshes issued.",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ECC Correctable Errors",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_M_ECC_CORRECTABLE_ERRORS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of ECC errors detected and=
 corrected by the iMC on this channel.  This counter is only useful with EC=
C DRAM devices.  This count will increment one time for each correction reg=
ardless of the number of bits corrected.  The iMC can correct up to 4 bit e=
rrors in independent channel mode and 8 bit erros in lockstep mode.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Cycles in a Major Mode; Isoch Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_M_MAJOR_MODES.ISOCH",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of cycles spent in a=
 major mode (selected by a filter) on the given channel.   Major modea are =
channel-wide, and not a per-rank (or dimm or bank) mode.",
+        "UMask": "0x8",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Cycles where DRAM ranks are in power down (CK=
E) mode",
+        "BriefDescription": "Cycles in a Major Mode; Partial Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_M_MAJOR_MODES.PARTIAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of cycles spent in a=
 major mode (selected by a filter) on the given channel.   Major modea are =
channel-wide, and not a per-rank (or dimm or bank) mode.",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Cycles in a Major Mode; Read Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_M_MAJOR_MODES.READ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of cycles spent in a=
 major mode (selected by a filter) on the given channel.   Major modea are =
channel-wide, and not a per-rank (or dimm or bank) mode.",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Cycles in a Major Mode; Write Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_M_MAJOR_MODES.WRITE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of cycles spent in a=
 major mode (selected by a filter) on the given channel.   Major modea are =
channel-wide, and not a per-rank (or dimm or bank) mode.",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Channel DLLOFF Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_M_POWER_CHANNEL_DLLOFF",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles when all the ranks in the c=
hannel are in CKE Slow (DLLOFF) mode.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Channel PPD Cycles",
         "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "UNC_M_POWER_CHANNEL_PPD",
-        "MetricExpr": "(UNC_M_POWER_CHANNEL_PPD / UNC_M_CLOCKTICKS) * 100.=
",
-        "MetricName": "power_channel_ppd %",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles when all the ranks in the c=
hannel are in PPD mode.  If IBT=3Doff is enabled, then this can be used to =
count those cycles.  If it is not enabled, then this can count the number o=
f cycles when that could have been taken advantage of.",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Cycles all ranks are in critical thermal thro=
ttle",
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent in CKE ON mode.  The =
filter allows you to select a rank to monitor.  If multiple ranks are in CK=
E ON mode at one time, the counter will ONLY increment by one rather than d=
oing accumulation.  Multiple counters will need to be used to track multipl=
e ranks simultaneously.  There is no distinction between the different CKE =
modes (APD, PPDS, PPDF).  This can be determined based on the system progra=
mming.  These events should commonly be used with Invert to get the number =
of cycles in power saving mode.  Edge Detect is also useful here.  Make sur=
e that you do NOT use Invert with Edge Detect (this just confuses the syste=
m and is not necessary).",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent in CKE ON mode.  The =
filter allows you to select a rank to monitor.  If multiple ranks are in CK=
E ON mode at one time, the counter will ONLY increment by one rather than d=
oing accumulation.  Multiple counters will need to be used to track multipl=
e ranks simultaneously.  There is no distinction between the different CKE =
modes (APD, PPDS, PPDF).  This can be determined based on the system progra=
mming.  These events should commonly be used with Invert to get the number =
of cycles in power saving mode.  Edge Detect is also useful here.  Make sur=
e that you do NOT use Invert with Edge Detect (this just confuses the syste=
m and is not necessary).",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK2",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent in CKE ON mode.  The =
filter allows you to select a rank to monitor.  If multiple ranks are in CK=
E ON mode at one time, the counter will ONLY increment by one rather than d=
oing accumulation.  Multiple counters will need to be used to track multipl=
e ranks simultaneously.  There is no distinction between the different CKE =
modes (APD, PPDS, PPDF).  This can be determined based on the system progra=
mming.  These events should commonly be used with Invert to get the number =
of cycles in power saving mode.  Edge Detect is also useful here.  Make sur=
e that you do NOT use Invert with Edge Detect (this just confuses the syste=
m and is not necessary).",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK3",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent in CKE ON mode.  The =
filter allows you to select a rank to monitor.  If multiple ranks are in CK=
E ON mode at one time, the counter will ONLY increment by one rather than d=
oing accumulation.  Multiple counters will need to be used to track multipl=
e ranks simultaneously.  There is no distinction between the different CKE =
modes (APD, PPDS, PPDF).  This can be determined based on the system progra=
mming.  These events should commonly be used with Invert to get the number =
of cycles in power saving mode.  Edge Detect is also useful here.  Make sur=
e that you do NOT use Invert with Edge Detect (this just confuses the syste=
m and is not necessary).",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK4",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent in CKE ON mode.  The =
filter allows you to select a rank to monitor.  If multiple ranks are in CK=
E ON mode at one time, the counter will ONLY increment by one rather than d=
oing accumulation.  Multiple counters will need to be used to track multipl=
e ranks simultaneously.  There is no distinction between the different CKE =
modes (APD, PPDS, PPDF).  This can be determined based on the system progra=
mming.  These events should commonly be used with Invert to get the number =
of cycles in power saving mode.  Edge Detect is also useful here.  Make sur=
e that you do NOT use Invert with Edge Detect (this just confuses the syste=
m and is not necessary).",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK5",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent in CKE ON mode.  The =
filter allows you to select a rank to monitor.  If multiple ranks are in CK=
E ON mode at one time, the counter will ONLY increment by one rather than d=
oing accumulation.  Multiple counters will need to be used to track multipl=
e ranks simultaneously.  There is no distinction between the different CKE =
modes (APD, PPDS, PPDF).  This can be determined based on the system progra=
mming.  These events should commonly be used with Invert to get the number =
of cycles in power saving mode.  Edge Detect is also useful here.  Make sur=
e that you do NOT use Invert with Edge Detect (this just confuses the syste=
m and is not necessary).",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK6",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent in CKE ON mode.  The =
filter allows you to select a rank to monitor.  If multiple ranks are in CK=
E ON mode at one time, the counter will ONLY increment by one rather than d=
oing accumulation.  Multiple counters will need to be used to track multipl=
e ranks simultaneously.  There is no distinction between the different CKE =
modes (APD, PPDS, PPDF).  This can be determined based on the system progra=
mming.  These events should commonly be used with Invert to get the number =
of cycles in power saving mode.  Edge Detect is also useful here.  Make sur=
e that you do NOT use Invert with Edge Detect (this just confuses the syste=
m and is not necessary).",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK7",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent in CKE ON mode.  The =
filter allows you to select a rank to monitor.  If multiple ranks are in CK=
E ON mode at one time, the counter will ONLY increment by one rather than d=
oing accumulation.  Multiple counters will need to be used to track multipl=
e ranks simultaneously.  There is no distinction between the different CKE =
modes (APD, PPDS, PPDF).  This can be determined based on the system progra=
mming.  These events should commonly be used with Invert to get the number =
of cycles in power saving mode.  Edge Detect is also useful here.  Make sur=
e that you do NOT use Invert with Edge Detect (this just confuses the syste=
m and is not necessary).",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Critical Throttle Cycles",
         "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES",
-        "MetricExpr": "(UNC_M_POWER_CRITICAL_THROTTLE_CYCLES / UNC_M_CLOCK=
TICKS) * 100.",
-        "MetricName": "power_critical_throttle_cycles %",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the iMC is =
in critical thermal throttling.  When this happens, all traffic is blocked.=
  This should be rare unless something bad is going on in the platform.  Th=
ere is no filtering by rank for this event.",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Cycles Memory is in self refresh power mode",
+        "BriefDescription": "Clock-Enabled Self-Refresh",
         "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_M_POWER_SELF_REFRESH",
-        "MetricExpr": "(UNC_M_POWER_SELF_REFRESH / UNC_M_CLOCKTICKS) * 100=
.",
-        "MetricName": "power_self_refresh %",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the iMC is =
in self-refresh and the iMC still has a clock.  This happens in some packag=
e C-states.  For example, the PCU may ask the iMC to enter self-refresh eve=
n though some of the cores are still processing.  One use of this is for Mo=
nroe technology.  Self-refresh is required during package C3 and C6, but th=
ere is no clock in the iMC at this time, so it is not possible to count the=
se cases.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles while the iMC is=
 being throttled by either thermal constraints or by the PCU throttling.  I=
t is not possible to distinguish between the two.  This can be filtered by =
rank.  If multiple ranks are selected and are being throttled at the same t=
ime, the counter will only increment by 1.",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles while the iMC is=
 being throttled by either thermal constraints or by the PCU throttling.  I=
t is not possible to distinguish between the two.  This can be filtered by =
rank.  If multiple ranks are selected and are being throttled at the same t=
ime, the counter will only increment by 1.",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK2",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles while the iMC is=
 being throttled by either thermal constraints or by the PCU throttling.  I=
t is not possible to distinguish between the two.  This can be filtered by =
rank.  If multiple ranks are selected and are being throttled at the same t=
ime, the counter will only increment by 1.",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK3",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles while the iMC is=
 being throttled by either thermal constraints or by the PCU throttling.  I=
t is not possible to distinguish between the two.  This can be filtered by =
rank.  If multiple ranks are selected and are being throttled at the same t=
ime, the counter will only increment by 1.",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK4",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles while the iMC is=
 being throttled by either thermal constraints or by the PCU throttling.  I=
t is not possible to distinguish between the two.  This can be filtered by =
rank.  If multiple ranks are selected and are being throttled at the same t=
ime, the counter will only increment by 1.",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK5",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles while the iMC is=
 being throttled by either thermal constraints or by the PCU throttling.  I=
t is not possible to distinguish between the two.  This can be filtered by =
rank.  If multiple ranks are selected and are being throttled at the same t=
ime, the counter will only increment by 1.",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK6",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles while the iMC is=
 being throttled by either thermal constraints or by the PCU throttling.  I=
t is not possible to distinguish between the two.  This can be filtered by =
rank.  If multiple ranks are selected and are being throttled at the same t=
ime, the counter will only increment by 1.",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK7",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles while the iMC is=
 being throttled by either thermal constraints or by the PCU throttling.  I=
t is not possible to distinguish between the two.  This can be filtered by =
rank.  If multiple ranks are selected and are being throttled at the same t=
ime, the counter will only increment by 1.",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Preemption Count; Read over Read Preempt=
ion",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_M_PREEMPTION.RD_PREEMPT_RD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times a read in the iMC=
 preempts another read or write.  Generally reads to an open page are issue=
d ahead of requests to closed pages.  This improves the page hit rate of th=
e system.  However, high priority requests can cause pages of active reques=
ts to be closed in order to get them out.  This will reduce the latency of =
the high-priority request at the expense of lower bandwidth and increased o=
verall average latency.",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Preemption Count; Read over Write Preemp=
tion",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_M_PREEMPTION.RD_PREEMPT_WR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times a read in the iMC=
 preempts another read or write.  Generally reads to an open page are issue=
d ahead of requests to closed pages.  This improves the page hit rate of th=
e system.  However, high priority requests can cause pages of active reques=
ts to be closed in order to get them out.  This will reduce the latency of =
the high-priority request at the expense of lower bandwidth and increased o=
verall average latency.",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands.; Precharge due to ti=
mer expiration",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_M_PRE_COUNT.PAGE_CLOSE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRAM Precharge commands=
 sent on this channel.",
+        "UMask": "0x2",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Memory page conflicts",
+        "BriefDescription": "DRAM Precharge commands.; Precharges due to p=
age miss",
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.PAGE_MISS",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRAM Precharge commands=
 sent on this channel.",
         "UMask": "0x1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Occupancy counter for memory read queue",
+        "BriefDescription": "Read Pending Queue Full Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_M_RPQ_CYCLES_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the Read Pe=
nding Queue is full.  When the RPQ is full, the HA will not be able to issu=
e any additional read requests into the iMC.  This count should be similar =
count in the HA which tracks the number of cycles that the HA has no RPQ cr=
edits, just somewhat smaller to account for the credit return overhead.  We=
 generally do not expect to see RPQ become full except for potentially duri=
ng Write Major Mode or while running with slow DRAM.  This event only track=
s non-ISOC queue entries.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_M_RPQ_CYCLES_NE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the Read Pe=
nding Queue is not empty.  This can then be used to calculate the average o=
ccupancy (in conjunction with the Read Pending Queue Occupancy count).  The=
 RPQ is used to schedule reads out to the memory controller and to track th=
e requests.  Requests allocate into the RPQ soon after they enter the memor=
y controller, and need credits for an entry in this buffer before being sen=
t from the HA to the iMC.  They deallocate after the CAS command has been i=
ssued to memory.  This filter is to be used in conjunction with the occupan=
cy filter so that one can correctly track the average occupancies for sched=
ulable entries and scheduled requests.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the Re=
ad Pending Queue.  This queue is used to schedule reads out to the memory c=
ontroller and to track the requests.  Requests allocate into the RPQ soon a=
fter they enter the memory controller, and need credits for an entry in thi=
s buffer before being sent from the HA to the iMC.  They deallocate after t=
he CAS command has been issued to memory.  This includes both ISOCH and non=
-ISOCH requests.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Occupancy",
         "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_M_RPQ_OCCUPANCY",
         "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancies of the Read Pend=
ing Queue each cycle.  This can then be used to calculate both the average =
occupancy (in conjunction with the number of cycles not empty) and the aver=
age latency (in conjunction with the number of allocations).  The RPQ is us=
ed to schedule reads out to the memory controller and to track the requests=
.  Requests allocate into the RPQ soon after they enter the memory controll=
er, and need credits for an entry in this buffer before being sent from the=
 HA to the iMC. They deallocate after the CAS command has been issued to me=
mory.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Full Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_CYCLES_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the Write P=
ending Queue is full.  When the WPQ is full, the HA will not be able to iss=
ue any additional read requests into the iMC.  This count should be similar=
 count in the HA which tracks the number of cycles that the HA has no WPQ c=
redits, just somewhat smaller to account for the credit return overhead.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_M_WPQ_CYCLES_NE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the Write P=
ending Queue is not empty.  This can then be used to calculate the average =
queue occupancy (in conjunction with the WPQ Occupancy Accumulation count).=
  The WPQ is used to schedule write out to the memory controller and to tra=
ck the writes.  Requests allocate into the WPQ soon after they enter the me=
mory controller, and need credits for an entry in this buffer before being =
sent from the HA to the iMC.  They deallocate after being issued to DRAM.  =
Write requests themselves are able to complete (from the perspective of the=
 rest of the system) as soon they have 'posted' to the iMC.  This is not to=
 be confused with actually performing the write to DRAM.  Therefore, the av=
erage latency for this queue is actually not useful for deconstruction inte=
rmediate write latencies.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_M_WPQ_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the Wr=
ite Pending Queue.  This can then be used to calculate the average queuing =
latency (in conjunction with the WPQ occupancy count).  The WPQ is used to =
schedule write out to the memory controller and to track the writes.  Reque=
sts allocate into the WPQ soon after they enter the memory controller, and =
need credits for an entry in this buffer before being sent from the HA to t=
he iMC.  They deallocate after being issued to DRAM.  Write requests themse=
lves are able to complete (from the perspective of the rest of the system) =
as soon they have 'posted' to the iMC.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x81",
+        "EventName": "UNC_M_WPQ_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancies of the Write Pen=
ding Queue each cycle.  This can then be used to calculate both the average=
 queue occupancy (in conjunction with the number of cycles not empty) and t=
he average latency (in conjunction with the number of allocations).  The WP=
Q is used to schedule write out to the memory controller and to track the w=
rites.  Requests allocate into the WPQ soon after they enter the memory con=
troller, and need credits for an entry in this buffer before being sent fro=
m the HA to the iMC.  They deallocate after being issued to DRAM.  Write re=
quests themselves are able to complete (from the perspective of the rest of=
 the system) as soon they have 'posted' to the iMC.  This is not to be conf=
used with actually performing the write to DRAM.  Therefore, the average la=
tency for this queue is actually not useful for deconstruction intermediate=
 write latencies.  So, we provide filtering based on if the request has pos=
ted or not.  By using the 'not posted' filter, we can track how long writes=
 spent in the iMC before completions were sent to the HA.  The 'posted' fil=
ter, on the other hand, provides information about how much queueing is act=
ually happenning in the iMC for writes before they are actually issued to m=
emory.  High average occupancies will generally coincide with high write ma=
jor mode counts.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_M_WPQ_READ_HIT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times a request hits in=
 the WPQ (write-pending queue).  The iMC allows writes and reads to pass up=
 other writes to different addresses.  Before a read or a write is issued, =
it will first CAM the WPQ to see if there is a write pending to that addres=
s.  When reads hit, they are able to directly pull their data from the WPQ =
instead of going to memory.  Writes that hit will overwrite the existing da=
ta.  Partial writes that hit will not need to do underfill reads and will s=
imply update their relevant sections.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_M_WPQ_WRITE_HIT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times a request hits in=
 the WPQ (write-pending queue).  The iMC allows writes and reads to pass up=
 other writes to different addresses.  Before a read or a write is issued, =
it will first CAM the WPQ to see if there is a write pending to that addres=
s.  When reads hit, they are able to directly pull their data from the WPQ =
instead of going to memory.  Writes that hit will overwrite the existing da=
ta.  Partial writes that hit will not need to do underfill reads and will s=
imply update their relevant sections.",
         "Unit": "iMC"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-other.json
new file mode 100644
index 000000000000..99fc673c59e9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json
@@ -0,0 +1,1551 @@
+[
+    {
+        "BriefDescription": "Address Match (Conflict) Count; Conflict Merg=
es",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_ADDRESS_MATCH.MERGE_COUNT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when an inbound w=
rite (from a device to memory or another device) had an address match with =
another request in the write cache.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Address Match (Conflict) Count; Conflict Stal=
ls",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_ADDRESS_MATCH.STALL_COUNT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when an inbound w=
rite (from a device to memory or another device) had an address match with =
another request in the write cache.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Write Ack Pending Occupancy; Any Source",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_CACHE_ACK_PENDING_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes that have a=
cquired ownership but have not yet returned their data to the uncore.  Thes=
e writes are generally queued up in the switch trying to get to the head of=
 their queues so that they can post their data.  The queue occuapancy incre=
ments when the ACK is received, and decrements when either the data is retu=
rned OR a tickle is received and ownership is released.  Note that a single=
 tickle can result in multiple decrements.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Write Ack Pending Occupancy; Select Source",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_CACHE_ACK_PENDING_OCCUPANCY.SOURCE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes that have a=
cquired ownership but have not yet returned their data to the uncore.  Thes=
e writes are generally queued up in the switch trying to get to the head of=
 their queues so that they can post their data.  The queue occuapancy incre=
ments when the ACK is received, and decrements when either the data is retu=
rned OR a tickle is received and ownership is released.  Note that a single=
 tickle can result in multiple decrements.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Write Ownership Occupancy; Any So=
urce",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_CACHE_OWN_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes (and write =
prefetches) that are outstanding in the uncore trying to acquire ownership =
in each cycle.  This can be used with the write transaction count to calcul=
ate the average write latency in the uncore.  The occupancy increments when=
 a write request is issued, and decrements when the data is returned.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Write Ownership Occupancy; Select=
 Source",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_CACHE_OWN_OCCUPANCY.SOURCE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes (and write =
prefetches) that are outstanding in the uncore trying to acquire ownership =
in each cycle.  This can be used with the write transaction count to calcul=
ate the average write latency in the uncore.  The occupancy increments when=
 a write request is issued, and decrements when the data is returned.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Read Occupancy; Any Source",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_CACHE_READ_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of reads that are out=
standing in the uncore in each cycle.  This can be used with the read trans=
action count to calculate the average read latency in the uncore.  The occu=
pancy increments when a read request is issued, and decrements when the dat=
a is returned.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Read Occupancy; Select Source",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_CACHE_READ_OCCUPANCY.SOURCE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of reads that are out=
standing in the uncore in each cycle.  This can be used with the read trans=
action count to calculate the average read latency in the uncore.  The occu=
pancy increments when a read request is issued, and decrements when the dat=
a is returned.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Total Write Cache Occupancy; Any Source",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of reads and writes t=
hat are outstanding in the uncore in each cycle.  This is effectively the s=
um of the READ_OCCUPANCY and WRITE_OCCUPANCY events.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Total Write Cache Occupancy; Select Source",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.SOURCE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of reads and writes t=
hat are outstanding in the uncore in each cycle.  This is effectively the s=
um of the READ_OCCUPANCY and WRITE_OCCUPANCY events.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Write Occupancy; Any Source",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_CACHE_WRITE_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes (and write =
prefetches)  that are outstanding in the uncore in each cycle.  This can be=
 used with the transaction count event to calculate the average latency in =
the uncore.  The occupancy increments when the ownership fetch/prefetch is =
issued, and decrements the data is returned to the uncore.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Write Occupancy; Select Source",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_CACHE_WRITE_OCCUPANCY.SOURCE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes (and write =
prefetches)  that are outstanding in the uncore in each cycle.  This can be=
 used with the transaction count event to calculate the average latency in =
the uncore.  The occupancy increments when the ownership fetch/prefetch is =
issued, and decrements the data is returned to the uncore.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Clocks in the IRP",
+        "Counter": "0,1",
+        "EventName": "UNC_I_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of clocks in the IRP.",
+        "Unit": "IRP"
+    },
+    {
+        "Counter": "0,1",
+        "EventCode": "0xB",
+        "EventName": "UNC_I_RxR_AK_CYCLES_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the AK Ingr=
ess is full.  This queue is where the IRP receives responses from R2PCIe (t=
he ring).",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "AK Ingress Occupancy",
+        "Counter": "0,1",
+        "EventCode": "0xA",
+        "EventName": "UNC_I_RxR_AK_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the AK=
 Ingress.  This queue is where the IRP receives responses from R2PCIe (the =
ring).",
+        "Unit": "IRP"
+    },
+    {
+        "Counter": "0,1",
+        "EventCode": "0xC",
+        "EventName": "UNC_I_RxR_AK_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the AK Ingress =
in each cycles.  This queue is where the IRP receives responses from R2PCIe=
 (the ring).",
+        "Unit": "IRP"
+    },
+    {
+        "Counter": "0,1",
+        "EventCode": "0x4",
+        "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL Ingress Occupancy - DRS",
+        "Counter": "0,1",
+        "EventCode": "0x1",
+        "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "Unit": "IRP"
+    },
+    {
+        "Counter": "0,1",
+        "EventCode": "0x7",
+        "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "Unit": "IRP"
+    },
+    {
+        "Counter": "0,1",
+        "EventCode": "0x5",
+        "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL Ingress Occupancy - NCB",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "Unit": "IRP"
+    },
+    {
+        "Counter": "0,1",
+        "EventCode": "0x8",
+        "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "Unit": "IRP"
+    },
+    {
+        "Counter": "0,1",
+        "EventCode": "0x6",
+        "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL Ingress Occupancy - NCS",
+        "Counter": "0,1",
+        "EventCode": "0x3",
+        "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "Unit": "IRP"
+    },
+    {
+        "Counter": "0,1",
+        "EventCode": "0x9",
+        "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Tickle Count; Ownership Lost",
+        "Counter": "0,1",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TICKLES.LOST_OWNERSHIP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of tickles that are receiv=
ed.  This is for both explicit (from Cbo) and implicit (internal conflict) =
tickles.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Tickle Count; Data Returned",
+        "Counter": "0,1",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TICKLES.TOP_OF_QUEUE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of tickles that are receiv=
ed.  This is for both explicit (from Cbo) and implicit (internal conflict) =
tickles.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Select Source",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_TRANSACTIONS.ORDERINGQ",
+        "Filter": "IRPFilter[4:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of 'Inbound' transactions =
from the IRP to the Uncore.  This can be filtered based on request type in =
addition to the source queue.  Note the special filtering equation.  We do =
OR-reduction on the request type.  If the SOURCE bit is set, then we also d=
o AND qualification based on the source portID.",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Read Prefetches",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_TRANSACTIONS.PD_PREFETCHES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of 'Inbound' transactions =
from the IRP to the Uncore.  This can be filtered based on request type in =
addition to the source queue.  Note the special filtering equation.  We do =
OR-reduction on the request type.  If the SOURCE bit is set, then we also d=
o AND qualification based on the source portID.",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Reads",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_TRANSACTIONS.READS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of 'Inbound' transactions =
from the IRP to the Uncore.  This can be filtered based on request type in =
addition to the source queue.  Note the special filtering equation.  We do =
OR-reduction on the request type.  If the SOURCE bit is set, then we also d=
o AND qualification based on the source portID.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Writes",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_TRANSACTIONS.WRITES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of 'Inbound' transactions =
from the IRP to the Uncore.  This can be filtered based on request type in =
addition to the source queue.  Note the special filtering equation.  We do =
OR-reduction on the request type.  If the SOURCE bit is set, then we also d=
o AND qualification based on the source portID.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "No AD Egress Credit Stalls",
+        "Counter": "0,1",
+        "EventCode": "0x18",
+        "EventName": "UNC_I_TxR_AD_STALL_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number times when it is not possi=
ble to issue a request to the R2PCIe because there are no AD Egress Credits=
 available.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "No BL Egress Credit Stalls",
+        "Counter": "0,1",
+        "EventCode": "0x19",
+        "EventName": "UNC_I_TxR_BL_STALL_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number times when it is not possi=
ble to issue data to the R2PCIe because there are no BL Egress Credits avai=
lable.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Read Requests",
+        "Counter": "0,1",
+        "EventCode": "0xE",
+        "EventName": "UNC_I_TxR_DATA_INSERTS_NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Read Requests",
+        "Counter": "0,1",
+        "EventCode": "0xF",
+        "EventName": "UNC_I_TxR_DATA_INSERTS_NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Request Queue Occupancy",
+        "Counter": "0,1",
+        "EventCode": "0xD",
+        "EventName": "UNC_I_TxR_REQUEST_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumultes the number of outstanding outboun=
d requests from the IRP to the switch (towards the devices).  This can be u=
sed in conjuection with the allocations event in order to calculate average=
 latency of outbound requests.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Write Ordering Stalls",
+        "Counter": "0,1",
+        "EventCode": "0x1A",
+        "EventName": "UNC_I_WRITE_ORDERING_STALL_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are p=
ending write ACK's in the switch but the switch->IRP pipeline is not utiliz=
ed.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Number of uclks in domain",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_R2_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of uclks in the R2PCIe ucl=
k domain.  This could be slightly different than the count in the Ubox beca=
use of enable/freeze delays.  However, because the R2PCIe is close to the U=
box, they generally should not diverge by more than a handful of cycles.",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credit Acquired; DRS",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credit Acquired; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credit Acquired; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Failed to Acquire a Credit; DRS",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R2_IIO_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request pe=
nding in the BL Ingress attempted to acquire either a NCB or NCS credit to =
transmit into the IIO, but was rejected because no credits were available. =
 NCB, or non-coherent bypass messages are used to transmit data without coh=
erency (and are common).  NCS is used for reads to PCIe (and should be used=
 sparingly).",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Failed to Acquire a Credit; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R2_IIO_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request pe=
nding in the BL Ingress attempted to acquire either a NCB or NCS credit to =
transmit into the IIO, but was rejected because no credits were available. =
 NCB, or non-coherent bypass messages are used to transmit data without coh=
erency (and are common).  NCS is used for reads to PCIe (and should be used=
 sparingly).",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Failed to Acquire a Credit; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R2_IIO_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request pe=
nding in the BL Ingress attempted to acquire either a NCB or NCS credit to =
transmit into the IIO, but was rejected because no credits were available. =
 NCB, or non-coherent bypass messages are used to transmit data without coh=
erency (and are common).  NCS is used for reads to PCIe (and should be used=
 sparingly).",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credits in Use; DRS",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_R2_IIO_CREDITS_USED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credits in Use; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_R2_IIO_CREDITS_USED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credits in Use; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_R2_IIO_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Any",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xa",
+        "EventName": "UNC_R2_RING_IV_USED.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.",
+        "UMask": "0xf",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "AK Ingress Bounced",
+        "EventCode": "0x12",
+        "EventName": "UNC_R2_RxR_AK_BOUNCES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a request de=
stined for the AK ingress bounced.",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; DRS",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R2_RxR_CYCLES_NE.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Ingress is not empty.  This tracks one of the three rings that are used by =
the R2PCIe agent.  This can be used in conjunction with the R2PCIe Ingress =
Occupancy Accumulator event in order to calculate average queue occupancy. =
 Multiple ingress buffers can be tracked at a given time using multiple cou=
nters.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R2_RxR_CYCLES_NE.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Ingress is not empty.  This tracks one of the three rings that are used by =
the R2PCIe agent.  This can be used in conjunction with the R2PCIe Ingress =
Occupancy Accumulator event in order to calculate average queue occupancy. =
 Multiple ingress buffers can be tracked at a given time using multiple cou=
nters.",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R2_RxR_CYCLES_NE.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Ingress is not empty.  This tracks one of the three rings that are used by =
the R2PCIe agent.  This can be used in conjunction with the R2PCIe Ingress =
Occupancy Accumulator event in order to calculate average queue occupancy. =
 Multiple ingress buffers can be tracked at a given time using multiple cou=
nters.",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; AD",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; AK",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.AK",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; BL",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Not Empty; AD",
+        "EventCode": "0x23",
+        "EventName": "UNC_R2_TxR_CYCLES_NE.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Not Empty; AK",
+        "EventCode": "0x23",
+        "EventName": "UNC_R2_TxR_CYCLES_NE.AK",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Not Empty; BL",
+        "EventCode": "0x23",
+        "EventName": "UNC_R2_TxR_CYCLES_NE.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress NACK; AD",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACKS.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that the Egress r=
eceived a NACK from the ring and could not issue a transaction.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress NACK; AK",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACKS.AK",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that the Egress r=
eceived a NACK from the ring and could not issue a transaction.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress NACK; BL",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACKS.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that the Egress r=
eceived a NACK from the ring and could not issue a transaction.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Number of uclks in domain",
+        "Counter": "0,1,2",
+        "EventCode": "0x1",
+        "EventName": "UNC_R3_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of uclks in the QPI uclk d=
omain.  This could be slightly different than the count in the Ubox because=
 of enable/freeze delays.  However, because the QPI Agent is close to the U=
box, they generally should not diverge by more than a handful of cycles.",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit Acquired",
+        "Counter": "0,1",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquried in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transfering data wi=
thout coherency, and DRS is used for transfering data with coherency (cacha=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit Acquired",
+        "Counter": "0,1",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquried in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transfering data wi=
thout coherency, and DRS is used for transfering data with coherency (cacha=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit Acquired",
+        "Counter": "0,1",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquried in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transfering data wi=
thout coherency, and DRS is used for transfering data with coherency (cacha=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit Rejected",
+        "Counter": "0,1",
+        "EventCode": "0x21",
+        "EventName": "UNC_R3_IIO_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transfering data witho=
ut coherency, and DRS is used for transfering data with coherency (cachable=
 PCI transactions).  This event can only track one message class at a time.=
",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit Rejected",
+        "Counter": "0,1",
+        "EventCode": "0x21",
+        "EventName": "UNC_R3_IIO_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transfering data witho=
ut coherency, and DRS is used for transfering data with coherency (cachable=
 PCI transactions).  This event can only track one message class at a time.=
",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit Rejected",
+        "Counter": "0,1",
+        "EventCode": "0x21",
+        "EventName": "UNC_R3_IIO_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transfering data witho=
ut coherency, and DRS is used for transfering data with coherency (cachable=
 PCI transactions).  This event can only track one message class at a time.=
",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit In Use",
+        "Counter": "0,1",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_IIO_CREDITS_USED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transfering dat=
a without coherency, and DRS is used for transfering data with coherency (c=
achable PCI transactions).  This event can only track one message class at =
a time.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit In Use",
+        "Counter": "0,1",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_IIO_CREDITS_USED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transfering dat=
a without coherency, and DRS is used for transfering data with coherency (c=
achable PCI transactions).  This event can only track one message class at =
a time.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "to IIO BL Credit In Use",
+        "Counter": "0,1",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_IIO_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transfering dat=
a without coherency, and DRS is used for transfering data with coherency (c=
achable PCI transactions).  This event can only track one message class at =
a time.",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 IV Ring in Use; Any",
+        "Counter": "0,1,2",
+        "EventCode": "0xa",
+        "EventName": "UNC_R3_RING_IV_USED.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.",
+        "UMask": "0xf",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Bypassed",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_R3_RxR_BYPASSED.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when the Ingress =
was bypassed and an incoming transaction was bypassed directly across the B=
GF and into the qfclk domain.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; DRS",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; HOM",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NDR",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; SNP",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; DRS",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; HOM",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NDR",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; SNP",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; DRS",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; HOM",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; NCB",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; NCS",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; NDR",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; SNP",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; DRS Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; HOM Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCB Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCS Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NDR Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; SNP Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; DRS Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; HOM Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; NCB Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; NCS Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; NDR Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; SNP Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA credit Acquisitions",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credts from the VN0 pool.  N=
ote that a single packet may require multiple flit buffers (i.e. when data =
is being transfered).  Therefore, this event will increment by the number o=
f credits acquired in each cycle.  Filtering based on message class is not =
provided.  One can count the number of packets transfered in a given messag=
e class using an qfclk event.",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; DRS Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; HOM Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; NCB Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; NCS Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; NDR Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; SNP Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Cycles with no VNA credits available",
+        "Counter": "0,1",
+        "EventCode": "0x31",
+        "EventName": "UNC_R3_VNA_CREDIT_CYCLES_OUT",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI uclk cycles when the transmitt=
ed has no VNA credits available and therefore cannot send any requests on t=
his channel.  Note that this does not mean that no flits can be transmitted=
, as those holding VN0 credits will still (potentially) be able to transmit=
.  Generally it is the goal of the uncore that VNA credits should not run o=
ut, as this can substantially throttle back useful QPI bandwidth.",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Cycles with 1 or more VNA credits in use",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_R3_VNA_CREDIT_CYCLES_USED",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI uclk cycles with one or more V=
NA credits in use.  This event can be used in conjunction with the VNA In-U=
se Accumulator to calculate the average number of used VNA credits.",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VLW Received",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.DOORBELL_RCVD",
+        "PerPkg": "1",
+        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
+        "UMask": "0x8",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "VLW Received",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.INT_PRIO",
+        "PerPkg": "1",
+        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
+        "UMask": "0x10",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "VLW Received",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.IPI_RCVD",
+        "PerPkg": "1",
+        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
+        "UMask": "0x4",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "VLW Received",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.MSI_RCVD",
+        "PerPkg": "1",
+        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "VLW Received",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.VLW_RCVD",
+        "PerPkg": "1",
+        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Filter Match",
+        "Counter": "0,1",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.DISABLE",
+        "PerPkg": "1",
+        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Filter Match",
+        "Counter": "0,1",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.ENABLE",
+        "Filter": "UBoxFilter[3:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Filter Match",
+        "Counter": "0,1",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.U2C_DISABLE",
+        "PerPkg": "1",
+        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
+        "UMask": "0x8",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Filter Match",
+        "Counter": "0,1",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.U2C_ENABLE",
+        "Filter": "UBoxFilter[3:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
+        "UMask": "0x4",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "IDI Lock/SplitLock Cycles",
+        "Counter": "0,1",
+        "EventCode": "0x44",
+        "EventName": "UNC_U_LOCK_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times an IDI Lock/SplitLock sequen=
ce was started",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "MsgCh Requests by Size; 4B Requests",
+        "Counter": "0,1",
+        "EventCode": "0x47",
+        "EventName": "UNC_U_MSG_CHNL_SIZE_COUNT.4B",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of transactions on the message channe=
l filtered by request size.  This includes both reads and writes.",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "MsgCh Requests by Size; 8B Requests",
+        "Counter": "0,1",
+        "EventCode": "0x47",
+        "EventName": "UNC_U_MSG_CHNL_SIZE_COUNT.8B",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of transactions on the message channe=
l filtered by request size.  This includes both reads and writes.",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Cycles PHOLD Assert to Ack; ACK to Deassert",
+        "Counter": "0,1",
+        "EventCode": "0x45",
+        "EventName": "UNC_U_PHOLD_CYCLES.ACK_TO_DEASSERT",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "PHOLD cycles.  Filter from source CoreID.",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Cycles PHOLD Assert to Ack; Assert to ACK",
+        "Counter": "0,1",
+        "EventCode": "0x45",
+        "EventName": "UNC_U_PHOLD_CYCLES.ASSERT_TO_ACK",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "PHOLD cycles.  Filter from source CoreID.",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "RACU Request",
+        "Counter": "0,1",
+        "EventCode": "0x46",
+        "EventName": "UNC_U_RACU_REQUESTS.COUNT",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Correctable Machine Check=
",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.CMC",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x10",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Livelock",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.LIVELOCK",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x4",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; LTError",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.LTERROR",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x8",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Monitor T0",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T0",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Monitor T1",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T1",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Other",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.OTHER",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x80",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Trap",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.TRAP",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x40",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Uncorrectable Machine Che=
ck",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.UMC",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x20",
+        "Unit": "UBOX"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-power.json
index 8755693d86c6..04228344cb9c 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
@@ -1,272 +1,372 @@
 [
     {
-        "BriefDescription": "PCU clock ticks. Use to get percentages of PC=
U cycles events",
+        "BriefDescription": "pclk Cycles",
         "Counter": "0,1,2,3",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
+        "PublicDescription": "The PCU runs off a fixed 800 MHz clock.  Thi=
s event counts the number of pclk cycles measured while the counter was ena=
bled.  The pclk, like the Memory Controller's dclk, counts at a constant ra=
te making it a good measure of actual wall time.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore w=
as running at a frequency greater than or equal to the frequency that is co=
nfigured in the filter.  (filter_band0=3DXXX with XXX in 100Mhz units). One=
 can also use inversion (filter_inv=3D1) to track cycles when we were less =
than the configured frequency",
+        "BriefDescription": "Core C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xb",
-        "EventName": "UNC_P_FREQ_BAND0_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_BAND0_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_band0_cycles %",
+        "EventCode": "0x3",
+        "EventName": "UNC_P_CORE0_TRANSITION_CYCLES",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore w=
as running at a frequency greater than or equal to the frequency that is co=
nfigured in the filter.  (filter_band1=3DXXX with XXX in 100Mhz units). One=
 can also use inversion (filter_inv=3D1) to track cycles when we were less =
than the configured frequency",
+        "BriefDescription": "Core C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xc",
-        "EventName": "UNC_P_FREQ_BAND1_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_BAND1_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_band1_cycles %",
+        "EventCode": "0x4",
+        "EventName": "UNC_P_CORE1_TRANSITION_CYCLES",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore w=
as running at a frequency greater than or equal to the frequency that is co=
nfigured in the filter.  (filter_band2=3DXXX with XXX in 100Mhz units). One=
 can also use inversion (filter_inv=3D1) to track cycles when we were less =
than the configured frequency",
+        "BriefDescription": "Core C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xd",
-        "EventName": "UNC_P_FREQ_BAND2_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_BAND2_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_band2_cycles %",
+        "EventCode": "0x5",
+        "EventName": "UNC_P_CORE2_TRANSITION_CYCLES",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore w=
as running at a frequency greater than or equal to the frequency that is co=
nfigured in the filter.  (filter_band3=3DXXX, with XXX in 100Mhz units). On=
e can also use inversion (filter_inv=3D1) to track cycles when we were less=
 than the configured frequency",
+        "BriefDescription": "Core C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xe",
-        "EventName": "UNC_P_FREQ_BAND3_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_BAND3_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_band3_cycles %",
+        "EventCode": "0x6",
+        "EventName": "UNC_P_CORE3_TRANSITION_CYCLES",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of times that the uncore tr=
ansitioned a frequency greater than or equal to the frequency that is confi=
gured in the filter.  (filter_band0=3DXXX with XXX in 100Mhz units). One ca=
n also use inversion (filter_inv=3D1) to track cycles when we were less tha=
n the configured frequency. Derived from unc_p_freq_band0_cycles",
+        "BriefDescription": "Core C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xb",
-        "EventName": "UNC_P_FREQ_BAND0_TRANSITIONS",
-        "Filter": "edge=3D1",
-        "MetricExpr": "(UNC_P_FREQ_BAND0_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_band0_cycles %",
+        "EventCode": "0x7",
+        "EventName": "UNC_P_CORE4_TRANSITION_CYCLES",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of times that the uncore tr=
ansistioned to a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  (filter_band1=3DXXX with XXX in 100Mhz units). On=
e can also use inversion (filter_inv=3D1) to track cycles when we were less=
 than the configured frequency. Derived from unc_p_freq_band1_cycles",
+        "BriefDescription": "Core C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xc",
-        "EventName": "UNC_P_FREQ_BAND1_TRANSITIONS",
-        "Filter": "edge=3D1",
-        "MetricExpr": "(UNC_P_FREQ_BAND1_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_band1_cycles %",
+        "EventCode": "0x8",
+        "EventName": "UNC_P_CORE5_TRANSITION_CYCLES",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore t=
ransitioned to a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  (filter_band2=3DXXX with XXX in 100Mhz units). On=
e can also use inversion (filter_inv=3D1) to track cycles when we were less=
 than the configured frequency. Derived from unc_p_freq_band2_cycles",
+        "BriefDescription": "Core C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xd",
-        "EventName": "UNC_P_FREQ_BAND2_TRANSITIONS",
-        "Filter": "edge=3D1",
-        "MetricExpr": "(UNC_P_FREQ_BAND2_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_band2_cycles %",
+        "EventCode": "0x9",
+        "EventName": "UNC_P_CORE6_TRANSITION_CYCLES",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore t=
ransitioned to a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  (filter_band3=3DXXX, with XXX in 100Mhz units). O=
ne can also use inversion (filter_inv=3D1) to track cycles when we were les=
s than the configured frequency. Derived from unc_p_freq_band3_cycles",
+        "BriefDescription": "Core C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xe",
-        "EventName": "UNC_P_FREQ_BAND3_TRANSITIONS",
-        "Filter": "edge=3D1",
-        "MetricExpr": "(UNC_P_FREQ_BAND3_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_band3_cycles %",
+        "EventCode": "0xa",
+        "EventName": "UNC_P_CORE7_TRANSITION_CYCLES",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "This is an occupancy event that tracks the nu=
mber of cores that are in C0.  It can be used by itself to get the average =
number of cores in C0, with threshholding to generate histograms, or with o=
ther PCU events and occupancy triggering to capture other details",
+        "BriefDescription": "Core C State Demotions",
         "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
-        "Filter": "occ_sel=3D1",
-        "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C0 / UNC_P_CLOCK=
TICKS) * 100.",
-        "MetricName": "power_state_occupancy.cores_c0 %",
+        "EventCode": "0x1e",
+        "EventName": "UNC_P_DEMOTIONS_CORE0",
+        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "This is an occupancy event that tracks the nu=
mber of cores that are in C3.  It can be used by itself to get the average =
number of cores in C0, with threshholding to generate histograms, or with o=
ther PCU events and occupancy triggering to capture other details",
+        "BriefDescription": "Core C State Demotions",
         "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
-        "Filter": "occ_sel=3D2",
-        "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C3 / UNC_P_CLOCK=
TICKS) * 100.",
-        "MetricName": "power_state_occupancy.cores_c3 %",
+        "EventCode": "0x1f",
+        "EventName": "UNC_P_DEMOTIONS_CORE1",
+        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "This is an occupancy event that tracks the nu=
mber of cores that are in C6.  It can be used by itself to get the average =
number of cores in C0, with threshholding to generate histograms, or with o=
ther PCU events ",
+        "BriefDescription": "Core C State Demotions",
         "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
-        "Filter": "occ_sel=3D3",
-        "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C6 / UNC_P_CLOCK=
TICKS) * 100.",
-        "MetricName": "power_state_occupancy.cores_c6 %",
+        "EventCode": "0x20",
+        "EventName": "UNC_P_DEMOTIONS_CORE2",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that we are in ex=
ternal PROCHOT mode.  This mode is triggered when a sensor off the die dete=
rmines that something off-die (like DRAM) is too hot and must throttle to a=
void damaging the chip",
+        "BriefDescription": "Core C State Demotions",
         "Counter": "0,1,2,3",
-        "EventCode": "0xa",
-        "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
-        "MetricExpr": "(UNC_P_PROCHOT_EXTERNAL_CYCLES / UNC_P_CLOCKTICKS) =
* 100.",
-        "MetricName": "prochot_external_cycles %",
+        "EventCode": "0x21",
+        "EventName": "UNC_P_DEMOTIONS_CORE3",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_P_DEMOTIONS_CORE4",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_P_DEMOTIONS_CORE5",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_P_DEMOTIONS_CORE6",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_P_DEMOTIONS_CORE7",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Frequency Residency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb",
+        "EventName": "UNC_P_FREQ_BAND0_CYCLES",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the uncore =
was running at a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  One can use all four counters with this event, so=
 it is possible to track up to 4 configurable bands.  One can use edge dete=
ct in conjunction with this event to track the number of times that we tran=
sitioned into a frequency greater than or equal to the configurable frequen=
cy. One can also use inversion to track cycles when we were less than the c=
onfigured frequency.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Frequency Residency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc",
+        "EventName": "UNC_P_FREQ_BAND1_CYCLES",
+        "Filter": "PCUFilter[15:8]",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the uncore =
was running at a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  One can use all four counters with this event, so=
 it is possible to track up to 4 configurable bands.  One can use edge dete=
ct in conjunction with this event to track the number of times that we tran=
sitioned into a frequency greater than or equal to the configurable frequen=
cy. One can also use inversion to track cycles when we were less than the c=
onfigured frequency.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles when temperature =
is the upper limit on frequency",
+        "BriefDescription": "Frequency Residency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd",
+        "EventName": "UNC_P_FREQ_BAND2_CYCLES",
+        "Filter": "PCUFilter[23:16]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the uncore =
was running at a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  One can use all four counters with this event, so=
 it is possible to track up to 4 configurable bands.  One can use edge dete=
ct in conjunction with this event to track the number of times that we tran=
sitioned into a frequency greater than or equal to the configurable frequen=
cy. One can also use inversion to track cycles when we were less than the c=
onfigured frequency.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Frequency Residency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xe",
+        "EventName": "UNC_P_FREQ_BAND3_CYCLES",
+        "Filter": "PCUFilter[31:24]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the uncore =
was running at a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  One can use all four counters with this event, so=
 it is possible to track up to 4 configurable bands.  One can use edge dete=
ct in conjunction with this event to track the number of times that we tran=
sitioned into a frequency greater than or equal to the configurable frequen=
cy. One can also use inversion to track cycles when we were less than the c=
onfigured frequency.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Current Strongest Upper Limit Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_P_FREQ_MAX_CURRENT_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when current is =
the upper limit on frequency.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Thermal Strongest Upper Limit Cycles",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES / UNC_P_CLOCKT=
ICKS) * 100.",
-        "MetricName": "freq_max_limit_thermal_cycles %",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when thermal con=
ditions are the upper limit on frequency.  This is related to the THERMAL_T=
HROTTLE CYCLES_ABOVE_TEMP event, which always counts cycles when we are abo=
ve the thermal temperature.  This event (STRONGEST_UPPER_LIMIT) is sampled =
at the output of the algorithm that determines the actual frequency, while =
THERMAL_THROTTLE looks at the input.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles when the OS is th=
e upper limit on frequency",
+        "BriefDescription": "OS Strongest Upper Limit Cycles",
         "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_P_FREQ_MAX_OS_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_MAX_OS_CYCLES / UNC_P_CLOCKTICKS) * 100=
.",
-        "MetricName": "freq_max_os_cycles %",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the OS is t=
he upper limit on frequency.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles when power is the=
 upper limit on frequency",
+        "BriefDescription": "Power Strongest Upper Limit Cycles",
         "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_MAX_POWER_CYCLES / UNC_P_CLOCKTICKS) * =
100.",
-        "MetricName": "freq_max_power_cycles %",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when power is th=
e upper limit on frequency.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles when current is t=
he upper limit on frequency",
+        "BriefDescription": "IO P Limit Strongest Lower Limit Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0x7",
-        "EventName": "UNC_P_FREQ_MAX_CURRENT_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_MAX_CURRENT_CYCLES / UNC_P_CLOCKTICKS) =
* 100.",
-        "MetricName": "freq_max_current_cycles %",
+        "EventCode": "0x1",
+        "EventName": "UNC_P_FREQ_MIN_IO_P_CYCLES",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when IO P Limit =
is preventing us from dropping the frequency lower.  This algorithm monitor=
s the needs to the IO subsystem on both local and remote sockets and will m=
aintain a frequency high enough to maintain good IO BW.  This is necessary =
for when all the IA cores on a socket are idle but a user still would like =
to maintain high IO Bandwidth.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Perf P Limit Strongest Lower Limit Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_P_FREQ_MIN_PERF_P_CYCLES",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when Perf P Limi=
t is preventing us from dropping the frequency lower.  Perf P Limit is an a=
lgorithm that takes input from remote sockets when determining if a socket =
should drop it's frequency down.  This is largely to minimize increases in =
snoop and remote read latencies.",
         "Unit": "PCU"
     },
     {
         "BriefDescription": "Cycles spent changing Frequency",
         "Counter": "0,1,2,3",
         "EventName": "UNC_P_FREQ_TRANS_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_TRANS_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_trans_cycles %",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the system =
is changing frequency.  This can not be filtered by thread ID.  One can als=
o use it with the occupancy counter that monitors number of threads in C0 t=
o estimate the performance impact that frequency transitions had on the sys=
tem.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore w=
as running at a frequency greater than or equal to 1.2Ghz. Derived from unc=
_p_freq_band0_cycles",
+        "BriefDescription": "Memory Phase Shedding Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xb",
-        "EventName": "UNC_P_FREQ_GE_1200MHZ_CYCLES",
-        "Filter": "filter_band0=3D12",
-        "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
-        "MetricName": "freq_ge_1200mhz_cycles %",
+        "EventCode": "0x2f",
+        "EventName": "UNC_P_MEMORY_PHASE_SHEDDING_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the PCU has=
 triggered memory phase shedding.  This is a mode that can be run in the iM=
C physicals that saves power at the expense of additional latency.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore w=
as running at a frequency greater than or equal to 2Ghz. Derived from unc_p=
_freq_band1_cycles",
+        "BriefDescription": "Number of cores in C0",
         "Counter": "0,1,2,3",
-        "EventCode": "0xc",
-        "EventName": "UNC_P_FREQ_GE_2000MHZ_CYCLES",
-        "Filter": "filter_band1=3D20",
-        "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
-        "MetricName": "freq_ge_2000mhz_cycles %",
+        "EventCode": "0x80",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
         "PerPkg": "1",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in C0.  It can be used by itself to get the average=
 number of cores in C0, with threshholding to generate histograms, or with =
other PCU events and occupancy triggering to capture other details.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore w=
as running at a frequency greater than or equal to 3Ghz. Derived from unc_p=
_freq_band2_cycles",
+        "BriefDescription": "Number of cores in C0",
         "Counter": "0,1,2,3",
-        "EventCode": "0xd",
-        "EventName": "UNC_P_FREQ_GE_3000MHZ_CYCLES",
-        "Filter": "filter_band2=3D30",
-        "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
-        "MetricName": "freq_ge_3000mhz_cycles %",
+        "EventCode": "0x80",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
         "PerPkg": "1",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in C0.  It can be used by itself to get the average=
 number of cores in C0, with threshholding to generate histograms, or with =
other PCU events and occupancy triggering to capture other details.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore w=
as running at a frequency greater than or equal to 4Ghz. Derived from unc_p=
_freq_band3_cycles",
+        "BriefDescription": "Number of cores in C0",
         "Counter": "0,1,2,3",
-        "EventCode": "0xe",
-        "EventName": "UNC_P_FREQ_GE_4000MHZ_CYCLES",
-        "Filter": "filter_band3=3D40",
-        "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
-        "MetricName": "freq_ge_4000mhz_cycles %",
+        "EventCode": "0x80",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
         "PerPkg": "1",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in C0.  It can be used by itself to get the average=
 number of cores in C0, with threshholding to generate histograms, or with =
other PCU events and occupancy triggering to capture other details.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of times that the uncore tr=
ansitioned to a frequency greater than or equal to 1.2Ghz. Derived from unc=
_p_freq_band0_cycles",
+        "BriefDescription": "External Prochot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xa",
+        "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that we are in e=
xternal PROCHOT mode.  This mode is triggered when a sensor off the die det=
ermines that something off-die (like DRAM) is too hot and must throttle to =
avoid damaging the chip.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Internal Prochot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that we are in I=
nteral PROCHOT mode.  This mode is triggered when a sensor on the die deter=
mines that we are too hot and must throttle to avoid damaging the chip.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Total Core C State Transition Cycles",
         "Counter": "0,1,2,3",
         "EventCode": "0xb",
-        "EventName": "UNC_P_FREQ_GE_1200MHZ_TRANSITIONS",
-        "Filter": "edge=3D1,filter_band0=3D12",
-        "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
-        "MetricName": "freq_ge_1200mhz_cycles %",
+        "EventName": "UNC_P_TOTAL_TRANSITION_CYCLES",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions across all cores.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of times that the uncore tr=
ansitioned to a frequency greater than or equal to 2Ghz. Derived from unc_p=
_freq_band1_cycles",
+        "BriefDescription": "Cycles Changing Voltage",
         "Counter": "0,1,2,3",
-        "EventCode": "0xc",
-        "EventName": "UNC_P_FREQ_GE_2000MHZ_TRANSITIONS",
-        "Filter": "edge=3D1,filter_band1=3D20",
-        "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
-        "MetricName": "freq_ge_2000mhz_cycles %",
+        "EventCode": "0x3",
+        "EventName": "UNC_P_VOLT_TRANS_CYCLES_CHANGE",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the system =
is changing voltage.  There is no filtering supported with this event.  One=
 can use it as a simple event, or use it conjunction with the occupancy eve=
nts to monitor the number of cores or threads that were impacted by the tra=
nsition.  This event is calculated by or'ing together the increasing and de=
creasing events.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore t=
ransitioned to a frequency greater than or equal to 3Ghz. Derived from unc_=
p_freq_band2_cycles",
+        "BriefDescription": "Cycles Decreasing Voltage",
         "Counter": "0,1,2,3",
-        "EventCode": "0xd",
-        "EventName": "UNC_P_FREQ_GE_3000MHZ_TRANSITIONS",
-        "Filter": "edge=3D1,filter_band2=3D30",
-        "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
-        "MetricName": "freq_ge_3000mhz_cycles %",
+        "EventCode": "0x2",
+        "EventName": "UNC_P_VOLT_TRANS_CYCLES_DECREASE",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the system =
is decreasing voltage.  There is no filtering supported with this event.  O=
ne can use it as a simple event, or use it conjunction with the occupancy e=
vents to monitor the number of cores or threads that were impacted by the t=
ransition.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore t=
ransitioned to a frequency greater than or equal to 4Ghz. Derived from unc_=
p_freq_band3_cycles",
+        "BriefDescription": "Cycles Increasing Voltage",
         "Counter": "0,1,2,3",
-        "EventCode": "0xe",
-        "EventName": "UNC_P_FREQ_GE_4000MHZ_TRANSITIONS",
-        "Filter": "edge=3D1,filter_band3=3D40",
-        "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
-        "MetricName": "freq_ge_4000mhz_cycles %",
+        "EventCode": "0x1",
+        "EventName": "UNC_P_VOLT_TRANS_CYCLES_INCREASE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the system =
is increasing voltage.  There is no filtering supported with this event.  O=
ne can use it as a simple event, or use it conjunction with the occupancy e=
vents to monitor the number of cores or threads that were impacted by the t=
ransition.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "VR Hot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_P_VR_HOT_CYCLES",
         "PerPkg": "1",
         "Unit": "PCU"
     }
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/virtual-memory.json b/=
tools/perf/pmu-events/arch/x86/jaketown/virtual-memory.json
index 4dd136d00a10..98362abba1a7 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/virtual-memory.json
@@ -146,4 +146,4 @@
         "SampleAfterValue": "100007",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index b023c1ac2224..10c57fc4dcd1 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -14,7 +14,7 @@ GenuineIntel-6-(7D|7E|A7),v1.14,icelake,core
 GenuineIntel-6-6[AC],v1.15,icelakex,core
 GenuineIntel-6-3A,v22,ivybridge,core
 GenuineIntel-6-3E,v21,ivytown,core
-GenuineIntel-6-2D,v20,jaketown,core
+GenuineIntel-6-2D,v21,jaketown,core
 GenuineIntel-6-57,v9,knightslanding,core
 GenuineIntel-6-85,v9,knightslanding,core
 GenuineIntel-6-1E,v2,nehalemep,core
--=20
2.37.1.359.gd136c6c3e2-goog

