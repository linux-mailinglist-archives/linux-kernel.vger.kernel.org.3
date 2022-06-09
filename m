Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD81544A4A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiFILcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243974AbiFILbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:31:46 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6B33A81D9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:31:21 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id hy20-20020a1709068a7400b00703779e6f2fso10896334ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bycUJydp4Is1Pgrv0uqBEliLMdGvYRKoN6kNtR19/dc=;
        b=lPOLFAzaVOjO2E4jOt3ajdFnigRsm9W5V8NrkrH81hFiV+UvGpy8BzgrUxJPkgesV4
         JHfrN4FpaAFLyyF0K+5ILXw4du2srmoNDODBSReZ0dqEEMsNlyUx+J9sOcdv336zaj8D
         WtlzYclXrCEY/MRa3dkhE2ArEhpYIFs2bTDiQSwNLa7qv+7KeLZZeav+jW98O39oDjWB
         WtWGIaUqWlr7k6ZOsucAdEX4WJ91Gr2hDXMGDLo7jig6TjQ07gN9+YmpNhuNNqX464hF
         9DIPwAlg1zMIralWSr504/4Z95jF1S2ilpCpYRzXhkFGJ9iY1e5Cgdy0HjmtbVQ3fQCF
         oEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bycUJydp4Is1Pgrv0uqBEliLMdGvYRKoN6kNtR19/dc=;
        b=R81XUb+2QnWrnojgt4Ox5taik3Bxun96g4HSC0XzC1CuTvXXORK+YRH0DqYL+pKbmT
         JuV2hNyutduv5Y743crDDj3YauUTnLJzoy+kqAcrOirM3Fp6y5k0ocWLOox60Kmo/4JT
         lCgm6sgGIlAcQ6Rk85235SVCyI6yPSU/ml1xt7/5zfg+YYX3hYgWPkv+l5minD9n+F8q
         3nkOYC3z30e4YE8EgngtnQ2DXwXme+vlTEWtkpAQreWVtESLi15HNW2sJSuAiG7kFKu8
         9xolHw6sroOtk4JmMNHQqMczn7AgFR9S0BC/FL6fu9BQEWOzWqRJYrby5G9ePAJOJlXl
         HEMQ==
X-Gm-Message-State: AOAM530XzHeaC4JBod4Ntce2PUoz/CzWXUJEOQoSkPfHIm8SNXrhUYHb
        NyECsYVBJhGMJVuG1BS/Ic8auwszBQ==
X-Google-Smtp-Source: ABdhPJydpZCykPcdaFY2rxjM84Lwhm+BapZzdgw9pPl1PPzpnynWUqwblyylyqmpNsUsmyb5P8OdnbA0Lg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:dcf:e5ba:10a5:1ea5])
 (user=elver job=sendgmr) by 2002:a05:6402:11:b0:431:680c:cca1 with SMTP id
 d17-20020a056402001100b00431680ccca1mr22174051edu.420.1654774279801; Thu, 09
 Jun 2022 04:31:19 -0700 (PDT)
Date:   Thu,  9 Jun 2022 13:30:46 +0200
In-Reply-To: <20220609113046.780504-1-elver@google.com>
Message-Id: <20220609113046.780504-9-elver@google.com>
Mime-Version: 1.0
References: <20220609113046.780504-1-elver@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 8/8] perf/hw_breakpoint: Clean up headers
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up headers:

 - Remove unused <linux/kallsyms.h>

 - Remove unused <linux/kprobes.h>

 - Remove unused <linux/module.h>

 - Remove unused <linux/smp.h>

 - Add <linux/export.h> for EXPORT_SYMBOL_GPL().

 - Sort alphabetically.

 - Move <linux/hw_breakpoint.h> to top to test it compiles on its own.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/events/hw_breakpoint.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 3b33a4075104..e9aa7f2c031a 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -17,26 +17,24 @@
  * This file contains the arch-independent routines.
  */
 
+#include <linux/hw_breakpoint.h>
+
 #include <linux/atomic.h>
+#include <linux/bug.h>
+#include <linux/cpu.h>
+#include <linux/export.h>
+#include <linux/init.h>
 #include <linux/irqflags.h>
-#include <linux/kallsyms.h>
-#include <linux/notifier.h>
-#include <linux/kprobes.h>
 #include <linux/kdebug.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/percpu.h>
+#include <linux/rhashtable.h>
 #include <linux/sched.h>
-#include <linux/spinlock.h>
-#include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/rhashtable.h>
-#include <linux/cpu.h>
-#include <linux/smp.h>
-#include <linux/bug.h>
+#include <linux/spinlock.h>
 
-#include <linux/hw_breakpoint.h>
 /*
  * Constraints data
  */
-- 
2.36.1.255.ge46751e96f-goog

