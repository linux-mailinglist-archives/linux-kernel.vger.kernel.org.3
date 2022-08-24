Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BF459FB3C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238244AbiHXNZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbiHXNZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:25:20 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765E43057C;
        Wed, 24 Aug 2022 06:25:11 -0700 (PDT)
X-QQ-mid: bizesmtp87t1661347507t2fij6qf
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:25:06 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: CR3LFp2JE4li9KkNUsZL46Wo60Goymdu6HOaosXe/O2Y0350jSNsVPDpLdTZ9
        CxKHhqriI8QLAOXIQQH/GZdj81Q0wh+/NpEleaJg7pAntsA4PiYM4QKMfbhLXh8G/UPRVGO
        w+BvVSKKhG4mig5otfmQ05uIKz1G2gYz+nraIEKuMuV5r2jL69acfMdBmNMVnAKUEHG/S9d
        rKQYRJdbuqHLdYtJP2bTJUyV59/prI8OUjbchhJJWfpVfyVglRiwZvvHz4isW6Dq+7weqYh
        cpQfHC7BYKZbso6wk96DwEsgBiEU+iEKEHuIE0MlLa75vSAElM5fkJswOeD4G245Nr+xsjv
        lXSliAv85CUesztLs6YaRYnaphO2SlqIPUsvzTjO82z6o63bl1S4J/O0MpH+98s+X5TPcjb
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] pci/saa7164: fix repeated words in comments
Date:   Wed, 24 Aug 2022 21:25:00 +0800
Message-Id: <20220824132500.59911-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
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
2.36.1

