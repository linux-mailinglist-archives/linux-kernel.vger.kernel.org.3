Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2667959E766
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244892AbiHWQeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244724AbiHWQdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:33:31 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C309A9F4;
        Tue, 23 Aug 2022 07:52:31 -0700 (PDT)
X-QQ-mid: bizesmtp63t1661266342t2f59wqq
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:52:20 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: R3vftN8GVq8iVDHEowFNDn44iKc9ithiTLDgcDSRx4e896Gtxp4doItLko+3n
        wffvr2SNTopOWndq8NuUv1jgbGjcy+QSIlGEC5pdKCfBb0XefvDbol9lIZR4UjYo3F8vZlk
        KbjjWIS5CllFdazq4TsojFvirDviUvgCfajYa4FbYcEcC93LltyRdmzMAivJ9kpMKb8CDdU
        FezeVNEX7KWUvoc8K9GoqiZwQJk1SfJFpaNcACzHT7sDcE0e2RTZfYx4n5kxeaD+zVYmHWk
        FG29k5FyXa5i9vNL4pkVRDYji00FmmT9En3PBmn8f9OeSWnFz6KUquSLiOQMa0Jb1pHEl7I
        nKrvEyIOtp693oR11qbebXRj2Z/imLAg4YYG1uTZ77ekuHGL4uCCUlEPCxFHshz+G06lz6A
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     jacopo@jmondi.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] media/i2c: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:52:14 +0800
Message-Id: <20220823145214.43383-1-wangjianli@cdjrlc.com>
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

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/media/i2c/mt9v111.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/mt9v111.c b/drivers/media/i2c/mt9v111.c
index 2dc4a0f24ce8..7beca0b70b72 100644
--- a/drivers/media/i2c/mt9v111.c
+++ b/drivers/media/i2c/mt9v111.c
@@ -633,7 +633,7 @@ static int mt9v111_hw_config(struct mt9v111_dev *mt9v111)
 
 	/*
 	 * Set pixel integration time to the whole frame time.
-	 * This value controls the the shutter delay when running with AE
+	 * This value controls the shutter delay when running with AE
 	 * disabled. If longer than frame time, it affects the output
 	 * frame rate.
 	 */
-- 
2.36.1

