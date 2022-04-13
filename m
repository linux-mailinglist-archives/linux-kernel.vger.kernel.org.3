Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7FF50009A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiDMVIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238783AbiDMVHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:07:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866B35DA2E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:05:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e642be1a51so26218897b3.21
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BiA1gzDs+n6vDGSyDdWYoxAvlHWpcqRt9LMJt+dwRlo=;
        b=cT2sTaIMVLOPT74kFGHktC+icBAQMMitYlHTnse3U0c8GPNYtmaFOykm5+dUsmQk1o
         E7ByyhyM2T+vI7F5+EbwtBDfslNdd/O/14Pb6bFQKCHqim9WuB/w2GJyOMSnjEd2xmFn
         4z4Q4ivCrWe9efPlC4D91uOSeSKfetscyDVsxBddKBr2+EFLBa9o1/GxUsjYY+dXzb5s
         Qv1fV0+t4V2RVDV1AhoiVUP8IuCgSYsPqceefoAO1k6XFDp6yJAMjuPP64yXaNZiNRRL
         80/8Iv3K0wFx7DKw1Zg51uz2QpxX0zEAUnNHH0/Yqhe4DazToBI5KO6YdY/qEWpRL1Jq
         8F6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BiA1gzDs+n6vDGSyDdWYoxAvlHWpcqRt9LMJt+dwRlo=;
        b=JHQKNk3OsVC6qwj8M6tomn1bSqRwMEmXru/ficu1+t4SVHYevWl4EW5cGnhtdzWUPH
         ZIPNFQ+zkGpWu1PL1xKbAiXzBI6sP+soPP67n6Brc0N8rkuN8BY6Rc1+RQ/CcaAYCd+5
         Sv79ZcYhgu+HP1Hz3QEL83s3Ee20mxN4VsDjrenqtc24pSpBi2THxf39nW5xKhUnSnYZ
         8az2byf+Br5hPIaWYmSGUpifQAPQ2BmAWT6wM+4aI2hTFWkX34n1v1lrByn6q+oLnfS2
         WiGRZ9AndIz+F5r++/WioLKjrZjksK7eGs0QKGzzHU9cJ0lMX4dcByxRDgN6mBakz20+
         w2+w==
X-Gm-Message-State: AOAM532zqnd6YOeamTLqh8K2Yp7eiN5EOCOMSB9YV9qYUA9rqHYdiHNO
        0z8XlCYPJV7EicRE6I+sRo+cd0svLDS8
X-Google-Smtp-Source: ABdhPJwFBPwtEJ8LO4FnVSBHwBt8py7IEeV5kyVlIQSaAejZD+dkyKK7myVE9f6n8ZG1QrPX7ZylSPzEvt/U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a5b:8c8:0:b0:641:e8de:a6f4 with SMTP id
 w8-20020a5b08c8000000b00641e8dea6f4mr667192ybq.533.1649883921739; Wed, 13 Apr
 2022 14:05:21 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:04:56 -0700
In-Reply-To: <20220413210503.3256922-1-irogers@google.com>
Message-Id: <20220413210503.3256922-7-irogers@google.com>
Mime-Version: 1.0
References: <20220413210503.3256922-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 07/14] perf vendor events intel: Update tigerlake topic
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the topic of ASSISTS.ANY as per:
https://github.com/intel/event-converter-for-linux-perf/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/tigerlake/other.json | 13 +------------
 .../pmu-events/arch/x86/tigerlake/pipeline.json     | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/other.json b/tools/perf/pmu-events/arch/x86/tigerlake/other.json
index 304cd09fe159..65539490e18f 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/other.json
@@ -1,15 +1,4 @@
 [
-    {
-        "BriefDescription": "Number of occurrences where a microcode assist is invoked by hardware.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xc1",
-        "EventName": "ASSISTS.ANY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "PublicDescription": "Counts the number of occurrences where a microcode assist is invoked by hardware Examples include AD (page Access Dirty), FP and AVX related assists.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x7"
-    },
     {
         "BriefDescription": "Core cycles where the core was running in a manner where Turbo may be clipped to the Non-AVX turbo schedule.",
         "CollectPEBSRecord": "2",
@@ -57,4 +46,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json b/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
index d436775c80db..a8aa1b455c77 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
@@ -11,6 +11,17 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x9"
     },
+    {
+        "BriefDescription": "Number of occurrences where a microcode assist is invoked by hardware.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.ANY",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of occurrences where a microcode assist is invoked by hardware Examples include AD (page Access Dirty), FP and AVX related assists.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x7"
+    },
     {
         "BriefDescription": "All branch instructions retired.",
         "CollectPEBSRecord": "2",
@@ -1055,4 +1066,4 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
-- 
2.36.0.rc0.470.gd361397f0d-goog

