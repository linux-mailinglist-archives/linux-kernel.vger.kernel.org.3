Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4447347CB28
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 02:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbhLVBza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 20:55:30 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:26210 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231315AbhLVBz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:55:29 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V.Na7RS_1640138116;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V.Na7RS_1640138116)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Dec 2021 09:55:16 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jdmason@kudzu.us
Cc:     dave.jiang@intel.com, allenbh@gmail.com,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH next] NTB/msi: Fix ntbm_msi_request_threaded_irq() kernel-doc comment
Date:   Wed, 22 Dec 2021 09:55:13 +0800
Message-Id: <20211222015513.23106-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description of @msi_desc and change the @devname to @name
in ntbm_msi_request_threaded_irq() kernel-doc comment to remove
some warnings found by running scripts/kernel-doc, which is caused
by using 'make W=1'.
drivers/ntb/msi.c:285: warning: Function parameter or member 'name' not
described in 'ntbm_msi_request_threaded_irq'
drivers/ntb/msi.c:285: warning: Function parameter or member 'msi_desc'
not described in 'ntbm_msi_request_threaded_irq'
drivers/ntb/msi.c:285: warning: Excess function parameter 'devname'
description in 'ntbm_msi_request_threaded_irq'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/ntb/msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 2818bfcf4031..dd683cb58d09 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -262,8 +262,9 @@ static int ntbm_msi_setup_callback(struct ntb_dev *ntb, struct msi_desc *entry,
  * @handler:	Function to be called when the IRQ occurs
  * @thread_fn:  Function to be called in a threaded interrupt context. NULL
  *              for clients which handle everything in @handler
- * @devname:    An ascii name for the claiming device, dev_name(dev) if NULL
+ * @name:    An ascii name for the claiming device, dev_name(dev) if NULL
  * @dev_id:     A cookie passed back to the handler function
+ * @msi_desc:	MSI descriptor data which triggers the interrupt
  *
  * This function assigns an interrupt handler to an unused
  * MSI interrupt and returns the descriptor used to trigger
-- 
2.20.1.7.g153144c

