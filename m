Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0448470813
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245119AbhLJSJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:09:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48082 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241434AbhLJSJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:09:21 -0500
Date:   Fri, 10 Dec 2021 18:05:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639159544;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sg/PwEBB7o01QIlNTu70uQyBftqrBM7hSYpRwiBySno=;
        b=szObEXP2Ba/faAusFPhXjQihheXXQF8+59VIV+Wx5jJeb6lIkAowjg0UtOxjMCzPpCx/Rh
        QfUTHDQdqancudWjjZq3M215pPhVZwsVTQH542wcvBEVzbVrVQnKfbkRM+oULGbQ+QKIPr
        81xdVqBrfpRQG12yMJuFlOvE2o5+O5hUKbXx8ODPCK2S0sy4NLvVKXYQsNhgmxJ9z7gDXY
        uVFLSAo8zUKiXhPnEV8KeyNqp8J/4HqPfWVm4EpnCbYCT/IESJ6z1hNPIp8vEGBbYWlr8B
        Op8FU76QsgCH5nKgs1d8nOs5GcrrvL+dtPUTyy56g62Cpwu/Vp7JNOM8goVNGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639159544;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sg/PwEBB7o01QIlNTu70uQyBftqrBM7hSYpRwiBySno=;
        b=0o0HGxTmIrvTKLP2Y5JI9s4U6kmMS5HIYc51LsbnT3/NLL0F419u6gXRq3+bawlTyHcRFJ
        +ezbPZhmjl1ajZAg==
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
Message-ID: <163915954325.23020.14804385797521679140.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     34c4aa156f810db51e9e97792ced52401d66655a
Gitweb:        https://git.kernel.org/tip/34c4aa156f810db51e9e97792ced52401d66655a
Author:        Shaokun Zhang <zhangshaokun@hisilicon.com>
AuthorDate:    Thu, 09 Dec 2021 09:55:50 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 10 Dec 2021 18:42:56 +01:00

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
