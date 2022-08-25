Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE14C5A1091
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241775AbiHYMdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241683AbiHYMdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:33:07 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C027F9AF99
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:33:05 -0700 (PDT)
X-QQ-mid: bizesmtp71t1661430779t0wqcr7e
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 Aug 2022 20:32:58 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: znfcQSa1hKa24PmL2rwvet0G8IZcQPAKAk0FJcFhPb2OVd7Rvp3RrUPBFfJ4N
        6kDVt5Jdsqz1pGKclqpFZ4nYgSKckCKNOkVt0C4O/cLcIz0xgiUojsS7xdHeWZhL3ZprZsf
        CFdCzt6mnNbkY+IqibyAZRWXv72nhDTWRHaa3k6JGEwo5PzPiHSSPfFLOqUelt+FSYbLhHP
        Ca4vWrUuvqHHghFBg3+PoKbj3eU1JuDS2D2+d45HC+mKSTM9LRW+k8uxWY6cZSFWdaVLzs9
        n6pMYxJ1PSm4ucgCHwRcucePnwzk8gBNGX6ACZcEkWFL4w9C9URweTbrCsqAxZqhRuPdjfx
        nFM1fgq6U/B07EQ+i/zdOmSPRJjdH4elobusgQBWCkSTeyABw4uzBIO8kDdYNSePzDnHEsy
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     stuyoder@gmail.com, laurentiu.tudor@nxp.com
Cc:     linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] bus/fsl-mc: fix repeated words in comments
Date:   Thu, 25 Aug 2022 20:32:53 +0800
Message-Id: <20220825123253.33013-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'for'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/bus/fsl-mc/fsl-mc-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 0cfe859a4ac4..df3318f1a292 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -96,7 +96,7 @@ static void __fsl_mc_msi_write_msg(struct fsl_mc_device *mc_bus_dev,
 		}
 	} else {
 		/*
-		 * IRQ is for for a child device of mc_bus_dev
+		 * IRQ is for a child device of mc_bus_dev
 		 */
 		error = dprc_set_obj_irq(mc_bus_dev->mc_io,
 					 MC_CMD_FLAG_INTR_DIS | MC_CMD_FLAG_PRI,
-- 
2.36.1

