Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75C6547033
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349393AbiFJXfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349296AbiFJXfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:35:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756A9289F14
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u128-20020a25dd86000000b0066073927e92so549916ybg.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f2ez5GlPiz7LVHLEwJNPKLpo0vJP8RdxLafLiRUk5QE=;
        b=iKH4lvrLXdfTkbOBM3216qeAmFXUVCNZOl9l8BspQJ4rpqELSsOx/dvp5FBCJ61+MK
         Qe7z/u7qUuuWGvcZaS1+jt1dc9SzMwm80qJ0J1VDr3aegKpLxX1ggYXz7fKnk0418CTL
         Hg11Fttm16oJnUgS/diZT5zIRg78gDBu8cEmHV/k6ysToIhnQh8/a5fo2iNXz+i0UOED
         ZrFaKU0CtyasnLmWkqq51A0dCu18cBIr8KaX5AuBMPnp9I2mz6nPDlUFM5Qc9z6ADbKf
         ogKMQTsKq7Acbzw+8xLAP7paiSLqLT2pEIB3orxvzuNNtAd0JIyfUj2YyV+yP6FDGaWt
         j0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f2ez5GlPiz7LVHLEwJNPKLpo0vJP8RdxLafLiRUk5QE=;
        b=OOwopWnyop/tRQyhwJ/ONk3ldPDU5VDl/knyDt3KQXJf49ZvBidY6G3z0xcm9NzTIK
         87uhrdfm9WGrQpTeSoEdwkaFY7K1i4e3eNzJxoxBl75nWa0PZga62RkmH0KaakOipUXJ
         Zm6E5KQsywnGaYBV+rkRWnpTTpQQmXhjow7aAyZXNrV9QbO6nblP2fF1j3JyEkKvPN35
         PWAK812UKNemk4yvdSkp0nrTBmn4mmZkuIkXQsusaaewquHSbWF6bqp6xwUsVQbLMkIv
         Dj31opBfDl3wFyUDDJCJ0EdDqty0ilaDuaREo99wJUOgsM/LYsbVc4/B2mL6Zmqn/tWh
         nCDQ==
X-Gm-Message-State: AOAM530RcHKX50jKYnT6YF2aT0c09fH/XYgVFTLOdBuXt0iOmouucMsx
        qIajKJkn48X2CRS4NcfNLrHTA2c6MN6GB5mQysepS3HPrUn6KFQ87/Bzz8VCh93hLILN62GQMQl
        4FXxuTtIXCFbNaOCVZUprzE0Nec+6js+pnSWU9XOh5KpS7CkXvynrBY32f2b2g/0MGNtsuC1pWI
        TwkicOzAMjvA==
X-Google-Smtp-Source: ABdhPJxz2IY87/Xw53sI2vfsQaG1YS1q3LumYXmYWqaHfb2HDYl+aHwo+eKjFDgc7azDGZJL0i2ozWPbeM/MCDDKFTg=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a5b:48a:0:b0:663:7ee1:999c with SMTP
 id n10-20020a5b048a000000b006637ee1999cmr28580272ybp.544.1654904120569; Fri,
 10 Jun 2022 16:35:20 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:34:55 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=815; h=from:subject;
 bh=RS8kezem6HKmvIC2xkWx+Vimg14ewNmCZ/1rOo726vQ=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9Us0Qlk8N5JpvifNY7fxEcru1Y6AbEzteuzzSUX
 A+M8G4CJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLAAKCRBMtfaEi7xW7mNoC/
 9Hbp8Ou+VWLCKh26fDW3X/l+zpog1gX2cHWcbQLZjUDuBdoBOsMeJFZbAJr7gp6cyArykGxpWXjcmW
 QZbCeNOnrTVHXzY5St0+Ifo/59T9fIcUBwHKC/flaN5RQ7izb8+ogGYfeI0mrYTZepJuoaKaWTyBdf
 AUhLi/p2zg/xr8NCHPVxMqNF9nIItJ6JduJw5Sd+xAtbcd2Mbop0+QpzlZbA3nWRZ9xAFB0r7XV+hR
 mvFqbPwY7b1hFE1FacbEFByAEslu//mJzsZsmdZzd6Q+5sQGaHrELVyHMCjTnIXuj/UInbiKvwg2S2
 km6wMZAsd4FFEv2beTZaMXkrEessphESu0M7O9miUDxCjaG/tqzp3LbULs8sVrgKSm/xM6g8z6Igt8
 WQM7NtLXMg5SQneP0oKyLpzfCIXMiHsKuP37sWAozocaYzsdNSvKjqRAvThxlQoF8NQK+tJXYdKFPZ
 yV5EBSBWBhAlN8S0DBn0q2ESKwRkuy6Hjtig2SpJDvcPE=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 02/20] scripts/kallsyms: Ignore __kcfi_typeid_
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

The compiler generates __kcfi_typeid_ symbols for annotating assembly
functions with type information. These are constants that can be
referenced in assembly code and are resolved by the linker. Ignore
them in kallsyms.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/kallsyms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index f18e6dfc68c5..ccdf0c897f31 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -119,6 +119,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		"__ThumbV7PILongThunk_",
 		"__LA25Thunk_",		/* mips lld */
 		"__microLA25Thunk_",
+		"__kcfi_typeid_",	/* CFI type identifiers */
 		NULL
 	};
 
-- 
2.36.1.476.g0c4daa206d-goog

