Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ADE53DF53
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351962AbiFFB3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348931AbiFFB3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:29:46 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D6BDF5E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 18:29:38 -0700 (PDT)
X-QQ-mid: bizesmtp62t1654478970tyhjp24p
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 06 Jun 2022 09:29:23 +0800 (CST)
X-QQ-SSF: 01000000000000C0G000000A0000000
X-QQ-FEAT: 50GcHO11QPGP7X2zxDByGO3USZgo5jXmMxDDXrT1iV2TWjNCxWZbExBKTbLZZ
        x0CkzNXR7SnmxN/esPnuVszq5KgvMLalFEt9Bfnx4BY+7Jpewvf7j6B2yrOVdMjYYJVZyjl
        VkDZszzYHB1dMfZH2hB4YSeE36gl9qiRdGRjOdvcLcx4MlXaY0nEaQeNMLk+1FLhmexwYv0
        pq7ewfwJjJpCFP2zQbP4fQH5Kly/nMs3bjLOeb2zs50aj7rsRToLebtOa1142GOv9ENJDXA
        QsULKEabKLl7kbFB2CCGpx1u8WEQwWQ6oM+YP7iHzOSTqwY4XACdX4gI4=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     peterz@infradead.org
Cc:     will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] seqlock: Fix syntax errors in comments
Date:   Mon,  6 Jun 2022 09:29:21 +0800
Message-Id: <20220606012921.22246-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 3926e9027947..4e2ae90554cd 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -863,7 +863,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 }
 
 /*
- * For all seqlock_t write side functions, use the the internal
+ * For all seqlock_t write side functions, use the internal
  * do_write_seqcount_begin() instead of generic write_seqcount_begin().
  * This way, no redundant lockdep_assert_held() checks are added.
  */
-- 
2.36.1

