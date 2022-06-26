Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EFA55B0B5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiFZJL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiFZJLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8236012A9A;
        Sun, 26 Jun 2022 02:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 152F461186;
        Sun, 26 Jun 2022 09:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1872C341CA;
        Sun, 26 Jun 2022 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656234670;
        bh=ApZQkTVnenerWztaVmFVFWCkGX5enE8Jokt4QEoiyq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CG5qn3kuWwHakJqS7RKOcK9W9tkz/kqcpovCIwIpcUS7fS3T16YFXxsIk1rxPRN3+
         4D24IyKnmupH1+QnzGjxbH07Z9ySDqhpiU9s+t8tUOz1w60dx14WbOOo322o/WqFFM
         MCQerz1q2YhcWfBfyP+tGg0123M4NiTooYb6ygW5LetOY4FpHYN1PIHxLo36E9cuyW
         sZcLIbaF1Mz0FX3Ms9kkxPHD2LTsEV7IQboWaXR0EOsbIUdrfc+9z8fBOb9aV/sSzF
         J2NzRKaTYBdq+L4lygWJx8tbkG5sJqlSoWbZ2tzF/+5jL6K5Dtwr7Ewf/TKBItq8tT
         OnMX9v8V7UYiQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o5OIO-001cp3-4w;
        Sun, 26 Jun 2022 10:11:08 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v2 15/20] objtool: update objtool.txt references
Date:   Sun, 26 Jun 2022 10:11:01 +0100
Message-Id: <ec285ece6348a5be191aebe45f78d06b3319056b.1656234456.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656234456.git.mchehab@kernel.org>
References: <cover.1656234456.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset a8e35fece49b ("objtool: Update documentation")
renamed: tools/objtool/Documentation/stack-validation.txt
to: tools/objtool/Documentation/objtool.txt.

Update the cross-references accordingly.

Fixes: a8e35fece49b ("objtool: Update documentation")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/

 Documentation/x86/orc-unwinder.rst | 2 +-
 include/linux/objtool.h            | 2 +-
 lib/Kconfig.debug                  | 2 +-
 tools/include/linux/objtool.h      | 2 +-
 tools/objtool/check.c              | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/x86/orc-unwinder.rst b/Documentation/x86/orc-unwinder.rst
index 9a66a88be765..cdb257015bd9 100644
--- a/Documentation/x86/orc-unwinder.rst
+++ b/Documentation/x86/orc-unwinder.rst
@@ -140,7 +140,7 @@ Unwinder implementation details
 
 Objtool generates the ORC data by integrating with the compile-time
 stack metadata validation feature, which is described in detail in
-tools/objtool/Documentation/stack-validation.txt.  After analyzing all
+tools/objtool/Documentation/objtool.txt.  After analyzing all
 the code paths of a .o file, it creates an array of orc_entry structs,
 and a parallel array of instruction addresses associated with those
 structs, and writes them to the .orc_unwind and .orc_unwind_ip sections
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 15b940ec1eac..1c769cddb42a 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -62,7 +62,7 @@ struct unwind_hint {
  * It should only be used in special cases where you're 100% sure it won't
  * affect the reliability of frame pointers and kernel stack traces.
  *
- * For more information, see tools/objtool/Documentation/stack-validation.txt.
+ * For more information, see tools/objtool/Documentation/objtool.txt.
  */
 #define STACK_FRAME_NON_STANDARD(func) \
 	static void __used __section(".discard.func_stack_frame_non_standard") \
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3da5f9acb966..3025347bb433 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -498,7 +498,7 @@ config STACK_VALIDATION
 	  runtime stack traces are more reliable.
 
 	  For more information, see
-	  tools/objtool/Documentation/stack-validation.txt.
+	  tools/objtool/Documentation/objtool.txt.
 
 config NOINSTR_VALIDATION
 	bool
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 15b940ec1eac..1c769cddb42a 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -62,7 +62,7 @@ struct unwind_hint {
  * It should only be used in special cases where you're 100% sure it won't
  * affect the reliability of frame pointers and kernel stack traces.
  *
- * For more information, see tools/objtool/Documentation/stack-validation.txt.
+ * For more information, see tools/objtool/Documentation/objtool.txt.
  */
 #define STACK_FRAME_NON_STANDARD(func) \
 	static void __used __section(".discard.func_stack_frame_non_standard") \
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 864bb9dd3584..970844ceecdc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3190,7 +3190,7 @@ static struct instruction *next_insn_to_validate(struct objtool_file *file,
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
  * each instruction and validate all the rules described in
- * tools/objtool/Documentation/stack-validation.txt.
+ * tools/objtool/Documentation/objtool.txt.
  */
 static int validate_branch(struct objtool_file *file, struct symbol *func,
 			   struct instruction *insn, struct insn_state state)
-- 
2.36.1

