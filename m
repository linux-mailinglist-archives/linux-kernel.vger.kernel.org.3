Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A578A481A35
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbhL3HV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237444AbhL3HVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3FFC06179B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i203-20020a2554d4000000b0060a529902b3so32485079ybb.21
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7nJ9aOY2C2GnsWnTQGBnrlJBEwWMod18BO03r+kibPw=;
        b=KWezbe3kkqPhJVVohiMlaiTOEk+T1iyv7L7SQrNAh7oF1e4VMmdNRhKKa1wNAd2OK6
         Qwu0hPZiulgsvcHIj9u6XNurh/w9x++sISOXTc68b9DgjYWvrGewl96FQmNCXz8UyN9L
         dU495nJujAPGS1Ma12QbKw7l8sEe/zWI8c1+fGPeDz37mk1lEEGU43Jh8c4viwjGOsM7
         dolbipQA5ILAJQ+tfw6QMzPP9ReNtr5HUPXvTlzMcCTjn7JeENQjPS+oTkQTGt2aO1G0
         w+qxvpUVp0KWbenT+UqojIiKqBrKJVuqq1dK/uYtHMAbQMfOj+XY4qazQhOi3+sriIzX
         v24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7nJ9aOY2C2GnsWnTQGBnrlJBEwWMod18BO03r+kibPw=;
        b=C1Py9uHKWLRLXDJuo3M5h4DydllmEg7MDXmqOTzPS5oE4/tJjSwlQ3kRBKR2w2bmyN
         Vko1k/D46kyj5URBAHxyHoJf8lmAnDjVVvhX4RN2vmRq+ouWyIC0MWjKqoKxMFKeAOZH
         to7IZsT3yLYj/T+DFw20gfLlLcihB2iauo0KLfaop5a5k4WliGd3M4fKeeElZzOlcquI
         1moOK/gEfo10+urZcvtHiv6cXLn/st+lZYZKMo23U/5na7kne3bhIYo4m+NrhtyQFKJ5
         x6WFqhfAVsPz1bgyqS//iBsBD8DiexXHsAV3iXcJ0dg9MKJN+QD33ZMc3d8nHKys3TNK
         hQqA==
X-Gm-Message-State: AOAM531GcZGF+oSDiJ68PtTgRR9e9R715c/7BHmkuONhGWoqTJTG8Kyq
        XpdABSStdlX+Zlnd4Txa6eyaZSmgifMS
X-Google-Smtp-Source: ABdhPJzov2mWeddkNNyT1ptl/wAa61C67X+DyXseDVp52ciwdu0LHcmg4sggAmCr1woeI93RSQ8d4qjzFAXj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:da4a:: with SMTP id
 n71mr29939366ybf.600.1640848873588; Wed, 29 Dec 2021 23:21:13 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:56 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-16-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 14/48] perf cpumap: Rename empty functions.
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
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove cpu_map from name as a cpu_map isn't used. Pass a const pointer
rather than by value to avoid unnecessary copying.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c      | 12 ++++++------
 tools/perf/util/cpumap.c       | 24 ++++++++++++------------
 tools/perf/util/cpumap.h       |  4 ++--
 tools/perf/util/stat-display.c | 10 +++++-----
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6b985abaa2d2..d229fb71b577 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1349,9 +1349,9 @@ static struct aggr_cpu_id perf_stat__get_node(struct perf_stat_config *config __
 static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
 					      aggr_get_id_t get_id, int cpu)
 {
-	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
-	if (cpu_map__aggr_cpu_id_is_empty(config->cpus_aggr_map->map[cpu]))
+	if (aggr_cpu_id__is_empty(&config->cpus_aggr_map->map[cpu]))
 		config->cpus_aggr_map->map[cpu] = get_id(config, cpu);
 
 	id = config->cpus_aggr_map->map[cpu];
@@ -1496,7 +1496,7 @@ static inline int perf_env__get_cpu(void *data, struct perf_cpu_map *map, int id
 static struct aggr_cpu_id perf_env__get_socket_aggr_by_cpu(int cpu, void *data)
 {
 	struct perf_env *env = data;
-	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
 	if (cpu != -1)
 		id.socket = env->cpu[cpu].socket_id;
@@ -1507,7 +1507,7 @@ static struct aggr_cpu_id perf_env__get_socket_aggr_by_cpu(int cpu, void *data)
 static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(int cpu, void *data)
 {
 	struct perf_env *env = data;
-	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
 	if (cpu != -1) {
 		/*
@@ -1525,7 +1525,7 @@ static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(int cpu, void *data)
 static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(int cpu, void *data)
 {
 	struct perf_env *env = data;
-	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
 	if (cpu != -1) {
 		/*
@@ -1543,7 +1543,7 @@ static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(int cpu, void *data)
 
 static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(int cpu, void *data)
 {
-	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
 	id.node = perf_env__numa_node(data, cpu);
 	return id;
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 8fa00a6221c8..b3e1304aca0c 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -104,7 +104,7 @@ struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr)
 
 		cpus->nr = nr;
 		for (i = 0; i < nr; i++)
-			cpus->map[i] = cpu_map__empty_aggr_cpu_id();
+			cpus->map[i] = aggr_cpu_id__empty();
 
 		refcount_set(&cpus->refcnt, 1);
 	}
@@ -130,7 +130,7 @@ int cpu_map__get_socket_id(int cpu)
 
 struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data __maybe_unused)
 {
-	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
 	id.socket = cpu_map__get_socket_id(cpu);
 	return id;
@@ -209,7 +209,7 @@ struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data)
 	 * make a unique ID.
 	 */
 	id = cpu_map__get_socket_aggr_by_cpu(cpu, data);
-	if (cpu_map__aggr_cpu_id_is_empty(id))
+	if (aggr_cpu_id__is_empty(&id))
 		return id;
 
 	id.die = die;
@@ -234,7 +234,7 @@ struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data)
 
 	/* cpu_map__get_die returns a struct with socket and die set*/
 	id = cpu_map__get_die_aggr_by_cpu(cpu, data);
-	if (cpu_map__aggr_cpu_id_is_empty(id))
+	if (aggr_cpu_id__is_empty(&id))
 		return id;
 
 	/*
@@ -248,7 +248,7 @@ struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data)
 
 struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data __maybe_unused)
 {
-	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
 	id.node = cpu_map__get_node_id(cpu);
 	return id;
@@ -602,16 +602,16 @@ bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b
 		a->core == b->core;
 }
 
-bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a)
+bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
 {
-	return a.thread == -1 &&
-		a.node == -1 &&
-		a.socket == -1 &&
-		a.die == -1 &&
-		a.core == -1;
+	return a->thread == -1 &&
+		a->node == -1 &&
+		a->socket == -1 &&
+		a->die == -1 &&
+		a->core == -1;
 }
 
-struct aggr_cpu_id cpu_map__empty_aggr_cpu_id(void)
+struct aggr_cpu_id aggr_cpu_id__empty(void)
 {
 	struct aggr_cpu_id ret = {
 		.thread = -1,
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 652b76c69376..9589b0001a28 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -68,7 +68,7 @@ int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
 
 bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b);
-bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a);
-struct aggr_cpu_id cpu_map__empty_aggr_cpu_id(void);
+bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a);
+struct aggr_cpu_id aggr_cpu_id__empty(void);
 
 #endif /* __PERF_CPUMAP_H */
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 0241436bb1fb..870b1db71fbc 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -698,7 +698,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 
 	uval = val * counter->scale;
 	if (cpu != -1) {
-		id = cpu_map__empty_aggr_cpu_id();
+		id = aggr_cpu_id__empty();
 		id.core = cpu;
 	}
 	printout(config, id, nr, counter, uval,
@@ -780,7 +780,7 @@ static struct perf_aggr_thread_value *sort_aggr_thread(
 			continue;
 
 		buf[i].counter = counter;
-		buf[i].id = cpu_map__empty_aggr_cpu_id();
+		buf[i].id = aggr_cpu_id__empty();
 		buf[i].id.thread = thread;
 		buf[i].uval = uval;
 		buf[i].val = val;
@@ -868,7 +868,7 @@ static void print_counter_aggr(struct perf_stat_config *config,
 		fprintf(output, "%s", prefix);
 
 	uval = cd.avg * counter->scale;
-	printout(config, cpu_map__empty_aggr_cpu_id(), 0, counter, uval, prefix, cd.avg_running,
+	printout(config, aggr_cpu_id__empty(), 0, counter, uval, prefix, cd.avg_running,
 		 cd.avg_enabled, cd.avg, &rt_stat);
 	if (!metric_only)
 		fprintf(output, "\n");
@@ -911,7 +911,7 @@ static void print_counter(struct perf_stat_config *config,
 			fprintf(output, "%s", prefix);
 
 		uval = val * counter->scale;
-		id = cpu_map__empty_aggr_cpu_id();
+		id = aggr_cpu_id__empty();
 		id.core = cpu;
 		printout(config, id, 0, counter, uval, prefix,
 			 run, ena, 1.0, &rt_stat);
@@ -938,7 +938,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 		if (prefix)
 			fputs(prefix, config->output);
 		evlist__for_each_entry(evlist, counter) {
-			id = cpu_map__empty_aggr_cpu_id();
+			id = aggr_cpu_id__empty();
 			id.core = cpu;
 			if (first) {
 				aggr_printout(config, counter, id, 0);
-- 
2.34.1.448.ga2b2bfdf31-goog

