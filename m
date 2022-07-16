Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B3D579F81
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbiGSNU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243859AbiGSNTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:19:46 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E01CC90BF;
        Tue, 19 Jul 2022 05:36:35 -0700 (PDT)
X-QQ-mid: bizesmtp75t1658234186trre1prl
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:36:25 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000C00A0000020
X-QQ-FEAT: Hom130/y8pnBi2MWREI/wm9kFTumZRyQK0pfDLmVHi0b+m5uLzoiPy7aigSYK
        GQGr5Z2pMP54Sqr84mdR5ex9LybuVvj7EAlR9Hc8bKuHN7sbwYps0KjlLhI0aCO/02PxdHV
        NOHnZRB6wWEZEPZuTY1h437Q4fvEGSRSeqBBlb+SJH/a42enKhaEdA28qOqWFXZ1OdiAp50
        gZ8AmAujfl6u8qd7f39fO0eO6n+ajwHkYrQ+muX2u7cmaVlw8anElOZUQ/fT2y8TgKebpyu
        NC1kdHOnK7hNwsLlQhFrSFXzucOpDFfba3m0xYw8JX2mruG8vLNCiXY6JNNcKJDK3a8XZFG
        FrG7dREyjziUPmpxGe/2tbREv5zpJZ4q9AsDn632ybBP0F31PKUzrZYiingf14InL7A6Q/g
        k3HTUPbR/WA=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] media: omap3isp: Fix comment typo
Date:   Sat, 16 Jul 2022 12:34:17 +0800
Message-Id: <20220716043417.41455-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/media/platform/ti/omap3isp/isp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/omap3isp/isp.c b/drivers/media/platform/ti/omap3isp/isp.c
index d251736eb420..a6052df9bb19 100644
--- a/drivers/media/platform/ti/omap3isp/isp.c
+++ b/drivers/media/platform/ti/omap3isp/isp.c
@@ -1528,7 +1528,7 @@ void omap3isp_print_status(struct isp_device *isp)
  * To solve this problem power management support is split into prepare/complete
  * and suspend/resume operations. The pipelines are stopped in prepare() and the
  * ISP clocks get disabled in suspend(). Similarly, the clocks are re-enabled in
- * resume(), and the the pipelines are restarted in complete().
+ * resume(), and the pipelines are restarted in complete().
  *
  * TODO: PM dependencies between the ISP and sensors are not modelled explicitly
  * yet.
-- 
2.35.1

