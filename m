Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25FC55316A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350183AbiFULxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348633AbiFULxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:53:47 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A341B7B8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:53:42 -0700 (PDT)
X-QQ-mid: bizesmtp88t1655812397tisisiq8
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 19:53:13 +0800 (CST)
X-QQ-SSF: 0100000000700040B000B00A0000000
X-QQ-FEAT: ZJ5VjJmbjcy+Th0RuyFPliD3TJvaSy+jTaRQGYLDuVO7ubm31ipm1tNZTI+si
        Mvc7I6UfOtjBkUK2CArto8nZXb6qE2A14XUmycxa9Hmf5kBtgCpEK7VrVI5LHTNycr4WH6V
        RFYSkv9AHbSxSLgSJZ3qK6aetTSWt6Ql9hdiNkrL6YyKfdh39CxDNjOEjnYw+1Zrl8TqtEU
        wQlNRf/nfF/LXz3aD7t08jnHzWtxfFlO2tQUBKxF34aq01AjoStCUXQ7rzD7JST5eq70Lrb
        FD8jrb4gDELXWBugrnW6W7GSZRA4uRrQDJDkFZULsmDpL7BjCjHvc3mkq7cLrIHZ/IkUve3
        tEUNpMT1mTlzRgAtes=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jikos@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] apm-emulation: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 19:53:10 +0800
Message-Id: <20220621115310.110740-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/char/apm-emulation.c
line: 547
* Wait for the the suspend_acks_pending variable to drop to
changed to
* Wait for the suspend_acks_pending variable to drop to

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/char/apm-emulation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/apm-emulation.c b/drivers/char/apm-emulation.c
index 230cf852fa9c..e795390b070f 100644
--- a/drivers/char/apm-emulation.c
+++ b/drivers/char/apm-emulation.c
@@ -544,7 +544,7 @@ static int apm_suspend_notifier(struct notifier_block *nb,
 		wake_up_interruptible(&apm_waitqueue);
 
 		/*
-		 * Wait for the the suspend_acks_pending variable to drop to
+		 * Wait for the suspend_acks_pending variable to drop to
 		 * zero, meaning everybody acked the suspend event (or the
 		 * process was killed.)
 		 *
-- 
2.17.1

