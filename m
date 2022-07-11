Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E5F56D3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 06:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiGKEPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 00:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKEPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:15:45 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29143186D2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 21:15:43 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 26B4DEo2018381;
        Mon, 11 Jul 2022 13:13:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 26B4DEo2018381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657512796;
        bh=vmX1TC8ghk+PT+J3sj3bSAW/EXY5N/4tuqRl5sau7A8=;
        h=From:To:Cc:Subject:Date:From;
        b=wSpV+zS3BNvT9eILdgxeZwNZEsbNKj2YqU5O4MFo5HtKNxL1aWkWn0o5WxpELiKeW
         DUXtBoJPlFyGBumxTI1vhWLALhgG7ksjmqvm1Oj3b9b6UpPrJt8I7W+4ElkoCyyrSu
         SBrhXj02KJlu2Pb5JIQMWKIZID67Lj9hIWJxMAIrDhgVNdWU6yjE0MLTBmxNPgD3pF
         80lJZlfNCF4yNdHseJx8HJ3oBr7NTaovcnKqISbSKYMMBh4dqB6uuYhGuRo9s90SA0
         lqUZENX7mDuiM23ANBHOekU92g+h2KZmwLY/Qf4Dyj7jW4RkXLSyrIl0K9JKes7De2
         F1jtEKBZr9eYw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Roth <michael.roth@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] x86/build: remove unused OBJECT_FILES_NON_STANDARD_test_nx.o
Date:   Mon, 11 Jul 2022 13:12:47 +0900
Message-Id: <20220711041247.119357-1-masahiroy@kernel.org>
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

I sent the same patch in April:
https://lore.kernel.org/all/CAK7LNATRH4sHYrZk556Sjo4nP=S3qD170OMCZ21n0TEz7gyDUw@mail.gmail.com/

It did not make into the mainline.
I pinged the X86 maintainers, but none of them responded.



 arch/x86/kernel/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 4c8b6ae802ac..a20a5ebfacd7 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -34,8 +34,6 @@ KASAN_SANITIZE_sev.o					:= n
 # by several compilation units. To be safe, disable all instrumentation.
 KCSAN_SANITIZE := n
 
-OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
-
 # If instrumentation of this dir is enabled, boot hangs during first second.
 # Probably could be more selective here, but note that files related to irqs,
 # boot, dumpstack/stacktrace, etc are either non-interesting or can lead to
-- 
2.32.0

