Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0905A526B27
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384234AbiEMUXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384200AbiEMUWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:22:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86DB1756B1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f83cc145edso81116847b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hVI2H0xnZ7RmL/u8CtkGkcPsuty3huMjT1xVoaokMS8=;
        b=ChOWWSpwlZWxcJIQ+SaNXPfO7pMlQzZbg6m7xZvVehWYTAEfesAlK2rfgMl6kKYUJZ
         PC88MEu08ggaydfb7OYECcrn2NOkrMNmn4eblAgc0zmX5VRvl27k7SoIFReIQfZLRN8r
         Xj+i+6O7FRCzR9R40JANUSe2JsNQtPUVmZ6bmpUImk/RWRvp35IAvOEg1QHOncWHWOnk
         XFPQyfBLs72a30aa6J5tmiMLgoA9h+0MOtVMP6BgtZM14sSGVY6sTiFi8Kp9sHcbO8mr
         6JuTiZzANlnMwoHHFhf4NoXoBBK3TW7AygfM2wKUm2o2ehKVgRxQJX1O8ZfSyi07I/GC
         15xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hVI2H0xnZ7RmL/u8CtkGkcPsuty3huMjT1xVoaokMS8=;
        b=X88YgfjFYJMdyV65p2pDXmVc2JIalB5190BCGI4iswowZARW+skxlBh0fR8Bc0q2Up
         ILBHy3Q0DpY5h0nmxPiluijS1M2Yj2bkMipX+0BWvehGZeQRiSWbWshsLGsVXUxxsepu
         IHlB2nQQzHVEs10BKN1bRnXI3Xz72OCrklGSrMPGU64xxC550LNgsJ60FXsGPUlZ0eL+
         iUPD8lqLrGD69z8rM6bEiHJEY4Il9ytWvHifvH56Gf+Xn2r8BgslsD5IQIRLIcIf4URA
         Ou2xXwqbKbU5/FObYO9tWJ2KA2zfH6pGWoCehGyp8rOc+9VhOzyjffF46G1u+FQSj7r/
         iFjA==
X-Gm-Message-State: AOAM531wifiZ/uK6WsMdaKdqNC+yoh2cBDt/9y7SJsr4+tGT+FmD1oHM
        6U38mplTa0FQb72AcW8HxJPIvTmXMXseSF/axGoJdNdu3o3oKzTLkYl3c71S5wJrXCbw5pjiKT3
        M93UDlsA7dlRay4BZo7lAh2iMUQLodrEmIb+2rT/R5uPqTHjv3ztuIRMshT7k3MLcVGUewcuE0U
        oNvt0lRSmYKg==
X-Google-Smtp-Source: ABdhPJyXOQ8uvyWPL+12fGNZws/BE5YW9i9nX3hNgx2mGOV+806AxTC5RpGIfedu/1NbCFyEdmO58l9WKRQjRyjzaEE=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a25:6407:0:b0:64b:4b88:a3a1 with SMTP
 id y7-20020a256407000000b0064b4b88a3a1mr6935792ybb.320.1652473347761; Fri, 13
 May 2022 13:22:27 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:49 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2335; h=from:subject;
 bh=UQlGPlwtYybM8FEAV0vACm4HLycz0znjf8+xx6gkTx0=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3knoHGJRQ8lklk1VH0eWFsW6jNYP2xh19dScd+
 EuJIIM2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn695AAKCRBMtfaEi7xW7kRSC/
 42vBryC3ccOIXP/usmo03Al21Qca5sIegalwVHuJV+choTcYrlXsVgpXmKEbgvi0MOdXz7P2uXwf6N
 ZMqBuYr2/fS7MiuRb0lv3fUxcWTBSlLokzEKszNO55+3k1A2+OaE1jGDM26vzTk4E6f/ehXixU/lmb
 EPwPWGqa6vrC9QuGN0TOqrJw9h6RZh7EmB5kzUNvXQx0dPN/t0h4qyIufAjODvsE/Umg2MZ+NwqIww
 SXHqyzYZeaEY3pxLTbJ2FC9WvJaK/LnVAtWGuvmNdvdTjHq7ly2b3SVz/5el1sPLp+v5ZoAZ1C6wF/
 HeIsnn2jx/Mk2gb7IcxRwxwtMZjrnTDW9lfq/d0TDHhReaCXOqEWfwE02+h7xRT+xyVP0J2XVbpUK4
 KbUE3kdbMCFdQidVvRFCZlCYl5UbTml8VKUW+GZu1taVIPo5a9jIUwUHJXhrLhxKRfAWWFnz5DnB2g
 vTke5m0gcOVH/HeP/DAQgo3aqLyGnKoS8NlOfBBSnEqmc=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 11/21] arm64: Drop unneeded __nocfi attributes
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

With -fsanitize=kcfi, CONFIG_CFI_CLANG no longer has issues
with address space confusion in functions that switch to linear
mapping. Now that the indirectly called assembly functions have
type annotations, drop the __nocfi attributes.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/include/asm/mmu_context.h | 2 +-
 arch/arm64/kernel/alternative.c      | 2 +-
 arch/arm64/kernel/cpufeature.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 6770667b34a3..ca0140d0b8cf 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -143,7 +143,7 @@ static inline void cpu_install_ttbr0(phys_addr_t ttbr0, unsigned long t0sz)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp)
+static inline void cpu_replace_ttbr1(pgd_t *pgdp)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 7bbf5104b7b7..e98466bab633 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -133,7 +133,7 @@ static void clean_dcache_range_nopatch(u64 start, u64 end)
 	} while (cur += d_size, cur < end);
 }
 
-static void __nocfi __apply_alternatives(struct alt_region *region, bool is_module,
+static void __apply_alternatives(struct alt_region *region, bool is_module,
 				 unsigned long *feature_mask)
 {
 	struct alt_instr *alt;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d72c4b4d389c..af78dcacf9fe 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1596,7 +1596,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 }
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-static void __nocfi
+static void
 kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 {
 	typedef void (kpti_remap_fn)(int, int, phys_addr_t);
-- 
2.36.0.550.gb090851708-goog

