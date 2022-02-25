Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE904C4279
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239621AbiBYKgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239591AbiBYKgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:36:42 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB192399F4;
        Fri, 25 Feb 2022 02:36:10 -0800 (PST)
IronPort-SDR: 3Ize7zT55FsZi+9UEP3oL5OFjOldX0bdD8oqpHofkx6N9REqySHynuB3vFr3NGK3UkvpPvyPn3
 SzD+RXjnw7OBhpYOdH7ZxRpPRLjzK68V8r4dXfEbi4Ka5pYexU9M/dyWp8VEy4kHPzR0xQgvQl
 tmP+9x7Yy/0jesRwHC/jwBLVJq8zmaM7D40bJaxOu7kjBVxjQcL+++RmAhPQKrzO7BPTltgHXa
 URgHiAo2TtUbZ5BkrEgrUVDXw6JR61hEMKxkCji7piNbdl5kGzxyaLR/v16kaFOnLAC7gOOaqY
 p4ABAb6LrOyNs7wAmkUVIMlX
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="64248432"
X-IronPort-AV: E=Sophos;i="5.90,136,1643641200"; 
   d="scan'208";a="64248432"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Feb 2022 19:35:08 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8CAD1C68A8;
        Fri, 25 Feb 2022 19:35:06 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7899FCFBC2;
        Fri, 25 Feb 2022 19:35:05 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 6D1AA40124EF7;
        Fri, 25 Feb 2022 19:35:05 +0900 (JST)
From:   Shunsuke <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: [RFC PATCH 1/7] libperf tests: Fix typo in the error message "evsel" -> "evlist"
Date:   Fri, 25 Feb 2022 19:31:08 +0900
Message-Id: <20220225103114.144239-2-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225103114.144239-1-nakamura.shun@fujitsu.com>
References: <20220225103114.144239-1-nakamura.shun@fujitsu.com>
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

From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

This patch corrects a typo in the error message.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/tests/test-evlist.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index b3479dfa9a1c..fafc6b0f8687 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -68,7 +68,7 @@ static int test_stat_cpu(void)
 	perf_evlist__set_maps(evlist, cpus, NULL);
 
 	err = perf_evlist__open(evlist);
-	__T("failed to open evsel", err == 0);
+	__T("failed to open evlist", err == 0);
 
 	perf_evlist__for_each_evsel(evlist, evsel) {
 		cpus = perf_evsel__cpus(evsel);
@@ -129,7 +129,7 @@ static int test_stat_thread(void)
 	perf_evlist__set_maps(evlist, NULL, threads);
 
 	err = perf_evlist__open(evlist);
-	__T("failed to open evsel", err == 0);
+	__T("failed to open evlist", err == 0);
 
 	perf_evlist__for_each_evsel(evlist, evsel) {
 		perf_evsel__read(evsel, 0, 0, &counts);
@@ -186,7 +186,7 @@ static int test_stat_thread_enable(void)
 	perf_evlist__set_maps(evlist, NULL, threads);
 
 	err = perf_evlist__open(evlist);
-	__T("failed to open evsel", err == 0);
+	__T("failed to open evlist", err == 0);
 
 	perf_evlist__for_each_evsel(evlist, evsel) {
 		perf_evsel__read(evsel, 0, 0, &counts);
@@ -506,7 +506,7 @@ static int test_stat_multiplexing(void)
 	perf_evlist__set_maps(evlist, NULL, threads);
 
 	err = perf_evlist__open(evlist);
-	__T("failed to open evsel", err == 0);
+	__T("failed to open evlist", err == 0);
 
 	perf_evlist__enable(evlist);
 
-- 
2.31.1

