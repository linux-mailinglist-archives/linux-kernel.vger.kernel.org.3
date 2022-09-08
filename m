Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BCB5B28D0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiIHV4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiIHVz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:55:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FDAE3D75
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:55:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-34577a9799dso84598147b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=l/P3ICq7gexrMqe8SVvEbDdbAWpxQuadkoKvFylJkqo=;
        b=UD1ccXbRxz7Xi9ICwlivWXurmIf1Xil1VOXbXD+17fH0lgPb4/B2u8dw9zKCKXtt/3
         sukLBKdMi754n+cnRVt7aJ6aF2qiIdjb7Tn7iFTED/shpoGeLxWfI2tpJd6IXSfGZ8t2
         e9TK8HrAKj1NqLMpBNiEuvmWbQDwZFxQ8L1xUiyXgQTP5i1G1q5VBEgqHvYsdib61Gcp
         Of/JLPj0u8QieOMW6PDwecAc7/Y1Va52p7dY25pE3xpJSyiWqYAm5/hSkdGclfIJiuZL
         C2UHCzXvpzIyy/qrOKHG9tJWSZNaAoTKvJvr+avmfT1psQpkThKEw3GhAPdmJa4D/bV7
         Hr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=l/P3ICq7gexrMqe8SVvEbDdbAWpxQuadkoKvFylJkqo=;
        b=dK5dCnQ6OQXpwlEVZLiNt56EyZiIS3mEUYzqCjJBqXNtQ6LC7YRg5cCpw6Q7seKjQ4
         lnpuqiy0U9D0Z8unvTTiqZCLIH4s5iX9jZZwIkxtosEVeMMWzmIyWYJrmGA6DImBedzT
         WPxOLW+xxqoz9cuRQMkSxY+2GQnbtU7utUdCIYXJsk2/TDJo923kI3uPE8MYM9ucj7Zr
         0trEOMB0b0FwjVmUPxIhUz/gcnSo985k5xZ9TH8fJAjBopi8O+TZClFzwRmhGKod5vS7
         j2maEJsv+zcWmTXKQ637mEYXsIvWFclA11Xi/9SDfMDYiI0AZ7L5bZGEAxROVqqwTXSY
         QdaA==
X-Gm-Message-State: ACgBeo1LV99hjq3HTnyuj5AUyUvmCWy7fAf3hrt896h8WuUZybS7XB+m
        DW9ExMxL0hbpEQ3t18nrqvyaeuQpW4VXGbPRx+nEiNG3q1+d7TX7h2alKAZ9FFb676fjGvOLfx/
        Bwgy5nUV9nHco0pwtLWP35LeuBz1KMcZok+04WDXH+sVPZ6p3U2YoQGMu0ieZtE9Sm3qNrqcTU4
        5hN4WKuvZX6g==
X-Google-Smtp-Source: AA6agR5a0urzcgqtiNi5U9w+rnOkqDqa5tT2drcbxAab7k4RS46CA4kYqncx6Fwz1a0FDqqjBnC3YLNEgfnP18OQ3Tc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a25:fe0e:0:b0:69e:7884:5006 with SMTP
 id k14-20020a25fe0e000000b0069e78845006mr9202550ybe.579.1662674138614; Thu,
 08 Sep 2022 14:55:38 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:54 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1029; i=samitolvanen@google.com;
 h=from:subject; bh=w1Y02HzgeI7knEEHZIsxDg9VMOLQptocTxv/oc51D5c=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS16oHvirVLE2hytnBruHp3nBLqOD6x/WQZ2qt4
 k4D51yOJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktQAKCRBMtfaEi7xW7rtWDA
 CXo6kB5HgNU1fcH0EhWUjrQsIumv8nz+i3x4vs5z30oE5HTRA51x2U2Nj4SgyDDY+V7G3AvUwJPgJg
 +kh0h/5jfijyYIrOTp2uo2EwB7HGCftq2TsfHjHbWza75F8VwBo3dDZrkPSaYvyKB7YRRlPNZeaUZU
 mIa31uMuqI6xdH5hSQC6zE6Q2yRZgDmPlNhZjiS/bm5AQQI6TS7I2Jj22NX6XTDphP6IsaZV0Rfh84
 pd/NRoIzlZ2qsoyx8ywRjV0rtvE0GZvGKXazpkxzM9JAdR1ClstW9ayMVYXZsFK4RGZr3NXn9ZX5xY
 VTbTQvixgrAiEeQxvNoNp1SPMqoWWbiE2irbxsBcWQLaQorjCc961X61Z+oexGMcZveQgMIlx5F3d8
 5kK17TKdfDnyFXi23EhOL8a8FIHs2t01MVbt+2yu9FluH26SdZ79Fq2C4aUCaIZYwXl32I0fLjzDr6
 HDN9J7SFmEbYwlMfsxgEGsmu1LWGTJCDCgZARrqumu0hw=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 12/22] init: Drop __nocfi from __init
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

It's no longer necessary to disable CFI checking for all __init
functions. Drop the __nocfi attribute from __init.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/init.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index baf0b29a7010..88f2964097f5 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -47,7 +47,7 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(".init.text") __cold  __latent_entropy __noinitretpoline __nocfi
+#define __init		__section(".init.text") __cold  __latent_entropy __noinitretpoline
 #define __initdata	__section(".init.data")
 #define __initconst	__section(".init.rodata")
 #define __exitdata	__section(".exit.data")
-- 
2.37.2.789.g6183377224-goog

