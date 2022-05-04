Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CE251AD40
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377300AbiEDSuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377285AbiEDSuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:50:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB6D165B1;
        Wed,  4 May 2022 11:47:13 -0700 (PDT)
Date:   Wed, 04 May 2022 18:47:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651690031;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zu5TSATSvCYYaY7Kn2lIzDaMbq7oFFxVQXH2iz93NOU=;
        b=FT9XUPQSXNPAliWIwJWVv3GAtt+7uGyTD+RdDKElLRAS96W/MU3t3q/XtnJ1Rv1Y7OmGNb
        IqZ0t3MxLwHFcLSTpM+JNNEVW1QIPj4HF7XQ+Zwfrl7UmAq/UqnVi6M3PK7Ol1wUvyzzkH
        MqbUeBhA5V6xF2sVKfguup3Xkv8oFCWeGLhvkPOR7B4ozQ1Uy0//IQHkVDuyJnMvVpEgxi
        7nhXTiSGPWqP6ehkHpwVShjO0Z8ibIKW+tYDamZE5OUAJsm0rSG3A6bb844H3cQPBH2I/q
        6MB+FaDz+MORPCgVsQ2CkQylegh6DWWvwJXw9WorTmtyEEWOR3i3pO+RYY/ueA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651690031;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zu5TSATSvCYYaY7Kn2lIzDaMbq7oFFxVQXH2iz93NOU=;
        b=L5OJ4IGTIFitrOyK09kyp0h2o+yt356Sl4YooRa8tmSRXqgNNxb9i5nLP7CslxZ1ThAUg4
        ViZT4yarJJ9II4Bg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] MAINTAINERS: Update Josh Poimboeuf's email address
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1abc3de4b00dc6f915ac975a2ec29ed545d96dc4.1651687652.git.jpoimboe@redhat.com>
References: <1abc3de4b00dc6f915ac975a2ec29ed545d96dc4.1651687652.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165169003042.4207.8052984123869654429.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     770fb0942c338545f93a584342b64848cff31efe
Gitweb:        https://git.kernel.org/tip/770fb0942c338545f93a584342b64848cff31efe
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 04 May 2022 11:07:45 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 04 May 2022 20:43:08 +02:00

MAINTAINERS: Update Josh Poimboeuf's email address

Change to my kernel.org email address.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/1abc3de4b00dc6f915ac975a2ec29ed545d96dc4.1651687652.git.jpoimboe@redhat.com
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index edc96cd..1e1a226 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7499,7 +7499,7 @@ F:	Documentation/hwmon/f71805f.rst
 F:	drivers/hwmon/f71805f.c
 
 FADDR2LINE
-M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
 S:	Maintained
 F:	scripts/faddr2line
 
@@ -11348,7 +11348,7 @@ F:	drivers/mmc/host/litex_mmc.c
 N:	litex
 
 LIVE PATCHING
-M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Jiri Kosina <jikos@kernel.org>
 M:	Miroslav Benes <mbenes@suse.cz>
 M:	Petr Mladek <pmladek@suse.com>
@@ -14224,7 +14224,7 @@ F:	lib/objagg.c
 F:	lib/test_objagg.c
 
 OBJTOOL
-M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 S:	Supported
 F:	tools/objtool/
@@ -18792,7 +18792,7 @@ F:	include/dt-bindings/reset/starfive-jh7100.h
 
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
-M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Jason Baron <jbaron@akamai.com>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Ard Biesheuvel <ardb@kernel.org>
@@ -21444,7 +21444,7 @@ F:	arch/x86/kernel/apic/x2apic_uv_x.c
 F:	arch/x86/platform/uv/
 
 X86 STACK UNWINDING
-M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 S:	Supported
 F:	arch/x86/include/asm/unwind*.h
