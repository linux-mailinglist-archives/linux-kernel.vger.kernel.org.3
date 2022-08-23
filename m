Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD759E735
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbiHWQ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242455AbiHWQ2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:28:20 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A5F11BB2B;
        Tue, 23 Aug 2022 05:55:46 -0700 (PDT)
X-QQ-mid: bizesmtp71t1661259272tqvnoyqj
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 20:54:26 +0800 (CST)
X-QQ-SSF: 01000000002000B0B000B00A0000000
X-QQ-FEAT: +ynUkgUhZJk6LdAbhrlAVbiXtAb5Z4jbwsMiEEw+N+DQMZvqgZuwknZEMCPuH
        NxyG7T/oa5QGHsMzz49okPMky1AvA63dzPQPhsf4BJW7DT2kSlM6Z2o6ygMV/PpCOW7Pqf4
        D3CFb8XnDfLxYfjoR7dTM8T5E678nSlaQWlNG9KGN1w9x/luKIqesV+yHP+S+9hDmnNRMNP
        oD4hVB4Dg1q6RhYqEI8TXaW8v/TkwS1RxHE9VmWR8zZndW0UpjuBmn9tlyzBPjy3LysX6V5
        RqhRMQTEckHFdnJjw5EU7w1l7MUwCyWn1wkRcCvae+pt975buy4ZPH5OofpMbIdDl8mEqo6
        2rVtN9+fIHaFR6Bz/VJzHTjPQNSR007OWA4A7+kCrW7TO41dgqB8F4+GMvRHTjxmEH9mRda
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] cpuidle: coupled: Fix double word in comments
Date:   Tue, 23 Aug 2022 08:54:25 -0400
Message-Id: <20220823125425.621-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word "are" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
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
2.35.1

