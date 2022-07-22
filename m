Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468E357DA6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiGVGlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVGlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:41:19 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BC7B8239C;
        Thu, 21 Jul 2022 23:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pjlpM
        8dBHy5NE83zTB8LjaeuaNsWgsLf7e7AH9wZrWY=; b=QZja4GOpqGSsC/QyvUCz6
        royHoeX8BKig58Dx0YfIlwyU1dNFM5Bn0oOWuJ4RkUoQryzCxVnA6tX2Tn5zfQKd
        VyRQZCoVq+BHPnV5svn1qqCNpGvPTKOOChRnpM97f90Yx+ImehZBzoUdDCzh695C
        YKRbDJPupyegMHK3R7l/ZE=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp3 (Coremail) with SMTP id G9xpCgDXt0uCRtpicCR6Qg--.4947S2;
        Fri, 22 Jul 2022 14:41:07 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] media: tm6000: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 14:41:05 +0800
Message-Id: <20220722064105.70610-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgDXt0uCRtpicCR6Qg--.4947S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr1DWFWrAF18tw47Arb_yoWfZrX_CF
        ykuw4xuw1UJrn0yr1fGrnIvryYya1kZFZ7AFsxt3yfGrWq9FyDXrWDWayxJFn3CrW2qFyD
        A34FqF1rWw1SgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRuYLyJUUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiRwNGZFc7Yw9XuwAAsK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
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
2.25.1

