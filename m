Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A5F4EE9E1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244530AbiDAIn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiDAIn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:43:58 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1477A255AB8;
        Fri,  1 Apr 2022 01:42:08 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 1 Apr 2022
 16:42:01 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 1 Apr
 2022 16:42:00 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Helge Deller <deller@gmx.de>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Hvideo: fbdev: pm2fb: Fix a kernel-doc formatting issue
Date:   Fri, 1 Apr 2022 16:41:57 +0800
Message-ID: <1648802518-10571-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-124.meizu.com (172.16.1.124) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function had kernel-doc that not used a hash to separate
the function name from the one line description.

The warning was found by running scripts/kernel-doc, which is
caused by using 'make W=1'.

drivers/video/fbdev/pm2fb.c:1507: warning: This comment starts with '/**', 
but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Device initialisation
drivers/video/fbdev/pm2fb.c:1714: warning: This comment starts with '/**', 
but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Device removal.


Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/video/fbdev/pm2fb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index c68725eebee3..d3be2c64f1c0 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -1504,9 +1504,7 @@ static const struct fb_ops pm2fb_ops = {
 
 
 /**
- * Device initialisation
- *
- * Initialise and allocate resource for PCI device.
+ * pm2fb_probe - Initialise and allocate resource for PCI device.
  *
  * @pdev:	PCI device.
  * @id:		PCI device ID.
@@ -1711,9 +1709,7 @@ static int pm2fb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 }
 
 /**
- * Device removal.
- *
- * Release all device resources.
+ * pm2fb_remove - Release all device resources.
  *
  * @pdev:	PCI device to clean up.
  */
-- 
2.7.4

