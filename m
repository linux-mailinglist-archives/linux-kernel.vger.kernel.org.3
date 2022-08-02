Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFDE587C2E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiHBMSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiHBMSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:18:15 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577D140BFC;
        Tue,  2 Aug 2022 05:18:10 -0700 (PDT)
X-QQ-mid: bizesmtp76t1659442679t8yn2sjl
Received: from kali.lan ( [125.69.43.47])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 20:17:58 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: XBN7tc9DADI6Ojkp2zarVxqaO1A5I6gQqaQ5zzxYKVTmUGCuljx9aINUNxuez
        8/K5ajgyHjB3KpPKPJ3BqU7nHGWfaNZtqzMh7LyQZzrLiBAT4KrdwrA07slrXT5zzetlk5x
        uMGbAbhJtvuO3sZjB6ZTgUcnOWIlzVNCiWSCIKL3qmdxreNEIteF2DU8TvwUKBvZ+NHguu9
        I7y7+rShwQZA6IrmrsbjjxG5LZxA1NPftibfl0qcDIpyVorwWHkPQ/BA8z5ui8Cd481ruYf
        cTImVegfdPZJVi8T2OlH+yw6tVYYiw0GsetYw3bJfTza4PwxgsRzLKnkYeVVDwyqtBch9bP
        zBeO0z4q1iOuyqn6nZ2lzVBwatPdkasE/dVhfwAiSMVhVoZqRz/2oW7QAsLUrSHg4WDXiHW
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     tony@atomide.com
Cc:     lee@kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] mfd: twl-core: Fix comment typo
Date:   Wed,  3 Aug 2022 04:17:57 +0800
Message-Id: <20220802201757.8142-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RDNS_NONE,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `to' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/mfd/twl-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 2cb9326f3e61..ca6eca53a79e 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -883,7 +883,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	 * SR_I2C_SCL_CTRL_PU(bit 4)=0 and SR_I2C_SDA_CTRL_PU(bit 6)=0.
 	 *
 	 * Also, always enable SmartReflex bit as that's needed for omaps to
-	 * to do anything over I2C4 for voltage scaling even if SmartReflex
+	 * do anything over I2C4 for voltage scaling even if SmartReflex
 	 * is disabled. Without the SmartReflex bit omap sys_clkreq idle
 	 * signal will never trigger for retention idle.
 	 */
-- 
2.35.1


