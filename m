Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE1E56A65C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbiGGO5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiGGO4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:56:53 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E135C97C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:55:35 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Ldzx21Kyjz9tGm;
        Thu,  7 Jul 2022 16:55:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ku_m0WjcgRIw; Thu,  7 Jul 2022 16:55:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Ldzx20ZV4z9tGf;
        Thu,  7 Jul 2022 16:55:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 014818B7A9;
        Thu,  7 Jul 2022 16:55:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PZOos7Sn6knh; Thu,  7 Jul 2022 16:55:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.174])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B92168B7A0;
        Thu,  7 Jul 2022 16:55:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 267EtO5F541777
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 7 Jul 2022 16:55:24 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 267EtN3d541776;
        Thu, 7 Jul 2022 16:55:23 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc/probes: Remove ppc_opcode_t
Date:   Thu,  7 Jul 2022 16:55:14 +0200
Message-Id: <b2d762191b095530789ac8b71b167c6740bb6aed.1657205708.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1657205713; l=1596; s=20211009; h=from:subject:message-id; bh=29AGqRathw4AZvQv4uOylQJgwbRnmYkQsT2plmAfeHc=; b=/bMm8dBkbm29pziEhAJycPRGBU8DNfxyjqiVld1xqayxkmzrESlUfJni6EHErvkZP9bnBgWsqMRe qQMHXOedDyLrJGlYVMpiYWJjX+dfg3py7U5iPT1mI1FY8LCeC2Xe
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

ppc_opcode_t is just an u32. There is no point in hiding u32
behind such a typedef. Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/kprobes.h | 2 +-
 arch/powerpc/include/asm/probes.h  | 1 -
 arch/powerpc/include/asm/uprobes.h | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index bab364152b29..c8e4b4fd4e33 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -29,7 +29,7 @@
 struct pt_regs;
 struct kprobe;
 
-typedef ppc_opcode_t kprobe_opcode_t;
+typedef u32 kprobe_opcode_t;
 
 extern kprobe_opcode_t optinsn_slot;
 
diff --git a/arch/powerpc/include/asm/probes.h b/arch/powerpc/include/asm/probes.h
index 6f66e358aa37..00634e3145e7 100644
--- a/arch/powerpc/include/asm/probes.h
+++ b/arch/powerpc/include/asm/probes.h
@@ -10,7 +10,6 @@
 #include <linux/types.h>
 #include <asm/disassemble.h>
 
-typedef u32 ppc_opcode_t;
 #define BREAKPOINT_INSTRUCTION	0x7fe00008	/* trap */
 
 /* Trap definitions per ISA */
diff --git a/arch/powerpc/include/asm/uprobes.h b/arch/powerpc/include/asm/uprobes.h
index a7ae1860115a..4fea116d3d37 100644
--- a/arch/powerpc/include/asm/uprobes.h
+++ b/arch/powerpc/include/asm/uprobes.h
@@ -12,7 +12,7 @@
 #include <linux/notifier.h>
 #include <asm/probes.h>
 
-typedef ppc_opcode_t uprobe_opcode_t;
+typedef u32 uprobe_opcode_t;
 
 #define MAX_UINSN_BYTES		8
 #define UPROBE_XOL_SLOT_BYTES	(MAX_UINSN_BYTES)
-- 
2.36.1

