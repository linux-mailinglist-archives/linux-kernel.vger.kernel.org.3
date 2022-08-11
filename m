Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E567558FDF1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbiHKN7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbiHKN7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:59:11 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B218B83BFF
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:59:09 -0700 (PDT)
X-QQ-mid: bizesmtp85t1660226342tbq3avfi
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 21:59:00 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: +ynUkgUhZJns9Hywu1JtC6+YgWtE5HVVtHMMXcmSGm7pZwDUszPEB2dzRu5CQ
        5sRpIT/xi3uOfGsYxAVuml/X7jsmNO+1qbl2oF/jJU1+tXEkIfJwosYyizy28Nm6m23Da7P
        Ew6xW6BoxRlcVdESy1Ll5uGWvcs5DcbhxSi/5qK2amqVe0tNLdT9UqYOEXHY3iAwiEp3a5y
        ITZy8kM6GwAC7wvsHmEDZMeauGaasjU/skHRCqQrVGyeIIGwSy2NqkuZwnQSwVzYd736AAV
        CXwgGVGN+UQx3CfEkJJzxUKphMML2C/FChn3sVhEPYZkUbk2wfAcwLQc493UQLhRSVonN9a
        4wVChmewi+b7KV27UdTxVsZCdu8xHrIw9b6SMqO75HKTgncnf/W4TPNf0w88163aWGhGg9i
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     miquel.raynal@bootlin.com
Cc:     han.xu@nxp.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] mtd: rawnand: gpmi: Fix comment typo
Date:   Thu, 11 Aug 2022 21:58:54 +0800
Message-Id: <20220811135854.27036-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 93da23682d86..01ccbde748f3 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1361,7 +1361,7 @@ static int gpmi_alloc_dma_buffer(struct gpmi_nand_data *this)
 /*
  * Handles block mark swapping.
  * It can be called in swapping the block mark, or swapping it back,
- * because the the operations are the same.
+ * because the operations are the same.
  */
 static void block_mark_swapping(struct gpmi_nand_data *this,
 				void *payload, void *auxiliary)
-- 
2.36.1

