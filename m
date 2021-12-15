Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BA2475953
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242687AbhLONFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:05:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47850 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbhLONFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:05:51 -0500
Date:   Wed, 15 Dec 2021 13:05:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639573550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CrwoUGwhUf2+jm8upIb7DsqwuAOLh+4EsiEpT0j5yYY=;
        b=h2HWTm/Yu3SjKYajuHUULPEmYAQWxfOnB/I1awWeSwf3cgZSmjGvVaHtQ7qrhmi9ZOj/1G
        /QtXtly4JQFxHrVxBbsLXx7GMGH/IIZIn/PEClTbdeblu3ix8+8yW9Ldwl6nV54ifeFLtQ
        IyJ69EV+B57ZfX3xyaH26pi8bQ0mz81nDr/QGgRvvYZADF2psudOtHR8csolcCx8tixAPd
        sj2IVINbGepPiVASStnh1B/XL+zfFmdac0wckHNW4DN1z3bGDU06SonwnO0eAyf2nheRlz
        DM2Cj+1lYLRvLGlMx4y7d+zbv2tqV8Ch2flBRFbVX6i+HHTKV+zoYjGLZHMdPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639573550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CrwoUGwhUf2+jm8upIb7DsqwuAOLh+4EsiEpT0j5yYY=;
        b=XjnrTBKbQeR5X8hN7clhxH58mk2rAjSzizwm0kkb8lIiXJbCxqjPNW/ka1xpeMuPpOOUwu
        CmYqKyvJhzAiGyDw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] Revert "x86/boot: Mark prepare_command_line() __init"
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211213112757.2612-2-bp@alien8.de>
References: <20211213112757.2612-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163957354901.23020.2806694166507690379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     58e138d62476fc5f889252dcf73848beeaa54789
Gitweb:        https://git.kernel.org/tip/58e138d62476fc5f889252dcf73848beeaa54789
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 13 Dec 2021 12:27:55 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 15 Dec 2021 11:14:28 +01:00

Revert "x86/boot: Mark prepare_command_line() __init"

This reverts commit c0f2077baa4113f38f008b8e912b9fb3ff8d43df.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211213112757.2612-2-bp@alien8.de
---
 arch/x86/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 6a190c7..c410be7 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -742,7 +742,7 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
 	return 0;
 }
 
-static char * __init prepare_command_line(void)
+static char *prepare_command_line(void)
 {
 #ifdef CONFIG_CMDLINE_BOOL
 #ifdef CONFIG_CMDLINE_OVERRIDE
