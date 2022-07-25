Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DC658079A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbiGYWkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbiGYWix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:38:53 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B2526AFA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e559f6840so96409267b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=bfVzhZ96EzompuyTda9KA6Q5+ZcShGgCbKXcbg8IJss=;
        b=UGCWCsPskB+0ThgDWJXldDIcVfhxhCCSGiNUQ83FRswr/eJ4L1ex8OtbrKmIC117ZK
         lZQ6eYr2zPGY1DxM6mqmPcc8xMg96POPrhrQlQH6Ns0BOkHeCCoQBwOedAcqWRiWewtg
         wZ9kssIFvTKQS5wJjsDb5BbcRmjyJd8GvdsESkbRFrLw+96kQ78Ygh+fI1aX7JFhu4qz
         z0b1K3fq6yL1nAeJPCMNhBHhySTA62qvqM+PU/oYeCFVkAO6MV57pJWnWNwlekKywkfh
         HXCWn4n5DcKm3vR62lT9WOnjV0lnKJ7VUsUkpyBMXaHxA+drBd7vt18+uB0Dc9549Nu7
         Dxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=bfVzhZ96EzompuyTda9KA6Q5+ZcShGgCbKXcbg8IJss=;
        b=xLAuXJZljWhBjRCszfiALANsOHQC2jjOTRhvDylLPnKgR/BXPvVrYVBfds/Cus0/EY
         1l9NhyXUQf6GdICNhL93k5WAkpmVnKoutD31c8SCZsEGf2c/EpnIiLo5XCxV6OEn+FOR
         nqS+EOygjA1ZyPJ2KX5uQapCMReiEMwg4bDtdTSVGVPOiPBUcDtRowHJf1JvdtwD2y/D
         C3yNglOMXx2mt4BLXlZMU6+Or0mAP+WS6t43Sxd8I27GyRg3eKGM5McJ86omBHH0D8m/
         WE/LiVjctzmNDF9r9915yEsrV9A4XDKcYx2pbyCn4Z5kzypNxbJt4+N7Zm6MJdjL/nsp
         XC4A==
X-Gm-Message-State: AJIora/tKSJimmLbekXqJwg+kV7/+oSCA48d2BuRuZThqjnzF20rrBT3
        wUJlQteHZmZkM8FCIR3muIU39spQYRks
X-Google-Smtp-Source: AGRyM1v39RmO2YyNpYHAPxY7IP5xQpGF+a5iV7lzCzpGyvp/x5hBffd6/L46JLGBmfkFFc+xAevCCOdOMNuU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a0d:f082:0:b0:31f:1d1d:118d with SMTP id
 z124-20020a0df082000000b0031f1d1d118dmr4005582ywe.124.1658788663377; Mon, 25
 Jul 2022 15:37:43 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:23 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-23-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 22/32] perf vendor events: Update Intel sandybridge
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

Update to v17, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

to download and generate the latest events and metrics. Manually copy
the sandybridge files into perf and update mapfile.csv.

Tested on a non-sandybridge with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv            |  2 +-
 tools/perf/pmu-events/arch/x86/sandybridge/cache.json |  2 +-
 .../arch/x86/sandybridge/floating-point.json          |  2 +-
 .../pmu-events/arch/x86/sandybridge/frontend.json     |  4 ++--
 .../perf/pmu-events/arch/x86/sandybridge/memory.json  |  2 +-
 tools/perf/pmu-events/arch/x86/sandybridge/other.json |  2 +-
 .../pmu-events/arch/x86/sandybridge/pipeline.json     | 10 +++++-----
 .../pmu-events/arch/x86/sandybridge/snb-metrics.json  | 11 +++++++++--
 .../pmu-events/arch/x86/sandybridge/uncore-other.json |  2 +-
 .../arch/x86/sandybridge/virtual-memory.json          |  2 +-
 10 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index ab070ba3ad48..eae103022077 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -19,12 +19,12 @@ GenuineIntel-6-(57|85),v9,knightslanding,core
 GenuineIntel-6-AA,v1.00,meteorlake,core
 GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
+GenuineIntel-6-2A,v17,sandybridge,core
 GenuineIntel-6-[4589]E,v24,skylake,core
 GenuineIntel-6-A[56],v24,skylake,core
 GenuineIntel-6-37,v13,silvermont,core
 GenuineIntel-6-4D,v13,silvermont,core
 GenuineIntel-6-4C,v13,silvermont,core
-GenuineIntel-6-2A,v15,sandybridge,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/cache.json b/tools/=
perf/pmu-events/arch/x86/sandybridge/cache.json
index 92a7269eb444..a1d622352131 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
@@ -1876,4 +1876,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json=
 b/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
index 713878fd062b..eb2ff2cfdf6b 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
@@ -135,4 +135,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json b/too=
ls/perf/pmu-events/arch/x86/sandybridge/frontend.json
index fa22f9463b66..e2c82e43a2de 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
@@ -176,7 +176,7 @@
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES",
-        "PublicDescription": "This event counts cycles during which the mi=
crocode sequencer assisted the front-end in delivering uops.  Microcode ass=
ists are used for complex instructions or scenarios that can't be handled b=
y the standard decoder.  Using other instructions, if possible, will usuall=
y improve performance.  See the Intel 64 and IA-32 Architectures Optimizati=
on Reference Manual for more information.",
+        "PublicDescription": "This event counts cycles during which the mi=
crocode sequencer assisted the front-end in delivering uops.  Microcode ass=
ists are used for complex instructions or scenarios that can't be handled b=
y the standard decoder.  Using other instructions, if possible, will usuall=
y improve performance.  See the Intel(R) 64 and IA-32 Architectures Optimiz=
ation Reference Manual for more information.",
         "SampleAfterValue": "2000003",
         "UMask": "0x30"
     },
@@ -311,4 +311,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/memory.json b/tools=
/perf/pmu-events/arch/x86/sandybridge/memory.json
index 931892d34076..3c283ca309f3 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/memory.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/memory.json
@@ -442,4 +442,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/other.json b/tools/=
perf/pmu-events/arch/x86/sandybridge/other.json
index e251f535ec09..2f873ab14156 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/other.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/other.json
@@ -55,4 +55,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/sandybridge/pipeline.json
index b9a3f194a00a..2c3b6c92aa6b 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
@@ -609,7 +609,7 @@
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
@@ -652,7 +652,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
-        "PublicDescription": "This event counts loads that followed a stor=
e to the same address, where the data could not be forwarded inside the pip=
eline from the store to the load.  The most common reason why store forward=
ing would be blocked is when a load's address range overlaps with a preceed=
ing smaller uncompleted store.  See the table of not supported store forwar=
ds in the Intel 64 and IA-32 Architectures Optimization Reference Manual.  =
The penalty for blocked store forwarding is that the load must wait for the=
 store to complete before it can be issued.",
+        "PublicDescription": "This event counts loads that followed a stor=
e to the same address, where the data could not be forwarded inside the pip=
eline from the store to the load.  The most common reason why store forward=
ing would be blocked is when a load's address range overlaps with a preceed=
ing smaller uncompleted store.  See the table of not supported store forwar=
ds in the Intel(R) 64 and IA-32 Architectures Optimization Reference Manual=
.  The penalty for blocked store forwarding is that the load must wait for =
the store to complete before it can be issued.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -778,7 +778,7 @@
         "CounterMask": "1",
         "EventCode": "0x59",
         "EventName": "PARTIAL_RAT_STALLS.FLAGS_MERGE_UOP_CYCLES",
-        "PublicDescription": "This event counts the number of cycles spent=
 executing performance-sensitive flags-merging uops. For example, shift CL =
(merge_arith_flags). For more details, See the Intel 64 and IA-32 Architect=
ures Optimization Reference Manual.",
+        "PublicDescription": "This event counts the number of cycles spent=
 executing performance-sensitive flags-merging uops. For example, shift CL =
(merge_arith_flags). For more details, See the Intel(R) 64 and IA-32 Archit=
ectures Optimization Reference Manual.",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
@@ -797,7 +797,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0x59",
         "EventName": "PARTIAL_RAT_STALLS.SLOW_LEA_WINDOW",
-        "PublicDescription": "This event counts the number of cycles with =
at least one slow LEA uop being allocated. A uop is generally considered as=
 slow LEA if it has three sources (for example, two sources and immediate) =
regardless of whether it is a result of LEA instruction or not. Examples of=
 the slow LEA uop are or uops with base, index, and offset source operands =
using base and index reqisters, where base is EBR/RBP/R13, using RIP relati=
ve or 16-bit addressing modes. See the Intel 64 and IA-32 Architectures Opt=
imization Reference Manual for more details about slow LEA instructions.",
+        "PublicDescription": "This event counts the number of cycles with =
at least one slow LEA uop being allocated. A uop is generally considered as=
 slow LEA if it has three sources (for example, two sources and immediate) =
regardless of whether it is a result of LEA instruction or not. Examples of=
 the slow LEA uop are or uops with base, index, and offset source operands =
using base and index reqisters, where base is EBR/RBP/R13, using RIP relati=
ve or 16-bit addressing modes. See the Intel(R) 64 and IA-32 Architectures =
Optimization Reference Manual for more details about slow LEA instructions.=
",
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     },
@@ -1209,4 +1209,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/=
tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
index c8e7050d9c26..ae7ed267b2a2 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
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
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json b=
/tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json
index 6278068908cf..88f1e326205f 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/uncore-other.json
@@ -82,10 +82,10 @@
     {
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les.",
         "Counter": "Fixed",
+        "EventCode": "0xff",
         "EventName": "UNC_CLOCK.SOCKET",
         "PerPkg": "1",
         "PublicDescription": "This 48-bit fixed counter counts the UCLK cy=
cles.",
-        "UMask": "0x01",
         "Unit": "ARB"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json=
 b/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
index 4dd136d00a10..98362abba1a7 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
@@ -146,4 +146,4 @@
         "SampleAfterValue": "100007",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
--=20
2.37.1.359.gd136c6c3e2-goog

