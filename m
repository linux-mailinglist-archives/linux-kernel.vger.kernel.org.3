Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F615155C5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380870AbiD2Uk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380854AbiD2UkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:40:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4145283019
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:36:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 9-20020a250909000000b006484b89c979so8287163ybj.21
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mNJyMVnIlguT1rUilClQ07jGJwBfREePO+0SEXQazuU=;
        b=SbPzWHz94PkiMgXJJgKeWVHyDbGKW0iDGndnpCpHSSnGy0udUUlBjtpN0J1quzFzj6
         9DNm9Bc3j3kVnXgb5WawLcDyFQd04kIbtQGi1DPmqk1xDQVxu0qIpcBAxx/d6ejw5h49
         KT14vLiZFTxcJrqYL4GVD3dvIF1Fv8ZgUnBDLOgTvQr5SYM7PWI8gAxJ1oq0ZHm80ihD
         EWjK+FxhDoerz3ciebN4rXM84mTDWRZyheZGg7EhS5aWE9aJqx3EyOAjZOUEGrgxQVMm
         WiRwj5rN0xhl95Qy5z18BBET4b5MLZM3cRbUhOAOvSictxqNCKkfnrg7fXhpvLyH149+
         sl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mNJyMVnIlguT1rUilClQ07jGJwBfREePO+0SEXQazuU=;
        b=dEBDKHlN6F6BsXMFE5w1X57z0FSs74taQDSY+mxvo8kY0QrCdADdZuKCcvNBwmQSsc
         ScvUW6vRKB+gBiPxtAuOAMKPw2a9KuQUW4XeYF9tm9qQqwOQ8hlVCzhMljHJSm/pXGhh
         o3cCOK6g/IeMAqiZ/SnuJtwU5XSd4DTuagwVAFCNOmZ2Nf6f+dPhOVm8lCA669vGzFV0
         Wjk6Y+Ky4OUw8n6qCju9UOODZO44axsKj4sl+iv0xdcRU+YgvucQmmhfBDWtC3TMeQFa
         2vXUDB1L69HNtmW+AR/pxL+Gxu8BDncxtJakBTfQg6PZG/Z3pV/mKcOFJFIqUZ8vrPJF
         Y4jQ==
X-Gm-Message-State: AOAM531AomuP2ozgC+MwJLRBDIs6h58DloXC73Axxg9tTf7By/ewZT4z
        gc6Z8PEJDjmHqp+PCFj4xlOzgUlNXGu6rnC/2qQkEPvYRzGv8vYZeI3fXprtdOJbnLz17Jh3Pu9
        zjmvBkpTpb82jH+aFXN/ueY2ZDfyjySK5Bl5KKCLCu0kkb9HMSlrQ7INdModAXcdI1ixQU/8Rv4
        PJ2GGrRbo18g==
X-Google-Smtp-Source: ABdhPJyayjsqoZ9MAE/d6QWDpfC4MBpe6t087Wq8ydOs9sA1lE9zrm0OkbjlaqzE1YyNGhiVhX9WmrSBQYStbxUZJck=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a81:5085:0:b0:2f4:d6fb:f76f with SMTP
 id e127-20020a815085000000b002f4d6fbf76fmr1289650ywb.190.1651264615259; Fri,
 29 Apr 2022 13:36:55 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:26 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=669; h=from:subject;
 bh=o0oSO6A7dgHXw3JXyfs3kpLOQ31qQjhpc3pVMXlQeFk=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExVconqZfKUU7vtSg68iLeto5MMy78pevg9vXBt
 ZBfrWfiJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVQAKCRBMtfaEi7xW7sdRC/
 4rfcaIe+IT88EzfaYojaN8Sm+K4SATmfqAiUgwPtEJr2MID9IqKsrAZ9k2RjrSDq6w4bhs0A8V4B0G
 xeVCMT4W1+zvdWXlHb0A00gQOmvQ1vQyWI56OKIo9NiJti+CgLpYubN2ZUJOjoGlgeg1gLbJO66pDw
 icjIr0tUfuqNt27ID7vosvM2t0dLvewBveN5xF39aBc335pIruuGBF+43BjkceurX4nUyMuyRQKyuC
 C53Q0gRzSGtojQq0oZgtUt5bNOXehc7Bl3Y49D251QXr9mC5mhzdgMstIidEmNouXNfULHiTCOP+JZ
 EQXw/jX3KI7Q/9i8Rhjf+MJb6HiZMqWNHAz0Cxs32KU9fFjs5mCqmaXOcuKypUxZf8Bl1rRbOJ6N0P
 828GLh6ViZaJwR3qKRUm4OMT2qNKAA5RQww1KQsFt1rvpUpLxfm3f4Y4aHj9Gzwtf2CnUqUpg4EAY3
 OYhC9Lm3NuP0XGZvhb3CJ0qnvicQJW7kr29sr8vDYrhkI=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 03/21] kallsyms: Ignore __kcfi_typeid_
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

The compiler generates CFI type identifier symbols for annotating
assembly functions at link time. Ignore them in kallsyms.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/kallsyms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8caabddf817c..eebd02e4b832 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -118,6 +118,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		"__ThumbV7PILongThunk_",
 		"__LA25Thunk_",		/* mips lld */
 		"__microLA25Thunk_",
+		"__kcfi_typeid_",	/* CFI type identifiers */
 		NULL
 	};
 
-- 
2.36.0.464.gb9c8b46e94-goog

