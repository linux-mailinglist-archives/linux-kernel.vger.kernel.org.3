Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEA358ECE1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiHJNQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiHJNQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:16:11 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4701B789
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:16:05 -0700 (PDT)
X-QQ-mid: bizesmtp66t1660137360tf54vmum
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 10 Aug 2022 21:15:58 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: LE7C6P2vL8QZH5ItXYgHmvuuc9aXQB6IzMwJ1o6d6XtQDUTIsgCVAGd0sWqqY
        kBi7hCCyXSuzihUSlyYfywBFQVnadK4M6CBKeRyZOr1+sg57sNa65+WUCYRcVQFFZLk2kpH
        MKWDeO7hv6l3U/vegQfSx12Pfq912pXuBM66DmMue6ZEuzdi0VI6snucDQgjqg4mAceLTJn
        6vouAnpK9hte7ZgNg5yQVjqX78vRDKtOKZvbobsG+8U20+72BEzpNttrFrMJYTrKxbX6b91
        Rs3liy3qTGZ7FYpaAez4K/bcp1yuhT0PoArrNWa6w/jGl8MdsovlyudhusrkXLmCWyNTS3K
        IJNjB+dYI2uXplmrcDyfNYeR8MYsEt62EjJgv03
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drivers/mtd: fix repeated words in comments
Date:   Wed, 10 Aug 2022 21:15:39 +0800
Message-Id: <20220810131539.51108-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'it'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/mtd/inftlcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/inftlcore.c b/drivers/mtd/inftlcore.c
index 6b48397c750c..1709f7f6bf6f 100644
--- a/drivers/mtd/inftlcore.c
+++ b/drivers/mtd/inftlcore.c
@@ -356,7 +356,7 @@ static u16 INFTL_foldchain(struct INFTLrecord *inftl, unsigned thisVUC, unsigned
 	 * Newest unit in chain now contains data from _all_ older units.
 	 * So go through and erase each unit in chain, oldest first. (This
 	 * is important, by doing oldest first if we crash/reboot then it
-	 * it is relatively simple to clean up the mess).
+	 * is relatively simple to clean up the mess).
 	 */
 	pr_debug("INFTL: want to erase virtual chain %d\n", thisVUC);
 
-- 
2.36.1

