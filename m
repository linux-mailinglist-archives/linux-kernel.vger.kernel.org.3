Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DD9589B60
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbiHDMCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiHDMB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:01:58 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2807F606B5;
        Thu,  4 Aug 2022 05:01:56 -0700 (PDT)
X-QQ-mid: bizesmtp90t1659614511tg57ozor
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 Aug 2022 20:01:50 +0800 (CST)
X-QQ-SSF: 01000000008000F0U000B00A0000020
X-QQ-FEAT: zT6n3Y95oi3S/F9OUGlPecUpO7yksKBmy+Db8DugP9WQ6Y/JVUiJKpNtK7HE4
        JPWHZ5fbPfUu4hhetLS1LJXLdkH1AKIk4R/wySQO0SpuJUYSfOIanor5rd+pn/v9OFylXND
        2h6lmQjnwz2s23bhABaDmVeyNoJ896EiUWcseJamluFFA7ddmTdGYAoHU5evuoFpnrb854r
        jM1K4KLx5KGZuVc0LZVy6Me3hIEE0usPbWZlJd6ymHUPyJCcmRY5y6mx3azylZlm2xnGfr9
        RzngkSoNTB4fPmDA0EcZGudQopGajsqul9+lP3PNEvboHdINwNYsTnWHdhzt4yBa74kreoz
        rHGgef7gSy7po/yze9PiqyhOVg7rEhOXHZhdObTbEGGOA/krvvIZPxGcgbEHNYWXKiAjCHG
        6bZfhESOQRs=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     sakari.ailus@linux.intel.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] media: v4l2-flash: Fix comment typo
Date:   Thu,  4 Aug 2022 20:01:48 +0800
Message-Id: <20220804120148.56268-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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
2.35.1

