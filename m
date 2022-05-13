Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5534D526B34
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384178AbiEMUXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384232AbiEMUWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:22:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7AD179C01
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d7eaa730d9so81526407b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3UaFU5xHj03sZsROlsGwfgYzXTeZAfKKB9B52UkHPts=;
        b=eCcXC8IEU4TE1wUZ9lhaNpCA7Z0h4DyMFY/4H5NAaxQsccUwtk8sjePd+x1NbczBs6
         Ox0P0++T7xXz5z8piJI/aM8tT+OeVA8J6bK2UToqho+Fc+Jf0lOSPvXV6TI4oxl76/45
         VD8MFSCK2J1gh7JhBYsOT8o7NGx4Dq5IWxRlcHwu1CzJOD2h09EjVCJnALkxcaud//td
         oKVpNJ15xxQ7Pw9VU1AfCY+U/VH0XOP1vOZXa4Tp/ktS5ehYSnGnGIW18Kvuu3tBr4ts
         LVkqDmg5dihnZSeWav46yeycpyXIgsAeDPyLDpaaOHDjpqxXJsukVeHoZb2bUIv6D4vd
         qCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3UaFU5xHj03sZsROlsGwfgYzXTeZAfKKB9B52UkHPts=;
        b=0nd9I39eqC8rH+P89I1e6z8wViRw0rcXlQQjdXDs42NvXx6AlYQscbAjcEedslAWI9
         WSTQV2njcX4wG2tDyPsegjXOAKwTSJ11x0cOWxVTZk8sskgqb/KLXMIwK54z5c6+eJfV
         WSYeerlhIjjl8Z3QdB9T8QO7oJfrI0qmnN3qE/G5ocq5kKF0dGS4BxbldLiJJREsZUSN
         xdAGuL2tUdA5TpAVx3LzyaxOOlEyE5MhRQ4hceAG/vdWIQu+es8WW+aoe2z6L6rjUZx2
         E2ncSTdzLniw85eLFR2lJWZg2ZneSzJjApIJeh/7C2Wruvjmc5dwHQrBGP7gYRo8eSVX
         zdQA==
X-Gm-Message-State: AOAM531WA91xlJZRUaxuWxTMOV5qSitHjxDOGwdlkq3I3N9YgGxCUKA2
        xP9IcRrWP9ovJE1WtH/t8OQI+W/LpqkqI2hr72KKdJ29baUTjTvoOEoM7RMlsv6E/hZvavpaOXk
        Z6Iu6JmkTR8QzaI83L3+pTof/Kj3+/rYruikBMX1MvAUdnHRaX88ZfGfKUV4YuC0uGYg5GAiFJx
        JsMfgbGRbgLQ==
X-Google-Smtp-Source: ABdhPJy/Xry+6o5/aZvCnAuWwOtasUz4noL3K26Hbe2/oGf4osiyUIQJ54ZDIZxyv42DhCx7eptfqF9TiwS8lip9gso=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a25:7243:0:b0:649:1be0:5061 with SMTP
 id n64-20020a257243000000b006491be05061mr6561779ybc.597.1652473359022; Fri,
 13 May 2022 13:22:39 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:54 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=641; h=from:subject;
 bh=BSMde0wfILoH9GAgh/AL2A0KfpejGhMH1EXBp0R87bA=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3lS6DgGrgcdlTr4VdqCp+hJ4gok3CvQfxUBLVW
 A6LaMPeJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn695QAKCRBMtfaEi7xW7gXFDA
 CHg4xEbmMadZBDqHqq0UEmifRbgTU4jfyD/g+/XScylIqJWRNr8acWg1Ez0oZ0wjApncrd0VTGbZOG
 N/N8qRTqHOujf3tWPFlD/3WoW4YHoqB79n1ZD01+aEGVLL5f5SV879mjfR/bQOxEJ2E98v+sgkOGlC
 c+zxC3gNrduPHvIGuK5jSsQ+g5DW+VP51Lw6g+FQgNRZQjtROp9VfPIFXTyQe8MqbHvDkX/ZFXNAu8
 aKQvmfyrQSv32nXwOhRyUvBsq7YMNpEw5tdud1hVmJNg/0dGh2eY/AGjMa5JVsnVN4QbBLvgGhGqT9
 camb6c2XcHf9mWoHSlfEG4e81gGiWkWMbkASfkHOBZ6EX/Z5HgYtH9N20zS4fMUYg9Di0ChEBrGYGv
 YLM333v24SOGwcOKOyNghGoUDw+juh4Quum23MthHk6uV+Ukmf7hTzsvyE7wy1D37AZGJpzk42FpKe
 72X8bL5jcVLHUzRFwpfIXccSO7+M1E/jMAgXYvXsGlWA4=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 16/21] x86/tools/relocs: Ignore __kcfi_typeid_ relocations
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

Ignore __kcfi_typeid_ symbols. These are compiler-generated constants
that contain CFI type identifiers.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/tools/relocs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e2c5b296120d..2925074b9a58 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -56,6 +56,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"^(xen_irq_disable_direct_reloc$|"
 	"xen_save_fl_direct_reloc$|"
 	"VDSO|"
+	"__kcfi_typeid_|"
 	"__crc_)",
 
 /*
-- 
2.36.0.550.gb090851708-goog

