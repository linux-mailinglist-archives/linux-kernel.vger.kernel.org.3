Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08A1472907
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244586AbhLMKRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:17:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33592 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbhLMJuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:50:11 -0500
Date:   Mon, 13 Dec 2021 09:50:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389009;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfBp4VCkCvOxTn5ystrkyv/GRImnlrOn0lVvZUbEEBk=;
        b=MP3Znm5Qwg6cJjnB71G9M3gHUJKM4ulk9mKkVBWqlC0y/RvtzV4yj6eN8cmBpsK0eBIFDO
        9/X3TzSoTXO/O2tBdhMn6vWZ4nE710KfsAVsnB+4I3F5mUhX/K4DKAIan4KiKUPFkeVU7X
        kjxd5q0s53U+QHC30ilWlgicw6QbhBiP4N4FgcYeK2+H/DdB8JEAMEUyynPs83AgSlg6RA
        71LpvLMQfuz9WcHRccRbQmeKGXr2SbAPdP0Mi0lddJpj0XH2qjENARc7fUms+R0+5yon7D
        mGe3z5KyfoSdV/PjV4xTilemkZaaSzjIKxBLHaQInRWFZqrm8wYarKKdevvxSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389009;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfBp4VCkCvOxTn5ystrkyv/GRImnlrOn0lVvZUbEEBk=;
        b=x1Tqd9JFeOJgznZrj1Hw9VFYdQUhwKOuu7aunp8VLUcohRpw0tHcJ82mIndwVBU30ywZ4y
        X20V5ByRYivQckBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Remove .fixup section
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101326.201590122@infradead.org>
References: <20211110101326.201590122@infradead.org>
MIME-Version: 1.0
Message-ID: <163938900868.23020.6909199448960109580.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     e5eefda5aa51f3178821b58806e1dddd798c0934
Gitweb:        https://git.kernel.org/tip/e5eefda5aa51f3178821b58806e1dddd798c0934
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:50 +01:00

x86: Remove .fixup section

No moar users, kill it dead.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101326.201590122@infradead.org
---
 arch/x86/entry/vdso/vdso-layout.lds.S | 1 -
 arch/x86/kernel/vmlinux.lds.S         | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index dc8da76..bafa73f 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -77,7 +77,6 @@ SECTIONS
 
 	.text		: {
 		*(.text*)
-		*(.fixup)
 	}						:text	=0x90909090,
 
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3d6dc12..27f8303 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -137,7 +137,6 @@ SECTIONS
 		ALIGN_ENTRY_TEXT_END
 		SOFTIRQENTRY_TEXT
 		STATIC_CALL_TEXT
-		*(.fixup)
 		*(.gnu.warning)
 
 #ifdef CONFIG_RETPOLINE
