Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926384C3FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbiBYIQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiBYIQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:16:38 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2C31E521D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:16:02 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p9so3185567wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Oosgf26C3cGHE1QmDHmqfOUEe/LnMdne4rGI4/p7qq4=;
        b=YoadWNid8jrZuAzwwdpw8uG9NG0tyExSz3wtZMAC9oPbW+TF/itAlD+mBY7HWhXpKq
         DmeLW3lwfIse5GB2zEHUcCcCPU0Rg3Xu3PRnkigkzFI4BA5nWpyI25WibbFVZ4acbEls
         CaYPblLYAAl7pfme5JpVS581S0xl8UvivnlRxcjnzEXWiRRktAtEw9CHxsnGeGnHLJLw
         e+HyTwqv0uFkA9NXiD1HQzyYiwonSIqilYm7iYItx36ESZP+Ou2XQOkuzsDOWYsor7JG
         AO76dheLPSufcWwVUS1D1MgUwRqqlioGp2bYL40gCXfMiFR/Cbisivx9G9/LdMpi41rh
         HITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Oosgf26C3cGHE1QmDHmqfOUEe/LnMdne4rGI4/p7qq4=;
        b=678nvGDsIsAK2ExUBeJmHuy91pjDZaRNHYVTvjRp+JYoScus//K4F9uAWRRCm3RbcM
         FDNaK9QPaNgVHM4bT20eqrwlfb71NDXPgV11sdltPFWHbPz2XNnQv3q3h1HN6cZeXd9r
         V7EB6tEWmUR1zX7rZsvgEXfEJ7AnmlHm8oPz9BYkRqsuNytYab09YCMPvF/faraURyxt
         SaAMLL3xeeNsuMo6178t3rKmVgNiHblU8k8PU8fTnE+nrFC200px7WI18CCnjByLs77V
         ZzDigguRRKhNaf4zoz2hAothLSNB3U4VkopEpGMr2dz0XdASbIboF3ZwmbWTbK0KTPl1
         swIA==
X-Gm-Message-State: AOAM532GiB9xFyYLAZHW5ivPRy6TaYI+JH2McPD0mPKYihj+NpVGaJ5y
        bizOZatzPBMvLzdgKrZauBw3FRAwmQ==
X-Google-Smtp-Source: ABdhPJxILhQaVrwkKgAM+E0cwbIZVNhvFvYXuL4ID5rgMZr7Ce+MP55YgNlYiR0x5fyurn6Fmbyaww==
X-Received: by 2002:a5d:64ea:0:b0:1ea:8148:6b97 with SMTP id g10-20020a5d64ea000000b001ea81486b97mr4966505wri.679.1645776961086;
        Fri, 25 Feb 2022 00:16:01 -0800 (PST)
Received: from localhost.localdomain ([46.53.249.135])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c4f5100b003810030c23fsm1852488wmq.40.2022.02.25.00.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 00:16:00 -0800 (PST)
Date:   Fri, 25 Feb 2022 11:15:58 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Drop -Wdeclaration-after-statement
Message-ID: <YhiQPhsoODiXRAPy@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Putting declarations before statement is relict of single pass compiler
era. It was necessary to allocate stack slots before generating code.

Recently added static_assert() is a declaration. -Wdeclaration-after-statement
prevents its placement anywhere in the code for no reason.

Placing variable declarations in the beginning of the block increases
variable "LOC lifetime" so to speak and chances that it will be misused.
This is very low probability bug but still. Declaring variables right
before first use will make "LOC lifetime" smaller.

	{
		int x;
		[x is misused due to a typo]
		f(x);	// first correct use
	}

vs

	{
		[can't misuse undeclared variable]
		int x;
		f(x);	// first correct use
	}

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Makefile                          |    3 ---
 arch/arm64/kernel/vdso32/Makefile |    1 -
 tools/power/acpi/Makefile.config  |    1 -
 tools/power/cpupower/Makefile     |    1 -
 tools/scripts/Makefile.include    |    1 -
 5 files changed, 7 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -933,9 +933,6 @@ endif
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc
 
-# warn about C99 declaration after statement
-KBUILD_CFLAGS += -Wdeclaration-after-statement
-
 # Variable Length Arrays (VLAs) should not be used anywhere in the kernel
 KBUILD_CFLAGS += -Wvla
 
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -71,7 +71,6 @@ VDSO_CFLAGS += -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                -std=gnu89
 VDSO_CFLAGS  += -O2
 # Some useful compiler-dependent flags from top-level Makefile
-VDSO_CFLAGS += $(call cc32-option,-Wdeclaration-after-statement,)
 VDSO_CFLAGS += $(call cc32-option,-Wno-pointer-sign)
 VDSO_CFLAGS += -fno-strict-overflow
 VDSO_CFLAGS += $(call cc32-option,-Werror=strict-prototypes)
--- a/tools/power/acpi/Makefile.config
+++ b/tools/power/acpi/Makefile.config
@@ -63,7 +63,6 @@ OPTIMIZATION := $(call cc-supports,-Os,-O2)
 
 WARNINGS := -Wall
 WARNINGS += $(call cc-supports,-Wstrict-prototypes)
-WARNINGS += $(call cc-supports,-Wdeclaration-after-statement)
 
 KERNEL_INCLUDE := $(OUTPUT)include
 ACPICA_INCLUDE := $(srctree)/../../../drivers/acpi/acpica
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -118,7 +118,6 @@ OPTIMIZATION := $(call cc-supports,-Os,-O2)
 
 WARNINGS := -Wall -Wchar-subscripts -Wpointer-arith -Wsign-compare
 WARNINGS += $(call cc-supports,-Wno-pointer-sign)
-WARNINGS += $(call cc-supports,-Wdeclaration-after-statement)
 WARNINGS += -Wshadow
 
 override CFLAGS += -DVERSION=\"$(VERSION)\" -DPACKAGE=\"$(PACKAGE)\" \
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -21,7 +21,6 @@ endif
 # Include saner warnings here, which can catch bugs:
 #
 EXTRA_WARNINGS := -Wbad-function-cast
-EXTRA_WARNINGS += -Wdeclaration-after-statement
 EXTRA_WARNINGS += -Wformat-security
 EXTRA_WARNINGS += -Wformat-y2k
 EXTRA_WARNINGS += -Winit-self
