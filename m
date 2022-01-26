Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23FF49CAD8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239944AbiAZNar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:30:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57088 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239594AbiAZNad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:30:33 -0500
Date:   Wed, 26 Jan 2022 13:30:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643203832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwpsyTbb3pWxBC08bJQCOrjmcYrfudgHpnpWJhGSl2o=;
        b=UIhnfZf7f2wuk7gqpGp2w5ZEqZj5drVnp/SRZRTudcq/aateTRL7V+H71/REL9ozxmCLuR
        KMns3IpGnX8YAcdbON3kMiMUzGcar3z2bR9sK0u0GgTQYfEomCzSRQOsYo3rgk6ETKZjYo
        H1O2zOU44lN/qKU8wB2QrWAf60dU+DWd67FdtuQfk+Mc2e73x+b3YlY7co5PndFHySbcTN
        h96lb71PvQDkN9Vy0bi146eOyuQNngjD5x603bh2g/rzucZd8uJn9YR033A/z7u/3sIzY3
        9evtdMZjYSfM96LcgiVPwDtctw0u5pdQO6e/dMzp2XvUMCw0hsylunK4ZZCIbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643203832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwpsyTbb3pWxBC08bJQCOrjmcYrfudgHpnpWJhGSl2o=;
        b=wa6loCnYCPlRbna/IOyt6TE7ZjxV5qQpmyTFSdAY4aY9en5LW2v8XizVE0U/QuxeKBWf7z
        IL55jCV9geWIRNCQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] MAINTAINERS: add myself as reviewer for atomics
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220104095018.1990058-1-mark.rutland@arm.com>
References: <20220104095018.1990058-1-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <164320383081.16921.9909201595548579959.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     54dff232142e255ff644d73de1c8d80122f5ad7b
Gitweb:        https://git.kernel.org/tip/54dff232142e255ff644d73de1c8d80122f5ad7b
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 04 Jan 2022 09:50:18 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 25 Jan 2022 22:30:27 +01:00

MAINTAINERS: add myself as reviewer for atomics

As I've fiddled about with the atomic infrastructure a fair bit now,
Peter suggested I should add myself as a reviewer or maintainer to make
sure I'm Cc'd on anything I might have an opinion on.

For now, add myself as a reviewer.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20220104095018.1990058-1-mark.rutland@arm.com
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c9..bccca3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3193,6 +3193,7 @@ ATOMIC INFRASTRUCTURE
 M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 R:	Boqun Feng <boqun.feng@gmail.com>
+R:	Mark Rutland <mark.rutland@arm.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	arch/*/include/asm/atomic*.h
