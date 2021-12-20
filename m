Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8559D47AAD2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhLTOA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbhLTOAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:00:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A2EC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:00:53 -0800 (PST)
Date:   Mon, 20 Dec 2021 14:00:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640008850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ShK16/9d9KWP/IE/0KYgdJLuWepRWxKW6nOcNXVA9CM=;
        b=p58ddCUfefUDp/ywWezqK8awYp9ZzEesq3+jOnju4XKlFeYaeCT/s1cKHgWsKsbWR3m4eb
        RyetGZox6ezM0zfG9jOiOz6oYtt/Q5F33phEYuP7wCFiZqwgNTp5ogQsUbUvN37N5J4afC
        Xs0O0TBWohig87ny17KCIvuqs2ycC26VPi0+Mofd1FfMFmzDQX7QVV7KQIK4eGrdM+1v5a
        2De0N0Jtf9gSh5AqzuNWPJ//3yekQhsUkCsTEuZm3gAJ6s6NiP/D7GFpHmG/EMM6bZ6XGE
        1NMgxuCWlV9ghzhuwvEmRXLm/6IeD1Guh6/08HLLqjM+7Qf8Qg8D9vnZEQ3bcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640008850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ShK16/9d9KWP/IE/0KYgdJLuWepRWxKW6nOcNXVA9CM=;
        b=rd8nd/dy8Uc2ZxluRfEcFOf64cA9UN+ObPGz1u7b4DUGxQzHZN8LlEzxl+jcvI+n6IXiEm
        Ks3quoraGEzCvYBg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] KVM: arm64: Add minimal handling for the
 ARMv8.7 PMU
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211126115533.217903-1-maz@kernel.org>
References: <20211126115533.217903-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164000884963.23020.18240369465894812989.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     00e228b31596c6bf5f08b5ef76f80cb26e620f02
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/00e228b31596c6bf5f08b5ef76f80cb26e620f02
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 26 Nov 2021 11:36:43 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 01 Dec 2021 13:11:22 

KVM: arm64: Add minimal handling for the ARMv8.7 PMU

When running a KVM guest hosted on an ARMv8.7 machine, the host
kernel complains that it doesn't know about the architected number
of events.

Fix it by adding the PMUver code corresponding to PMUv3 for ARMv8.7.

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211126115533.217903-1-maz@kernel.org
---
 arch/arm64/include/asm/sysreg.h | 1 +
 arch/arm64/kvm/pmu-emul.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 16b3f1a..615dd62 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -937,6 +937,7 @@
 #define ID_AA64DFR0_PMUVER_8_1		0x4
 #define ID_AA64DFR0_PMUVER_8_4		0x5
 #define ID_AA64DFR0_PMUVER_8_5		0x6
+#define ID_AA64DFR0_PMUVER_8_7		0x7
 #define ID_AA64DFR0_PMUVER_IMP_DEF	0xf
 
 #define ID_AA64DFR0_PMSVER_8_2		0x1
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index a5e4bbf..ca92cc5 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -28,6 +28,7 @@ static u32 kvm_pmu_event_mask(struct kvm *kvm)
 	case ID_AA64DFR0_PMUVER_8_1:
 	case ID_AA64DFR0_PMUVER_8_4:
 	case ID_AA64DFR0_PMUVER_8_5:
+	case ID_AA64DFR0_PMUVER_8_7:
 		return GENMASK(15, 0);
 	default:		/* Shouldn't be here, just for sanity */
 		WARN_ONCE(1, "Unknown PMU version %d\n", kvm->arch.pmuver);
