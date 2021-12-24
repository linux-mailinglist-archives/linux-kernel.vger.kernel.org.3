Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716D247EA9D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 03:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350942AbhLXCma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 21:42:30 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:35940 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350885AbhLXCm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 21:42:29 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0V.aP5OF_1640313744;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V.aP5OF_1640313744)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Dec 2021 10:42:25 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jdike@addtoit.com, viro@zeniv.linux.org.uk
Cc:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] um: Remove duplicated include in syscalls_64.c
Date:   Fri, 24 Dec 2021 10:42:23 +0800
Message-Id: <20211224024223.9356-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following includecheck warning:
./arch/x86/um/syscalls_64.c: registers.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: dbba7f704aa0 ("um: stop polluting the namespace with registers.h contents")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/x86/um/syscalls_64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index fe5323f0c42d..27b29ae6c471 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -12,7 +12,6 @@
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include <registers.h>
 #include <os.h>
-#include <registers.h>
 
 long arch_prctl(struct task_struct *task, int option,
 		unsigned long __user *arg2)
-- 
2.20.1.7.g153144c

