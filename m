Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58E75155CE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380983AbiD2UlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380964AbiD2Ukv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:40:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86142852E2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f8d487f575so12167007b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tv2NfEjyfprEjH/WagRqqCH1hQfxPpGMj5Z2HbEgkRA=;
        b=pB+2omq61Q3217AvI0rEZSjmyFqJ9NJ7YuTSaZYQdZKihILOoXitcHp4Aqk4DfNuJC
         Ii1imHx96bqsVsHF4LbRU0itbEjHrNgVdkQ3irES1Ih8mxUshYfbtfCT+TfHZ/oz1dtP
         NY0q6seVOURhumX36uwOxNHojZ45LOr10er9aVaKi/UiJRMGUW9RPY1W/crXdM6e/nzW
         jbvzkhILVLoFfcKOggaouemXiLcCzeXKkf/R9rS3XSJYuy1mUw5kXCtFqCb5OkWHmIae
         AVmKCEcuaeO8akCJpncoE0TcUuvyXfT1iSaAa7lBOHuy3YgYc6i8BTmI6s6WYnCNi+AU
         t24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tv2NfEjyfprEjH/WagRqqCH1hQfxPpGMj5Z2HbEgkRA=;
        b=tsY+/VnMaIgcVG05WmtLEMcRXakOt7tBK3r89MuHtfZY0EvvgxdQIdALDG/9umSJWV
         MEG8v9vkZ3p6pWRWmnQ6zLw/JUM9AMglSN1FmXcl+5g66cCsf3+jVYPrnXWgP6LeQmcn
         76v66IC9r15HQ2e2fhJa0A4U8uSK4EdP/k5AOx1BtvZAiYIK2G+f76DAiRzXIHvOL9Gl
         RoxUkqljb8ECILSqmXWShF6EEmHZdmMgKQqf7jDSm6MdmMkN164qDI2Im9sjB0hJzJWc
         dLrljOUNh8xzyqkVqNOoJ6exw6jkNgDquZT0A2lviiqpWVmgRDWid2cLDdQzfhSl5zjk
         N5yQ==
X-Gm-Message-State: AOAM531REVGNTJApCJnlwFdjJVmQAsVie5ypA0r2IeOgOlbKsjwQHAF7
        2rhzJGiKBFHfAIGN/TNHYJtiPiHRWvA602O4GEwtB1g2oh5s0/CxbtKZAagZkH64EBWtyEuPM67
        FkgxxG6hm1vZrl0B+zVs3l+iaGLggS5Jret5NSzpy0Klf8ojMrBd3X6p2YJUN5D+q/mQT1msobq
        iBzM3FaLXxpg==
X-Google-Smtp-Source: ABdhPJzf8F6MhhQvERk6o6aC905EfQk7qKag0BcoEBBD0uWfioudMPTHJnGQUhT5pwFx9Z28Q9LGUrtznvm+L73jrDw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a81:234b:0:b0:2f8:4082:bbd3 with SMTP
 id j72-20020a81234b000000b002f84082bbd3mr1122079ywj.47.1651264638553; Fri, 29
 Apr 2022 13:37:18 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:36 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; h=from:subject;
 bh=tehRW82jP0RyTtdlRN0VdoftCcUQiAtEwsyBl3tnXQM=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExXrPGtzBdwEr3WsUJMcTa5SnMpMUdhtG1ELjyr
 Yo4vk3yJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVwAKCRBMtfaEi7xW7gG8C/
 4rBi6pp+EX2VhofKNrL5OB4Nbj0tmkbvch9On+rothI5RrjLElKTQ7rJKCbeCMf/fd9MhXmmy30ZDc
 0i6d/nQFbMUJNbP3YvHszFfVozL5oetNY0LKa1tEWLrl1PmBWiMM1Y0hzUx695EFNuB9Z/IgzAWJHc
 VyKoFSgqL/HZvX7mFYcG2EAsOE+icuxIZICSAVt8NfVenhy3oKckN6+QZSZVHFbTE8sAiAE8x4UgZ4
 nSjkqIrcznKGhg5HogEmdwZzCaAcGZxDqdA0V1aaU4kyfLHFp9XZzKmiiUwTYYSWwvCY9Tvo+xL+Vu
 0CTamYHWDP1HUePZ8CB/mw9CsUeTuhu6zkvuMYcG354jmx7ooV+gAhNyCiEi4fKTuxQ5a1mRQuNNRE
 8SsQdB8squmkfEfpsoDlQCt5QaUw4WeUghUIX9vTwT7ISqGIun7rYMiGMRNi2bz7Bl6AT0hPw82Lgr
 VbBurkClkSn9jw/pGy7ura6cWEncKA6ChV3483s2teTmc=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 13/21] cfi: Add the cfi_unchecked macro
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cfi_unchecked macro allows CFI checking to be disabled for a
specific indirect call expression, by passing the expression as an
argument to the macro. For example:

  static void call(void (*f)(void)) {
          cfi_unchecked(f());
  }

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/compiler-clang.h | 2 ++
 include/linux/compiler_types.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index c4ff42859077..0d6a0e7e36dc 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -94,4 +94,6 @@
 #if CONFIG_CFI_CLANG
 /* Disable CFI checking inside a function. */
 #define __nocfi		__attribute__((__no_sanitize__("kcfi")))
+/* Disable CFI checking for the indirect call expression. */
+#define cfi_unchecked(expr)	__builtin_kcfi_call_unchecked(expr)
 #endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index bdd2526af46a..41f547fe9724 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -263,6 +263,10 @@ struct ftrace_likely_data {
 # define __nocfi
 #endif
 
+#ifndef cfi_unchecked
+# define cfi_unchecked(expr)	expr
+#endif
+
 /*
  * Any place that could be marked with the "alloc_size" attribute is also
  * a place to be marked with the "malloc" attribute. Do this as part of the
-- 
2.36.0.464.gb9c8b46e94-goog

