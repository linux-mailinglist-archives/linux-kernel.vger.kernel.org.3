Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D97470863
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244701AbhLJSWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:22:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48138 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242291AbhLJSWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:22:19 -0500
Date:   Fri, 10 Dec 2021 18:18:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639160323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjPg7/Ric87ChwPDOFHF7T483OZWNlq7n/EtGA6oQjM=;
        b=aYLecPQCNKcBy0XOyNPXPYkky7gEnMz9ErtBnkAQvOtaxh9XiY/sxm/lQA29re/3Agf39Z
        7gq8BEMI1bgyETFap4eQo7OAamjGvVETE5+3Lf0XtVrbUOU60ugJ2wYlD6XwzezjuG4+8l
        BmwnbvxX2+yu12O+XqUV1FGNtSFU3x6Mcr4yjW06GIwhkqs4sUZlXwCirKoxNmxNxbvyAf
        XXDr5HU16NmYs7aVfmN8Nt0JSGOcmQMXrcH3l4Wlf+LzeTchfHQQlIl58ZaPSJpwAwm55e
        t9jQilJ3jUVaL0fPahb6N9fRjyzsyOK/G0fi3dbeIe+QYQ5kYhA5UxhMPVVlZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639160323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjPg7/Ric87ChwPDOFHF7T483OZWNlq7n/EtGA6oQjM=;
        b=clrsdksQXtke3ut2dj45br1DVvrQtZwQAs0g/zcNAgr0QTNNQYYI8xqe2G5i3WAKoxFcKR
        EhFePLjUdL5DBTCg==
From:   "tip-bot2 for Shaokun Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/fpu: Remove duplicate
 copy_fpstate_to_sigframe() prototype
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211209015550.51916-1-zhangshaokun@hisilicon.com>
References: <20211209015550.51916-1-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Message-ID: <163916032228.23020.3633327260320989331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     20735d24adfe73c62f9482ae5b4f29cc5e00bbe8
Gitweb:        https://git.kernel.org/tip/20735d24adfe73c62f9482ae5b4f29cc5e00bbe8
Author:        Shaokun Zhang <zhangshaokun@hisilicon.com>
AuthorDate:    Thu, 09 Dec 2021 09:55:50 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 10 Dec 2021 19:13:06 +01:00

x86/fpu: Remove duplicate copy_fpstate_to_sigframe() prototype

The function prototype of copy_fpstate_to_sigframe() is declared twice in

  0ae67cc34f76 ("x86/fpu: Remove internal.h dependency from fpu/signal.h").

Remove one of them.

 [ bp: Massage ]

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211209015550.51916-1-zhangshaokun@hisilicon.com
---
 arch/x86/include/asm/fpu/signal.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 22b0273..e1c9df9 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -41,7 +41,4 @@ extern void fpu__clear_user_states(struct fpu *fpu);
 extern bool fpu__restore_sig(void __user *buf, int ia32_frame);
 
 extern void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask);
-
-extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
-
 #endif /* _ASM_X86_FPU_SIGNAL_H */
