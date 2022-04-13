Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E449500095
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbiDMVId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238824AbiDMVIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:08:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C915383B2F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:05:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x132-20020a25ce8a000000b00640812b1ebaso2677925ybe.14
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sKVGn/1ladzaP0YExN38aLKS4szg337axwqCtRoFPKY=;
        b=PeHSOCfhIr2t78utrnhqPnF2CwqBEgBbCu7akmhDubxfj7JzPm/WRYWKXB0v4CO/uV
         rgkA/6RHAZXvKST4aeqC1c6sU0pqCtKXE5AafERDwD+8nK19VoEBMai3V+AN5o4pZtzY
         KfeBObtDiyvaRTxg0m5fBzjiAs1UqctyukQZhqyXHDZcPsn9iq4yugb5hwNmXxW2awWH
         g2xzed2jUbpZcYh7bzDjKfXsC2FYPgj21XDGTQm7iswDBcj7H6vjAlh1e59wWqj/4uJY
         j5+4eAutBsReOaA7Dq2eR67L7JkxhFLX7EHOwK+yBrxqE3g5aR8Gj9qFPMkE2KF2MBZ7
         9Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sKVGn/1ladzaP0YExN38aLKS4szg337axwqCtRoFPKY=;
        b=P1D6mOHtE2r0gsJXCBA6zB6kmxHw2Xi3raXupSlOT54cEfz5LfmlY+hxkWTQBPaFRY
         X/t8ymBB2GzKuPZXPXQTH7U5FsTBA6PxJqqPqv11N/z7CgJr1l0xLL6i4DuWVIhwPaiV
         OKGNjC1nEHmosgTK2ceD+q3mNQTAZeZZiow3hX7nvHBu3c73/JZY/bNkgg+m8j5Zeaah
         GXY+xzoBMBHzPbO9cunRqMs8RjA+vwYpOHOb6SHaSnD+QqsyFLvhPaMFEyXO4GQUXD6h
         WA3zosdtgQBgoBs1TOjStb8o/NIyfiU1OLmjlAsRKC32XtEUl46wFAmzfurri+6/1U9Q
         dZCw==
X-Gm-Message-State: AOAM5338E8Az8MyLXLb7Pop1F5dir9sOtT+MHunVnVIm1nb+nhQBficl
        Iu/G+gevMeEEDXTTFTWEMrgLjS4DGRei
X-Google-Smtp-Source: ABdhPJxZ2hVLrrOW+xEw8cx39cBykS8TWylOmFMH74o7mx69pQ+eojR+GtMWOKA+h1jmB3nZLera8QjqfrrN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a81:a43:0:b0:2eb:d709:1cfa with SMTP id
 64-20020a810a43000000b002ebd7091cfamr723496ywk.212.1649883931767; Wed, 13 Apr
 2022 14:05:31 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:05:00 -0700
In-Reply-To: <20220413210503.3256922-1-irogers@google.com>
Message-Id: <20220413210503.3256922-11-irogers@google.com>
Mime-Version: 1.0
References: <20220413210503.3256922-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 11/14] perf vendor events intel: Update westmereex event topics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply topic updates from:
https://github.com/intel/event-converter-for-linux-perf/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/westmereex/other.json | 66 +------------------
 .../arch/x86/westmereex/pipeline.json         | 66 ++++++++++++++++++-
 2 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/westmereex/other.json b/tools/perf/pmu-events/arch/x86/westmereex/other.json
index 23dcd554728c..67bc34984fa8 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/other.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/other.json
@@ -1,28 +1,4 @@
 [
-    {
-        "BriefDescription": "Early Branch Prediciton Unit clears",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xE8",
-        "EventName": "BPU_CLEARS.EARLY",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Late Branch Prediction Unit clears",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xE8",
-        "EventName": "BPU_CLEARS.LATE",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "Branch prediction unit missed call or return",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xE5",
-        "EventName": "BPU_MISSED_CALL_RET",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "ES segment renames",
         "Counter": "0,1,2,3",
@@ -127,46 +103,6 @@
         "SampleAfterValue": "200000",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "All RAT stall cycles",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xD2",
-        "EventName": "RAT_STALLS.ANY",
-        "SampleAfterValue": "2000000",
-        "UMask": "0xf"
-    },
-    {
-        "BriefDescription": "Flag stall cycles",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xD2",
-        "EventName": "RAT_STALLS.FLAGS",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Partial register stall cycles",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xD2",
-        "EventName": "RAT_STALLS.REGISTERS",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "ROB read port stalls cycles",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xD2",
-        "EventName": "RAT_STALLS.ROB_READ_PORT",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x4"
-    },
-    {
-        "BriefDescription": "Scoreboard stall cycles",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xD2",
-        "EventName": "RAT_STALLS.SCOREBOARD",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x8"
-    },
     {
         "BriefDescription": "All Store buffer stall cycles",
         "Counter": "0,1,2,3",
@@ -284,4 +220,4 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json b/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
index 620d9084d860..7d6c2c1e0db0 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
@@ -50,6 +50,30 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Early Branch Prediciton Unit clears",
+        "Counter": "0,1,2,3",
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
     {
         "BriefDescription": "Branch instructions decoded",
         "Counter": "0,1,2,3",
@@ -494,6 +518,46 @@
         "SampleAfterValue": "20000",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "All RAT stall cycles",
+        "Counter": "0,1,2,3",
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
+        "SampleAfterValue": "2000000",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Resource related stall cycles",
         "Counter": "0,1,2,3",
@@ -894,4 +958,4 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
-- 
2.36.0.rc0.470.gd361397f0d-goog

