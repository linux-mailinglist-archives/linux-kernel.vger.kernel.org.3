Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E2E58B7CF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 20:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiHFSuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 14:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiHFSuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 14:50:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A79EB1;
        Sat,  6 Aug 2022 11:50:13 -0700 (PDT)
Date:   Sat, 06 Aug 2022 18:50:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659811810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekJuun2JIKiWZ64hgvYRQtolLrVyhjiUSxg+2zROszc=;
        b=tafUY8rhIxCLvwtBCZKmjxiyuqvAohyfbKPmlaRg85qgduKeKkKeDkoOW2tYUy7cvNswPx
        myWetY3Yg17xYxB2TKYohqamCzAsOi0uN2zggntVzATDF6v1g+o1jq80YhkPu7XrpT43kE
        p/u6ED7SNI8UKS2w1cgxcDUv5OkUABps5H+bfuQ9aqEs1a4I4duuRtWNTpHAsk2HXxAlCC
        yU1GJ4/yIbTbN+VFqoaCz0qmR2joV66U73R+EREBZwFsy6EnCdjAWY0u+HIDO3iThm5pKD
        xnOhzXEDNXotUnHPMiYjEyAiWX72J4b07gGhir6n4seN71WikBc7gJmu1PLqyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659811810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekJuun2JIKiWZ64hgvYRQtolLrVyhjiUSxg+2zROszc=;
        b=voOo7D/DjemJCfPTKZPDhnQdTflVp2+hZ5X6ge/zwknqHt0f49bHJWvOxO2p+1gMGswObC
        vsPt1wZ+38P8nQAg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Rename set_memory_present() to set_memory_p()
Cc:     Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220805140702.31538-1-bp@alien8.de>
References: <20220805140702.31538-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <165981180896.15455.6141778315507945390.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     86af8230ce138e0423f43f6b104f3fa050aced6d
Gitweb:        https://git.kernel.org/tip/86af8230ce138e0423f43f6b104f3fa050aced6d
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 05 Aug 2022 16:07:02 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Aug 2022 20:46:13 +02:00

x86/mm: Rename set_memory_present() to set_memory_p()

Have it adhere to the naming convention for those helpers.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220805140702.31538-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 1abd543..6a9043b 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1944,7 +1944,7 @@ int set_mce_nospec(unsigned long pfn)
 	return rc;
 }
 
-static int set_memory_present(unsigned long *addr, int numpages)
+static int set_memory_p(unsigned long *addr, int numpages)
 {
 	return change_page_attr_set(addr, numpages, __pgprot(_PAGE_PRESENT), 0);
 }
@@ -1954,7 +1954,7 @@ int clear_mce_nospec(unsigned long pfn)
 {
 	unsigned long addr = (unsigned long) pfn_to_kaddr(pfn);
 
-	return set_memory_present(&addr, 1);
+	return set_memory_p(&addr, 1);
 }
 EXPORT_SYMBOL_GPL(clear_mce_nospec);
 #endif /* CONFIG_X86_64 */
