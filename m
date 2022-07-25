Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2715807A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbiGYWkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237511AbiGYWi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:38:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2C826575
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e60b8bb07so96910107b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V6hW0wUvN1tuelpXyBkR6zqmp2cQAX56uo+I1mmHo24=;
        b=if0ucadgke5zdTg18n64C3Loas/F26dcXfYSm/UGzE553oONikX9nxZw9EIyOkUDFl
         A90IxmuxZ3TDauvJ9UIVHYmOdahhpyO9rLgR1WO4P8CRys06tXamhxNRbBT/vgEDbGys
         5AP/sh9BqO6Xf3ajwBUzDnrzol3RDm8kwr1s1QZgZUuQoxjAK8jhrr3TYG1+xhWK2f9c
         FrWAmIPKiXyeRX10sZcky+Mhc3Bq5OeeQtGQrwrcGIQJ7wfAB+3umy6cyu82gEQ+msnK
         Ba4xwQ8XLbzgwZMBfqHwlO8UtBiYN3ePsep44llwnn3XY27syxrPxE2t68Php1njB31S
         07dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V6hW0wUvN1tuelpXyBkR6zqmp2cQAX56uo+I1mmHo24=;
        b=HScqlfhyXpkVeK72dyzTwheAt3okhHVtpCZ7tzotNiOKglWhBIzZjVeooyxtshp2wc
         ZOYqc4LfDDY+m+tdrjeal0+wA70FenTHMyjK2rQIvP2yL28VMuHOCg9lHAe3XJaonOYY
         idYylk5rXjLhBVJyfRIHa4ASZaDC8T4b4n6f9UsE3EKhdIfV2VOaW3VsUC0U0ONMStx6
         4jIMZGjq/uOz7nq5VFwMiTvtCkb4StioyFX6JBb5Hd5PwcreygbOBhqky2scd+ZmdfbM
         KB2yMgUtY+HGLjDt5EibAdOmdyr/Rg8LjPAn62TW6x1P0D1goLPzIlkuX6lDOCs4Lm0m
         shPQ==
X-Gm-Message-State: AJIora8LDB18IL5Pq/1SyfpxLMlvWnVnfk/30MSM25qqlzkKZIpb51yv
        SlbW8Ka0lhHd7ANoAHEzyZZHG99YWJjG
X-Google-Smtp-Source: AGRyM1t7MUDAfA544CMYIvSjYeRYsr072YOWyYa68U9bYirQOoE73UsxCiSWPgRnfa5VGdJZS5XNFCftX4QB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a25:d0d6:0:b0:670:db02:e7c3 with SMTP id
 h205-20020a25d0d6000000b00670db02e7c3mr10186120ybg.368.1658788668539; Mon, 25
 Jul 2022 15:37:48 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:25 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-25-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 24/32] perf vendor events: Update Intel silvermont
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to v14, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually
copy the silvermont files into perf and update mapfile.csv. Other
than aligning whitespace this change just folds the mapfile.csv
entries for silvertmont onto one line.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv                    | 4 +---
 tools/perf/pmu-events/arch/x86/silvermont/cache.json          | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/floating-point.json | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/frontend.json       | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/memory.json         | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/other.json          | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/pipeline.json       | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json | 2 +-
 8 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 0ed0c1ad122b..d224d59e3c72 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -21,11 +21,9 @@ GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-2A,v17,sandybridge,core
 GenuineIntel-6-8F,v1.04,sapphirerapids,core
+GenuineIntel-6-(37|4C|4D),v14,silvermont,core
 GenuineIntel-6-[4589]E,v24,skylake,core
 GenuineIntel-6-A[56],v24,skylake,core
-GenuineIntel-6-37,v13,silvermont,core
-GenuineIntel-6-4D,v13,silvermont,core
-GenuineIntel-6-4C,v13,silvermont,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/cache.json b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
index e16e1d910e4a..7959504dff29 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/cache.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
@@ -807,4 +807,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json b/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
index 1d75b35694ac..aa4faf110512 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
@@ -8,4 +8,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json b/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
index a4c98e43f677..43e5e48f7212 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
@@ -71,4 +71,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/memory.json b/tools/perf/pmu-events/arch/x86/silvermont/memory.json
index 5e21fc3fd078..0f5fba43da4c 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/memory.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/memory.json
@@ -8,4 +8,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/other.json b/tools/perf/pmu-events/arch/x86/silvermont/other.json
index 16d16a1ce6de..4db59d84c144 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/other.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/other.json
@@ -17,4 +17,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
index 03a4c7f26698..e42a37eabc17 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
@@ -313,4 +313,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json b/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
index f4b8a1ef48f6..b50cee3a5e4c 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
@@ -66,4 +66,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x3"
     }
-]
\ No newline at end of file
+]
-- 
2.37.1.359.gd136c6c3e2-goog

