Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8755662FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiGEGPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiGEGPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:15:30 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F596B4A0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:15:29 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 1C2381E80D71;
        Tue,  5 Jul 2022 14:13:25 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2kobxK8LI91U; Tue,  5 Jul 2022 14:13:22 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id DA8BA1E80D19;
        Tue,  5 Jul 2022 14:13:21 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, liqiong@fschina.com,
        renyu@nfschina.com, Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] char: lp: Fix spelling mistake and add spaces
Date:   Tue,  5 Jul 2022 14:15:18 +0800
Message-Id: <20220705061518.13533-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling of doesn' t.
Add spaces around '=' and ','.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/char/lp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 38aad99ebb61..214fb037fa76 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -26,7 +26,7 @@
  * be still BUSY. This is needed at least with Epson Stylus Color. To enable
  * the new TRUST_IRQ mode read the `LP OPTIMIZATION' section below...
  * Fixed the irq on the rising edge of the strobe case.
- * Obsoleted the CAREFUL flag since a printer that doesn' t work with
+ * Obsoleted the CAREFUL flag since a printer that doesn't work with
  * CAREFUL will block a bit after in lp_check_status().
  *				Andrea Arcangeli, 15 Oct 1998
  * Obsoleted and removed all the lowlevel stuff implemented in the last
@@ -418,7 +418,7 @@ static ssize_t lp_read(struct file *file, char __user *buf,
 		       size_t count, loff_t *ppos)
 {
 	DEFINE_WAIT(wait);
-	unsigned int minor=iminor(file_inode(file));
+	unsigned int minor = iminor(file_inode(file));
 	struct parport *port = lp_table[minor].dev->port;
 	ssize_t retval = 0;
 	char *kbuf = lp_table[minor].lp_buffer;
@@ -965,7 +965,7 @@ static void lp_attach(struct parport *port)
 		    port->probe_info[0].class != PARPORT_CLASS_PRINTER)
 			return;
 		if (lp_count == LP_NO) {
-			printk(KERN_INFO "lp: ignoring parallel port (max. %d)\n",LP_NO);
+			printk(KERN_INFO "lp: ignoring parallel port (max. %d)\n", LP_NO);
 			return;
 		}
 		for (i = 0; i < LP_NO; i++)
-- 
2.34.1

