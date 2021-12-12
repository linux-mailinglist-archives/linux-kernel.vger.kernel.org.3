Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F5D4717F9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 04:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhLLDYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 22:24:49 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:29475 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229635AbhLLDYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 22:24:48 -0500
X-QQ-mid: bizesmtp44t1639279467tpfmb7r9
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 11:24:26 +0800 (CST)
X-QQ-SSF: 01000000002000D0H000B00A0000000
X-QQ-FEAT: F3yR32iATbjGUty7JOvTDi9n9m+mqQYI+e6hSssoDfBJE9Gd1TVesQbCMo/zT
        XaJoDxOp5Ul78RrkWXckhcOORY64vVS4qzStsNL3hzJL3LMVuIJNV1J3pJipQIrybW8xzxE
        7p+ghhl9NUn7a07iDNvzpo5d1cL0fM6v6Q/125FwcN3+X3jB7Yl27zeBaAXKADvcfOByLrJ
        W8HyHVBHvjzDxfeuSst7SyPhRrOd2kKwMcIXUz3XZrNsVRfzQH3YuaPbgh8R2qb63WFJY3M
        /vjwaqXnzof+3K+A5nfEEXeJDN/ET/+HV0h0P1t25lYBlvzf8kDycHW+Bt8hJk2iZ+tgNGn
        OPcKH6XRVfHOp5f/XEO5bZ6t8JEnIPFAV0cQONr
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     jgross@suse.com
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        wangborong@cdjrlc.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xen/pciback: fix typo in a comment
Date:   Sun, 12 Dec 2021 11:24:08 +0800
Message-Id: <20211212032408.52180-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' in the comment in line 163 is repeated. Remove it
from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/xen/xen-pciback/pciback_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/pciback_ops.c b/drivers/xen/xen-pciback/pciback_ops.c
index 3fbc21466a93..e38b43b5065e 100644
--- a/drivers/xen/xen-pciback/pciback_ops.c
+++ b/drivers/xen/xen-pciback/pciback_ops.c
@@ -160,7 +160,7 @@ int xen_pcibk_enable_msi(struct xen_pcibk_device *pdev,
 	}
 
 	/* The value the guest needs is actually the IDT vector, not the
-	 * the local domain's IRQ number. */
+	 * local domain's IRQ number. */
 
 	op->value = dev->irq ? xen_pirq_from_irq(dev->irq) : 0;
 
-- 
2.34.1

