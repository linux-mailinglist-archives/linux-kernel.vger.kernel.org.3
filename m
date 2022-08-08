Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC4358CB3B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbiHHPY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243208AbiHHPY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:24:26 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B8213FBD;
        Mon,  8 Aug 2022 08:24:24 -0700 (PDT)
X-QQ-mid: bizesmtp70t1659972241t2ri8ov1
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 Aug 2022 23:23:55 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: RrZlkntZBfmuOfo8quMEwD3080NOsCahJQvomSWrjR200jqYM2uJS5tZj+9Fg
        KGKjOOrRCW5yYFFchp6E4ft3Kf8SkjRNOUgBHG1jCaoAXcqKzzLxtxZGSNqjQIYVZvNKlvi
        T9j8p99fynkmc3k1+Dom+vsyg1h8wLbnizYhZ6QuAyc2v/z6A7ozAlYPNwM48lxPgRGby7+
        C8Dseij3302y5oY8UW8Qwck3y8NArut/ZrOZtFHsNmFGJ1yrbaEbvfMMYLaWFCD1Al/y7lV
        SVkayiXQ9GSiiZrv/cCgXMVHhEn3WwulWCWTvh7mp20DOJdzhdB9chA5SFpuXm43zF2InJO
        IGli3zczRyh2Z9HhzLR1EpHBqWNSoH3zmoiPohXLjVUfYhF+ok66t+i+DS+AiX5vIQwuFqk
        LOBmYiVoP/E=
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] rtc: rs5c372: Fix typo in comments
Date:   Mon,  8 Aug 2022 11:23:54 -0400
Message-Id: <20220808152354.3641-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "the" in comments.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/rtc/rtc-rs5c372.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index cb15983383f5..8d551e15b91a 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -150,7 +150,7 @@ static int rs5c_get_regs(struct rs5c372 *rs5c)
 	 * least 80219 chips; this works around that bug.
 	 *
 	 * The third method on the other hand doesn't work for the SMBus-only
-	 * configurations, so we use the the first method there, stripping off
+	 * configurations, so we use the first method there, stripping off
 	 * the extra register in the process.
 	 */
 	if (rs5c->smbus) {
-- 
2.35.1

