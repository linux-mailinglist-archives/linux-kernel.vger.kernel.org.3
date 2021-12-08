Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F5846CB1B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243326AbhLHCtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243295AbhLHCtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:49:46 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8994C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 18:46:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g36-20020a25ae64000000b005c1f46f7ee6so2124316ybe.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 18:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wlzvFhqo5Ob2FwSLKutkF1C2G0YnCryxWNekd2r2c2M=;
        b=Q8t3vuVt5q7bW590pG9nfgKeyqZ0Co6klwyMM5o4/s2kFV1RCqA9wgvbb6E0+ZM6RT
         UZQfEsOgxsd14ixKImooKlXrhBUlmsHt5SA1YCIelGWvUEC4HugO2tJ2RrCKVNNY6TfU
         OVLkMbvmHKlVq6r8yCTzn9ICfIk6FpRkYOq160a9v8JIVFuFv7i20J2Sl9WBRsPCrL9l
         EteHUVRn690jGncjOZRPeDgFtK5+c9TKUDPwlvCPnp2NlaDS+EV/h2o/GeXoSWcpUkzB
         QtO8De/+wJY1LEGyW3J6QpPqUgwl9PVC2CMq/rHQYt3BMtKVpOO0aFzk/s7R5VJ8lbub
         JAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wlzvFhqo5Ob2FwSLKutkF1C2G0YnCryxWNekd2r2c2M=;
        b=AlGs97al/k0sZulWusId6VO4NQtm0Ol9j0rtWZApFCLRucXvcBOyKZ6Qcpm2kodwhv
         U1E9aSkhRuNitIIiNxwCfGQuVhwDyCTlSXrc8BhwE2dWijrENUl8ej5y/lv3yIBUvhVL
         R4FPBQbXwaF8oOxzFh7nFsai02IJvwJFduHexm6Kol76R/SkKaBD7R8ixpNQhrjgk6Gn
         Pp68egaw5NgLwhA/v73G+GX1/0V16wmZjsQYFucQTO2cqIJi73Zz9Xv2s5PQUYSQLnZB
         8fcLc674gblV/2c/sUeOXm3RTD2UlpTpp2DbljYnjxQd0VyhaI/mqcU2Ma3dRj1Au3jW
         MqOQ==
X-Gm-Message-State: AOAM533mNXSRiwOQwLM43qRaEq1LITeGNnNUJj7F+02yTidOrNs0Td2u
        NLjKlFBShypHaIvaXl+0pXYDXIGgFMbM
X-Google-Smtp-Source: ABdhPJwPLdvV4+k3N1J9vtHeKfWpSN8ZFNP1H2Dx+thd1lOFDc+08AeCs8ZCcfhvyR8H0iivKwE9YjuCBMcg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:aa43:: with SMTP id
 s61mr52118737ybi.186.1638931574080; Tue, 07 Dec 2021 18:46:14 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:45:46 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-2-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 01/22] libperf: Add comments to perf_cpu_map.
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A particular observed problem is confusing the index with the CPU value,
documentation should hopefully reduce this type of problem.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/cpumap.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index 840d4032587b..1c1726f4a04e 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -4,9 +4,16 @@
 
 #include <linux/refcount.h>
 
+/**
+ * A sized, reference counted, sorted array of integers representing CPU
+ * numbers. This is commonly used to capture which CPUs a PMU is associated
+ * with.
+ */
 struct perf_cpu_map {
 	refcount_t	refcnt;
+	/** Length of the map array. */
 	int		nr;
+	/** The CPU values. */
 	int		map[];
 };
 
-- 
2.34.1.400.ga245620fadb-goog

