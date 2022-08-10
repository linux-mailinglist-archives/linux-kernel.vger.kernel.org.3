Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C9B58ED7A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiHJNjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiHJNjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:39:12 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448396583F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:39:09 -0700 (PDT)
X-QQ-mid: bizesmtp80t1660138745tdu021vk
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 10 Aug 2022 21:39:03 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: svq08P3H43XysrHG5O8YQOL7NCARp11jQQ/d0i2y4vJ5mUitLQ3G+dXMq8vQx
        6w7MJ02hNuwQ+uOnWgAOYXeafIaquK1wb70U1x2r2ZHx/iCI1SiQadd8EzfxBP8KpXNPguy
        uOSjDCjcTxCnv1C1cZM+i4iLBtk7mURdtH3w41Xl19jmDxGZH4ZWXCuJuozfhUF5bDbFAjL
        D8VJrbT7e7AkvQ+8xc3i+PUU3gA6ClNj2TVfcTyFKa9C3fjcKAHauxrD63CJ7q+2vxNEdAw
        AicoWz6QuqmlaC+l51Roo+bGPsxvI39aox5qB4Xu7uUzxW1/Vijrw41ACnO15+5J8ZnRX1D
        GY5FiMXb2j7ecz0qBQ4lOkaQHW9FgVDezsQioXKsR8Q6Tk+P+SYQTTnFmvyTUzB+9GTLdMx
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] mtd/ubi: fix repeated words in comments
Date:   Wed, 10 Aug 2022 21:38:56 +0800
Message-Id: <20220810133856.4546-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
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

 Delete the redundant word 'a'.
 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/mtd/ubi/wl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 55bae06cf408..0fadd55beee0 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -376,7 +376,7 @@ static struct ubi_wl_entry *find_mean_wl_entry(struct ubi_device *ubi,
  * refill_wl_user_pool().
  * @ubi: UBI device description object
  *
- * This function returns a a wear leveling entry in case of success and
+ * This function returns a wear leveling entry in case of success and
  * NULL in case of failure.
  */
 static struct ubi_wl_entry *wl_get_wle(struct ubi_device *ubi)
@@ -429,7 +429,7 @@ static int prot_queue_del(struct ubi_device *ubi, int pnum)
 /**
  * sync_erase - synchronously erase a physical eraseblock.
  * @ubi: UBI device description object
- * @e: the the physical eraseblock to erase
+ * @e: the physical eraseblock to erase
  * @torture: if the physical eraseblock has to be tortured
  *
  * This function returns zero in case of success and a negative error code in
@@ -1016,7 +1016,7 @@ static int ensure_wear_leveling(struct ubi_device *ubi, int nested)
 
 	/*
 	 * If the ubi->scrub tree is not empty, scrubbing is needed, and the
-	 * the WL worker has to be scheduled anyway.
+	 * WL worker has to be scheduled anyway.
 	 */
 	if (!ubi->scrub.rb_node) {
 #ifdef CONFIG_MTD_UBI_FASTMAP
-- 
2.36.1

