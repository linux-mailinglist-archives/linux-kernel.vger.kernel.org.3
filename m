Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD82358BBB5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 17:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiHGP4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 11:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiHGP4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 11:56:12 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A274A64F7;
        Sun,  7 Aug 2022 08:56:09 -0700 (PDT)
X-QQ-mid: bizesmtp86t1659887760t21is6qe
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 07 Aug 2022 23:55:50 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: 8eavv92r+Yk86VBS8z+mamh7NMEuMvA6ldeTh4eDuX8TkXKUdq+Xsv0/DRfgz
        jeL1o0TI1Hp7NmkgYxOK9xcKkskwF0KGZypLwvB9bTBuHrbv9VwiH40EzqkYhQgolm1lSmj
        4DiiSU7/1L4U06nweWfhdkx+u662T3AUI3KUqmRYr3bkHj9fju6/Uc0CEDFSwhSTRsiOUUJ
        9K2EDRFWBflULmEh3JlYvbCbK9d1+rdWzTTikS+0tTDP9CZ2p7191pBsXPmgEWlE16oXvmV
        TgT0zPwB7hXX0I3l1xOEZrFPzI7dCt1t9uWHIkDn/bi2VBCLnDPF+SfHFbXU60aQ1FzwBDv
        GR2pLIRB85/Uett3wK8Fu/ys/vjwyt/2eDcvaY+Bo7ExokuRhMKd1mjXzLbOA==
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] perf tools: Fix typo in comments
Date:   Sun,  7 Aug 2022 11:55:49 -0400
Message-Id: <20220807155549.30953-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "to" in comments.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 tools/perf/util/events_stats.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/events_stats.h b/tools/perf/util/events_stats.h
index 1b0006092265..040ab9d0a803 100644
--- a/tools/perf/util/events_stats.h
+++ b/tools/perf/util/events_stats.h
@@ -22,7 +22,7 @@
  *
  * The total_period is needed because by default auto-freq is used, so
  * multiplying nr_events[PERF_EVENT_SAMPLE] by a frequency isn't possible to get
- * the total number of low level events, it is necessary to to sum all struct
+ * the total number of low level events, it is necessary to sum all struct
  * perf_record_sample.period and stash the result in total_period.
  */
 struct events_stats {
-- 
2.35.1

