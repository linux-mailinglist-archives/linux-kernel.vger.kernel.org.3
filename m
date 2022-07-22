Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D870557E7B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiGVT5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiGVT5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:57:12 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD2B9C266
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:57:07 -0700 (PDT)
X-QQ-mid: bizesmtp88t1658519818tbf9803n
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Jul 2022 03:56:44 +0800 (CST)
X-QQ-SSF: 0100000000200030C000B00A0000020
X-QQ-FEAT: ZTnzshg2nJZn4GL34ySWIVhtOCg7d+2hs3cf3FwTnVgHWZxoCBxQT3Tx43Q6o
        oKhEAJfHWUBXfqWuD30+/jM6AfJV1FCV+xZmm7WL+0RZlAZGYJ90GWZ6VDBmFZjY5tC8O37
        PONG+lcdVmjZoqvm743DtWRhQR2sI1os6PwccSYwhHSzGveyRDcNZRnsr4knhInLabi7N/A
        BnsYdpHjDCR8sp5ZLt9uCExsJO8nR2krP9REUWYrDGsn92LEE76B38niQVSEL9DFwsqW823
        aegiDu9MUiPzOk707d3SBIiWbw4+hFdZ1ud5s8JqQVdUQnPrugBv7CNlfYyqf/aX/+myVwh
        1iIv9Fj6S+REO8MgWyF32eAmH7r2OpV7fuE12xDL1q+HM8AyvW27wClYoNvlQ==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     hubcap@omnibond.com
Cc:     martin@omnibond.com, devel@lists.orangefs.org,
        linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] orangefs: Fix code typo
Date:   Sat, 23 Jul 2022 03:56:42 +0800
Message-Id: <20220722195642.18917-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `been' is duplicated in line 920, remove one.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 fs/orangefs/orangefs-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 29eaa4544372..01d7e5ad2daf 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -917,7 +917,7 @@ int orangefs_debugfs_new_client_mask(void __user *arg)
 	client_debug_mask.mask1 = mask2_info.mask1_value;
 	client_debug_mask.mask2 = mask2_info.mask2_value;
 
-	pr_info("%s: client debug mask has been been received "
+	pr_info("%s: client debug mask has been received "
 		":%llx: :%llx:\n",
 		__func__,
 		(unsigned long long)client_debug_mask.mask1,
-- 
2.30.2

