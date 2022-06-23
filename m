Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCD65573F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiFWH3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiFWH3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:29:30 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45B04664A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:29:25 -0700 (PDT)
X-QQ-mid: bizesmtp62t1655969359tf9qc6cl
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 15:29:11 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: F3yR32iATbhu3pcGn39LV3mpGHIZkAD842sH0YqrO4SIcMGrMZt43slG6a29b
        lylRIzFUqtuYNtkbksQZLGjiQskjvKLMUMDPL2Qq3APiPlHjmsE/p37GaWonecPY4ckrmKf
        Uoo+XT8fFpncPwRQAXeBe5e9T5kNV2qv9FZxLLnaMTD97a4F8jOLy+Cw2b9TcdvKauNq2wN
        7ug+5YVf6YFpHaTjqJUjBOkexMAKxe6hO+vpLHvBWsvv8sGQSSG5IEGUbETdhFiElfAGgnu
        dGZhdhtJ1nzIvLimMsEedQxxCHJLB2xMtY3pB/PFZASr/ye9fzzHUMt9rbhuQ/oscQWwAxg
        FGJoe58jxyH5jAuufJffiG7o/4Qrw==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH v1] mtd: ubi: drop unexpected word 'a' in comments
Date:   Thu, 23 Jun 2022 15:29:09 +0800
Message-Id: <20220623072909.16518-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'a' in the comments that need to be dropped

file - drivers/mtd/ubi/wl.c
line - 379

* This function returns a a wear leveling entry in case of success and

changed to:

* This function returns a wear leveling entry in case of success and

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/mtd/ubi/wl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 55bae06cf408..f1fa78c1391b 100644
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
-- 
2.17.1

