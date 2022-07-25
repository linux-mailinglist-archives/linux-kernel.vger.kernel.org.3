Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2435F5807AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbiGYWla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbiGYWjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:39:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66E62611E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:38:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m123-20020a253f81000000b0066ff6484995so9618446yba.22
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XYXEQIuy7h924sIm++0QL8msX4qZC4lZX28byHCoX+w=;
        b=QMV/ybTkfw1e72GPBPoLbYsd+XjiKEz2oJd9Jbb1qSS3aJDSoBQjQkeMl/iJtrRbMW
         hl57AbCsWZd0JsToqbvl5EbufBA6lcTFioj6KFLoi8zNJUqcgJaHvmg9lmfyToCn7dXB
         zJecYAhwiyRBOilNnIPQ16hArq9H2ftH2Ij+Rdl8Cuo5T1VXwL4h1m/6jLYlV9S1bEP8
         DWxOocTITe1H28dxaFXraGAacXctHf7tjcE/RM58EtqFo/xrf/jxkGOwxthO5CnQwSzS
         lqTITJl1H60UriBmHLtz3ZGcA3m7SpJiyyWqpYoMAS2dng8QHg/TR87ocCUU7qKHzTgv
         lgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XYXEQIuy7h924sIm++0QL8msX4qZC4lZX28byHCoX+w=;
        b=M6Uv38pn1W807DZ8v/Lhd/PICqfQWnw+r7A3uy23u9C1v1V0/AOWtk0jeJjStQIAhi
         o3Kw2E4thWWXGdTxQ6QDmVOWv5MvDOk+f05b+FWKQW1Ty0+Ae+eoaYGk4eImfnOL3NKD
         YJCVAIyJAnbejQAxYIpxBp9ibqaDc7OIcy5u8mi8VttABpNeFc1KWMDXjHr6ync5gFVX
         rq6664JY47lhgIN7hQCM9QDeTDGJlLD2JEZbOC/l9N+a7bTZ7XmkbaD2tAAXab1yua8W
         IPuKbEWd/t4op50UxGaX6psbDb6/Z/3uA64j6R6uKkcRkxPwvRRHgKqjBVNh9tLMdde0
         p9lw==
X-Gm-Message-State: AJIora9jXqNbGjY1SlhHSO7JCE2XwldTJjrLl+3QC4yn9NiMXIv1Hqef
        T2R+ODM0mIxkSdfBT+Dq4PAHCyksm6Ve
X-Google-Smtp-Source: AGRyM1s409YKheeodSYji9f5l2Bq3f11WDdbB2wYwHte+vCkagU3vpfmA0LfENcSF+OVWxU/OGHGG9+50L3H
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a25:b9ce:0:b0:670:8423:eacb with SMTP id
 y14-20020a25b9ce000000b006708423eacbmr11191785ybj.324.1658788686381; Mon, 25
 Jul 2022 15:38:06 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:32 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-32-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 31/32] perf vendor events intel: Rename tremontx to snowridgex
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

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Tremontx was an old name for Snowridgex, so rename Tremontx to Snowridgex.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv                      | 2 +-
 .../pmu-events/arch/x86/{tremontx => snowridgex}/cache.json     | 0
 .../arch/x86/{tremontx => snowridgex}/floating-point.json       | 0
 .../pmu-events/arch/x86/{tremontx => snowridgex}/frontend.json  | 0
 .../pmu-events/arch/x86/{tremontx => snowridgex}/memory.json    | 0
 .../pmu-events/arch/x86/{tremontx => snowridgex}/other.json     | 0
 .../pmu-events/arch/x86/{tremontx => snowridgex}/pipeline.json  | 0
 .../arch/x86/{tremontx => snowridgex}/uncore-memory.json        | 0
 .../arch/x86/{tremontx => snowridgex}/uncore-other.json         | 0
 .../arch/x86/{tremontx => snowridgex}/uncore-power.json         | 0
 .../arch/x86/{tremontx => snowridgex}/virtual-memory.json       | 0
 11 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/cache.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/floating-point.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/frontend.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/memory.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/other.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/pipeline.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/uncore-memory.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/uncore-other.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/uncore-power.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/virtual-memory.json (100%)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 4cf708477680..7ae035d4cc42 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -24,11 +24,11 @@ GenuineIntel-6-8F,v1.04,sapphirerapids,core
 GenuineIntel-6-(37|4C|4D),v14,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v53,skylake,core
 GenuineIntel-6-55-[01234],v1.28,skylakex,core
+GenuineIntel-6-86,v1,snowridgex,core
 GenuineIntel-6-8[CD],v1.07,tigerlake,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v3,westmereep-sp,core
 GenuineIntel-6-2F,v3,westmereex,core
-GenuineIntel-6-86,v1,tremontx,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
 AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen3,core
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/cache.json b/tools/perf/pmu-events/arch/x86/snowridgex/cache.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/cache.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/cache.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/floating-point.json b/tools/perf/pmu-events/arch/x86/snowridgex/floating-point.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/floating-point.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/floating-point.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/frontend.json b/tools/perf/pmu-events/arch/x86/snowridgex/frontend.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/frontend.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/frontend.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/memory.json b/tools/perf/pmu-events/arch/x86/snowridgex/memory.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/memory.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/memory.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/other.json b/tools/perf/pmu-events/arch/x86/snowridgex/other.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/other.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/other.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/pipeline.json b/tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/pipeline.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/virtual-memory.json b/tools/perf/pmu-events/arch/x86/snowridgex/virtual-memory.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/virtual-memory.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/virtual-memory.json
-- 
2.37.1.359.gd136c6c3e2-goog

