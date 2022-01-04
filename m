Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AC3483B28
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 04:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiADDpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 22:45:10 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:53032 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiADDpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 22:45:09 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4JSdmP04Jsz9xKhp
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 03:45:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LYHBoYwBHgo2 for <linux-kernel@vger.kernel.org>;
        Mon,  3 Jan 2022 21:45:08 -0600 (CST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4JSdmN52F3z9xKhl
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 21:45:08 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4JSdmN52F3z9xKhl
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4JSdmN52F3z9xKhl
Received: by mail-pf1-f199.google.com with SMTP id f24-20020aa782d8000000b004bc00caa4c0so10072865pfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 19:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8AydL0k0VcbSY7fqf9Bm778YsY1Fu3lcHUWs8jK5zSU=;
        b=C4m9j6KzGHSy8qKUUiGcEC8/QFqHYqJuZOgVfEJsAk1nahi1BltSdI1YGpLwNwHjoA
         w5GcmfNNj+yJ9WoaRaGcJl76/Pg2/bmT/7IKvWCHwDGO6/2ZcPN5a1P4bIv/RVIbRkL4
         XE8yyYltQtN0p/xFW/EBvfivnWrj16a+ZqEK2JN/5iYx738ZdRq7fqjEBMe1ZsYuqdkY
         pCSrSYGN8SDxBbQGWquhXvVVH+NCUFskHq+m6O7O7E8PDXW/N1merA8l9pA7hswF5Ovl
         Sfkp/P8Nopf4FB41ZqBXq0BjLkhGQlgo8eJqmaOf0gKOV9gnJEM/+RdswyrZ2Z2/i57Z
         Dt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8AydL0k0VcbSY7fqf9Bm778YsY1Fu3lcHUWs8jK5zSU=;
        b=Hb/PQpgax1qJ29sEffsoppil/Ob+27bxCmxWIS5dgSacjQSsqjEzYeJWFqlee2e0Ii
         C1VpYPs5wdZh8zfv0zMOmdMuq4h6QhgsDQ8EXuq3imBxLUhYjPPHa3ImxOMAvpybIPKT
         01BWIDAPJXRcqo3KsRDCwpyEXfTrslCs+m9JYuuYIgb5NvfH8liS1fq4UOKKz+L5zlqj
         ZpbLQun0rjDe71v5QIeSOi4aWhg2OQwhnyaoz8A11aJ2cQu/tw+Cw8+JZkTR1aDBmpyG
         JNIK/3MXf7oiQZo4LkCjgg5h5kl710oVDOqMDOzXMkvrmkz97u4TO8Z+ycrYRTsm8kyB
         uHPg==
X-Gm-Message-State: AOAM530TTrnDqoHtJ0LxcjKqGJbJzZfGRBJUx6BOlfZeQdJeH2AqICYU
        mflun2jUel2scX8t6dLbZQPf4oQDb8KJ0jffKOb0NgerC0Ad5Bsa56es5P8yjolyrs4GvTK+8tG
        pYlqaj4jYxkfELmim6r0a5vqiKSa6
X-Received: by 2002:a63:545:: with SMTP id 66mr42621491pgf.473.1641267907360;
        Mon, 03 Jan 2022 19:45:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKFjY+b88xd2hYdX+FJaIJCcLOqOu8peF9z2JZ1MMhN6Nb8HGmI4Dd7VGdse1mjrJQSEhPWw==
X-Received: by 2002:a63:545:: with SMTP id 66mr42621472pgf.473.1641267907133;
        Mon, 03 Jan 2022 19:45:07 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.62.162])
        by smtp.gmail.com with ESMTPSA id y29sm26162655pfa.54.2022.01.03.19.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 19:45:06 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Fei Li <fei1.li@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] virt: acrn: fix a memory leak bug in acrn_dev_ioctl()
Date:   Tue,  4 Jan 2022 11:45:01 +0800
Message-Id: <20220104034501.45715-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104024729.GA26952@louislifei-OptiPlex-7050>
References: <20220104024729.GA26952@louislifei-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In acrn_dev_ioctl(), vm_param is not released or passed out on the 
error path of "if ((vm_param->reserved0 | vm_param->reserved1) != 0)", 
which could lead to a memory leak.

Fix this bug by adding a kfree of vm_param on the error path.

This bug was found by a static analyzer.

Builds with CONFIG_ACRN_GUEST=y, CONFIG_ACRN_HSM=y show no new warnings, 
and our static analyzer no longer warns about this code.

Fixes: 9c5137aedd11 (“9c5137aedd11 virt: acrn: Introduce VM management interfaces”)
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent
security operations (e.g., checks or kfrees) between two code paths
and confirms that the inconsistent operations are not recovered in 
the current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Changes in v2:
  -  Fix the same bug in ACRN_IOCTL_SET_VCPU_REGS.

 drivers/virt/acrn/hsm.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 5419794fccf1..7a8f722f431c 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -136,9 +136,11 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 		if (IS_ERR(vm_param))
 			return PTR_ERR(vm_param);
 
-		if ((vm_param->reserved0 | vm_param->reserved1) != 0)
-			return -EINVAL;
-
+		if ((vm_param->reserved0 | vm_param->reserved1) != 0) {
+			ret = -EINVAL;
+			kfree(vm_param);
+			break;
+		}
 		vm = acrn_vm_create(vm, vm_param);
 		if (!vm) {
 			ret = -EINVAL;
@@ -182,21 +184,29 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 			return PTR_ERR(cpu_regs);
 
 		for (i = 0; i < ARRAY_SIZE(cpu_regs->reserved); i++)
-			if (cpu_regs->reserved[i])
+			if (cpu_regs->reserved[i]) {
+				kfree(cpu_regs);
 				return -EINVAL;
+			}
 
 		for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.reserved_32); i++)
-			if (cpu_regs->vcpu_regs.reserved_32[i])
+			if (cpu_regs->vcpu_regs.reserved_32[i]) {
+				kfree(cpu_regs);
 				return -EINVAL;
+			}
 
 		for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.reserved_64); i++)
-			if (cpu_regs->vcpu_regs.reserved_64[i])
+			if (cpu_regs->vcpu_regs.reserved_64[i]) {
+				kfree(cpu_regs);
 				return -EINVAL;
+			}
 
 		for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.gdt.reserved); i++)
 			if (cpu_regs->vcpu_regs.gdt.reserved[i] |
-			    cpu_regs->vcpu_regs.idt.reserved[i])
+			    cpu_regs->vcpu_regs.idt.reserved[i]) {
+				kfree(cpu_regs);
 				return -EINVAL;
+			}
 
 		ret = hcall_set_vcpu_regs(vm->vmid, virt_to_phys(cpu_regs));
 		if (ret < 0)
-- 
2.25.1

