Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F9533E39
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbiEYNuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244595AbiEYNuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:50:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFC82C67B;
        Wed, 25 May 2022 06:50:14 -0700 (PDT)
Date:   Wed, 25 May 2022 13:50:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653486613;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/7QoNTR6KxK6cV3mDhoJv7AZrlbnpX0w8gUZqApLUEw=;
        b=ezyCEWvcq2DuJP4sIGUq4Y8sMw+91pGs5/Ks3np5C2GTaeCQ5UMNfv7blFkdrUZbtWLCYp
        zkneGYRNHSfKeB/Kkflj+o+5A4Zj5icohhttnru46JqB8vF9PYXx/mZUlNmGvN5j0FWaYq
        Bun2rZ+E6mW0P8OgZdN0yx3Im97V0ijaBgu8wTmVDrzMXGoU9n5SZneQu7atzwQsPvOHMJ
        0XOXdA+cTkA8adMKl68miVNm6lLjDZ4zcyth5IX2dJ1fQgWZGskLI65AbrxqqOcxcq0Ico
        CzK159g1FhxnhsWPcKag68vHjP678pVIxu11EPG4QpyuBC5TRBwkmZmkmwVDaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653486613;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/7QoNTR6KxK6cV3mDhoJv7AZrlbnpX0w8gUZqApLUEw=;
        b=eL6GBSFV30I2O2RKDhZ65qdaaF21lIfR6+VQlaw9x1Czi0Ffz0ydmS8UqLre55WlCSlFZ4
        uTyTvkSFui49GNBg==
From:   "tip-bot2 for sunliming" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/idt: Remove unused headers
Cc:     sunliming <sunliming@kylinos.cn>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220525012827.93464-1-sunliming@kylinos.cn>
References: <20220525012827.93464-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Message-ID: <165348661199.4207.1899974546551206593.tip-bot2@tip-bot2>
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

Commit-ID:     20eb48885b62d5de4ab6be7e08f9f55aa33333fd
Gitweb:        https://git.kernel.org/tip/20eb48885b62d5de4ab6be7e08f9f55aa33333fd
Author:        sunliming <kelulanainsley@gmail.com>
AuthorDate:    Wed, 25 May 2022 09:28:27 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 May 2022 15:45:00 +02:00

x86/idt: Remove unused headers

Commit:

  4b9a8dca0e58 ("x86/idt: Remove the tracing IDT completely")

removed the 'tracing IDT' from arch/x86/kernel/tracepoint.c,
but left related headers included - remove them.

[ mingo: Tweak changelog. ]

Signed-off-by: sunliming <sunliming@kylinos.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220525012827.93464-1-sunliming@kylinos.cn
---
 arch/x86/kernel/tracepoint.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
index fcfc077..f39aad6 100644
--- a/arch/x86/kernel/tracepoint.c
+++ b/arch/x86/kernel/tracepoint.c
@@ -8,10 +8,7 @@
 #include <linux/jump_label.h>
 #include <linux/atomic.h>
 
-#include <asm/hw_irq.h>
-#include <asm/desc.h>
 #include <asm/trace/exceptions.h>
-#include <asm/trace/irq_vectors.h>
 
 DEFINE_STATIC_KEY_FALSE(trace_pagefault_key);
 
