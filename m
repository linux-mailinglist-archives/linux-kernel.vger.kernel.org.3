Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB90583EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbiG1Mcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiG1Mcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:32:41 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CC0402F7;
        Thu, 28 Jul 2022 05:32:36 -0700 (PDT)
X-QQ-mid: bizesmtp82t1659011550t9m7phva
Received: from localhost.localdomain ( [171.223.98.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 28 Jul 2022 20:32:29 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: cHEuLz3LyUiN53M7ojyHa3bsJ+TbgZG9r8Gm+iPf2zZo5RLoM/uRWyjwU5UFq
        JnAU4A1vm+HLTK/Kf7GEA00TX4eIN5NOTWxaIZMffzaXiApSWD7gKSpMohymXayfouNjJwA
        sgA9lruQkn13SeK4beMDXJw8xseNjN3P9FRQ5vOvzsCT3vSWY2lYhE2I5KjiQxuynvBCam3
        B/lVv1dymhlaNiPxLt4gW57xsqCe6hCjl0InZOLn0KHRjWWNP1blKIqpg0fqZUqb0LSaCzo
        CNlO2GsLd7ipW/bwhHhYWul3a0aIhaBKvTu/PVGbOoY61lSDuIdSvLhDAbQO/DE25cjzl3L
        ggwzytbB48+M9SACgb2JKmMxuwT1Fwi43wG40BOUITkkWaMJaE5vablkykyclp0E5y+0vxb
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] Input: sx8654 - Fix comment typo
Date:   Mon, 25 Jul 2022 12:30:34 +0800
Message-Id: <20220725043034.5565-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `mode' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/input/touchscreen/sx8654.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index de85e57b2486..984d79bfea80 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -292,7 +292,7 @@ static void sx8654_close(struct input_dev *dev)
 	if (!sx8654->data->has_irq_penrelease)
 		del_timer_sync(&sx8654->timer);
 
-	/* enable manual mode mode */
+	/* enable manual mode */
 	error = i2c_smbus_write_byte(client, sx8654->data->cmd_manual);
 	if (error) {
 		dev_err(&client->dev, "writing command CMD_MANUAL failed");
-- 
2.35.1

