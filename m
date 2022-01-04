Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3734483E80
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiADIxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:53:30 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:42584 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiADIx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:53:29 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4JSmc855s2z9vCBY
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 08:53:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TIsESvYCWO9s for <linux-kernel@vger.kernel.org>;
        Tue,  4 Jan 2022 02:53:28 -0600 (CST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4JSmc8326Qz9vCBB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 02:53:27 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4JSmc8326Qz9vCBB
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4JSmc8326Qz9vCBB
Received: by mail-pg1-f200.google.com with SMTP id d13-20020a63f24d000000b003424f1d4733so2821896pgk.21
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 00:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cbd2+Z9DNfCBjAoqlz587VvL8bEBH1giBgmy9UH37BA=;
        b=IMxuV33WAnOPzQ33KvWbUDLAGs35EEfyiQ34ef804d7M/Vyw++ZxMBWnSz52dITPNp
         j+AnRFPRovsp/mT682gyJXvvzIWT1sPdkLLgig4A23sRLOMos1An9nZCNIEwJRJP2q4w
         WzHMkzDxzoaOjaOFyXu9V2+1k0DUoz0qyLaIj/ZubYnL5AGUo/Mg/kTGCFbGuS7hgriW
         Js0PWx1WnxX/dEht/MoUsSIBYRqW5z3UnHCFnzHpacjNOGFDAUwWV/PFYQ58Zvm9muLY
         O8iHiC7lFbflEhZn/lNqI0nNaoKFJ5duYC6pF9NVtrmtFqh1AiYNCG3ePe4LLe+Dn5UW
         VwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cbd2+Z9DNfCBjAoqlz587VvL8bEBH1giBgmy9UH37BA=;
        b=wVpOxEfBzSSN25nadHpsbFWVMm28dv9XEomK7Brr3zZ25gYV6YzflYIe0QsbhXa5pQ
         g4fPXu+hoRiP6WjoABEsGYHns5/NgUNJ6QFFwYUNxoIevO00sBoAC3LF3MrmgI79ETaO
         bo9KRjSkQIBJnOq9uvyzVDeg9jEFl3Kw/K3SIbykokx8NAWtE/kNcutJg4/GgEVv7mPG
         bgOw1BhpBDin2KxPITqBhbrwGWb3NReNRzVffhcq6rdpLKA1WciW+sgK2D9UUC7THPvf
         40v4bmikMNFJExiAnD+vh7j8hy61+4rL506u7czQZ+mztY3k6nf1F+anV7aaPm5McGlm
         Guzw==
X-Gm-Message-State: AOAM532KkKfCrzEvw4NUGf70HzI7LEgIP+9Z/u03xCtvOWEmniA62Dtu
        6BkYupxufxUJWRE4ll4+UpeWHfMCJJ12v/w4h3xrg7YZHFx+MImXeQDqFbI38g/K7jKHfmujqIL
        MUm0MHnxpgN3SdQyCtjseUZHR9PFj
X-Received: by 2002:a17:902:744b:b0:149:6294:d973 with SMTP id e11-20020a170902744b00b001496294d973mr43619626plt.62.1641286406425;
        Tue, 04 Jan 2022 00:53:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGOWG0TmpY+ppzEQfDFLHl8v5O2F2jsd1rynMzd5lCdim8+xW5Kbf+PqA5bukyHlU9+jbOsQ==
X-Received: by 2002:a17:902:744b:b0:149:6294:d973 with SMTP id e11-20020a170902744b00b001496294d973mr43619617plt.62.1641286406219;
        Tue, 04 Jan 2022 00:53:26 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.41])
        by smtp.gmail.com with ESMTPSA id q19sm41877259pfk.83.2022.01.04.00.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 00:53:25 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Fei Li <fei1.li@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virt: acrn: fix memory leak in acrn_dev_ioctl()
Date:   Tue,  4 Jan 2022 16:53:21 +0800
Message-Id: <20220104085321.94485-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In acrn_dev_ioctl(), cpu_regs is not released or passed out on several 
error paths which could lead to memory leak bug.

Fix this bug by adding kfree of cpu_regs on error paths.

This bug was found by a static analyzer.

Builds with CONFIG_ACRN_GUEST=y, CONFIG_ACRN_HSM=y show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 2ad2aaee1bc9 ("virt: acrn: Introduce an ioctl to set vCPU registers state")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent
security operations (e.g., checks or kfrees) between two code paths
and confirms that the inconsistent operations are not recovered in
the current function or the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/virt/acrn/hsm.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 5419794fccf1..1eb0a17aadde 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -182,21 +182,29 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 			return PTR_ERR(cpu_regs);
 
 		for (i = 0; i < ARRAY_SIZE(cpu_regs->reserved); i++)
-			if (cpu_regs->reserved[i])
-				return -EINVAL;
+			if (cpu_regs->reserved[i]) {
+				kfree(cpu_regs);
+				return -EINVAL;
+			}
 
 		for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.reserved_32); i++)
-			if (cpu_regs->vcpu_regs.reserved_32[i])
-				return -EINVAL;
+			if (cpu_regs->vcpu_regs.reserved_32[i]) {
+				kfree(cpu_regs);
+				return -EINVAL;
+			}
 
 		for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.reserved_64); i++)
-			if (cpu_regs->vcpu_regs.reserved_64[i])
-				return -EINVAL;
+			if (cpu_regs->vcpu_regs.reserved_64[i]) {
+				kfree(cpu_regs);
+				return -EINVAL;
+			}
 
 		for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.gdt.reserved); i++)
 			if (cpu_regs->vcpu_regs.gdt.reserved[i] |
-			    cpu_regs->vcpu_regs.idt.reserved[i])
-				return -EINVAL;
+			    cpu_regs->vcpu_regs.idt.reserved[i]) {
+				kfree(cpu_regs);
+				return -EINVAL;
+			}
 
 		ret = hcall_set_vcpu_regs(vm->vmid, virt_to_phys(cpu_regs));
 		if (ret < 0)
-- 
2.25.1

