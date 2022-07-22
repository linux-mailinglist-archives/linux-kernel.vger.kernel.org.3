Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC1457E9DA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbiGVWhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbiGVWgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:36:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBF4BB5DB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:34:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31cb93cadf2so48932557b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I8nWMwwOUnxIXJLn3evVmHPoWtcNbbFXnRW8hY/SJac=;
        b=E1ul1f+6aNygcDdEnP3jteVP6U+m/TeDcIdJI0D6CBUI5i4rRTDmB4ZaGNDEEjsCjL
         jPSHSsUibDgZiRG+cQtGAizUT8uQ+pwTQeklOQmHxKPNS9xT+NHeQKA1Vl/l8Xy5Vvm5
         njBouWLeWYnM+BprRqvLdqg96drUamHqMFgo+VA3epQDM8lBW1kGzKCDIRInddm+qo9P
         sFR5QGEnN2IkSkFW+HXRyPY4DRT4aVduUXT2c4qs4IlHzqkusvIatjhESvrmWv7k529z
         W2HlHDmdmMbH3e8AF3UHhyW7ZBE9ujbxh5MsG2r3JtNcUnLrVdDTtSDqa2pY6OvTjLm2
         CE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I8nWMwwOUnxIXJLn3evVmHPoWtcNbbFXnRW8hY/SJac=;
        b=Hft+eWAh9Cq0Cb34XBPPiDk8ScRYJTpxKgEsQ2sP3Uth852OXwDzOMVKoW5ZcFGN7f
         aZSWVnVpSgpuAdS8/glhfvzL8kdKdd65t5hmrfvIn/wQrTC0DeTFOyGGbz/7WRWSU9Lh
         1Zz/U4VEYTwgfq8xd8OygLflIH6Qk0dPytTwr9GqBs58m4PSB9y5135R1Hl8Khe2+vWA
         RwcEFMu8DaxFBN8eayDTxqwMh5xKTahjBdTbYjlR2sI4SahUHQE6JRg80RMCHf/xjyFr
         /CLwKLEEZ4/bGq9aiL0JEWgLZh716bDYCHyYetgZYO906RTAwLN761aInWtLbw9zLIKr
         3QpA==
X-Gm-Message-State: AJIora/QXt5qLWgnV/T2aky8CK4HCyXjqa2BcFqx4G5Sgwg3Nbj8zZ+m
        PQhGDiGe+9uz33bRxMVn8GADTEOc1eZi
X-Google-Smtp-Source: AGRyM1txqqE72xjSEWDurh4w8N/SBw7osvr6W7K/FRaH61C+YZNM68PeLrWKM1Ux3BoRM0A90KVOTvnv5s+E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a25:bd83:0:b0:670:c602:db73 with SMTP id
 f3-20020a25bd83000000b00670c602db73mr1676790ybh.502.1658529253296; Fri, 22
 Jul 2022 15:34:13 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:40 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-32-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 31/31] perf vendor events: Update Intel westmereex
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
index f0155639c22d..7f2d777fd97f 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -28,7 +28,7 @@ GenuineIntel-6-86,v1.20,snowridgex,core
 GenuineIntel-6-8[CD],v1.07,tigerlake,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v3,westmereep-sp,core
-GenuineIntel-6-2F,v2,westmereex,core
+GenuineIntel-6-2F,v3,westmereex,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
 AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen3,core
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

