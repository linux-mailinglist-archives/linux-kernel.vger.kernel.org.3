Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F445B28CE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiIHV4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiIHVzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:55:32 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E297DC275C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:55:26 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id n11-20020a17090ade8b00b00200ab47f82fso4379106pjv.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=hxVlN6rWLARdYy3dC6gMYDiNdzPlrI9Em0RdQMqLWyE=;
        b=YixyhnGLxPM5IyBq+Cx3ROpfwgkmWSL/S+Z9WY9aAlV7aqP076z0Be803EmoxgmZSI
         QPaV8mCVsgLhPK0aWX376YklGiCJfSTQGO1TR9S0NuD23n3U49BRqiD9JQRLbsJS1gPo
         KDdIn8Ft5t+LqAtHkX2xDrILJvARG24X0A1g3yXOFgW4s5rrBn+hl8I8C1z7wNlYB5sS
         B5b4ju+vHNFK6prjhEKAeNilCbI2oaOjKYSm+B9K8L0AQmCslqzX6I5rLytuYw+tivqQ
         fj5gWZIuFxcERHDKBIHCixAvaqoKbaIi7sNWgZ6OjyRKxDhxAeTOB1qkIq/GII7+iKz3
         2mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=hxVlN6rWLARdYy3dC6gMYDiNdzPlrI9Em0RdQMqLWyE=;
        b=MB1rkHcoZxqV+oXsfmomV2p2YuW0xPODKGQcIoYK+U3kY6RYkeV2JLLcAAUO/x8yEa
         16bCiY/PtjwRpkoiggo3SgUx6Z1HosVg92MmgTgpdPTUD9lhXLfoliXHbste5d4vGcVr
         KFWwm1lWwtEIjP713I9LmL3a1MOjBvEaJMpJS4bpqzOGLzA12QY71aPaic9GdPW4Ml09
         N5cfRmcWBklmP5mAYWuBurLEdq+jFr35wyu/EaezIICezcTFpTH7ciCbZZF7XgAIzEGu
         ESaW12E6UkO0MJpHquiga28dxTX96f9TQu/vERi60B0VGWeFjwnaAPayICnRUwNLCF6q
         GPwg==
X-Gm-Message-State: ACgBeo1pT7Ei8CN2WhjCJZHifZF2NwtdC7kT9ygJ0WkFxqo92QlpzGTl
        fyXryJSgWzW/KYhfVmgVyy8LpXw5wpM4hAGFYSezCskeHAEq72NA3P/IKGJwNBmnBHatiE8f32Z
        JDbMb7Y+YScJrlUP0nAcqNHkPHLe+wBW85Phg4O5spgbUZblm+QuYwnnY26Ix15mmdWfOh6FmFT
        UrvXuM+ZY7lw==
X-Google-Smtp-Source: AA6agR65qo+hoOIT4XctxXEnKYpVkqbDPe1kpMaIsXT3ELQK8UbHn7uKhuVpWc1mlSHvRk67rOv9sIorlVrSO2geSOA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a05:6a00:ac4:b0:535:c08:2da7 with
 SMTP id c4-20020a056a000ac400b005350c082da7mr11099784pfl.69.1662674125665;
 Thu, 08 Sep 2022 14:55:25 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:49 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=samitolvanen@google.com;
 h=from:subject; bh=Y4Uf5ZGPYU6AVUx35/Ny2uohOGmi5MxjylrWIxxHQXk=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS0Or7SZXmXRk+ugEb0v0gF1mhowC/k7HonApWp
 lUIZjtGJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktAAKCRBMtfaEi7xW7rh9C/
 9iq8SJMhpp0douzn0NEiuSP+kUubtmt5lc4Ok7KEerIJ/4MOPE+/l7P1ebhCfDc9WP0hGgMpwU/x0t
 SJk/5fVgawWQ+TwNz5JgujDI77rc2mVF5orGjQoukvQ9vBOvYnvttyAO8/r189bsgyQicv9rhmTBpY
 EcXryiDMh3OmYogpOQQsbtgPmHgVLy6xJzU/dU0s8jD5F/A3gQSWdJH8KUqJNsaW/CGS1u9pfiSHtr
 XNWjIJfmS2QQBXL+cJh0XD9OHMcnS8zIgUMxXywsk1AcobJws5sQYF4uPhOg5agf8SCVeR2vemS4ig
 6UfOqd8bUCL7kpK5vGnAv+NDRItdIzJWQiukTpzP379idLXQ07ItKJFjXcLeh0p6/K6q53vum6j+HX
 gtICAhP23tyItKQUf+XD6MaKkqENs0dgpVPjNynyYBpbJgTcOdInrZfntnE9z7YEnHQNIWq7bZQ6Lo
 VWytjgNgdX/N5z5lbv2dVuSB0Cbc7hlz3BBDwnxPLuvOs=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 07/22] lkdtm: Emit an indirect call for CFI tests
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

Clang can convert the indirect calls in lkdtm_CFI_FORWARD_PROTO into
direct calls. Move the call into a noinline function that accepts the
target address as an argument to ensure the compiler actually emits an
indirect call instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/cfi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
index 71483cb1e422..5245cf6013c9 100644
--- a/drivers/misc/lkdtm/cfi.c
+++ b/drivers/misc/lkdtm/cfi.c
@@ -20,6 +20,13 @@ static noinline int lkdtm_increment_int(int *counter)
 
 	return *counter;
 }
+
+/* Don't allow the compiler to inline the calls. */
+static noinline void lkdtm_indirect_call(void (*func)(int *))
+{
+	func(&called_count);
+}
+
 /*
  * This tries to call an indirect function with a mismatched prototype.
  */
@@ -29,15 +36,11 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
 	 * Matches lkdtm_increment_void()'s prototype, but not
 	 * lkdtm_increment_int()'s prototype.
 	 */
-	void (*func)(int *);
-
 	pr_info("Calling matched prototype ...\n");
-	func = lkdtm_increment_void;
-	func(&called_count);
+	lkdtm_indirect_call(lkdtm_increment_void);
 
 	pr_info("Calling mismatched prototype ...\n");
-	func = (void *)lkdtm_increment_int;
-	func(&called_count);
+	lkdtm_indirect_call((void *)lkdtm_increment_int);
 
 	pr_err("FAIL: survived mismatched prototype function call!\n");
 	pr_expected_config(CONFIG_CFI_CLANG);
-- 
2.37.2.789.g6183377224-goog

