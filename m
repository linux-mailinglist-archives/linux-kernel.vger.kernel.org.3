Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62115576E41
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiGPNiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGPNis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:38:48 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFDE213;
        Sat, 16 Jul 2022 06:38:42 -0700 (PDT)
X-QQ-mid: bizesmtp76t1657978717ts20f4ix
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 21:38:32 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: zK0nlCs2Z6HAdltJbsCKbdC2wcaj4eyRd7aC4uBhsez2cY7937vDU9f66xjVT
        P1rFgHJ6gZK2WI4hPT1fgKhZomaDTKD4i7ps8pBUyHyN7hWOsrnuHXY/6LiiP06AMKbWsgC
        ZqogqEAu9D6NE42wGrdcfD3rxGXIfif6nZKWXAMIY3FyN+k1uBkERePG1Z0q9ayOm7hOjP5
        gK5EAMo1jtZesL9D01nStpdHAx6bQpZLB4mrltVVwJbQVOVQlHtkutyDpm8YkhbV/XW16dx
        /AFAiJ2W9HdyOdTLk+R2FqPT5k9QpeSEVGjjNXXxVyRDeqnNr5xjtj6OIRipzKsGDjHZcha
        MQBDTjrvbUdVkXHX0p1sFlqxUe9hRudsKtKSBhgZHhPcD5K2DMZd8wY62Z2Rg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/image: fix repeated words in comments
Date:   Sat, 16 Jul 2022 21:38:25 +0800
Message-Id: <20220716133825.43161-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/image/mdc800.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/image/mdc800.c b/drivers/usb/image/mdc800.c
index fc0e22cc6fda..67f098579fb4 100644
--- a/drivers/usb/image/mdc800.c
+++ b/drivers/usb/image/mdc800.c
@@ -38,7 +38,7 @@
  *
  * version 0.7.3
  * bugfix : The mdc800->state field gets set to READY after the
- * the disconnect function sets it to NOT_CONNECTED. This makes the
+ * disconnect function sets it to NOT_CONNECTED. This makes the
  * driver running like the camera is connected and causes some
  * hang ups.
  *
-- 
2.36.1

