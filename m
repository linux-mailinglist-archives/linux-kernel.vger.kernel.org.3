Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0A046F997
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 04:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbhLJD0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 22:26:23 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:16426 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231207AbhLJD0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 22:26:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V-6vgYq_1639106553;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V-6vgYq_1639106553)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 11:22:36 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        Li Yang <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/2] x86: Fix kernel-doc
Date:   Fri, 10 Dec 2021 11:22:08 +0800
Message-Id: <20211210032208.28240-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20211210032208.28240-1-yang.lee@linux.alibaba.com>
References: <20211210032208.28240-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Yang <yang.lee@linux.alibaba.com>

Fix function name in process.c kernel-doc comment
to remove a warning found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

arch/x86/kernel/process.c:411: warning: expecting prototype for
tss_update_io_bitmap(). Prototype was for native_tss_update_io_bitmap()
instead

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Li Yang <yang.lee@linux.alibaba.com>
---
 arch/x86/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b415f30278d1..290c5bf610f1 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -405,7 +405,7 @@ static void tss_copy_io_bitmap(struct tss_struct *tss, struct io_bitmap *iobm)
 }
 
 /**
- * tss_update_io_bitmap - Update I/O bitmap before exiting to usermode
+ * native_tss_update_io_bitmap - Update I/O bitmap before exiting to usermode
  */
 void native_tss_update_io_bitmap(void)
 {
-- 
2.34.0

