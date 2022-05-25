Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4800F533E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244504AbiEYNne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiEYNn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:43:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9864C6D3AE;
        Wed, 25 May 2022 06:43:25 -0700 (PDT)
Date:   Wed, 25 May 2022 13:43:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653486201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2eBubNTS/rZDib2edFgqMnORaIY195K9KIuHostpN5s=;
        b=UQR2+3t6tr/SwBDQ9vW4hiPK+IfyapwBtBm9F4vHBMSjNzidfiCQlWzYrHfm4fvCBg7BPU
        dnDkQCa4W1fLI1jH77Ah4GJGT/uIoqJRKE7SrjzD7FQdpb725sVId0a328hX7WpJBSI6v3
        k3sO17vrHlRFa90oZ5dFdyctEXGwHinlwIycwVpm2FHQ9YzYbpKUzrXBXjGk05AHD6nb5P
        37Wsc3Jg/ROaYg+3xyfxVOlayrVF2PAmcsu8Lu13RLg4DLc2jPUDm3zOxGdEMHEa20SlXD
        MjRon4n6RDPO8G4E9lxtK0ZGC66uKsMY4FNaCTPUu8rmBSZSCkUwi0XGabvr1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653486201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2eBubNTS/rZDib2edFgqMnORaIY195K9KIuHostpN5s=;
        b=AeHmKzFOCq5pdaAt0B4Nuwziaox+J9taHZ8ALxPb8vlZfR6ujQHXkj4dqsOllQLoVfFVcG
        xMkxLWVO4pyToUCg==
From:   "tip-bot2 for Juerg Haefliger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/Kconfig: Fix indentation of arch/x86/Kconfig.debug
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220525133203.52463-3-juerg.haefliger@canonical.com>
References: <20220525133203.52463-3-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Message-ID: <165348620047.4207.1389769682815540395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     0ecfacb4c50ae2fd32ee1898562fe55f045b56d2
Gitweb:        https://git.kernel.org/tip/0ecfacb4c50ae2fd32ee1898562fe55f045b56d2
Author:        Juerg Haefliger <juerg.haefliger@canonical.com>
AuthorDate:    Wed, 25 May 2022 15:32:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 May 2022 15:39:27 +02:00

x86/Kconfig: Fix indentation of arch/x86/Kconfig.debug

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220525133203.52463-3-juerg.haefliger@canonical.com
---
 arch/x86/Kconfig.debug | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index d872a75..340399f 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -73,20 +73,19 @@ config DEBUG_TLBFLUSH
 	bool "Set upper limit of TLB entries to flush one-by-one"
 	depends on DEBUG_KERNEL
 	help
+	  X86-only for now.
 
-	X86-only for now.
+	  This option allows the user to tune the amount of TLB entries the
+	  kernel flushes one-by-one instead of doing a full TLB flush. In
+	  certain situations, the former is cheaper. This is controlled by the
+	  tlb_flushall_shift knob under /sys/kernel/debug/x86. If you set it
+	  to -1, the code flushes the whole TLB unconditionally. Otherwise,
+	  for positive values of it, the kernel will use single TLB entry
+	  invalidating instructions according to the following formula:
 
-	This option allows the user to tune the amount of TLB entries the
-	kernel flushes one-by-one instead of doing a full TLB flush. In
-	certain situations, the former is cheaper. This is controlled by the
-	tlb_flushall_shift knob under /sys/kernel/debug/x86. If you set it
-	to -1, the code flushes the whole TLB unconditionally. Otherwise,
-	for positive values of it, the kernel will use single TLB entry
-	invalidating instructions according to the following formula:
+	  flush_entries <= active_tlb_entries / 2^tlb_flushall_shift
 
-	flush_entries <= active_tlb_entries / 2^tlb_flushall_shift
-
-	If in doubt, say "N".
+	  If in doubt, say "N".
 
 config IOMMU_DEBUG
 	bool "Enable IOMMU debugging"
@@ -119,10 +118,10 @@ config X86_DECODER_SELFTEST
 	depends on DEBUG_KERNEL && INSTRUCTION_DECODER
 	depends on !COMPILE_TEST
 	help
-	 Perform x86 instruction decoder selftests at build time.
-	 This option is useful for checking the sanity of x86 instruction
-	 decoder code.
-	 If unsure, say "N".
+	  Perform x86 instruction decoder selftests at build time.
+	  This option is useful for checking the sanity of x86 instruction
+	  decoder code.
+	  If unsure, say "N".
 
 choice
 	prompt "IO delay type"
