Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA26589B55
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbiHDL7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbiHDL7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:59:36 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0EB30579;
        Thu,  4 Aug 2022 04:59:34 -0700 (PDT)
X-QQ-mid: bizesmtp81t1659614366t67r7ki2
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 Aug 2022 19:59:25 +0800 (CST)
X-QQ-SSF: 01000000008000F0U000B00A0000020
X-QQ-FEAT: Xz3VOcA7Mr3laMDebUHydeSJslzKpwtdfFqopWs0h6WOE39I/HQueeYyWvh/T
        hzt60bmqVcFhlnnxHLHvd9yaE8g5ORzN94VFNdzW4iV3uRiJ2S2lu3N6gD/+Am/GORu0Ru6
        Rih8qmixS9CORmOUn/TJBCmaWFd2FZcD3NTzwaAogHvqQqhvkDpPJGK2M0G+M661WifgymL
        xFfkjc+f5zG/A4SqPQGxnl+M4weXeGRLITdCSYF3ATBgcOLTDjBP8u/LC2PyK80oaNBo01O
        d0aG5IAbnh14HR664nwA2M3WDjELVorYCx2cWh2p/gKg1EJ3FJi5zqBeyINI8dQ5G3HYdw7
        uLFEWsrV+o0gFj8Vqlg2qRhCFPMaCc8evb3wi/WHXAdcdT6VR4kjn2sxye5gTZydPK8S/CF
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     jacopo@jmondi.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] media: mt9v111: Fix comment typo
Date:   Thu,  4 Aug 2022 19:59:24 +0800
Message-Id: <20220804115924.54296-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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
2.35.1

