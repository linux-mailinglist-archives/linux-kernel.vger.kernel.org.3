Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5290E579E15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbiGSM5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242240AbiGSM46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:56:58 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BD25C974;
        Tue, 19 Jul 2022 05:22:51 -0700 (PDT)
X-QQ-mid: bizesmtp80t1658233353tqq92jcs
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:22:32 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: Chk1D9siCl8QDJHyipscqKQatlYEJiELRfYPGlCWlqCixeuaz0Gd9xdp20OyB
        5oKT803Zxd8Pbnb6z8jzMi+mutlhPCEavkjkpjqwXuApwojb5SMzN+OCRrgs4prSRrEc5hv
        hTtI1DOC35lfBd98GJ2n4Y6cNOZ8w3vqjSyag3nC7jBBqaRo4y3Ktw8w8GzVq3USW5u2peb
        McLB6rm57ycO9UxW8gWATdMdPjS5viybdhSsHXIC620lGSqpQg9talrFth8jNgqVx5qkYm/
        jZKinn4Z6lbGMuOQsDMvGg6yrxoXx4+Yp+NXNAPFWPgthBNM2lm4JrGjtEAwW6G9TBEFwiM
        Qy8dwsfj8olElIWW1ITBioxFt8umhPgSRMFFz12sFtigeTjq1hSyIeILbT1snEerbH5Tlp2
        gWFKBgcpwww=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     alexandre.belloni@bootlin.com
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] rtc: rs5c372: Fix comment typo
Date:   Sat, 16 Jul 2022 12:20:34 +0800
Message-Id: <20220716042034.34989-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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

