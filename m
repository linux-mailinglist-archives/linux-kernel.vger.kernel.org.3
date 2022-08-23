Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3635159E8D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243237AbiHWRPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245252AbiHWROo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:14:44 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2174A86700;
        Tue, 23 Aug 2022 06:53:20 -0700 (PDT)
X-QQ-mid: bizesmtp82t1661262751t32ml53c
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 21:52:30 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: 0b1/4t+gNkJ++Dgm7zJ6fFrNWFd/Ikx8Yab7Y1JNUbFJSbYJam5vPtKgWzzRZ
        mNZTawlexVcvW4Ax5SzGgbdQUGCFbapYTIudj2AsXszVfao58H9b/Vv/JCA9qPVnHQRZtz4
        yuIvGFtjvnrO4WGHbdW9s4rr28lX06DKAh5w5oZYMWn28kNSqR0F5eRW04Gx+RyLYv2WKez
        6brbXH0KqzqCPWsK2Fts56XIPaX2otuQLO9ioyi0CDGgaHPCOgQ25MbM9u63z0uBWmpzmqp
        icY8SdWiqeKZhmCKI8b+P35cxz9pkyDJ7PmkDy/br4JuyyEq+cOb94W0Igw7sWV9ChmO5nd
        ynCtBHkNth/QiZQQfb+xeEfxEs2pc18K7CKHUUTpKeRtPM+FVcJmIzK6EduPA==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/crypto: fix repeated words in comments
Date:   Tue, 23 Aug 2022 21:52:23 +0800
Message-Id: <20220823135223.62869-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/crypto/n2_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index 3b0bf6fea491..31e24df18877 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -1494,7 +1494,7 @@ static void n2_unregister_algs(void)
  *
  * So we have to back-translate, going through the 'intr' and 'ino'
  * property tables of the n2cp MDESC node, matching it with the OF
- * 'interrupts' property entries, in order to to figure out which
+ * 'interrupts' property entries, in order to figure out which
  * devino goes to which already-translated IRQ.
  */
 static int find_devino_index(struct platform_device *dev, struct spu_mdesc_info *ip,
-- 
2.36.1

