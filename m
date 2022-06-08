Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAE4543EF5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiFHWBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiFHWBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:01:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138CE15FD1;
        Wed,  8 Jun 2022 15:01:04 -0700 (PDT)
Date:   Wed, 08 Jun 2022 22:01:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654725661;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZLW55a6/6K0yMK4EHkE1wX9QM2vv/nZWp/lrqD3jvJk=;
        b=wQBa/oitNmFupC9VngBdU12XvQh6kKXi0XtP6bTlA/IP9rdu6I5vodd4tppGgxkEasL2rO
        UPztf2PgnQ4fos9kqnR9aMsa0itGE2nYBKA06NnxxIJPDJJDEEb91cZ+N0+BpkACxIKVqr
        GzrgImTvZEN8DbVaqwFZjOP0aUcMNhrwh2YOMORQrUKiAhr09VIccF5x0VfsnVtUCW8w6/
        D5sDNZKS37eA1EeHMB/LJCbxRvTJjPHfjOrhGcE32IKik3zLA4+UGthtWDCDbGu3hM03F8
        wicJ1pySS8J22zdMTFSMXxgVAwb4aodtl++wEL8wATVa4qEZCoArje8cG7gauw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654725661;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZLW55a6/6K0yMK4EHkE1wX9QM2vv/nZWp/lrqD3jvJk=;
        b=6Rcwv7IRtYrlGoZl4YsrH4Z+Bmj1cWLcfYECO4iS8WXUGsFdtrRbtBOHHZV3rdT3poxa8c
        6sYBamR74L5R0xBQ==
From:   "tip-bot2 for Wyes Karny" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86: Fix comment for X86_FEATURE_ZEN
Cc:     Wyes Karny <wyes.karny@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C9931b01a85120a0d1faf0f244e8de3f2190e774c=2E16545?=
 =?utf-8?q?38381=2Egit-series=2Ewyes=2Ekarny=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C9931b01a85120a0d1faf0f244e8de3f2190e774c=2E165453?=
 =?utf-8?q?8381=2Egit-series=2Ewyes=2Ekarny=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165472566029.4207.7734270022087420736.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     6f33a9daff9f07906365c4054c90b225f346cd0e
Gitweb:        https://git.kernel.org/tip/6f33a9daff9f07906365c4054c90b225f346cd0e
Author:        Wyes Karny <wyes.karny@amd.com>
AuthorDate:    Mon, 06 Jun 2022 23:33:36 +05:30
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 08 Jun 2022 13:01:58 -07:00

x86: Fix comment for X86_FEATURE_ZEN

The feature X86_FEATURE_ZEN implies that the CPU based on Zen
microarchitecture. Call this out explicitly in the comment.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lkml.kernel.org/r/9931b01a85120a0d1faf0f244e8de3f2190e774c.1654538381.git-series.wyes.karny@amd.com
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 73e643a..6141457 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -219,7 +219,7 @@
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 or above (Zen) */
+#define X86_FEATURE_ZEN			(7*32+28) /* "" CPU based on Zen microarchitecture */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 #define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
