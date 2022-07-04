Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE740564B84
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 04:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiGDCOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 22:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGDCOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:14:03 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 460D55F7D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 19:14:02 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id CF54A1E80C95;
        Mon,  4 Jul 2022 10:12:08 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bTWRuc3kLf8M; Mon,  4 Jul 2022 10:12:06 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 9C0051E80C90;
        Mon,  4 Jul 2022 10:12:05 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfachina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] ubi: fastmap: Fix typo in comments
Date:   Mon,  4 Jul 2022 10:13:56 +0800
Message-Id: <20220704021356.14849-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a typo(dont't) in comments.
Fix it.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/mtd/ubi/wl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 55bae06cf408..ab413a674783 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1464,7 +1464,7 @@ static bool scrub_possible(struct ubi_device *ubi, struct ubi_wl_entry *e)
  * ubi_bitflip_check - Check an eraseblock for bitflips and scrub it if needed.
  * @ubi: UBI device description object
  * @pnum: the physical eraseblock to schedule
- * @force: dont't read the block, assume bitflips happened and take action.
+ * @force: don't read the block, assume bitflips happened and take action.
  *
  * This function reads the given eraseblock and checks if bitflips occured.
  * In case of bitflips, the eraseblock is scheduled for scrubbing.
-- 
2.34.1

