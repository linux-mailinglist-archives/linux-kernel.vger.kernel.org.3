Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AD65122E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiD0Tkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiD0Tjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:39:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFC31016
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D43361B79
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AB5C385C0;
        Wed, 27 Apr 2022 19:36:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1njnSr-002IsZ-1h;
        Wed, 27 Apr 2022 15:36:41 -0400
Message-ID: <20220427193640.887318514@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Apr 2022 15:36:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [for-next][PATCH 08/21] MAINTAINERS: Enlarge coverage of TRACING inside architectures
References: <20220427193623.529296556@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

Most architectures have ftrace related stuff in arch/*/kernel/ftrace.c
but powerpc has it spread in multiple files located in
arch/powerpc/kernel/trace/
In several architectures, there are also additional files containing
'ftrace' as part of the name but with some prefix or suffix.

Use wildcards to enlarge coverage.

With arch/*/*/*/*ftrace*:
	arch/alpha/include/asm/ftrace.h
	arch/arm64/include/asm/ftrace.h
	arch/arm/include/asm/ftrace.h
	arch/csky/include/asm/ftrace.h
	arch/csky/kernel/probes/ftrace.c
	arch/ia64/include/asm/ftrace.h
	arch/m68k/include/asm/ftrace.h
	arch/microblaze/include/asm/ftrace.h
	arch/mips/include/asm/ftrace.h
	arch/nds32/include/asm/ftrace.h
	arch/parisc/include/asm/ftrace.h
	arch/powerpc/include/asm/ftrace.h
	arch/powerpc/kernel/trace/ftrace_64_pg.S
	arch/powerpc/kernel/trace/ftrace.c
	arch/powerpc/kernel/trace/ftrace_low.S
	arch/powerpc/kernel/trace/ftrace_mprofile.S
	arch/riscv/include/asm/ftrace.h
	arch/riscv/kernel/probes/ftrace.c
	arch/s390/include/asm/ftrace.h
	arch/s390/include/asm/ftrace.lds.h
	arch/sh/include/asm/ftrace.h
	arch/sparc/include/asm/ftrace.h
	arch/x86/include/asm/ftrace.h
	arch/x86/kernel/kprobes/ftrace.c
	arch/xtensa/include/asm/ftrace.h

With arch/*/*/*ftrace*:
	arch/arm64/kernel/entry-ftrace.S
	arch/arm64/kernel/ftrace.c
	arch/arm/kernel/entry-ftrace.S
	arch/arm/kernel/ftrace.c
	arch/csky/kernel/ftrace.c
	arch/ia64/kernel/ftrace.c
	arch/microblaze/kernel/ftrace.c
	arch/mips/kernel/ftrace.c
	arch/nds32/kernel/ftrace.c
	arch/parisc/kernel/ftrace.c
	arch/powerpc/kernel/kprobes-ftrace.c
	arch/riscv/kernel/ftrace.c
	arch/s390/kernel/ftrace.c
	arch/s390/kernel/ftrace.h
	arch/sh/kernel/ftrace.c
	arch/sparc/kernel/ftrace.c
	arch/x86/kernel/ftrace_32.S
	arch/x86/kernel/ftrace_64.S
	arch/x86/kernel/ftrace.c

Link: https://lkml.kernel.org/r/e8338c0ad0e73991cbd8f31c215b16ea4efe212d.1648189904.git.christophe.leroy@csgroup.eu

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61d9f114c37f..b90535d923a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19951,8 +19951,8 @@ M:	Ingo Molnar <mingo@redhat.com>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 F:	Documentation/trace/ftrace.rst
-F:	arch/*/*/*/ftrace.h
-F:	arch/*/kernel/ftrace.c
+F:	arch/*/*/*/*ftrace*
+F:	arch/*/*/*ftrace*
 F:	fs/tracefs/
 F:	include/*/ftrace.h
 F:	include/linux/trace*.h
-- 
2.35.1
