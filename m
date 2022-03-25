Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D4F4E6E37
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 07:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355278AbiCYGeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 02:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244115AbiCYGeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:34:08 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA3BC6837
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:32:34 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KPshc6CGzz9sSg;
        Fri, 25 Mar 2022 07:32:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wcJddXA699EP; Fri, 25 Mar 2022 07:32:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KPshc58pBz9sSY;
        Fri, 25 Mar 2022 07:32:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 95B578B780;
        Fri, 25 Mar 2022 07:32:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id b2q8qNEYZCZ9; Fri, 25 Mar 2022 07:32:32 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 693648B763;
        Fri, 25 Mar 2022 07:32:32 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22P6WPw01929871
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 07:32:25 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22P6WOAi1929870;
        Fri, 25 Mar 2022 07:32:24 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] MAINTAINERS: Enlarge coverage of TRACING inside architectures
Date:   Fri, 25 Mar 2022 07:32:21 +0100
Message-Id: <e8338c0ad0e73991cbd8f31c215b16ea4efe212d.1648189904.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648189940; l=2471; s=20211009; h=from:subject:message-id; bh=yGp7FFa7HBbJp8rR4opj6dC3eUxH51ufjaS0fMwDaXA=; b=tn1cBoMKwSgWqRA31d1a6NhUAlf4APNizNT1B/nujBxHIRYNT9kz14hfxWscDnYT5g85WT/24Uoj G3b+uJI/Cz5y19M8c+1y+Y/pO1eo7lPcQ1IGcNjLsS+CvDG7RRMI
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e127c2fb08a7..e03c471fcd73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19590,8 +19590,8 @@ M:	Ingo Molnar <mingo@redhat.com>
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

