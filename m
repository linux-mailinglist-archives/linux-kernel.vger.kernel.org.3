Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889DC5155DB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381084AbiD2Ul5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380976AbiD2UlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:41:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF05CC535
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f825f8c944so84511767b3.15
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c3P0Hz4r3G9OpLG/quSc8J3HkB5RqmI/gpWW3ubqRHw=;
        b=L3b4tsGo9U6EKhT1enH+lnwRGBAriMT04pxJOWGmkTh/LOTTSEf7+ZnnodamgedxF/
         0cwAbqdA5BTRqaVaWO9cIk3CrgrGdAh+jueAcHfV8Bg8TTAZ+khVx+B8eXyacA4mY4Xx
         K3TQUEqnaXw1lY5l03iwoFMiQRQsJmRAKWpBy5VlbUJzdl8A2l7wvJu19Rol8flqku9I
         WNZ/yUORvsGxlp+SHTywXjv/cQ3+dFZB9Bv+ISu7Xf8nMdBe2LwKPup9v4pkWEFDDPFS
         kaimPMTLgDV3p2dFB9fsB4bsR6Vkc62TMrM/JjgmNdYT0fQUUEBM5oeL8rAQdxi3N/ib
         ZNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c3P0Hz4r3G9OpLG/quSc8J3HkB5RqmI/gpWW3ubqRHw=;
        b=IAVtoSiTHw6IMxW+I3Jh+xWFZF48WyqojAoPDa61ONyo1SUlUOCmtvU+SlL2CwTkn5
         qGacmwF/kYGmrLdvNtZkQaJK1QjjwSrHV+6YZnT7XgfLOWRYm4eD6nX9TOmmrmrZuBUK
         fE9YjoaF4lmqPuOnxF3IC4y11VYR/HgH/HTbEgEp2/7gUZDL9s+A+2ijXrMi6o3n806q
         MeHZ/uVCJBDZfufivhopgA9u7X+9VgbcmxyWdgAeA9UmMEQ7OnDT5j4MaZw3otIYRY8n
         QtfurpzZ7N20bn7m7jz+WT+kzAJxcXcoiCHQNsL4Mpl2kzVV2JU4YGUacwZk3q2eH2EF
         9Cgw==
X-Gm-Message-State: AOAM530yLk31PgJjbKEZIpV3oToPy8JcFzUemNgK1S+LblQWnDdCOLgc
        oDkQDDaxV2UKWxBtzsOgsSnFX4vsZSlY7zMEqJIAOZG+ZsMsdFsTZGFRvA6IsgD+iAqJCJ5nMW+
        tF5D7B9gCGSboAo+YETzLRIItu8cgctFE6TE8FkjuPNfllecxDlgIhklG6Peyug68NgdBKUfULc
        Uri6UKvdlFLA==
X-Google-Smtp-Source: ABdhPJy48Ta9ddvMIF4e+65DRSdxotM1XKnrKu3boCyUAK2XttelwSr/WCmbVBiS9zrXdXlk0V9aV262+2v6W6Pe/+Y=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a81:8493:0:b0:2f7:d7c3:15f8 with SMTP
 id u141-20020a818493000000b002f7d7c315f8mr1216311ywf.196.1651264655480; Fri,
 29 Apr 2022 13:37:35 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:43 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-21-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427; h=from:subject;
 bh=qwzizA85BcxzgY6DCPbuVyLVCg+lMcvwRT1NDXtCdLs=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExYM8ehL1/+o0aCrhRJzqnXsps5M4p21c1LQlC3
 sSVsl4WJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMWAAKCRBMtfaEi7xW7tTEDA
 CIw6jCzNraux3uPsdGgkoAmjqy1E308ymvORumKcO9YZjpCWgxUG+wrt+QoMZR3WsGxUe2zWhOF83/
 GBMcbJoiHwlX4DbEEk02ZUts9xuqk851PS5XPj4XupWl8F+kbRnXqWj7hSkLGOAkDS71i8n4fC9xr0
 6Ez6wHIz/0fvbvzjy2pHl3vX2S1oouofjPnfB6+NNmsyEb/K8pceL8f2CcR6jIzAd/J0QmzZTj76WT
 O4AwX/0ZNLkWjMQpGtuKzzGFHozskjUdwKRyIsCMnHGCm2py2s1oLV/ZY9mk7yD4IoRB3MrC0v0FDM
 Fl8hcWy38RiLdiG2OvGkUee959W0eF+qPDLNNpHfpiSB1J1t43APoJLX+iPYsGLObYHe9DGTllVo0x
 kt56P/u268sda8zQK7JrAuU3qLye5d96mt/FiDL13+rXzBZuloXyNLx7trQLbxVhiAQkGYOvGEGt2D
 lY6u8L5nEHbyCOCMu0kfKXPQzqa6gVH7sa1innsuiCfcA=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 20/21] x86/vdso: Disable CFI
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC_FLAGS_LTO no longer includes CC_FLAGS_CFI, so filter these flags
out as well.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/entry/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 693f8b9031fb..abf41ef0f89e 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -91,7 +91,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -151,6 +151,7 @@ KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_CFI),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
-- 
2.36.0.464.gb9c8b46e94-goog

