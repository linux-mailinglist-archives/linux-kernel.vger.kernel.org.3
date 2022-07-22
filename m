Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B940557D82B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 03:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiGVBwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 21:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGVBwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 21:52:30 -0400
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D013590DB8;
        Thu, 21 Jul 2022 18:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=o1+DK
        13Fy5uW6btIxsT+i3DKkdpjKlIY8exuTz/+L7s=; b=mxCWzH5P8tI8ZKry5VAtD
        JnF5l+tnknPuc2Cqvstedy/Eb9JzmEZpD5UKhc8EoLVORSC38XLrk89P8GslILiA
        rKOfJ4XUP/lHHGQtV6XY3r35UMROGAKmznizdOAReXTxB6RHyzXb43gJU0Pw88od
        vIIitWl7WMmCbAlnpO+z7M=
Received: from localhost.localdomain (unknown [223.104.68.59])
        by smtp14 (Coremail) with SMTP id EsCowADHF+TNAtpismGWOQ--.8395S2;
        Fri, 22 Jul 2022 09:52:18 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     jacopo@jmondi.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] media: i2c: mt9v111: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 09:52:11 +0800
Message-Id: <20220722015211.63609-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowADHF+TNAtpismGWOQ--.8395S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr1kWF1UJr45Zw1kKrg_yoW3Grg_Cw
        1DXw4xXF1SyFnIy3W7trWrZryrtay8uw1kWas5t3sIqryIyF95uF1kA3y7A3y5ur93JFy3
        Xr1qgr1rJwsxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREeT5UUUUUU==
X-Originating-IP: [223.104.68.59]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGRJGZFyPdmffngAAsq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
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
2.25.1

