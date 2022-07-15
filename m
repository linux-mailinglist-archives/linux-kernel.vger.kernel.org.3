Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8315857837B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiGRNRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiGRNRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:17:39 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812B027B19;
        Mon, 18 Jul 2022 06:17:34 -0700 (PDT)
X-QQ-mid: bizesmtp82t1658150250tw87x307
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:17:28 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: 0AHoP94G71VzoKZpzzxxsve7xx364+lfoULIkOFIcMwYZ9nhr7xcyRopGvLNL
        WgDiIFIB/eLWwFSY8+foeJVHkGmXOIuOQE49+f2UBkzWpwGWmykWHqZIsHbwF0qlmKRwmuW
        bQFVKRvSfAD46D5ZOGIuMPu0JE68pT/zz7kEKgQy+LDtSAENxXZ6rN/fY0LnqxOOxqw+ipZ
        y6V9C4R5k7BWjtL8itJE/egyBD3Cbw4OMPsLxD8TVEA+JVksa8un0m6AkTIjZDcWL1UCsC1
        tLPq+RPwFkmF55q3YkRNE8UCHxLUx2ShjSHvjTU93lzhWk5Xt8drsYbcw1Ct1lqdMz8N0xz
        ajUg14iREmxevup9h+EhEX1PAVYmhbt5gHLWOaScQsE+pFF6dB8poqfGyqbP7j5XbhoSfgr
        LyMgeR1ZJkY=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     wangborong@cdjrlc.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: Fix comment typo
Date:   Fri, 15 Jul 2022 13:15:32 +0800
Message-Id: <20220715051532.29742-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in line 1300, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/media/usb/tm6000/tm6000-cards.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/tm6000/tm6000-cards.c b/drivers/media/usb/tm6000/tm6000-cards.c
index 98f4a63adc2a..b7842cd6f9af 100644
--- a/drivers/media/usb/tm6000/tm6000-cards.c
+++ b/drivers/media/usb/tm6000/tm6000-cards.c
@@ -1297,7 +1297,7 @@ static int tm6000_usb_probe(struct usb_interface *interface,
 		le16_to_cpu(dev->udev->descriptor.idProduct),
 		interface->altsetting->desc.bInterfaceNumber);
 
-/* check if the the device has the iso in endpoint at the correct place */
+/* check if the device has the iso in endpoint at the correct place */
 	if (!dev->isoc_in.endp) {
 		printk(KERN_ERR "tm6000: probing error: no IN ISOC endpoint!\n");
 		rc = -ENODEV;
-- 
2.35.1

