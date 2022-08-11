Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D6158FBED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiHKMJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiHKMJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:09:36 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664F4956B9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:09:34 -0700 (PDT)
X-QQ-mid: bizesmtp79t1660219767t4u30kic
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 20:09:25 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: TLc+rbMvNaH5OYpc2vpXRliUymwUm3enbmSFWCPJHLn06RxUVTo7PYfDoGSrc
        Bf1mjnddn5ysypy0lYDebVTCHb1ta+hJ42+ICX9bVZkki8fWJAPuB77P0BTPLB6E6/zKNOs
        1ygH0WkIG8GlHvaeknhZKc7QKboCryiP1Ijqxfjxi2VKh1aacbmp2VNYZhTxtnsC2jFNozo
        /f/iNMCOjFoFJnQJJcdFQ69fMJDgzc3frUXx5g/Hi8ESPD6iZWAW9Z764mt3GIh5wV3aKXV
        t0X9VnkZG8PaBahVKeJIMmJKfm0k18jOxCmOb7sPvA+Jo11o++jJxROa92NSXNR9ssAtSSK
        0UMEzj44QlR5zkEOMzW3bxqlWCoKbTfEjEwsPitTU+NyQK6Ep3/AuDqG35gmtMEDvKYZVG2
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     oleksandr_tyshchenko@epam.com
Cc:     jgross@suse.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] xen/pciback: Fix comment typo
Date:   Thu, 11 Aug 2022 20:09:18 +0800
Message-Id: <20220811120918.17961-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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

