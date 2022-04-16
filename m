Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB61B5037C2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 19:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiDPRwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 13:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiDPRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 13:52:39 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA93E34
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 10:50:06 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 23GHlWIm010241;
        Sun, 17 Apr 2022 02:47:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 23GHlWIm010241
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650131253;
        bh=MmtjwtCuEj1qKGBoGSATHNrzVUzXA3tNAIgp0P+zNN0=;
        h=From:To:Cc:Subject:Date:From;
        b=YSqIGN04c1empKIaQiXTqky6lQBCPNNOGUw8yXvf58p/lT4sdDIdnit5dyy3R6TEu
         ZowWR6VqzcC6vMXbfA4ftgj6rlA5QZt28XkHhUxNT4ziPDZhlIerc+OjLJUJtcHth7
         mtsBqrjBiTcBgfXnzSgdjZTyjOTUXUvU0zgPFAkrQH1krhf/SJ9cvFNu1b4m3Dq9hF
         IcDiWtkn7jzcjC83Dp00vVGGuwt+7izP+szMcBdWO4uPF8tmvqzTGq7FwB2v2dDCcz
         P7bHXkCrMawxk8B955iCnH0U0HQpD6tERgp0Cy+yYsw4VTijitWwZ7mh7eveFclmcs
         Cwy823jAt2msQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH] x86/build: remove unused OBJECT_FILES_NON_STANDARD_test_nx.o
Date:   Sun, 17 Apr 2022 02:47:10 +0900
Message-Id: <20220416174710.269226-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3ad38ceb2769 ("x86/mm: Remove CONFIG_DEBUG_NX_TEST")
removed arch/x86/kernel/test_nx.c

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/kernel/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index c41ef42adbe8..d8b2a81b3dba 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -34,8 +34,6 @@ KASAN_SANITIZE_sev.o					:= n
 # by several compilation units. To be safe, disable all instrumentation.
 KCSAN_SANITIZE := n
 
-OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
-
 ifdef CONFIG_FRAME_POINTER
 OBJECT_FILES_NON_STANDARD_ftrace_$(BITS).o		:= y
 endif
-- 
2.32.0

