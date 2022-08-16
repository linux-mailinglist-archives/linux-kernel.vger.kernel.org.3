Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A529D595CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbiHPNIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiHPNIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:08:15 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBD1AF4BD;
        Tue, 16 Aug 2022 06:07:39 -0700 (PDT)
X-QQ-mid: bizesmtp71t1660655241t7fl0map
Received: from localhost.localdomain ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 16 Aug 2022 21:07:20 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: l4gSQpGTOtI0BKbfVAZxeeRY2o4rsA1a0pvReYuYto+AzVQKRo71QCbcqjKpx
        I/PcN2w109n/+rRkOZxFZq7em4kCCiJ5gnzwspaNRYubmGh3zLV79/IEI2m0f3ulCpGTsmU
        GnHsOgeem3jkwLsy51wqyhBXzADEv/sbOhFes8uZXwJKRl8wso7wH4hUwbI015g2lwEf6Ip
        HAApvn45wEUOGgIOH95BHmFCcaNKVnraxQUBlEo0S2gfBfxAxUmDrnzkM6+BAHzJRMYhzuY
        H3r3YQPLGyz+aeH9bwTg6DnbXAgls3a7Eg6qqKYHcGcmfP7j45GwfwspQaCpcYSF43ri6X8
        R6jjvuStlv9OBlYdF03PNxr4WBz+pNeYAnqlKs9P51oQxYnkLfYb11YtSQdpA==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] video/fbdev: fix repeated words in comments
Date:   Tue, 16 Aug 2022 21:07:13 +0800
Message-Id: <20220816130713.28597-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'set'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/video/fbdev/ssd1307fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 5c765655d000..52e4ed9da78c 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -450,7 +450,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	if (ret < 0)
 		return ret;
 
-	/* Set Set Area Color Mode ON/OFF & Low Power Display Mode */
+	/* Set Area Color Mode ON/OFF & Low Power Display Mode */
 	if (par->area_color_enable || par->low_power) {
 		u32 mode;
 
-- 
2.36.1

