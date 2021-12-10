Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3021470995
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245697AbhLJTAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:00:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48392 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241978AbhLJTAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:00:42 -0500
Date:   Fri, 10 Dec 2021 18:57:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639162626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yoDBKNhuk0czCNC+uZIIKsoOrQ9oupxrKIthRZRU/6Y=;
        b=ssB8xzD0GBEZZY5Fo6GTyoouLa1jO2NjRt8xZ2KkTXNTATjF4lHRUibSOWDgq7G6utPKs+
        kZD7hGpbbPzOCGq7J7IAQpMGea8Lj1ecXpNXg4xNklSmbd0hd2JkjKoATFZW0ENlzp3UnF
        c5C55/20exO/xWnTMBbi5gYCcq/orl7xE5KAZOEGQrb+HloYkwStmfAareVTiSKtEllE2J
        bsRAiV6xkcDGI6Ew5H6PBH51xZShK9K88kV4v0z3pkaGYmxak98NURhm2rAQ5wU5nGbmT7
        s5fffZQvUA21RUkw+CITeK+zH45cuGvmDcubjy1CIXfOS7UDVyMM1KsrSkUebQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639162626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yoDBKNhuk0czCNC+uZIIKsoOrQ9oupxrKIthRZRU/6Y=;
        b=OYR7Al5i7W4jlDpS60RXim0rU/I9jBiZ64FDEju/jqV94VV6X7YJQ5S6As266c3oKStLn3
        WR3AhjhR40N5uGCg==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/boot/string: Add missing function prototypes
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211119175325.3668419-1-keescook@chromium.org>
References: <20211119175325.3668419-1-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <163916262480.23020.13492329769891837055.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     bc7aaf52f963674690510e6c1f3710cd0394b25e
Gitweb:        https://git.kernel.org/tip/bc7aaf52f963674690510e6c1f3710cd0394b25e
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 19 Nov 2021 09:53:25 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 10 Dec 2021 19:49:06 +01:00

x86/boot/string: Add missing function prototypes

Silence "warning: no previous prototype for ... [-Wmissing-prototypes]"
warnings from string.h when building under W=1.

 [ bp: Clarify commit message. ]

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211119175325.3668419-1-keescook@chromium.org
---
 arch/x86/boot/string.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
index a232da4..e5d2c6b 100644
--- a/arch/x86/boot/string.h
+++ b/arch/x86/boot/string.h
@@ -8,8 +8,10 @@
 #undef memcmp
 
 void *memcpy(void *dst, const void *src, size_t len);
+void *memmove(void *dst, const void *src, size_t len);
 void *memset(void *dst, int c, size_t len);
 int memcmp(const void *s1, const void *s2, size_t len);
+int bcmp(const void *s1, const void *s2, size_t len);
 
 /* Access builtin version by default. */
 #define memcpy(d,s,l) __builtin_memcpy(d,s,l)
@@ -25,6 +27,7 @@ extern size_t strnlen(const char *s, size_t maxlen);
 extern unsigned int atou(const char *s);
 extern unsigned long long simple_strtoull(const char *cp, char **endp,
 					  unsigned int base);
+long simple_strtol(const char *cp, char **endp, unsigned int base);
 
 int kstrtoull(const char *s, unsigned int base, unsigned long long *res);
 int boot_kstrtoul(const char *s, unsigned int base, unsigned long *res);
