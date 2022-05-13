Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284B2526B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384180AbiEMUXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384236AbiEMUWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:22:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB63179C25
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g26-20020a25b11a000000b0064984a4ffb7so8208163ybj.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nUpPaqC0eYL5Nt1oJAx9xMuIXQVPdTCitfDNswclMOQ=;
        b=NGUyzaEgTOzOQLTvGRKxy+h20499lPJi5/bsMfRsZPY50ZEZqUY00bPfA5hyNxQu4L
         vN8+OSPtEHMBxroLCTwKi1OSx4Vzz3fhx04vGmzP5a0PBrWxie/lCPWbhCj/liIjolRo
         NqTebXuV+en7aRSF+p/b93gOcmPVRpVzC7/GH3X/tKBVpb8qIKWEQT/gKhb+CzKbbYo4
         +kCZheZew6tKW+x89Ktx1lasOXVEVag1VVYCJlE2snyDQ7WQcJEZnsYNaVnJjuzTop5H
         Nl4yioYKQ958oMvcKEMiiZhY/HU3opeNEd5zKqAeoqbQ4OqqG+TCsRg8h1wnkzkZ9mcJ
         9zzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nUpPaqC0eYL5Nt1oJAx9xMuIXQVPdTCitfDNswclMOQ=;
        b=uy3OUmsicMVQJj+dk6wWZCD+z9tkfh6cxlwOZXDLdBOKBM70nOMsddqZqpsuMsa3ZR
         hW7sGm+Y4JnUD+4HO0xXZCk1zvgi5jfPmMoNlZn8kAOlwl8CjPt/H4ZTFcaGQv1stw4P
         Kl3lhCaNhuHFs0kbYNjPe1S3paBnC90W+q4weKwVMqWzBYWWAh3b26uIAj4pSsRYaj9a
         1PSxx1Iy+jRiaMg/VW+rGtbGGPLSeF5fO56D7O94RkxQv46+4mhr+VmdTKTHePXahPqy
         Yucsj6ULx5Y3SW/I6za5MeeNok8CwZ6zRe03d9dXVGwFcI7mytfsazD0P4oYERGQfo9x
         JtUw==
X-Gm-Message-State: AOAM533bKMSdksrfh+V4SZBqdOuh6PetZvhqrSYyeAcBoqnypwyaS9qW
        IPsgObQoSBuNTzBXuXa2ucfCx/DBmgOmE1tmRfj1L54uRA/xg/qNh2rfw6ungK/dMcIgdsPm4ct
        3CXfjBWc4VJlF0P7UBAxZhw2EEgj+rKngCgvvuupWa9/zQY1iJUnAbjZrIL1kovxKOLfhFd8dC9
        LXiYX37KluBQ==
X-Google-Smtp-Source: ABdhPJym3cBdFsDpIM2tmSGXzSDbcw5wm3NKeWj4wDNkpC1RXx4qZwbZndlBzE2vMNk03H9K3mFgotzJMVnS9Ymc5Zo=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:526:b0:648:506b:1a0c with
 SMTP id y6-20020a056902052600b00648506b1a0cmr6623042ybs.254.1652473361076;
 Fri, 13 May 2022 13:22:41 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:55 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1843; h=from:subject;
 bh=Tzngjb8MoymH2ioVLVXdJdgOCZQILE66fWSMpHjt6pE=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3lsRq/H1xovX9N/KUFK0NOk3o/nIT8tQQsdWEf
 Ofbm6FyJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn695QAKCRBMtfaEi7xW7sS1C/
 9gij0HCI9i3xZiRVcPO0F8xuDwz3inbEGwbWsTKqlXSy5gWjfweTKMJXIgkYcouSrgbOjhl8nzwPxL
 81nocm/AhRTr3/yte0jvexKghAR3TJlP4Qu3fjMwdAN97zxjt9+LTucDd54iBkvR9iDd23FMge6C7j
 YPIYFUshdjCb3rqxtJyoMrTauMj1hPnhMANlj4WDN13X+Ay16VtB9w0JPAwwAy6A/uB5M3QACY2XJR
 pjpKA3O+1HU1Ojf7QN7z4DR63l/wHh3+xSKudUS0njUm7mZc617Z6n10l2nuxvfVFQVyvlFBS0hDPK
 +kj+tWdbgwuqRgr4/HwxWx0s5ssxvIn4V12RFbkaNEPiI78ESoVO5vyvelqxDjzRlWKId+HB9a6i8D
 92WpY30bsvj+a1djwv5hmFiTsICSpLsIXFCeMZa5lwzBY2u/7GEdUcwnwzqyYUfLIYiqjbhnvExzYD
 95XvQRRTCdT2ULBXckH5XIp+S2pLb8o2bqHbgUcKAJwDs=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 17/21] x86: Add types to indirectly called assembly functions
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_CFI_CLANG, assembly functions indirectly called from C code
must be annotated with type identifiers to pass CFI checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/crypto/blowfish-x86_64-asm_64.S | 5 +++--
 arch/x86/lib/memcpy_64.S                 | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/crypto/blowfish-x86_64-asm_64.S b/arch/x86/crypto/blowfish-x86_64-asm_64.S
index 802d71582689..4a43e072d2d1 100644
--- a/arch/x86/crypto/blowfish-x86_64-asm_64.S
+++ b/arch/x86/crypto/blowfish-x86_64-asm_64.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 
 .file "blowfish-x86_64-asm.S"
 .text
@@ -141,7 +142,7 @@ SYM_FUNC_START(__blowfish_enc_blk)
 	RET;
 SYM_FUNC_END(__blowfish_enc_blk)
 
-SYM_FUNC_START(blowfish_dec_blk)
+SYM_TYPED_FUNC_START(blowfish_dec_blk)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -332,7 +333,7 @@ SYM_FUNC_START(__blowfish_enc_blk_4way)
 	RET;
 SYM_FUNC_END(__blowfish_enc_blk_4way)
 
-SYM_FUNC_START(blowfish_dec_blk_4way)
+SYM_TYPED_FUNC_START(blowfish_dec_blk_4way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index d0d7b9bc6cad..e5d9b299577f 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -2,6 +2,7 @@
 /* Copyright 2002 Andi Kleen */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/errno.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
@@ -27,7 +28,7 @@
  * Output:
  * rax original destination
  */
-SYM_FUNC_START(__memcpy)
+__SYM_TYPED_FUNC_START(__memcpy, memcpy)
 	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memcpy_erms", X86_FEATURE_ERMS
 
-- 
2.36.0.550.gb090851708-goog

