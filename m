Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D331526B23
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384286AbiEMUXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384185AbiEMUWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:22:43 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944EC15FE08
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7c322f770so81160367b3.20
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bOpzM5rX2l4ip7yxSBZMEDJLuv66hWELCctweBJJHks=;
        b=rL/hL6OntTIlT6+vghCQAiZfUmoZf+JKLSwkZf+IrrsNgssVEJVawitmFaYY55jmBe
         amD7Eq+wsfiNCduzWZ9qsgP4L4Eaoz5WdsbalKIQn6dmzQtZSjg5Ws94G9xU2GMA3379
         ptYLd/GCT/HZYVruQu1ULOS8r60MhY8tYFWaQkLiwx/jHZy3Hv8nqZJGcbTTlO61CRHO
         Ui5viFE1OPI2iQTd8ZFgpeNNg8UIf9lxq/5l0yMHnkI4aHbNASnhtiPtCkKN6ow4/8Gy
         Buw+p+M5hlwFYUt71jzAT461tK+NYI45ChnwXdq3pjmdEybkufp0sSLOl8jFCSlKjOtr
         c9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bOpzM5rX2l4ip7yxSBZMEDJLuv66hWELCctweBJJHks=;
        b=KtRaI4GN0LaVtVEfPrhv36znDrn6xIpzV2TtZEAoj1BXa9jLtkLYsj0XnEPjAnPDcE
         WAVrWru9F8d/dgLyuSgsWKoV1r0SZqLZ1pfMCysfOOmc0JFZP6TWpX7Z5Vwh2kPgl8b2
         Iw7ODMuUBDAi4z0+QQmpyYY2UmAXuHvKsin73qpT2zqAZIT/YFarM2P5SZmdxmyNM0G2
         NonvhwJRWNe1jyfq5U92BJw8E02Jp5LBsuIIVaOEfZ40uZa3FG4zrrlDtc3Mge9QlXEf
         G1LRmZsG0L4ie/tTZrMFttB0GMVEUZvb+WRQ2ItGUYMhrwBOA+IVOp+1b5hWH1h+lvdP
         EGeQ==
X-Gm-Message-State: AOAM532DXxUPWSWczPCz10dYlj2m/vAEwYNaCjvVVgAvj9gg5UYOV8oZ
        bWEQhgjsfqRxNyg5F1xnig6AwcNHH48r26lmUwnLqvJjNFXZGXE1BQl6v8HvXO5u+FBcfkLAuxf
        Kfv0EohUifs6SkjhZ4Gi1cWtP4RSx5Ec8EMV5uUbmPRCht91h+pQ+jqV4PxnKV3cf8Dc+kY84y5
        Y75cr82n07dA==
X-Google-Smtp-Source: ABdhPJwWzw5BAhCv70kXSSaCh7PhBQVVl4ghLTYlA0W/0QO97ijY+sTWmPSKw5zlsA+je25PPHFJReZCMSvJtqlJTmo=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a25:b320:0:b0:645:6969:52f4 with SMTP
 id l32-20020a25b320000000b00645696952f4mr6410598ybj.466.1652473340628; Fri,
 13 May 2022 13:22:20 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:46 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; h=from:subject;
 bh=HH1ZoZ4U7IrTG0qT02hkMGqwA8ikkqMw52ht6iNCIe8=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3j/HnryEij1/HDUc2sbZLQyYN7d6556HPZq1qT
 l1xSJNOJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn694wAKCRBMtfaEi7xW7ktXDA
 CU67UkQ9+rP6BZrl4m0BX4xUiwzSmmKPLl9nByQ7yxpXu6x9cOxvsh7U+Y+kdEvD+wXiJX/83jCg88
 viRNpRYeMvJXxI1DPEyJhK+E2GSrC8RfNlnOKOCBWyBm9pDr7/akIxQSKPItAZ9NR9hoZDzYxImk2b
 kFlY7+tt3abbniKqgwD2SlAe9ab1jJeTDp1b8ijpK85f3dEHhJtGWHn4ijrJQWlimUHtN4amn+DJmV
 I7Ti8ClmSh7Lky12ga65DmJQ3s1WHHj5ZrZGalNG25evyzYj+FTwpvEv/D9IRDB2+brvZ/pidt0x7N
 F1EQbzuYgZCDrr4PNCycx1HLCBZ4pC1q+96fvrsjj4UyPP6hEiyzGaqhTM211QovCAKh8N5YyyY8Kq
 cgmRTA/+rmphPKNrl6e434tN7thBoUXXn9pnTlR1B7tNq5ZAio1MvLBno+7zYk2Lthd97TwEgrcjPV
 xYOFqJC1W7SajhbCnMeZUuTW5HZSIq64lZnTLiQXLJKfU=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 08/21] psci: Fix the function type for psci_initcall_t
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

Functions called through a psci_initcall_t pointer all have
non-const arguments. Fix the type definition to avoid tripping
indirect call checks with CFI_CLANG.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/firmware/psci/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index cfb448eabdaa..6554bf4b8c99 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -521,7 +521,7 @@ static int __init psci_probe(void)
 	return 0;
 }
 
-typedef int (*psci_initcall_t)(const struct device_node *);
+typedef int (*psci_initcall_t)(struct device_node *);
 
 /*
  * PSCI init function for PSCI versions >=0.2
-- 
2.36.0.550.gb090851708-goog

