Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FBE53C3E7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 06:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbiFCE5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 00:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCE5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 00:57:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C421831
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 21:57:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-30c9a01d1c5so59694827b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 21:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MEQmxhdhzj6Wva0dy8UFtG14viIsjIrwd9QZHTnb4Sg=;
        b=WhkX3pc6B1nQlpibT1FYCsRiyGAaNvybNGGpmlm4CoUsKd3Wlca7WK5LjY5Z/KOsDs
         sdb/q6pSoMbrvKG6pr9gVgnRCEXycNiRCTZmrdiv1j+fIFZ3thVdebsjQ2mPTxKtTKZb
         wD+n0UaX57U6Ht3D61rYEIUV9p0fionYn2lmaYEbbjmbAL1FNBQb36bbvk0x95WWjkrE
         Cg1Ja4E0ue3ND3QaNDiRKi3O0frT587ZQ/LOdDa1bdLjoDRJQiISUvQjXPbKvHgJkZVD
         yA36QkodwQEPa3xec6pEe21dQnQ6GK8NERN1N4TOdvGvGf/Ka8wYO4dWy3xieJQmF8wB
         hAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MEQmxhdhzj6Wva0dy8UFtG14viIsjIrwd9QZHTnb4Sg=;
        b=yopLFbQc+9rncnm6mYYQlYApuNfqEEWSsI/4TN/SY8XQHcvQYItL+m0LjnKTqVbh4w
         mown58Y7M8dM/6xfizG+8ZrWlSwnfRHloMtTm5nz0Zv5kTilQKJea/8OVBTzmGeGmwTE
         1fSDUDcd7xmpjnhhODwGugTO5M9o7FWt3ECcC7aHMKyWlnMl97bqy/hpxbDJFpsXSc2x
         1iCeR0UOH+0XgR61nopBfb8YQSQpJzpPgWNuszWz3Gl02f1jHAkEquGFXKD0Q5zAeW1I
         pQzR4PJm8wP7HG0/KTZG3lNiFnTZ70+E/PE93GMIpgw5BlejhMKTt0gdeeNQI9qtyr8B
         7exw==
X-Gm-Message-State: AOAM531mwmaMxNRCDPxYSsi1oye4s56iSsLJoDTSAzgtuO44oHPG/9j9
        fMfcR16L9t5bTAE2v6Lp8gjbghnXTmXk
X-Google-Smtp-Source: ABdhPJxC68EAiBGvASOaIPffKNdFKZ0ETYvIPGwdmpWXvlMj0PsDeresPRUqm2vz4oret+2Hq1YldMxgGydC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:7125:61ca:dfbf:5f0b])
 (user=irogers job=sendgmr) by 2002:a25:bd8b:0:b0:657:8392:55c3 with SMTP id
 f11-20020a25bd8b000000b00657839255c3mr9130007ybh.452.1654232269215; Thu, 02
 Jun 2022 21:57:49 -0700 (PDT)
Date:   Thu,  2 Jun 2022 21:57:44 -0700
Message-Id: <20220603045744.2815559-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH] perf docs: Correct typo of event_sources
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Sandipan Das <sandipan.das@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Alyssa Ross <hi@alyssa.is>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Like Xu <likexu@tencent.com>,
        Joshua Martinez <joshuamart@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kevin Nomura <nomurak@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysfs directory is called event_source.

Reported-by: Kevin Nomura <nomurak@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt | 2 +-
 tools/perf/Documentation/perf-stat.txt   | 2 +-
 tools/perf/Documentation/perf-top.txt    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index b4e9ef7edfef..cf8ad50f3de1 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -33,7 +33,7 @@ OPTIONS
         - a raw PMU event in the form of rN where N is a hexadecimal value
           that represents the raw register encoding with the layout of the
           event control registers as described by entries in
-          /sys/bus/event_sources/devices/cpu/format/*.
+          /sys/bus/event_source/devices/cpu/format/*.
 
         - a symbolic or raw PMU event followed by an optional colon
 	  and a list of event modifiers, e.g., cpu-cycles:p.  See the
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 8d1cde00b8d6..d8a33f4a47c5 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -39,7 +39,7 @@ report::
 	- a raw PMU event in the form of rN where N is a hexadecimal value
 	  that represents the raw register encoding with the layout of the
 	  event control registers as described by entries in
-	  /sys/bus/event_sources/devices/cpu/format/*.
+	  /sys/bus/event_source/devices/cpu/format/*.
 
         - a symbolic or raw PMU event followed by an optional colon
 	  and a list of event modifiers, e.g., cpu-cycles:p.  See the
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index cac3dfbee7d8..c1fdba26bf53 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -41,7 +41,7 @@ Default is to monitor all CPUS.
 	(use 'perf list' to list all events) or a raw PMU event in the form
 	of rN where N is a hexadecimal value that represents the raw register
 	encoding with the layout of the event control registers as described
-	by entries in /sys/bus/event_sources/devices/cpu/format/*.
+	by entries in /sys/bus/event_source/devices/cpu/format/*.
 
 -E <entries>::
 --entries=<entries>::
-- 
2.36.1.255.ge46751e96f-goog

