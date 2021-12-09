Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C06446E085
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhLIB6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:58:38 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16347 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhLIB6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:58:36 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J8cXZ5PP7z9196;
        Thu,  9 Dec 2021 09:54:22 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 09:55:01 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH] x86/fpu: Clean up the repeated declaration
Date:   Thu, 9 Dec 2021 09:55:50 +0800
Message-ID: <20211209015550.51916-1-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function 'copy_fpstate_to_sigframe' is declared twice by
commit <0ae67cc34f76> ("x86/fpu: Remove internal.h dependency from fpu/signal.h").

Clean up the last one and remove the blank line.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@suse.de>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 arch/x86/include/asm/fpu/signal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 22b0273a8bf1..2ec9df1d6daf 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -42,6 +42,4 @@ extern bool fpu__restore_sig(void __user *buf, int ia32_frame);
 
 extern void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask);
 
-extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
-
 #endif /* _ASM_X86_FPU_SIGNAL_H */
-- 
2.33.0

