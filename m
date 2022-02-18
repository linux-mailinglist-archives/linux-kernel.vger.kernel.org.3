Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5094BB421
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiBRI0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:26:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiBRI0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:26:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD022221B7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:26:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i6-20020a255406000000b006241e97e420so4943641ybb.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RZAu1RopNW0ZnAhNX12nSJphTGjmyvccd/3qHZblYXY=;
        b=rCB+yv0t3K2artQviTbyk/s1ERydB/bk4ZSc8CtHBGWDb960G5TEmbF7KVd59dToSl
         fbSTCa3ux/7+xckpeHEGWrupiuQ26paV6JUm7AiZ695TBD8MwKRpOXr1aAyblZxp4f5z
         wI6qmLnLkEgVobo9GzyV8cgaoN+kiaMeSqzgzciQz0swVMXroFwjHuW8iSJsYMwGUJ7T
         QwFy6SnNz0o9fQrZopD2msec3ba4QSNiuewF7551R5Uc+CXwz/pBlVURbYaCatjKNFW+
         bVQIrlRO0drjc0DgrBs7NvA4cOLJLuyjnwhsN0Xe0nzTTlWeeZ/5uVnQvZsO1Ej2Aijn
         1ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RZAu1RopNW0ZnAhNX12nSJphTGjmyvccd/3qHZblYXY=;
        b=cuBo6OqWMitL35yIbByC269XpSbFZxBXn2v7YDleGrvAOPZznT4z8k6Tcih8Lvigqg
         v2xV+oCCFsYvH5VqtZeQVA8AdnXMn4DM0kEx32WUlx1kEKF01AKCn3Fc/TL97Y90fnGf
         fSj3ltydZUen+C38WlA5UFRpoYJZaF+Nfoim5xUd3VKv4qqEwokEROmsuCfo14PohNVD
         hF+Fici2XYqBll4RBrYHHK0hsQABpK5jtJn9cl1wjq2bKo4YJGFkvEqQqGlEv8kE/EDP
         Txg3/faaDdM5RcUchJhu42gl/tacZZI6WpZx4cemGmFyUnFifNxZd3apnjNJMDkfLhyS
         cAKA==
X-Gm-Message-State: AOAM533s4Fs0cVTcvCJZn84fWvJyXbV8JYrXvHRntwC43z1DymmxlhTw
        7z8/dFzeZ08lGOVs6NV6tdoCpWGMfGIB
X-Google-Smtp-Source: ABdhPJxrlB+xqNTDUqw0l54UMAh7wnOLcJJX8wTR1FqNzyU2jkIXBNFKEJYtk1JqNQPyLFtrWMgHYrCO8QR6
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:200:bdb7:3728:9760:87c])
 (user=maskray job=sendgmr) by 2002:a25:d6d3:0:b0:61d:aa5c:7e82 with SMTP id
 n202-20020a25d6d3000000b0061daa5c7e82mr6379447ybg.404.1645172775391; Fri, 18
 Feb 2022 00:26:15 -0800 (PST)
Date:   Fri, 18 Feb 2022 00:26:11 -0800
Message-Id: <20220218082611.396353-1-maskray@google.com>
Mime-Version: 1.0
Subject: [PATCH] riscv module: remove (NOLOAD)
From:   Fangrui Song <maskray@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Fangrui Song <maskray@google.com>
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

On ELF, (NOLOAD) sets the section type to SHT_NOBITS[1]. It is conceptually
inappropriate for .plt, .got, and .got.plt sections which are always
SHT_PROGBITS.

In GNU ld, if PLT entries are needed, .plt will be SHT_PROGBITS anyway
and (NOLOAD) will be essentially ignored. In ld.lld, since
https://reviews.llvm.org/D118840 ("[ELF] Support (TYPE=<value>) to
customize the output section type"), ld.lld will report a `section type
mismatch` error. Just remove (NOLOAD) to fix the error.

[1] https://lld.llvm.org/ELF/linker_script.html As of today, "The
section should be marked as not loadable" on
https://sourceware.org/binutils/docs/ld/Output-Section-Type.html is
outdated for ELF.
---
 arch/riscv/include/asm/module.lds.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/module.lds.h b/arch/riscv/include/asm/module.lds.h
index 4254ff2ff049..1075beae1ac6 100644
--- a/arch/riscv/include/asm/module.lds.h
+++ b/arch/riscv/include/asm/module.lds.h
@@ -2,8 +2,8 @@
 /* Copyright (C) 2017 Andes Technology Corporation */
 #ifdef CONFIG_MODULE_SECTIONS
 SECTIONS {
-	.plt (NOLOAD) : { BYTE(0) }
-	.got (NOLOAD) : { BYTE(0) }
-	.got.plt (NOLOAD) : { BYTE(0) }
+	.plt : { BYTE(0) }
+	.got : { BYTE(0) }
+	.got.plt : { BYTE(0) }
 }
 #endif
-- 
2.35.1.265.g69c8d7142f-goog

