Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5125807A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbiGYWkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbiGYWjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:39:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D6227160
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:38:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b18-20020a25bb52000000b0067128e66131so3447951ybk.18
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8pN3twcMAxYA80ZD4DEEJfFP2dE7IQ0k6stG34SCEVY=;
        b=jPhgsYH45wUQW9295+P8oO91agNX6GoR5xCIKHbmM7JdW0v2AOxVKHXb7OidcVRFb1
         uxbo2DaklByeDqp6fyUBXwYL8Wqq5s1K+DXhfiNeb+lLm2HA9iulERIKexEArSI7DZ9S
         bSm51YJh1TJ+E89W2Do0gh6649b7ZEfPda/V9Z3UFeYr6NfDYY7T3BUDdvVJyMj6rxBV
         6hb619IWGakDDm2rAESlKb38TtSGBdcGZjcc6ob7BX7eNZ3+mHTeZIIqMrGER09WGQTg
         VTHTInLuv2h89GaGJ3A5zOC+ay/6js5mZOtFQiKKYfzq7SDFFt7Rrq8RGJspfiTWrQUH
         tgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8pN3twcMAxYA80ZD4DEEJfFP2dE7IQ0k6stG34SCEVY=;
        b=2PGG2PiSKiaQjyb3wXfvqGcVEqFhzJ3rlHDPdcKZmYaM5SVODCztIoBCSyj6kZzvNf
         VjBSYsQ+//BvjHkKIKJhWqEJWHH2BvaIUXoVb2MMaOO6JKpvLzl0Vble5UKEe8RUmRzq
         c6OgdcXLbOABZzm6FxLDUdMhVHbJL3mfZG4mkW7vr1F312aIVvsin537bQsuNskkrLXC
         nF51lHSdC985pJ14PT0wENGm0j50DjyfC14g/SsaEhQ0JLD7HCxkKWlOmXDASFpQQ0Eh
         QabVcJhfzM6Fr0kQmuYkdXPmpkffvMrhfaGing3nIHJR18JmnmAQyXUX9zkkZTKGDn3N
         ljyQ==
X-Gm-Message-State: AJIora+i0bU3uTB61e+Km5Ufr49sZi40ORbDN44PGbezRzv1Rw+stho8
        ed0Og/SoxiEcc90uyzF6jd5oFe5K9OYT
X-Google-Smtp-Source: AGRyM1u2us22BEnB4yApB40ngzsCOAHp4l1UuRKFKJJ8Wki0MTOV0z0VCnqxvJe3E6PeHU6xGBb4VPuUVAlv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a25:340f:0:b0:670:4d74:1e3e with SMTP id
 b15-20020a25340f000000b006704d741e3emr10605390yba.283.1658788679226; Mon, 25
 Jul 2022 15:37:59 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:29 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-29-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 28/32] perf vendor events: Update Intel westmereep-dp
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

Update to v2, the metrics are based on TMA 4.4 full.

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

