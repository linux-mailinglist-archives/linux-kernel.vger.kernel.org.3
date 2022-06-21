Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67C0552CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346521AbiFUIQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347889AbiFUIQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:16:44 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1367424BC3;
        Tue, 21 Jun 2022 01:16:39 -0700 (PDT)
X-QQ-mid: bizesmtp80t1655799388tgzcyz03
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 16:16:18 +0800 (CST)
X-QQ-SSF: 01000000007000109000B00A0000000
X-QQ-FEAT: Z953UCsBqO6atZV269AMCwt/nSVDocI2xqHilqIIqsqy6Ps32uNHKQJen4OdJ
        K6Mz92k0vbO4bgN9j9z+d014PX+G6Kn9mEJxA5PLQcUQ7E8SH6+SW65gesBV8Rlp6pp2qL0
        Oa7z6fuA93hOg/BQBajFUUsS+QbUe4jClZe2qJYYbhbsB9RpOAJc9xPqYjJ/RSU8rDxyzLP
        ScNfaQQiBMITWrip6NtoMY/aUHkEYG3C60lhzsR4vkSL5Oq1cNR5wKaj+4VZYQMlnSjAfni
        SECveFyom3wVF9g89j+hgu4ji7phasBl2TkqoDmzWJVMIIYPKgJYwrZXF4cWhXHGrs+Jtqa
        wguXQVI9N3ymLs0DoM=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] tools: remove unexpected word "the"
Date:   Tue, 21 Jun 2022 16:16:17 +0800
Message-Id: <20220621081617.47300-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is unexpected word "the" in comments need to remove

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ede31a4287a0..ad4c9b79c051 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5398,7 +5398,7 @@ void print_dev_latency(void)
 }
 
 /*
- * Linux-perf manages the the HW instructions-retired counter
+ * Linux-perf manages the HW instructions-retired counter
  * by enabling when requested, and hiding rollover
  */
 void linux_perf_init(void)
-- 
2.17.1

