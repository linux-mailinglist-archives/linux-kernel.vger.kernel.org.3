Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422EC532515
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiEXIQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiEXIQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:16:11 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A8D1140
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:16:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VEHCnEO_1653380161;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VEHCnEO_1653380161)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 May 2022 16:16:08 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     gregkh@linuxfoundation.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, hridya@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] Android: binder: Fix kernel-doc
Date:   Tue, 24 May 2022 16:16:00 +0800
Message-Id: <20220524081600.39941-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following W=1 kernel warnings:

drivers/android/binder.c:362: warning: expecting prototype for
binder_node_unlock(). Prototype was for binder_node_inner_unlock()
instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 9e0982289dde..8ec8f43bf6c7 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -354,7 +354,7 @@ _binder_node_inner_lock(struct binder_node *node, int line)
 }
 
 /**
- * binder_node_unlock() - Release node and inner locks
+ * binder_node_inner_unlock() - Release node and inner locks
  * @node:         struct binder_node to acquire
  *
  * Release lock acquired via binder_node_lock()
-- 
2.20.1.7.g153144c

