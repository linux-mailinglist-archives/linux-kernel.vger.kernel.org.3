Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB48588F92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiHCPmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbiHCPmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:42:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E54418B0A;
        Wed,  3 Aug 2022 08:42:07 -0700 (PDT)
Date:   Wed, 03 Aug 2022 15:42:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659541325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IPf7laHJr6gLAnl9xbzWj6hPnYO44QtIRkP/NzRqwj4=;
        b=pU0TEY1bKY8E5lCFO2/AQbzx1Ysga19d931OoZKDrO/YVZOApm/OPRT64pmnR/mt+XijYL
        tx5wu9zbDVrkFxhlvvm08Ye3EubF2Mbmp1wFfjEvtGTdxuMvvp9wasfCcRxX4EIjAm3T3r
        02H+VMhVGUGg9vrlz7xNug2kWKGCRoCCmMcGb2GroyVMCr621G2oVMAZOkLRjDBLRHvXrX
        yCIIZ3fw7PdM9OxgcAQ5CaBHTWmr3Wi+ev59a7EsSRyHb9sfIfuZUdIWvZQkw8Cwh6du5U
        ieaM9fltb//ntRDGcylO8KmEWJhwZFDbBpvufTzT/Criw7AVSgFRd3lAMeMq1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659541325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IPf7laHJr6gLAnl9xbzWj6hPnYO44QtIRkP/NzRqwj4=;
        b=0zNEGoKqhNL7DtOrQzrM4ORlKiIakvdg2Mr+2un7xd1I4s2zHCSVPJ6FDCJ17HOTXzbJq5
        UT5vUBIaZ9P2PDAQ==
From:   "tip-bot2 for Li kunyu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/boot: Remove superfluous type casting from
 arch/x86/boot/bitops.h
Cc:     Li kunyu <kunyu@nfschina.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220725042358.3377-1-kunyu@nfschina.com>
References: <20220725042358.3377-1-kunyu@nfschina.com>
MIME-Version: 1.0
Message-ID: <165954132463.15455.4096087290275074737.tip-bot2@tip-bot2>
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

Commit-ID:     a50be38f617b11b451c0a432c574859419e69471
Gitweb:        https://git.kernel.org/tip/a50be38f617b11b451c0a432c574859419e69471
Author:        Li kunyu <kunyu@nfschina.com>
AuthorDate:    Mon, 25 Jul 2022 12:23:58 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Aug 2022 11:32:29 +02:00

x86/boot: Remove superfluous type casting from arch/x86/boot/bitops.h

'const void *' will auto-type-convert to just about any other const pointer type,
no need to force it.

[ mingo: Rewrote the changelog. ]

Signed-off-by: Li kunyu <kunyu@nfschina.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220725042358.3377-1-kunyu@nfschina.com
---
 arch/x86/boot/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/bitops.h b/arch/x86/boot/bitops.h
index 02e1dea..8518ae2 100644
--- a/arch/x86/boot/bitops.h
+++ b/arch/x86/boot/bitops.h
@@ -19,13 +19,13 @@
 
 static inline bool constant_test_bit(int nr, const void *addr)
 {
-	const u32 *p = (const u32 *)addr;
+	const u32 *p = addr;
 	return ((1UL << (nr & 31)) & (p[nr >> 5])) != 0;
 }
 static inline bool variable_test_bit(int nr, const void *addr)
 {
 	bool v;
-	const u32 *p = (const u32 *)addr;
+	const u32 *p = addr;
 
 	asm("btl %2,%1" CC_SET(c) : CC_OUT(c) (v) : "m" (*p), "Ir" (nr));
 	return v;
