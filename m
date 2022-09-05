Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6D45ACB19
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbiIEGe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbiIEGe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:34:29 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F2303D5B8
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=56QwR
        QkLZn5ZFYd4Q2aRadVIzGx++uGfkoHnHFr0I70=; b=XWNXelXe3Of2F7afarMP9
        fafQ9z07T/7qTwyRqm9yAOKP5dxvPQ9pp1fNC0PT42+vdQJ2hWBhY9dMRtyICSl+
        x7iWofPRq7WkhdsgJf4y2xHL6jd+fDVmzvtq42NWlymDFzEt5UMrwbb2Cy35yVnL
        yUWUTofnjWv+m+9V3B2CJA=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp3 (Coremail) with SMTP id G9xpCgDnL1QJmBVjG_YAbA--.31732S2;
        Mon, 05 Sep 2022 14:32:43 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] mtd: rawnand: fix spelling typo in comment
Date:   Mon,  5 Sep 2022 14:32:32 +0800
Message-Id: <20220905063232.1830197-1-13667453960@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgDnL1QJmBVjG_YAbA--.31732S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5GFWfCrWDCFg_yoWftrb_W3
        W7AryvkrWqyF109rn3Crs3A3y5ta1Ygr1kXrn8Zr43Jw43uw4UX3yDJr1ftw1jkr48tF15
        Wa43t3s3Xw1ktjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1GNtDUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbiyAtz+1p7HmmGDQAAsW
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
index 8bb17c5a66c3..6487dfc64258 100644
--- a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
@@ -14,7 +14,7 @@
 #include <linux/bcma/bcma.h>
 
 /* Broadcom uses 1'000'000 but it seems to be too many. Tests on WNDR4500 has
- * shown ~1000 retries as maxiumum. */
+ * shown ~1000 retries as maximum. */
 #define NFLASH_READY_RETRIES		10000
 
 #define NFLASH_SECTOR_SIZE		512
-- 
2.27.0


No virus found
		Checked by Hillstone Network AntiVirus

