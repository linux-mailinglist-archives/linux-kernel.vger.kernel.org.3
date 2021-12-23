Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879E347DFCE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347146AbhLWHr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347109AbhLWHrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:03 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B672C061792
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j204-20020a2523d5000000b005c21574c704so8596840ybj.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jkb8WQdF9O+yiT4urJzPw184L/fpHPkSKVmnEzvHNI4=;
        b=cjmUrPorOPwMSR8Clp9D3BUztfdQynd9f+mTH9gfaUFdKwgXLjEpecPhtWm10pTf95
         kUko6md3ZhP8VUeVp+cOBc0Jy7VYksiU+XwG9bEZJZwyYpL5+WlBI25m6x8I0AoE7YBy
         /5hIfsd9OEg5Sd6a2fM8L2GTWOy0Qy3BrRE2imlAsxGVpL2bAMTuwSXqDv6IBpjLDw28
         Cih2qQTG3eSXRCzQsGWh/12JzeNtpxdPyM8wv8uXQza4zo9nnDbamcbPPwJEiqNLD2q9
         b6L5BCdYsBLbBj+19qoSMjTDstctOdLIIZKT6surEGtmeqFG6rPdV/KQvv303T+YxZTW
         YSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jkb8WQdF9O+yiT4urJzPw184L/fpHPkSKVmnEzvHNI4=;
        b=eEifWoVlvK0r4WtdBGUMQJCACqcyr6szRqlJt4Z/Enh2lU0c0kK/i8IeGIMT59Sv0W
         27qDIJKnfpni0KbXvH/xlQqB6vvCVvjjv0tEzcF17H5MgLhK5kgSu60JkRov17A9azER
         oyHbe93dSeayVGOnUtVJ1dnBT9Tj8PoL4xN+XtjZDZIeiDEq7Vx2JbafHEiqzx/hi7V3
         wFrZkhwS40k8YKVIaT9PGsw4eBD/j6loMU1egWnQPMNpR+r/hIkQcM4DwwiBB2GLSkCZ
         k3Xt82VrDspmWIQjDQfVcjHgqaVIamDTF9SVRaDhLjtddvU3YTdqE64OWpXzVn2FBp5w
         TPgQ==
X-Gm-Message-State: AOAM533kWdUWsE+z3edgNXd9dmhGw5N9LNqUOmAE7UqMs96CcgF1v5+y
        U/aSWsr5CmzQiEEUQwMFl1ivuL4c7xVq
X-Google-Smtp-Source: ABdhPJzRHzlckq6o8uuyeTGVvKZ4mtq8Xw/HKmt9jKvhxGET/afj05hc3jdaQ7vdvPJiKVhC3up45BXHd1bO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:d492:: with SMTP id
 m140mr1874549ybf.105.1640245620849; Wed, 22 Dec 2021 23:47:00 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:14 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-22-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 21/48] perf cpumap: Add some comments to cpu_aggr_map
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

Move cpu_aggr_map__empty_new to be with other cpu_aggr_map function.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 832fc53f3c11..8acef8ff8753 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -24,16 +24,18 @@ struct aggr_cpu_id {
 	int core;
 };
 
+/** A collection of aggr_cpu_id values, the "built" version is sorted and uniqued. */
 struct cpu_aggr_map {
 	refcount_t refcnt;
+	/** Number of valid entries. */
 	int nr;
+	/** The entries. */
 	struct aggr_cpu_id map[];
 };
 
 struct perf_record_cpu_map_data;
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
-struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
 
 struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data);
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
@@ -67,6 +69,12 @@ int cpu__get_die_id(int cpu);
  */
 int cpu__get_core_id(int cpu);
 
+/**
+ * cpu_aggr_map__empty_new - Create a cpu_aggr_map of size nr with every entry
+ * being empty.
+ */
+struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
+
 typedef struct aggr_cpu_id (*aggr_cpu_id_get_t)(int cpu, void *data);
 
 /**
-- 
2.34.1.307.g9b7440fafd-goog

