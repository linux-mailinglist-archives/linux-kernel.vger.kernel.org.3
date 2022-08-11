Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD0E58FBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbiHKMFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbiHKMFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:05:06 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086B8956A5;
        Thu, 11 Aug 2022 05:05:04 -0700 (PDT)
X-QQ-mid: bizesmtp80t1660219498tncr2goc
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 20:04:57 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: SGbEDZt3ZyZazrvh3yNR+bQlXu0qsiC+vMqnfAp9KATZkDdVTX2QhF3RKgWfR
        I/nbnTFHwK7WZ1x+spHtaXyd7k7m+RwMNV2TeoOw0+25cnugyDRZfj3mSji48PeijRnMRV+
        yiTPpjiYPooy0VzGAwypQKe3Mxmg3tia0mFM6FuJwvhTZQMoIXhseM0FdonTnQt2HH2YvtH
        cFEnThKEAPSxcFnRThWjV0/NYW/Q/0/KqZKdh6Vu1EhftZDvUvkxFNLj4XUNHxbSsSqJonT
        kqpPV1v7B4w3qEkDo3BfPF9qDnpCtIA7vwyqNtTEMLXwK46RvHj2gRifJTEgs6ZZx4CsFNW
        vTxwA60H+KZEynFEsV6kvoa+3LTQ68eA2pg8/RFjdh6gH3h0/hRQwFcu8hApk5UkEnmSfv/
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] cpuidle/coupled: Fix comment typo
Date:   Thu, 11 Aug 2022 20:04:50 +0800
Message-Id: <20220811120450.13886-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
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

The double `are' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/cpuidle/coupled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 74068742cef3..9acde71558d5 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -54,7 +54,7 @@
  * variable is not locked.  It is only written from the cpu that
  * it stores (or by the on/offlining cpu if that cpu is offline),
  * and only read after all the cpus are ready for the coupled idle
- * state are are no longer updating it.
+ * state are no longer updating it.
  *
  * Three atomic counters are used.  alive_count tracks the number
  * of cpus in the coupled set that are currently or soon will be
-- 
2.36.1

