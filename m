Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3267658353B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiG0WN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiG0WNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:13:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2CF52E52
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:10:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k16-20020a252410000000b006718984ef63so255152ybk.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ea5qq9OwG1E7D+Zg/lMvvHqHKfra/Cfq/E+Bb/GJs0k=;
        b=cGusKGNWQl2Dyuw3y/FXTyUI0EcTQCuP+iZzPCCZMFhZ7Sv0443E5jHWTqrsZ0gTjS
         Ruuzu0fHI7s6JpEROuiabm29r103/NK802iUfZGWD+hgXs8/fPOYaOGjhVzClaz//V24
         Tl66BKu9zRQk3l73CURpZPPv6nIDjUlfeilbhC/lOkYSN5gjRw04Edvg1rYMj5BdpLN8
         8MkhZA0QCd90GSmz4dJMdG1QeUd3gkdUG8ihVJ+8d0rRb0i2G+w9zR1o0Z+3k0cWyRBf
         M+ljbDry8tcZnqxF6SdNybKHkxQfwKDxY4DXVuVAvN6ftyoKq0tsYKoubbdPgjl7vM5I
         KR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ea5qq9OwG1E7D+Zg/lMvvHqHKfra/Cfq/E+Bb/GJs0k=;
        b=jruTF9cyrFbzuNongR3dLK9QPpVYwCHaDMFoANzERCCvE9SrzjSY/nV26cmnmkAl0e
         jbUj1ajQPGOZeTVE4JjdBj3q3EiY/6ZdKKYV5/SKZBsbXNCUPgjkl63zvLIydBkXQBkt
         03zzRby+ZHuXGwYIuxxZV4ogo4/5PRSxe00Pw/wn70gs9ob09LVyO2ovOLThKs96J+dX
         m+IyAIJ7l+fGytnQdV5s8GT403HBgQITX9W2E3FlFN5foOc1iT/cjoPwIG/JpcF3kkYK
         TnVRhA+3z5C4sye6EH975Gi00Cx8rR9O4KH0EtXu1LeeVC0UC8m+vPnj41qDV5miSB8P
         7Ogw==
X-Gm-Message-State: AJIora9SYNPs4BqISQ47qOYsust6wCGAveoRO98YnfGHM2ektqcywmuK
        +fDpyM1Y8xZOum/apDn2vspbK/PRlvby
X-Google-Smtp-Source: AGRyM1sZx1VkmpaNlIu9L9Rgq9XnhJ8Ng73hpgO23J/o7yUmwkUNz+Axutoy1neyJ5X1YJ0Hm52Uh/vVwKAe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:882a:af57:8cb6:6f9e])
 (user=irogers job=sendgmr) by 2002:a81:6057:0:b0:31f:65cb:662a with SMTP id
 u84-20020a816057000000b0031f65cb662amr3529305ywb.272.1658959803463; Wed, 27
 Jul 2022 15:10:03 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:08:32 -0700
In-Reply-To: <20220727220832.2865794-1-irogers@google.com>
Message-Id: <20220727220832.2865794-31-irogers@google.com>
Mime-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3 30/30] perf vendor events: Update Intel snowridgex
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

Update to v1.20, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually copy
the snowridgex files into perf and update mapfile.csv.

Tested on a non-snowridgex with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

This change just updates the version number.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index c607f4155556..7f2d777fd97f 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -24,11 +24,11 @@ GenuineIntel-6-8F,v1.04,sapphirerapids,core
 GenuineIntel-6-(37|4C|4D),v14,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v53,skylake,core
 GenuineIntel-6-55-[01234],v1.28,skylakex,core
+GenuineIntel-6-86,v1.20,snowridgex,core
 GenuineIntel-6-8[CD],v1.07,tigerlake,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v3,westmereep-sp,core
 GenuineIntel-6-2F,v3,westmereex,core
-GenuineIntel-6-86,v1,snowridgex,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
 AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen3,core
-- 
2.37.1.359.gd136c6c3e2-goog

