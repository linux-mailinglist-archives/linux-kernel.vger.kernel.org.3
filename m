Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F5F50B551
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446701AbiDVKib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446678AbiDVKhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:37:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791A3E1D;
        Fri, 22 Apr 2022 03:35:00 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:34:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ixAqwzpengXwD5KICKFjJKuIpmCrhvRlPXj+034fpNk=;
        b=2wZu5j4nSnVwp+jhHPVGIjMJhpcTH5VjJ6ayStKFVokznEMwE5BDyFX78UmiZd+3dlBgrV
        yalNFNcrP1hUrz1WGn/yuJRjf54vQw/Dag1c7WUmB8LfsZTJbWqWVTF5x8EtS0nEJlZoto
        0XF26dDePiflJC+LEbXdKmp5OnAscgaxGA1y0qwp54weEtWJwV+jSfqypJk7CxYfE2L1yK
        2AYZN1YE1vp8/uOGksjF8QD5fgyRD+qRc+G3ESzdJvDFLqIYM5SvJ1JNyaVfdXIyJqpKBU
        BkmQg1VJjWJX8/vL00yNxfm3EarksfLxttmpb2lyrvdKdr/cUl9jzkYwVcMxqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ixAqwzpengXwD5KICKFjJKuIpmCrhvRlPXj+034fpNk=;
        b=VaWWbS3T7MylzXJBezgLZEQnGnv3oDVh3ErPc0O5CkQiqsC1GRIPVwtcBOQrY+VU4LhTqO
        FQ4DjCTW7aVjfGCQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Rename "VMLINUX_VALIDATION" ->
 "NOINSTR_VALIDATION"
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <173f07e2d6d1afc0874aed975a61783207c6a531.1650300597.git.jpoimboe@redhat.com>
References: <173f07e2d6d1afc0874aed975a61783207c6a531.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062369811.4207.16811054707894288843.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     0f620cefd7753175b6258fed85f76c2014ec3799
Gitweb:        https://git.kernel.org/tip/0f620cefd7753175b6258fed85f76c2014ec3799
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:04 +02:00

objtool: Rename "VMLINUX_VALIDATION" -> "NOINSTR_VALIDATION"

CONFIG_VMLINUX_VALIDATION is just the validation of the "noinstr" rules.
That name is a misnomer, because now objtool actually does vmlinux
validation for other reasons.

Rename CONFIG_VMLINUX_VALIDATION to CONFIG_NOINSTR_VALIDATION.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/173f07e2d6d1afc0874aed975a61783207c6a531.1650300597.git.jpoimboe@redhat.com
---
 include/linux/instrumentation.h | 6 +++---
 lib/Kconfig.debug               | 2 +-
 scripts/link-vmlinux.sh         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
index 9111a37..bc7babe 100644
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -2,7 +2,7 @@
 #ifndef __LINUX_INSTRUMENTATION_H
 #define __LINUX_INSTRUMENTATION_H
 
-#ifdef CONFIG_VMLINUX_VALIDATION
+#ifdef CONFIG_NOINSTR_VALIDATION
 
 #include <linux/stringify.h>
 
@@ -53,9 +53,9 @@
 		     ".popsection\n\t" : : "i" (c));			\
 })
 #define instrumentation_end() __instrumentation_end(__COUNTER__)
-#else /* !CONFIG_VMLINUX_VALIDATION */
+#else /* !CONFIG_NOINSTR_VALIDATION */
 # define instrumentation_begin()	do { } while(0)
 # define instrumentation_end()		do { } while(0)
-#endif /* CONFIG_VMLINUX_VALIDATION */
+#endif /* CONFIG_NOINSTR_VALIDATION */
 
 #endif /* __LINUX_INSTRUMENTATION_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7d2bbc3..73359d6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -500,7 +500,7 @@ config STACK_VALIDATION
 	  For more information, see
 	  tools/objtool/Documentation/stack-validation.txt.
 
-config VMLINUX_VALIDATION
+config NOINSTR_VALIDATION
 	bool
 	depends on HAVE_OBJTOOL && DEBUG_ENTRY
 	select OBJTOOL
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 90c9c4c..fce4f41 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -160,7 +160,7 @@ objtool_link()
 		objtoolopt="${objtoolopt} --lto"
 	fi
 
-	if is_enabled CONFIG_VMLINUX_VALIDATION; then
+	if is_enabled CONFIG_NOINSTR_VALIDATION; then
 		objtoolopt="${objtoolopt} --noinstr"
 	fi
 
