Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059405324A0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbiEXH6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbiEXHzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:55:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76459AE41
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653378934; x=1684914934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A5/CoVFBWzQfMEpYvR3LxrjJSi6xfNNPtwpbje93Wbc=;
  b=gHBgM2px/51Dziio9JnltRxZYmydaXvjzUVWH6PqmL2wKdRhB2hdZ/oo
   CW4tYuKTAQSRqERL3BnvF51QruZQAl2H6ILyDDOt9ulrTG4H2F87Dusxj
   6Eax1CtijqgbUKDETfRvvs/8vd/sGagzgRXiEucv3cICH8zDRlm6HGthD
   7KnRO16aec0XIXK+hcsBvIp+3leFUiZK+Tag3GJTQ478VUL/MrbhkWxHz
   DP0uhzE++e2BV9AcyiaP3w05e/ysQI3P7rI4VLeTzWHTcOFMAEnE8LJH6
   16KV+N8DY7ZrDUmTmc1nnhWQyU7r37JBUsYyskXBvRve/qtF0XzL3Rq0R
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273455511"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273455511"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="717072436"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.52.210])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:32 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 13/15] libperf evsel: Add comments for booleans
Date:   Tue, 24 May 2022 10:54:34 +0300
Message-Id: <20220524075436.29144-14-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524075436.29144-1-adrian.hunter@intel.com>
References: <20220524075436.29144-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comments for 'system_wide' and 'requires_cpu' booleans

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/include/internal/evsel.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 77fbb8b97e5c..2a912a1f1989 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -49,7 +49,17 @@ struct perf_evsel {
 
 	/* parse modifier helper */
 	int			 nr_members;
+	/*
+	 * system_wide is for events that need to be on every CPU, irrespective
+	 * of user requested CPUs or threads. Map propagation will set cpus to
+	 * this event's own_cpus, whereby they will contribute to evlist
+	 * all_cpus.
+	 */
 	bool			 system_wide;
+	/*
+	 * Some events, for example uncore events, require a CPU.
+	 * i.e. it cannot be the 'any CPU' value of -1.
+	 */
 	bool			 requires_cpu;
 	int			 idx;
 };
-- 
2.25.1

