Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF529596155
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbiHPRmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiHPRl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:41:59 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE7121801;
        Tue, 16 Aug 2022 10:41:56 -0700 (PDT)
X-QQ-mid: bizesmtp88t1660671681t74hx3op
Received: from harry-jrlc.. ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 17 Aug 2022 01:41:10 +0800 (CST)
X-QQ-SSF: 0100000000200060D000B00A0000020
X-QQ-FEAT: xqT8U4SkSphTDDkaSJLIDDA0iAQssCISAKJJgZfRA+41rXHjtp7pGpTT5XDCA
        Oy4Ru9qCP6Zxy3KLFLLS9UC9X34WUPH3XKUX5tiQRKmZq+ebGodM453X6Lseqy90l4iRQO6
        yqq4m/u9Z5kRe0VIeztMVCOGnGrUN9sSTn27a8HaO5PSVsgaPog3oDEd9YAYSSvUDQ2dI9R
        2inrCrImq8zdgkkVcLb1d2+N8ZubCtcXqkPukmCx0BrXNxPZ47Aa2ZddjiJJLVbdjsY5EMw
        drU6V524n/edUtubIgEBJduZ7grHyxyH104O2Fw1JRK8LhQ1ij1apjvTeuhRvKFOKdG8JZ0
        gIrXY3mBYqZ1vHyezdl5oQOlWAUUDwJx6Tka/J6DAIdtT4iFzAFf9HXcRDzeg==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     namhyung@kernel.org, irogers@google.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] perf parse-events: Variable type completion
Date:   Wed, 17 Aug 2022 01:41:09 +0800
Message-Id: <20220816174109.7718-1-gaoxin@cdjrlc.com>
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
 tools/perf/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f516d3821d28..bc1230f68341 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1225,7 +1225,7 @@ static char *pmu_formats_string(struct list_head *formats)
 	struct perf_pmu_format *format;
 	char *str = NULL;
 	struct strbuf buf = STRBUF_INIT;
-	unsigned i = 0;
+	unsigned int i = 0;
 
 	if (!formats)
 		return NULL;
-- 
2.30.2

