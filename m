Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB405070E6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350288AbiDSOqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351116AbiDSOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:46:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DEC3A5DC;
        Tue, 19 Apr 2022 07:42:56 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:42:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650379360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b7OJ7fxN/CHWsQzM3HtGGSNRkYu2h73FDMImgPW55fk=;
        b=DQ7WL0jtEyy0oIq0iYsD14iR6DMr9Hf8kHD5z2TBu+zqFuPqsSs6G45dIj5QLiNOC13Rn8
        E60v9ZsfsXRq63TvKdtQucyEaPbZzeuaFLi9IKJJW9rBf2hhzQ9N00ewQb7u0e4Q83ATXj
        bZkyKRQ3G7Hwex69f7+iIlg7pVieYNY2BV1TIO62EAJ/7VG269EvWa7YtqiwbuaT+ygkhz
        CIXmItRg5k5zP1CBVe0GwjOP1425EdA5yemrzS1reyxaZbCwDJkrH9HXYD1CdtcV+klpnt
        5+Q4i9a1vZsVaTH40b/JaTpP9y4B0qUE32v6B6sbASPkxs08U1Itn4TcMRz+UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650379360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b7OJ7fxN/CHWsQzM3HtGGSNRkYu2h73FDMImgPW55fk=;
        b=0L3Uo3maE4RKH/GoiA2siJjxM4T7Sm88UPS1yZXKr9FPmfNdjD44ESNfBgqA6jz8teXQE5
        y/SmPJnAy77g+4AA==
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
Message-ID: <165037935939.4207.14107957668797882327.tip-bot2@tip-bot2>
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

Commit-ID:     9e3cdf7ad39356c11b6a4f3c407726f9bcc85956
Gitweb:        https://git.kernel.org/tip/9e3cdf7ad39356c11b6a4f3c407726f9bcc85956
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 18 Apr 2022 11:16:13 -05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 19 Apr 2022 07:17:25 -07:00

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
