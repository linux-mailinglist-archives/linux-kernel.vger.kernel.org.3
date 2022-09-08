Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775B95B28D5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiIHV5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiIHV4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:56:48 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AF212C4AC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:55:55 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 136-20020a63008e000000b0042d707c94fbso9720933pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=vm5veKXR+O2rRgDax5LpSkLTaTy6Og98Noar0uvmDBg=;
        b=ZH4pBF7GcHnWh2rdS1M78dhaZ11K8L+Sgzed6KJoRLi3j8jXB817lSxBYasnKxh35l
         ZgnZlL9KZKdVv/EEmU4Tr+fZQkPdIzGmxpc5X5xhaFXzDlmMeZThq26jacwbWTgmbIt+
         mEOWKEGQf60wrEwM3JZDw9Jzp39hksE1mVbxmtBIAb5U04hNo0rDQzSQy3qp0ANVY3Nx
         mKwCjtrn4M5SR6N3Ntr0p4SQUb7v7l9CLXjBfW3uSHAXgNiORV7YYLQU3pmYbuhWBylE
         YBOxayLfIlv8bl+W/GJkrVOltIx+Nqz+DUXVpTpgY3U82wYjYp/kQseaYZQPRushhMm5
         TAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=vm5veKXR+O2rRgDax5LpSkLTaTy6Og98Noar0uvmDBg=;
        b=Lb9EPQnAOHQ2NwsWpGV7/hzsbEyRz+2V8DPWNKd+RnI0KBHaPbpuSu/Q1dvTtx2O2X
         sg61F8ty45y3iu38aw4RA9iplp0WNXKlQ+TVPaf0UpkdcScT6o2xnyBZTZQPvVRPMbbp
         UB7VYVc5D4VXzHsiyuChSm0M8Lh2o8NrFa3s24aF1zHensx2lF+r8jE20dN/MFcPmQDw
         oFOMsptrY5QcWERJ55kKXe4r1E3WuHKjuaJ05MOBVfsSLcUnWd14H5SeGsNAeLYV+i9G
         kjkpzm33YuF5o0OaooALRVK0aSUTzW6+zhhN4qRn+95gdaG+HVycwIAgH30kkjKkrbMO
         Ue6w==
X-Gm-Message-State: ACgBeo13uQtYyIv602IOxaloud4PBQ0/MQuM1XbXBvnKprviET6CNvXB
        N1IqoWKEzD2omP3Ln6/THIQvBxvF5U9H3MXIwE2FVv+XgHtu/2K/xHv3pX3NROV9Xm7hZ9a3PNe
        lRXhsHmow2YubgRT1348tmo6jyVgm6Rh5qUq+BpD+iUCaeYrnpduet7nnLcZeXJU/K0p3zTUtDf
        rXjcoYPmU8Cg==
X-Google-Smtp-Source: AA6agR5WnOKxTdr/25i3BNZh8IUmQ/bEKkkDvPQH35RzmIpWPpUdr+e8HDfZfjjiwD8/thKx3eVCYIJ3WfNg33P35jo=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a05:6a00:1390:b0:540:b6b6:e978 with
 SMTP id t16-20020a056a00139000b00540b6b6e978mr3321390pfg.8.1662674154442;
 Thu, 08 Sep 2022 14:55:54 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:55:00 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-19-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418; i=samitolvanen@google.com;
 h=from:subject; bh=9OoxBGSeValXYdhbTF14Jfw3MpaGMV549rycOq8LEaw=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS2qkSmjV+l0koJEkW3Ra86NWCQbdAoQUKsCsKu
 US5kAIeJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktgAKCRBMtfaEi7xW7pPDDA
 Cn2pbnV5bcnzoGc8JddgQnV8D4DQRGk/vp6Uu/MGcpttE+hmRYXGnxPteqSuac3HNTSxdxiMaQbfi4
 tBYcvtA6mZVp5tIWr3/aPPuCXplinZdK/00vI41ck/OgxL6dJAJOalxRJzlbGGoQcXuHN2qEF0xHTr
 /m3yfieyINfDIDo4hlAU5NQcvyjTWGcpk1tkvYoRl3NFUC5Tcu91qUajnAkFemmoRTlvav6BDdgLve
 6I7D1tpAsuiRpM7MiIB9WdPztgJcnq3wGcE5+hlQyM3NNPYVKNJRkBwUyTGRzbOQ5MNHbAUE/uYTuZ
 UXkp9zyheMNGsyjM8WiRweAG84GbTPpJfv2qdX2QzOuq8OeMyHCx3/gNnAHfS3cz+ZwsyKBUTB95XM
 /xIO9SBobBIFVshdiOGryKwpvtyHrmgoTm36g2d0vRyq+zF59jNJhd4zf6kaJcYjXsGyh4SAyVxQtH
 4CwhKkIc22A/byAV/q1kus+z4aFPKT0NFo0RM2dCxr0y4=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 18/22] kallsyms: Drop CONFIG_CFI_CLANG workarounds
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

With -fsanitize=kcfi, the compiler no longer renames static
functions with CONFIG_CFI_CLANG + ThinLTO. Drop the code that cleans
up the ThinLTO hash from the function names.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 kernel/kallsyms.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 3e7e2c2ad2f7..b27e6ea31f8b 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -159,7 +159,6 @@ static bool cleanup_symbol_name(char *s)
 	 * character in an identifier in C. Suffixes observed:
 	 * - foo.llvm.[0-9a-f]+
 	 * - foo.[0-9a-f]+
-	 * - foo.[0-9a-f]+.cfi_jt
 	 */
 	res = strchr(s, '.');
 	if (res) {
@@ -167,22 +166,6 @@ static bool cleanup_symbol_name(char *s)
 		return true;
 	}
 
-	if (!IS_ENABLED(CONFIG_CFI_CLANG) ||
-	    !IS_ENABLED(CONFIG_LTO_CLANG_THIN) ||
-	    CONFIG_CLANG_VERSION >= 130000)
-		return false;
-
-	/*
-	 * Prior to LLVM 13, the following suffixes were observed when thinLTO
-	 * and CFI are both enabled:
-	 * - foo$[0-9]+
-	 */
-	res = strrchr(s, '$');
-	if (res) {
-		*res = '\0';
-		return true;
-	}
-
 	return false;
 }
 
-- 
2.37.2.789.g6183377224-goog

