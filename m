Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774415B1E38
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiIHNLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiIHNL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:11:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D8FE620A;
        Thu,  8 Sep 2022 06:10:56 -0700 (PDT)
X-QQ-mid: bizesmtp62t1662642651tzwfgrad
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 21:10:50 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: 83ShfzFP0oBbtYgqnnaZvNPUUGGrjzey0kOBTZrE2Djs8msViU/sAXUkZIBAv
        RMFMks7uAmP4O/msPnt3R2YIJRhIOdlP2lnvecyvAI2ngXPfY4BY9YPKVvRygIO+mUH4KIa
        a2AJgVR5qSS3ElcSRAMqTM+D++Jiyzwj7oAwb1OPxj2X+7EDQWbV72Pe4DkAmAf8lejcm+w
        eQrtafNh4DOgwxCBCVMnm1DajaM00IFFllXNifR0Tg2R9yiZhgKSpXESPJQXEmGDm76y6gU
        VPSwtCzjEZrPEpJju0YQFuSzub1EALET01DpYmWSPPmUfES3mWPX+bcDMgCj3AbVpz/yuM7
        Og4ZPEv8yCVUcbUKp56stWYmsxaVP///E+VkqK/EK5YTkGnFqkgqnbVr9IkaQ==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] input/mouse: fix repeated words in comments
Date:   Thu,  8 Sep 2022 21:10:43 +0800
Message-Id: <20220908131043.37099-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/input/mouse/hgpk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 523b26a117d6..3c8310da0b05 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -884,7 +884,7 @@ static ssize_t hgpk_trigger_recal(struct psmouse *psmouse, void *data,
 
 	/*
 	 * We queue work instead of doing recalibration right here
-	 * to avoid adding locking to to hgpk_force_recalibrate()
+	 * to avoid adding locking to hgpk_force_recalibrate()
 	 * since workqueue provides serialization.
 	 */
 	psmouse_queue_work(psmouse, &priv->recalib_wq, 0);
-- 
2.36.1

