Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1063A50716E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353684AbiDSPMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353594AbiDSPMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:12:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1217F3B289;
        Tue, 19 Apr 2022 08:09:35 -0700 (PDT)
Date:   Tue, 19 Apr 2022 15:09:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650380973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=84SvmrYb0d8HI4VLeBxcmCnfHKheHm5ovGXtzvp9Ecw=;
        b=JfP+RGq5b0StN+OQXrQKqaFyhL2P7TVTBh6qqeqrlcyeCtpPnnkbo1x2ZWmmjXH758xyaK
        3Egafpg0AJXxBByBehQhBHGz2capGAVhg6yNN9RmTBfanF4G9sKav0yKsNyVbiuyBvxqa6
        V3NbnqcTjSonPCUAf6AyJ3tRyiFMCCsUZRGtnG7TZM+6vpaCdyAylN5Xt+o6AyUzUZQHvL
        57v8asmErJuAnkcN7L/zpuO0a8hLAaWxsauzVuG7LWSwMg2uiobB9zKfPtnF+1POX66+qc
        4k0rEk7zW3sy1DzyKhVX/JgkrtT4OiEBsKk7QsF3SzSIyFr8ETgG0ahMny2YhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650380973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=84SvmrYb0d8HI4VLeBxcmCnfHKheHm5ovGXtzvp9Ecw=;
        b=B5Go3lGitpt/ja7YVYopr5hPEapZK2gOKCqFypM7+4paiEYEX+5jCSJVBf11czAVfOn21Z
        BHhnKASTcRlk3HAw==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/mm: Fix spacing within memory encryption features message
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C02401f3024b18e90bc2508147e22e729436cb6d9=2E16502?=
 =?utf-8?q?98573=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C02401f3024b18e90bc2508147e22e729436cb6d9=2E165029?=
 =?utf-8?q?8573=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165038096740.4207.11945503087935656353.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     51964015565d302fda63ce84ef151e1c9a5939cc
Gitweb:        https://git.kernel.org/tip/51964015565d302fda63ce84ef151e1c9a5939cc
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 18 Apr 2022 11:16:13 -05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 19 Apr 2022 08:04:17 -07:00

x86/mm: Fix spacing within memory encryption features message

The spacing is off in the memory encryption features message on AMD
platforms that support memory encryption, e.g.:

  "Memory Encryption Features active:AMD  SEV SEV-ES"

There is no space before "AMD" and two spaces after it. Fix this so that
the message is spaced properly:

  "Memory Encryption Features active: AMD SEV SEV-ES"

Fixes: 968b493173ac ("x86/mm: Make DMA memory shared for TD guest")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lkml.kernel.org/r/02401f3024b18e90bc2508147e22e729436cb6d9.1650298573.git.thomas.lendacky@amd.com
---
 arch/x86/mm/mem_encrypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 10ee40b..1562f5e 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -49,7 +49,7 @@ static void print_mem_encrypt_feature_info(void)
 		return;
 	}
 
-	pr_cont("AMD ");
+	pr_cont(" AMD");
 
 	/* Secure Memory Encryption */
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
