Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E302F589A4E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 12:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiHDKM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 06:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiHDKMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 06:12:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F191532DAA;
        Thu,  4 Aug 2022 03:12:51 -0700 (PDT)
Date:   Thu, 04 Aug 2022 10:12:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659607970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLSZPZSjoAeTGrgSN5RmR7EL5cAJ9diYkxxZcNWNL4s=;
        b=O5+10C1hO6tN8OpUQDe3V/QvDkB32GSgqx/TNSjBWdHtKDAdi7ri6Fz0OgoZyIZZlqwk04
        EDyWgDpFUawpCZuyAMyQtMDWO3PQYQDXF9/v54Jjw3Sf4IBNf8kfVnuEFuGebXTaA4G5Kc
        aKBkeqg+vft3LddCQYkEy/f1F1XfAuI0vJroz8q1ll4LtS8IkyUyrUcbAgco7eduL/c/hd
        BB1kmuk6IAL4/iUQgDlVWianKoszxp5AQTaT0RYZgF1jpQvlQ3oy3VQMVpTPhf8JzBtJAb
        ug/cgupC2PYoi8bN3TJbhocJgDGmDU+UhzsudhjeG72/h23m5MpMBNPMwDeNzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659607970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLSZPZSjoAeTGrgSN5RmR7EL5cAJ9diYkxxZcNWNL4s=;
        b=VQAMonK1IeG501+VvO1wGyesc5mBrAC82ZCHzNPalzpLxmKOx1UNU67CohWLJovwiPyM69
        iNUmKUOmvpt+L4Ag==
From:   "tip-bot2 for Jason Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Fix various duplicate-word comment typos
Cc:     Jason Wang <wangborong@cdjrlc.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220715044809.20572-1-wangborong@cdjrlc.com>
References: <20220715044809.20572-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Message-ID: <165960796851.15455.16926739892196439639.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     edf13ecbc8d68cc7462df9cae1f4a137df3b827c
Gitweb:        https://git.kernel.org/tip/edf13ecbc8d68cc7462df9cae1f4a137df3b827c
Author:        Jason Wang <wangborong@cdjrlc.com>
AuthorDate:    Fri, 15 Jul 2022 12:48:09 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 04 Aug 2022 12:08:10 +02:00

x86: Fix various duplicate-word comment typos

[ mingo: Consolidated 4 very similar patches into one, it's silly to spread this out. ]

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220715044809.20572-1-wangborong@cdjrlc.com
---
 arch/x86/kernel/amd_gart_64.c | 2 +-
 arch/x86/kernel/aperture_64.c | 2 +-
 arch/x86/kvm/vmx/nested.c     | 2 +-
 arch/x86/platform/efi/efi.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 194d54e..19a0207 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -53,7 +53,7 @@ static u32 *iommu_gatt_base;		/* Remapping table */
  * of only flushing when an mapping is reused. With it true the GART is
  * flushed for every mapping. Problem is that doing the lazy flush seems
  * to trigger bugs with some popular PCI cards, in particular 3ware (but
- * has been also also seen with Qlogic at least).
+ * has been also seen with Qlogic at least).
  */
 static int iommu_fullflush = 1;
 
diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index 7a5630d..4feaa67 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -36,7 +36,7 @@
 /*
  * Using 512M as goal, in case kexec will load kernel_big
  * that will do the on-position decompress, and could overlap with
- * with the gart aperture that is used.
+ * the gart aperture that is used.
  * Sequence:
  * kernel_small
  * ==> kexec (with kdump trigger path or gart still enabled)
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ab135f9..f0ba7da 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2560,7 +2560,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	 * bits which we consider mandatory enabled.
 	 * The CR0_READ_SHADOW is what L2 should have expected to read given
 	 * the specifications by L1; It's not enough to take
-	 * vmcs12->cr0_read_shadow because on our cr0_guest_host_mask we we
+	 * vmcs12->cr0_read_shadow because on our cr0_guest_host_mask we
 	 * have more bits than L1 expected.
 	 */
 	vmx_set_cr0(vcpu, vmcs12->guest_cr0);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 1591d67..b6efd2b 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -192,7 +192,7 @@ static void __init do_add_efi_memmap(void)
 }
 
 /*
- * Given add_efi_memmap defaults to 0 and there there is no alternative
+ * Given add_efi_memmap defaults to 0 and there is no alternative
  * e820 mechanism for soft-reserved memory, import the full EFI memory
  * map if soft reservations are present and enabled. Otherwise, the
  * mechanism to disable the kernel's consideration of EFI_MEMORY_SP is
