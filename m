Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2803F59E93C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiHWRXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbiHWRUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:20:37 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2D78B2CC
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:44:45 -0700 (PDT)
X-QQ-mid: bizesmtp74t1661262207t05al4g6
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 21:43:26 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: 5q30pvLz2ic4M38+9R1mgjNrve/V9zAjkT+n8YcF+jgn9KwKuqxu1kmUgW3LG
        qTEEqoSxhHP3sHfUqxoH6Iyo7FmAFwRFI4tZ49R/xVa8ZVoH6j091NvJbmZwkp+QE053FmH
        XXAw9AmQDnjcAB/HfQNSp1Y1gN35as1S8N6Vuz4TcgmDhHU4UpD8KhzIE4i+wCLAdr+3nkg
        vHSNbSW7HsGov0tSUdYKEDki1K3LZQ6PiNeUUhHxYUCG1KQSFbxLHPIdg7UWdv4cIt13Ju1
        fqJRkCKPPebV8UPUcUWZVU8MsEamwEkEbtAndvEVrgvLGKqjnAzSF95ipyHstkRRylcB2lD
        +6zO3sruaz6k2bUn+Jtvxec78+nEpyCeWHW8mSM
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     jgross@suse.com, sstabellini@kernel.org,
        oleksandr_tyshchenko@epam.com
Cc:     linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] xen/xen-pciback: fix repeated words in comments
Date:   Tue, 23 Aug 2022 21:43:18 +0800
Message-Id: <20220823134318.58080-1-wangjianli@cdjrlc.com>
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
 drivers/xen/xen-pciback/pciback_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/pciback_ops.c b/drivers/xen/xen-pciback/pciback_ops.c
index 3fbc21466a93..84e014490950 100644
--- a/drivers/xen/xen-pciback/pciback_ops.c
+++ b/drivers/xen/xen-pciback/pciback_ops.c
@@ -159,7 +159,7 @@ int xen_pcibk_enable_msi(struct xen_pcibk_device *pdev,
 		return XEN_PCI_ERR_op_failed;
 	}
 
-	/* The value the guest needs is actually the IDT vector, not the
+	/* The value the guest needs is actually the IDT vector, not
 	 * the local domain's IRQ number. */
 
 	op->value = dev->irq ? xen_pirq_from_irq(dev->irq) : 0;
-- 
2.36.1

