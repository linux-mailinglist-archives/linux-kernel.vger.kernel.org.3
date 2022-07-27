Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFD9583519
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbiG0WJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiG0WJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:09:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0CE5C971
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:09:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b129-20020a25e487000000b0066e1c52ac55so231400ybh.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=B+gtsj8kGdhzO57fAg1zHkfGGPsZDtIyS2F897iZGKo=;
        b=A3dG9EJpR+vAKG1aPiPXPxc0Qg6KiOhdJz9oLQm+uaUcfK8DMoBAunfOcIoYB+JEwk
         p4yaLuEXsJSyizU4VC7Iczv8DYWtBFQXnCQrk24FVd8X1TnSHmFaowZDG6S4wsv83edv
         EkuUSXzA9s6bXyYNgJuI2LOP2jq+QqR2qfXspwwGgQMt+SWoc7wm4wNIOWFX099KnCsp
         hO0Va0gKs5vudpBZvlNPGcTMfVQrmxkPm2gVptSyM/VDpWOJuoje1SMHd6KZkFbbGSde
         /Z1Zwd/KBzKuIvrKqKMaSvUd1KaYgpc2P7K/7HBBWiBSTeRHGoC7o6Cftrecmj2lgvCj
         0JkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=B+gtsj8kGdhzO57fAg1zHkfGGPsZDtIyS2F897iZGKo=;
        b=z/Npth37f8j7x8IrC4CJ8nBuuW/d0Kz13CC5JWTC/fZ8GdjClMIqoiKCh+AUYpaw57
         dcyQYxuFot1veBVLY65Hl2CeAUQWYfRWB6dwJl+5fDKloGKOTj3Qbnxe4e93OqoHWfqv
         1+O9SwuFdWGZQtVHSlrK13Hq34Nk9JIKRWGKg6dwSHdOtzf+bDRferR6fsiGPKNCWi3Q
         JutHV2X5MXdog414Tu0/OoCeB9r+OwxbTymbYhRtX6ITyqYgt0PvWfakG6yG6M9GR0km
         JrUTsz6TKKs9L+AlaK+YTl5/h/WPAkM0UlJLIzD1T7AmavyT+e/dnYBeBSredWwLXG7b
         Y3pg==
X-Gm-Message-State: AJIora/jFrwZgdqN+YOEL8AyEEyhTPRGlAPIgWyXOPPUN73s4Fzj+yV5
        Rl5P3JdblYizy4CYGBnQVT9BqfjpX2bM
X-Google-Smtp-Source: AGRyM1s3y0gOrPPHRxWceD2ePVpULzp1b1ff3+679/pfglDQl2wsDpL/dQZBEb/LxBHAFIXmVTde7KjmWKFu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:882a:af57:8cb6:6f9e])
 (user=irogers job=sendgmr) by 2002:a05:6902:1082:b0:671:7c95:e239 with SMTP
 id v2-20020a056902108200b006717c95e239mr6581764ybu.273.1658959747271; Wed, 27
 Jul 2022 15:09:07 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:08:11 -0700
In-Reply-To: <20220727220832.2865794-1-irogers@google.com>
Message-Id: <20220727220832.2865794-10-irogers@google.com>
Mime-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3 09/30] perf vendor events: Update goldmontplus mapfile.csv
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align end of file whitespace with what is generated by:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

Correct the version in mapfile.csv.
Event json remains at v1.01, there are no goldmontplus metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/goldmontplus/cache.json          | 2 +-
 tools/perf/pmu-events/arch/x86/goldmontplus/floating-point.json | 2 +-
 tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json       | 2 +-
 tools/perf/pmu-events/arch/x86/goldmontplus/memory.json         | 2 +-
 tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json       | 2 +-
 tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json | 2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv                      | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json b/tools=
/perf/pmu-events/arch/x86/goldmontplus/cache.json
index 59c039169eb8..16e8913c0434 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
@@ -1462,4 +1462,4 @@
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/floating-point.jso=
n b/tools/perf/pmu-events/arch/x86/goldmontplus/floating-point.json
index c1f00c9470f4..9c3d22439530 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/floating-point.json
@@ -35,4 +35,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json b/to=
ols/perf/pmu-events/arch/x86/goldmontplus/frontend.json
index 3fdc788a2b20..4c2abfbac8f8 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json
@@ -95,4 +95,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/memory.json b/tool=
s/perf/pmu-events/arch/x86/goldmontplus/memory.json
index e26763d16d52..ae0cb3451866 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/memory.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/memory.json
@@ -35,4 +35,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
index 4d7e3129e5ac..2b712b12cc1f 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
@@ -428,7 +428,7 @@
         "EventName": "MACHINE_CLEARS.SMC",
         "PDIR_COUNTER": "na",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of times that the processo=
r detects that a program is writing to a code section and has to perform a =
machine clear because of that modification.  Self-modifying code (SMC) caus=
es a severe penalty in all Intel architecture processors.",
+        "PublicDescription": "Counts the number of times that the processo=
r detects that a program is writing to a code section and has to perform a =
machine clear because of that modification.  Self-modifying code (SMC) caus=
es a severe penalty in all Intel(R) architecture processors.",
         "SampleAfterValue": "20003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.jso=
n b/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
index 36eaec87eead..1f7db22c15e6 100644
--- a/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
@@ -218,4 +218,4 @@
         "SampleAfterValue": "20003",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 17047a972c16..9a69ecc95d66 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -7,7 +7,7 @@ GenuineIntel-6-4F,v19,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.16,cascadelakex,core
 GenuineIntel-6-96,v1.03,elkhartlake,core
 GenuineIntel-6-5[CF],v13,goldmont,core
-GenuineIntel-6-7A,v1,goldmontplus,core
+GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-3C,v24,haswell,core
 GenuineIntel-6-45,v24,haswell,core
 GenuineIntel-6-46,v24,haswell,core
--=20
2.37.1.359.gd136c6c3e2-goog

