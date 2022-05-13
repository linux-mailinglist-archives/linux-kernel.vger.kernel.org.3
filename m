Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D22526B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384237AbiEMUXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384230AbiEMUWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:22:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68240179940
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f4dee8688cso80603367b3.16
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CUpp+eY1h6QavnLplUi4X+6IJ2Hw5l406MyPGXj9jyo=;
        b=NJZvNrKMHoHE07itMseh//QkW1oZVG1hCm5Y34ki8iVp32X/fIOIG4pQrp41GoNIh4
         4/vt1vqzEx1K7q8Je1+0mPg3QA9/Qy4ZitgvgWB49MQowYMC/cH9uxBIK5vAGqnAJXir
         ekRUxDpRjm8KyFj/cpyFJMcXI+ruO3K/yT4m+65BqWW9aWkxjK1EdSTA53QBrbcyXoNS
         kYAR4exBZhq7ge6oYG/Z6cHSKt7QKR+Doiv7NpqSnEwN9RmcMp8+U5jwfKld3dm3Ueuc
         m1oIjVLfuTjqn3YAQkcR4uVX8iEvvpOKWA5v+AX8LB6GAGLFkF96bW8ARNw1LRoAUfEV
         xF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CUpp+eY1h6QavnLplUi4X+6IJ2Hw5l406MyPGXj9jyo=;
        b=luH5iUnQcd4mZLF1ChNPr4WWur6UG6W/1g4BFzDD2EWABL/ft6xg2qCkuDP7Ngq/Ly
         QTd4t8MC6DMs6G2MiS0oHO+iDJfMV9CSVBKqM0d3jFmt+/klx43XNB/X/32hT+ywfPtm
         Q/CHfrNpnBEQhuPS56/uqSdYCQ7UjW+vsgtCg5k6Za6tDTJdbYq87MlrWBctMbjBwU4/
         bH2Ha7DyzC0kcSL11o4KuWNZIMvTLyENnXZuynE3Agw6pu3EFTvjjVWh1nrf873sWqHB
         t/qTpiUEbb5Ku4P1EHR14DJxtaptUcB3cvVN5cRe8Pchwx2vkHsOIkaY5e+ZAZHvzSSc
         HxCg==
X-Gm-Message-State: AOAM532J7A+ZSavABknoy0Tw45kusSIgxXykd5QxZuP+P5z3NKAtYfMH
        evFSI6DoXdo5EYxdBe4+7xSbZKgFNUO4+t7Eo/DmXjP6C1uHnGOt95xad1LmscOiNJ8ITFQ8ilz
        UrJkgvqHdsjNh8e12X2dD+KgMf1Egj2bGzhjoWSRzP3gXc/oP8ioSdDqoTDEuT/Us/Zmy/+3YrM
        HhSPQnVW/8Qg==
X-Google-Smtp-Source: ABdhPJz5wAuQU3zhvCRsK12hFWDISmsLfDtjrTPNI5RGXLBRze46095reNUl3lvy/7ZwI2ttc/rbo/qNH7jP9MYfta4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a25:595:0:b0:648:dd02:7e51 with SMTP
 id 143-20020a250595000000b00648dd027e51mr6808309ybf.486.1652473356577; Fri,
 13 May 2022 13:22:36 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:53 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; h=from:subject;
 bh=/4dgPteGbvoZ6Zm9ahP/RnJKty3E0+Ci/Lgu/Bn2E3A=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3lEh9/nV290jJ4ehCHvPJOG78C323NH9UaWJCR
 7UXQDEKJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn695QAKCRBMtfaEi7xW7r1IC/
 95H/s3slv+1ghpDO8U01KIVSGedwc/9NJRp7/HlT/nHaySYRWxxRwR5AqeE42fgrLsMPiozLy0Gfxj
 rcr/Twts4H9ZFBUSI1zYQ2eKUgaBOvevjRwwMWpcW1O0FilrWNF8RIsot8ME7I9MbxjJrnOG+pHJfT
 NNyxQDi02C4LNomTPzVRftAmOwfSpPyodElQFeBS5iWwA3B0AiUhkh8E6mBsXlJDAtHQamg7yXPD5U
 EGcfAHyyTA/JVuvdvSJagxtTXU9AMwHPt4D9hltcduns8G8fsw8PbvIhCtYyN2+fBE5oNs5y8ZEGkY
 fy7lP7nBp/SfFw/JgNztUkvbE5Qk5zuC6DzVZwU6jIhMAYwyNs5FgeY1k7KCuSwHBPTrCyHxMjO35Z
 65OmbzeZnKrCpwJNuLuoXnPZi6zFP7iUkZI0QJl8XSDLul8rQvLdrgPRrEnuJU2U4qxS2/n//iyqIy
 c0HZsESX2A63vEHvQWQsl/o6WsSYKsYPwxnyLskmJeO/c=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 15/21] objtool: Don't warn about __cfi_ preambles
 falling through
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

The __cfi_ preambles contain valid instructions, which embed KCFI
type information in the following format:

  __cfi_function:
    int3
    int3
    mov <id>, %eax
    int3
    int3
  function:
    ...

While the preambles are STT_FUNC and contain valid instructions,
they are not executed and always fall through. Skip the warning for
them.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/objtool/check.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ca5b74603008..88f005ae6dcc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3311,6 +3311,10 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		next_insn = next_insn_to_validate(file, insn);
 
 		if (func && insn->func && func != insn->func->pfunc) {
+			/* Ignore KCFI type preambles, which always fall through */
+			if (!strncmp(func->name, "__cfi_", 6))
+				return 0;
+
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn->func->name);
 			return 1;
-- 
2.36.0.550.gb090851708-goog

