Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C4157E9D0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiGVWgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbiGVWe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:34:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A14A7234
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o135-20020a25738d000000b0066f58989d75so4654882ybc.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u9V9/eIAy62qbC1mH5oNxvRIs4NXT0oj8ydg6s6sUdg=;
        b=BUeJ6x+D0EEazVdERC3eiyl1uBXYEiQDO0QkyDwv1NrWFc8z+Gam51b42B/hmjJ4f2
         dMOw1MEaE/n6k4Tr3CXnFcm2KZx5oDWXMFXykFj/hcE4F82EHZngdoZsD4G/77QLwJSw
         n9nCxl6YlUPVRxaghzRF0UQmkdR8tYQbT3t1mVPo0h8OcRnGjZASilMGwfC0iXvvmY1I
         uRLYse+KVs6s+W63blaCl/zHZ6miVcWe6gEfS9ja+zWpNT0Fzn1tt3VYP5cY6uzS3hZy
         wGv5yiE4G8qGbj7Qpo+ihM7ZUe/yQN6lHBb/yaXXdIF/DOZ5wnCjcd/2nnVdpCdMe/Qz
         MsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u9V9/eIAy62qbC1mH5oNxvRIs4NXT0oj8ydg6s6sUdg=;
        b=Ji8x8lnMlDQfcz8wTZVYy8PgU4Lk1T2NNDN1yerLMp0eoukPf0Qu7fIv7pshvSFngx
         t+RU4JOofQhRAcvjBBV0+RlD7PtxobnftalQRY2UnvgC3yxQnOdRpePNvJRD6M82JMmP
         j429bVZ2I37xMo3vEAvbs0iAcxyeAeTy/PkTpmiwcScGjUh+gGyukPs4w6Q4MIZH8Aa0
         VaW1mHRK3oFz90QOU8vYUfsdCbekFAfnAJSmbJOpxK8E4sBwIpb6TrSHndfxDgFhQpXK
         I04kNtQ6dn3rPa9oYukd449N9aJjtiObRfuPBBfCmLv7PGlGHZdvjSRTre3mX/vNkkdf
         wDxA==
X-Gm-Message-State: AJIora/EDSvgxVAjUSO0I6waLBbE2z6eRQVaSp0oVDIBbmEK7yZoX3G7
        utFljQwmyLXglLCE3hYX5YMR7HJ7qs35
X-Google-Smtp-Source: AGRyM1sD+yS6bs+2zf7Exw+WpYdhN2n4GVB3U9oUqWl6NO9+BvzymZ+69lhBiwFbt2YpBnUzPRymxnoawGyq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a05:6902:110e:b0:66d:e6dc:5f31 with SMTP
 id o14-20020a056902110e00b0066de6dc5f31mr1827296ybu.628.1658529226961; Fri,
 22 Jul 2022 15:33:46 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:30 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-22-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 21/31] perf vendor events: Update Intel nehalemex
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually copy
the nehalemex files into perf and update mapfile.csv.

Tested on a non-nehalemex with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Note: most of this change is just sorting the keys in the json dictionaries.
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
 .../pmu-events/arch/x86/nehalemex/cache.json  | 2974 ++++++++---------
 .../arch/x86/nehalemex/floating-point.json    |  182 +-
 .../arch/x86/nehalemex/frontend.json          |   20 +-
 .../pmu-events/arch/x86/nehalemex/memory.json |  672 ++--
 .../pmu-events/arch/x86/nehalemex/other.json  |  170 +-
 .../arch/x86/nehalemex/pipeline.json          |  830 ++---
 .../arch/x86/nehalemex/virtual-memory.json    |   92 +-
 8 files changed, 2471 insertions(+), 2471 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 8336f2c8f96f..ab070ba3ad48 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -18,7 +18,7 @@ GenuineIntel-6-2D,v21,jaketown,core
 GenuineIntel-6-(57|85),v9,knightslanding,core
 GenuineIntel-6-AA,v1.00,meteorlake,core
 GenuineIntel-6-1[AEF],v3,nehalemep,core
-GenuineIntel-6-2E,v2,nehalemex,core
+GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-[4589]E,v24,skylake,core
 GenuineIntel-6-A[56],v24,skylake,core
 GenuineIntel-6-37,v13,silvermont,core
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/cache.json b/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
index 21a0f8fd057e..01542c4ea678 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
@@ -1,3184 +1,3184 @@
 [
     {
-        "EventCode": "0x63",
+        "BriefDescription": "Cycles L1D locked",
         "Counter": "0,1",
-        "UMask": "0x2",
+        "EventCode": "0x63",
         "EventName": "CACHE_LOCK_CYCLES.L1D",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles L1D locked"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x63",
+        "BriefDescription": "Cycles L1D and L2 locked",
         "Counter": "0,1",
-        "UMask": "0x1",
+        "EventCode": "0x63",
         "EventName": "CACHE_LOCK_CYCLES.L1D_L2",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles L1D and L2 locked"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x51",
+        "BriefDescription": "L1D cache lines replaced in M state",
         "Counter": "0,1",
-        "UMask": "0x4",
+        "EventCode": "0x51",
         "EventName": "L1D.M_EVICT",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1D cache lines replaced in M state"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0x51",
+        "BriefDescription": "L1D cache lines allocated in the M state",
         "Counter": "0,1",
-        "UMask": "0x2",
+        "EventCode": "0x51",
         "EventName": "L1D.M_REPL",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1D cache lines allocated in the M state"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x51",
+        "BriefDescription": "L1D snoop eviction of cache lines in M state",
         "Counter": "0,1",
-        "UMask": "0x8",
+        "EventCode": "0x51",
         "EventName": "L1D.M_SNOOP_EVICT",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1D snoop eviction of cache lines in M state"
+        "UMask": "0x8"
     },
     {
-        "EventCode": "0x51",
+        "BriefDescription": "L1 data cache lines allocated",
         "Counter": "0,1",
-        "UMask": "0x1",
+        "EventCode": "0x51",
         "EventName": "L1D.REPL",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1 data cache lines allocated"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x43",
+        "BriefDescription": "All references to the L1 data cache",
         "Counter": "0,1",
-        "UMask": "0x1",
+        "EventCode": "0x43",
         "EventName": "L1D_ALL_REF.ANY",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "All references to the L1 data cache"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x43",
+        "BriefDescription": "L1 data cacheable reads and writes",
         "Counter": "0,1",
-        "UMask": "0x2",
+        "EventCode": "0x43",
         "EventName": "L1D_ALL_REF.CACHEABLE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1 data cacheable reads and writes"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x40",
+        "BriefDescription": "L1 data cache read in E state",
         "Counter": "0,1",
-        "UMask": "0x4",
+        "EventCode": "0x40",
         "EventName": "L1D_CACHE_LD.E_STATE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1 data cache read in E state"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0x40",
+        "BriefDescription": "L1 data cache read in I state (misses)",
         "Counter": "0,1",
-        "UMask": "0x1",
+        "EventCode": "0x40",
         "EventName": "L1D_CACHE_LD.I_STATE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1 data cache read in I state (misses)"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x40",
+        "BriefDescription": "L1 data cache reads",
         "Counter": "0,1",
-        "UMask": "0x8",
-        "EventName": "L1D_CACHE_LD.M_STATE",
+        "EventCode": "0x40",
+        "EventName": "L1D_CACHE_LD.MESI",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1 data cache read in M state"
+        "UMask": "0xf"
     },
     {
-        "EventCode": "0x40",
+        "BriefDescription": "L1 data cache read in M state",
         "Counter": "0,1",
-        "UMask": "0xf",
-        "EventName": "L1D_CACHE_LD.MESI",
+        "EventCode": "0x40",
+        "EventName": "L1D_CACHE_LD.M_STATE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1 data cache reads"
+        "UMask": "0x8"
     },
     {
-        "EventCode": "0x40",
+        "BriefDescription": "L1 data cache read in S state",
         "Counter": "0,1",
-        "UMask": "0x2",
+        "EventCode": "0x40",
         "EventName": "L1D_CACHE_LD.S_STATE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1 data cache read in S state"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x42",
+        "BriefDescription": "L1 data cache load locks in E state",
         "Counter": "0,1",
-        "UMask": "0x4",
+        "EventCode": "0x42",
         "EventName": "L1D_CACHE_LOCK.E_STATE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1 data cache load locks in E state"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0x42",
+        "BriefDescription": "L1 data cache load lock hits",
         "Counter": "0,1",
-        "UMask": "0x1",
+        "EventCode": "0x42",
         "EventName": "L1D_CACHE_LOCK.HIT",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1 data cache load lock hits"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x42",
+        "BriefDescription": "L1 data cache load locks in M state",
         "Counter": "0,1",
-        "UMask": "0x8",
+        "EventCode": "0x42",
         "EventName": "L1D_CACHE_LOCK.M_STATE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1 data cache load locks in M state"
+        "UMask": "0x8"
     },
     {
-        "EventCode": "0x42",
+        "BriefDescription": "L1 data cache load locks in S state",
         "Counter": "0,1",
-        "UMask": "0x2",
+        "EventCode": "0x42",
         "EventName": "L1D_CACHE_LOCK.S_STATE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1 data cache load locks in S state"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x53",
+        "BriefDescription": "L1D load lock accepted in fill buffer",
         "Counter": "0,1",
-        "UMask": "0x1",
+        "EventCode": "0x53",
         "EventName": "L1D_CACHE_LOCK_FB_HIT",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1D load lock accepted in fill buffer"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x52",
+        "BriefDescription": "L1D prefetch load lock accepted in fill buffer",
         "Counter": "0,1",
-        "UMask": "0x1",
+        "EventCode": "0x52",
         "EventName": "L1D_CACHE_PREFETCH_LOCK_FB_HIT",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1D prefetch load lock accepted in fill buffer"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x41",
+        "BriefDescription": "L1 data cache stores in E state",
         "Counter": "0,1",
-        "UMask": "0x4",
+        "EventCode": "0x41",
         "EventName": "L1D_CACHE_ST.E_STATE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1 data cache stores in E state"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0x41",
+        "BriefDescription": "L1 data cache stores in M state",
         "Counter": "0,1",
-        "UMask": "0x8",
+        "EventCode": "0x41",
         "EventName": "L1D_CACHE_ST.M_STATE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1 data cache stores in M state"
+        "UMask": "0x8"
     },
     {
-        "EventCode": "0x41",
+        "BriefDescription": "L1 data cache stores in S state",
         "Counter": "0,1",
-        "UMask": "0x2",
+        "EventCode": "0x41",
         "EventName": "L1D_CACHE_ST.S_STATE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1 data cache stores in S state"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x4E",
+        "BriefDescription": "L1D hardware prefetch misses",
         "Counter": "0,1",
-        "UMask": "0x2",
+        "EventCode": "0x4E",
         "EventName": "L1D_PREFETCH.MISS",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L1D hardware prefetch misses"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x4E",
+        "BriefDescription": "L1D hardware prefetch requests",
         "Counter": "0,1",
-        "UMask": "0x1",
+        "EventCode": "0x4E",
         "EventName": "L1D_PREFETCH.REQUESTS",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L1D hardware prefetch requests"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x4E",
+        "BriefDescription": "L1D hardware prefetch requests triggered",
         "Counter": "0,1",
-        "UMask": "0x4",
+        "EventCode": "0x4E",
         "EventName": "L1D_PREFETCH.TRIGGERS",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L1D hardware prefetch requests triggered"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0x28",
+        "BriefDescription": "L1 writebacks to L2 in E state",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0x28",
         "EventName": "L1D_WB_L2.E_STATE",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L1 writebacks to L2 in E state"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0x28",
+        "BriefDescription": "L1 writebacks to L2 in I state (misses)",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x28",
         "EventName": "L1D_WB_L2.I_STATE",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L1 writebacks to L2 in I state (misses)"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x28",
+        "BriefDescription": "All L1 writebacks to L2",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "L1D_WB_L2.M_STATE",
+        "EventCode": "0x28",
+        "EventName": "L1D_WB_L2.MESI",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L1 writebacks to L2 in M state"
+        "UMask": "0xf"
     },
     {
-        "EventCode": "0x28",
+        "BriefDescription": "L1 writebacks to L2 in M state",
         "Counter": "0,1,2,3",
-        "UMask": "0xf",
-        "EventName": "L1D_WB_L2.MESI",
+        "EventCode": "0x28",
+        "EventName": "L1D_WB_L2.M_STATE",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All L1 writebacks to L2"
+        "UMask": "0x8"
     },
     {
-        "EventCode": "0x28",
+        "BriefDescription": "L1 writebacks to L2 in S state",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0x28",
         "EventName": "L1D_WB_L2.S_STATE",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L1 writebacks to L2 in S state"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x26",
+        "BriefDescription": "All L2 data requests",
         "Counter": "0,1,2,3",
-        "UMask": "0xff",
+        "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.ANY",
         "SampleAfterValue": "200000",
-        "BriefDescription": "All L2 data requests"
+        "UMask": "0xff"
     },
     {
-        "EventCode": "0x26",
+        "BriefDescription": "L2 data demand loads in E state",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.DEMAND.E_STATE",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 data demand loads in E state"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0x26",
+        "BriefDescription": "L2 data demand loads in I state (misses)",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.DEMAND.I_STATE",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 data demand loads in I state (misses)"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x26",
+        "BriefDescription": "L2 data demand requests",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "L2_DATA_RQSTS.DEMAND.M_STATE",
+        "EventCode": "0x26",
+        "EventName": "L2_DATA_RQSTS.DEMAND.MESI",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 data demand loads in M state"
+        "UMask": "0xf"
     },
     {
-        "EventCode": "0x26",
+        "BriefDescription": "L2 data demand loads in M state",
         "Counter": "0,1,2,3",
-        "UMask": "0xf",
-        "EventName": "L2_DATA_RQSTS.DEMAND.MESI",
+        "EventCode": "0x26",
+        "EventName": "L2_DATA_RQSTS.DEMAND.M_STATE",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 data demand requests"
+        "UMask": "0x8"
     },
     {
-        "EventCode": "0x26",
+        "BriefDescription": "L2 data demand loads in S state",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.DEMAND.S_STATE",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 data demand loads in S state"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x26",
+        "BriefDescription": "L2 data prefetches in E state",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
+        "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.PREFETCH.E_STATE",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 data prefetches in E state"
+        "UMask": "0x40"
     },
     {
-        "EventCode": "0x26",
+        "BriefDescription": "L2 data prefetches in the I state (misses)",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
+        "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.PREFETCH.I_STATE",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 data prefetches in the I state (misses)"
+        "UMask": "0x10"
     },
     {
-        "EventCode": "0x26",
+        "BriefDescription": "All L2 data prefetches",
         "Counter": "0,1,2,3",
-        "UMask": "0x80",
-        "EventName": "L2_DATA_RQSTS.PREFETCH.M_STATE",
+        "EventCode": "0x26",
+        "EventName": "L2_DATA_RQSTS.PREFETCH.MESI",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 data prefetches in M state"
+        "UMask": "0xf0"
     },
     {
-        "EventCode": "0x26",
+        "BriefDescription": "L2 data prefetches in M state",
         "Counter": "0,1,2,3",
-        "UMask": "0xf0",
-        "EventName": "L2_DATA_RQSTS.PREFETCH.MESI",
+        "EventCode": "0x26",
+        "EventName": "L2_DATA_RQSTS.PREFETCH.M_STATE",
         "SampleAfterValue": "200000",
-        "BriefDescription": "All L2 data prefetches"
+        "UMask": "0x80"
     },
     {
-        "EventCode": "0x26",
+        "BriefDescription": "L2 data prefetches in the S state",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
+        "EventCode": "0x26",
         "EventName": "L2_DATA_RQSTS.PREFETCH.S_STATE",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 data prefetches in the S state"
+        "UMask": "0x20"
     },
     {
-        "EventCode": "0xF1",
+        "BriefDescription": "L2 lines alloacated",
         "Counter": "0,1,2,3",
-        "UMask": "0x7",
+        "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.ANY",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 lines alloacated"
+        "UMask": "0x7"
     },
     {
-        "EventCode": "0xF1",
+        "BriefDescription": "L2 lines allocated in the E state",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.E_STATE",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 lines allocated in the E state"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0xF1",
+        "BriefDescription": "L2 lines allocated in the S state",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xF1",
         "EventName": "L2_LINES_IN.S_STATE",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 lines allocated in the S state"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0xF2",
+        "BriefDescription": "L2 lines evicted",
         "Counter": "0,1,2,3",
-        "UMask": "0xf",
+        "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.ANY",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 lines evicted"
+        "UMask": "0xf"
     },
     {
-        "EventCode": "0xF2",
+        "BriefDescription": "L2 lines evicted by a demand request",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DEMAND_CLEAN",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 lines evicted by a demand request"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xF2",
+        "BriefDescription": "L2 modified lines evicted by a demand request",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.DEMAND_DIRTY",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 modified lines evicted by a demand request"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0xF2",
+        "BriefDescription": "L2 lines evicted by a prefetch request",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.PREFETCH_CLEAN",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 lines evicted by a prefetch request"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0xF2",
+        "BriefDescription": "L2 modified lines evicted by a prefetch request",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
+        "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.PREFETCH_DIRTY",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 modified lines evicted by a prefetch request"
+        "UMask": "0x8"
     },
     {
-        "EventCode": "0x24",
+        "BriefDescription": "L2 instruction fetches",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
-        "EventName": "L2_RQSTS.IFETCH_HIT",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.IFETCHES",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 instruction fetch hits"
+        "UMask": "0x30"
     },
     {
-        "EventCode": "0x24",
+        "BriefDescription": "L2 instruction fetch hits",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
-        "EventName": "L2_RQSTS.IFETCH_MISS",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.IFETCH_HIT",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 instruction fetch misses"
+        "UMask": "0x10"
     },
     {
-        "EventCode": "0x24",
+        "BriefDescription": "L2 instruction fetch misses",
         "Counter": "0,1,2,3",
-        "UMask": "0x30",
-        "EventName": "L2_RQSTS.IFETCHES",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.IFETCH_MISS",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 instruction fetches"
+        "UMask": "0x20"
     },
     {
-        "EventCode": "0x24",
+        "BriefDescription": "L2 load hits",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x24",
         "EventName": "L2_RQSTS.LD_HIT",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 load hits"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x24",
+        "BriefDescription": "L2 load misses",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0x24",
         "EventName": "L2_RQSTS.LD_MISS",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 load misses"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x24",
+        "BriefDescription": "L2 requests",
         "Counter": "0,1,2,3",
-        "UMask": "0x3",
+        "EventCode": "0x24",
         "EventName": "L2_RQSTS.LOADS",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 requests"
+        "UMask": "0x3"
     },
     {
-        "EventCode": "0x24",
+        "BriefDescription": "All L2 misses",
         "Counter": "0,1,2,3",
-        "UMask": "0xaa",
+        "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
         "SampleAfterValue": "200000",
-        "BriefDescription": "All L2 misses"
+        "UMask": "0xaa"
     },
     {
+        "BriefDescription": "All L2 prefetches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
+        "EventName": "L2_RQSTS.PREFETCHES",
+        "SampleAfterValue": "200000",
+        "UMask": "0xc0"
+    },
+    {
+        "BriefDescription": "L2 prefetch hits",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
+        "EventCode": "0x24",
         "EventName": "L2_RQSTS.PREFETCH_HIT",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 prefetch hits"
+        "UMask": "0x40"
     },
     {
-        "EventCode": "0x24",
+        "BriefDescription": "L2 prefetch misses",
         "Counter": "0,1,2,3",
-        "UMask": "0x80",
+        "EventCode": "0x24",
         "EventName": "L2_RQSTS.PREFETCH_MISS",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 prefetch misses"
+        "UMask": "0x80"
     },
     {
-        "EventCode": "0x24",
+        "BriefDescription": "All L2 requests",
         "Counter": "0,1,2,3",
-        "UMask": "0xc0",
-        "EventName": "L2_RQSTS.PREFETCHES",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.REFERENCES",
         "SampleAfterValue": "200000",
-        "BriefDescription": "All L2 prefetches"
+        "UMask": "0xff"
     },
     {
-        "EventCode": "0x24",
+        "BriefDescription": "L2 RFO requests",
         "Counter": "0,1,2,3",
-        "UMask": "0xff",
-        "EventName": "L2_RQSTS.REFERENCES",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.RFOS",
         "SampleAfterValue": "200000",
-        "BriefDescription": "All L2 requests"
+        "UMask": "0xc"
     },
     {
-        "EventCode": "0x24",
+        "BriefDescription": "L2 RFO hits",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 RFO hits"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0x24",
+        "BriefDescription": "L2 RFO misses",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
+        "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 RFO misses"
+        "UMask": "0x8"
     },
     {
-        "EventCode": "0x24",
+        "BriefDescription": "All L2 transactions",
         "Counter": "0,1,2,3",
-        "UMask": "0xc",
-        "EventName": "L2_RQSTS.RFOS",
-        "SampleAfterValue": "200000",
-        "BriefDescription": "L2 RFO requests"
-    },
-    {
         "EventCode": "0xF0",
-        "Counter": "0,1,2,3",
-        "UMask": "0x80",
         "EventName": "L2_TRANSACTIONS.ANY",
         "SampleAfterValue": "200000",
-        "BriefDescription": "All L2 transactions"
+        "UMask": "0x80"
     },
     {
-        "EventCode": "0xF0",
+        "BriefDescription": "L2 fill transactions",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
+        "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.FILL",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 fill transactions"
+        "UMask": "0x20"
     },
     {
-        "EventCode": "0xF0",
+        "BriefDescription": "L2 instruction fetch transactions",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.IFETCH",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 instruction fetch transactions"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0xF0",
+        "BriefDescription": "L1D writeback to L2 transactions",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
+        "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.L1D_WB",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L1D writeback to L2 transactions"
+        "UMask": "0x10"
     },
     {
-        "EventCode": "0xF0",
+        "BriefDescription": "L2 Load transactions",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.LOAD",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 Load transactions"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xF0",
+        "BriefDescription": "L2 prefetch transactions",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
+        "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.PREFETCH",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 prefetch transactions"
+        "UMask": "0x8"
     },
     {
-        "EventCode": "0xF0",
+        "BriefDescription": "L2 RFO transactions",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.RFO",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 RFO transactions"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0xF0",
+        "BriefDescription": "L2 writeback to LLC transactions",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
+        "EventCode": "0xF0",
         "EventName": "L2_TRANSACTIONS.WB",
         "SampleAfterValue": "200000",
-        "BriefDescription": "L2 writeback to LLC transactions"
+        "UMask": "0x40"
     },
     {
-        "EventCode": "0x27",
+        "BriefDescription": "L2 demand lock RFOs in E state",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
+        "EventCode": "0x27",
         "EventName": "L2_WRITE.LOCK.E_STATE",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 demand lock RFOs in E state"
+        "UMask": "0x40"
     },
     {
-        "EventCode": "0x27",
+        "BriefDescription": "All demand L2 lock RFOs that hit the cache",
         "Counter": "0,1,2,3",
-        "UMask": "0xe0",
+        "EventCode": "0x27",
         "EventName": "L2_WRITE.LOCK.HIT",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All demand L2 lock RFOs that hit the cache"
+        "UMask": "0xe0"
     },
     {
-        "EventCode": "0x27",
+        "BriefDescription": "L2 demand lock RFOs in I state (misses)",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
+        "EventCode": "0x27",
         "EventName": "L2_WRITE.LOCK.I_STATE",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 demand lock RFOs in I state (misses)"
+        "UMask": "0x10"
     },
     {
-        "EventCode": "0x27",
+        "BriefDescription": "All demand L2 lock RFOs",
         "Counter": "0,1,2,3",
-        "UMask": "0x80",
-        "EventName": "L2_WRITE.LOCK.M_STATE",
+        "EventCode": "0x27",
+        "EventName": "L2_WRITE.LOCK.MESI",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 demand lock RFOs in M state"
+        "UMask": "0xf0"
     },
     {
-        "EventCode": "0x27",
+        "BriefDescription": "L2 demand lock RFOs in M state",
         "Counter": "0,1,2,3",
-        "UMask": "0xf0",
-        "EventName": "L2_WRITE.LOCK.MESI",
+        "EventCode": "0x27",
+        "EventName": "L2_WRITE.LOCK.M_STATE",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All demand L2 lock RFOs"
+        "UMask": "0x80"
     },
     {
-        "EventCode": "0x27",
+        "BriefDescription": "L2 demand lock RFOs in S state",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
+        "EventCode": "0x27",
         "EventName": "L2_WRITE.LOCK.S_STATE",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 demand lock RFOs in S state"
+        "UMask": "0x20"
     },
     {
-        "EventCode": "0x27",
+        "BriefDescription": "All L2 demand store RFOs that hit the cache",
         "Counter": "0,1,2,3",
-        "UMask": "0xe",
+        "EventCode": "0x27",
         "EventName": "L2_WRITE.RFO.HIT",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All L2 demand store RFOs that hit the cache"
+        "UMask": "0xe"
     },
     {
-        "EventCode": "0x27",
+        "BriefDescription": "L2 demand store RFOs in I state (misses)",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x27",
         "EventName": "L2_WRITE.RFO.I_STATE",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 demand store RFOs in I state (misses)"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x27",
+        "BriefDescription": "All L2 demand store RFOs",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "L2_WRITE.RFO.M_STATE",
+        "EventCode": "0x27",
+        "EventName": "L2_WRITE.RFO.MESI",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 demand store RFOs in M state"
+        "UMask": "0xf"
     },
     {
-        "EventCode": "0x27",
+        "BriefDescription": "L2 demand store RFOs in M state",
         "Counter": "0,1,2,3",
-        "UMask": "0xf",
-        "EventName": "L2_WRITE.RFO.MESI",
+        "EventCode": "0x27",
+        "EventName": "L2_WRITE.RFO.M_STATE",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All L2 demand store RFOs"
+        "UMask": "0x8"
     },
     {
-        "EventCode": "0x27",
+        "BriefDescription": "L2 demand store RFOs in S state",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0x27",
         "EventName": "L2_WRITE.RFO.S_STATE",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 demand store RFOs in S state"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x2E",
+        "BriefDescription": "Longest latency cache miss",
         "Counter": "0,1,2,3",
-        "UMask": "0x41",
+        "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Longest latency cache miss"
+        "UMask": "0x41"
     },
     {
-        "EventCode": "0x2E",
+        "BriefDescription": "Longest latency cache reference",
         "Counter": "0,1,2,3",
-        "UMask": "0x4f",
+        "EventCode": "0x2E",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "SampleAfterValue": "200000",
-        "BriefDescription": "Longest latency cache reference"
+        "UMask": "0x4f"
     },
     {
-        "PEBS": "1",
+        "BriefDescription": "Memory instructions retired above 0 clocks (Precise Event)",
+        "Counter": "3",
         "EventCode": "0xB",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "MEM_INST_RETIRED.LOADS",
+        "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_0",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x0",
+        "PEBS": "2",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Instructions retired which contains a load (Precise Event)"
+        "UMask": "0x10"
     },
     {
-        "PEBS": "1",
+        "BriefDescription": "Memory instructions retired above 1024 clocks (Precise Event)",
+        "Counter": "3",
         "EventCode": "0xB",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "MEM_INST_RETIRED.STORES",
-        "SampleAfterValue": "2000000",
-        "BriefDescription": "Instructions retired which contains a store (Precise Event)"
+        "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_1024",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x400",
+        "PEBS": "2",
+        "SampleAfterValue": "100",
+        "UMask": "0x10"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xCB",
-        "Counter": "0,1,2,3",
-        "UMask": "0x40",
-        "EventName": "MEM_LOAD_RETIRED.HIT_LFB",
-        "SampleAfterValue": "200000",
-        "BriefDescription": "Retired loads that miss L1D and hit an previously allocated LFB (Precise Event)"
+        "BriefDescription": "Memory instructions retired above 128 clocks (Precise Event)",
+        "Counter": "3",
+        "EventCode": "0xB",
+        "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_128",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x80",
+        "PEBS": "2",
+        "SampleAfterValue": "1000",
+        "UMask": "0x10"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xCB",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "MEM_LOAD_RETIRED.L1D_HIT",
-        "SampleAfterValue": "2000000",
-        "BriefDescription": "Retired loads that hit the L1 data cache (Precise Event)"
+        "BriefDescription": "Memory instructions retired above 16 clocks (Precise Event)",
+        "Counter": "3",
+        "EventCode": "0xB",
+        "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_16",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x10",
+        "PEBS": "2",
+        "SampleAfterValue": "10000",
+        "UMask": "0x10"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xCB",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "MEM_LOAD_RETIRED.L2_HIT",
-        "SampleAfterValue": "200000",
-        "BriefDescription": "Retired loads that hit the L2 cache (Precise Event)"
-    },
-    {
-        "PEBS": "1",
-        "EventCode": "0xCB",
-        "Counter": "0,1,2,3",
-        "UMask": "0x10",
-        "EventName": "MEM_LOAD_RETIRED.LLC_MISS",
-        "SampleAfterValue": "10000",
-        "BriefDescription": "Retired loads that miss the LLC cache (Precise Event)"
-    },
-    {
-        "PEBS": "1",
-        "EventCode": "0xCB",
-        "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "MEM_LOAD_RETIRED.LLC_UNSHARED_HIT",
-        "SampleAfterValue": "40000",
-        "BriefDescription": "Retired loads that hit valid versions in the LLC cache (Precise Event)"
-    },
-    {
-        "PEBS": "1",
-        "EventCode": "0xCB",
-        "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "MEM_LOAD_RETIRED.OTHER_CORE_L2_HIT_HITM",
-        "SampleAfterValue": "40000",
-        "BriefDescription": "Retired loads that hit sibling core's L2 in modified or unmodified states (Precise Event)"
-    },
-    {
-        "EventCode": "0xB0",
-        "Counter": "0,1,2,3",
-        "UMask": "0x40",
-        "EventName": "OFFCORE_REQUESTS.L1D_WRITEBACK",
-        "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore L1 data cache writebacks"
-    },
-    {
-        "EventCode": "0xB2",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "OFFCORE_REQUESTS_SQ_FULL",
-        "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore requests blocked due to Super Queue full"
-    },
-    {
-        "EventCode": "0xF4",
-        "Counter": "0,1,2,3",
-        "UMask": "0x10",
-        "EventName": "SQ_MISC.SPLIT_LOCK",
-        "SampleAfterValue": "2000000",
-        "BriefDescription": "Super Queue lock splits across a cache line"
-    },
-    {
-        "EventCode": "0x6",
-        "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "STORE_BLOCKS.AT_RET",
-        "SampleAfterValue": "200000",
-        "BriefDescription": "Loads delayed with at-Retirement block code"
-    },
-    {
-        "EventCode": "0x6",
-        "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "STORE_BLOCKS.L1D_BLOCK",
-        "SampleAfterValue": "200000",
-        "BriefDescription": "Cacheable loads delayed with L1D block code"
-    },
-    {
-        "PEBS": "2",
-        "EventCode": "0xB",
-        "MSRValue": "0x0",
-        "Counter": "3",
-        "UMask": "0x10",
-        "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_0",
-        "MSRIndex": "0x3F6",
-        "SampleAfterValue": "2000000",
-        "BriefDescription": "Memory instructions retired above 0 clocks (Precise Event)"
-    },
-    {
-        "PEBS": "2",
-        "EventCode": "0xB",
-        "MSRValue": "0x400",
-        "Counter": "3",
-        "UMask": "0x10",
-        "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_1024",
-        "MSRIndex": "0x3F6",
-        "SampleAfterValue": "100",
-        "BriefDescription": "Memory instructions retired above 1024 clocks (Precise Event)"
-    },
-    {
-        "PEBS": "2",
-        "EventCode": "0xB",
-        "MSRValue": "0x80",
-        "Counter": "3",
-        "UMask": "0x10",
-        "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_128",
-        "MSRIndex": "0x3F6",
-        "SampleAfterValue": "1000",
-        "BriefDescription": "Memory instructions retired above 128 clocks (Precise Event)"
-    },
-    {
-        "PEBS": "2",
-        "EventCode": "0xB",
-        "MSRValue": "0x10",
+        "BriefDescription": "Memory instructions retired above 16384 clocks (Precise Event)",
         "Counter": "3",
-        "UMask": "0x10",
-        "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_16",
-        "MSRIndex": "0x3F6",
-        "SampleAfterValue": "10000",
-        "BriefDescription": "Memory instructions retired above 16 clocks (Precise Event)"
-    },
-    {
-        "PEBS": "2",
         "EventCode": "0xB",
-        "MSRValue": "0x4000",
-        "Counter": "3",
-        "UMask": "0x10",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_16384",
         "MSRIndex": "0x3F6",
+        "MSRValue": "0x4000",
+        "PEBS": "2",
         "SampleAfterValue": "5",
-        "BriefDescription": "Memory instructions retired above 16384 clocks (Precise Event)"
+        "UMask": "0x10"
     },
     {
-        "PEBS": "2",
-        "EventCode": "0xB",
-        "MSRValue": "0x800",
+        "BriefDescription": "Memory instructions retired above 2048 clocks (Precise Event)",
         "Counter": "3",
-        "UMask": "0x10",
+        "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_2048",
         "MSRIndex": "0x3F6",
+        "MSRValue": "0x800",
+        "PEBS": "2",
         "SampleAfterValue": "50",
-        "BriefDescription": "Memory instructions retired above 2048 clocks (Precise Event)"
+        "UMask": "0x10"
     },
     {
-        "PEBS": "2",
-        "EventCode": "0xB",
-        "MSRValue": "0x100",
+        "BriefDescription": "Memory instructions retired above 256 clocks (Precise Event)",
         "Counter": "3",
-        "UMask": "0x10",
+        "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_256",
         "MSRIndex": "0x3F6",
+        "MSRValue": "0x100",
+        "PEBS": "2",
         "SampleAfterValue": "500",
-        "BriefDescription": "Memory instructions retired above 256 clocks (Precise Event)"
+        "UMask": "0x10"
     },
     {
-        "PEBS": "2",
-        "EventCode": "0xB",
-        "MSRValue": "0x20",
+        "BriefDescription": "Memory instructions retired above 32 clocks (Precise Event)",
         "Counter": "3",
-        "UMask": "0x10",
+        "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_32",
         "MSRIndex": "0x3F6",
+        "MSRValue": "0x20",
+        "PEBS": "2",
         "SampleAfterValue": "5000",
-        "BriefDescription": "Memory instructions retired above 32 clocks (Precise Event)"
+        "UMask": "0x10"
     },
     {
-        "PEBS": "2",
-        "EventCode": "0xB",
-        "MSRValue": "0x8000",
+        "BriefDescription": "Memory instructions retired above 32768 clocks (Precise Event)",
         "Counter": "3",
-        "UMask": "0x10",
+        "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_32768",
         "MSRIndex": "0x3F6",
+        "MSRValue": "0x8000",
+        "PEBS": "2",
         "SampleAfterValue": "3",
-        "BriefDescription": "Memory instructions retired above 32768 clocks (Precise Event)"
+        "UMask": "0x10"
     },
     {
-        "PEBS": "2",
-        "EventCode": "0xB",
-        "MSRValue": "0x4",
+        "BriefDescription": "Memory instructions retired above 4 clocks (Precise Event)",
         "Counter": "3",
-        "UMask": "0x10",
+        "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_4",
         "MSRIndex": "0x3F6",
+        "MSRValue": "0x4",
+        "PEBS": "2",
         "SampleAfterValue": "50000",
-        "BriefDescription": "Memory instructions retired above 4 clocks (Precise Event)"
+        "UMask": "0x10"
     },
     {
-        "PEBS": "2",
-        "EventCode": "0xB",
-        "MSRValue": "0x1000",
+        "BriefDescription": "Memory instructions retired above 4096 clocks (Precise Event)",
         "Counter": "3",
-        "UMask": "0x10",
+        "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_4096",
         "MSRIndex": "0x3F6",
+        "MSRValue": "0x1000",
+        "PEBS": "2",
         "SampleAfterValue": "20",
-        "BriefDescription": "Memory instructions retired above 4096 clocks (Precise Event)"
+        "UMask": "0x10"
     },
     {
-        "PEBS": "2",
-        "EventCode": "0xB",
-        "MSRValue": "0x200",
+        "BriefDescription": "Memory instructions retired above 512 clocks (Precise Event)",
         "Counter": "3",
-        "UMask": "0x10",
+        "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_512",
         "MSRIndex": "0x3F6",
+        "MSRValue": "0x200",
+        "PEBS": "2",
         "SampleAfterValue": "200",
-        "BriefDescription": "Memory instructions retired above 512 clocks (Precise Event)"
+        "UMask": "0x10"
     },
     {
-        "PEBS": "2",
-        "EventCode": "0xB",
-        "MSRValue": "0x40",
+        "BriefDescription": "Memory instructions retired above 64 clocks (Precise Event)",
         "Counter": "3",
-        "UMask": "0x10",
+        "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_64",
         "MSRIndex": "0x3F6",
+        "MSRValue": "0x40",
+        "PEBS": "2",
         "SampleAfterValue": "2000",
-        "BriefDescription": "Memory instructions retired above 64 clocks (Precise Event)"
+        "UMask": "0x10"
     },
     {
-        "PEBS": "2",
-        "EventCode": "0xB",
-        "MSRValue": "0x8",
+        "BriefDescription": "Memory instructions retired above 8 clocks (Precise Event)",
         "Counter": "3",
-        "UMask": "0x10",
+        "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_8",
         "MSRIndex": "0x3F6",
+        "MSRValue": "0x8",
+        "PEBS": "2",
         "SampleAfterValue": "20000",
-        "BriefDescription": "Memory instructions retired above 8 clocks (Precise Event)"
+        "UMask": "0x10"
     },
     {
-        "PEBS": "2",
-        "EventCode": "0xB",
-        "MSRValue": "0x2000",
+        "BriefDescription": "Memory instructions retired above 8192 clocks (Precise Event)",
         "Counter": "3",
-        "UMask": "0x10",
+        "EventCode": "0xB",
         "EventName": "MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD_8192",
         "MSRIndex": "0x3F6",
+        "MSRValue": "0x2000",
+        "PEBS": "2",
         "SampleAfterValue": "10",
-        "BriefDescription": "Memory instructions retired above 8192 clocks (Precise Event)"
+        "UMask": "0x10"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7F11",
+        "BriefDescription": "Instructions retired which contains a load (Precise Event)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB",
+        "EventName": "MEM_INST_RETIRED.LOADS",
+        "PEBS": "1",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Instructions retired which contains a store (Precise Event)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB",
+        "EventName": "MEM_INST_RETIRED.STORES",
+        "PEBS": "1",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired loads that miss L1D and hit an previously allocated LFB (Precise Event)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xCB",
+        "EventName": "MEM_LOAD_RETIRED.HIT_LFB",
+        "PEBS": "1",
+        "SampleAfterValue": "200000",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Retired loads that hit the L1 data cache (Precise Event)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xCB",
+        "EventName": "MEM_LOAD_RETIRED.L1D_HIT",
+        "PEBS": "1",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired loads that hit the L2 cache (Precise Event)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xCB",
+        "EventName": "MEM_LOAD_RETIRED.L2_HIT",
+        "PEBS": "1",
+        "SampleAfterValue": "200000",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired loads that miss the LLC cache (Precise Event)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xCB",
+        "EventName": "MEM_LOAD_RETIRED.LLC_MISS",
+        "PEBS": "1",
+        "SampleAfterValue": "10000",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Retired loads that hit valid versions in the LLC cache (Precise Event)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xCB",
+        "EventName": "MEM_LOAD_RETIRED.LLC_UNSHARED_HIT",
+        "PEBS": "1",
+        "SampleAfterValue": "40000",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Retired loads that hit sibling core's L2 in modified or unmodified states (Precise Event)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xCB",
+        "EventName": "MEM_LOAD_RETIRED.OTHER_CORE_L2_HIT_HITM",
+        "PEBS": "1",
+        "SampleAfterValue": "40000",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Offcore L1 data cache writebacks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "OFFCORE_REQUESTS.L1D_WRITEBACK",
+        "SampleAfterValue": "100000",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Offcore requests blocked due to Super Queue full",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "OFFCORE_REQUESTS_SQ_FULL",
+        "SampleAfterValue": "100000",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Offcore data reads satisfied by any cache or DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7F11",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads satisfied by any cache or DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFF11",
+        "BriefDescription": "All offcore data reads",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFF11",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All offcore data reads",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8011",
+        "BriefDescription": "Offcore data reads satisfied by the IO, CSR, MMIO unit",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8011",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads satisfied by the IO, CSR, MMIO unit",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x111",
+        "BriefDescription": "Offcore data reads satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x111",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads satisfied by the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x211",
+        "BriefDescription": "Offcore data reads satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x211",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads satisfied by the LLC and HIT in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x411",
+        "BriefDescription": "Offcore data reads satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x411",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads satisfied by the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x711",
+        "BriefDescription": "Offcore data reads satisfied by the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x711",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads satisfied by the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4711",
+        "BriefDescription": "Offcore data reads satisfied by the LLC or local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4711",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads satisfied by the LLC or local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1811",
+        "BriefDescription": "Offcore data reads satisfied by a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1811",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads satisfied by a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x3811",
+        "BriefDescription": "Offcore data reads satisfied by a remote cache or remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x3811",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads satisfied by a remote cache or remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1011",
+        "BriefDescription": "Offcore data reads that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1011",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads that HIT in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x811",
+        "BriefDescription": "Offcore data reads that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x811",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7F44",
+        "BriefDescription": "Offcore code reads satisfied by any cache or DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7F44",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code reads satisfied by any cache or DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFF44",
+        "BriefDescription": "All offcore code reads",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFF44",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All offcore code reads",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8044",
+        "BriefDescription": "Offcore code reads satisfied by the IO, CSR, MMIO unit",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8044",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code reads satisfied by the IO, CSR, MMIO unit",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x144",
+        "BriefDescription": "Offcore code reads satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x144",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code reads satisfied by the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x244",
+        "BriefDescription": "Offcore code reads satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x244",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code reads satisfied by the LLC and HIT in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x444",
+        "BriefDescription": "Offcore code reads satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x444",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code reads satisfied by the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x744",
+        "BriefDescription": "Offcore code reads satisfied by the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x744",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code reads satisfied by the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4744",
+        "BriefDescription": "Offcore code reads satisfied by the LLC or local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4744",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code reads satisfied by the LLC or local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1844",
+        "BriefDescription": "Offcore code reads satisfied by a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1844",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code reads satisfied by a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x3844",
+        "BriefDescription": "Offcore code reads satisfied by a remote cache or remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x3844",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code reads satisfied by a remote cache or remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1044",
+        "BriefDescription": "Offcore code reads that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1044",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code reads that HIT in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x844",
+        "BriefDescription": "Offcore code reads that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x844",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code reads that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7FFF",
+        "BriefDescription": "Offcore requests satisfied by any cache or DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7FFF",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore requests satisfied by any cache or DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFFFF",
+        "BriefDescription": "All offcore requests",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFFFF",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All offcore requests",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x80FF",
+        "BriefDescription": "Offcore requests satisfied by the IO, CSR, MMIO unit",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x80FF",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore requests satisfied by the IO, CSR, MMIO unit",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1FF",
+        "BriefDescription": "Offcore requests satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1FF",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore requests satisfied by the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2FF",
+        "BriefDescription": "Offcore requests satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2FF",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore requests satisfied by the LLC and HIT in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4FF",
+        "BriefDescription": "Offcore requests satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4FF",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore requests satisfied by the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7FF",
+        "BriefDescription": "Offcore requests satisfied by the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7FF",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore requests satisfied by the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x47FF",
+        "BriefDescription": "Offcore requests satisfied by the LLC or local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x47FF",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore requests satisfied by the LLC or local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x18FF",
+        "BriefDescription": "Offcore requests satisfied by a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x18FF",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore requests satisfied by a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x38FF",
+        "BriefDescription": "Offcore requests satisfied by a remote cache or remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x38FF",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore requests satisfied by a remote cache or remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x10FF",
+        "BriefDescription": "Offcore requests that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x10FF",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore requests that HIT in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8FF",
+        "BriefDescription": "Offcore requests that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8FF",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore requests that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7F22",
+        "BriefDescription": "Offcore RFO requests satisfied by any cache or DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7F22",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore RFO requests satisfied by any cache or DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFF22",
+        "BriefDescription": "All offcore RFO requests",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFF22",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All offcore RFO requests",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8022",
+        "BriefDescription": "Offcore RFO requests satisfied by the IO, CSR, MMIO unit",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8022",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore RFO requests satisfied by the IO, CSR, MMIO unit",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x122",
+        "BriefDescription": "Offcore RFO requests satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x122",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore RFO requests satisfied by the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x222",
+        "BriefDescription": "Offcore RFO requests satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x222",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore RFO requests satisfied by the LLC and HIT in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x422",
+        "BriefDescription": "Offcore RFO requests satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x422",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore RFO requests satisfied by the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x722",
+        "BriefDescription": "Offcore RFO requests satisfied by the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x722",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore RFO requests satisfied by the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4722",
+        "BriefDescription": "Offcore RFO requests satisfied by the LLC or local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4722",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore RFO requests satisfied by the LLC or local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1822",
+        "BriefDescription": "Offcore RFO requests satisfied by a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1822",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore RFO requests satisfied by a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x3822",
+        "BriefDescription": "Offcore RFO requests satisfied by a remote cache or remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x3822",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore RFO requests satisfied by a remote cache or remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1022",
+        "BriefDescription": "Offcore RFO requests that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1022",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore RFO requests that HIT in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x822",
+        "BriefDescription": "Offcore RFO requests that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x822",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore RFO requests that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7F08",
+        "BriefDescription": "Offcore writebacks to any cache or DRAM.",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7F08",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore writebacks to any cache or DRAM.",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFF08",
+        "BriefDescription": "All offcore writebacks",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFF08",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All offcore writebacks",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8008",
+        "BriefDescription": "Offcore writebacks to the IO, CSR, MMIO unit.",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8008",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore writebacks to the IO, CSR, MMIO unit.",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x108",
+        "BriefDescription": "Offcore writebacks to the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x108",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore writebacks to the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x408",
+        "BriefDescription": "Offcore writebacks to the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x408",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore writebacks to the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x708",
+        "BriefDescription": "Offcore writebacks to the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x708",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore writebacks to the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4708",
+        "BriefDescription": "Offcore writebacks to the LLC or local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4708",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore writebacks to the LLC or local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1808",
+        "BriefDescription": "Offcore writebacks to a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1808",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore writebacks to a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x3808",
+        "BriefDescription": "Offcore writebacks to a remote cache or remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x3808",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore writebacks to a remote cache or remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1008",
+        "BriefDescription": "Offcore writebacks that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1008",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore writebacks that HIT in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x808",
+        "BriefDescription": "Offcore writebacks that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x808",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore writebacks that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7F77",
+        "BriefDescription": "Offcore code or data read requests satisfied by any cache or DRAM.",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7F77",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code or data read requests satisfied by any cache or DRAM.",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFF77",
+        "BriefDescription": "All offcore code or data read requests",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFF77",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All offcore code or data read requests",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8077",
+        "BriefDescription": "Offcore code or data read requests satisfied by the IO, CSR, MMIO unit.",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8077",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code or data read requests satisfied by the IO, CSR, MMIO unit.",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x177",
+        "BriefDescription": "Offcore code or data read requests satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x177",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code or data read requests satisfied by the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x277",
+        "BriefDescription": "Offcore code or data read requests satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x277",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code or data read requests satisfied by the LLC and HIT in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x477",
+        "BriefDescription": "Offcore code or data read requests satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x477",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code or data read requests satisfied by the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x777",
+        "BriefDescription": "Offcore code or data read requests satisfied by the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x777",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code or data read requests satisfied by the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4777",
+        "BriefDescription": "Offcore code or data read requests satisfied by the LLC or local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4777",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code or data read requests satisfied by the LLC or local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1877",
+        "BriefDescription": "Offcore code or data read requests satisfied by a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1877",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code or data read requests satisfied by a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x3877",
+        "BriefDescription": "Offcore code or data read requests satisfied by a remote cache or remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x3877",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code or data read requests satisfied by a remote cache or remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1077",
+        "BriefDescription": "Offcore code or data read requests that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1077",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code or data read requests that HIT in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x877",
+        "BriefDescription": "Offcore code or data read requests that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x877",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code or data read requests that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7F33",
+        "BriefDescription": "Offcore request = all data, response = any cache_dram",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7F33",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore request = all data, response = any cache_dram",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFF33",
+        "BriefDescription": "Offcore request = all data, response = any location",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFF33",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore request = all data, response = any location",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8033",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the IO, CSR, MMIO unit",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8033",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the IO, CSR, MMIO unit",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x133",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x133",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x233",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x233",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC and HIT in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x433",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x433",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x733",
+        "BriefDescription": "Offcore request = all data, response = local cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x733",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore request = all data, response = local cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4733",
+        "BriefDescription": "Offcore request = all data, response = local cache or dram",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4733",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore request = all data, response = local cache or dram",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1833",
+        "BriefDescription": "Offcore request = all data, response = remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1833",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore request = all data, response = remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x3833",
+        "BriefDescription": "Offcore request = all data, response = remote cache or dram",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x3833",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore request = all data, response = remote cache or dram",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1033",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1033",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads, RFO's and prefetches that HIT in a remote cache ",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x833",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x833",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads, RFO's and prefetches that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7F03",
+        "BriefDescription": "Offcore demand data requests satisfied by any cache or DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7F03",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data requests satisfied by any cache or DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFF03",
+        "BriefDescription": "All offcore demand data requests",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFF03",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All offcore demand data requests",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8003",
+        "BriefDescription": "Offcore demand data requests satisfied by the IO, CSR, MMIO unit.",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8003",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data requests satisfied by the IO, CSR, MMIO unit.",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x103",
+        "BriefDescription": "Offcore demand data requests satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x103",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data requests satisfied by the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x203",
+        "BriefDescription": "Offcore demand data requests satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x203",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data requests satisfied by the LLC and HIT in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x403",
+        "BriefDescription": "Offcore demand data requests satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x403",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data requests satisfied by the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x703",
+        "BriefDescription": "Offcore demand data requests satisfied by the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x703",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data requests satisfied by the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4703",
+        "BriefDescription": "Offcore demand data requests satisfied by the LLC or local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4703",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data requests satisfied by the LLC or local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1803",
+        "BriefDescription": "Offcore demand data requests satisfied by a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1803",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data requests satisfied by a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x3803",
+        "BriefDescription": "Offcore demand data requests satisfied by a remote cache or remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x3803",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data requests satisfied by a remote cache or remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1003",
+        "BriefDescription": "Offcore demand data requests that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1003",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data requests that HIT in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x803",
+        "BriefDescription": "Offcore demand data requests that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x803",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data requests that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7F01",
+        "BriefDescription": "Offcore demand data reads satisfied by any cache or DRAM.",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7F01",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data reads satisfied by any cache or DRAM.",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFF01",
+        "BriefDescription": "All offcore demand data reads",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFF01",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All offcore demand data reads",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8001",
+        "BriefDescription": "Offcore demand data reads satisfied by the IO, CSR, MMIO unit",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8001",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data reads satisfied by the IO, CSR, MMIO unit",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x101",
+        "BriefDescription": "Offcore demand data reads satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x101",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data reads satisfied by the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x201",
+        "BriefDescription": "Offcore demand data reads satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x201",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data reads satisfied by the LLC and HIT in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x401",
+        "BriefDescription": "Offcore demand data reads satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x401",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data reads satisfied by the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x701",
+        "BriefDescription": "Offcore demand data reads satisfied by the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x701",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data reads satisfied by the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4701",
+        "BriefDescription": "Offcore demand data reads satisfied by the LLC or local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4701",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data reads satisfied by the LLC or local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1801",
+        "BriefDescription": "Offcore demand data reads satisfied by a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1801",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data reads satisfied by a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x3801",
+        "BriefDescription": "Offcore demand data reads satisfied by a remote cache or remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x3801",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data reads satisfied by a remote cache or remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1001",
+        "BriefDescription": "Offcore demand data reads that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1001",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data reads that HIT in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x801",
+        "BriefDescription": "Offcore demand data reads that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x801",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data reads that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7F04",
+        "BriefDescription": "Offcore demand code reads satisfied by any cache or DRAM.",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7F04",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand code reads satisfied by any cache or DRAM.",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFF04",
+        "BriefDescription": "All offcore demand code reads",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFF04",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All offcore demand code reads",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8004",
+        "BriefDescription": "Offcore demand code reads satisfied by the IO, CSR, MMIO unit",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8004",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand code reads satisfied by the IO, CSR, MMIO unit",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x104",
+        "BriefDescription": "Offcore demand code reads satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x104",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand code reads satisfied by the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x204",
+        "BriefDescription": "Offcore demand code reads satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x204",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand code reads satisfied by the LLC and HIT in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x404",
+        "BriefDescription": "Offcore demand code reads satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x404",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand code reads satisfied by the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x704",
+        "BriefDescription": "Offcore demand code reads satisfied by the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x704",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand code reads satisfied by the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4704",
+        "BriefDescription": "Offcore demand code reads satisfied by the LLC or local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4704",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand code reads satisfied by the LLC or local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1804",
+        "BriefDescription": "Offcore demand code reads satisfied by a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1804",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand code reads satisfied by a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x3804",
+        "BriefDescription": "Offcore demand code reads satisfied by a remote cache or remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x3804",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand code reads satisfied by a remote cache or remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1004",
+        "BriefDescription": "Offcore demand code reads that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1004",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand code reads that HIT in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x804",
+        "BriefDescription": "Offcore demand code reads that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x804",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand code reads that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7F02",
+        "BriefDescription": "Offcore demand RFO requests satisfied by any cache or DRAM.",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7F02",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand RFO requests satisfied by any cache or DRAM.",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFF02",
+        "BriefDescription": "All offcore demand RFO requests",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFF02",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All offcore demand RFO requests",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8002",
+        "BriefDescription": "Offcore demand RFO requests satisfied by the IO, CSR, MMIO unit",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8002",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand RFO requests satisfied by the IO, CSR, MMIO unit",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x102",
+        "BriefDescription": "Offcore demand RFO requests satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x102",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand RFO requests satisfied by the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x202",
+        "BriefDescription": "Offcore demand RFO requests satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x202",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand RFO requests satisfied by the LLC and HIT in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x402",
+        "BriefDescription": "Offcore demand RFO requests satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x402",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand RFO requests satisfied by the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x702",
+        "BriefDescription": "Offcore demand RFO requests satisfied by the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x702",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand RFO requests satisfied by the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4702",
+        "BriefDescription": "Offcore demand RFO requests satisfied by the LLC or local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4702",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand RFO requests satisfied by the LLC or local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1802",
+        "BriefDescription": "Offcore demand RFO requests satisfied by a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1802",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand RFO requests satisfied by a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x3802",
+        "BriefDescription": "Offcore demand RFO requests satisfied by a remote cache or remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x3802",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand RFO requests satisfied by a remote cache or remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1002",
+        "BriefDescription": "Offcore demand RFO requests that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1002",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand RFO requests that HIT in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x802",
+        "BriefDescription": "Offcore demand RFO requests that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x802",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand RFO requests that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7F80",
+        "BriefDescription": "Offcore other requests satisfied by any cache or DRAM.",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7F80",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore other requests satisfied by any cache or DRAM.",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFF80",
+        "BriefDescription": "All offcore other requests",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFF80",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All offcore other requests",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8080",
+        "BriefDescription": "Offcore other requests satisfied by the IO, CSR, MMIO unit",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8080",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore other requests satisfied by the IO, CSR, MMIO unit",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x180",
+        "BriefDescription": "Offcore other requests satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x180",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore other requests satisfied by the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x280",
+        "BriefDescription": "Offcore other requests satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x280",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore other requests satisfied by the LLC and HIT in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x480",
+        "BriefDescription": "Offcore other requests satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x480",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore other requests satisfied by the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x780",
+        "BriefDescription": "Offcore other requests satisfied by the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x780",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore other requests satisfied by the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4780",
+        "BriefDescription": "Offcore other requests satisfied by the LLC or local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4780",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore other requests satisfied by the LLC or local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1880",
+        "BriefDescription": "Offcore other requests satisfied by a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1880",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore other requests satisfied by a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x3880",
+        "BriefDescription": "Offcore other requests satisfied by a remote cache or remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x3880",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore other requests satisfied by a remote cache or remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1080",
+        "BriefDescription": "Offcore other requests that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1080",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore other requests that HIT in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x880",
+        "BriefDescription": "Offcore other requests that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x880",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore other requests that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7F30",
+        "BriefDescription": "Offcore prefetch data requests satisfied by any cache or DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7F30",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data requests satisfied by any cache or DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFF30",
+        "BriefDescription": "All offcore prefetch data requests",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFF30",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All offcore prefetch data requests",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8030",
+        "BriefDescription": "Offcore prefetch data requests satisfied by the IO, CSR, MMIO unit.",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8030",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data requests satisfied by the IO, CSR, MMIO unit.",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x130",
+        "BriefDescription": "Offcore prefetch data requests satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x130",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data requests satisfied by the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x230",
+        "BriefDescription": "Offcore prefetch data requests satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x230",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data requests satisfied by the LLC and HIT in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x430",
+        "BriefDescription": "Offcore prefetch data requests satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x430",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data requests satisfied by the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x730",
+        "BriefDescription": "Offcore prefetch data requests satisfied by the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x730",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data requests satisfied by the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4730",
+        "BriefDescription": "Offcore prefetch data requests satisfied by the LLC or local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4730",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data requests satisfied by the LLC or local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1830",
+        "BriefDescription": "Offcore prefetch data requests satisfied by a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1830",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data requests satisfied by a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x3830",
+        "BriefDescription": "Offcore prefetch data requests satisfied by a remote cache or remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x3830",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data requests satisfied by a remote cache or remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1030",
+        "BriefDescription": "Offcore prefetch data requests that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1030",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data requests that HIT in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x830",
+        "BriefDescription": "Offcore prefetch data requests that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x830",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data requests that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7F10",
+        "BriefDescription": "Offcore prefetch data reads satisfied by any cache or DRAM.",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7F10",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data reads satisfied by any cache or DRAM.",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFF10",
+        "BriefDescription": "All offcore prefetch data reads",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFF10",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All offcore prefetch data reads",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8010",
+        "BriefDescription": "Offcore prefetch data reads satisfied by the IO, CSR, MMIO unit",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8010",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data reads satisfied by the IO, CSR, MMIO unit",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x110",
+        "BriefDescription": "Offcore prefetch data reads satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x110",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data reads satisfied by the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x210",
+        "BriefDescription": "Offcore prefetch data reads satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x210",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data reads satisfied by the LLC and HIT in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x410",
+        "BriefDescription": "Offcore prefetch data reads satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x410",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data reads satisfied by the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x710",
+        "BriefDescription": "Offcore prefetch data reads satisfied by the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x710",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data reads satisfied by the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4710",
+        "BriefDescription": "Offcore prefetch data reads satisfied by the LLC or local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4710",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data reads satisfied by the LLC or local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1810",
+        "BriefDescription": "Offcore prefetch data reads satisfied by a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1810",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data reads satisfied by a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x3810",
+        "BriefDescription": "Offcore prefetch data reads satisfied by a remote cache or remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x3810",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data reads satisfied by a remote cache or remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1010",
+        "BriefDescription": "Offcore prefetch data reads that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1010",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data reads that HIT in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x810",
+        "BriefDescription": "Offcore prefetch data reads that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x810",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data reads that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7F40",
+        "BriefDescription": "Offcore prefetch code reads satisfied by any cache or DRAM.",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7F40",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch code reads satisfied by any cache or DRAM.",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFF40",
+        "BriefDescription": "All offcore prefetch code reads",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFF40",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All offcore prefetch code reads",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8040",
+        "BriefDescription": "Offcore prefetch code reads satisfied by the IO, CSR, MMIO unit",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8040",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch code reads satisfied by the IO, CSR, MMIO unit",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x140",
+        "BriefDescription": "Offcore prefetch code reads satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x140",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch code reads satisfied by the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x240",
+        "BriefDescription": "Offcore prefetch code reads satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x240",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch code reads satisfied by the LLC and HIT in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x440",
+        "BriefDescription": "Offcore prefetch code reads satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x440",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch code reads satisfied by the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x740",
+        "BriefDescription": "Offcore prefetch code reads satisfied by the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x740",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch code reads satisfied by the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4740",
+        "BriefDescription": "Offcore prefetch code reads satisfied by the LLC or local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4740",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch code reads satisfied by the LLC or local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1840",
+        "BriefDescription": "Offcore prefetch code reads satisfied by a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1840",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch code reads satisfied by a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x3840",
+        "BriefDescription": "Offcore prefetch code reads satisfied by a remote cache or remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x3840",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch code reads satisfied by a remote cache or remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1040",
+        "BriefDescription": "Offcore prefetch code reads that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1040",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch code reads that HIT in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x840",
+        "BriefDescription": "Offcore prefetch code reads that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x840",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch code reads that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7F20",
+        "BriefDescription": "Offcore prefetch RFO requests satisfied by any cache or DRAM.",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7F20",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch RFO requests satisfied by any cache or DRAM.",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFF20",
+        "BriefDescription": "All offcore prefetch RFO requests",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFF20",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All offcore prefetch RFO requests",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8020",
+        "BriefDescription": "Offcore prefetch RFO requests satisfied by the IO, CSR, MMIO unit",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8020",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch RFO requests satisfied by the IO, CSR, MMIO unit",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x120",
+        "BriefDescription": "Offcore prefetch RFO requests satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x120",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch RFO requests satisfied by the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x220",
+        "BriefDescription": "Offcore prefetch RFO requests satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x220",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch RFO requests satisfied by the LLC and HIT in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x420",
+        "BriefDescription": "Offcore prefetch RFO requests satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x420",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch RFO requests satisfied by the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x720",
+        "BriefDescription": "Offcore prefetch RFO requests satisfied by the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x720",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch RFO requests satisfied by the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4720",
+        "BriefDescription": "Offcore prefetch RFO requests satisfied by the LLC or local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4720",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch RFO requests satisfied by the LLC or local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1820",
+        "BriefDescription": "Offcore prefetch RFO requests satisfied by a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1820",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch RFO requests satisfied by a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x3820",
+        "BriefDescription": "Offcore prefetch RFO requests satisfied by a remote cache or remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x3820",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch RFO requests satisfied by a remote cache or remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1020",
+        "BriefDescription": "Offcore prefetch RFO requests that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1020",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch RFO requests that HIT in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x820",
+        "BriefDescription": "Offcore prefetch RFO requests that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x820",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch RFO requests that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x7F70",
+        "BriefDescription": "Offcore prefetch requests satisfied by any cache or DRAM.",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.ANY_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x7F70",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch requests satisfied by any cache or DRAM.",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xFF70",
+        "BriefDescription": "All offcore prefetch requests",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.ANY_LOCATION",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xFF70",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "All offcore prefetch requests",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x8070",
+        "BriefDescription": "Offcore prefetch requests satisfied by the IO, CSR, MMIO unit",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.IO_CSR_MMIO",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x8070",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch requests satisfied by the IO, CSR, MMIO unit",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x170",
+        "BriefDescription": "Offcore prefetch requests satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.LLC_HIT_NO_OTHER_CORE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x170",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch requests satisfied by the LLC and not found in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x270",
+        "BriefDescription": "Offcore prefetch requests satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.LLC_HIT_OTHER_CORE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x270",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch requests satisfied by the LLC and HIT in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x470",
+        "BriefDescription": "Offcore prefetch requests satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.LLC_HIT_OTHER_CORE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x470",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch requests satisfied by the LLC  and HITM in a sibling core",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x770",
+        "BriefDescription": "Offcore prefetch requests satisfied by the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.LOCAL_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x770",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch requests satisfied by the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4770",
+        "BriefDescription": "Offcore prefetch requests satisfied by the LLC or local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.LOCAL_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4770",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch requests satisfied by the LLC or local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1870",
+        "BriefDescription": "Offcore prefetch requests satisfied by a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.REMOTE_CACHE",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1870",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch requests satisfied by a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x3870",
+        "BriefDescription": "Offcore prefetch requests satisfied by a remote cache or remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.REMOTE_CACHE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x3870",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch requests satisfied by a remote cache or remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x1070",
+        "BriefDescription": "Offcore prefetch requests that HIT in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.REMOTE_CACHE_HIT",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x1070",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch requests that HIT in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x870",
+        "BriefDescription": "Offcore prefetch requests that HITM in a remote cache",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.REMOTE_CACHE_HITM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x870",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch requests that HITM in a remote cache",
-        "Offcore": "1"
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Super Queue lock splits across a cache line",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xF4",
+        "EventName": "SQ_MISC.SPLIT_LOCK",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Loads delayed with at-Retirement block code",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "STORE_BLOCKS.AT_RET",
+        "SampleAfterValue": "200000",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cacheable loads delayed with L1D block code",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "STORE_BLOCKS.L1D_BLOCK",
+        "SampleAfterValue": "200000",
+        "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json b/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
index 7d2f71a9dee3..666e466d351c 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
@@ -1,229 +1,229 @@
 [
     {
-        "PEBS": "1",
-        "EventCode": "0xF7",
+        "BriefDescription": "X87 Floating point assists (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xF7",
         "EventName": "FP_ASSIST.ALL",
+        "PEBS": "1",
         "SampleAfterValue": "20000",
-        "BriefDescription": "X87 Floating point assists (Precise Event)"
+        "UMask": "0x1"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xF7",
+        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0xF7",
         "EventName": "FP_ASSIST.INPUT",
+        "PEBS": "1",
         "SampleAfterValue": "20000",
-        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)"
+        "UMask": "0x4"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xF7",
+        "BriefDescription": "X87 Floating point assists for invalid output value (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xF7",
         "EventName": "FP_ASSIST.OUTPUT",
+        "PEBS": "1",
         "SampleAfterValue": "20000",
-        "BriefDescription": "X87 Floating point assists for invalid output value (Precise Event)"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x10",
+        "BriefDescription": "MMX Uops",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.MMX",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "MMX Uops"
+        "UMask": "0x2"
     },
     {
+        "BriefDescription": "SSE2 integer Uops",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
+        "EventName": "FP_COMP_OPS_EXE.SSE2_INTEGER",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "SSE* FP double precision Uops",
         "Counter": "0,1,2,3",
-        "UMask": "0x80",
+        "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_DOUBLE_PRECISION",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "SSE* FP double precision Uops"
+        "UMask": "0x80"
     },
     {
-        "EventCode": "0x10",
+        "BriefDescription": "SSE and SSE2 FP Uops",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_FP",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "SSE and SSE2 FP Uops"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0x10",
+        "BriefDescription": "SSE FP packed Uops",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
+        "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_FP_PACKED",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "SSE FP packed Uops"
+        "UMask": "0x10"
     },
     {
-        "EventCode": "0x10",
+        "BriefDescription": "SSE FP scalar Uops",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
+        "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_FP_SCALAR",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "SSE FP scalar Uops"
+        "UMask": "0x20"
     },
     {
-        "EventCode": "0x10",
+        "BriefDescription": "SSE* FP single precision Uops",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
+        "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.SSE_SINGLE_PRECISION",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "SSE* FP single precision Uops"
+        "UMask": "0x40"
     },
     {
-        "EventCode": "0x10",
+        "BriefDescription": "Computational floating-point operations executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "FP_COMP_OPS_EXE.SSE2_INTEGER",
-        "SampleAfterValue": "2000000",
-        "BriefDescription": "SSE2 integer Uops"
-    },
-    {
         "EventCode": "0x10",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
         "EventName": "FP_COMP_OPS_EXE.X87",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Computational floating-point operations executed"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xCC",
+        "BriefDescription": "All Floating Point to and from MMX transitions",
         "Counter": "0,1,2,3",
-        "UMask": "0x3",
+        "EventCode": "0xCC",
         "EventName": "FP_MMX_TRANS.ANY",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "All Floating Point to and from MMX transitions"
+        "UMask": "0x3"
     },
     {
-        "EventCode": "0xCC",
+        "BriefDescription": "Transitions from MMX to Floating Point instructions",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xCC",
         "EventName": "FP_MMX_TRANS.TO_FP",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Transitions from MMX to Floating Point instructions"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xCC",
+        "BriefDescription": "Transitions from Floating Point to MMX instructions",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xCC",
         "EventName": "FP_MMX_TRANS.TO_MMX",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Transitions from Floating Point to MMX instructions"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x12",
+        "BriefDescription": "128 bit SIMD integer pack operations",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0x12",
         "EventName": "SIMD_INT_128.PACK",
         "SampleAfterValue": "200000",
-        "BriefDescription": "128 bit SIMD integer pack operations"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0x12",
+        "BriefDescription": "128 bit SIMD integer arithmetic operations",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
+        "EventCode": "0x12",
         "EventName": "SIMD_INT_128.PACKED_ARITH",
         "SampleAfterValue": "200000",
-        "BriefDescription": "128 bit SIMD integer arithmetic operations"
+        "UMask": "0x20"
     },
     {
-        "EventCode": "0x12",
+        "BriefDescription": "128 bit SIMD integer logical operations",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
+        "EventCode": "0x12",
         "EventName": "SIMD_INT_128.PACKED_LOGICAL",
         "SampleAfterValue": "200000",
-        "BriefDescription": "128 bit SIMD integer logical operations"
+        "UMask": "0x10"
     },
     {
-        "EventCode": "0x12",
+        "BriefDescription": "128 bit SIMD integer multiply operations",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x12",
         "EventName": "SIMD_INT_128.PACKED_MPY",
         "SampleAfterValue": "200000",
-        "BriefDescription": "128 bit SIMD integer multiply operations"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x12",
+        "BriefDescription": "128 bit SIMD integer shift operations",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0x12",
         "EventName": "SIMD_INT_128.PACKED_SHIFT",
         "SampleAfterValue": "200000",
-        "BriefDescription": "128 bit SIMD integer shift operations"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x12",
+        "BriefDescription": "128 bit SIMD integer shuffle/move operations",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
+        "EventCode": "0x12",
         "EventName": "SIMD_INT_128.SHUFFLE_MOVE",
         "SampleAfterValue": "200000",
-        "BriefDescription": "128 bit SIMD integer shuffle/move operations"
+        "UMask": "0x40"
     },
     {
-        "EventCode": "0x12",
+        "BriefDescription": "128 bit SIMD integer unpack operations",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
+        "EventCode": "0x12",
         "EventName": "SIMD_INT_128.UNPACK",
         "SampleAfterValue": "200000",
-        "BriefDescription": "128 bit SIMD integer unpack operations"
+        "UMask": "0x8"
     },
     {
-        "EventCode": "0xFD",
+        "BriefDescription": "SIMD integer 64 bit pack operations",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0xFD",
         "EventName": "SIMD_INT_64.PACK",
         "SampleAfterValue": "200000",
-        "BriefDescription": "SIMD integer 64 bit pack operations"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0xFD",
+        "BriefDescription": "SIMD integer 64 bit arithmetic operations",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
+        "EventCode": "0xFD",
         "EventName": "SIMD_INT_64.PACKED_ARITH",
         "SampleAfterValue": "200000",
-        "BriefDescription": "SIMD integer 64 bit arithmetic operations"
+        "UMask": "0x20"
     },
     {
-        "EventCode": "0xFD",
+        "BriefDescription": "SIMD integer 64 bit logical operations",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
+        "EventCode": "0xFD",
         "EventName": "SIMD_INT_64.PACKED_LOGICAL",
         "SampleAfterValue": "200000",
-        "BriefDescription": "SIMD integer 64 bit logical operations"
+        "UMask": "0x10"
     },
     {
-        "EventCode": "0xFD",
+        "BriefDescription": "SIMD integer 64 bit packed multiply operations",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xFD",
         "EventName": "SIMD_INT_64.PACKED_MPY",
         "SampleAfterValue": "200000",
-        "BriefDescription": "SIMD integer 64 bit packed multiply operations"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xFD",
+        "BriefDescription": "SIMD integer 64 bit shift operations",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xFD",
         "EventName": "SIMD_INT_64.PACKED_SHIFT",
         "SampleAfterValue": "200000",
-        "BriefDescription": "SIMD integer 64 bit shift operations"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0xFD",
+        "BriefDescription": "SIMD integer 64 bit shuffle/move operations",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
+        "EventCode": "0xFD",
         "EventName": "SIMD_INT_64.SHUFFLE_MOVE",
         "SampleAfterValue": "200000",
-        "BriefDescription": "SIMD integer 64 bit shuffle/move operations"
+        "UMask": "0x40"
     },
     {
-        "EventCode": "0xFD",
+        "BriefDescription": "SIMD integer 64 bit unpack operations",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
+        "EventCode": "0xFD",
         "EventName": "SIMD_INT_64.UNPACK",
         "SampleAfterValue": "200000",
-        "BriefDescription": "SIMD integer 64 bit unpack operations"
+        "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/frontend.json b/tools/perf/pmu-events/arch/x86/nehalemex/frontend.json
index e5e21e03444d..c561ac24d91d 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/frontend.json
@@ -1,26 +1,26 @@
 [
     {
-        "EventCode": "0xD0",
+        "BriefDescription": "Instructions decoded",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xD0",
         "EventName": "MACRO_INSTS.DECODED",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Instructions decoded"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xA6",
+        "BriefDescription": "Macro-fused instructions decoded",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xA6",
         "EventName": "MACRO_INSTS.FUSIONS_DECODED",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Macro-fused instructions decoded"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x19",
+        "BriefDescription": "Two Uop instructions decoded",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x19",
         "EventName": "TWO_UOP_INSTS_DECODED",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Two Uop instructions decoded"
+        "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/memory.json b/tools/perf/pmu-events/arch/x86/nehalemex/memory.json
index f914a4525b65..6e95de3f3409 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/memory.json
@@ -1,739 +1,739 @@
 [
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x6011",
+        "BriefDescription": "Offcore data reads satisfied by any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x6011",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads satisfied by any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF811",
+        "BriefDescription": "Offcore data reads that missed the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF811",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads that missed the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4011",
+        "BriefDescription": "Offcore data reads satisfied by the local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4011",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads satisfied by the local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2011",
+        "BriefDescription": "Offcore data reads satisfied by a remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2011",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads satisfied by a remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x6044",
+        "BriefDescription": "Offcore code reads satisfied by any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x6044",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code reads satisfied by any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF844",
+        "BriefDescription": "Offcore code reads that missed the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF844",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code reads that missed the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4044",
+        "BriefDescription": "Offcore code reads satisfied by the local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4044",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code reads satisfied by the local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2044",
+        "BriefDescription": "Offcore code reads satisfied by a remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_IFETCH.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2044",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code reads satisfied by a remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x60FF",
+        "BriefDescription": "Offcore requests satisfied by any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x60FF",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore requests satisfied by any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF8FF",
+        "BriefDescription": "Offcore requests that missed the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF8FF",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore requests that missed the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x40FF",
+        "BriefDescription": "Offcore requests satisfied by the local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x40FF",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore requests satisfied by the local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x20FF",
+        "BriefDescription": "Offcore requests satisfied by a remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x20FF",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore requests satisfied by a remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x6022",
+        "BriefDescription": "Offcore RFO requests satisfied by any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x6022",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore RFO requests satisfied by any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF822",
+        "BriefDescription": "Offcore RFO requests that missed the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF822",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore RFO requests that missed the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4022",
+        "BriefDescription": "Offcore RFO requests satisfied by the local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4022",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore RFO requests satisfied by the local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2022",
+        "BriefDescription": "Offcore RFO requests satisfied by a remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2022",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore RFO requests satisfied by a remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x6008",
+        "BriefDescription": "Offcore writebacks to any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x6008",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore writebacks to any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF808",
+        "BriefDescription": "Offcore writebacks that missed the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF808",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore writebacks that missed the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4008",
+        "BriefDescription": "Offcore writebacks to the local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4008",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore writebacks to the local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2008",
+        "BriefDescription": "Offcore writebacks to a remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.COREWB.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2008",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore writebacks to a remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x6077",
+        "BriefDescription": "Offcore code or data read requests satisfied by any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x6077",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code or data read requests satisfied by any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF877",
+        "BriefDescription": "Offcore code or data read requests that missed the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF877",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code or data read requests that missed the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4077",
+        "BriefDescription": "Offcore code or data read requests satisfied by the local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4077",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code or data read requests satisfied by the local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2077",
+        "BriefDescription": "Offcore code or data read requests satisfied by a remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IFETCH.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2077",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore code or data read requests satisfied by a remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x6033",
+        "BriefDescription": "Offcore request = all data, response = any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x6033",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore request = all data, response = any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF833",
+        "BriefDescription": "Offcore request = all data, response = any LLC miss",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF833",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore request = all data, response = any LLC miss",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4033",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the local DRAM.",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4033",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the local DRAM.",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2033",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2033",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x6003",
+        "BriefDescription": "Offcore demand data requests satisfied by any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x6003",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data requests satisfied by any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF803",
+        "BriefDescription": "Offcore demand data requests that missed the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF803",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data requests that missed the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4003",
+        "BriefDescription": "Offcore demand data requests satisfied by the local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4003",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data requests satisfied by the local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2003",
+        "BriefDescription": "Offcore demand data requests satisfied by a remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2003",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data requests satisfied by a remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x6001",
+        "BriefDescription": "Offcore demand data reads satisfied by any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x6001",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data reads satisfied by any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF801",
+        "BriefDescription": "Offcore demand data reads that missed the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF801",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data reads that missed the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4001",
+        "BriefDescription": "Offcore demand data reads satisfied by the local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4001",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data reads satisfied by the local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2001",
+        "BriefDescription": "Offcore demand data reads satisfied by a remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2001",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand data reads satisfied by a remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x6004",
+        "BriefDescription": "Offcore demand code reads satisfied by any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x6004",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand code reads satisfied by any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF804",
+        "BriefDescription": "Offcore demand code reads that missed the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF804",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand code reads that missed the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4004",
+        "BriefDescription": "Offcore demand code reads satisfied by the local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4004",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand code reads satisfied by the local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2004",
+        "BriefDescription": "Offcore demand code reads satisfied by a remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2004",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand code reads satisfied by a remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x6002",
+        "BriefDescription": "Offcore demand RFO requests satisfied by any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x6002",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand RFO requests satisfied by any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF802",
+        "BriefDescription": "Offcore demand RFO requests that missed the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF802",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand RFO requests that missed the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4002",
+        "BriefDescription": "Offcore demand RFO requests satisfied by the local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4002",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand RFO requests satisfied by the local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2002",
+        "BriefDescription": "Offcore demand RFO requests satisfied by a remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2002",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore demand RFO requests satisfied by a remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x6080",
+        "BriefDescription": "Offcore other requests satisfied by any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x6080",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore other requests satisfied by any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF880",
+        "BriefDescription": "Offcore other requests that missed the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF880",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore other requests that missed the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2080",
+        "BriefDescription": "Offcore other requests satisfied by a remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.OTHER.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2080",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore other requests satisfied by a remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x6030",
+        "BriefDescription": "Offcore prefetch data requests satisfied by any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x6030",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data requests satisfied by any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF830",
+        "BriefDescription": "Offcore prefetch data requests that missed the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF830",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data requests that missed the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4030",
+        "BriefDescription": "Offcore prefetch data requests satisfied by the local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4030",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data requests satisfied by the local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2030",
+        "BriefDescription": "Offcore prefetch data requests satisfied by a remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2030",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data requests satisfied by a remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x6010",
+        "BriefDescription": "Offcore prefetch data reads satisfied by any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x6010",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data reads satisfied by any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF810",
+        "BriefDescription": "Offcore prefetch data reads that missed the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF810",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data reads that missed the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4010",
+        "BriefDescription": "Offcore prefetch data reads satisfied by the local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4010",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data reads satisfied by the local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2010",
+        "BriefDescription": "Offcore prefetch data reads satisfied by a remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2010",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch data reads satisfied by a remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x6040",
+        "BriefDescription": "Offcore prefetch code reads satisfied by any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x6040",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch code reads satisfied by any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF840",
+        "BriefDescription": "Offcore prefetch code reads that missed the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF840",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch code reads that missed the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4040",
+        "BriefDescription": "Offcore prefetch code reads satisfied by the local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4040",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch code reads satisfied by the local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2040",
+        "BriefDescription": "Offcore prefetch code reads satisfied by a remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2040",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch code reads satisfied by a remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x6020",
+        "BriefDescription": "Offcore prefetch RFO requests satisfied by any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x6020",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch RFO requests satisfied by any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF820",
+        "BriefDescription": "Offcore prefetch RFO requests that missed the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF820",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch RFO requests that missed the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4020",
+        "BriefDescription": "Offcore prefetch RFO requests satisfied by the local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4020",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch RFO requests satisfied by the local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2020",
+        "BriefDescription": "Offcore prefetch RFO requests satisfied by a remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_RFO.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2020",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch RFO requests satisfied by a remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x6070",
+        "BriefDescription": "Offcore prefetch requests satisfied by any DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.ANY_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x6070",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch requests satisfied by any DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0xF870",
+        "BriefDescription": "Offcore prefetch requests that missed the LLC",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.ANY_LLC_MISS",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0xF870",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch requests that missed the LLC",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x4070",
+        "BriefDescription": "Offcore prefetch requests satisfied by the local DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.LOCAL_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x4070",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch requests satisfied by the local DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB7",
-        "MSRValue": "0x2070",
+        "BriefDescription": "Offcore prefetch requests satisfied by a remote DRAM",
         "Counter": "2",
-        "UMask": "0x1",
+        "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PREFETCH.REMOTE_DRAM",
         "MSRIndex": "0x1A6",
+        "MSRValue": "0x2070",
+        "Offcore": "1",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Offcore prefetch requests satisfied by a remote DRAM",
-        "Offcore": "1"
+        "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/other.json b/tools/perf/pmu-events/arch/x86/nehalemex/other.json
index af0860622445..f6887b234b0e 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/other.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/other.json
@@ -1,210 +1,146 @@
 [
     {
-        "EventCode": "0xE8",
+        "BriefDescription": "ES segment renames",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "BPU_CLEARS.EARLY",
-        "SampleAfterValue": "2000000",
-        "BriefDescription": "Early Branch Prediciton Unit clears"
-    },
-    {
-        "EventCode": "0xE8",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "BPU_CLEARS.LATE",
-        "SampleAfterValue": "2000000",
-        "BriefDescription": "Late Branch Prediction Unit clears"
-    },
-    {
-        "EventCode": "0xE5",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "BPU_MISSED_CALL_RET",
-        "SampleAfterValue": "2000000",
-        "BriefDescription": "Branch prediction unit missed call or return"
-    },
-    {
         "EventCode": "0xD5",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
         "EventName": "ES_REG_RENAMES",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "ES segment renames"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x6C",
+        "BriefDescription": "I/O transactions",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x6C",
         "EventName": "IO_TRANSACTIONS",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "I/O transactions"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x80",
+        "BriefDescription": "L1I instruction fetch stall cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0x80",
         "EventName": "L1I.CYCLES_STALLED",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1I instruction fetch stall cycles"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0x80",
+        "BriefDescription": "L1I instruction fetch hits",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x80",
         "EventName": "L1I.HITS",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1I instruction fetch hits"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x80",
+        "BriefDescription": "L1I instruction fetch misses",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0x80",
         "EventName": "L1I.MISSES",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1I instruction fetch misses"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x80",
+        "BriefDescription": "L1I Instruction fetches",
         "Counter": "0,1,2,3",
-        "UMask": "0x3",
+        "EventCode": "0x80",
         "EventName": "L1I.READS",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "L1I Instruction fetches"
+        "UMask": "0x3"
     },
     {
-        "EventCode": "0x82",
+        "BriefDescription": "Large ITLB hit",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x82",
         "EventName": "LARGE_ITLB.HIT",
         "SampleAfterValue": "200000",
-        "BriefDescription": "Large ITLB hit"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x13",
+        "BriefDescription": "All loads dispatched",
         "Counter": "0,1,2,3",
-        "UMask": "0x7",
+        "EventCode": "0x13",
         "EventName": "LOAD_DISPATCH.ANY",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "All loads dispatched"
+        "UMask": "0x7"
     },
     {
-        "EventCode": "0x13",
+        "BriefDescription": "Loads dispatched from the MOB",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0x13",
         "EventName": "LOAD_DISPATCH.MOB",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Loads dispatched from the MOB"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0x13",
+        "BriefDescription": "Loads dispatched that bypass the MOB",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x13",
         "EventName": "LOAD_DISPATCH.RS",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Loads dispatched that bypass the MOB"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x13",
+        "BriefDescription": "Loads dispatched from stage 305",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0x13",
         "EventName": "LOAD_DISPATCH.RS_DELAYED",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Loads dispatched from stage 305"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x7",
+        "BriefDescription": "False dependencies due to partial address aliasing",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x7",
         "EventName": "PARTIAL_ADDRESS_ALIAS",
         "SampleAfterValue": "200000",
-        "BriefDescription": "False dependencies due to partial address aliasing"
-    },
-    {
-        "EventCode": "0xD2",
-        "Counter": "0,1,2,3",
-        "UMask": "0xf",
-        "EventName": "RAT_STALLS.ANY",
-        "SampleAfterValue": "2000000",
-        "BriefDescription": "All RAT stall cycles"
-    },
-    {
-        "EventCode": "0xD2",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "RAT_STALLS.FLAGS",
-        "SampleAfterValue": "2000000",
-        "BriefDescription": "Flag stall cycles"
-    },
-    {
-        "EventCode": "0xD2",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "RAT_STALLS.REGISTERS",
-        "SampleAfterValue": "2000000",
-        "BriefDescription": "Partial register stall cycles"
-    },
-    {
-        "EventCode": "0xD2",
-        "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "RAT_STALLS.ROB_READ_PORT",
-        "SampleAfterValue": "2000000",
-        "BriefDescription": "ROB read port stalls cycles"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xD2",
+        "BriefDescription": "All Store buffer stall cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "RAT_STALLS.SCOREBOARD",
-        "SampleAfterValue": "2000000",
-        "BriefDescription": "Scoreboard stall cycles"
-    },
-    {
         "EventCode": "0x4",
-        "Counter": "0,1,2,3",
-        "UMask": "0x7",
         "EventName": "SB_DRAIN.ANY",
         "SampleAfterValue": "200000",
-        "BriefDescription": "All Store buffer stall cycles"
+        "UMask": "0x7"
     },
     {
-        "EventCode": "0xD4",
+        "BriefDescription": "Segment rename stall cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xD4",
         "EventName": "SEG_RENAME_STALLS",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Segment rename stall cycles"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB8",
+        "BriefDescription": "Thread responded HIT to snoop",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xB8",
         "EventName": "SNOOP_RESPONSE.HIT",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Thread responded HIT to snoop"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB8",
+        "BriefDescription": "Thread responded HITE to snoop",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xB8",
         "EventName": "SNOOP_RESPONSE.HITE",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Thread responded HITE to snoop"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0xB8",
+        "BriefDescription": "Thread responded HITM to snoop",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0xB8",
         "EventName": "SNOOP_RESPONSE.HITM",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Thread responded HITM to snoop"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0xF6",
+        "BriefDescription": "Super Queue full stall cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xF6",
         "EventName": "SQ_FULL_STALL_CYCLES",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Super Queue full stall cycles"
+        "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json b/tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json
index 41006ddcd893..6fc1a6efd8e8 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json
@@ -1,881 +1,945 @@
 [
     {
-        "EventCode": "0x14",
+        "BriefDescription": "Cycles the divider is busy",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x14",
         "EventName": "ARITH.CYCLES_DIV_BUSY",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles the divider is busy"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x14",
-        "Invert": "1",
+        "BriefDescription": "Divide Operations executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0x14",
         "EventName": "ARITH.DIV",
+        "Invert": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Divide Operations executed",
-        "CounterMask": "1",
-        "EdgeDetect": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x14",
+        "BriefDescription": "Multiply operations executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0x14",
         "EventName": "ARITH.MUL",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Multiply operations executed"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0xE6",
+        "BriefDescription": "BACLEAR asserted with bad target address",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xE6",
         "EventName": "BACLEAR.BAD_TARGET",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "BACLEAR asserted with bad target address"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0xE6",
+        "BriefDescription": "BACLEAR asserted, regardless of cause",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xE6",
         "EventName": "BACLEAR.CLEAR",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "BACLEAR asserted, regardless of cause "
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xA7",
+        "BriefDescription": "Instruction queue forced BACLEAR",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xA7",
         "EventName": "BACLEAR_FORCE_IQ",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Instruction queue forced BACLEAR"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xE0",
+        "BriefDescription": "Early Branch Prediciton Unit clears",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xE8",
+        "EventName": "BPU_CLEARS.EARLY",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Late Branch Prediction Unit clears",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE8",
+        "EventName": "BPU_CLEARS.LATE",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Branch prediction unit missed call or return",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE5",
+        "EventName": "BPU_MISSED_CALL_RET",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Branch instructions decoded",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE0",
         "EventName": "BR_INST_DECODED",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Branch instructions decoded"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x88",
+        "BriefDescription": "Branch instructions executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x7f",
+        "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.ANY",
         "SampleAfterValue": "200000",
-        "BriefDescription": "Branch instructions executed"
+        "UMask": "0x7f"
     },
     {
-        "EventCode": "0x88",
+        "BriefDescription": "Conditional branch instructions executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.COND",
         "SampleAfterValue": "200000",
-        "BriefDescription": "Conditional branch instructions executed"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x88",
+        "BriefDescription": "Unconditional branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.DIRECT",
         "SampleAfterValue": "200000",
-        "BriefDescription": "Unconditional branches executed"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x88",
+        "BriefDescription": "Unconditional call branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
+        "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.DIRECT_NEAR_CALL",
         "SampleAfterValue": "20000",
-        "BriefDescription": "Unconditional call branches executed"
+        "UMask": "0x10"
     },
     {
-        "EventCode": "0x88",
+        "BriefDescription": "Indirect call branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
+        "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.INDIRECT_NEAR_CALL",
         "SampleAfterValue": "20000",
-        "BriefDescription": "Indirect call branches executed"
+        "UMask": "0x20"
     },
     {
-        "EventCode": "0x88",
+        "BriefDescription": "Indirect non call branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.INDIRECT_NON_CALL",
         "SampleAfterValue": "20000",
-        "BriefDescription": "Indirect non call branches executed"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0x88",
+        "BriefDescription": "Call branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x30",
+        "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.NEAR_CALLS",
         "SampleAfterValue": "20000",
-        "BriefDescription": "Call branches executed"
+        "UMask": "0x30"
     },
     {
-        "EventCode": "0x88",
+        "BriefDescription": "All non call branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x7",
+        "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.NON_CALLS",
         "SampleAfterValue": "200000",
-        "BriefDescription": "All non call branches executed"
+        "UMask": "0x7"
     },
     {
-        "EventCode": "0x88",
+        "BriefDescription": "Indirect return branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
+        "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.RETURN_NEAR",
         "SampleAfterValue": "20000",
-        "BriefDescription": "Indirect return branches executed"
+        "UMask": "0x8"
     },
     {
-        "EventCode": "0x88",
+        "BriefDescription": "Taken branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
+        "EventCode": "0x88",
         "EventName": "BR_INST_EXEC.TAKEN",
         "SampleAfterValue": "200000",
-        "BriefDescription": "Taken branches executed"
+        "UMask": "0x40"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC4",
+        "BriefDescription": "Retired branch instructions (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
         "SampleAfterValue": "200000",
-        "BriefDescription": "Retired branch instructions (Precise Event)"
+        "UMask": "0x4"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC4",
+        "BriefDescription": "Retired conditional branch instructions (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.CONDITIONAL",
+        "PEBS": "1",
         "SampleAfterValue": "200000",
-        "BriefDescription": "Retired conditional branch instructions (Precise Event)"
+        "UMask": "0x1"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC4",
+        "BriefDescription": "Retired near call instructions (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xC4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
+        "PEBS": "1",
         "SampleAfterValue": "20000",
-        "BriefDescription": "Retired near call instructions (Precise Event)"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x89",
+        "BriefDescription": "Mispredicted branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x7f",
+        "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.ANY",
         "SampleAfterValue": "20000",
-        "BriefDescription": "Mispredicted branches executed"
+        "UMask": "0x7f"
     },
     {
-        "EventCode": "0x89",
+        "BriefDescription": "Mispredicted conditional branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.COND",
         "SampleAfterValue": "20000",
-        "BriefDescription": "Mispredicted conditional branches executed"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x89",
+        "BriefDescription": "Mispredicted unconditional branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.DIRECT",
         "SampleAfterValue": "20000",
-        "BriefDescription": "Mispredicted unconditional branches executed"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x89",
+        "BriefDescription": "Mispredicted non call branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
+        "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.DIRECT_NEAR_CALL",
         "SampleAfterValue": "2000",
-        "BriefDescription": "Mispredicted non call branches executed"
+        "UMask": "0x10"
     },
     {
-        "EventCode": "0x89",
+        "BriefDescription": "Mispredicted indirect call branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
+        "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.INDIRECT_NEAR_CALL",
         "SampleAfterValue": "2000",
-        "BriefDescription": "Mispredicted indirect call branches executed"
+        "UMask": "0x20"
     },
     {
-        "EventCode": "0x89",
+        "BriefDescription": "Mispredicted indirect non call branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.INDIRECT_NON_CALL",
         "SampleAfterValue": "2000",
-        "BriefDescription": "Mispredicted indirect non call branches executed"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0x89",
+        "BriefDescription": "Mispredicted call branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x30",
+        "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.NEAR_CALLS",
         "SampleAfterValue": "2000",
-        "BriefDescription": "Mispredicted call branches executed"
+        "UMask": "0x30"
     },
     {
-        "EventCode": "0x89",
+        "BriefDescription": "Mispredicted non call branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x7",
+        "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.NON_CALLS",
         "SampleAfterValue": "20000",
-        "BriefDescription": "Mispredicted non call branches executed"
+        "UMask": "0x7"
     },
     {
-        "EventCode": "0x89",
+        "BriefDescription": "Mispredicted return branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
+        "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.RETURN_NEAR",
         "SampleAfterValue": "2000",
-        "BriefDescription": "Mispredicted return branches executed"
+        "UMask": "0x8"
     },
     {
-        "EventCode": "0x89",
+        "BriefDescription": "Mispredicted taken branches executed",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
+        "EventCode": "0x89",
         "EventName": "BR_MISP_EXEC.TAKEN",
         "SampleAfterValue": "20000",
-        "BriefDescription": "Mispredicted taken branches executed"
+        "UMask": "0x40"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC5",
+        "BriefDescription": "Mispredicted near retired calls (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xC5",
         "EventName": "BR_MISP_RETIRED.NEAR_CALL",
+        "PEBS": "1",
         "SampleAfterValue": "2000",
-        "BriefDescription": "Mispredicted near retired calls (Precise Event)"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x0",
+        "BriefDescription": "Reference cycles when thread is not halted (fixed counter)",
         "Counter": "Fixed counter 3",
-        "UMask": "0x0",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.REF",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Reference cycles when thread is not halted (fixed counter)"
+        "UMask": "0x0"
     },
     {
-        "EventCode": "0x3C",
+        "BriefDescription": "Reference base clock (133 Mhz) cycles when thread is not halted (programmable counter)",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.REF_P",
         "SampleAfterValue": "100000",
-        "BriefDescription": "Reference base clock (133 Mhz) cycles when thread is not halted (programmable counter)"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x0",
+        "BriefDescription": "Cycles when thread is not halted (fixed counter)",
         "Counter": "Fixed counter 2",
-        "UMask": "0x0",
+        "EventCode": "0x0",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles when thread is not halted (fixed counter)"
+        "UMask": "0x0"
     },
     {
-        "EventCode": "0x3C",
+        "BriefDescription": "Cycles when thread is not halted (programmable counter)",
         "Counter": "0,1,2,3",
-        "UMask": "0x0",
+        "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles when thread is not halted (programmable counter)"
+        "UMask": "0x0"
     },
     {
-        "EventCode": "0x3C",
-        "Invert": "1",
+        "BriefDescription": "Total CPU cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0x0",
+        "CounterMask": "2",
+        "EventCode": "0x3C",
         "EventName": "CPU_CLK_UNHALTED.TOTAL_CYCLES",
+        "Invert": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Total CPU cycles",
-        "CounterMask": "2"
+        "UMask": "0x0"
     },
     {
-        "EventCode": "0x87",
+        "BriefDescription": "Any Instruction Length Decoder stall cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0xf",
+        "EventCode": "0x87",
         "EventName": "ILD_STALL.ANY",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Any Instruction Length Decoder stall cycles"
+        "UMask": "0xf"
     },
     {
-        "EventCode": "0x87",
+        "BriefDescription": "Instruction Queue full stall cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0x87",
         "EventName": "ILD_STALL.IQ_FULL",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Instruction Queue full stall cycles"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0x87",
+        "BriefDescription": "Length Change Prefix stall cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Length Change Prefix stall cycles"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x87",
+        "BriefDescription": "Stall cycles due to BPU MRU bypass",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0x87",
         "EventName": "ILD_STALL.MRU",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Stall cycles due to BPU MRU bypass"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x87",
+        "BriefDescription": "Regen stall cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
+        "EventCode": "0x87",
         "EventName": "ILD_STALL.REGEN",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Regen stall cycles"
+        "UMask": "0x8"
     },
     {
-        "EventCode": "0x18",
+        "BriefDescription": "Instructions that must be decoded by decoder 0",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x18",
         "EventName": "INST_DECODED.DEC0",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Instructions that must be decoded by decoder 0"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x1E",
+        "BriefDescription": "Instructions written to instruction queue.",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "INST_QUEUE_WRITE_CYCLES",
+        "EventCode": "0x17",
+        "EventName": "INST_QUEUE_WRITES",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles instructions are written to the instruction queue"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x17",
+        "BriefDescription": "Cycles instructions are written to the instruction queue",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "INST_QUEUE_WRITES",
+        "EventCode": "0x1E",
+        "EventName": "INST_QUEUE_WRITE_CYCLES",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Instructions written to instruction queue."
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x0",
+        "BriefDescription": "Instructions retired (fixed counter)",
         "Counter": "Fixed counter 1",
-        "UMask": "0x0",
+        "EventCode": "0x0",
         "EventName": "INST_RETIRED.ANY",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Instructions retired (fixed counter)"
+        "UMask": "0x0"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC0",
+        "BriefDescription": "Instructions retired (Programmable counter and Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xC0",
         "EventName": "INST_RETIRED.ANY_P",
+        "PEBS": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Instructions retired (Programmable counter and Precise Event)"
+        "UMask": "0x1"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC0",
+        "BriefDescription": "Retired MMX instructions (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0xC0",
         "EventName": "INST_RETIRED.MMX",
+        "PEBS": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Retired MMX instructions (Precise Event)"
+        "UMask": "0x4"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC0",
-        "Invert": "1",
+        "BriefDescription": "Total cycles (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "CounterMask": "16",
+        "EventCode": "0xC0",
         "EventName": "INST_RETIRED.TOTAL_CYCLES",
+        "Invert": "1",
+        "PEBS": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Total cycles (Precise Event)",
-        "CounterMask": "16"
+        "UMask": "0x1"
     },
     {
-        "PEBS": "1",
+        "BriefDescription": "Total cycles (Precise Event)",
+        "Counter": "0,1,2,3",
+        "CounterMask": "16",
         "EventCode": "0xC0",
+        "EventName": "INST_RETIRED.TOTAL_CYCLES_PS",
+        "Invert": "1",
+        "PEBS": "2",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired floating-point operations (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xC0",
         "EventName": "INST_RETIRED.X87",
+        "PEBS": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Retired floating-point operations (Precise Event)"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x4C",
+        "BriefDescription": "Load operations conflicting with software prefetches",
         "Counter": "0,1",
-        "UMask": "0x1",
+        "EventCode": "0x4C",
         "EventName": "LOAD_HIT_PRE",
         "SampleAfterValue": "200000",
-        "BriefDescription": "Load operations conflicting with software prefetches"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xA8",
+        "BriefDescription": "Cycles when uops were delivered by the LSD",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "CounterMask": "1",
+        "EventCode": "0xA8",
         "EventName": "LSD.ACTIVE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles when uops were delivered by the LSD",
-        "CounterMask": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xA8",
-        "Invert": "1",
+        "BriefDescription": "Cycles no uops were delivered by the LSD",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "CounterMask": "1",
+        "EventCode": "0xA8",
         "EventName": "LSD.INACTIVE",
+        "Invert": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles no uops were delivered by the LSD",
-        "CounterMask": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x20",
+        "BriefDescription": "Loops that can't stream from the instruction queue",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x20",
         "EventName": "LSD_OVERFLOW",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Loops that can't stream from the instruction queue"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xC3",
+        "BriefDescription": "Cycles machine clear asserted",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.CYCLES",
         "SampleAfterValue": "20000",
-        "BriefDescription": "Cycles machine clear asserted"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xC3",
+        "BriefDescription": "Execution pipeline restart due to Memory ordering conflicts",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEM_ORDER",
         "SampleAfterValue": "20000",
-        "BriefDescription": "Execution pipeline restart due to Memory ordering conflicts"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0xC3",
+        "BriefDescription": "Self-Modifying Code detected",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
         "SampleAfterValue": "20000",
-        "BriefDescription": "Self-Modifying Code detected"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0xA2",
+        "BriefDescription": "All RAT stall cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "RESOURCE_STALLS.ANY",
+        "EventCode": "0xD2",
+        "EventName": "RAT_STALLS.ANY",
+        "SampleAfterValue": "2000000",
+        "UMask": "0xf"
+    },
+    {
+        "BriefDescription": "Flag stall cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "RAT_STALLS.FLAGS",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Partial register stall cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "RAT_STALLS.REGISTERS",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "ROB read port stalls cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "RAT_STALLS.ROB_READ_PORT",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Scoreboard stall cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "RAT_STALLS.SCOREBOARD",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Resource related stall cycles"
+        "UMask": "0x8"
     },
     {
+        "BriefDescription": "Resource related stall cycles",
+        "Counter": "0,1,2,3",
         "EventCode": "0xA2",
+        "EventName": "RESOURCE_STALLS.ANY",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "FPU control word write stall cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
+        "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.FPCW",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "FPU control word write stall cycles"
+        "UMask": "0x20"
     },
     {
-        "EventCode": "0xA2",
+        "BriefDescription": "Load buffer stall cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.LOAD",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Load buffer stall cycles"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0xA2",
+        "BriefDescription": "MXCSR rename stall cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
+        "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.MXCSR",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "MXCSR rename stall cycles"
+        "UMask": "0x40"
     },
     {
-        "EventCode": "0xA2",
+        "BriefDescription": "Other Resource related stall cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0x80",
+        "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.OTHER",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Other Resource related stall cycles"
+        "UMask": "0x80"
     },
     {
-        "EventCode": "0xA2",
+        "BriefDescription": "ROB full stall cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
+        "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.ROB_FULL",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "ROB full stall cycles"
+        "UMask": "0x10"
     },
     {
-        "EventCode": "0xA2",
+        "BriefDescription": "Reservation Station full stall cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.RS_FULL",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Reservation Station full stall cycles"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0xA2",
+        "BriefDescription": "Store buffer stall cycles",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
+        "EventCode": "0xA2",
         "EventName": "RESOURCE_STALLS.STORE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Store buffer stall cycles"
+        "UMask": "0x8"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC7",
+        "BriefDescription": "SIMD Packed-Double Uops retired (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0xC7",
         "EventName": "SSEX_UOPS_RETIRED.PACKED_DOUBLE",
+        "PEBS": "1",
         "SampleAfterValue": "200000",
-        "BriefDescription": "SIMD Packed-Double Uops retired (Precise Event)"
+        "UMask": "0x4"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC7",
+        "BriefDescription": "SIMD Packed-Single Uops retired (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xC7",
         "EventName": "SSEX_UOPS_RETIRED.PACKED_SINGLE",
+        "PEBS": "1",
         "SampleAfterValue": "200000",
-        "BriefDescription": "SIMD Packed-Single Uops retired (Precise Event)"
+        "UMask": "0x1"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC7",
+        "BriefDescription": "SIMD Scalar-Double Uops retired (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
+        "EventCode": "0xC7",
         "EventName": "SSEX_UOPS_RETIRED.SCALAR_DOUBLE",
+        "PEBS": "1",
         "SampleAfterValue": "200000",
-        "BriefDescription": "SIMD Scalar-Double Uops retired (Precise Event)"
+        "UMask": "0x8"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC7",
+        "BriefDescription": "SIMD Scalar-Single Uops retired (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xC7",
         "EventName": "SSEX_UOPS_RETIRED.SCALAR_SINGLE",
+        "PEBS": "1",
         "SampleAfterValue": "200000",
-        "BriefDescription": "SIMD Scalar-Single Uops retired (Precise Event)"
+        "UMask": "0x2"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC7",
+        "BriefDescription": "SIMD Vector Integer Uops retired (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
+        "EventCode": "0xC7",
         "EventName": "SSEX_UOPS_RETIRED.VECTOR_INTEGER",
+        "PEBS": "1",
         "SampleAfterValue": "200000",
-        "BriefDescription": "SIMD Vector Integer Uops retired (Precise Event)"
+        "UMask": "0x10"
     },
     {
-        "EventCode": "0xDB",
+        "BriefDescription": "Stack pointer instructions decoded",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "UOP_UNFUSION",
-        "SampleAfterValue": "2000000",
-        "BriefDescription": "Uop unfusions due to FP exceptions"
-    },
-    {
         "EventCode": "0xD1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x4",
         "EventName": "UOPS_DECODED.ESP_FOLDING",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Stack pointer instructions decoded"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0xD1",
+        "BriefDescription": "Stack pointer sync operations",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
+        "EventCode": "0xD1",
         "EventName": "UOPS_DECODED.ESP_SYNC",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Stack pointer sync operations"
+        "UMask": "0x8"
     },
     {
-        "EventCode": "0xD1",
+        "BriefDescription": "Uops decoded by Microcode Sequencer",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "CounterMask": "1",
+        "EventCode": "0xD1",
         "EventName": "UOPS_DECODED.MS_CYCLES_ACTIVE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Uops decoded by Microcode Sequencer",
-        "CounterMask": "1"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0xD1",
-        "Invert": "1",
+        "BriefDescription": "Cycles no Uops are decoded",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "CounterMask": "1",
+        "EventCode": "0xD1",
         "EventName": "UOPS_DECODED.STALL_CYCLES",
+        "Invert": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles no Uops are decoded",
-        "CounterMask": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x3f",
         "AnyThread": "1",
+        "BriefDescription": "Cycles Uops executed on any port (core count)",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_ACTIVE_CYCLES",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles Uops executed on any port (core count)",
-        "CounterMask": "1"
+        "UMask": "0x3f"
     },
     {
-        "EventCode": "0xB1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1f",
         "AnyThread": "1",
+        "BriefDescription": "Cycles Uops executed on ports 0-4 (core count)",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_ACTIVE_CYCLES_NO_PORT5",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles Uops executed on ports 0-4 (core count)",
-        "CounterMask": "1"
+        "UMask": "0x1f"
     },
     {
-        "EventCode": "0xB1",
-        "Invert": "1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x3f",
         "AnyThread": "1",
-        "EventName": "UOPS_EXECUTED.CORE_STALL_COUNT",
-        "SampleAfterValue": "2000000",
         "BriefDescription": "Uops executed on any port (core count)",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
-        "EdgeDetect": "1"
-    },
-    {
+        "EdgeDetect": "1",
         "EventCode": "0xB1",
+        "EventName": "UOPS_EXECUTED.CORE_STALL_COUNT",
         "Invert": "1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1f",
-        "AnyThread": "1",
-        "EventName": "UOPS_EXECUTED.CORE_STALL_COUNT_NO_PORT5",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Uops executed on ports 0-4 (core count)",
-        "CounterMask": "1",
-        "EdgeDetect": "1"
+        "UMask": "0x3f"
     },
     {
+        "AnyThread": "1",
+        "BriefDescription": "Uops executed on ports 0-4 (core count)",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
         "EventCode": "0xB1",
+        "EventName": "UOPS_EXECUTED.CORE_STALL_COUNT_NO_PORT5",
         "Invert": "1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x3f",
-        "AnyThread": "1",
-        "EventName": "UOPS_EXECUTED.CORE_STALL_CYCLES",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles no Uops issued on any port (core count)",
-        "CounterMask": "1"
+        "UMask": "0x1f"
     },
     {
+        "AnyThread": "1",
+        "BriefDescription": "Cycles no Uops issued on any port (core count)",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
         "EventCode": "0xB1",
+        "EventName": "UOPS_EXECUTED.CORE_STALL_CYCLES",
         "Invert": "1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1f",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x3f"
+    },
+    {
         "AnyThread": "1",
+        "BriefDescription": "Cycles no Uops issued on ports 0-4 (core count)",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.CORE_STALL_CYCLES_NO_PORT5",
+        "Invert": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles no Uops issued on ports 0-4 (core count)",
-        "CounterMask": "1"
+        "UMask": "0x1f"
     },
     {
-        "EventCode": "0xB1",
+        "BriefDescription": "Uops executed on port 0",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT0",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Uops executed on port 0"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xB1",
+        "BriefDescription": "Uops issued on ports 0, 1 or 5",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
+        "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT015",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Uops issued on ports 0, 1 or 5"
+        "UMask": "0x40"
     },
     {
-        "EventCode": "0xB1",
-        "Invert": "1",
+        "BriefDescription": "Cycles no Uops issued on ports 0, 1 or 5",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
+        "CounterMask": "1",
+        "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT015_STALL_CYCLES",
+        "Invert": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles no Uops issued on ports 0, 1 or 5",
-        "CounterMask": "1"
+        "UMask": "0x40"
     },
     {
-        "EventCode": "0xB1",
+        "BriefDescription": "Uops executed on port 1",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Uops executed on port 1"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0xB1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x4",
         "AnyThread": "1",
-        "EventName": "UOPS_EXECUTED.PORT2_CORE",
+        "BriefDescription": "Uops issued on ports 2, 3 or 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UOPS_EXECUTED.PORT234_CORE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Uops executed on port 2 (core count)"
+        "UMask": "0x80"
     },
     {
-        "EventCode": "0xB1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x80",
         "AnyThread": "1",
-        "EventName": "UOPS_EXECUTED.PORT234_CORE",
+        "BriefDescription": "Uops executed on port 2 (core count)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UOPS_EXECUTED.PORT2_CORE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Uops issued on ports 2, 3 or 4"
+        "UMask": "0x4"
     },
     {
-        "EventCode": "0xB1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x8",
         "AnyThread": "1",
+        "BriefDescription": "Uops executed on port 3 (core count)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT3_CORE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Uops executed on port 3 (core count)"
+        "UMask": "0x8"
     },
     {
-        "EventCode": "0xB1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x10",
         "AnyThread": "1",
+        "BriefDescription": "Uops executed on port 4 (core count)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT4_CORE",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Uops executed on port 4 (core count)"
+        "UMask": "0x10"
     },
     {
-        "EventCode": "0xB1",
+        "BriefDescription": "Uops executed on port 5",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
+        "EventCode": "0xB1",
         "EventName": "UOPS_EXECUTED.PORT5",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Uops executed on port 5"
+        "UMask": "0x20"
     },
     {
-        "EventCode": "0xE",
+        "BriefDescription": "Uops issued",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xE",
         "EventName": "UOPS_ISSUED.ANY",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Uops issued"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xE",
-        "Invert": "1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
         "AnyThread": "1",
+        "BriefDescription": "Cycles no Uops were issued on any thread",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0xE",
         "EventName": "UOPS_ISSUED.CORE_STALL_CYCLES",
+        "Invert": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles no Uops were issued on any thread",
-        "CounterMask": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xE",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
         "AnyThread": "1",
+        "BriefDescription": "Cycles Uops were issued on either thread",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0xE",
         "EventName": "UOPS_ISSUED.CYCLES_ALL_THREADS",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles Uops were issued on either thread",
-        "CounterMask": "1"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0xE",
+        "BriefDescription": "Fused Uops issued",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xE",
         "EventName": "UOPS_ISSUED.FUSED",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Fused Uops issued"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0xE",
-        "Invert": "1",
+        "BriefDescription": "Cycles no Uops were issued",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "CounterMask": "1",
+        "EventCode": "0xE",
         "EventName": "UOPS_ISSUED.STALL_CYCLES",
+        "Invert": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles no Uops were issued",
-        "CounterMask": "1"
+        "UMask": "0x1"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC2",
+        "BriefDescription": "Cycles Uops are being retired",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "CounterMask": "1",
+        "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ACTIVE_CYCLES",
+        "PEBS": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles Uops are being retired",
-        "CounterMask": "1"
+        "UMask": "0x1"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC2",
+        "BriefDescription": "Uops retired (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.ANY",
+        "PEBS": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Uops retired (Precise Event)"
+        "UMask": "0x1"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC2",
+        "BriefDescription": "Macro-fused Uops retired (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
+        "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.MACRO_FUSED",
+        "PEBS": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Macro-fused Uops retired (Precise Event)"
+        "UMask": "0x4"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC2",
+        "BriefDescription": "Retirement slots used (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
+        "PEBS": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Retirement slots used (Precise Event)"
+        "UMask": "0x2"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC2",
-        "Invert": "1",
+        "BriefDescription": "Cycles Uops are not retiring (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "CounterMask": "1",
+        "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
+        "Invert": "1",
+        "PEBS": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Cycles Uops are not retiring (Precise Event)",
-        "CounterMask": "1"
+        "UMask": "0x1"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC2",
-        "Invert": "1",
+        "BriefDescription": "Total cycles using precise uop retired event (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "CounterMask": "16",
+        "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
+        "Invert": "1",
+        "PEBS": "1",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Total cycles using precise uop retired event (Precise Event)",
-        "CounterMask": "16"
+        "UMask": "0x1"
     },
     {
-        "PEBS": "2",
-        "EventCode": "0xC0",
-        "Invert": "1",
+        "BriefDescription": "Uop unfusions due to FP exceptions",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "INST_RETIRED.TOTAL_CYCLES_PS",
+        "EventCode": "0xDB",
+        "EventName": "UOP_UNFUSION",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "Total cycles (Precise Event)",
-        "CounterMask": "16"
+        "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json b/tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json
index 0596094e0ee9..e88c0802e679 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json
@@ -1,109 +1,109 @@
 [
     {
-        "EventCode": "0x8",
+        "BriefDescription": "DTLB load misses",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x8",
         "EventName": "DTLB_LOAD_MISSES.ANY",
         "SampleAfterValue": "200000",
-        "BriefDescription": "DTLB load misses"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x8",
+        "BriefDescription": "DTLB load miss caused by low part of address",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
+        "EventCode": "0x8",
         "EventName": "DTLB_LOAD_MISSES.PDE_MISS",
         "SampleAfterValue": "200000",
-        "BriefDescription": "DTLB load miss caused by low part of address"
+        "UMask": "0x20"
     },
     {
-        "EventCode": "0x8",
+        "BriefDescription": "DTLB second level hit",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
+        "EventCode": "0x8",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "DTLB second level hit"
+        "UMask": "0x10"
     },
     {
-        "EventCode": "0x8",
+        "BriefDescription": "DTLB load miss page walks complete",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0x8",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "200000",
-        "BriefDescription": "DTLB load miss page walks complete"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0x49",
+        "BriefDescription": "DTLB misses",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0x49",
         "EventName": "DTLB_MISSES.ANY",
         "SampleAfterValue": "200000",
-        "BriefDescription": "DTLB misses"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x49",
+        "BriefDescription": "DTLB first level misses but second level hit",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
+        "EventCode": "0x49",
         "EventName": "DTLB_MISSES.STLB_HIT",
         "SampleAfterValue": "200000",
-        "BriefDescription": "DTLB first level misses but second level hit"
+        "UMask": "0x10"
     },
     {
-        "EventCode": "0x49",
+        "BriefDescription": "DTLB miss page walks",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0x49",
         "EventName": "DTLB_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "200000",
-        "BriefDescription": "DTLB miss page walks"
+        "UMask": "0x2"
     },
     {
-        "EventCode": "0xAE",
+        "BriefDescription": "ITLB flushes",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xAE",
         "EventName": "ITLB_FLUSH",
         "SampleAfterValue": "2000000",
-        "BriefDescription": "ITLB flushes"
+        "UMask": "0x1"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC8",
+        "BriefDescription": "ITLB miss",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
-        "EventName": "ITLB_MISS_RETIRED",
-        "SampleAfterValue": "200000",
-        "BriefDescription": "Retired instructions that missed the ITLB (Precise Event)"
-    },
-    {
         "EventCode": "0x85",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
         "EventName": "ITLB_MISSES.ANY",
         "SampleAfterValue": "200000",
-        "BriefDescription": "ITLB miss"
+        "UMask": "0x1"
     },
     {
-        "EventCode": "0x85",
+        "BriefDescription": "ITLB miss page walks",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
+        "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "200000",
-        "BriefDescription": "ITLB miss page walks"
+        "UMask": "0x2"
     },
     {
+        "BriefDescription": "Retired instructions that missed the ITLB (Precise Event)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC8",
+        "EventName": "ITLB_MISS_RETIRED",
         "PEBS": "1",
-        "EventCode": "0xCB",
+        "SampleAfterValue": "200000",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Retired loads that miss the DTLB (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x80",
+        "EventCode": "0xCB",
         "EventName": "MEM_LOAD_RETIRED.DTLB_MISS",
+        "PEBS": "1",
         "SampleAfterValue": "200000",
-        "BriefDescription": "Retired loads that miss the DTLB (Precise Event)"
+        "UMask": "0x80"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC",
+        "BriefDescription": "Retired stores that miss the DTLB (Precise Event)",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
+        "EventCode": "0xC",
         "EventName": "MEM_STORE_RETIRED.DTLB_MISS",
+        "PEBS": "1",
         "SampleAfterValue": "200000",
-        "BriefDescription": "Retired stores that miss the DTLB (Precise Event)"
+        "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
-- 
2.37.1.359.gd136c6c3e2-goog

