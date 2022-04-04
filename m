Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1514F1DD7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385881AbiDDVmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379934AbiDDSYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:24:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0801222B20;
        Mon,  4 Apr 2022 11:22:19 -0700 (PDT)
Date:   Mon, 04 Apr 2022 18:22:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649096537;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oY/Nb3gZgmyqqAZtzdiguynTW3EJR/4qr4+zwF29TqU=;
        b=IJwXMj8IMyPDXuk3w6zz8sj0SJleQztGsO2wm92rsikhMtKPNZFhaOPbTsB4qST4XKX0/7
        LL5aeSF8RLKatcvMJlskC02vJSJbNZ0/9/qf4Q+yzvNULSn2GyI+fdPLi+yZF3xtTr/Nal
        2NAPRhM11w7knaE936b4PeoPvwwy9K/lcwhhsf35xbd06XQMNK4QMmeMAEn5RS4X92AT9b
        17d6FQ/hec58lR4E4WnrprWJyZE55PT/L72iSqEmz/5qY95YLVWXo33erkz10yMYWsfLTr
        kIMyr3o1u5Wgdjrebg1WNOoOwMUDPaPjUXpzqPHYB1+r8pG9Pt+V4JIJLhmNHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649096537;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oY/Nb3gZgmyqqAZtzdiguynTW3EJR/4qr4+zwF29TqU=;
        b=KA6hTj/l/1ZsaiYpZZP6rWsip1LWWJgZ0WBIO9imDBYvk61hlq6MeyyKBxVsaKUOO1qiiB
        G56ny9h0OnDw/RAg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove "noclflush"
Cc:     Borislav Petkov <bp@suse.de>, Kees Cook <keescook@chromium.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220127115626.14179-7-bp@alien8.de>
References: <20220127115626.14179-7-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <164909653637.389.15323497274729912796.tip-bot2@tip-bot2>
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

Commit-ID:     f8858b5eff30d1b2be15ef1ea6285964013b95e6
Gitweb:        https://git.kernel.org/tip/f8858b5eff30d1b2be15ef1ea6285964013b95e6
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 27 Jan 2022 12:56:26 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Apr 2022 10:17:05 +02:00

x86/cpu: Remove "noclflush"

Not really needed anymore and there's clearcpuid=.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20220127115626.14179-7-bp@alien8.de
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 arch/x86/kernel/cpu/common.c                    | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a2299b2..8c18e7d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3444,8 +3444,6 @@
 
 	nocache		[ARM]
 
-	noclflush	[BUGS=X86] Don't use the CLFLUSH instruction
-
 	delayacct	[KNL] Enable per-task delay accounting
 
 	nodsp		[SH] Disable hardware DSP at boot time.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5791f69..7dd7604 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1870,14 +1870,6 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 	update_srbds_msr();
 }
 
-static __init int setup_noclflush(char *arg)
-{
-	setup_clear_cpu_cap(X86_FEATURE_CLFLUSH);
-	setup_clear_cpu_cap(X86_FEATURE_CLFLUSHOPT);
-	return 1;
-}
-__setup("noclflush", setup_noclflush);
-
 void print_cpu_info(struct cpuinfo_x86 *c)
 {
 	const char *vendor = NULL;
