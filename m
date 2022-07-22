Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339D757E9C6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiGVWfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbiGVWeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:34:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362DDA6FBF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u6-20020a25b7c6000000b00670862c5b16so4623867ybj.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=F7anhDm8PebwjhvNggkNBLJBN7ZTJKCSCzip1erQYE4=;
        b=suYtYUWuf5+bY5Li70jt5YkU1HupWwFX+hUE0RAg+XBoQGxiHXGjmUf0Qi0mA4wn8K
         FwWB96YePh1p9tFnZVBmwAuMvAO+NDiSVsN3B21PKaLEC0+DOuz+EKCRGobnRdGVChOM
         +cURsPJfPaCy/4CnTFXAe7DpddGgdxK68FvzroI+n+Ht4JDfCUI0+wvCj7UgYT6dy+oP
         xOAQkEZbeW1ZcjNm3NYz8XfNYh8BIEfEaozHbF8MhReQQ0+MvD6f0845Nf9V6Y4KOCBl
         zVgQanZwsH7n7jpZM1IPFl+b+CVnH4xGUPOcOiLGWjc17iMjrRHUQCgXF/6BGB1WKzWE
         nLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=F7anhDm8PebwjhvNggkNBLJBN7ZTJKCSCzip1erQYE4=;
        b=DKRvOfop+qk/p2nVpPqHGjsvxGKIwAky+8Ni0yhZWxUtHEs+l1MD1z0Hmf6DF1S5bB
         e7YuWZ+zo6Z4+yez5t2aNAc88stx1eGM2h26vNSadRuE4Xrs/xlpDu7MWDFfDmcC00hi
         V9eG6r2OjhhMJ1idIrm20Q9YjJI+5gnI/3hErZb1n5fMnPnTuzKy4KavJHOLD+DfxCjD
         nSEnG5hpGlMovshcFBVN199wVHg4RKBUs/Ba2EnDxROQvMKu9CEBdJ/WgFpry/oTPYka
         YzPX/WjL15yZP2nAphKrm9aoaR1FGvQD5wJ7nn2AaQCeszeXFPOfr8Gh1HoI9cg+Rj7H
         GaCw==
X-Gm-Message-State: AJIora8Xk1JslQ3OVtj/7wHVh7lk1WKxRBCZ+npnwGe1xhKMMWGryCSC
        pW1s361U49AnbH7L6Nz6qX9yQARTtxho
X-Google-Smtp-Source: AGRyM1uNVPVyv2ofcXlJOqA5vTUOxVuSN6+TiscxqTCPL++HeEiZl57zv4ZlE47HzcdCWBF/YjtV5dET97Nq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a05:6902:124e:b0:668:222c:e8da with SMTP
 id t14-20020a056902124e00b00668222ce8damr1759560ybu.383.1658529218493; Fri,
 22 Jul 2022 15:33:38 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:27 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-19-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 18/31] perf vendor events: Update Intel knightslanding
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
the knightslanding files into perf and update mapfile.csv.

Tested on a non-knightslanding with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Note: uncore-memory has become uncore-other as the topic was
determined this way in the conversion scripts. For simplicity the
scripts naming is maintained.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/knightslanding/cache.json        |    2 +-
 .../x86/knightslanding/floating-point.json    |    2 +-
 .../arch/x86/knightslanding/frontend.json     |    2 +-
 .../arch/x86/knightslanding/memory.json       |    2 +-
 .../arch/x86/knightslanding/pipeline.json     |    2 +-
 .../x86/knightslanding/uncore-memory.json     |   42 -
 .../arch/x86/knightslanding/uncore-other.json | 3890 +++++++++++++++++
 .../x86/knightslanding/virtual-memory.json    |    2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    3 +-
 9 files changed, 3897 insertions(+), 50 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/uncore-me=
mory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/uncore-ot=
her.json

diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json b/too=
ls/perf/pmu-events/arch/x86/knightslanding/cache.json
index 1bd50b186e93..5e10eabda300 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
@@ -2300,4 +2300,4 @@
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/floating-point.j=
son b/tools/perf/pmu-events/arch/x86/knightslanding/floating-point.json
index 5fce5020efa1..ff5db600e420 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/floating-point.json
@@ -26,4 +26,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/frontend.json b/=
tools/perf/pmu-events/arch/x86/knightslanding/frontend.json
index d075ab594d75..63343a0d1e86 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/frontend.json
@@ -55,4 +55,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/memory.json b/to=
ols/perf/pmu-events/arch/x86/knightslanding/memory.json
index 5e6ca6896af1..2611defaeaa2 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/memory.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/memory.json
@@ -1107,4 +1107,4 @@
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json b/=
tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
index 8f4213e5fbfd..1f13bc2686cb 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
@@ -374,4 +374,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.js=
on b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
deleted file mode 100644
index e3bcd86c4f56..000000000000
--- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
+++ /dev/null
@@ -1,42 +0,0 @@
-[
-    {
-        "BriefDescription": "ddr bandwidth read (CPU traffic only) (MB/sec=
). ",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x03",
-        "EventName": "UNC_M_CAS_COUNT.RD",
-        "PerPkg": "1",
-        "ScaleUnit": "6.4e-05MiB",
-        "UMask": "0x01",
-        "Unit": "imc"
-    },
-    {
-        "BriefDescription": "ddr bandwidth write (CPU traffic only) (MB/se=
c). ",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x03",
-        "EventName": "UNC_M_CAS_COUNT.WR",
-        "PerPkg": "1",
-        "ScaleUnit": "6.4e-05MiB",
-        "UMask": "0x02",
-        "Unit": "imc"
-    },
-    {
-        "BriefDescription": "mcdram bandwidth read (CPU traffic only) (MB/=
sec). ",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x01",
-        "EventName": "UNC_E_RPQ_INSERTS",
-        "PerPkg": "1",
-        "ScaleUnit": "6.4e-05MiB",
-        "UMask": "0x01",
-        "Unit": "edc_eclk"
-    },
-    {
-        "BriefDescription": "mcdram bandwidth write (CPU traffic only) (MB=
/sec). ",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x02",
-        "EventName": "UNC_E_WPQ_INSERTS",
-        "PerPkg": "1",
-        "ScaleUnit": "6.4e-05MiB",
-        "UMask": "0x01",
-        "Unit": "edc_eclk"
-    }
-]
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.jso=
n b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
new file mode 100644
index 000000000000..a87d7431ef45
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
@@ -0,0 +1,3890 @@
+[
+    {
+        "BriefDescription": "Counts the number of read requests and stream=
ing stores that hit in MCDRAM cache and the data in MCDRAM is clean with re=
spect to DDR. This event is only valid in cache and hybrid memory mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_EDC_ACCESS.HIT_CLEAN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "Counts the number of read requests and stream=
ing stores that hit in MCDRAM cache and the data in MCDRAM is dirty with re=
spect to DDR. This event is only valid in cache and hybrid memory mode. ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_EDC_ACCESS.HIT_DIRTY",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "Counts the number of read requests and stream=
ing stores that miss in MCDRAM cache and the data evicted from the MCDRAM i=
s clean with respect to DDR. This event is only valid in cache and hybrid m=
emory mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_EDC_ACCESS.MISS_CLEAN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "Counts the number of read requests and stream=
ing stores that miss in MCDRAM cache and the data evicted from the MCDRAM i=
s dirty with respect to DDR. This event is only valid in cache and hybrid m=
emory mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_EDC_ACCESS.MISS_DIRTY",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "Number of EDC Hits or Misses. Miss I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_EDC_ACCESS.MISS_INVALID",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "ECLK count",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_E_E_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "EDC_ECLK"
+    },
+    {
+        "BriefDescription": "Counts the number of read requests received b=
y the MCDRAM controller. This event is valid in all three memory modes: fla=
t, cache and hybrid. In cache and hybrid memory mode, this event counts all=
 read requests as well as streaming stores that hit or miss in the MCDRAM c=
ache. ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_E_RPQ_INSERTS",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "EDC_ECLK"
+    },
+    {
+        "BriefDescription": "UCLK count",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_E_U_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "Counts the number of write requests received =
by the MCDRAM controller. This event is valid in all three memory modes: fl=
at, cache and hybrid. In cache and hybrid memory mode, this event counts al=
l streaming stores, writebacks and, read requests that miss in MCDRAM cache=
.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_WPQ_INSERTS",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "EDC_ECLK"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 0-7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x81",
+        "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED_EXT.ANY_OF_TGR0_THRU_TGR7"=
,
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x81",
+        "EventName": "UNC_H_AG0_AD_CRD_ACQUIRED_EXT.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 0-7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY_EXT.ANY_OF_TGR0_THRU_TGR7=
",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy For Transgres=
s 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_H_AG0_AD_CRD_OCCUPANCY_EXT.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 0-7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x89",
+        "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED_EXT.ANY_OF_TGR0_THRU_TGR7"=
,
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired For Transgress=
 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x89",
+        "EventName": "UNC_H_AG0_BL_CRD_ACQUIRED_EXT.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 0-7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8B",
+        "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY_EXT.ANY_OF_TGR0_THRU_TGR7=
",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy For Transgres=
s 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8B",
+        "EventName": "UNC_H_AG0_BL_CRD_OCCUPANCY_EXT.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0-7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD1",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD_EXT.ANY_OF_TGR=
0_THRU_TGR7",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD1",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_AD_EXT.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0-7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL_EXT.ANY_OF_TGR=
0_THRU_TGR7",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_H_AG0_STALL_NO_CRD_EGRESS_HORZ_BL_EXT.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 0-7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x85",
+        "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED_EXT.ANY_OF_TGR0_THRU_TGR7"=
,
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired For Transgress=
 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x85",
+        "EventName": "UNC_H_AG1_AD_CRD_ACQUIRED_EXT.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 0-7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x87",
+        "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY_EXT.ANY_OF_TGR0_THRU_TGR7=
",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy For Transgres=
s 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x87",
+        "EventName": "UNC_H_AG1_AD_CRD_OCCUPANCY_EXT.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 0-7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8D",
+        "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED_EXT.ANY_OF_TGR0_THRU_TGR7"=
,
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired For Transgress=
 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8D",
+        "EventName": "UNC_H_AG1_BL_CRD_ACQUIRED_EXT.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 0-7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8F",
+        "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY_EXT.ANY_OF_TGR0_THRU_TGR7=
",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy For Transgres=
s 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8F",
+        "EventName": "UNC_H_AG1_BL_CRD_OCCUPANCY_EXT.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0-7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD3",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD_EXT.ANY_OF_TGR=
0_THRU_TGR7",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD3",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_AD_EXT.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 0-7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD7",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL_EXT.ANY_OF_TGR=
0_THRU_TGR7",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Transgress Credits For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD7",
+        "EventName": "UNC_H_AG1_STALL_NO_CRD_EGRESS_HORZ_BL_EXT.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Writeback transactions from L2 to the LLC  This includes=
 all write transactions -- both Cachable and UC.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.E_STATE",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Filters for any transaction originating from the IPQ or =
IRQ.  This does not include lookups originating from the ISMQ.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.F_STATE",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized that Match NID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Read transactions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.M_STATE",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized that Does Not Match NID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Filters for only snoop requests coming from the remote s=
ocket(s) through the IPQ.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_H_CACHE_LINES_VICTIMIZED.S_STATE",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Uncore Clocks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_H_CLOCK",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9D",
+        "EventName": "UNC_H_EGRESS_HORZ_ADS_USED.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9D",
+        "EventName": "UNC_H_EGRESS_HORZ_ADS_USED.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9D",
+        "EventName": "UNC_H_EGRESS_HORZ_ADS_USED.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Bypass. AD ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9F",
+        "EventName": "UNC_H_EGRESS_HORZ_BYPASS.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Bypass. AK ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9F",
+        "EventName": "UNC_H_EGRESS_HORZ_BYPASS.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Bypass. BL ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9F",
+        "EventName": "UNC_H_EGRESS_HORZ_BYPASS.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Bypass. IV ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9F",
+        "EventName": "UNC_H_EGRESS_HORZ_BYPASS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full AD=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x96",
+        "EventName": "UNC_H_EGRESS_HORZ_CYCLES_FULL.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full AK=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x96",
+        "EventName": "UNC_H_EGRESS_HORZ_CYCLES_FULL.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full BL=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x96",
+        "EventName": "UNC_H_EGRESS_HORZ_CYCLES_FULL.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full IV=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x96",
+        "EventName": "UNC_H_EGRESS_HORZ_CYCLES_FULL.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x97",
+        "EventName": "UNC_H_EGRESS_HORZ_CYCLES_NE.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x97",
+        "EventName": "UNC_H_EGRESS_HORZ_CYCLES_NE.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty BL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x97",
+        "EventName": "UNC_H_EGRESS_HORZ_CYCLES_NE.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x97",
+        "EventName": "UNC_H_EGRESS_HORZ_CYCLES_NE.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x95",
+        "EventName": "UNC_H_EGRESS_HORZ_INSERTS.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x95",
+        "EventName": "UNC_H_EGRESS_HORZ_INSERTS.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts BL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x95",
+        "EventName": "UNC_H_EGRESS_HORZ_INSERTS.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x95",
+        "EventName": "UNC_H_EGRESS_HORZ_INSERTS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x99",
+        "EventName": "UNC_H_EGRESS_HORZ_NACK.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x99",
+        "EventName": "UNC_H_EGRESS_HORZ_NACK.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x99",
+        "EventName": "UNC_H_EGRESS_HORZ_NACK.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x99",
+        "EventName": "UNC_H_EGRESS_HORZ_NACK.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x94",
+        "EventName": "UNC_H_EGRESS_HORZ_OCCUPANCY.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x94",
+        "EventName": "UNC_H_EGRESS_HORZ_OCCUPANCY.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy BL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x94",
+        "EventName": "UNC_H_EGRESS_HORZ_OCCUPANCY.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x94",
+        "EventName": "UNC_H_EGRESS_HORZ_OCCUPANCY.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9B",
+        "EventName": "UNC_H_EGRESS_HORZ_STARVED.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9B",
+        "EventName": "UNC_H_EGRESS_HORZ_STARVED.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9B",
+        "EventName": "UNC_H_EGRESS_HORZ_STARVED.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9B",
+        "EventName": "UNC_H_EGRESS_HORZ_STARVED.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts number of cycles IV was blocked in the=
 TGR Egress due to SNP/GO Ordering requirements",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAE",
+        "EventName": "UNC_H_EGRESS_ORDERING.IV_SNP_GO_DN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts number of cycles IV was blocked in the=
 TGR Egress due to SNP/GO Ordering requirements",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAE",
+        "EventName": "UNC_H_EGRESS_ORDERING.IV_SNP_GO_UP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_H_EGRESS_VERT_ADS_USED.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_H_EGRESS_VERT_ADS_USED.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_H_EGRESS_VERT_ADS_USED.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_H_EGRESS_VERT_ADS_USED.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_H_EGRESS_VERT_ADS_USED.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_H_EGRESS_VERT_ADS_USED.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Bypass. AD ring agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_H_EGRESS_VERT_BYPASS.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Bypass. AD ring agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_H_EGRESS_VERT_BYPASS.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Bypass. AK ring agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_H_EGRESS_VERT_BYPASS.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Bypass. AK ring agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_H_EGRESS_VERT_BYPASS.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Bypass. BL ring agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_H_EGRESS_VERT_BYPASS.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Bypass. BL ring agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_H_EGRESS_VERT_BYPASS.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Bypass. IV ring agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_H_EGRESS_VERT_BYPASS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full AD -=
 Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full AD -=
 Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full AK -=
 Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full AK -=
 Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full BL -=
 Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full BL -=
 Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full IV -=
 Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_H_EGRESS_VERT_CYCLES_FULL.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 IV - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_H_EGRESS_VERT_CYCLES_NE.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_H_EGRESS_VERT_INSERTS.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_H_EGRESS_VERT_INSERTS.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_H_EGRESS_VERT_INSERTS.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_H_EGRESS_VERT_INSERTS.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_H_EGRESS_VERT_INSERTS.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_H_EGRESS_VERT_INSERTS.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations IV - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_H_EGRESS_VERT_INSERTS.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_H_EGRESS_VERT_NACK.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_H_EGRESS_VERT_NACK.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs Onto AK Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_H_EGRESS_VERT_NACK.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_H_EGRESS_VERT_NACK.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs Onto BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_H_EGRESS_VERT_NACK.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_H_EGRESS_VERT_NACK.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_H_EGRESS_VERT_NACK.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy IV - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_H_EGRESS_VERT_OCCUPANCY.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_H_EGRESS_VERT_STARVED.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_H_EGRESS_VERT_STARVED.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation Onto=
 AK Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_H_EGRESS_VERT_STARVED.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_H_EGRESS_VERT_STARVED.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation Onto=
 BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_H_EGRESS_VERT_STARVED.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_H_EGRESS_VERT_STARVED.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_H_EGRESS_VERT_STARVED.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts cycles source throttling is adderted -=
 horizontal",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA5",
+        "EventName": "UNC_H_FAST_ASSERTED.HORZ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts cycles source throttling is adderted -=
 vertical",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA5",
+        "EventName": "UNC_H_FAST_ASSERTED.VERT",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Horizont=
al AD ring is being used at this ring stop - Left and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_H_HORZ_RING_AD_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Horizont=
al AD ring is being used at this ring stop - Left and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_H_HORZ_RING_AD_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Horizont=
al AD ring is being used at this ring stop - Right and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_H_HORZ_RING_AD_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Horizont=
al AD ring is being used at this ring stop - Right and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_H_HORZ_RING_AD_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Horizont=
al AK ring is being used at this ring stop - Left and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA9",
+        "EventName": "UNC_H_HORZ_RING_AK_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Horizont=
al AK ring is being used at this ring stop - Left and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA9",
+        "EventName": "UNC_H_HORZ_RING_AK_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Horizont=
al AK ring is being used at this ring stop - Right and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA9",
+        "EventName": "UNC_H_HORZ_RING_AK_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Horizont=
al AK ring is being used at this ring stop - Right and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA9",
+        "EventName": "UNC_H_HORZ_RING_AK_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Horizont=
al BL ring is being used at this ring stop - Left and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAB",
+        "EventName": "UNC_H_HORZ_RING_BL_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Horizont=
al BL ring is being used at this ring stop - Left and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAB",
+        "EventName": "UNC_H_HORZ_RING_BL_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Horizont=
al BL ring is being used at this ring stop - Right and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAB",
+        "EventName": "UNC_H_HORZ_RING_BL_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Horizont=
al BL ring is being used at this ring stop - Right and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAB",
+        "EventName": "UNC_H_HORZ_RING_BL_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Horizont=
al IV ring is being used at this ring stop - Left",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAD",
+        "EventName": "UNC_H_HORZ_RING_IV_IN_USE.LEFT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Horizont=
al IV ring is being used at this ring stop - Right",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAD",
+        "EventName": "UNC_H_HORZ_RING_IV_IN_USE.RIGHT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Allocations. Counts number of allocat=
ions per cycle into the specified Ingress queue. - IPQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_H_INGRESS_INSERTS.IPQ",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Allocations. Counts number of allocat=
ions per cycle into the specified Ingress queue. - IRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_H_INGRESS_INSERTS.IRQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Allocations. Counts number of allocat=
ions per cycle into the specified Ingress queue. - IRQ Rejected",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_H_INGRESS_INSERTS.IRQ_REJ",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Allocations. Counts number of allocat=
ions per cycle into the specified Ingress queue. - PRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_H_INGRESS_INSERTS.PRQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Allocations. Counts number of allocat=
ions per cycle into the specified Ingress queue. - PRQ Rejected",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_H_INGRESS_INSERTS.PRQ_REJ",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles with the IPQ in Internal Starvation.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_H_INGRESS_INT_STARVED.IPQ",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles with the IRQ in Internal Starvation.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_H_INGRESS_INT_STARVED.IRQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles with the ISMQ in Internal Starvation."=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_H_INGRESS_INT_STARVED.ISMQ",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress internal starvation cycles. Counts cy=
cles in internal starvation. This occurs when one or more of the entries in=
 the ingress queue are being starved out by other entries in the queue.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_H_INGRESS_INT_STARVED.PRQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy. Counts number of entries i=
n the specified Ingress queue in each cycle. - IPQ",
+        "EventCode": "0x11",
+        "EventName": "UNC_H_INGRESS_OCCUPANCY.IPQ",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy. Counts number of entries i=
n the specified Ingress queue in each cycle. - IRQ",
+        "EventCode": "0x11",
+        "EventName": "UNC_H_INGRESS_OCCUPANCY.IRQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy. Counts number of entries i=
n the specified Ingress queue in each cycle. - IRQ Rejected",
+        "EventCode": "0x11",
+        "EventName": "UNC_H_INGRESS_OCCUPANCY.IRQ_REJ",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy. Counts number of entries i=
n the specified Ingress queue in each cycle. - PRQ",
+        "EventCode": "0x11",
+        "EventName": "UNC_H_INGRESS_OCCUPANCY.PRQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy. Counts number of entries i=
n the specified Ingress queue in each cycle. - PRQ Rejected",
+        "EventCode": "0x11",
+        "EventName": "UNC_H_INGRESS_OCCUPANCY.PRQ_REJ",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_INGRESS_RETRY_IPQ0_REJECT.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_H_INGRESS_RETRY_IPQ1_REJECT.ALLOW_SNP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_H_INGRESS_RETRY_IPQ1_REJECT.ANY_REJECT_IPQ0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_H_INGRESS_RETRY_IPQ1_REJECT.PA_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_H_INGRESS_RETRY_IPQ1_REJECT.SF_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_H_INGRESS_RETRY_IPQ1_REJECT.SF_WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_H_INGRESS_RETRY_IRQ0_REJECT.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_H_INGRESS_RETRY_IRQ1_REJECT.ALLOW_SNP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_H_INGRESS_RETRY_IRQ1_REJECT.ANY_REJECT_IRQ0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_H_INGRESS_RETRY_IRQ1_REJECT.PA_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_H_INGRESS_RETRY_IRQ1_REJECT.SF_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_H_INGRESS_RETRY_IRQ1_REJECT.SF_WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_REJECT.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_H_INGRESS_RETRY_ISMQ0_RETRY.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_H_INGRESS_RETRY_OTHER0_RETRY.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_H_INGRESS_RETRY_OTHER1_RETRY.ALLOW_SNP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_H_INGRESS_RETRY_OTHER1_RETRY.ANY_REJECT_IRQ0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_H_INGRESS_RETRY_OTHER1_RETRY.PA_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_H_INGRESS_RETRY_OTHER1_RETRY.SF_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Queue Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_H_INGRESS_RETRY_OTHER1_RETRY.SF_WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_INGRESS_RETRY_PRQ0_REJECT.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_INGRESS_RETRY_PRQ1_REJECT.ALLOW_SNP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_INGRESS_RETRY_PRQ1_REJECT.ANY_REJECT_IRQ0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_INGRESS_RETRY_PRQ1_REJECT.PA_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_INGRESS_RETRY_PRQ1_REJECT.SF_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_INGRESS_RETRY_PRQ1_REJECT.SF_WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_H_INGRESS_RETRY_REQ_Q0_RETRY.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.ALLOW_SNP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.ANY_REJECT_IRQ0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.PA_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.SF_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "REQUESTQ'' includes:  IRQ, PRQ, IPQ, RRQ, WBQ=
 (everything except for ISMQ)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_H_INGRESS_RETRY_REQ_Q1_RETRY.SF_WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Miscellaneous events in the Cbo. CV0 Prefetch=
 Miss",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_H_MISC.CV0_PREF_MISS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Miscellaneous events in the Cbo. CV0 Prefetch=
 Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_H_MISC.CV0_PREF_VIC",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Miscellaneous events in the Cbo. RFO HitS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_H_MISC.RFO_HIT_S",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Miscellaneous events in the Cbo. Silent Snoop=
 Eviction",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_H_MISC.RSPI_WAS_FSE",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Miscellaneous events in the Cbo. Write Combin=
ing Aliasing",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_H_MISC.WC_ALIASING",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Number of incoming messages from the Horizont=
al ring that were bounced, by ring type.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_H_RING_BOUNCES_HORZ.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Number of incoming messages from the Horizont=
al ring that were bounced, by ring type - Acknowledgements to core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_H_RING_BOUNCES_HORZ.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Number of incoming messages from the Horizont=
al ring that were bounced, by ring type - Data Responses to core.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_H_RING_BOUNCES_HORZ.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Number of incoming messages from the Horizont=
al ring that were bounced, by ring type - Snoops of processor's cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_H_RING_BOUNCES_HORZ.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Number of incoming messages from the Vertical=
 ring that were bounced, by ring type.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_H_RING_BOUNCES_VERT.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Number of incoming messages from the Vertical=
 ring that were bounced, by ring type - Acknowledgements to core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_H_RING_BOUNCES_VERT.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Number of incoming messages from the Vertical=
 ring that were bounced, by ring type - Data Responses to core.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_H_RING_BOUNCES_VERT.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Number of incoming messages from the Vertical=
 ring that were bounced, by ring type - Snoops of processor's cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_H_RING_BOUNCES_VERT.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal ring sink starvation count - AD ri=
ng",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA3",
+        "EventName": "UNC_H_RING_SINK_STARVED_HORZ.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal ring sink starvation count - AK ri=
ng",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA3",
+        "EventName": "UNC_H_RING_SINK_STARVED_HORZ.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal ring sink starvation count - BL ri=
ng",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA3",
+        "EventName": "UNC_H_RING_SINK_STARVED_HORZ.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal ring sink starvation count - IV ri=
ng",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA3",
+        "EventName": "UNC_H_RING_SINK_STARVED_HORZ.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical ring sink starvation count - AD ring=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA2",
+        "EventName": "UNC_H_RING_SINK_STARVED_VERT.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical ring sink starvation count - AK ring=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA2",
+        "EventName": "UNC_H_RING_SINK_STARVED_VERT.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical ring sink starvation count - BL ring=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA2",
+        "EventName": "UNC_H_RING_SINK_STARVED_VERT.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical ring sink starvation count - IV ring=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA2",
+        "EventName": "UNC_H_RING_SINK_STARVED_VERT.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts cycles in throttle mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA4",
+        "EventName": "UNC_H_RING_SRC_THRTL",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Filters for any transaction originating from the IPQ or =
IRQ.  This does not include lookups originating from the ISMQ.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_H_SF_LOOKUP.ANY",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Read transactions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_H_SF_LOOKUP.DATA_READ",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Filters for only snoop requests coming from the remote s=
ocket(s) through the IPQ.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_H_SF_LOOKUP.REMOTE_SNOOP",
+        "PerPkg": "1",
+        "UMask": "0x09",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups. Counts the number of times the=
 LLC was accessed. Writeback transactions from L2 to the LLC  This includes=
 all write transactions -- both Cachable and UC.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_H_SF_LOOKUP.WRITE",
+        "PerPkg": "1",
+        "UMask": "0x05",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, because a message from the other queue has higher priorit=
y",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_H_TG_INGRESS_BUSY_STARVED.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, because a message from the other queue has higher priorit=
y",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_H_TG_INGRESS_BUSY_STARVED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, because a message from the other queue has higher priorit=
y",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_H_TG_INGRESS_BUSY_STARVED.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, because a message from the other queue has higher priorit=
y",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_H_TG_INGRESS_BUSY_STARVED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_H_TG_INGRESS_BYPASS.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_H_TG_INGRESS_BYPASS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_H_TG_INGRESS_BYPASS.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_H_TG_INGRESS_BYPASS.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_H_TG_INGRESS_BYPASS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass. Number of packets =
bypassing the CMS Ingress .",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_H_TG_INGRESS_BYPASS.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.IFV",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation. Counts cycle=
s under injection starvation mode.  This starvation is triggered when the C=
MS Ingress cannot send a transaction onto the mesh for a long period of tim=
e.  In this case, the Ingress is unable to forward to the Egress due to a l=
ack of credit.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_H_TG_INGRESS_CRD_STARVED.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_H_TG_INGRESS_INSERTS.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_H_TG_INGRESS_INSERTS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_H_TG_INGRESS_INSERTS.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_H_TG_INGRESS_INSERTS.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_H_TG_INGRESS_INSERTS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations. Number of all=
ocations into the CMS Ingress  The Ingress is used to queue up requests rec=
eived from the mesh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_H_TG_INGRESS_INSERTS.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy. Occupancy event=
 for the Ingress buffers in the CMS  The Ingress is used to queue up reques=
ts received from the mesh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_H_TG_INGRESS_OCCUPANCY.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Uncore Clocks",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_H_U_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Vertical=
 AD ring is being used at this ring stop - Down and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_H_VERT_RING_AD_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Vertical=
 AD ring is being used at this ring stop - Down and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_H_VERT_RING_AD_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Vertical=
 AD ring is being used at this ring stop - Up and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_H_VERT_RING_AD_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Vertical=
 AD ring is being used at this ring stop - Up and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_H_VERT_RING_AD_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Vertical=
 AK ring is being used at this ring stop - Down and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA8",
+        "EventName": "UNC_H_VERT_RING_AK_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Vertical=
 AK ring is being used at this ring stop - Down and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA8",
+        "EventName": "UNC_H_VERT_RING_AK_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Vertical=
 AK ring is being used at this ring stop - Up and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA8",
+        "EventName": "UNC_H_VERT_RING_AK_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Vertical=
 AK ring is being used at this ring stop - Up and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA8",
+        "EventName": "UNC_H_VERT_RING_AK_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Vertical=
 BL ring is being used at this ring stop - Down and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAA",
+        "EventName": "UNC_H_VERT_RING_BL_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Vertical=
 BL ring is being used at this ring stop - Down and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAA",
+        "EventName": "UNC_H_VERT_RING_BL_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Vertical=
 BL ring is being used at this ring stop - Up and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAA",
+        "EventName": "UNC_H_VERT_RING_BL_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Vertical=
 BL ring is being used at this ring stop - Up and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAA",
+        "EventName": "UNC_H_VERT_RING_BL_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Vertical=
 IV ring is being used at this ring stop - Down",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAC",
+        "EventName": "UNC_H_VERT_RING_IV_IN_USE.DN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the Vertical=
 IV ring is being used at this ring stop - Up",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAC",
+        "EventName": "UNC_H_VERT_RING_IV_IN_USE.UP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AD_0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AD_0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AD_1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AD_1",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AK_0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AK_0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AK_1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AK_1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  BL_0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.BL_0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  BL_1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.BL_1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AD_0",
+        "Counter": "0,1",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AD_0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AD_1",
+        "Counter": "0,1",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AD_1",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AK_0",
+        "Counter": "0,1",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AK_0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AK_1",
+        "Counter": "0,1",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AK_1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  BL_0",
+        "Counter": "0,1",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.BL_0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  BL_1",
+        "Counter": "0,1",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.BL_1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AD_0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AD_0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AD_1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AD_1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_CRD_0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_CRD_0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_CRD_1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_CRD_1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. BL_0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.BL_0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. BL_1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.BL_1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.ALL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_IDI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_IDI",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_NCB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_NCB",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_NCS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_NCS",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CAS All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_CAS_COUNT.ALL",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "iMC_DCLK"
+    },
+    {
+        "BriefDescription": "CAS Reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_CAS_COUNT.RD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "iMC_DCLK"
+    },
+    {
+        "BriefDescription": "CAS Writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_CAS_COUNT.WR",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "iMC_DCLK"
+    },
+    {
+        "BriefDescription": "DCLK count",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_M_D_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "iMC_DCLK"
+    },
+    {
+        "BriefDescription": "UCLK count",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_M_U_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "iMC_UCLK"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.j=
son b/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
index eda299ef5ff8..821cdd44a12f 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
@@ -62,4 +62,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x3"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 10c57fc4dcd1..fbb2c9dcdc7b 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -15,8 +15,7 @@ GenuineIntel-6-6[AC],v1.15,icelakex,core
 GenuineIntel-6-3A,v22,ivybridge,core
 GenuineIntel-6-3E,v21,ivytown,core
 GenuineIntel-6-2D,v21,jaketown,core
-GenuineIntel-6-57,v9,knightslanding,core
-GenuineIntel-6-85,v9,knightslanding,core
+GenuineIntel-6-(57|85),v9,knightslanding,core
 GenuineIntel-6-1E,v2,nehalemep,core
 GenuineIntel-6-1F,v2,nehalemep,core
 GenuineIntel-6-1A,v2,nehalemep,core
--=20
2.37.1.359.gd136c6c3e2-goog

