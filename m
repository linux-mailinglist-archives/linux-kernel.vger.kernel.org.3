Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2853846CB25
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243562AbhLHCuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243579AbhLHCuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:50:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9815C0617A1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 18:46:36 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h5-20020a255f45000000b005ffd939127bso2077742ybm.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 18:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JL9xm0pQGWjwf/D+CorLwzYUYcl9IVQI3NDKsfgtnNk=;
        b=C9P3/WGinLrMKvSFzzif8NHIWpzFbfaMv5OWFjpGjE9dXlDuoJysDeX2XBtpbhdjMM
         fB9RjhQE20ez1WsJo6z5c1F6oWTcAkkMxst0JjdA4+TSNZtJtY+I9QMLZeHmdZyFzYPt
         3qWrer5wb8gPFZtfrQds6mSe4juDZzYBCAa77NA+cDcLqXSaANMtP9nYQqyL11EJXY3a
         wJ6/ZEtGpLzrwpWkqKaFde7Hj6Y37ClqDcM+a/EZfOi+9CCpnzTLNQNyVTlEWp4KJHxX
         m9KPxLkrABZSohO966ruLrh3PVBmeaNHyYdPCzJ7wN2jM+mTWFSUd8zMpJNWjtzaM2Vg
         J3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JL9xm0pQGWjwf/D+CorLwzYUYcl9IVQI3NDKsfgtnNk=;
        b=77tjAOZ2MxxXqxVFIyqMxHBiGrvcXcPFhFSF/xyOMywTxR/N781UzYj8uXo8hLZkB6
         kneibkqFmKuGaXfDggMiQE8+9FKGvxfrVM+BOkB5ERl9Bn6tSrTAqnbjPmei2g5QDgrP
         9OllRFK1CrReO2kViMYEHvSB1g/op+CHMzZQaNvPDwAtBILYNAYwGwdj4T6/ailhO78t
         L60VgTJQk+oAZ4uHjvTP6VVBvTf/gZUN7EbEsplGoNFbbmrQDqwPpvLzzqtM5IIAROnA
         EiN0WSKDem7K7DWCgjkR0g+mO1WhyzZVn3Z8zzfSwC//tr3kgK7NHchPFyIqqV/lCdRK
         Eg8w==
X-Gm-Message-State: AOAM5300ZLF5Uev2X1jqfPhzu8uOTm/hTeBguBnbYQRNXeVECr2jzBG6
        m3R9hdKLfgFLmRs21lIMHpJsSrXwAsqU
X-Google-Smtp-Source: ABdhPJyJ0bej87Fe++nEKMg3a/0nS/mAECp36Njxy2YWfSsOX0jck/jJeh25/ElQ7Gfv8JWtc2Ax0+tWpmuM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:cbd7:: with SMTP id
 b206mr55557475ybg.737.1638931596072; Tue, 07 Dec 2021 18:46:36 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:45:55 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-11-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 10/22] perf cpumap: Add comments to aggr_cpu_id
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

This code is already tested in topology.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index f0121dd4fdcb..edd93e1db36a 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -7,11 +7,20 @@
 #include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
+/** Identify where counts are aggregated, -1 implies not to aggregate. */
 struct aggr_cpu_id {
+	/** A value in the range 0 to number of threads. */
 	int thread;
+	/** The numa node X as read from /sys/devices/system/node/nodeX. */
 	int node;
+	/**
+	 * The socket number as read from
+	 * /sys/devices/system/cpu/cpuX/topology/physical_package_id.
+	 */
 	int socket;
+	/** The die id as read from /sys/devices/system/cpu/cpuX/topology/die_id. */
 	int die;
+	/** The core id as read from /sys/devices/system/cpu/cpuX/topology/core_id. */
 	int core;
 };
 
-- 
2.34.1.400.ga245620fadb-goog

