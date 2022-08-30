Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D275A71E6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiH3Xdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiH3Xct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:32:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DF774DC5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s15-20020a5b044f000000b00680c4eb89f1so869069ybp.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=saKNbXZ+fTVa0JCRlEDSkii0PaJZv4EakgrTZQbxYqs=;
        b=XD92pfvmT5UHG/QrlG3x9hvk0uRfqb5LlQMcyxwpxG4Wvm3LMrD9fBN4uRw0cmd3JZ
         rQk27V3ud6PA9klM89vVveRJNcYRNPoK7Smg/GRjHzNs/qpH/lsfOue6qoG0E0W5XAbS
         LCVsvBBxhKptrcXE6zTxH2Kf84TnwhrfYIDVjUuW6MFXkh+8IGAFDG7Lv0amG9+3O5u9
         NVHPeZM5EZcwXMZOdETU513PilVsaSsHeHh1ncLczWvvfxqefmwikXbsa0jLUPtuklss
         vGdKBOFJndYV593TOqZikma2MqAvRxnESnGVJQPpfozUl9huam1HsjXgxZyh3MRsMjBe
         UxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=saKNbXZ+fTVa0JCRlEDSkii0PaJZv4EakgrTZQbxYqs=;
        b=yjww8G+u6j15a2qnYcTVma9yz8/zNISMTDrDqmXKXVP5KU2HJOtNqA5egodnd89mbI
         w6Hu+ehNOo1T2+Ncd9quOod74UjZYcZr3YUXwNNmUl+IFmTizpugolytrIn6gii8sSqW
         pD8REXHNW53OeSiN5WuKR+0dUxR7byfhYeCA0V/v1wYXo+lQJWDsaMlKG2zjBa3LLYAE
         sVjZzmr1rs+41V//3190l5cGQhh4ImzULvhbCPXIFc1jJauprSLL9nV58j7jS4J1xiJg
         RlxMbGPw2wJQXx9tVnTuuJAkQZ9tFyPyJB7PwwqAN8xHx6iJhdV44Q3P4tDs+NipcZL+
         P2uw==
X-Gm-Message-State: ACgBeo2Z/VL8AjKD678Te+8bRdnnyJuXbsq6Bt2HAooglk+gQNCuqrbf
        Cs3D3Id2Df/O0gYBBrg6guhsMQXGGp+JP9NKnhpF/kskNsEYzmGN8edpUNjpYboWzooU/LCvZDW
        mCUflSkifNDzJZWW3bzL6kHKlLIq5dk2UO445Q954l4fI6UVFETgcWb3+nmMxiva7B/52nmcpHd
        CgvJudOg2r9A==
X-Google-Smtp-Source: AA6agR6xEQ5EyMbo66xRDA8vDW84e9YQyrHtWQROUp4QlR4E9NAmiWv98pKaF1InZnqVuSE2D/OjJElxp+jjP0RZeUM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a0d:cb0a:0:b0:337:1dbc:4c21 with SMTP
 id n10-20020a0dcb0a000000b003371dbc4c21mr16082798ywd.297.1661902331345; Tue,
 30 Aug 2022 16:32:11 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:22 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2540; i=samitolvanen@google.com;
 h=from:subject; bh=47sy+JmGHjJvxG1HdOlerjFJI0LNv5ITm57Sshi6/KQ=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3OJuw0Lbmu9DwQiB41MJWv7pYFcmThxoyhKmDF
 NnpHdLuJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzgAKCRBMtfaEi7xW7jjTC/
 9XfHgdD1uKnJRuMbjXkORu2FVPpFXBG9howb+XjW5cmmpsWsNswLD9oHgViYcRhjWfDHHYgZP4EiGe
 exmmrQD/bheC7yEI76RUsyoKy7XIrIslXoDfK0tk3+pAJfxHy9yH+PXmqpiRgcW9CkutyukbhRqjZe
 aSLk9lpH0fEfgJjVQdmyjRS5YchkeuDU7qX8EMlwEVLIJxw/x+T8iSHWSIAISM/oG9zZMiYY7i9hCb
 bR0reU9bLkR69p4txll9OqqyyUyiGiLVdosVn48XtYoIEz7TZD6BN19C9xs4Y0CLFNGm5v0SxdH2wj
 oLjogYcicWo3Z9EuIianekHBQKoGpsBcsb6vbar2WcSCxG6wYSI/cXWhiGp9G/ryiIUDMtdP6pl1rS
 Y0NjFq7PgfDgWWNCzrREiqHzewWSIkMozSXjAoVf21npOgOLsXp6YtqNGh3XdNOpi52ZGaNR/+VTIZ
 xGyGb1/j/VcMvuAloU0xVvqPRyjHv8kDkr7ydi/mDSyDo=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 14/21] treewide: Drop WARN_ON_FUNCTION_MISMATCH
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

CONFIG_CFI_CLANG no longer breaks cross-module function address
equality, which makes WARN_ON_FUNCTION_MISMATCH unnecessary. Remove
the definition and switch back to WARN_ON_ONCE.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/bug.h | 16 ----------------
 kernel/kthread.c          |  3 +--
 kernel/workqueue.c        |  2 +-
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index ba1f860af38b..4050b191e1a9 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -220,22 +220,6 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 # define WARN_ON_SMP(x)			({0;})
 #endif
 
-/*
- * WARN_ON_FUNCTION_MISMATCH() warns if a value doesn't match a
- * function address, and can be useful for catching issues with
- * callback functions, for example.
- *
- * With CONFIG_CFI_CLANG, the warning is disabled because the
- * compiler replaces function addresses taken in C code with
- * local jump table addresses, which breaks cross-module function
- * address equality.
- */
-#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_MODULES)
-# define WARN_ON_FUNCTION_MISMATCH(x, fn) ({ 0; })
-#else
-# define WARN_ON_FUNCTION_MISMATCH(x, fn) WARN_ON_ONCE((x) != (fn))
-#endif
-
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3c677918d8f2..28a6b7ab4a0f 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1050,8 +1050,7 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
 	struct timer_list *timer = &dwork->timer;
 	struct kthread_work *work = &dwork->work;
 
-	WARN_ON_FUNCTION_MISMATCH(timer->function,
-				  kthread_delayed_work_timer_fn);
+	WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn);
 
 	/*
 	 * If @delay is 0, queue @dwork->work immediately.  This is for
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index aeea9731ef80..16df315d2a3d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1651,7 +1651,7 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	struct work_struct *work = &dwork->work;
 
 	WARN_ON_ONCE(!wq);
-	WARN_ON_FUNCTION_MISMATCH(timer->function, delayed_work_timer_fn);
+	WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
 	WARN_ON_ONCE(timer_pending(timer));
 	WARN_ON_ONCE(!list_empty(&work->entry));
 
-- 
2.37.2.672.g94769d06f0-goog

