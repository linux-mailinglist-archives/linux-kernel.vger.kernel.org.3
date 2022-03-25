Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C034E6D66
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 05:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358297AbiCYEpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 00:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358276AbiCYEpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:45:07 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B3B6948B;
        Thu, 24 Mar 2022 21:43:23 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="67012658"
X-IronPort-AV: E=Sophos;i="5.90,209,1643641200"; 
   d="scan'208";a="67012658"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Mar 2022 13:43:17 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7C768DB9F7;
        Fri, 25 Mar 2022 13:43:16 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id A5C51DACE8;
        Fri, 25 Mar 2022 13:43:15 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 6F3BA403F02E4;
        Fri, 25 Mar 2022 13:43:15 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [RFC PATCH v2 1/7] libperf tests: Fix typo in the error message
Date:   Fri, 25 Mar 2022 13:38:23 +0900
Message-Id: <20220325043829.224045-2-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects a typo in the error message.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/tests/test-evlist.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index fa854c83b7e7..ed616fc19b4f 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -69,7 +69,7 @@ static int test_stat_cpu(void)
 	perf_evlist__set_maps(evlist, cpus, NULL);
 
 	err = perf_evlist__open(evlist);
-	__T("failed to open evsel", err == 0);
+	__T("failed to open evlist", err == 0);
 
 	perf_evlist__for_each_evsel(evlist, evsel) {
 		cpus = perf_evsel__cpus(evsel);
@@ -130,7 +130,7 @@ static int test_stat_thread(void)
 	perf_evlist__set_maps(evlist, NULL, threads);
 
 	err = perf_evlist__open(evlist);
-	__T("failed to open evsel", err == 0);
+	__T("failed to open evlist", err == 0);
 
 	perf_evlist__for_each_evsel(evlist, evsel) {
 		perf_evsel__read(evsel, 0, 0, &counts);
@@ -187,7 +187,7 @@ static int test_stat_thread_enable(void)
 	perf_evlist__set_maps(evlist, NULL, threads);
 
 	err = perf_evlist__open(evlist);
-	__T("failed to open evsel", err == 0);
+	__T("failed to open evlist", err == 0);
 
 	perf_evlist__for_each_evsel(evlist, evsel) {
 		perf_evsel__read(evsel, 0, 0, &counts);
@@ -507,7 +507,7 @@ static int test_stat_multiplexing(void)
 	perf_evlist__set_maps(evlist, NULL, threads);
 
 	err = perf_evlist__open(evlist);
-	__T("failed to open evsel", err == 0);
+	__T("failed to open evlist", err == 0);
 
 	perf_evlist__enable(evlist);
 
-- 
2.25.1

