Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87645807AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbiGYWkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiGYWjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:39:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F56D2715C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:38:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m5-20020a2598c5000000b0066faab590c5so9440818ybo.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0r3HjsQD2+mb0wsEzIakMgBjDsOoNwszNIkiBQ7nAXY=;
        b=S9EUsYTZwhR6CPCBNnM0vibmcEI78YknZJu6QIUxRwfi8v4ImQJTCfcL8zKRGoSYkK
         7WwkA72kep0BQa128skm5JZFi1ysRM2siDYpZXGV3S5GkBi1ssYDynpmurb8EhgoDhzU
         ww6IoOQi/JAjVKKOgCmd8cKKQdF37OCwZC9uvfSc+SaunWDj64pczNT3UxWC0IebkT4t
         fZ9VKzu3G0qgBRBQIqhVhhsC4waZRRnXah2f7tsfnOqjzJA9gjKe9BRzEkjanmyN7kss
         ZlB255aLtWvqXlYilDwLS7JejRiLoF/0It3OrzjWpY3lqs9/R7SD8lm1mkp9uKNP519G
         SsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0r3HjsQD2+mb0wsEzIakMgBjDsOoNwszNIkiBQ7nAXY=;
        b=Mbs8Kvg4QKva7TKvATbETi/BPJHEtXGZt8NrmGnfgkM6HxTNUGvYoAGLDQVv2l8yVY
         EnT2YoEEvM/iMVRkFqnCMlB3vEQ7d2XrXwYLY5sWf03HYxlh7ZwVq0WPxvFMJTB9W/P/
         qFb5V3I/aOx9HIYt5VM17LaA0AjtU7SWnQRCF0DpxO7xSVyj8BMYxPzLIbTzb9ImA+qy
         ZcsrIw9Uj09oqfOgfSEH31F3gcO6hWGkWHdyOajpvAt4Y5zrpalv7im41nBeP71shJzE
         ev8AIjQamlyNcmLaxVM4TlvjaOIZ+n47bVgq8/Vd7zwXAWqvGCwBElkfCWHcch1boLMu
         OSfA==
X-Gm-Message-State: AJIora8ftAGodcs70g6nkmL8fuyqQ8Nza7hhwcFaEkBP+tEPRa3g24Ks
        Q2TPknO+jGtGaYiwLqfDiN4jQp8ewdOp
X-Google-Smtp-Source: AGRyM1sBEiKwTqirqb0r0WooZIhScMRsn+/AtAKFxZ6scFO8jt80M5g6Z0CE9Rzq8PIP6g5h14LkhtOCuPwB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a25:9208:0:b0:66e:b73f:cdf4 with SMTP id
 b8-20020a259208000000b0066eb73fcdf4mr10579288ybo.300.1658788683969; Mon, 25
 Jul 2022 15:38:03 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:31 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-31-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 30/32] perf vendor events: Update Intel westmereex
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

Update to v3, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually
copy the westmereex files into perf and update mapfile.csv. This
change just aligns whitespace and updates the version number.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv                    | 2 +-
 tools/perf/pmu-events/arch/x86/westmereex/floating-point.json | 2 +-
 tools/perf/pmu-events/arch/x86/westmereex/frontend.json       | 2 +-
 tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 4c00b050ebc6..4cf708477680 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -27,7 +27,7 @@ GenuineIntel-6-55-[01234],v1.28,skylakex,core
 GenuineIntel-6-8[CD],v1.07,tigerlake,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v3,westmereep-sp,core
-GenuineIntel-6-2F,v2,westmereex,core
+GenuineIntel-6-2F,v3,westmereex,core
 GenuineIntel-6-86,v1,tremontx,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
index 39af1329224a..666e466d351c 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
@@ -226,4 +226,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/frontend.json b/tools/perf/pmu-events/arch/x86/westmereex/frontend.json
index 8ac5c24888c5..c561ac24d91d 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/frontend.json
@@ -23,4 +23,4 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
index 5d1e017d1261..0c3501e6e5a3 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
@@ -170,4 +170,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
-- 
2.37.1.359.gd136c6c3e2-goog

