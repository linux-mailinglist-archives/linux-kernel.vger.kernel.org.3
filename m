Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610ED54704C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350952AbiFJXgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350467AbiFJXfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:35:41 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23AB28D69F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:35 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id d125-20020a636883000000b003db5e24db27so209804pgc.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NcjHS6Suh3OhItEG/2MZtt/0Xj5mN4IWKhqbfh52Rno=;
        b=B6yAU5GEe4pZv/48yh6WLaI6mEXb6q5ek/xHD3FNdQztYNNt1boCQdLPa1Eoj+bFb0
         IcRpSoqgwJeACNDoRbvXik97hjTOzyv6MAX9mnUDXEqkFElRkH/mbVQthzGmVv0VoW5V
         shtnOK+4rpBrCbU/1qxNlqiQ4avMTDXPZlIVe27ivwDSoSZ5/Z5JaL0bIVD4AVFn2s1p
         sZG06EBIRR6jFQ7sHdn7SkltPOKCP9uyEidLrsiFZ+405A0pylIsgI5jzXJ1cCfkTtq8
         CxkV/5qTOb+qnKBdhYYE1CE2cmC7lI7sRQut6bHug9ResZugpE1Kql3uyWJJqVhYd605
         sRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NcjHS6Suh3OhItEG/2MZtt/0Xj5mN4IWKhqbfh52Rno=;
        b=titXRC6U3FzUzdAE/cFzMSDjhPSnMoJ7d7h4bCxYIU/F5r5Dw0xJdxzf/6e4GLfoDA
         zN9HzBEUt4/XE/BctlgudlHOc9eDycLKFa0otlwGahXB5UIKbpnxGu0Kt/eHEPakFfXW
         G2IXdz5jencQIr4qDZJTflikOmSAW/6oZhy0P1zZCRJD3/7WrZ5diVwybUJ+cyryfd4V
         LscYWV0JcOVnkW3D08oOOZRWRp8o9BOgJBIhaBsX/yk10qIVTbYiTgxm5CqmcoFmLdkL
         0Fc/TNAeVNg/LwqC/hk79T6SY/ZtfqNxuDeMgHM5FSuoK31qhrom5+Vi+c3BXOhCWd1+
         ISlg==
X-Gm-Message-State: AOAM531LSSwxFyxyJ0tkDHwjem3rm7XI+8OqAVfQQtyK1JCcjvBrBMKx
        PFfZyFrhLr9WsOZUwstqsConyT2DPOtS363aGDs+Z4gLtq0gpa2syb1HnsJ0IFve9wg2GvNwD5F
        JqZANp70pl4olooLXYvAGg03zqTLkd/FfyDIg8wi2jy9EpfdqXtmMSEmk2CP/NiLYLxKB9PJvlV
        QmkTv3boUu8A==
X-Google-Smtp-Source: ABdhPJxw7oIAK8hGCeVcNE80HM7NhVBaTN+eR2hseQO0/X0b/4Yf1tGUnNUottQiVCVizuJeiQD04X+aq1KSVb7CZow=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a05:6a00:1a01:b0:51c:d4f:c2a7 with
 SMTP id g1-20020a056a001a0100b0051c0d4fc2a7mr31838209pfv.45.1654904134785;
 Fri, 10 Jun 2022 16:35:34 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:35:01 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3850; h=from:subject;
 bh=5ZgbGJz2ZEVaG6LF/2peYBgvNX5g5T9rQB8ZfRmBxaI=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9Ut3swgrYqngHqwtC1wp3RKCDV4QKgDfNVLYTiJ
 6dF63+OJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLQAKCRBMtfaEi7xW7qYDC/
 4uoZDVEdEW9ia3dPSZOELy1obJP3wjydRD7Jb2lRl1j9YRC2vDbdRegiY/dAhKBUZJIhMFxhi7Ucda
 KBRlntq1sn5muM0HQLQW+2VQgGVUy6eswi1cnBJhF5weOCA5Yq8JqmkzpXMwmDQ15lHhdhWygirOmo
 YoyTdzn+9slce2r9w2kr8H7tKHOPpmByY8iM3OzE+cVOW9MTkuNi95Nzrccd8sFj2MDWuqGOfStQVv
 Rucb8+Vw6DbdPiJsNzUi4iTPWKMGooEKDKoO40U7zAARl068qUIzJNawJ2xy4ljp+UtBszmuNETnQD
 T0ouk5BQa4iYf7b1d4cbdz19cbiD6tkWIB8qleILbqaLLwWo/Qy2osauXT85QiQLludzGxtOVgotdy
 WF/4UkWdBS756ZuBpa1lLxpYbC2IVBSAtVs0C8isRpIIUnIl6TuTi4N4f0HRZbiuuluaWnw9wFxsqA
 iUejEfd5Gi6gRpLlSxdqzBG0a1c1VsXlwbq5mZ1fkSado=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 08/20] arm64: Add types to indirect called assembly functions
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_CFI_CLANG, assembly functions indirectly called from C
code must be annotated with type identifiers to pass CFI checking. Use
SYM_TYPED_FUNC_START for the indirectly called functions.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/crypto/ghash-ce-core.S | 5 +++--
 arch/arm64/crypto/sm3-ce-core.S   | 3 ++-
 arch/arm64/kernel/cpu-reset.S     | 5 +++--
 arch/arm64/mm/proc.S              | 5 +++--
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/crypto/ghash-ce-core.S b/arch/arm64/crypto/ghash-ce-core.S
index 7868330dd54e..ebe5558929b7 100644
--- a/arch/arm64/crypto/ghash-ce-core.S
+++ b/arch/arm64/crypto/ghash-ce-core.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/assembler.h>
 
 	SHASH		.req	v0
@@ -350,11 +351,11 @@ CPU_LE(	rev64		T1.16b, T1.16b	)
 	 * void pmull_ghash_update(int blocks, u64 dg[], const char *src,
 	 *			   struct ghash_key const *k, const char *head)
 	 */
-SYM_FUNC_START(pmull_ghash_update_p64)
+SYM_TYPED_FUNC_START(pmull_ghash_update_p64)
 	__pmull_ghash	p64
 SYM_FUNC_END(pmull_ghash_update_p64)
 
-SYM_FUNC_START(pmull_ghash_update_p8)
+SYM_TYPED_FUNC_START(pmull_ghash_update_p8)
 	__pmull_ghash	p8
 SYM_FUNC_END(pmull_ghash_update_p8)
 
diff --git a/arch/arm64/crypto/sm3-ce-core.S b/arch/arm64/crypto/sm3-ce-core.S
index ef97d3187cb7..ca70cfacd0d0 100644
--- a/arch/arm64/crypto/sm3-ce-core.S
+++ b/arch/arm64/crypto/sm3-ce-core.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/assembler.h>
 
 	.irp		b, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
@@ -73,7 +74,7 @@
 	 *                       int blocks)
 	 */
 	.text
-SYM_FUNC_START(sm3_ce_transform)
+SYM_TYPED_FUNC_START(sm3_ce_transform)
 	/* load state */
 	ld1		{v8.4s-v9.4s}, [x0]
 	rev64		v8.4s, v8.4s
diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 48a8af97faa9..6b752fe89745 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -8,6 +8,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/assembler.h>
 #include <asm/sysreg.h>
 #include <asm/virt.h>
@@ -28,7 +29,7 @@
  * branch to what would be the reset vector. It must be executed with the
  * flat identity mapping.
  */
-SYM_CODE_START(cpu_soft_restart)
+SYM_TYPED_FUNC_START(cpu_soft_restart)
 	mov_q	x12, INIT_SCTLR_EL1_MMU_OFF
 	pre_disable_mmu_workaround
 	/*
@@ -47,6 +48,6 @@ SYM_CODE_START(cpu_soft_restart)
 	mov	x1, x3				// arg1
 	mov	x2, x4				// arg2
 	br	x8
-SYM_CODE_END(cpu_soft_restart)
+SYM_FUNC_END(cpu_soft_restart)
 
 .popsection
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 50bbed947bec..dfa715315551 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/linkage.h>
 #include <linux/pgtable.h>
+#include <linux/cfi_types.h>
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/asm_pointer_auth.h>
@@ -184,7 +185,7 @@ SYM_FUNC_END(cpu_do_resume)
  * This is the low-level counterpart to cpu_replace_ttbr1, and should not be
  * called by anything else. It can only be executed from a TTBR0 mapping.
  */
-SYM_FUNC_START(idmap_cpu_replace_ttbr1)
+SYM_TYPED_FUNC_START(idmap_cpu_replace_ttbr1)
 	save_and_disable_daif flags=x2
 
 	__idmap_cpu_set_reserved_ttbr1 x1, x3
@@ -224,7 +225,7 @@ SYM_FUNC_END(idmap_cpu_replace_ttbr1)
  */
 __idmap_kpti_flag:
 	.long	1
-SYM_FUNC_START(idmap_kpti_install_ng_mappings)
+SYM_TYPED_FUNC_START(idmap_kpti_install_ng_mappings)
 	cpu		.req	w0
 	num_cpus	.req	w1
 	swapper_pa	.req	x2
-- 
2.36.1.476.g0c4daa206d-goog

