Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1040257D86E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiGVCTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiGVCTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:19:32 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFAD413CDB;
        Thu, 21 Jul 2022 19:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/0XkG
        Fs+FCFX0sqA6J0AfVmSz9Si3P6MzDBYURSGPow=; b=jlOH1H/SqnYS+AroUQ+xH
        YKjMWVKLXrnaQTWLqbRgx4GMUyh6tiPDkVKRigl3ag0QGzqWSMEKrg6l9Lcq3/oZ
        mjylRONb7tZ7VhBbCTkVViLMybSz3LOWPe2kqaPGvdFW2ACOOIsjKPaTO1p91ayi
        uRKqGsLIFwp5JZF0h7TroM=
Received: from localhost.localdomain (unknown [223.104.63.34])
        by smtp10 (Coremail) with SMTP id DsCowAD3ISQpCdpi5mSGOg--.603S2;
        Fri, 22 Jul 2022 10:19:24 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] media: saa7164: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 10:19:18 +0800
Message-Id: <20220722021918.64636-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAD3ISQpCdpi5mSGOg--.603S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr1ftw4UJF18Cr4DJwb_yoW3Krg_Wr
        1DZ3yxZ343Jr1ayF4Yv3WfZry8K3y8uFWrA3Z3tryrt348ur1UXryYywn8Xw1UJFW3u3sr
        WrZxWa1xZw1rKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREbAFPUUUUU==
X-Originating-IP: [223.104.63.34]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGRBGZFyPdmgJAgABss
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/media/pci/saa7164/saa7164-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/saa7164/saa7164-core.c b/drivers/media/pci/saa7164/saa7164-core.c
index 7973ae42873a..d5f32e3ff544 100644
--- a/drivers/media/pci/saa7164/saa7164-core.c
+++ b/drivers/media/pci/saa7164/saa7164-core.c
@@ -626,7 +626,7 @@ static irqreturn_t saa7164_irq(int irq, void *dev_id)
 	portf = &dev->ports[SAA7164_PORT_VBI2];
 
 	/* Check that the hardware is accessible. If the status bytes are
-	 * 0xFF then the device is not accessible, the the IRQ belongs
+	 * 0xFF then the device is not accessible, the IRQ belongs
 	 * to another driver.
 	 * 4 x u32 interrupt registers.
 	 */
-- 
2.25.1

