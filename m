Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1E84E592E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244426AbiCWTcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiCWTcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:32:04 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59AA89083;
        Wed, 23 Mar 2022 12:30:33 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id x20so4430327ybi.5;
        Wed, 23 Mar 2022 12:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4GBPXMmjtCwB7t0ecjf/4IevMdb1dyWXSGcgSEXFlT8=;
        b=qtl+lhBaAMthvQDwCYrV6oxBbC+PpsvyuQLj9/TyMc0cCgyzg/Dls7Uf4lCluf5sOx
         DLyYicn0h5x101JHYSFSrbZBA4YBboKhpgxZfOIKjKBJ2fmLJallwWJEKPTccS1jQp1N
         pK7eIgpawC5cyF/cod72+8hmqN2tddQFpB8QHs0bk+RHqPXOLUmLC92QqzEAdKmupkbp
         U7yHXUEuFIn0IDBY6zm3qkGjbtTWJBjSuaIvGL4CEZrV4MB7t/9F10KLzqsDEfy54MyJ
         tD0/BzuWdLkom/QcU8WK1EwzwLFsnOdMTiBx74ASzxaxaG263bKSDlK7cM+2QoU2LSZ7
         uqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4GBPXMmjtCwB7t0ecjf/4IevMdb1dyWXSGcgSEXFlT8=;
        b=3GzLuG8meCNXv/hbZx1p7QqQkbpRlU/vleKsw8M37tIme/4gUqCVw4B/dRLwTdU/E+
         0cNJghu1NtpzlzG9JGQnrvOKrivbjsVhtHioAfqtms1/kADfuFkc/uJbXa979KmQB37w
         uxrf8iVH8OaOK+XbZ6SQwSaXNM2qlOlPrSud57hBP+UdmT1qxTjRLFSf4P/OBEf9wWyZ
         QCL1XpYVoKTw8X6fbfTleVDzHYz9E+CtmQqGB+BqWQ885EaYAvbt0h9N53Z7ktvdBQBf
         nbD4UyPg9un1QD3wJ+kdRfXPtpvhHFJCwGCS7BaLxkGa/e6Ew3gl2qh9GnvbatWOLEX9
         lokQ==
X-Gm-Message-State: AOAM532518POkunZ1XBvJpMjiPn1p7T/vmtzYRW5ly7f1tnfGOpOi9CS
        oXmfzI8KRyqVOofTRl4pmu/kFaHOH3VtgP99w1E=
X-Google-Smtp-Source: ABdhPJxZ1MSoLDdKHZky2vco5xm5QrfsdbxxW3/Aqho9hXPfRJJqaLRTKCYfMAcuhHnxTxfnVEZsegttbk9HVYJbwuQ=
X-Received: by 2002:a25:d95:0:b0:633:771f:6118 with SMTP id
 143-20020a250d95000000b00633771f6118mr1635509ybn.122.1648063833053; Wed, 23
 Mar 2022 12:30:33 -0700 (PDT)
MIME-Version: 1.0
From:   Charlemagne Lasse <charlemagnelasse@gmail.com>
Date:   Wed, 23 Mar 2022 20:30:22 +0100
Message-ID: <CAFGhKbyifH1a+nAMCvWM88TK6fpNPdzFtUXPmRGnnQeePV+1sw@mail.gmail.com>
Subject: Re: [PATCH] x86: bug.h: merge annotate_reachable into _BUG_FLAGS for __WARN_FLAGS
To:     ndesaulniers@google.com
Cc:     adobriyan@gmail.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        linux-sparse@vger.kernel.org, llvm@lists.linux.dev,
        luc.vanoostenryck@gmail.com, mingo@redhat.com, nathan@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -75,9 +77,9 @@ do {                                \
>   */
>  #define __WARN_FLAGS(flags)                    \
>  do {                                \
> +    __auto_type f = BUGFLAG_WARNING|(flags);        \
>      instrumentation_begin();                \
> -    _BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags));        \
> -    annotate_reachable();                    \
> +    _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);            \
>      instrumentation_end();                    \
>  } while (0)

This causes following sparse warning on x86:

make allnoconfig && touch init/version.c && make CHECK="sparse
-Wshadow"  C=1 init/version.o
#
# No change to .config
#
 CALL    scripts/checksyscalls.sh
 CALL    scripts/atomic/check-atomics.sh
 CHK     include/generated/compile.h
 CC      init/version.o
 CHECK   init/version.c
init/version.c: note: in included file (through
include/linux/rculist.h, include/linux/pid.h, include/linux/sched.h,
include/linux/utsname.h):
./include/linux/rcupdate.h:1007:9: warning: symbol 'f' shadows an earlier one
./include/linux/rcupdate.h:1001:47: originally declared here


Affected versions (from the ones on kernel.org):

* 5.17 - bfb1a7c91fb7 ("x86/bug: Merge annotate_reachable() into
_BUG_FLAGS() asm")
* 5.16.17 - fe0c95903a68 ("x86/bug: Merge annotate_reachable() into
_BUG_FLAGS() asm")

Cannot be seen when changing the variable name:

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index bab883c0b6fe..cbd11e38252a 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -77,9 +77,9 @@ do {                                \
  */
 #define __WARN_FLAGS(flags)                    \
 do {                                \
-    __auto_type f = BUGFLAG_WARNING|(flags);        \
+    __auto_type __f = BUGFLAG_WARNING|(flags);        \
     instrumentation_begin();                \
-    _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);            \
+    _BUG_FLAGS(ASM_UD2, __f, ASM_REACHABLE);            \
     instrumentation_end();                    \
 } while (0)
