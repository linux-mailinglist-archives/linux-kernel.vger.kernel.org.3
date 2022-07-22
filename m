Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE7C57E9D8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbiGVWhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbiGVWgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:36:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5411ABB220
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:34:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e619dcbbaso48745837b3.14
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zb/UuVimEkD2kfOtF8vKjWmJwlghCbwNUEVzI98zy9Q=;
        b=XjbAgAjSIhczEi6ixt44wvXWN+9nyP6MSHlpVHP/UqKrRyTBYyFjuTF3Ht6M+K7dI6
         xRBvyhPAqvgerNZkwN97ceS0DEbBSHTapuebbB/myJBxNl3bCZTNf4uaD8strBhxV37/
         /GO1xAUHCVWpRgNY5Xu2Q2NsobKhUAedAlEoxyM55anqQQMde5UowiYORO34xtNvoUGi
         ypUPM+KuT/Ww7opeV7OhP01btTqgDM+jYkKu8N60OJ7MiuKr9hmH59T0HddBYiklbpFn
         icXuq1vozfiVtE5yzbmAaT8HwYthb/bOw4GAZvaLBifMHQwEEIjgwcJ9pqy+9qcDHHGl
         oLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zb/UuVimEkD2kfOtF8vKjWmJwlghCbwNUEVzI98zy9Q=;
        b=SeeqpbKdEalChFZixDcDuyO1Q0Z2ThIgw2ybkUURRnc0Mv6ttuKNPJdspIHCdxLrhP
         VH1JtFuR66/Axpo69NM8Hbcg/BYEGywju550nveqYD1InfjTzjigLAvvLVvmGld9g6Pw
         Kw6bGGAyN20EZORd37BFfmy6BYtT8kjjoDl29E+e1WpJqXoR1/2BCz4juEGfl0s5Bb+6
         iqa9Yrphlsmdm13RVE5HoHqdW3aKTxQQTrRSMg780RGf181XVlfEAHBEaIsnqLAD1/BC
         MrYhIXlF3WLNEcK/YvTcaZolG8F6ewKnFNullXG+iY6KpdLeHmmGqkijdBNobFBKy39d
         A4mA==
X-Gm-Message-State: AJIora8TFulfo7DqHArboCyv7DHDazeexOprQJUrU9hOgeAlTyBbR54e
        IqhBKPsrxdYlycCsaj/jJsAQaq+h3gjs
X-Google-Smtp-Source: AGRyM1uJMCdOO3dyZ/WD7UmpDJq4I3YGwnJ7qR0F56Y7jz9pCQaE41FA1xf60torzM9SQIJzwNNTAmOHboEX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a81:8842:0:b0:31e:6b20:b171 with SMTP id
 y63-20020a818842000000b0031e6b20b171mr1738789ywf.318.1658529247972; Fri, 22
 Jul 2022 15:34:07 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:38 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-30-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 29/31] perf vendor events: Update Intel westmereep-dp
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

to download and generate the latest events and metrics. Manually
copy the westmereep-dp files into perf and update
mapfile.csv. This change just aligns whitespace.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json         | 2 +-
 .../perf/pmu-events/arch/x86/westmereep-dp/floating-point.json  | 2 +-
 tools/perf/pmu-events/arch/x86/westmereep-dp/frontend.json      | 2 +-
 tools/perf/pmu-events/arch/x86/westmereep-dp/memory.json        | 2 +-
 .../perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
index 0f01cf223777..37ed2742fec6 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
@@ -2814,4 +2814,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
index 39af1329224a..666e466d351c 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
@@ -226,4 +226,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/frontend.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/frontend.json
index 8ac5c24888c5..c561ac24d91d 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/frontend.json
@@ -23,4 +23,4 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/memory.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/memory.json
index 36fbea313c6f..7e529b367c21 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/memory.json
@@ -755,4 +755,4 @@
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
index d63e469a43e1..8099e6700e31 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
@@ -170,4 +170,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
-- 
2.37.1.359.gd136c6c3e2-goog

