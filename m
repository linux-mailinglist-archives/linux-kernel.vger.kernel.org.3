Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3579E59FB74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbiHXNez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbiHXNex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:34:53 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ED562D0;
        Wed, 24 Aug 2022 06:34:50 -0700 (PDT)
X-QQ-mid: bizesmtp68t1661348085t9zorb9j
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:34:44 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: 3M0okmaRx3jTc4V2x+XjrCr6fA5e0YP6JnDtOca3veDQwrnfMQYyveIwzyCli
        Ed1eXLljA+84g8XW/Dn+W0wbdpqHTMfWVOxiI2blUoPhcxTo6tfOHYywJNFPYCtbtlG93e4
        lNlRSFETu5H/X9ZE1Gl2zLFHiq21eI2DCGY/0oQO8SrZTzq34FxmJFofiB5thf4rKpCcQVf
        eXLW9UreWwkrbxRBJeDrlXgQloIlhU5ToEH6xXNXpGYrbQWSjR8lNvbqsK5q3CIdhhOYKHy
        NdXdDhXzQMSaUY445jg3y5AEIxaqgBNYIDds8zUaV+iUgJBiy2wGQferMMbNhbq6BK5K8ox
        6p3rgEjthO/VkMZW/crHyCf8QQJrOEcwmlANRTYwjKEpeAnszzAQcGvoHY2BoIJpTanGv6G
        WClNrfMTHZ8=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] media/v4l2-core: fix repeated words in comments
Date:   Wed, 24 Aug 2022 21:34:38 +0800
Message-Id: <20220824133438.1829-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/v4l2-core/v4l2-flash-led-class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-flash-led-class.c b/drivers/media/v4l2-core/v4l2-flash-led-class.c
index e70e128ccc9c..355595a0fefa 100644
--- a/drivers/media/v4l2-core/v4l2-flash-led-class.c
+++ b/drivers/media/v4l2-core/v4l2-flash-led-class.c
@@ -94,7 +94,7 @@ static int v4l2_flash_set_led_brightness(struct v4l2_flash *v4l2_flash,
 	 * brightness <-> intensity conversion, it also must have defined
 	 * related v4l2 control step == 1. In such a case a backward conversion
 	 * from led brightness to v4l2 intensity is required to find out the
-	 * the aligned intensity value.
+	 * aligned intensity value.
 	 */
 	if (has_flash_op(v4l2_flash, led_brightness_to_intensity))
 		ctrl->val = call_flash_op(v4l2_flash,
-- 
2.36.1

