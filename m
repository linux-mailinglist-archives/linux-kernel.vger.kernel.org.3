Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B336583531
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiG0WNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbiG0WNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:13:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DED4D4FE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:10:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f5668674cso1154037b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yz1gy8EbEjVfbtq7r9wHKmA+xi2VRHnsF2WGncncbl0=;
        b=IGSWZe2RAvgAI1NC4mgkU2MZnvmxgJfXuEhmZ0AROTHGzGZa+vMfIgPsenQ9mWcAPr
         rpG0flmxraN6c/s3d/ce7E17SABsI08cCZ8UCEO3BqWEszlhyIUXkGtLOWojOJaQFQxR
         YnOhjGm6p/q7MFI6K4nu75A4bthC1JOviRdQ7oDGO6ixzsx60sJj8lL/RTXNUpxTtgIJ
         5RsqVX0fEiPrQ2u8RU4W6lgE3XFnL+indlOECLUEWBTA1o28Rv3vmEXWNVaPr1yZIRdJ
         uIG9RwYtzK5gO6KWicRZAxCb42SwiZj39RNwCGTLgjy23MclpmPF7d9XO1baESGPKjZs
         TsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yz1gy8EbEjVfbtq7r9wHKmA+xi2VRHnsF2WGncncbl0=;
        b=ZCoz1HPeKG0mjFihw2L61bMuk9qFS66vLlZosg2k6aZEDFaDpISlK9xct7c/ITWPtp
         ar9rOeQrjwsmAemdtLmi5jw0Z2wJHVVo6wbsRVE5mOtcClBBZltCHIoHrRKeBuby6F6B
         EBlExJxi8zwPT5OnvWgcF8Dt9KJks2M09ge+ZAJASgKWCECiV0LZYEf9h2P8pFuaar85
         Q1ZCt5dHaAEcVHV1smmdLU6qCtCHkY105VgRlaYBUP7FJhCsscG11I4inPBRtGUAhqC2
         8uJ9L3I0hhWvg2pY2yq+7zABsNZoGTG5JzQZjEGpr+9FxqFgQB0LYGAxMQRGyyRW+MLJ
         +Neg==
X-Gm-Message-State: AJIora9+QIktjufeXbcBWQHNkPWrLDkNDblLwe97pZ8A1iXT3XlpdOOp
        fx8FA6jWm+w/QwLtUV6wbq2Z16Z84yk8
X-Google-Smtp-Source: AGRyM1tZw3r+LoZ9vp1HMfOCeMc5Gz/u0tJkxA6KMogkSdr5j077uSGuWTPVPsWiXkeYvqcBfMyJ8h9SNUcf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:882a:af57:8cb6:6f9e])
 (user=irogers job=sendgmr) by 2002:a25:808c:0:b0:670:7d94:f2a with SMTP id
 n12-20020a25808c000000b006707d940f2amr20208758ybk.452.1658959798783; Wed, 27
 Jul 2022 15:09:58 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:08:30 -0700
In-Reply-To: <20220727220832.2865794-1-irogers@google.com>
Message-Id: <20220727220832.2865794-29-irogers@google.com>
Mime-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3 28/30] perf vendor events: Update Intel westmereep-sp
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

Update to v3, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually
copy the westmereep-sp files into perf and update
mapfile.csv. This change just aligns whitespace and updates the
version number.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv                      | 2 +-
 .../perf/pmu-events/arch/x86/westmereep-sp/floating-point.json  | 2 +-
 tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json      | 2 +-
 .../perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index b660d3528b7d..d1cabfc62c39 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -26,7 +26,7 @@ GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v53,skylake,core
 GenuineIntel-6-55-[01234],v1.28,skylakex,core
 GenuineIntel-6-8[CD],v1.07,tigerlake,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
-GenuineIntel-6-25,v2,westmereep-sp,core
+GenuineIntel-6-25,v3,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
 GenuineIntel-6-86,v1,snowridgex,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
index 39af1329224a..666e466d351c 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
@@ -226,4 +226,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json
index 8ac5c24888c5..c561ac24d91d 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json
@@ -23,4 +23,4 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
index 0252f77a844b..e7affdf7f41b 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
@@ -146,4 +146,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
-- 
2.37.1.359.gd136c6c3e2-goog

