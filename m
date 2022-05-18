Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBB952B1F9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 07:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiERFsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiERFsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:48:13 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BF112082
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:48:12 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 24D4A3FFCF
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652852887;
        bh=OuYcIW78oTiw+Sz2rhEVAmrHB11Rr6sr/ed5JNrvcwk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=u09LqiNUHceULTjIeaWd9/4KNwv9o5lPF5AvU0kUkmDq1r9b2u2ZKXgFr6V2PT0k0
         jU7ZSNY/MMt+H6IhCdWBOYkXmsj9obfa2QnqCV0Zuz4wqQznL4YcWCUgTjh7GKSceL
         bXczGGImqTrIgFN23dHRLOqR56zae3QTxMVXFOC3ay3eU1gMWdJmj8RapdJiqOqN+p
         N0jUYesYq2hVC7Yzqjah1aImorkF7HqkVXr8A5AMu0bSN0rxE9ImsKR9tgQCJ1XiyN
         RPf/COB9Ylit+jJT0sRWUeko9GpLwSS1h4tXLS0tMQurWpIATuDtyaL9M89k2kmEYs
         gVOBYxMdhjmsQ==
Received: by mail-ed1-f70.google.com with SMTP id s9-20020aa7c549000000b0042ab6ab62f0so872953edr.14
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OuYcIW78oTiw+Sz2rhEVAmrHB11Rr6sr/ed5JNrvcwk=;
        b=z5uPk8I0gOFzj5Wp2f9NpUtJZ9ldYF5Efrr1D+S8bKJ00eDuInmDR/tQ64jaU9dCGs
         IOTf/GCNdkQc9oBpAEIHxKblZwpJ81Wt3HTJBOUfSsSsDamqTZuEkIDD6uyEKCqP88Nj
         S+4IDul4lopF8/BgnhnX8cEfz1TVbUUFjDGCXvMP516Gs5TxFVR0EW3vH33/avxpiVeM
         vCjNMcQ2bSHUrP+LQ7Fx7VDCf+JnSDl/DQZ50vQrcgQ/TUr9Uqa4FedQQYBRdeUN+/mG
         Cvmb0ocneRZ6KqtfeUwWBhDSyf6qIvmt0RwKiCY2GTSJuzfspTgcrvWA1ued1l/TV3AS
         3YAQ==
X-Gm-Message-State: AOAM533khcnx4SQVRpLNmkdtwHOuTvK9oo5Z8fuEqwgo3PHHU7p2myzm
        Z6saJO/A+BD/KT+diUNJtQCTbF/9X9O5VpzU7UXuvBDWBxjN4pMVh0ubILqOZL2CZCTqTOFi/tA
        nKJZRHD3fNghPyQ8VdRGsX9GeKJBQr0Xb3mGYRyS+JQ==
X-Received: by 2002:a17:906:2294:b0:6f3:bd02:95a3 with SMTP id p20-20020a170906229400b006f3bd0295a3mr22217725eja.201.1652852886233;
        Tue, 17 May 2022 22:48:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsM5guVQhEMwbqlHeH0ltEm3owbFLAO6FNX1R+3hR4rTF5TMvbDnm/h3oEhbEjA5RRjkcMvQ==
X-Received: by 2002:a17:906:2294:b0:6f3:bd02:95a3 with SMTP id p20-20020a170906229400b006f3bd0295a3mr22217710eja.201.1652852885906;
        Tue, 17 May 2022 22:48:05 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id e18-20020a170906749200b006f3ef214e17sm513630ejl.125.2022.05.17.22.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 22:48:05 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        llvm@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH v2] arch/Kconfig: Fix indentation and add comments
Date:   Wed, 18 May 2022 07:48:01 +0200
Message-Id: <20220518054801.364376-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220517141024.331475-1-juergh@canonical.com>
References: <20220517141024.331475-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

While add it, add trailing comments to endmenu statements for better
readability.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>

---
v2:
  Fix subject prefix (ARM: Kconfig: -> arch/Kconfig)

---
 arch/Kconfig | 130 +++++++++++++++++++++++++--------------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 31c4fdc4a4ba..65091088b1fd 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -28,7 +28,7 @@ config HOTPLUG_SMT
 	bool
 
 config GENERIC_ENTRY
-       bool
+	bool
 
 config KPROBES
 	bool "Kprobes"
@@ -47,26 +47,26 @@ config JUMP_LABEL
 	depends on HAVE_ARCH_JUMP_LABEL
 	depends on CC_HAS_ASM_GOTO
 	help
-	 This option enables a transparent branch optimization that
-	 makes certain almost-always-true or almost-always-false branch
-	 conditions even cheaper to execute within the kernel.
+	  This option enables a transparent branch optimization that
+	  makes certain almost-always-true or almost-always-false branch
+	  conditions even cheaper to execute within the kernel.
 
-	 Certain performance-sensitive kernel code, such as trace points,
-	 scheduler functionality, networking code and KVM have such
-	 branches and include support for this optimization technique.
+	  Certain performance-sensitive kernel code, such as trace points,
+	  scheduler functionality, networking code and KVM have such
+	  branches and include support for this optimization technique.
 
-	 If it is detected that the compiler has support for "asm goto",
-	 the kernel will compile such branches with just a nop
-	 instruction. When the condition flag is toggled to true, the
-	 nop will be converted to a jump instruction to execute the
-	 conditional block of instructions.
+	  If it is detected that the compiler has support for "asm goto",
+	  the kernel will compile such branches with just a nop
+	  instruction. When the condition flag is toggled to true, the
+	  nop will be converted to a jump instruction to execute the
+	  conditional block of instructions.
 
-	 This technique lowers overhead and stress on the branch prediction
-	 of the processor and generally makes the kernel faster. The update
-	 of the condition is slower, but those are always very rare.
+	  This technique lowers overhead and stress on the branch prediction
+	  of the processor and generally makes the kernel faster. The update
+	  of the condition is slower, but those are always very rare.
 
-	 ( On 32-bit x86, the necessary options added to the compiler
-	   flags may increase the size of the kernel slightly. )
+	  ( On 32-bit x86, the necessary options added to the compiler
+	    flags may increase the size of the kernel slightly. )
 
 config STATIC_KEYS_SELFTEST
 	bool "Static key selftest"
@@ -90,9 +90,9 @@ config KPROBES_ON_FTRACE
 	depends on KPROBES && HAVE_KPROBES_ON_FTRACE
 	depends on DYNAMIC_FTRACE_WITH_REGS
 	help
-	 If function tracer is enabled and the arch supports full
-	 passing of pt_regs to function tracing, then kprobes can
-	 optimize on top of function tracing.
+	  If function tracer is enabled and the arch supports full
+	  passing of pt_regs to function tracing, then kprobes can
+	  optimize on top of function tracing.
 
 config UPROBES
 	def_bool n
@@ -146,21 +146,21 @@ config HAVE_EFFICIENT_UNALIGNED_ACCESS
 config ARCH_USE_BUILTIN_BSWAP
 	bool
 	help
-	 Modern versions of GCC (since 4.4) have builtin functions
-	 for handling byte-swapping. Using these, instead of the old
-	 inline assembler that the architecture code provides in the
-	 __arch_bswapXX() macros, allows the compiler to see what's
-	 happening and offers more opportunity for optimisation. In
-	 particular, the compiler will be able to combine the byteswap
-	 with a nearby load or store and use load-and-swap or
-	 store-and-swap instructions if the architecture has them. It
-	 should almost *never* result in code which is worse than the
-	 hand-coded assembler in <asm/swab.h>.  But just in case it
-	 does, the use of the builtins is optional.
+	  Modern versions of GCC (since 4.4) have builtin functions
+	  for handling byte-swapping. Using these, instead of the old
+	  inline assembler that the architecture code provides in the
+	  __arch_bswapXX() macros, allows the compiler to see what's
+	  happening and offers more opportunity for optimisation. In
+	  particular, the compiler will be able to combine the byteswap
+	  with a nearby load or store and use load-and-swap or
+	  store-and-swap instructions if the architecture has them. It
+	  should almost *never* result in code which is worse than the
+	  hand-coded assembler in <asm/swab.h>.  But just in case it
+	  does, the use of the builtins is optional.
 
-	 Any architecture with load-and-swap or store-and-swap
-	 instructions should set this. And it shouldn't hurt to set it
-	 on architectures that don't have such instructions.
+	  Any architecture with load-and-swap or store-and-swap
+	  instructions should set this. And it shouldn't hurt to set it
+	  on architectures that don't have such instructions.
 
 config KRETPROBES
 	def_bool y
@@ -686,13 +686,13 @@ config LTO_CLANG_FULL
 	depends on !COMPILE_TEST
 	select LTO_CLANG
 	help
-          This option enables Clang's full Link Time Optimization (LTO), which
-          allows the compiler to optimize the kernel globally. If you enable
-          this option, the compiler generates LLVM bitcode instead of ELF
-          object files, and the actual compilation from bitcode happens at
-          the LTO link step, which may take several minutes depending on the
-          kernel configuration. More information can be found from LLVM's
-          documentation:
+	  This option enables Clang's full Link Time Optimization (LTO), which
+	  allows the compiler to optimize the kernel globally. If you enable
+	  this option, the compiler generates LLVM bitcode instead of ELF
+	  object files, and the actual compilation from bitcode happens at
+	  the LTO link step, which may take several minutes depending on the
+	  kernel configuration. More information can be found from LLVM's
+	  documentation:
 
 	    https://llvm.org/docs/LinkTimeOptimization.html
 
@@ -1284,9 +1284,9 @@ config ARCH_HAS_CC_PLATFORM
 	bool
 
 config HAVE_SPARSE_SYSCALL_NR
-       bool
-       help
-          An architecture should select this if its syscall numbering is sparse
+	bool
+	help
+	  An architecture should select this if its syscall numbering is sparse
 	  to save space. For example, MIPS architecture has a syscall array with
 	  entries at 4000, 5000 and 6000 locations. This option turns on syscall
 	  related optimizations for a given architecture.
@@ -1309,35 +1309,35 @@ config HAVE_PREEMPT_DYNAMIC_CALL
 	depends on HAVE_STATIC_CALL
 	select HAVE_PREEMPT_DYNAMIC
 	help
-	   An architecture should select this if it can handle the preemption
-	   model being selected at boot time using static calls.
+	  An architecture should select this if it can handle the preemption
+	  model being selected at boot time using static calls.
 
-	   Where an architecture selects HAVE_STATIC_CALL_INLINE, any call to a
-	   preemption function will be patched directly.
+	  Where an architecture selects HAVE_STATIC_CALL_INLINE, any call to a
+	  preemption function will be patched directly.
 
-	   Where an architecture does not select HAVE_STATIC_CALL_INLINE, any
-	   call to a preemption function will go through a trampoline, and the
-	   trampoline will be patched.
+	  Where an architecture does not select HAVE_STATIC_CALL_INLINE, any
+	  call to a preemption function will go through a trampoline, and the
+	  trampoline will be patched.
 
-	   It is strongly advised to support inline static call to avoid any
-	   overhead.
+	  It is strongly advised to support inline static call to avoid any
+	  overhead.
 
 config HAVE_PREEMPT_DYNAMIC_KEY
 	bool
 	depends on HAVE_ARCH_JUMP_LABEL && CC_HAS_ASM_GOTO
 	select HAVE_PREEMPT_DYNAMIC
 	help
-	   An architecture should select this if it can handle the preemption
-	   model being selected at boot time using static keys.
+	  An architecture should select this if it can handle the preemption
+	  model being selected at boot time using static keys.
 
-	   Each preemption function will be given an early return based on a
-	   static key. This should have slightly lower overhead than non-inline
-	   static calls, as this effectively inlines each trampoline into the
-	   start of its callee. This may avoid redundant work, and may
-	   integrate better with CFI schemes.
+	  Each preemption function will be given an early return based on a
+	  static key. This should have slightly lower overhead than non-inline
+	  static calls, as this effectively inlines each trampoline into the
+	  start of its callee. This may avoid redundant work, and may
+	  integrate better with CFI schemes.
 
-	   This will have greater overhead than using inline static calls as
-	   the call to the preemption function cannot be entirely elided.
+	  This will have greater overhead than using inline static calls as
+	  the call to the preemption function cannot be entirely elided.
 
 config ARCH_WANT_LD_ORPHAN_WARN
 	bool
@@ -1360,8 +1360,8 @@ config ARCH_SUPPORTS_PAGE_TABLE_CHECK
 config ARCH_SPLIT_ARG64
 	bool
 	help
-	   If a 32-bit architecture requires 64-bit arguments to be split into
-	   pairs of 32-bit arguments, select this option.
+	  If a 32-bit architecture requires 64-bit arguments to be split into
+	  pairs of 32-bit arguments, select this option.
 
 config ARCH_HAS_ELFCORE_COMPAT
 	bool
@@ -1380,4 +1380,4 @@ source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
 
-endmenu
+endmenu # "General architecture-dependent options"
-- 
2.32.0

