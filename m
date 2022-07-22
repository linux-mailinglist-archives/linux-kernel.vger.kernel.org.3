Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CD957E9C4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbiGVWfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbiGVWeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:34:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A54B5575
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m123-20020a253f81000000b0066ff6484995so4635065yba.22
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=9ArlNkE9Ysn02koTmPHDPohLRaZdKk2HPfL1NeuBAmM=;
        b=X0Crefete/0mmRH/JTOLqk0mjDbVzlQ1b3qAfPwwwJsEEoMceLkEkWdRTcYjcPv/Ki
         UtktSkuDZH6O88YVV8uveBhfsjA1KvolgUnOwcTIjQ9WapdYjPm7YbFan826fsUbysi6
         M3Dxk7KuLxxAKkn+qOPCPS6RLIU7+WyqMmpz0WhiwYwnyJcIC82bBQfPw9vOfzKqFHJy
         PTGHDgIBi0qMdrngnLT3dWXkHE3mNcNub1BKDIO5Ld9vr2mXmOap4iTCNtTh2mpiFlKi
         HycewivES487RcsC3pCDEBhmM+0teu03sCzxCPZmBYTIGg/tgNPjnr7ObB1BbYqMXBug
         DzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=9ArlNkE9Ysn02koTmPHDPohLRaZdKk2HPfL1NeuBAmM=;
        b=OMyKLCxUmRCY3Mh9ldVo8rLfGHfO3ifX7n83+rMv6xFH4VUzuk/e5mbJNiDkvKE6SP
         pkNtfH8icxO4q3LBmJEFC2J6OSA/JZVOQnnf+cuHOvhCdfUqLacyLoyo/JH1p1xNys+9
         98gm1vgB+9pPV/SxzFIIaow0DOjDDNsTvdSU+g8HYckGcR+PYiBEfTd3eZ0jiZI32C/h
         vGZxtI8jXb6ItampKqaesdspUXMc6IFd05hvTbuavzIPyXdAN7ceAe+tVSIMDO6xTo6a
         21SdI5cifZ0GhL748YPM88YfCP4DLvWFKf9TL8QcyK/bx4Jes00rXKzhZ5Tyr9vxwitE
         Tu0Q==
X-Gm-Message-State: AJIora9vsMbZ+drv/IxxImVEg+S9j3VIeWEnDlYiQonsoh3dVk86Ap1Z
        GwmkBx0BdlSXcC8vxt7x0xlqadawFnQw
X-Google-Smtp-Source: AGRyM1tJ9nuIcxkv+FX6lnIidy1LpAsowSdWAo9P9YuRUVWoYeSXr91akw2SodCOOSTrVrqbFjRDtzwTm91g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a05:6902:1389:b0:668:39b3:63bc with SMTP
 id x9-20020a056902138900b0066839b363bcmr1608731ybu.577.1658529203141; Fri, 22
 Jul 2022 15:33:23 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:21 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-13-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 12/31] perf vendor events: Update Intel haswellx
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
the haswellx files into perf and update mapfile.csv.

Tested with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 90: perf all metricgroups test                                      : Ok
 91: perf all metrics test                                           : Fail=
ed
 93: perf all PMU test                                               : Ok

The test 91 failure is a pre-existing failure on the test system
with the metric Load_Miss_Real_Latency which is fixed by
prefixing it with --metric-no-group.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/haswellx/cache.json   |   44 +-
 .../arch/x86/haswellx/floating-point.json     |    2 +-
 .../arch/x86/haswellx/frontend.json           |    2 +-
 .../arch/x86/haswellx/hsx-metrics.json        |   85 +-
 .../pmu-events/arch/x86/haswellx/memory.json  |   52 +-
 .../pmu-events/arch/x86/haswellx/other.json   |    2 +-
 .../arch/x86/haswellx/pipeline.json           |    9 +-
 .../arch/x86/haswellx/uncore-cache.json       | 3779 ++++++++++++++++-
 .../x86/haswellx/uncore-interconnect.json     | 1430 ++++++-
 .../arch/x86/haswellx/uncore-memory.json      | 2839 ++++++++++++-
 .../arch/x86/haswellx/uncore-other.json       | 3170 ++++++++++++++
 .../arch/x86/haswellx/uncore-power.json       |  477 ++-
 .../arch/x86/haswellx/virtual-memory.json     |    2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
 14 files changed, 11582 insertions(+), 313 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/uncore-other.js=
on

diff --git a/tools/perf/pmu-events/arch/x86/haswellx/cache.json b/tools/per=
f/pmu-events/arch/x86/haswellx/cache.json
index 85eb998dd39e..7557a203a1b6 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/cache.json
@@ -20,7 +20,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "L1D miss oustandings duration in cycles",
+        "BriefDescription": "L1D miss outstanding duration in cycles",
         "Counter": "2",
         "CounterHTOff": "2",
         "EventCode": "0x48",
@@ -592,7 +592,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "All retired load uops.",
+        "BriefDescription": "Retired load uops.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
@@ -600,11 +600,12 @@
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PEBS": "1",
+        "PublicDescription": "Counts all retired load uops. This event acc=
ounts for SW prefetch uops of PREFETCHNTA or PREFETCHT0/1/2 or PREFETCHW.",
         "SampleAfterValue": "2000003",
         "UMask": "0x81"
     },
     {
-        "BriefDescription": "All retired store uops.",
+        "BriefDescription": "Retired store uops.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
@@ -613,6 +614,7 @@
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "L1_Hit_Indication": "1",
         "PEBS": "1",
+        "PublicDescription": "Counts all retired store uops.",
         "SampleAfterValue": "2000003",
         "UMask": "0x82"
     },
@@ -832,9 +834,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_HIT.HIT_OTHER_CORE_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0244",
+        "MSRValue": "0x4003C0244",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch code reads hit =
in the L3 and the snoops to sibling cores hit in either E/S state and the l=
ine is not forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -847,7 +848,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0091",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads hit =
in the L3 and the snoop to one of the sibling cores hits the line in M stat=
e and the line is forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -858,9 +858,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.HIT_OTHER_CORE_=
NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0091",
+        "MSRValue": "0x4003C0091",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads hit =
in the L3 and the snoops to sibling cores hit in either E/S state and the l=
ine is not forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -873,7 +872,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C07F7",
         "Offcore": "1",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & pre=
fetch) hit in the L3 and the snoop to one of the sibling cores hits the lin=
e in M state and the line is forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -884,9 +882,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_HIT.HIT_OTHER_CORE_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C07F7",
+        "MSRValue": "0x4003C07F7",
         "Offcore": "1",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & pre=
fetch) hit in the L3 and the snoops to sibling cores hit in either E/S stat=
e and the line is not forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -899,7 +896,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C8FFF",
         "Offcore": "1",
-        "PublicDescription": "Counts all requests hit in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -912,7 +908,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0122",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs hit in the=
 L3 and the snoop to one of the sibling cores hits the line in M state and =
the line is forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -923,9 +918,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.LLC_HIT.HIT_OTHER_CORE_NO_F=
WD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0122",
+        "MSRValue": "0x4003C0122",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs hit in the=
 L3 and the snoops to sibling cores hit in either E/S state and the line is=
 not forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -938,7 +932,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0004",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads hit in the L3 a=
nd the snoop to one of the sibling cores hits the line in M state and the l=
ine is forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -949,9 +942,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_HIT.HIT_OTHER_CO=
RE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0004",
+        "MSRValue": "0x4003C0004",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads hit in the L3 a=
nd the snoops to sibling cores hit in either E/S state and the line is not =
forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -964,7 +956,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0001",
         "Offcore": "1",
-        "PublicDescription": "Counts demand data reads hit in the L3 and t=
he snoop to one of the sibling cores hits the line in M state and the line =
is forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -975,9 +966,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.HIT_OTHER_CO=
RE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0001",
+        "MSRValue": "0x4003C0001",
         "Offcore": "1",
-        "PublicDescription": "Counts demand data reads hit in the L3 and t=
he snoops to sibling cores hit in either E/S state and the line is not forw=
arded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -990,7 +980,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0002",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs) hit in =
the L3 and the snoop to one of the sibling cores hits the line in M state a=
nd the line is forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1001,9 +990,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.HIT_OTHER_CORE_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0002",
+        "MSRValue": "0x4003C0002",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs) hit in =
the L3 and the snoops to sibling cores hit in either E/S state and the line=
 is not forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1016,7 +1004,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0040",
         "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads hit in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1029,7 +1016,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0010",
         "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads hit in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1042,7 +1028,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0020",
         "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs hit in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1055,7 +1040,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0200",
         "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads hit in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1068,7 +1052,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0080",
         "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads hit in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1081,7 +1064,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0100",
         "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs hit in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1094,4 +1076,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/floating-point.json b/=
tools/perf/pmu-events/arch/x86/haswellx/floating-point.json
index 55cf5b96464e..7cf203a90a74 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/floating-point.json
@@ -100,4 +100,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/frontend.json b/tools/=
perf/pmu-events/arch/x86/haswellx/frontend.json
index 0c8d5ccf1276..c45a09abe5d3 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/frontend.json
@@ -301,4 +301,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
index c99734fd907d..5c9e008ca995 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
@@ -111,17 +111,11 @@
         "MetricName": "CoreIPC_SMT"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is at least 1 uop executed)",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
         "MetricExpr": "( UOPS_EXECUTED.CORE / 2 / (( cpu@UOPS_EXECUTED.COR=
E\\,cmask\\=3D1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1=
@) ) if #SMT_on else UOPS_EXECUTED.CORE / (( cpu@UOPS_EXECUTED.CORE\\,cmask=
\\=3D1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@)",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "ILP"
     },
-    {
-        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts",
-        "MetricName": "IpMispredict"
-    },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
         "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_U=
NHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
@@ -170,6 +164,12 @@
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
@@ -177,11 +177,16 @@
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load instructions (in core cycles)",
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "IpMispredict"
+    },
+    {
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_=
MISS + mem_load_uops_retired.hit_lfb )",
         "MetricGroup": "Mem;MemoryBound;MemoryLat",
-        "MetricName": "Load_Miss_Real_Latency",
-        "PublicDescription": "Actual Average Latency for L1 data-cache mis=
s demand load instructions (in core cycles). Latency may be overestimated f=
or multi-load instructions - e.g. repeat strings."
+        "MetricName": "Load_Miss_Real_Latency"
     },
     {
         "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss. Per-Logical Proces=
sor)",
@@ -189,24 +194,6 @@
         "MetricGroup": "Mem;MemoryBound;MemoryBW",
         "MetricName": "MLP"
     },
-    {
-        "BriefDescription": "Average data fill bandwidth to the L1 data ca=
che [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L1D_Cache_Fill_BW"
-    },
-    {
-        "BriefDescription": "Average data fill bandwidth to the L2 cache [=
GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L2_Cache_Fill_BW"
-    },
-    {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration=
_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L3_Cache_Fill_BW"
-    },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED=
.ANY",
@@ -238,6 +225,48 @@
         "MetricGroup": "Mem;MemoryTLB_SMT",
         "MetricName": "Page_Walks_Utilization_SMT"
     },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L1D_Cache_Fill_BW"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L2_Cache_Fill_BW"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration=
_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L3_Cache_Fill_BW"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
+        "MetricExpr": "(64 * L1D.REPLACEMENT / 1000000000 / duration_time)=
",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L1D_Cache_Fill_BW_1T"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
+        "MetricExpr": "(64 * L2_LINES_IN.ALL / 1000000000 / duration_time)=
",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L2_Cache_Fill_BW_1T"
+    },
+    {
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
+        "MetricExpr": "0",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "L3_Cache_Access_BW_1T"
+    },
     {
         "BriefDescription": "Average CPU Utilization",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/memory.json b/tools/pe=
rf/pmu-events/arch/x86/haswellx/memory.json
index 6ffb5067f4eb..fdabc9fe12a5 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/memory.json
@@ -233,7 +233,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00244",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch code reads miss=
 in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -244,9 +243,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0600400244",
+        "MSRValue": "0x600400244",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch code reads miss=
 the L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -259,7 +257,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00091",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads miss=
 in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -270,9 +267,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0600400091",
+        "MSRValue": "0x600400091",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads miss=
 the L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -283,9 +279,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.REMOTE_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x063F800091",
+        "MSRValue": "0x63F800091",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads miss=
 the L3 and the data is returned from remote dram",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -298,7 +293,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00091",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads miss=
 the L3 and the modified data is transferred from remote cache",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -309,9 +303,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.REMOTE_HIT_FOR=
WARD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x083FC00091",
+        "MSRValue": "0x83FC00091",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads miss=
 the L3 and clean or shared data is transferred from remote cache",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -324,7 +317,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC007F7",
         "Offcore": "1",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & pre=
fetch) miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -335,9 +327,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x06004007F7",
+        "MSRValue": "0x6004007F7",
         "Offcore": "1",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & pre=
fetch) miss the L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -348,9 +339,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.REMOTE_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x063F8007F7",
+        "MSRValue": "0x63F8007F7",
         "Offcore": "1",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & pre=
fetch) miss the L3 and the data is returned from remote dram",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -363,7 +353,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC007F7",
         "Offcore": "1",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & pre=
fetch) miss the L3 and the modified data is transferred from remote cache",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -374,9 +363,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.REMOTE_HIT_FORWA=
RD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x083FC007F7",
+        "MSRValue": "0x83FC007F7",
         "Offcore": "1",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & pre=
fetch) miss the L3 and clean or shared data is transferred from remote cach=
e",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -389,7 +377,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC08FFF",
         "Offcore": "1",
-        "PublicDescription": "Counts all requests miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -402,7 +389,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00122",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs miss in th=
e L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -413,9 +399,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0600400122",
+        "MSRValue": "0x600400122",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs miss the L=
3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -428,7 +413,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00004",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads miss in the L3"=
,
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -439,9 +423,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_MISS.LOCAL_DRAM"=
,
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0600400004",
+        "MSRValue": "0x600400004",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads miss the L3 and=
 the data is returned from local dram",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -454,7 +437,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00001",
         "Offcore": "1",
-        "PublicDescription": "Counts demand data reads miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -465,9 +447,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.LOCAL_DRAM"=
,
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0600400001",
+        "MSRValue": "0x600400001",
         "Offcore": "1",
-        "PublicDescription": "Counts demand data reads miss the L3 and the=
 data is returned from local dram",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -480,7 +461,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00002",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs) miss in=
 the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -491,9 +471,8 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0600400002",
+        "MSRValue": "0x600400002",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs) miss th=
e L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -506,7 +485,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00002",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs) miss th=
e L3 and the modified data is transferred from remote cache",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -519,7 +497,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00040",
         "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -532,7 +509,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00010",
         "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -545,7 +521,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00020",
         "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -558,7 +533,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00200",
         "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -571,7 +545,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00080",
         "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -584,7 +557,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00100",
         "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -772,4 +744,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/other.json b/tools/per=
f/pmu-events/arch/x86/haswellx/other.json
index 4c6b9d34325a..7ca34f09b185 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/other.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/other.json
@@ -40,4 +40,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json b/tools/=
perf/pmu-events/arch/x86/haswellx/pipeline.json
index a53f28ec9270..42f6a8100661 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
@@ -1035,7 +1035,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_0_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted in p=
ort 0.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1056,7 +1055,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_1_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted in p=
ort 1.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -1117,7 +1115,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_4_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted in p=
ort 4.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -1138,7 +1135,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_5_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted in p=
ort 5.",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
@@ -1159,7 +1155,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_6_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted in p=
ort 6.",
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     },
@@ -1295,11 +1290,11 @@
         "BriefDescription": "Cycles with less than 10 actually retired uop=
s.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
-        "CounterMask": "10",
+        "CounterMask": "16",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
         "Invert": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
index 58ed6d33d1f4..03598904d746 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
@@ -1,11 +1,62 @@
 [
     {
-        "BriefDescription": "Uncore cache clock ticks",
+        "BriefDescription": "Bounce Control",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_C_BOUNCE_CONTROL",
+        "PerPkg": "1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Uncore Clocks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CBO"
     },
+    {
+        "BriefDescription": "Counter 0 Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_C_COUNTER0_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "FaST wire asserted",
+        "Counter": "0,1",
+        "EventCode": "0x9",
+        "EventName": "UNC_C_FAST_ASSERTED",
+        "PerPkg": "1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Cache Lookups; Data Read Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Cache Lookups; Write Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.WRITE",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Cache Lookups; External Snoop Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "CBO"
+    },
     {
         "BriefDescription": "All LLC Misses (code+ data rd + data wr - inc=
luding demand and prefetch)",
         "Counter": "0,1,2,3",
@@ -17,6 +68,24 @@
         "UMask": "0x11",
         "Unit": "CBO"
     },
+    {
+        "BriefDescription": "Cache Lookups; Lookups that Match NID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.NID",
+        "PerPkg": "1",
+        "UMask": "0x41",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Cache Lookups; Any Read Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.READ",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CBO"
+    },
     {
         "BriefDescription": "M line evictions from LLC (writebacks to memo=
ry)",
         "Counter": "0,1,2,3",
@@ -28,290 +97,3698 @@
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC misses - demand and prefetch data reads -=
 excludes LLC prefetches. Derived from unc_c_tor_inserts.miss_opcode",
+        "BriefDescription": "Lines Victimized; Lines in E state",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.DATA_READ",
-        "Filter": "filter_opc=3D0x182",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.E_STATE",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "UMask": "0x2",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) . D=
erived from unc_c_tor_inserts.miss_opcode",
+        "BriefDescription": "Lines in S State",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.UNCACHEABLE",
-        "Filter": "filter_opc=3D0x187",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.S_STATE",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "UMask": "0x4",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "MMIO reads. Derived from unc_c_tor_inserts.mi=
ss_opcode",
+        "BriefDescription": "Lines Victimized",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.MMIO_READ",
-        "Filter": "filter_opc=3D0x187,filter_nc=3D1",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.F_STATE",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "UMask": "0x8",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "MMIO writes. Derived from unc_c_tor_inserts.m=
iss_opcode",
+        "BriefDescription": "Lines Victimized; Victimized Lines that Match=
 NID",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.MMIO_WRITE",
-        "Filter": "filter_opc=3D0x18f,filter_nc=3D1",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.NID",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "UMask": "0x40",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC prefetch misses for RFO. Derived from unc=
_c_tor_inserts.miss_opcode",
+        "BriefDescription": "Lines Victimized",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.RFO_LLC_PREFETCH",
-        "Filter": "filter_opc=3D0x190",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.MISS",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "UMask": "0x10",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC prefetch misses for code reads. Derived f=
rom unc_c_tor_inserts.miss_opcode",
+        "BriefDescription": "Cbo Misc; Silent Snoop Eviction",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.CODE_LLC_PREFETCH",
-        "Filter": "filter_opc=3D0x191",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.RSPI_WAS_FSE",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC prefetch misses for data reads. Derived f=
rom unc_c_tor_inserts.miss_opcode",
+        "BriefDescription": "Cbo Misc; Write Combining Aliasing",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.DATA_LLC_PREFETCH",
-        "Filter": "filter_opc=3D0x192",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.WC_ALIASING",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "UMask": "0x2",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC misses for PCIe read current. Derived fro=
m unc_c_tor_inserts.miss_opcode",
+        "BriefDescription": "Cbo Misc",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.PCIE_READ",
-        "Filter": "filter_opc=3D0x19e",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.STARTED",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "UMask": "0x4",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "ItoM write misses (as part of fast string mem=
cpy stores) + PCIe full line writes. Derived from unc_c_tor_inserts.miss_op=
code",
+        "BriefDescription": "Cbo Misc; RFO HitS",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.PCIE_WRITE",
-        "Filter": "filter_opc=3D0x1c8",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.RFO_HIT_S",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "UMask": "0x8",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe write misses (full cache line). Derived =
from unc_c_tor_inserts.miss_opcode",
+        "BriefDescription": "Cbo Misc; Clean Victim with raw CV=3D0",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.PCIE_NON_SNOOP_WRITE",
-        "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.CVZERO_PREFETCH_VICTIM",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "UMask": "0x10",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe writes (partial cache line). Derived fro=
m unc_c_tor_inserts.opcode",
+        "BriefDescription": "Cbo Misc; DRd hitting non-M with raw CV=3D0",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_NS_PARTIAL_WRITE",
-        "Filter": "filter_opc=3D0x180,filter_tid=3D0x3e",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.CVZERO_PREFETCH_MISS",
         "PerPkg": "1",
-        "UMask": "0x1",
+        "UMask": "0x20",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "L2 demand and L2 prefetch code references to =
LLC. Derived from unc_c_tor_inserts.opcode",
+        "BriefDescription": "LRU Queue; LRU Age 0",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.CODE_LLC_PREFETCH",
-        "Filter": "filter_opc=3D0x181",
+        "EventCode": "0x3C",
+        "EventName": "UNC_C_QLRU.AGE0",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Streaming stores (full cache line). Derived f=
rom unc_c_tor_inserts.opcode",
+        "BriefDescription": "LRU Queue; LRU Age 1",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.STREAMING_FULL",
-        "Filter": "filter_opc=3D0x18c",
+        "EventCode": "0x3C",
+        "EventName": "UNC_C_QLRU.AGE1",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
+        "UMask": "0x2",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Streaming stores (partial cache line). Derive=
d from unc_c_tor_inserts.opcode",
+        "BriefDescription": "LRU Queue; LRU Age 2",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
-        "Filter": "filter_opc=3D0x18d",
+        "EventCode": "0x3C",
+        "EventName": "UNC_C_QLRU.AGE2",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
+        "UMask": "0x4",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe read current. Derived from unc_c_tor_ins=
erts.opcode",
+        "BriefDescription": "LRU Queue; LRU Age 3",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_READ",
-        "Filter": "filter_opc=3D0x19e",
+        "EventCode": "0x3C",
+        "EventName": "UNC_C_QLRU.AGE3",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
+        "UMask": "0x8",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe write references (full cache line). Deri=
ved from unc_c_tor_inserts.opcode",
+        "BriefDescription": "LRU Queue; LRU Bits Decremented",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_WRITE",
-        "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
+        "EventCode": "0x3C",
+        "EventName": "UNC_C_QLRU.LRU_DECREMENT",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "LRU Queue; Non-0 Aged Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_C_QLRU.VICTIM_NON_ZERO",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Up and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.UP_EVEN",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Occupancy counter for LLC data reads (demand =
and L2 prefetch). Derived from unc_c_tor_occupancy.miss_opcode",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.LLC_DATA_READ",
-        "Filter": "filter_opc=3D0x182",
+        "BriefDescription": "AD Ring In Use; Up and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.UP_ODD",
         "PerPkg": "1",
-        "UMask": "0x3",
+        "UMask": "0x2",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "read requests to home agent",
+        "BriefDescription": "AD Ring In Use; Down and Even",
         "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_H_REQUESTS.READS",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.DOWN_EVEN",
         "PerPkg": "1",
-        "UMask": "0x3",
-        "Unit": "HA"
+        "UMask": "0x4",
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "read requests to local home agent",
+        "BriefDescription": "AD Ring In Use; Down and Odd",
         "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_H_REQUESTS.READS_LOCAL",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.DOWN_ODD",
         "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "HA"
+        "UMask": "0x8",
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "read requests to remote home agent",
+        "BriefDescription": "AD Ring In Use; Up",
         "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_H_REQUESTS.READS_REMOTE",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.UP",
         "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "HA"
+        "UMask": "0x3",
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "write requests to home agent",
+        "BriefDescription": "AD Ring In Use; Down",
         "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_H_REQUESTS.WRITES",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.DOWN",
         "PerPkg": "1",
         "UMask": "0xC",
-        "Unit": "HA"
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "write requests to local home agent",
+        "BriefDescription": "AD Ring In Use; All",
         "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_H_REQUESTS.WRITES_LOCAL",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.ALL",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Up and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Up and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Down and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.DOWN_EVEN",
         "PerPkg": "1",
         "UMask": "0x4",
-        "Unit": "HA"
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "write requests to remote home agent",
+        "BriefDescription": "AK Ring In Use; Down and Odd",
         "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_H_REQUESTS.WRITES_REMOTE",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.DOWN_ODD",
         "PerPkg": "1",
         "UMask": "0x8",
-        "Unit": "HA"
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "Conflict requests (requests for same address =
from multiple agents simultaneously)",
+        "BriefDescription": "AK Ring In Use; Up",
         "Counter": "0,1,2,3",
-        "EventCode": "0x21",
-        "EventName": "UNC_H_SNOOP_RESP.RSPCNFLCT",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.UP",
         "PerPkg": "1",
-        "UMask": "0x40",
-        "Unit": "HA"
+        "UMask": "0x3",
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "M line forwarded from remote cache along with=
 writeback to memory",
+        "BriefDescription": "AK Ring In Use; Down",
         "Counter": "0,1,2,3",
-        "EventCode": "0x21",
-        "EventName": "UNC_H_SNOOP_RESP.RSP_FWD_WB",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.DOWN",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x20",
-        "Unit": "HA"
+        "UMask": "0xC",
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "M line forwarded from remote cache with no wr=
iteback to memory",
+        "BriefDescription": "AK Ring In Use; All",
         "Counter": "0,1,2,3",
-        "EventCode": "0x21",
-        "EventName": "UNC_H_SNOOP_RESP.RSPIFWD",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.ALL",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x4",
-        "Unit": "HA"
+        "UMask": "0xF",
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "Shared line response from remote cache",
+        "BriefDescription": "BL Ring in Use; Up and Even",
         "Counter": "0,1,2,3",
-        "EventCode": "0x21",
-        "EventName": "UNC_H_SNOOP_RESP.RSPS",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Up and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.UP_ODD",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
         "UMask": "0x2",
-        "Unit": "HA"
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "Shared line forwarded from remote cache",
+        "BriefDescription": "BL Ring in Use; Down and Even",
         "Counter": "0,1,2,3",
-        "EventCode": "0x21",
-        "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.DOWN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Down and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.DOWN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Up",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.UP",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Down",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.DOWN",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Down",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.ALL",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.AK",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; BL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.BL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Snoops of processor's cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.IV",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Any",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_C_RING_IV_USED.ANY",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Any",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_C_RING_IV_USED.UP",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Down",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_C_RING_IV_USED.DOWN",
+        "PerPkg": "1",
+        "UMask": "0xCC",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Any",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_C_RING_IV_USED.DN",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "UNC_C_RING_SINK_STARVED.AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_C_RING_SINK_STARVED.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "UNC_C_RING_SINK_STARVED.AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_C_RING_SINK_STARVED.AK",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "UNC_C_RING_SINK_STARVED.IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_C_RING_SINK_STARVED.IV",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "UNC_C_RING_SINK_STARVED.BL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_C_RING_SINK_STARVED.BL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Number of cycles the Cbo is actively throttli=
ng traffic onto the Ring in order to limit bounce traffic",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_C_RING_SRC_THRTL",
+        "PerPkg": "1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Arbiter Blocking Cycles; IPQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_C_RxR_EXT_STARVED.IRQ",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Arbiter Blocking Cycles; IRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_C_RxR_EXT_STARVED.IPQ",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Arbiter Blocking Cycles; PRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_C_RxR_EXT_STARVED.PRQ",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Arbiter Blocking Cycles; ISMQ_BID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_C_RxR_EXT_STARVED.ISMQ_BIDS",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; IRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.IRQ",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; IRQ Rejected",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.IRQ_REJ",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; IPQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.IPQ",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; PRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.PRQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; PRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.PRQ_REJ",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Internal Starvation Cycles; IRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_C_RxR_INT_STARVED.IRQ",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Internal Starvation Cycles; IPQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_C_RxR_INT_STARVED.IPQ",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Internal Starvation Cycles; ISMQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_C_RxR_INT_STARVED.ISMQ",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Internal Starvation Cycles; PRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_C_RxR_INT_STARVED.PRQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Probe Queue Retries; Any Reject",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_C_RxR_IPQ_RETRY.ANY",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Probe Queue Retries; No Egress Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_C_RxR_IPQ_RETRY.FULL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Probe Queue Retries; Address Conflict",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_C_RxR_IPQ_RETRY.ADDR_CONFLICT",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Probe Queue Retries; No QPI Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_C_RxR_IPQ_RETRY.QPI_CREDITS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Probe Queue Retries; No AD Sbo Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_C_RxR_IPQ_RETRY2.AD_SBO",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Probe Queue Retries; Target Node Filter",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_C_RxR_IPQ_RETRY2.TARGET",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; Any Reject",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.ANY",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; No Egress Cred=
its",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.FULL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; Address Confli=
ct",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.ADDR_CONFLICT",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; No RTIDs",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.RTID",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; No QPI Credits=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.QPI_CREDITS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; No IIO Credits=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.IIO_CREDITS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.NID",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; No AD Sbo Cred=
its",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_C_RxR_IRQ_RETRY2.AD_SBO",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; No BL Sbo Cred=
its",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_C_RxR_IRQ_RETRY2.BL_SBO",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; Target Node Fi=
lter",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_C_RxR_IRQ_RETRY2.TARGET",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; Any Reject",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.ANY",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; No Egress Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.FULL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; No RTIDs",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.RTID",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; No QPI Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.QPI_CREDITS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; No IIO Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.IIO_CREDITS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.WB_CREDITS",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.NID",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Request Queue Rejects; No AD Sbo Credits=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY2.AD_SBO",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Request Queue Rejects; No BL Sbo Credits=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY2.BL_SBO",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Request Queue Rejects; Target Node Filte=
r",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY2.TARGET",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; IRQ",
+        "EventCode": "0x11",
+        "EventName": "UNC_C_RxR_OCCUPANCY.IRQ",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; IPQ",
+        "EventCode": "0x11",
+        "EventName": "UNC_C_RxR_OCCUPANCY.IPQ",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; PRQ Rejects",
+        "EventCode": "0x11",
+        "EventName": "UNC_C_RxR_OCCUPANCY.PRQ_REJ",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "SBo Credits Acquired; For AD Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3D",
+        "EventName": "UNC_C_SBO_CREDITS_ACQUIRED.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "SBo Credits Acquired; For BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3D",
+        "EventName": "UNC_C_SBO_CREDITS_ACQUIRED.BL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "SBo Credits Occupancy; For AD Ring",
+        "EventCode": "0x3E",
+        "EventName": "UNC_C_SBO_CREDIT_OCCUPANCY.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "SBo Credits Occupancy; For BL Ring",
+        "EventCode": "0x3E",
+        "EventName": "UNC_C_SBO_CREDIT_OCCUPANCY.BL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "PCIe writes (partial cache line). Derived fro=
m unc_c_tor_inserts.opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "LLC_REFERENCES.PCIE_NS_PARTIAL_WRITE",
+        "Filter": "filter_opc=3D0x180,filter_tid=3D0x3e",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "PCIe writes (partial cache line)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
+        "Filter": "filter_opc=3D0x180,filter_tid=3D0x3e",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "L2 demand and L2 prefetch code references to =
LLC. Derived from unc_c_tor_inserts.opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "LLC_REFERENCES.CODE_LLC_PREFETCH",
+        "Filter": "filter_opc=3D0x181",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "L2 demand and L2 prefetch code references to =
LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
+        "Filter": "filter_opc=3D0x181",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Streaming stores (full cache line). Derived f=
rom unc_c_tor_inserts.opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "LLC_REFERENCES.STREAMING_FULL",
+        "Filter": "filter_opc=3D0x18c",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Streaming stores (full cache line)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
+        "Filter": "filter_opc=3D0x18c",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Streaming stores (partial cache line). Derive=
d from unc_c_tor_inserts.opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
+        "Filter": "filter_opc=3D0x18d",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Streaming stores (partial cache line)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
+        "Filter": "filter_opc=3D0x18d",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "PCIe read current. Derived from unc_c_tor_ins=
erts.opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "LLC_REFERENCES.PCIE_READ",
+        "Filter": "filter_opc=3D0x19e",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "PCIe read current",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
+        "Filter": "filter_opc=3D0x19e",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "PCIe write references (full cache line). Deri=
ved from unc_c_tor_inserts.opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "LLC_REFERENCES.PCIE_WRITE",
+        "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "PCIe write references (full cache line)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
+        "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Evictions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.EVICTION",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Writebacks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "LLC misses - demand and prefetch data reads -=
 excludes LLC prefetches. Derived from unc_c_tor_inserts.miss_opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "LLC_MISSES.DATA_READ",
+        "Filter": "filter_opc=3D0x182",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "LLC misses - demand and prefetch data reads -=
 excludes LLC prefetches",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
+        "Filter": "filter_opc=3D0x182",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) . D=
erived from unc_c_tor_inserts.miss_opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "LLC_MISSES.UNCACHEABLE",
+        "Filter": "filter_opc=3D0x187",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
+        "Filter": "filter_opc=3D0x187",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "MMIO reads. Derived from unc_c_tor_inserts.mi=
ss_opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "LLC_MISSES.MMIO_READ",
+        "Filter": "filter_opc=3D0x187,filter_nc=3D1",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "MMIO reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
+        "Filter": "filter_opc=3D0x187,filter_nc=3D1",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "MMIO writes. Derived from unc_c_tor_inserts.m=
iss_opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "LLC_MISSES.MMIO_WRITE",
+        "Filter": "filter_opc=3D0x18f,filter_nc=3D1",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "MMIO writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
+        "Filter": "filter_opc=3D0x18f,filter_nc=3D1",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "LLC prefetch misses for RFO. Derived from unc=
_c_tor_inserts.miss_opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "LLC_MISSES.RFO_LLC_PREFETCH",
+        "Filter": "filter_opc=3D0x190",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "LLC prefetch misses for RFO",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
+        "Filter": "filter_opc=3D0x190",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "LLC prefetch misses for code reads. Derived f=
rom unc_c_tor_inserts.miss_opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "LLC_MISSES.CODE_LLC_PREFETCH",
+        "Filter": "filter_opc=3D0x191",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "LLC prefetch misses for code reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
+        "Filter": "filter_opc=3D0x191",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "LLC prefetch misses for data reads. Derived f=
rom unc_c_tor_inserts.miss_opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "LLC_MISSES.DATA_LLC_PREFETCH",
+        "Filter": "filter_opc=3D0x192",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "LLC prefetch misses for data reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
+        "Filter": "filter_opc=3D0x192",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "LLC misses for PCIe read current. Derived fro=
m unc_c_tor_inserts.miss_opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "LLC_MISSES.PCIE_READ",
+        "Filter": "filter_opc=3D0x19e",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "LLC misses for PCIe read current",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
+        "Filter": "filter_opc=3D0x19e",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ItoM write misses (as part of fast string mem=
cpy stores) + PCIe full line writes. Derived from unc_c_tor_inserts.miss_op=
code",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "LLC_MISSES.PCIE_WRITE",
+        "Filter": "filter_opc=3D0x1c8",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ItoM write misses (as part of fast string mem=
cpy stores) + PCIe full line writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
+        "Filter": "filter_opc=3D0x1c8",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "PCIe write misses (full cache line). Derived =
from unc_c_tor_inserts.miss_opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "LLC_MISSES.PCIE_NON_SNOOP_WRITE",
+        "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "PCIe write misses (full cache line)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
+        "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; NID and Opcode Matched",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
+        "PerPkg": "1",
+        "UMask": "0x41",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; NID Matched Evictions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; NID Matched",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
+        "PerPkg": "1",
+        "UMask": "0x48",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; NID Matched Writebacks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_WB",
+        "PerPkg": "1",
+        "UMask": "0x50",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; NID and Opcode Matched Miss",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
+        "PerPkg": "1",
+        "UMask": "0x43",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; NID Matched Miss All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
+        "PerPkg": "1",
+        "UMask": "0x4A",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Misses to Local Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x2A",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Misses to Remote Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x8A",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Local Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x28",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Remote Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x88",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Misses to Local Memory - Opcode =
Matched",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
+        "PerPkg": "1",
+        "UMask": "0x23",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Misses to Remote Memory - Opcode=
 Matched",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
+        "PerPkg": "1",
+        "UMask": "0x83",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Local Memory - Opcode Matched",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.LOCAL_OPCODE",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Remote Memory - Opcode Matched",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.REMOTE_OPCODE",
+        "PerPkg": "1",
+        "UMask": "0x81",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Opcode Match",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.OPCODE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Evictions",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.EVICTION",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Any",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Occupancy counter for LLC data reads (demand =
and L2 prefetch). Derived from unc_c_tor_occupancy.miss_opcode",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.LLC_DATA_READ",
+        "Filter": "filter_opc=3D0x182",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Occupancy counter for LLC data reads (demand =
and L2 prefetch)",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE",
+        "Filter": "filter_opc=3D0x182",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Miss All",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_ALL",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID and Opcode Matched",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_OPCODE",
+        "PerPkg": "1",
+        "UMask": "0x41",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID Matched Evictions",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_EVICTION",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID Matched",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_ALL",
+        "PerPkg": "1",
+        "UMask": "0x48",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID and Opcode Matched Miss",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_OPCODE",
+        "PerPkg": "1",
+        "UMask": "0x43",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID Matched",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_ALL",
+        "PerPkg": "1",
+        "UMask": "0x4A",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x2A",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x8A",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x28",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x88",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Misses to Local Memory - Opcod=
e Matched",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
+        "PerPkg": "1",
+        "UMask": "0x23",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Misses to Remote Memory - Opco=
de Matched",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
+        "PerPkg": "1",
+        "UMask": "0x83",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Local Memory - Opcode Matched"=
,
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.LOCAL_OPCODE",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Remote Memory - Opcode Matched=
",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.REMOTE_OPCODE",
+        "PerPkg": "1",
+        "UMask": "0x81",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Writebacks",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID Matched Writebacks",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_WB",
+        "PerPkg": "1",
+        "UMask": "0x50",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Onto AD Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_C_TxR_ADS_USED.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Onto AK Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_C_TxR_ADS_USED.AK",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Onto BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_C_TxR_ADS_USED.BL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; AD - Cachebo",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.AD_CACHE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; AK - Cachebo",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.AK_CACHE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; BL - Cacheno",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.BL_CACHE",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; IV - Cachebo",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.IV_CACHE",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; AD - Corebo",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.AD_CORE",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; AK - Corebo",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.AK_CORE",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; BL - Corebo",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.BL_CORE",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; Onto AK Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_C_TxR_STARVED.AK_BOTH",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; Onto BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_C_TxR_STARVED.BL_BOTH",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; Onto IV Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_C_TxR_STARVED.IV",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; Onto AD Ring (to core)"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_C_TxR_STARVED.AD_CORE",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; IRQ Rejected",
+        "EventCode": "0x11",
+        "EventName": "UNC_C_RxR_OCCUPANCY.IRQ_REJ",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Lines in S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.I_STATE",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "QPI Address/Opcode Match; Address & Opcode Ma=
tch",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_ADDR_OPC_MATCH.FILT",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "QPI Address/Opcode Match; Address",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_ADDR_OPC_MATCH.ADDR",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "QPI Address/Opcode Match; Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_ADDR_OPC_MATCH.OPC",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "QPI Address/Opcode Match; AD Opcodes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_ADDR_OPC_MATCH.AD",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "QPI Address/Opcode Match; BL Opcodes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_ADDR_OPC_MATCH.BL",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "QPI Address/Opcode Match; AK Opcodes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_ADDR_OPC_MATCH.AK",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT Cycles Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "UNC_H_BT_CYCLES_NE",
+        "PerPkg": "1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT to HT Not Issued; Incoming Snoop Hazard",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "UNC_H_BT_TO_HT_NOT_ISSUED.INCOMING_SNP_HAZARD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT to HT Not Issued; Incoming Data Hazard",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "UNC_H_BT_TO_HT_NOT_ISSUED.INCOMING_BL_HAZARD",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT to HT Not Issued; Incoming Data Hazard",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "UNC_H_BT_TO_HT_NOT_ISSUED.RSPACKCFLT_HAZARD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT to HT Not Issued; Incoming Data Hazard",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "UNC_H_BT_TO_HT_NOT_ISSUED.WBMDATA_HAZARD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Bypass; Taken",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_H_BYPASS_IMC.TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Bypass; Not Taken",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_H_BYPASS_IMC.NOT_TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "uclks",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_H_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Direct2Core Messages Sent",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_H_DIRECT2CORE_COUNT",
+        "PerPkg": "1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles when Direct2Core was Disabled",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_H_DIRECT2CORE_CYCLES_DISABLED",
+        "PerPkg": "1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Number of Reads that had Direct2Core Overridd=
en",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_H_DIRECT2CORE_TXN_OVERRIDE",
+        "PerPkg": "1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Lat Opt Return",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_H_DIRECTORY_LAT_OPT",
+        "PerPkg": "1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Lookups; Snoop Needed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC",
+        "EventName": "UNC_H_DIRECTORY_LOOKUP.SNP",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Lookups; Snoop Not Needed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC",
+        "EventName": "UNC_H_DIRECTORY_LOOKUP.NO_SNP",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Updates; Directory Set",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD",
+        "EventName": "UNC_H_DIRECTORY_UPDATE.SET",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Updates; Directory Clear",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD",
+        "EventName": "UNC_H_DIRECTORY_UPDATE.CLEAR",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Updates; Any Directory Update",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD",
+        "EventName": "UNC_H_DIRECTORY_UPDATE.ANY",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is R=
dCode, RdData, RdDataMigratory, RdInvOwn, RdCur or InvItoE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.READ_OR_INVITOE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is W=
bMtoI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.WBMTOI",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is A=
ckCnfltWbI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.ACKCNFLTWBI",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is W=
bMtoE or WbMtoS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.WBMTOE_OR_S",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is R=
spIFwd or RspIFwdWb for a remote request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.RSPFWDI_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is R=
spIFwd or RspIFwdWb for a local request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.RSPFWDI_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is R=
sSFwd or RspSFwdWb",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.RSPFWDS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is R=
spI, RspIWb, RspS, RspSWb, RspCnflt or RspCnfltWbI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.RSP",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; Allocat=
ions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.ALLOCS",
+        "PerPkg": "1",
+        "UMask": "0x70",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; Allocat=
ions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.EVICTS",
+        "PerPkg": "1",
+        "UMask": "0x42",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; Invalid=
ations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.INVALS",
+        "PerPkg": "1",
+        "UMask": "0x26",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; All Req=
uests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.ALL",
+        "PerPkg": "1",
+        "UMask": "0xFF",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; HOM Req=
uests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.HOM",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is RdCode, RdData, RdDataMigratory, RdInvOwn, RdCur or InvItoE=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.READ_OR_INVITOE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is WbMtoI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.WBMTOI",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is AckCnfltWbI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.ACKCNFLTWBI",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is WbMtoE or WbMtoS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.WBMTOE_OR_S",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is RspIFwd or RspIFwdWb for a remote request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.RSPFWDI_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is RspIFwd or RspIFwdWb for a local request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.RSPFWDI_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is RsSFwd or RspSFwdWb",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.RSPFWDS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is RspI, RspIWb, RspS, RspSWb, RspCnflt or RspCnfltWbI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.RSP",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; All Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.ALL",
+        "PerPkg": "1",
+        "UMask": "0xFF",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; HOM Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.HOM",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is RdCode, RdData, RdDataMigratory, RdInvOwn, RdCur or InvItoE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.READ_OR_INVITOE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is WbMtoI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.WBMTOI",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is AckCnfltWbI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.ACKCNFLTWBI",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is WbMtoE or WbMtoS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.WBMTOE_OR_S",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is RspIFwd or RspIFwdWb for a remote request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.RSPFWDI_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is RspIFwd or RspIFwdWb for a local request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.RSPFWDI_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is RsSFwd or RspSFwdWb",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.RSPFWDS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is RspI, RspIWb, RspS, RspSWb, RspCnflt or RspCnfltWbI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.RSP",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.ALLOCS",
+        "PerPkg": "1",
+        "UMask": "0x70",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; Invalidations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.INVALS",
+        "PerPkg": "1",
+        "UMask": "0x26",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; All Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.ALL",
+        "PerPkg": "1",
+        "UMask": "0xFF",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; HOM Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.HOM",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles without QPI Ingress Credits; AD to QPI=
 Link 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.AD_QPI0",
+        "PerPkg": "1",
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
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles without QPI Ingress Credits; BL to QPI=
 Link 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.AD_QPI2",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles without QPI Ingress Credits; BL to QPI=
 Link 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.BL_QPI2",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Normal Priority Reads Issued; Norma=
l Priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_H_IMC_READS.NORMAL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Retry Events",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_H_IMC_RETRY",
+        "PerPkg": "1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Full Line Writes Issued; Full Line =
Non-ISOCH",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_H_IMC_WRITES.FULL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Full Line Writes Issued; Partial No=
n-ISOCH",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_H_IMC_WRITES.PARTIAL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Full Line Writes Issued; ISOCH Full=
 Line",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_H_IMC_WRITES.FULL_ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Full Line Writes Issued; ISOCH Part=
ial",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_H_IMC_WRITES.PARTIAL_ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Full Line Writes Issued; All Writes=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_H_IMC_WRITES.ALL",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IOT Backpressure",
+        "Counter": "0,1,2",
+        "EventCode": "0x61",
+        "EventName": "UNC_H_IOT_BACKPRESSURE.SAT",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IOT Backpressure",
+        "Counter": "0,1,2",
+        "EventCode": "0x61",
+        "EventName": "UNC_H_IOT_BACKPRESSURE.HUB",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Lo",
+        "Counter": "0,1,2",
+        "EventCode": "0x64",
+        "EventName": "UNC_H_IOT_CTS_EAST_LO.CTS0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Lo",
+        "Counter": "0,1,2",
+        "EventCode": "0x64",
+        "EventName": "UNC_H_IOT_CTS_EAST_LO.CTS1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Hi",
+        "Counter": "0,1,2",
+        "EventCode": "0x65",
+        "EventName": "UNC_H_IOT_CTS_HI.CTS2",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Hi",
+        "Counter": "0,1,2",
+        "EventCode": "0x65",
+        "EventName": "UNC_H_IOT_CTS_HI.CTS3",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Lo",
+        "Counter": "0,1,2",
+        "EventCode": "0x62",
+        "EventName": "UNC_H_IOT_CTS_WEST_LO.CTS0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Lo",
+        "Counter": "0,1,2",
+        "EventCode": "0x62",
+        "EventName": "UNC_H_IOT_CTS_WEST_LO.CTS1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast; Local Reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_H_OSB.READS_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast; Local InvItoE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_H_OSB.INVITOE_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast; Remote",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_H_OSB.REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast; Cancelled",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_H_OSB.CANCELLED",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast; Reads Local -  Useful",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_H_OSB.READS_LOCAL_USEFUL",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast; Remote - Useful",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_H_OSB.REMOTE_USEFUL",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Early Data Return; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_H_OSB_EDR.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Early Data Return; Reads to Local  I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_H_OSB_EDR.READS_LOCAL_I",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Early Data Return; Reads to Remote I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_H_OSB_EDR.READS_REMOTE_I",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Early Data Return; Reads to Local S",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_H_OSB_EDR.READS_LOCAL_S",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Early Data Return; Reads to Remote S",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_H_OSB_EDR.READS_REMOTE_S",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.READS",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.WRITES",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Local Reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.READS_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Remote Reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.READS_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Local Writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.WRITES_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Remote Writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.WRITES_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Local InvItoEs",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.INVITOE_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Remote InvItoEs",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.INVITOE_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3E",
+        "EventName": "UNC_H_RING_AD_USED.CW_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3E",
+        "EventName": "UNC_H_RING_AD_USED.CW_ODD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3E",
+        "EventName": "UNC_H_RING_AD_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3E",
+        "EventName": "UNC_H_RING_AD_USED.CCW_ODD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Clockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3E",
+        "EventName": "UNC_H_RING_AD_USED.CW",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Counterclockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3E",
+        "EventName": "UNC_H_RING_AD_USED.CCW",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3F",
+        "EventName": "UNC_H_RING_AK_USED.CW_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3F",
+        "EventName": "UNC_H_RING_AK_USED.CW_ODD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3F",
+        "EventName": "UNC_H_RING_AK_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3F",
+        "EventName": "UNC_H_RING_AK_USED.CCW_ODD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Clockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3F",
+        "EventName": "UNC_H_RING_AK_USED.CW",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Counterclockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3F",
+        "EventName": "UNC_H_RING_AK_USED.CCW",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CW_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CW_ODD",
+        "PerPkg": "1",
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
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CCW_ODD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Clockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CW",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Counterclockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CCW",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Acquired; For AD Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x68",
+        "EventName": "UNC_H_SBO0_CREDITS_ACQUIRED.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Acquired; For BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x68",
+        "EventName": "UNC_H_SBO0_CREDITS_ACQUIRED.BL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Occupancy; For AD Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6A",
+        "EventName": "UNC_H_SBO0_CREDIT_OCCUPANCY.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Occupancy; For BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6A",
+        "EventName": "UNC_H_SBO0_CREDIT_OCCUPANCY.BL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "SBo1 Credits Acquired; For AD Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_H_SBO1_CREDITS_ACQUIRED.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "SBo1 Credits Acquired; For BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_H_SBO1_CREDITS_ACQUIRED.BL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "SBo1 Credits Occupancy; For AD Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6B",
+        "EventName": "UNC_H_SBO1_CREDIT_OCCUPANCY.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "SBo1 Credits Occupancy; For BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6B",
+        "EventName": "UNC_H_SBO1_CREDIT_OCCUPANCY.BL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Data beat the Snoop Responses; Local Requests=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_H_SNOOPS_RSP_AFTER_DATA.LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Data beat the Snoop Responses; Remote Request=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_H_SNOOPS_RSP_AFTER_DATA.REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles with Snoops Outstanding; Local Request=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_H_SNOOP_CYCLES_NE.LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles with Snoops Outstanding; Remote Reques=
ts",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_H_SNOOP_CYCLES_NE.REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles with Snoops Outstanding; All Requests"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_H_SNOOP_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Snoops Outstanding Accumulator; Local=
 Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_H_SNOOP_OCCUPANCY.LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Snoops Outstanding Accumulator; Remot=
e Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_H_SNOOP_OCCUPANCY.REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received; RspI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_SNOOP_RESP.RSPI",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Shared line response from remote cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_SNOOP_RESP.RSPS",
         "PerPkg": "1",
         "ScaleUnit": "64Bytes",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "M line forwarded from remote cache with no wr=
iteback to memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_SNOOP_RESP.RSPIFWD",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Shared line forwarded from remote cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received; Rsp*WB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_SNOOP_RESP.RSP_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "M line forwarded from remote cache along with=
 writeback to memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_SNOOP_RESP.RSP_FWD_WB",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received; RSPCNFLCT*",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_SNOOP_RESP.RSPCNFLCT",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; RspI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPI",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; RspS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPS",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; RspIFwd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPIFWD",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; RspSFwd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPSFWD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; Rsp*WB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPxWB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; Rsp*FWD*WB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPxFWDxWB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; RspCnflct",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPCNFLCT",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; Other",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.OTHER",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo0, AD Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6C",
+        "EventName": "UNC_H_STALL_NO_SBO_CREDIT.SBO0_AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo1, AD Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6C",
+        "EventName": "UNC_H_STALL_NO_SBO_CREDIT.SBO1_AD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo0, BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6C",
+        "EventName": "UNC_H_STALL_NO_SBO_CREDIT.SBO0_BL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo1, BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6C",
+        "EventName": "UNC_H_STALL_NO_SBO_CREDIT.SBO1_BL",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_H_TAD_REQUESTS_G1.REGION8",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_H_TAD_REQUESTS_G1.REGION9",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_H_TAD_REQUESTS_G1.REGION10",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_H_TAD_REQUESTS_G1.REGION11",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Full; Cycles GP Completely Use=
d",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_H_TRACKER_CYCLES_FULL.GP",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Full; Cycles Completely Used",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_H_TRACKER_CYCLES_FULL.ALL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy Accumultor; Local Read Requ=
ests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_H_TRACKER_OCCUPANCY.READS_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy Accumultor; Remote Read Req=
uests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_H_TRACKER_OCCUPANCY.READS_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy Accumultor; Local Write Req=
uests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_H_TRACKER_OCCUPANCY.WRITES_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy Accumultor; Remote Write Re=
quests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_H_TRACKER_OCCUPANCY.WRITES_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy Accumultor; Local InvItoE R=
equests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_H_TRACKER_OCCUPANCY.INVITOE_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy Accumultor; Remote InvItoE =
Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_H_TRACKER_OCCUPANCY.INVITOE_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Data Pending Occupancy Accumultor; Local Requ=
ests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_H_TRACKER_PENDING_OCCUPANCY.LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Data Pending Occupancy Accumultor; Remote Req=
uests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_H_TRACKER_PENDING_OCCUPANCY.REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Outbound NDR Ring Transactions; Non-data Resp=
onses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xF",
+        "EventName": "UNC_H_TxR_AD.HOM",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Full; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_H_TxR_AD_CYCLES_FULL.SCHED0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Full; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_H_TxR_AD_CYCLES_FULL.SCHED1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Full; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_H_TxR_AD_CYCLES_FULL.ALL",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Not Empty; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_H_TxR_AD_CYCLES_NE.SCHED0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Not Empty; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_H_TxR_AD_CYCLES_NE.SCHED1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Not Empty; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_H_TxR_AD_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Allocations; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_H_TxR_AD_INSERTS.SCHED0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Allocations; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_H_TxR_AD_INSERTS.SCHED1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Allocations; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_H_TxR_AD_INSERTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Full; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_H_TxR_AK_CYCLES_FULL.SCHED0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Full; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_H_TxR_AK_CYCLES_FULL.SCHED1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Full; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_H_TxR_AK_CYCLES_FULL.ALL",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Not Empty; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_H_TxR_AK_CYCLES_NE.SCHED0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Not Empty; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_H_TxR_AK_CYCLES_NE.SCHED1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Not Empty; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_H_TxR_AK_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Allocations; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_H_TxR_AK_INSERTS.SCHED0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Allocations; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_H_TxR_AK_INSERTS.SCHED1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Allocations; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_H_TxR_AK_INSERTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to Cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_H_TxR_BL.DRS_CACHE",
+        "PerPkg": "1",
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
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Full; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TxR_BL_CYCLES_FULL.SCHED0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Full; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TxR_BL_CYCLES_FULL.SCHED1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Full; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TxR_BL_CYCLES_FULL.ALL",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Not Empty; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_H_TxR_BL_CYCLES_NE.SCHED0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Not Empty; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_H_TxR_BL_CYCLES_NE.SCHED1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Not Empty; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_H_TxR_BL_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Allocations; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_H_TxR_BL_INSERTS.SCHED0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Allocations; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_H_TxR_BL_INSERTS.SCHED1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Allocations; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_H_TxR_BL_INSERTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Injection Starvation; For AK Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6D",
+        "EventName": "UNC_H_TxR_STARVED.AK",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Injection Starvation; For BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6D",
+        "EventName": "UNC_H_TxR_STARVED.BL",
+        "PerPkg": "1",
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
         "UMask": "0x8",
         "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Not Empty; Local Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_H_TRACKER_CYCLES_NE.LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Not Empty; Remote Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_H_TRACKER_CYCLES_NE.REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Not Empty; All Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_H_TRACKER_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
index 824961318c1e..3e48ff3516b0 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
@@ -1,16 +1,998 @@
 [
     {
-        "BriefDescription": "QPI clock ticks",
+        "BriefDescription": "Number of qfclks",
         "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_Q_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "QPI LL"
     },
+    {
+        "BriefDescription": "Count of CTO Events",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_CTO_COUNT",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Success",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.SUCCESS_RBT_HIT",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT I=
nvalid",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_HIT",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Invalid",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT M=
iss",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_MISS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Miss",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_MISS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT M=
iss and Invalid",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_MISS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Miss, Invalid",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT_MISS",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in L1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_Q_L1_POWER_CYCLES",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in L0p",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_Q_RxL0P_POWER_CYCLES",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in L0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xF",
+        "EventName": "UNC_Q_RxL0_POWER_CYCLES",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Bypassed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_Q_RxL_BYPASSED",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "CRC Errors Detected; LinkInit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_CRC_ERRORS.LINK_INIT",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "CRC Errors Detected; Normal Operations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_CRC_ERRORS.NORMAL_OP",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; DRS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; NCB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; NCS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; HOM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; SNP",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; NDR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NDR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; DRS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; NCB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; NCS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; HOM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; SNP",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; NDR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.NDR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VNA Credit Consumed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VNA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_Q_RxL_CYCLES_NE",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - DRS; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xF",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_DRS.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - DRS; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xF",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_DRS.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - HOM; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_HOM.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - HOM; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_HOM.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NCB; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NCB.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NCB; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NCB.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NCS; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NCS.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NCS; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NCS.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NDR; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NDR.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NDR; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NDR.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - SNP; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_SNP.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - SNP; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_SNP.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
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
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; SNP Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; HOM Request Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.HOM_REQ",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
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
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; HOM Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; DRS Data Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.DRS_DATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
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
+        "UMask": "0x10",
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
+        "UMask": "0x18",
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
+        "UMask": "0x2",
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
+        "UMask": "0x8",
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
+        "UMask": "0xC",
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
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_Q_RxL_INSERTS",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - DRS; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_Q_RxL_INSERTS_DRS.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - DRS; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_Q_RxL_INSERTS_DRS.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - HOM; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC",
+        "EventName": "UNC_Q_RxL_INSERTS_HOM.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - HOM; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC",
+        "EventName": "UNC_Q_RxL_INSERTS_HOM.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NCB; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_Q_RxL_INSERTS_NCB.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NCB; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_Q_RxL_INSERTS_NCB.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NCS; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB",
+        "EventName": "UNC_Q_RxL_INSERTS_NCS.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NCS; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB",
+        "EventName": "UNC_Q_RxL_INSERTS_NCS.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NDR; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE",
+        "EventName": "UNC_Q_RxL_INSERTS_NDR.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NDR; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE",
+        "EventName": "UNC_Q_RxL_INSERTS_NDR.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - SNP; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD",
+        "EventName": "UNC_Q_RxL_INSERTS_SNP.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - SNP; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD",
+        "EventName": "UNC_Q_RxL_INSERTS_SNP.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - All Packets",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB",
+        "EventName": "UNC_Q_RxL_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - DRS; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_DRS.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - DRS; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_DRS.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - HOM; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_HOM.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - HOM; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_HOM.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NCB; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NCB.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NCB; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NCB.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NCS; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NCS.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NCS; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NCS.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NDR; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NDR.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NDR; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NDR.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - SNP; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_SNP.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - SNP; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_SNP.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - H=
OM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - S=
NP",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
DR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - D=
RS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
CB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
CS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_NDR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; Egress Credit=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.EGRESS_CREDITS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; GV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.GV",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - H=
OM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3A",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - S=
NP",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3A",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
DR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3A",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - D=
RS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3A",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
CB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3A",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
CS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3A",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_NDR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in L0p",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD",
+        "EventName": "UNC_Q_TxL0P_POWER_CYCLES",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in L0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC",
+        "EventName": "UNC_Q_TxL0_POWER_CYCLES",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Bypassed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_Q_TxL_BYPASSED",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is fu=
ll",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_TxL_CRC_NO_CREDITS.FULL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is al=
most full",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_TxL_CRC_NO_CREDITS.ALMOST_FULL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Cycles not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_Q_TxL_CYCLES_NE",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
     {
         "BriefDescription": "Number of data flits transmitted . Derived fr=
om unc_q_txl_flits_g0.data",
         "Counter": "0,1,2,3",
-        "EventName": "QPI_DATA_BANDWIDTH_TX",
+        "EventName": "QPI_DATA_BANDWIDTH_TX",
+        "PerPkg": "1",
+        "ScaleUnit": "8Bytes",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Number of data flits transmitted ",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
         "PerPkg": "1",
         "ScaleUnit": "8Bytes",
         "UMask": "0x2",
@@ -24,5 +1006,449 @@
         "ScaleUnit": "8Bytes",
         "UMask": "0x4",
         "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Number of non data (control) flits transmitte=
d ",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
+        "PerPkg": "1",
+        "ScaleUnit": "8Bytes",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; HOM Request Flit=
s",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; HOM Non-Request =
Flits",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
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
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; DRS Flits (both =
Header and Data)",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x18",
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
+        "UMask": "0x2",
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
+        "UMask": "0x8",
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
+        "UMask": "0xC",
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
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_Q_TxL_INSERTS",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_Q_TxL_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - HOM; for VN0"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_ACQUIRED.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - HOM; for VN1"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_ACQUIRED.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD HOM; for V=
N0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_OCCUPANCY.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD HOM; for V=
N1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_OCCUPANCY.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_ACQUIRED.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_ACQUIRED.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_OCCUPANCY.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_OCCUPANCY.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - SNP; for VN0"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_ACQUIRED.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - SNP; for VN1"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_ACQUIRED.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD SNP; for V=
N0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_OCCUPANCY.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD SNP; for V=
N1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_OCCUPANCY.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_ACQUIRED",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_OCCUPANCY",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for VN0"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_ACQUIRED.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for VN1"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_ACQUIRED.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for Shar=
ed VN",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_ACQUIRED.VN_SHR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for V=
N0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_OCCUPANCY.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for V=
N1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_OCCUPANCY.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for S=
hared VN",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_OCCUPANCY.VN_SHR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - NCB; for VN0"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_ACQUIRED.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - NCB; for VN1"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_ACQUIRED.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCB; for V=
N0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_OCCUPANCY.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCB; for V=
N1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_OCCUPANCY.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - NCS; for VN0"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_ACQUIRED.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - NCS; for VN1"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_ACQUIRED.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCS; for V=
N0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_OCCUPANCY.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCS; for V=
N1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_OCCUPANCY.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VNA Credits Returned",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_Q_VNA_CREDIT_RETURNS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VNA Credits Pending Return - Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_Q_VNA_CREDIT_RETURN_OCCUPANCY",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "Unit": "QPI LL"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json b/t=
ools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
index 66eed399724c..db3418db312e 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
@@ -1,4 +1,76 @@
 [
+    {
+        "BriefDescription": "DRAM Activate Count; Activate due to Read",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_M_ACT_COUNT.RD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Activate Count; Activate due to Write",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_M_ACT_COUNT.WR",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Activate Count; Activate due to Write",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_M_ACT_COUNT.BYP",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ACT command issued by 2 cycle bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M_BYP_CMDS.ACT",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CAS command issued by 2 cycle bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M_BYP_CMDS.CAS",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "PRE command issued by 2 cycle bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M_BYP_CMDS.PRE",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM RD=
_CAS (w/ and w/out auto-pre)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.RD_REG",
+        "PerPkg": "1",
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
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "read requests to memory controller. Derived f=
rom unc_m_cas_count.rd",
         "Counter": "0,1,2,3",
@@ -9,6 +81,34 @@
         "UMask": "0x3",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "read requests to memory controller",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.RD",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; DRAM WR_CAS=
 (w/ and w/out auto-pre) in Write Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.WR_WMM",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; DRAM WR_CAS=
 (w/ and w/out auto-pre) in Read Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.WR_RMM",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "write requests to memory controller. Derived =
from unc_m_cas_count.wr",
         "Counter": "0,1,2,3",
@@ -20,44 +120,323 @@
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Memory controller clock ticks",
+        "BriefDescription": "write requests to memory controller",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.WR",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM WR=
_CAS (w/ and w/out auto-pre)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.ALL",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; Read CAS is=
sued in WMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.RD_WMM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; Read CAS is=
sued in RMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.RD_RMM",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Clockticks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_M_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Cycles where DRAM ranks are in power down (CK=
E) mode",
+        "BriefDescription": "DRAM Precharge All Commands",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_M_DRAM_PRE_ALL",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_M_DRAM_REFRESH.PANIC",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_M_DRAM_REFRESH.HIGH",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ECC Correctable Errors",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_M_ECC_CORRECTABLE_ERRORS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Cycles in a Major Mode; Read Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_M_MAJOR_MODES.READ",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Cycles in a Major Mode; Write Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_M_MAJOR_MODES.WRITE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Cycles in a Major Mode; Partial Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_M_MAJOR_MODES.PARTIAL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Cycles in a Major Mode; Isoch Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_M_MAJOR_MODES.ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Channel DLLOFF Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_M_POWER_CHANNEL_DLLOFF",
+        "PerPkg": "1",
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
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK7",
+        "PerPkg": "1",
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
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Cycles Memory is in self refresh power mode",
+        "BriefDescription": "UNC_M_POWER_PCU_THROTTLING",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "UNC_M_POWER_PCU_THROTTLING",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Clock-Enabled Self-Refresh",
         "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_M_POWER_SELF_REFRESH",
-        "MetricExpr": "(UNC_M_POWER_SELF_REFRESH / UNC_M_CLOCKTICKS) * 100=
.",
-        "MetricName": "power_self_refresh %",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Pre-charges due to page misses",
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK7",
+        "PerPkg": "1",
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
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands.; Precharges due to p=
age miss",
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.PAGE_MISS",
@@ -66,7 +445,16 @@
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Pre-charge for reads",
+        "BriefDescription": "DRAM Precharge commands.; Precharge due to ti=
mer expiration",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_M_PRE_COUNT.PAGE_CLOSE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands.; Precharge due to re=
ad",
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.RD",
@@ -75,12 +463,2437 @@
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Pre-charge for writes",
+        "BriefDescription": "DRAM Precharge commands.; Precharge due to wr=
ite",
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.WR",
         "PerPkg": "1",
         "UMask": "0x8",
         "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands.; Precharge due to by=
pass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_M_PRE_COUNT.BYP",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS issued with LOW priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M_RD_CAS_PRIO.LOW",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS issued with MEDIUM priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M_RD_CAS_PRIO.MED",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS issued with HIGH priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M_RD_CAS_PRIO.HIGH",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS issued with PANIC NON ISOCH priority=
 (starved)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M_RD_CAS_PRIO.PANIC",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_M_RPQ_CYCLES_NE",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "VMSE MXB write buffer occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_M_VMSE_MXB_WR_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "VMSE WR PUSH issued; VMSE write PUSH issued i=
n WMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_M_VMSE_WR_PUSH.WMM",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "VMSE WR PUSH issued; VMSE write PUSH issued i=
n RMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_M_VMSE_WR_PUSH.RMM",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold; Transition from WMM to RMM because of starve counter",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_M_WMM_TO_RMM.LOW_THRESH",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_M_WMM_TO_RMM.STARVE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_M_WMM_TO_RMM.VMSE_RETRY",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Full Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_M_WPQ_CYCLES_NE",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_M_WPQ_READ_HIT",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_M_WPQ_WRITE_HIT",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Not getting the requested Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_M_WRONG_MM",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Clockticks",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_M_DCLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "iMC"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-other.json b/to=
ols/perf/pmu-events/arch/x86/haswellx/uncore-other.json
new file mode 100644
index 000000000000..135b59f34f37
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-other.json
@@ -0,0 +1,3170 @@
+[
+    {
+        "BriefDescription": "Total Write Cache Occupancy; Any Source",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Total Write Cache Occupancy; Select Source",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.SOURCE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Clocks in the IRP",
+        "Counter": "0,1",
+        "EventName": "UNC_I_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; PCIRdCur",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.PCIRDCUR",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; CRd",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.CRD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; DRd",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.DRD",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; RFO",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.RFO",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; PCIItoM",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.PCITOM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; PCIDCAHin5t",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.PCIDCAHINT",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; WbMtoI",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.WBMTOI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; CLFlush",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.CLFLUSH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Fastpath Requests",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.FAST_REQ",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Fastpath Rejects",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.FAST_REJ",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Read Tr=
ansactions as Secondary",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.2ND_RD_INSERT",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Write T=
ransactions as Secondary",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.2ND_WR_INSERT",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Atomic =
Transactions as Secondary",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.2ND_ATOMIC_INSERT",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Fastpath Transfers From =
Primary to Secondary",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.FAST_XFER",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Prefetch Ack Hints From =
Primary to Secondary",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.PF_ACK_HINT",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of I Line"=
,
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SLOW_I",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of S Line"=
,
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SLOW_S",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of E Line"=
,
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SLOW_E",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of M Line"=
,
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SLOW_M",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.LOST_FWD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Received Invalid",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SEC_RCVD_INVLD",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Received Valid",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SEC_RCVD_VLD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Data Throttled",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.DATA_THROTTLE",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "AK Ingress Occupancy",
+        "Counter": "0,1",
+        "EventCode": "0xA",
+        "EventName": "UNC_I_RxR_AK_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
+        "Counter": "0,1",
+        "EventCode": "0x4",
+        "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL Ingress Occupancy - DRS",
+        "Counter": "0,1",
+        "EventCode": "0x1",
+        "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "UNC_I_RxR_BL_DRS_OCCUPANCY",
+        "Counter": "0,1",
+        "EventCode": "0x7",
+        "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
+        "Counter": "0,1",
+        "EventCode": "0x5",
+        "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL Ingress Occupancy - NCB",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "UNC_I_RxR_BL_NCB_OCCUPANCY",
+        "Counter": "0,1",
+        "EventCode": "0x8",
+        "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
+        "Counter": "0,1",
+        "EventCode": "0x6",
+        "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL Ingress Occupancy - NCS",
+        "Counter": "0,1",
+        "EventCode": "0x3",
+        "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "UNC_I_RxR_BL_NCS_OCCUPANCY",
+        "Counter": "0,1",
+        "EventCode": "0x9",
+        "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; Miss",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.MISS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; Hit I",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_I",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; Hit E or S",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_ES",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; Hit M",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_M",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; SnpCode",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.SNPCODE",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; SnpData",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.SNPDATA",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; SnpInv",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.SNPINV",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Reads",
+        "Counter": "0,1",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.READS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Writes",
+        "Counter": "0,1",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.WRITES",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Read Prefetches",
+        "Counter": "0,1",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.RD_PREF",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Write Prefetches",
+        "Counter": "0,1",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Atomic",
+        "Counter": "0,1",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.ATOMIC",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Other",
+        "Counter": "0,1",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.OTHER",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Select Source",
+        "Counter": "0,1",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.ORDERINGQ",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "No AD Egress Credit Stalls",
+        "Counter": "0,1",
+        "EventCode": "0x18",
+        "EventName": "UNC_I_TxR_AD_STALL_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "No BL Egress Credit Stalls",
+        "Counter": "0,1",
+        "EventCode": "0x19",
+        "EventName": "UNC_I_TxR_BL_STALL_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Read Requests",
+        "Counter": "0,1",
+        "EventCode": "0xE",
+        "EventName": "UNC_I_TxR_DATA_INSERTS_NCB",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Read Requests",
+        "Counter": "0,1",
+        "EventCode": "0xF",
+        "EventName": "UNC_I_TxR_DATA_INSERTS_NCS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Request Queue Occupancy",
+        "Counter": "0,1",
+        "EventCode": "0xD",
+        "EventName": "UNC_I_TxR_REQUEST_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Prefetch TimeOut",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.PF_TIMEOUT",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Number of uclks in domain",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_R2_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "UNC_R2_IIO_CREDIT.PRQ_QPI0",
+        "Counter": "0,1",
+        "EventCode": "0x2D",
+        "EventName": "UNC_R2_IIO_CREDIT.PRQ_QPI0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "UNC_R2_IIO_CREDIT.PRQ_QPI1",
+        "Counter": "0,1",
+        "EventCode": "0x2D",
+        "EventName": "UNC_R2_IIO_CREDIT.PRQ_QPI1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "UNC_R2_IIO_CREDIT.ISOCH_QPI0",
+        "Counter": "0,1",
+        "EventCode": "0x2D",
+        "EventName": "UNC_R2_IIO_CREDIT.ISOCH_QPI0",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "UNC_R2_IIO_CREDIT.ISOCH_QPI1",
+        "Counter": "0,1",
+        "EventCode": "0x2D",
+        "EventName": "UNC_R2_IIO_CREDIT.ISOCH_QPI1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credit Acquired; DRS",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.DRS",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credit Acquired; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credit Acquired; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credits in Use; DRS",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_R2_IIO_CREDITS_USED.DRS",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credits in Use; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_R2_IIO_CREDITS_USED.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credits in Use; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_R2_IIO_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_ODD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_ODD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "AK Ingress Bounced; Up",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_R2_RING_AK_BOUNCES.UP",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "AK Ingress Bounced; Dn",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_R2_RING_AK_BOUNCES.DN",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_ODD",
+        "PerPkg": "1",
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
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_ODD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_ODD",
+        "PerPkg": "1",
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
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_ODD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Clockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_R2_RING_IV_USED.CW",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Counterclockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_R2_RING_IV_USED.CCW",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Any",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_R2_RING_IV_USED.ANY",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R2_RxR_CYCLES_NE.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R2_RxR_CYCLES_NE.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R2_RxR_INSERTS.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R2_RxR_INSERTS.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; DRS",
+        "EventCode": "0x13",
+        "EventName": "UNC_R2_RxR_OCCUPANCY.DRS",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Acquired; For AD Ring",
+        "Counter": "0,1",
+        "EventCode": "0x28",
+        "EventName": "UNC_R2_SBO0_CREDITS_ACQUIRED.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Acquired; For BL Ring",
+        "Counter": "0,1",
+        "EventCode": "0x28",
+        "EventName": "UNC_R2_SBO0_CREDITS_ACQUIRED.BL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Occupancy; For AD Ring",
+        "EventCode": "0x2A",
+        "EventName": "UNC_R2_SBO0_CREDIT_OCCUPANCY.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Occupancy; For BL Ring",
+        "EventCode": "0x2A",
+        "EventName": "UNC_R2_SBO0_CREDIT_OCCUPANCY.BL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo0, AD Ring",
+        "Counter": "0,1",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO0_AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo1, AD Ring",
+        "Counter": "0,1",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO1_AD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo0, BL Ring",
+        "Counter": "0,1",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO0_BL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo1, BL Ring",
+        "Counter": "0,1",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO1_BL",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; AD",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; AK",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.AK",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; BL",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.BL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Not Empty; AD",
+        "EventCode": "0x23",
+        "EventName": "UNC_R2_TxR_CYCLES_NE.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Not Empty; AK",
+        "EventCode": "0x23",
+        "EventName": "UNC_R2_TxR_CYCLES_NE.AK",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Not Empty; BL",
+        "EventCode": "0x23",
+        "EventName": "UNC_R2_TxR_CYCLES_NE.BL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; AD CCW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.DN_AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; BL CCW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.DN_BL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; AK CCW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.DN_AK",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; AK CCW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.UP_AD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; BL CCW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.UP_BL",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; BL CW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.UP_AK",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Number of uclks in domain",
+        "Counter": "0,1,2",
+        "EventCode": "0x1",
+        "EventName": "UNC_R3_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x1F",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO8",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x1F",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO9",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x1F",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO10",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x1F",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO11",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x1F",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO12",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x1F",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO13",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x1F",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO14_16",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x1F",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO_15_17",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x22",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "HA/R2 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2D",
+        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.HA0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "HA/R2 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2D",
+        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.HA1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "HA/R2 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2D",
+        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.R2_NCB",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "HA/R2 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2D",
+        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.R2_NCS",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "IOT Backpressure",
+        "Counter": "0,1,2",
+        "EventCode": "0xB",
+        "EventName": "UNC_R3_IOT_BACKPRESSURE.SAT",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "IOT Backpressure",
+        "Counter": "0,1,2",
+        "EventCode": "0xB",
+        "EventName": "UNC_R3_IOT_BACKPRESSURE.HUB",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Hi",
+        "Counter": "0,1,2",
+        "EventCode": "0xD",
+        "EventName": "UNC_R3_IOT_CTS_HI.CTS2",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Hi",
+        "Counter": "0,1,2",
+        "EventCode": "0xD",
+        "EventName": "UNC_R3_IOT_CTS_HI.CTS3",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Lo",
+        "Counter": "0,1,2",
+        "EventCode": "0xC",
+        "EventName": "UNC_R3_IOT_CTS_LO.CTS0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Lo",
+        "Counter": "0,1,2",
+        "EventCode": "0xC",
+        "EventName": "UNC_R3_IOT_CTS_LO.CTS1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_HOM",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_SNP",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_NDR",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_HOM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x20",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_NDR",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x21",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x21",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_HOM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x21",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x21",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_NDR",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2E",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2E",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_HOM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2E",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2E",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_NDR",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2F",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2F",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_HOM",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2F",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_SNP",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2F",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_NDR",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2F",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_HOM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2F",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2F",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_NDR",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CW_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CW_ODD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CCW_ODD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Clockwise",
+        "Counter": "0,1,2",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CW",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Counterclockwise",
+        "Counter": "0,1,2",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CCW",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CW_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CW_ODD",
+        "PerPkg": "1",
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
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CCW_ODD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Clockwise",
+        "Counter": "0,1,2",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CW",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Counterclockwise",
+        "Counter": "0,1,2",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CCW",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CW_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CW_ODD",
+        "PerPkg": "1",
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
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CCW_ODD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Clockwise",
+        "Counter": "0,1,2",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CW",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Counterclockwise",
+        "Counter": "0,1,2",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CCW",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 IV Ring in Use; Clockwise",
+        "Counter": "0,1,2",
+        "EventCode": "0xA",
+        "EventName": "UNC_R3_RING_IV_USED.CW",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 IV Ring in Use; Any",
+        "Counter": "0,1,2",
+        "EventCode": "0xA",
+        "EventName": "UNC_R3_RING_IV_USED.ANY",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ring Stop Starved; AK",
+        "Counter": "0,1,2",
+        "EventCode": "0xE",
+        "EventName": "UNC_R3_RING_SINK_STARVED.AK",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; HOM",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.HOM",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; SNP",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.SNP",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NDR",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.NDR",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Cycles Not Empty; HOM",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.HOM",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Cycles Not Empty; SNP",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.SNP",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Cycles Not Empty; NDR",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.NDR",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Cycles Not Empty; DRS",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.DRS",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Cycles Not Empty; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Cycles Not Empty; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_R3_RxR_CYCLES_NE_VN1.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; HOM",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.HOM",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; SNP",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.SNP",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NDR",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.NDR",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; DRS",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.DRS",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Allocations; HOM",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_R3_RxR_INSERTS_VN1.HOM",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Allocations; SNP",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_R3_RxR_INSERTS_VN1.SNP",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Allocations; NDR",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_R3_RxR_INSERTS_VN1.NDR",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Allocations; DRS",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_R3_RxR_INSERTS_VN1.DRS",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Allocations; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_R3_RxR_INSERTS_VN1.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Allocations; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_R3_RxR_INSERTS_VN1.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Occupancy Accumulator; HOM",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.HOM",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Occupancy Accumulator; SNP",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.SNP",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Occupancy Accumulator; NDR",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.NDR",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Occupancy Accumulator; DRS",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.DRS",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Occupancy Accumulator; NCB",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress Occupancy Accumulator; NCS",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY_VN1.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Acquired; For AD Ring",
+        "Counter": "0,1",
+        "EventCode": "0x28",
+        "EventName": "UNC_R3_SBO0_CREDITS_ACQUIRED.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Acquired; For BL Ring",
+        "Counter": "0,1",
+        "EventCode": "0x28",
+        "EventName": "UNC_R3_SBO0_CREDITS_ACQUIRED.BL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Occupancy; For AD Ring",
+        "EventCode": "0x2A",
+        "EventName": "UNC_R3_SBO0_CREDIT_OCCUPANCY.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Occupancy; For BL Ring",
+        "EventCode": "0x2A",
+        "EventName": "UNC_R3_SBO0_CREDIT_OCCUPANCY.BL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "SBo1 Credits Acquired; For AD Ring",
+        "Counter": "0,1",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_SBO1_CREDITS_ACQUIRED.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "SBo1 Credits Acquired; For BL Ring",
+        "Counter": "0,1",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_SBO1_CREDITS_ACQUIRED.BL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "SBo1 Credits Occupancy; For AD Ring",
+        "EventCode": "0x2B",
+        "EventName": "UNC_R3_SBO1_CREDIT_OCCUPANCY.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "SBo1 Credits Occupancy; For BL Ring",
+        "EventCode": "0x2B",
+        "EventName": "UNC_R3_SBO1_CREDIT_OCCUPANCY.BL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo0, AD Ring",
+        "Counter": "0,1",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R3_STALL_NO_SBO_CREDIT.SBO0_AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo1, AD Ring",
+        "Counter": "0,1",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R3_STALL_NO_SBO_CREDIT.SBO1_AD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo0, BL Ring",
+        "Counter": "0,1",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R3_STALL_NO_SBO_CREDIT.SBO0_BL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo1, BL Ring",
+        "Counter": "0,1",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R3_STALL_NO_SBO_CREDIT.SBO1_BL",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; AD CCW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK.DN_AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; BL CCW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK.DN_BL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; AK CCW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK.DN_AK",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; AK CCW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK.UP_AD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; BL CCW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK.UP_BL",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; BL CW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK.UP_AK",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; HOM Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.HOM",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; SNP Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.SNP",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NDR Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NDR",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; DRS Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCB Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
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
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; HOM Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.HOM",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; SNP Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.SNP",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; NDR Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.NDR",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; DRS Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.DRS",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; NCB Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; NCS Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; HOM Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.HOM",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; SNP Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.SNP",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NDR Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NDR",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; DRS Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NCB Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NCS Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; HOM Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.HOM",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; SNP Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.SNP",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; NDR Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.NDR",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; DRS Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.DRS",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; NCB Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; NCS Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA credit Acquisitions; HOM Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA credit Acquisitions; HOM Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.BL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; HOM Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.HOM",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; SNP Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.SNP",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; NDR Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NDR",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; DRS Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; NCB Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; NCS Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Bounce Control",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_S_BOUNCE_CONTROL",
+        "PerPkg": "1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Uncore Clocks",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_S_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "FaST wire asserted",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_S_FAST_ASSERTED",
+        "PerPkg": "1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Up and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_S_RING_AD_USED.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Up and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_S_RING_AD_USED.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Down and Event",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_S_RING_AD_USED.DOWN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Down and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_S_RING_AD_USED.DOWN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Up",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_S_RING_AD_USED.UP",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Down",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_S_RING_AD_USED.DOWN",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Up and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_S_RING_AK_USED.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Up and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_S_RING_AK_USED.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Down and Event",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_S_RING_AK_USED.DOWN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Down and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_S_RING_AK_USED.DOWN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Up",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_S_RING_AK_USED.UP",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Down",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_S_RING_AK_USED.DOWN",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Up and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_S_RING_BL_USED.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Up and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_S_RING_BL_USED.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Down and Event",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_S_RING_BL_USED.DOWN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Down and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_S_RING_BL_USED.DOWN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Up",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_S_RING_BL_USED.UP",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Down",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_S_RING_BL_USED.DOWN",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_S_RING_BOUNCES.AD_CACHE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Acknowledgements to core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_S_RING_BOUNCES.AK_CORE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Data Responses to core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_S_RING_BOUNCES.BL_CORE",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Snoops of processor's cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_S_RING_BOUNCES.IV_CORE",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Any",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_S_RING_IV_USED.UP",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Any",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_S_RING_IV_USED.DN",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "UNC_S_RING_SINK_STARVED.AD_CACHE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_S_RING_SINK_STARVED.AD_CACHE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "UNC_S_RING_SINK_STARVED.AK_CORE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_S_RING_SINK_STARVED.AK_CORE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "UNC_S_RING_SINK_STARVED.BL_CORE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_S_RING_SINK_STARVED.BL_CORE",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "UNC_S_RING_SINK_STARVED.IV_CORE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_S_RING_SINK_STARVED.IV_CORE",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; AD - Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_S_RxR_BUSY_STARVED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; AD - Bounces",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_S_RxR_BUSY_STARVED.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; BL - Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_S_RxR_BUSY_STARVED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; BL - Bounces",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_S_RxR_BUSY_STARVED.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Bypass; AD - Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_S_RxR_BYPASS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Bypass; AD - Bounces",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_S_RxR_BYPASS.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Bypass; BL - Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_S_RxR_BYPASS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Bypass; BL - Bounces",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_S_RxR_BYPASS.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Bypass; AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_S_RxR_BYPASS.AK",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Bypass; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_S_RxR_BYPASS.IV",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; AD - Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_S_RxR_CRD_STARVED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; AD - Bounces",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_S_RxR_CRD_STARVED.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; BL - Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_S_RxR_CRD_STARVED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; BL - Bounces",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_S_RxR_CRD_STARVED.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_S_RxR_CRD_STARVED.AK",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_S_RxR_CRD_STARVED.IV",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; IVF Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_S_RxR_CRD_STARVED.IFV",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; AD - Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_S_RxR_INSERTS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; AD - Bounces",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_S_RxR_INSERTS.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; BL - Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_S_RxR_INSERTS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; BL - Bounces",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_S_RxR_INSERTS.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_S_RxR_INSERTS.AK",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_S_RxR_INSERTS.IV",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; AD - Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_S_RxR_OCCUPANCY.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; AD - Bounces",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_S_RxR_OCCUPANCY.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; BL - Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_S_RxR_OCCUPANCY.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; BL - Bounces",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_S_RxR_OCCUPANCY.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_S_RxR_OCCUPANCY.AK",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_S_RxR_OCCUPANCY.IV",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "UNC_S_TxR_ADS_USED.AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_S_TxR_ADS_USED.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "UNC_S_TxR_ADS_USED.AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_S_TxR_ADS_USED.AK",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "UNC_S_TxR_ADS_USED.BL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_S_TxR_ADS_USED.BL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; AD - Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_S_TxR_INSERTS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; AD - Bounces",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_S_TxR_INSERTS.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; BL - Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_S_TxR_INSERTS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; BL - Bounces",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_S_TxR_INSERTS.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_S_TxR_INSERTS.AK",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_S_TxR_INSERTS.IV",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Egress Occupancy; AD - Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_S_TxR_OCCUPANCY.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Egress Occupancy; AD - Bounces",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_S_TxR_OCCUPANCY.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Egress Occupancy; BL - Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_S_TxR_OCCUPANCY.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Egress Occupancy; BL - Bounces",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_S_TxR_OCCUPANCY.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Egress Occupancy; AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_S_TxR_OCCUPANCY.AK",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Egress Occupancy; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_S_TxR_OCCUPANCY.IV",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; Onto AD Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_S_TxR_STARVED.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; Onto AK Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_S_TxR_STARVED.AK",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; Onto BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_S_TxR_STARVED.BL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; Onto IV Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_S_TxR_STARVED.IV",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "SBO"
+    },
+    {
+        "BriefDescription": "VLW Received",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.DOORBELL_RCVD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Filter Match",
+        "Counter": "0,1",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.ENABLE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Filter Match",
+        "Counter": "0,1",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.DISABLE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Filter Match",
+        "Counter": "0,1",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.U2C_ENABLE",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Filter Match",
+        "Counter": "0,1",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.U2C_DISABLE",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Cycles PHOLD Assert to Ack; Assert to ACK",
+        "Counter": "0,1",
+        "EventCode": "0x45",
+        "EventName": "UNC_U_PHOLD_CYCLES.ASSERT_TO_ACK",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "RACU Request",
+        "Counter": "0,1",
+        "EventCode": "0x46",
+        "EventName": "UNC_U_RACU_REQUESTS",
+        "PerPkg": "1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Monitor T0",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Monitor T1",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Livelock",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.LIVELOCK",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; LTError",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.LTERROR",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Correctable Machine Check=
",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.CMC",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Uncorrectable Machine Che=
ck",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.UMC",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Trap",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.TRAP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Other",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.OTHER",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "UNC_U_CLOCKTICKS",
+        "Counter": "0,1",
+        "EventName": "UNC_U_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "UBOX"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json b/to=
ols/perf/pmu-events/arch/x86/haswellx/uncore-power.json
index dd1b95655d1d..86b7c22af96b 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
@@ -1,91 +1,496 @@
 [
     {
-        "BriefDescription": "PCU clock ticks. Use to get percentages of PC=
U cycles events",
+        "BriefDescription": "pclk Cycles",
         "Counter": "0,1,2,3",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "This is an occupancy event that tracks the nu=
mber of cores that are in C0.  It can be used by itself to get the average =
number of cores in C0, with threshholding to generate histograms, or with o=
ther PCU events and occupancy triggering to capture other details",
+        "BriefDescription": "Core C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
-        "Filter": "occ_sel=3D1",
-        "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C0 / UNC_P_CLOCK=
TICKS) * 100.",
-        "MetricName": "power_state_occupancy.cores_c0 %",
+        "EventCode": "0x60",
+        "EventName": "UNC_P_CORE0_TRANSITION_CYCLES",
         "PerPkg": "1",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "This is an occupancy event that tracks the nu=
mber of cores that are in C3.  It can be used by itself to get the average =
number of cores in C0, with threshholding to generate histograms, or with o=
ther PCU events and occupancy triggering to capture other details",
+        "BriefDescription": "Core C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
-        "Filter": "occ_sel=3D2",
-        "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C3 / UNC_P_CLOCK=
TICKS) * 100.",
-        "MetricName": "power_state_occupancy.cores_c3 %",
+        "EventCode": "0x6A",
+        "EventName": "UNC_P_CORE10_TRANSITION_CYCLES",
         "PerPkg": "1",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "This is an occupancy event that tracks the nu=
mber of cores that are in C6.  It can be used by itself to get the average =
number of cores in C0, with threshholding to generate histograms, or with o=
ther PCU events ",
+        "BriefDescription": "Core C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
-        "Filter": "occ_sel=3D3",
-        "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C6 / UNC_P_CLOCK=
TICKS) * 100.",
-        "MetricName": "power_state_occupancy.cores_c6 %",
+        "EventCode": "0x6B",
+        "EventName": "UNC_P_CORE11_TRANSITION_CYCLES",
         "PerPkg": "1",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that we are in ex=
ternal PROCHOT mode.  This mode is triggered when a sensor off the die dete=
rmines that something off-die (like DRAM) is too hot and must throttle to a=
void damaging the chip",
+        "BriefDescription": "Core C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xA",
-        "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
-        "MetricExpr": "(UNC_P_PROCHOT_EXTERNAL_CYCLES / UNC_P_CLOCKTICKS) =
* 100.",
-        "MetricName": "prochot_external_cycles %",
+        "EventCode": "0x6C",
+        "EventName": "UNC_P_CORE12_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6D",
+        "EventName": "UNC_P_CORE13_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6E",
+        "EventName": "UNC_P_CORE14_TRANSITION_CYCLES",
         "PerPkg": "1",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles when temperature =
is the upper limit on frequency",
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6F",
+        "EventName": "UNC_P_CORE15_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_P_CORE16_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_P_CORE17_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x61",
+        "EventName": "UNC_P_CORE1_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x62",
+        "EventName": "UNC_P_CORE2_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x63",
+        "EventName": "UNC_P_CORE3_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x64",
+        "EventName": "UNC_P_CORE4_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x65",
+        "EventName": "UNC_P_CORE5_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x66",
+        "EventName": "UNC_P_CORE6_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x67",
+        "EventName": "UNC_P_CORE7_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x68",
+        "EventName": "UNC_P_CORE8_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_P_CORE9_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_P_DEMOTIONS_CORE0",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_P_DEMOTIONS_CORE1",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3A",
+        "EventName": "UNC_P_DEMOTIONS_CORE10",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3B",
+        "EventName": "UNC_P_DEMOTIONS_CORE11",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_P_DEMOTIONS_CORE12",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3D",
+        "EventName": "UNC_P_DEMOTIONS_CORE13",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3E",
+        "EventName": "UNC_P_DEMOTIONS_CORE14",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3F",
+        "EventName": "UNC_P_DEMOTIONS_CORE15",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_P_DEMOTIONS_CORE16",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_P_DEMOTIONS_CORE17",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_P_DEMOTIONS_CORE2",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_P_DEMOTIONS_CORE3",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_P_DEMOTIONS_CORE4",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_P_DEMOTIONS_CORE5",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x36",
+        "EventName": "UNC_P_DEMOTIONS_CORE6",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_P_DEMOTIONS_CORE7",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_P_DEMOTIONS_CORE8",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_P_DEMOTIONS_CORE9",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Frequency Residency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB",
+        "EventName": "UNC_P_FREQ_BAND0_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Frequency Residency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC",
+        "EventName": "UNC_P_FREQ_BAND1_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Frequency Residency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD",
+        "EventName": "UNC_P_FREQ_BAND2_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Frequency Residency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE",
+        "EventName": "UNC_P_FREQ_BAND3_CYCLES",
+        "PerPkg": "1",
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
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles when current is t=
he upper limit on frequency",
+        "BriefDescription": "IO P Limit Strongest Lower Limit Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x73",
+        "EventName": "UNC_P_FREQ_MIN_IO_P_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Cycles spent changing Frequency",
         "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "UNC_P_FREQ_TRANS_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_TRANS_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_trans_cycles %",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Memory Phase Shedding Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_P_MEMORY_PHASE_SHEDDING_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_P_PKG_RESIDENCY_C0_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C2E",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_P_PKG_RESIDENCY_C2E_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_P_PKG_RESIDENCY_C3_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2D",
+        "EventName": "UNC_P_PKG_RESIDENCY_C6_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C7 State Residency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_P_PKG_RESIDENCY_C7_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C-State; C0 and C1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C-State; C3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C-State; C6 and C7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "External Prochot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Internal Prochot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Total Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_P_TOTAL_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "UNC_P_UFS_TRANSITIONS_NO_CHANGE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x79",
+        "EventName": "UNC_P_UFS_TRANSITIONS_NO_CHANGE",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "VR Hot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "UNC_P_VR_HOT_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C1E",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4E",
+        "EventName": "UNC_P_PKG_RESIDENCY_C1E_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "UNC_P_UFS_TRANSITIONS_RING_GV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x79",
+        "EventName": "UNC_P_UFS_TRANSITIONS_RING_GV",
         "PerPkg": "1",
         "Unit": "PCU"
     }
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/virtual-memory.json b/=
tools/perf/pmu-events/arch/x86/haswellx/virtual-memory.json
index ba3e77a9f9a0..57d2a6452fec 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/virtual-memory.json
@@ -481,4 +481,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 66d54c879a3e..41c0c694211a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -9,7 +9,7 @@ GenuineIntel-6-96,v1.03,elkhartlake,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-(3C|45|46),v31,haswell,core
-GenuineIntel-6-3F,v17,haswellx,core
+GenuineIntel-6-3F,v25,haswellx,core
 GenuineIntel-6-3A,v18,ivybridge,core
 GenuineIntel-6-3E,v19,ivytown,core
 GenuineIntel-6-2D,v20,jaketown,core
--=20
2.37.1.359.gd136c6c3e2-goog

