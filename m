Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC0558352C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbiG0WNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbiG0WMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:12:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D860E08B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:10:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a11-20020a5b090b000000b00672acbe13c1so258206ybq.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8pN3twcMAxYA80ZD4DEEJfFP2dE7IQ0k6stG34SCEVY=;
        b=Rk00fQYzWE/+T3/aWAD2+vsfkXrS/m7JyO8AIWUDXS9kdfoeaUJMoQ+Dv5V0udI+im
         0YscWbWDGlXripQQ8k9LWXTCYL3vY4Hym7B1Em6TOwkbAwtdBNCqzbQgSpiIoieqBEfO
         q0YxgAaGNKAGOcJEEBaRCkxrVHNdUxRxTgJM0qmoo4z76PO9RcPNTnxVxSqgQDgfD/PP
         +8YGaD+OLbvHBPO6Q5mJQSWUrak2NNHJqAAGmXe/fhvfbo6//PLldR+Va+tur00Y/zh4
         aObyn3UL+Z7d9O2ciqMyuoFbmbeFp/I2SdMsqA8uxDz9OT8C1RUKUuV0qRPk9H+rDIFl
         jPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8pN3twcMAxYA80ZD4DEEJfFP2dE7IQ0k6stG34SCEVY=;
        b=qCRf/W2AJQUs86MHcQmXnmCWR8zH31UECLounMuMgMrf/c7ISXzYlT6YVLLAlD5fNo
         rZxI2miO676Urma2GGMnmCTKlOih/S72chAg0NE3/JmuuCx93dcKUJxj3kNuM0pyzPyY
         5AQRBdC75gkzhJy6YIqBdy+n+0LUzkFQ5QPjEasn/peQJ7smvaTB8O5ZSXRY9fC456XS
         6a42uxLs5jI/1PUJIpbtIHxHbZS8HWEIqP+iZl13V9ybwZSkEy5YoxKVxsjv0Em9o7zj
         9pwXpVnpRNo95DcyZMmRKftcYakRhFFrYgR3YDQYwbIE0JN/CqpTEKOafO8x/jtt/d+r
         CI3A==
X-Gm-Message-State: AJIora9Mg1GNx9pq65AfeGx5tYd+mDhXyZW9Ke2rFWoWZUfhxFXOm8Y6
        gr7mK8LIltDitgb/Huepg3mtishOX2Ip
X-Google-Smtp-Source: AGRyM1tqS2qztnHvbydy/RZbaTgto/0/M5eZXLb2wNIrVPz+adygKu8ccITcSM2BPXBuwh8yARoca7eY6Bg5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:882a:af57:8cb6:6f9e])
 (user=irogers job=sendgmr) by 2002:a05:6902:124a:b0:670:d03a:14fb with SMTP
 id t10-20020a056902124a00b00670d03a14fbmr19521998ybu.406.1658959796238; Wed,
 27 Jul 2022 15:09:56 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:08:29 -0700
In-Reply-To: <20220727220832.2865794-1-irogers@google.com>
Message-Id: <20220727220832.2865794-28-irogers@google.com>
Mime-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3 27/30] perf vendor events: Update Intel westmereep-dp
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

