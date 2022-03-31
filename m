Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5630A4ED663
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiCaJDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiCaJCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:02:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FA553E2C;
        Thu, 31 Mar 2022 02:01:02 -0700 (PDT)
Date:   Thu, 31 Mar 2022 09:00:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648717261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZHYuqeKJnzEN55VinKARygxDGwAlk2OUMAGWJjsEkn0=;
        b=J6VmftH1YDIqwEXxIQz1ucJSf9CwdQrMuGvrMKnKL/HXk5RG7Gl7lBU0vscOU8SCWUW5sf
        JwksjtgAoV95KE+R0UmAA6nOwFnzK4qjs0MIO33yK70AaBVfpGL1TorEs5ft3dTvhLQPBo
        H7kA8M7o9NyuFo7zKeQKlqzZo666+XBOHSobJetE6BzePXKPxOXwJ3dZFKFoY9eGaECCZ+
        CQpnaPyhzlluO1YcvqJ8SU+jLmtswFddITrWBmJ7BCEDv7O/ZWO10J9aCCE17jvGFtG22v
        mkCzPtNcZAdXLDVEpkl6W6Vf8WwA4mSr0w3V7h9iUwEZdNSLlpfAzZrsrOdAxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648717261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZHYuqeKJnzEN55VinKARygxDGwAlk2OUMAGWJjsEkn0=;
        b=nKTSEdDSM2g3EW9jn9DWkqgbuONzaDxmtRIcBk4ZIhskoX/cMmeiq/9md2B3xhvrYKpK8v
        xudUPpAIvhqHdHBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Remove unused supervisor only offsets
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220324134623.465066249@linutronix.de>
References: <20220324134623.465066249@linutronix.de>
MIME-Version: 1.0
Message-ID: <164871725930.389.263374082981753847.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d47f71f6de7970d504748d1a60a11c51af5bce47
Gitweb:        https://git.kernel.org/tip/d47f71f6de7970d504748d1a60a11c51af5bce47
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 24 Mar 2022 14:47:09 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 30 Mar 2022 10:44:51 +02:00

x86/fpu: Remove unused supervisor only offsets

No users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220324134623.465066249@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index dc6d5e9..dc33556 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -83,8 +83,6 @@ static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_comp_offsets[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] __ro_after_init =
-	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 
 /*
  * Return whether the system supports a given xfeature.
@@ -325,33 +323,6 @@ static void __init setup_xstate_comp_offsets(void)
 }
 
 /*
- * Setup offsets of a supervisor-state-only XSAVES buffer:
- *
- * The offsets stored in xstate_comp_offsets[] only work for one specific
- * value of the Requested Feature BitMap (RFBM).  In cases where a different
- * RFBM value is used, a different set of offsets is required.  This set of
- * offsets is for when RFBM=xfeatures_mask_supervisor().
- */
-static void __init setup_supervisor_only_offsets(void)
-{
-	unsigned int next_offset;
-	int i;
-
-	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
-
-	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
-		if (!xfeature_is_supervisor(i))
-			continue;
-
-		if (xfeature_is_aligned(i))
-			next_offset = ALIGN(next_offset, 64);
-
-		xstate_supervisor_only_offsets[i] = next_offset;
-		next_offset += xstate_sizes[i];
-	}
-}
-
-/*
  * Print out xstate component offsets and sizes
  */
 static void __init print_xstate_offset_size(void)
@@ -951,7 +922,6 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 
 	setup_init_fpu_buf();
 	setup_xstate_comp_offsets();
-	setup_supervisor_only_offsets();
 
 	/*
 	 * Paranoia check whether something in the setup modified the
