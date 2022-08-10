Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD4058ED36
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiHJN2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbiHJN2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:28:09 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA7633E0B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:27:56 -0700 (PDT)
X-QQ-mid: bizesmtp88t1660138071tm7fbmh1
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 10 Aug 2022 21:27:50 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: YHTLUubWl26igChFXzRkm64UDKpjaoOCHUIjXC277Z+iI0dvZuzPe9dE5tUrX
        N3kqbzrnzvJKRKdJRbeDjz24k0gJZ37cLkU0jZ2PbeAjSRHHu72HT5wGDSpdAEZf5tUFCmh
        bVbPV+3Gu/zZxwSq05ns4+i165ggmIRlSAC+epOGmnShx3Hg67BUOkkJ3jgvVe0ck0Bz7/t
        6AwrhQ+WJwuRajvoINmr4oYOiE/VcyRMSLaz7OeP16mp5aXo3PaBTAFcrmuaU2urAQxgbty
        9Sq02EE7/W4T+LQgl5H55ktOpCBXY7/bb+0P2jCrb9v054jol1YxEmFb36Oz9ZCdQKM9NlW
        OlvZz7HNMSPLsPY4rSyjRCLS8mq+CQ3h+6VqUQQt0n4HjbHniGQbGgxaK6PjA==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] nand/raw: fix repeated words in comments
Date:   Wed, 10 Aug 2022 21:27:33 +0800
Message-Id: <20220810132733.63767-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'and'.
 Delete the redundant word 'is'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/mtd/nand/raw/davinci_nand.c | 2 +-
 drivers/mtd/nand/raw/sm_common.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 3e98e3c255bf..b9377d6c3c89 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -375,7 +375,7 @@ static int nand_davinci_correct_4bit(struct nand_chip *chip, u_char *data,
 
 /* An ECC layout for using 4-bit ECC with small-page flash, storing
  * ten ECC bytes plus the manufacturer's bad block marker byte, and
- * and not overlapping the default BBT markers.
+ * not overlapping the default BBT markers.
  */
 static int hwecc4_ooblayout_small_ecc(struct mtd_info *mtd, int section,
 				      struct mtd_oob_region *oobregion)
diff --git a/drivers/mtd/nand/raw/sm_common.c b/drivers/mtd/nand/raw/sm_common.c
index ba24cb36d0b9..b2b42dd1a2de 100644
--- a/drivers/mtd/nand/raw/sm_common.c
+++ b/drivers/mtd/nand/raw/sm_common.c
@@ -52,7 +52,7 @@ static const struct mtd_ooblayout_ops oob_sm_ops = {
 	.free = oob_sm_ooblayout_free,
 };
 
-/* NOTE: This layout is is not compatabable with SmartMedia, */
+/* NOTE: This layout is not compatabable with SmartMedia, */
 /* because the 256 byte devices have page depenent oob layout */
 /* However it does preserve the bad block markers */
 /* If you use smftl, it will bypass this and work correctly */
-- 
2.36.1

