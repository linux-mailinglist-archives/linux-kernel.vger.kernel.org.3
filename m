Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B557E9BC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbiGVWeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbiGVWdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:33:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE1DBB23C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e89d6bea7so44463917b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=GbGcWKJXirAT7Uwkk1IBnk+6Tx6CCZwNj3BNiHUgNxk=;
        b=ruwhvf3v46+XmQ+hiLHLVbkB9pSmjOUM+QXF3JDKzyE6n2ht0qzI0K1oM/UDUWVII2
         XXFSP86vkz1tKdfExtI4C2w0xaY6R1mlK68ASMDRik2xhshwbqIy5VlYEdi5DH3kLXSS
         46DPPe/mD6CgZYtu6gwtWAZxFuiW04K21RNUdztCt2/gfNSqdcj5b0HE3dyr4uX+9ZJ4
         4oioKOaSivkb8VINTQyJ+lVH/E+jtfMPLtyQkQ76LcJZi6oVm67VTsgd2TzUY4i1/h47
         mnjsrnP2yzjYFj5Qs2gXTxmg0hWjHEYoDQdmAXEZUWC1KtVQEa7DOPzydqits0AY6+ee
         83Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=GbGcWKJXirAT7Uwkk1IBnk+6Tx6CCZwNj3BNiHUgNxk=;
        b=zREw8WERcxf6Uz2/+aGAKrB6X+hO0Oq5aEL8oOPgz7+MiYdUrSfRrDUaOA4xCXAl/w
         gWHOSdvMj+PPeGjs45CMb5NYLRt0dlIvaZkyaD061zAbofDOkSLeP4LqRceu2qwHtP8f
         LVqfAUUxH9cBjCDjP1Oo/ffN2fBYWK3joY/Zl5jLZiZM1W+1GuVXex6u++gOg6DqIrnu
         WWft806KJWTXk7ETDqg13Y/xeSG802n6VsfGUsX/ahUaGlYy1TbD2nwqQ05pip22IAzP
         w/O3r+riS7qXyGmFr1f04NMXPuuroaubZG3+EGoGH6lvURc6vhHqD6zWROK+AE6u1aec
         4l/Q==
X-Gm-Message-State: AJIora+C2JhkMwChwwUSnDdQahcS/bVjHZOGKcOHfKwcxPCSAc395lkH
        0WBC7N1fI9zlAd7yv1uxPxSl9M3JEHYR
X-Google-Smtp-Source: AGRyM1usLU7Z0bIKG6d4oTP/xH9M+6ofFNP5p+12uAxBLiuqljuNNpatcvbt9GcmuqZeySOS+NWXGosFSY0G
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a25:bfcb:0:b0:670:8107:3fc7 with SMTP id
 q11-20020a25bfcb000000b0067081073fc7mr1724201ybm.429.1658529197705; Fri, 22
 Jul 2022 15:33:17 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:19 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-11-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 10/31] perf vendor events: Update goldmontplus mapfile.csv
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
index ef0beab68a90..a2991906b51c 100644
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

