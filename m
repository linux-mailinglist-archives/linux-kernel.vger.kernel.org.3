Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C317C552B69
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346509AbiFUHB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346388AbiFUHBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:01:55 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC311EAD8;
        Tue, 21 Jun 2022 00:01:50 -0700 (PDT)
X-QQ-mid: bizesmtp67t1655794842tb8g352o
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 15:00:34 +0800 (CST)
X-QQ-SSF: 01000000007000109000B00A0000000
X-QQ-FEAT: hR9GyqeohShu5QCuxfz/nAdLMul1wuwlaGMI42ANkYK1+WZjRITiEeI6UBiAT
        my+KrgxsuojZIWPi8hR+CG5a9r/I665n+y6wnOBrkAS7DYteilWGHDGHj3ZO2Z47vGn0brt
        2AIwBn4Y+iY7SKtyc3U6okU9q7wJXT9TlX4Fnoerp0lKzJLqSMW4SJctHeT/JKFjXCSupmY
        Un8m+c2RY50IM/mS6OyC1RXFnQIHd6tosXF0mExZO4gk3C+yAv4ANkwL0mGv5JKSlEbw+PC
        Hs3SRlwh4RJTyryJY5yaXFU5sEKhz/1xOB9StStUowOs3c9k5AiZsT+wpYjT599y3V9oYfg
        N41NGH2MIi3GDEO4dw=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     dmitry.torokhov@gmail.com
Cc:     jiangjian@cdjrlc.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: cyapa_gen6 - aligned "*" each line
Date:   Tue, 21 Jun 2022 15:00:32 +0800
Message-Id: <20220621070032.30072-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider * alignment in comments

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/input/mouse/cyapa_gen6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/cyapa_gen6.c b/drivers/input/mouse/cyapa_gen6.c
index 812edfced86e..0caaf3e64215 100644
--- a/drivers/input/mouse/cyapa_gen6.c
+++ b/drivers/input/mouse/cyapa_gen6.c
@@ -57,7 +57,7 @@ struct pip_app_resp_head {
 	 * The value of data_status can be the first byte of data or
 	 * the command status or the unsupported command code depending on the
 	 * requested command code.
-	*/
+	 */
 	u8 data_status;
 } __packed;
 
-- 
2.17.1

