Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05C7526B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384276AbiEMUYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384164AbiEMUWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:22:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE08515EA7D
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f8be9326fcso81334967b3.18
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dlbVbF+zSH65SmcGkXw1HXEqEtfYUZQQn63+I2niGUI=;
        b=suo26qtPRItoyTwDfbbz3LASboBjKdoSMFI8aXUKdlLp7CvixfOiS0uW8H0gGPFal2
         ufgd4A/bFbLLb35MHsIFdaYntoAIZwz2uyf3z8bMRt81n9k1SU3nJTLVFvOQgb2SG8Fu
         bxKBgJRrvLFgiFjcPBc5Ql/tiiDyCHMFHdMWHyl55ksvDj3IxU5xl8BS15jw7IGglpoD
         rCWQ6dehGYNUVVdSLJleQQBFDeVcxeS2wdMj89py0SHeVj1/phR+9VxOKeAhx/R3o0y3
         dxmzZBsr6Kb5ReKmsDe4eAPOCfkU7q2HMZmt2/P07pSpGYOWb8T5SJmlzQByOBASF86u
         WdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dlbVbF+zSH65SmcGkXw1HXEqEtfYUZQQn63+I2niGUI=;
        b=2ehx6WxYpXDm3cbd9J2MC+zUVXXGbnVNsZRaY5GSBvvO3noaDxtcMxcaVeWAlCpP4v
         cFNp97mKD/JHcUE+pCjB1FARlsiEutCEFZvPM5ci2HDd8bG14pDUF8ZbUf6z9kUDdw6p
         LauHxcR52MIL1Y3sASWZa9Mr0PJuMTc9Ge6hsdUEFzT2u0lsOrvtaL7b7U3p7FpHy/d1
         YKM7enJ5+9M/i3NvS5MiEEP4fVp0TIKjyswpJOFz/TJxGSiZpK7sj9DwTPAVlj6TKGTj
         JSUhLdSQqm0qgOBUhOUMmewI+qHc7MJUCATiXA9HK7qtF3tNye/sgdrneWTVYq4q9XA4
         71hw==
X-Gm-Message-State: AOAM531Omun+yuZmToanlcvDJZntQgl1Ieck90K4c+L/wON2XxxdI8yX
        Mm/MkbFNyaA1saOmnxmslI7CxHNRxYiybGMGaXF15CPbOjnCn7vVWHdKcg89Up9wl6DGa5ndW/Z
        S2/7/kqYIxPk1DZ87wMfc0gg8dVNvSrKAucsOwFZ4CINRPnLiut9KeQvD/iUF/S5+LFSa6xawTs
        wzeY+6KTkWgQ==
X-Google-Smtp-Source: ABdhPJzFM48oKh50rHebCrOHf34tcszegLHZxSEku5WBt1TgwOcHyEAQ0+hAqjBZ97NekznHKYIzAU+Im42Yn+P0SW0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a25:3441:0:b0:64b:dc55:bdd2 with SMTP
 id b62-20020a253441000000b0064bdc55bdd2mr2715370yba.75.1652473369915; Fri, 13
 May 2022 13:22:49 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:59 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-22-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=873; h=from:subject;
 bh=EnKTZWbwTuwhGtVwGe8P9VjRM8gy1nwr12ORzB61S+o=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3mfZ8/2S8lWN4wX+IbgzR7T53VLtyDzI5tt2rz
 WJL+EaaJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn695gAKCRBMtfaEi7xW7pVmC/
 9a3zu00Ju5TXxz0xiUJonHs8P0BGs4hr5NmWM2GMbyFjujv8hZeNGa4mbYKHKM5PCQQ5gvZgix8xN7
 pycP7Dh2F7rK9HP2Fk6aH55ONw1ChCEHEzVNMB01KLR5+6/b4c4y7TCE3ZD3mF3h76hXjR8das2Zy8
 /l8yvdEZQEHquOWm1zBiS8yJvQi3QiroJFJv29MfZwGqv77y80QGHlf3OYSNsl1cli2prx6ZgDNeja
 U700rcBs2hsB/3Idgu5rWH2o1LwNQhhLXRSSPCJ+RDTgVj3o3z2qnQbJNcqWpzelCvO9OedQQVoUBc
 ijxVLEzzl1xpeBdNk1MBk5Yt1djJtfSIXAccu2h/e8gme3qYn4dkUdt/4mtjccvvFGzy5KZnCTFIAk
 UTsfhTj2V9f+6fyGCQ3hu/sQOzwh7XJUzd+IyJINOyFAw+0gRm/XHYEstiM2STE6izuoI7QWPXRpM3
 9+1GAAvAXf8upx6jl7Yk6dH45w3SkswkAp7IP4wLfr7Y4=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 21/21] init: Drop __nocfi from __init
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

It's no longer necessary to disable CFI checking for all __init
functions. Drop the __nocfi attribute.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/init.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 76058c9e0399..a0a90cd73ebe 100644
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
2.36.0.550.gb090851708-goog

