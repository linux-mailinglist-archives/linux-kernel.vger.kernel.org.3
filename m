Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F1353DADA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 10:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244812AbiFEIg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 04:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbiFEIg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 04:36:57 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817704D9CE;
        Sun,  5 Jun 2022 01:36:48 -0700 (PDT)
X-QQ-mid: bizesmtp70t1654418130tsg0818y
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 05 Jun 2022 16:35:16 +0800 (CST)
X-QQ-SSF: 01000000002000C0G000B00A0000000
X-QQ-FEAT: aP2oNmVYkM/8WXL6lyMugqaCVwDQOQUAEuXm7NSQSnD6OQvESoOveCBRKTTY/
        dLpZalDOtAnRhwp/mpem/XA4v/ygtKfwaAb8XJGF5wLHAEy79LL84X7LMBT7t8grVUbbpaL
        RQ8rDXbFHVx8QjXPPDEE1YEfYYL20s9vOBjzsi0Y/VI8pSaXcqk/uel2MhAlD95FpPEMX+P
        dfMEbuaJb0Z9hOLgFgWDJhWV+Lcby1/ak2VvyeTxF/q8uTdjtmJOG/sbkOmlL7SuwpNLQKx
        F59PPrMQBKaSZpFFFkBSSHMdUVrMHPTmSg7t/vuAlRzl8ICpwGHSKKKY8=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     a.zummo@towertech.it
Cc:     alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] rtc: at91rm9200: Fix syntax errors in comments
Date:   Sun,  5 Jun 2022 16:35:15 +0800
Message-Id: <20220605083515.9514-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'is'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/rtc/rtc-at91rm9200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index fe396d27ebb7..e9d17232d0a8 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -130,7 +130,7 @@ static void at91_rtc_write_idr(u32 mask)
 	 *
 	 * Note that there is still a possibility that the mask is updated
 	 * before interrupts have actually been disabled in hardware. The only
-	 * way to be certain would be to poll the IMR-register, which is is
+	 * way to be certain would be to poll the IMR-register, which is
 	 * the very register we are trying to emulate. The register read back
 	 * is a reasonable heuristic.
 	 */
-- 
2.36.1

