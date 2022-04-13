Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B64500099
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbiDMVIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbiDMVIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:08:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1D585676
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:05:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb2bc9018aso26561997b3.18
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=iCtYxWeRiXkRVvzMmnG/1dORtlkX4NiDuoUQ7y+x6Yw=;
        b=sTqWDCnhDg1kvusCERg3S1p+UotXTb6G5qc8QCoqJU35GgUvt7PmFqXUYii4KKsgGP
         txixbiqbIcFr7zOAzkaba9dTMQnBkAy0B9Hm7gR+sjZDqDe91q/tlecvGJgyj2FTumNY
         DrVjDxbDxxVjUI7OUK9i+GFGmvVevsDxJp7pjfGDEeD/PjguGWgReYxGmbynqB+/wHQU
         /LwmMvtGBocoMl8Qt11erRwoOt6wuJyA6eZrmCmgcwiP6jXr6sCocQBtCc7WfZIS4jPR
         ebymgjbejD+ZFWQmc/3+SCb5HVgjgp0Ea2RfDkdV70DJToHoes311isCVkF/q4jo3Cak
         nB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=iCtYxWeRiXkRVvzMmnG/1dORtlkX4NiDuoUQ7y+x6Yw=;
        b=yB2W9LBKSu7tRKyFsuZnoKRJ+UOECGAknvzHE1ObcTDnNAOBAK2K7v7CAFPABIKR+V
         Bj9J9xqr2mEw09aE08tgyJnwIuZu849yb3tj6fYME5Cst87/bfzCsjPh705OT07hVChw
         dUhkOJMxrJmDtHcZV6iif6B3//lNEsC9mf5AfX0Xqtc0RlSoxkTc2nkq0HO1arpvLbIF
         7ektJy4FLkXt0aRLBYA/3wV28mtqNnf+jhBMuljJm0gkDt6luUenZWA3f92/TfQyGDk8
         6x4/mvw+LGgpVZeYUZ915W+h5Ll2O8Ej64HagfJKORzQyZT0P0PHBsbIXhSkznU5lVi9
         3C/g==
X-Gm-Message-State: AOAM5316r6Ayx0D2s47GJikYA6ZyWGXiA3JiQBfc0yIfrAaPx5NIc+U9
        SnUI1yB/KR7BXSHZwAK0eQdnWQjVgACp
X-Google-Smtp-Source: ABdhPJyMCnkObVJCsABGzTvEJ9jw1AYzRcbOT55/NGtFWlysIfK58pJXa4XpTcBrsvY3wnEZtUJ6+czut0a+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a05:690c:87:b0:2ea:20a7:a2c with SMTP id
 be7-20020a05690c008700b002ea20a70a2cmr784557ywb.500.1649883939332; Wed, 13
 Apr 2022 14:05:39 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:05:03 -0700
In-Reply-To: <20220413210503.3256922-1-irogers@google.com>
Message-Id: <20220413210503.3256922-14-irogers@google.com>
Mime-Version: 1.0
References: <20220413210503.3256922-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 14/14] perf vendor events intel: Update goldmont event topics
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
Content-Transfer-Encoding: quoted-printable
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
 .../pmu-events/arch/x86/goldmont/other.json   | 31 +------------------
 .../arch/x86/goldmont/pipeline.json           | 31 ++++++++++++++++++-
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/goldmont/other.json b/tools/per=
f/pmu-events/arch/x86/goldmont/other.json
index e4605e636447..d888f67aa2ea 100644
--- a/tools/perf/pmu-events/arch/x86/goldmont/other.json
+++ b/tools/perf/pmu-events/arch/x86/goldmont/other.json
@@ -47,34 +47,5 @@
         "PublicDescription": "Counts hardware interrupts received by the p=
rocessor.",
         "SampleAfterValue": "203",
         "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Unfilled issue slots per cycle",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xCA",
-        "EventName": "ISSUE_SLOTS_NOT_CONSUMED.ANY",
-        "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed by the backend due to either a full resource  in=
 the backend (RESOURCE_FULL) or due to the processor recovering from some e=
vent (RECOVERY).",
-        "SampleAfterValue": "200003"
-    },
-    {
-        "BriefDescription": "Unfilled issue slots per cycle to recover",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xCA",
-        "EventName": "ISSUE_SLOTS_NOT_CONSUMED.RECOVERY",
-        "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed by the backend because allocation is stalled wai=
ting for a mispredicted jump to retire or other branch-like conditions (e.g=
. the event is relevant during certain microcode flows).   Counts all issue=
 slots blocked while within this window including slots where uops were not=
 available in the Instruction Queue.",
-        "SampleAfterValue": "200003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "Unfilled issue slots per cycle because of a f=
ull resource in the backend",
-        "CollectPEBSRecord": "1",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xCA",
-        "EventName": "ISSUE_SLOTS_NOT_CONSUMED.RESOURCE_FULL",
-        "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed because of a full resource in the backend.  Incl=
uding but not limited to resources such as the Re-order Buffer (ROB), reser=
vation stations (RS), load/store buffers, physical registers, or any other =
needed machine resource that is currently unavailable.   Note that uops mus=
t be available for consumption in order for this event to fire.  If a uop i=
s not available (Instruction Queue is empty), this event will not count.",
-        "SampleAfterValue": "200003",
-        "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json b/tools/=
perf/pmu-events/arch/x86/goldmont/pipeline.json
index cb9155c3836d..5dba4313013f 100644
--- a/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
@@ -245,6 +245,35 @@
         "PublicDescription": "Counts the number of instructions that retir=
e execution. For instructions that consist of multiple uops, this event cou=
nts the retirement of the last uop of the instruction. The event continues =
counting during hardware interrupts, traps, and inside interrupt handlers. =
 This is an architectural performance event.  This event uses a (_P)rogramm=
able general purpose performance counter. *This event is Precise Event capa=
ble:  The EventingRIP field in the PEBS record is precise to the address of=
 the instruction which caused the event.  Note: Because PEBS records can be=
 collected only on IA32_PMC0, only one event can use the PEBS facility at a=
 time.",
         "SampleAfterValue": "2000003"
     },
+    {
+        "BriefDescription": "Unfilled issue slots per cycle",
+        "CollectPEBSRecord": "1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xCA",
+        "EventName": "ISSUE_SLOTS_NOT_CONSUMED.ANY",
+        "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed by the backend due to either a full resource  in=
 the backend (RESOURCE_FULL) or due to the processor recovering from some e=
vent (RECOVERY).",
+        "SampleAfterValue": "200003"
+    },
+    {
+        "BriefDescription": "Unfilled issue slots per cycle to recover",
+        "CollectPEBSRecord": "1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xCA",
+        "EventName": "ISSUE_SLOTS_NOT_CONSUMED.RECOVERY",
+        "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed by the backend because allocation is stalled wai=
ting for a mispredicted jump to retire or other branch-like conditions (e.g=
. the event is relevant during certain microcode flows).   Counts all issue=
 slots blocked while within this window including slots where uops were not=
 available in the Instruction Queue.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Unfilled issue slots per cycle because of a f=
ull resource in the backend",
+        "CollectPEBSRecord": "1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xCA",
+        "EventName": "ISSUE_SLOTS_NOT_CONSUMED.RESOURCE_FULL",
+        "PublicDescription": "Counts the number of issue slots per core cy=
cle that were not consumed because of a full resource in the backend.  Incl=
uding but not limited to resources such as the Re-order Buffer (ROB), reser=
vation stations (RS), load/store buffers, physical registers, or any other =
needed machine resource that is currently unavailable.   Note that uops mus=
t be available for consumption in order for this event to fire.  If a uop i=
s not available (Instruction Queue is empty), this event will not count.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Loads blocked because address has 4k partial =
address false dependence (Precise event capable)",
         "CollectPEBSRecord": "2",
@@ -379,4 +408,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
--=20
2.36.0.rc0.470.gd361397f0d-goog

