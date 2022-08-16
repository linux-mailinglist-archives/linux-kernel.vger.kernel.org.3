Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798CA596148
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiHPRip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbiHPRih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:38:37 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C791C3718C;
        Tue, 16 Aug 2022 10:38:33 -0700 (PDT)
X-QQ-mid: bizesmtp86t1660671497tp0hmleu
Received: from harry-jrlc.. ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 17 Aug 2022 01:38:05 +0800 (CST)
X-QQ-SSF: 0100000000200060D000B00A0000020
X-QQ-FEAT: r/cTxDoDoiHFKS4LFalCA3jzslwrLAnPDYJotktburOuxpIbzU2Nz4ejWIojG
        YfYQG6qV5Nr5Mln0E1HFO3Mbhv2SRzh54hosARBoMD29aUBa8fMZ/5SNk3JF/HWY5/36hMG
        bIxSI/yvWVWkc9w//De82CmXkDoKOfnVx+6UOLdhvV1GJF8KsBXNLAMQF+r9CmrgT7PfoMw
        BavNCMEwba7wUTZjkY3hjm67SuR4eK0jUcFUw3no+Q73XnMwDRSymEEXEsuro2IFJpdS9/V
        LsgMz9gjns9mJ++JTvjX8iEh7C3n9FsJW1CHkLoiM+dgdexcr9uomgpsL0z75pkkARIQxMq
        rR8glep3N/qYRcLn4UoxCefKmbhJGi4pmvYyZVKAtZ++jR4j8A=
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     namhyung@kernel.org, irogers@google.com, john.garry@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] perf metrics: Variable type completion
Date:   Wed, 17 Aug 2022 01:38:04 +0800
Message-Id: <20220816173804.7539-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' is better than 'unsigned'.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ee8fcfa115e5..8926de9617ef 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1620,7 +1620,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 				    struct rblist *new_metric_events,
 				    struct rblist *old_metric_events)
 {
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < rblist__nr_entries(old_metric_events); i++) {
 		struct rb_node *nd;
-- 
2.30.2

