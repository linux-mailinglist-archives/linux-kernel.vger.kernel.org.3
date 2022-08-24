Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB7B59FB02
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbiHXNQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbiHXNQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:16:33 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E74B4AD59;
        Wed, 24 Aug 2022 06:16:31 -0700 (PDT)
X-QQ-mid: bizesmtp81t1661346987tx6hvkun
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:16:26 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: oGOjGSUjcuDZNQgLkW0dLLOtF/z5UCrxHPKXlZNwiYCxmgehcUdT9X02kelcD
        +KKVmfbNmxkhcYTUQtN6AcDaphC89F4Kb+0ASptbO012Hk0IT6EOSRg+Afdi19x/z0N9+GH
        NN6ObcxprvF4BaO7qBcPlzoOAwdiebHz5UojOJIH0eZS04lmQ7CihcRlBc9FtOL70pPyWWF
        F23Pp739oYdt3iA5mOwFqz9lqMcw9pnTEifUEENGa7IFeWZ76l1auEGVX4AGk6frAgrwpRd
        mTQKXa8Ki0ndc3CKNMPEy5cISM7t26vZd8w1/Zlk0FLppLL+76byHEeLb13H4OzcpW4yenf
        mo7t3nnNCRpIToZPlUI/dmvjRd55N7x5oecR3zMGuT44j3/8SmS5soYPeUBNC1WXrmfWJCA
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] i2c/cx25840: fix repeated words in comments
Date:   Wed, 24 Aug 2022 21:16:19 +0800
Message-Id: <20220824131619.54027-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'of'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/i2c/cx25840/cx25840-ir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/cx25840/cx25840-ir.c b/drivers/media/i2c/cx25840/cx25840-ir.c
index 9d7d1d149f1a..8cef9656c612 100644
--- a/drivers/media/i2c/cx25840/cx25840-ir.c
+++ b/drivers/media/i2c/cx25840/cx25840-ir.c
@@ -196,7 +196,7 @@ static u32 clock_divider_to_resolution(u16 divider)
 {
 	/*
 	 * Resolution is the duration of 1 tick of the readable portion of
-	 * of the pulse width counter as read from the FIFO.  The two lsb's are
+	 * the pulse width counter as read from the FIFO.  The two lsb's are
 	 * not readable, hence the << 2.  This function returns ns.
 	 */
 	return DIV_ROUND_CLOSEST((1 << 2)  * ((u32) divider + 1) * 1000,
-- 
2.36.1

