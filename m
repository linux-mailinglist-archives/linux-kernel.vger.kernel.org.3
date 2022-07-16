Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3E8576E46
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiGPNpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGPNpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:45:34 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63AD1C11D;
        Sat, 16 Jul 2022 06:45:28 -0700 (PDT)
X-QQ-mid: bizesmtp71t1657979106twrom2u9
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 21:45:03 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: swyrzWPvyR39Sw/G58I5eOSDVlCXGyn48mF66X41YWZ1o45RJ+4o8Gtm8gwAI
        Tdn8g6r3bvHO3GMkZfTji/Pcu7DUzYxx58wb+mgfNU7563to9bP+ucZoWYfzmbs8tYg5TL7
        yJQ9YSY6vTPMky6VvjdWlM1YKR27s3jn1fs080LAxjO28dP1bYHA1PfAxFC4WzNPJkslRv7
        5dbWR1xuqJZi4O1Qz9EkfuwE/FuslTAv4f3N8jB3tDqywgqbond9Mf3T4thUvPfQJsUiMf1
        l5yaR0KSQ+LLOqz9rwcT00yZcoTFfVHKXxwN5C5WnlvFVfm80oscR1hnzhNwdnrFeNRhZ8V
        /Ba5BcBvPmgiRf2+TlHV5PqwkCf2I83LKUEsVudUsEQEi3FRXyWNJj2dhdVNbosFYCr81Nn
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/musb: fix repeated words in comments
Date:   Sat, 16 Jul 2022 21:44:57 +0800
Message-Id: <20220716134457.46535-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'mode'.
 Delete the redundant word 'than'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/musb/musb_cppi41.c | 2 +-
 drivers/usb/musb/tusb6010.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index 7fbb8a307145..c963cb8565f2 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -286,7 +286,7 @@ static void cppi41_dma_callback(void *private_data,
 	 * receive a FIFO empty interrupt so the only thing we can do is
 	 * to poll for the bit. On HS it usually takes 2us, on FS around
 	 * 110us - 150us depending on the transfer size.
-	 * We spin on HS (no longer than than 25us and setup a timer on
+	 * We spin on HS (no longer than 25us and setup a timer on
 	 * FS to check for the bit and complete the transfer.
 	 */
 	if (is_host_active(musb)) {
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 7ed4cc348d99..5609b4e84d40 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -495,7 +495,7 @@ static void musb_do_idle(struct timer_list *t)
 }
 
 /*
- * Maybe put TUSB6010 into idle mode mode depending on USB link status,
+ * Maybe put TUSB6010 into idle mode depending on USB link status,
  * like "disconnected" or "suspended".  We'll be woken out of it by
  * connect, resume, or disconnect.
  *
-- 
2.36.1

