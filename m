Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48FF53E94F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbiFFP1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbiFFPZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDE81CD36D;
        Mon,  6 Jun 2022 08:25:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E41DA61543;
        Mon,  6 Jun 2022 15:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE74C36B0A;
        Mon,  6 Jun 2022 15:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529149;
        bh=DzHfRfTMaClgF8h/YljWNP6KKXvsPbgn8IYgJ+ecyLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dX+T7VFPPiYzevrey6Yv6HxUX0A5+Jn8bgmc2SKEiNoNcGAFI4mXwiMIxx4k0TuZS
         r+/9I7OOWyDfmtatc0tBfwZ3f/WjO48KeqicPQ2Fs3R1Ll21geyT1yDtPik1TsW3oP
         ViYlPW2j3RH3R8eAJ1bl2YeQBc1oiPorFY0Zz4PjmySDhU5qWn4sNai4Ut3LSbVYos
         kZr7eLdjgPWCueKcl+0IylJyBd9ROkukLpIh48/W8b/UXcIsOPcxf5Bnnpm4aJ/I8h
         eVFl1d9Tx+qFQiwN6S9JNbCPfD2jX++K72zYnsm8rn9WTqIqMCx1LzlRw3qdqncs01
         zHizbdCmKssZQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012Q0-Ex;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Latypov <dlatypov@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH 21/23] objtool: update objtool.txt references
Date:   Mon,  6 Jun 2022 16:25:43 +0100
Message-Id: <f076539bc44935710bc85493cb04900314ad9760.1654529011.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654529011.git.mchehab@kernel.org>
References: <cover.1654529011.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

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
index 6491fa8fba6d..6f89471005ee 100644
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
index 2e24db4bff19..79a71eb96111 100644
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
index 6491fa8fba6d..6f89471005ee 100644
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

