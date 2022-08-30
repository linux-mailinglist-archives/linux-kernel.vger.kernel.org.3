Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF2F5A68BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiH3QtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiH3QtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:49:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25449BA162
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:49:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33daeaa6b8eso182133007b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=TTzZt2MqnQlXfvTzLI7MzZx0sdeqXflvaM4OPZwrit0=;
        b=LWxnDRkDBU9PC3Z/RMXD1/pPx+42f81N9G3pjnaKh9jFYWInA7UDNwGH9Vl49dOcQo
         OtWlvneeBw9GZQEfAqvQjVlm2WCpZPVdUsWuoQRARR1izk+d1ZO4ziXPNLckOZ3ivBVz
         1/LazNhdZ5T/wNLJOwbtNzkE3jUOVDYK6VLIVGPyGqjWjgr6uUsSBWHfPIuu/i5RdFR1
         fS40Bji8+JWHv33iYInieIbyOSeETu1GHZ6tUfgoRGWy40+SPCvirpEkrVJtDFsKX6pF
         4EszuIGn5zlvk9NUI0w8D4pQlcj9GZbzbaEuhVMtr4NK0HOuWSyvYZv6CwakKx+x15OS
         JMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=TTzZt2MqnQlXfvTzLI7MzZx0sdeqXflvaM4OPZwrit0=;
        b=BvZZ5cSlCdtLuJtJZ3WjGlPUKIp3e4uRwOGdEXHHmQhd1ci/apGi3xxFHUnCUbhHCt
         eKPpVr4b49Z+6kSBhJzhnsOB2/QTr7q6iRIHXjhrnq4p3mHNnFqikRW5rmTH63VKwfba
         9LvLsF5/gW2XpUXVAX7tS1BUm7NqjZR98tmrdydA2F7TM36XrpTyM5DwJ/FwcvvGDjtE
         89K0ET4u9lGjD4sKRF4z6kJ273FrcrQOBqw97RpmUton1CUKEpaDP7k8goqJMHXBxpYV
         52AFU/ZIeW+ckF8wo1NG8DTJ2PItZNG3t+vCQ3dzwNIwA2AjgcbVvT5JTr8llQSeRXaC
         GS7Q==
X-Gm-Message-State: ACgBeo1CQN4XLa6C8ag2014tMJKcBaz0I8bbQtYblB3hgF/EPCYDlN2J
        NyJucA+4C8JQegeKss4WnKn2JoGNjQer
X-Google-Smtp-Source: AA6agR52AWfpqQYvl/0z5UzBgsYu7Z5fc3HvzYVDoiN8Fqg2ln6CV35ottUScDetIIkDMxxA+Y/suIv+rG7X
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:902c:b0fa:dec9:8767])
 (user=irogers job=sendgmr) by 2002:a05:6902:1143:b0:695:7755:2acb with SMTP
 id p3-20020a056902114300b0069577552acbmr12618883ybu.48.1661878143376; Tue, 30
 Aug 2022 09:49:03 -0700 (PDT)
Date:   Tue, 30 Aug 2022 09:48:39 -0700
In-Reply-To: <20220830164846.401143-1-irogers@google.com>
Message-Id: <20220830164846.401143-2-irogers@google.com>
Mime-Version: 1.0
References: <20220830164846.401143-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v1 1/8] perf smt: Tidy header guard add SPDX
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

Make the header guard consistent with others.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/smt.c | 1 +
 tools/perf/util/smt.h | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 2b0a36ebf27a..8fed03283c85 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/tools/perf/util/smt.h b/tools/perf/util/smt.h
index b8414b7bcbc8..a98d65808f6a 100644
--- a/tools/perf/util/smt.h
+++ b/tools/perf/util/smt.h
@@ -1,6 +1,7 @@
-#ifndef SMT_H
-#define SMT_H 1
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SMT_H
+#define __SMT_H 1
 
 int smt_on(void);
 
-#endif
+#endif /* __SMT_H */
-- 
2.37.2.672.g94769d06f0-goog

