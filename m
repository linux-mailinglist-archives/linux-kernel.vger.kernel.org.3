Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BCB58ED00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiHJNUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbiHJNU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:20:26 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31E3E62
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:20:24 -0700 (PDT)
X-QQ-mid: bizesmtp82t1660137620tvqpxd73
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 10 Aug 2022 21:20:19 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: uGhnJwy6xZK3/a4RZGPHChyYxZyQ91n+aQkD5cRY+ai5ylW5xYcDUzJOD4ag6
        UT+isujEYjcMdxFWz61a6UcvPhdLs3ds0tSLae7msJWbfm1NAk2XQpurmB8hHcsSZneUl07
        elWLQWUOKyeIdLwGt+3bSiLUzb3DfS/nOphfpqdekAapLR3IBRBrSDnO8gmDzZpgP01b5bl
        jik0taODm1e+3rAfeQj0rVkK4L0e/HjqZntXd/y3wGOldU6aPVbukNPuQdrGXhlD57XsObg
        aJ03JRsCH5jnLytcPSr4cFaYdLzgb5gNg7w1hQkmqDATgCjJWIkglhRI6gjybOvd2wiQcJa
        jVKx7hkbjAk3RXmOpA7+eoWuu0QaJQf9+gUwH2z9gXQNtOXLteIJd3dMWQWWw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drivers/mtd: fix repeated words in comments
Date:   Wed, 10 Aug 2022 21:20:09 +0800
Message-Id: <20220810132009.59842-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'in'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/mtd/mtdconcat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index f685a581df48..193428de6a4b 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -836,7 +836,7 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
 
 		/*
 		 * walk the map of the new device once more and fill in
-		 * in erase region info:
+		 * erase region info:
 		 */
 		curr_erasesize = subdev[0]->erasesize;
 		begin = position = 0;
-- 
2.36.1

