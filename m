Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E1151E4CA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445865AbiEGGww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445946AbiEGGwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:52:17 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031766543F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 23:48:07 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KwHzg0pVMz9sWK;
        Sat,  7 May 2022 08:47:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IijcZ8lsJNtr; Sat,  7 May 2022 08:47:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KwHzF3GP2z9sWN;
        Sat,  7 May 2022 08:46:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 621B38B76E;
        Sat,  7 May 2022 08:46:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7KPs2nU8qn7p; Sat,  7 May 2022 08:46:49 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 40E458B7AB;
        Sat,  7 May 2022 08:46:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2476kfdK1320571
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 7 May 2022 08:46:41 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2476kf6j1320570;
        Sat, 7 May 2022 08:46:41 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 25/25] powerpc/opcodes: Remove unused PPC_INST_XXX macros
Date:   Sat,  7 May 2022 08:46:27 +0200
Message-Id: <a589a4d81b519629835889d855ca232ba574e4b2.1651905939.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651905939.git.christophe.leroy@csgroup.eu>
References: <cover.1651905939.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1651905982; l=2923; s=20211009; h=from:subject:message-id; bh=pV3LNsUwDLHbNMELI+9s3LvNdD+cK5R0Uilc4bWSJuA=; b=dy1MlVxhbR1iF1HeceoXlf7i3uUOZodLvQLGMxKpRmjX6OOd0/HYMFm6Wpr6DtHwh3jZwClKDQV6 AGsmS61NDzMx2AzXni4kNsBRj2Dq1NZ670+pVAt/JKrVBhPdbBIY
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

The following PPC_INST_XXX macros are not used anymore
outside ppc-opcode.h:
	- PPC_INST_LD
	- PPC_INST_STD
	- PPC_INST_ADDIS
	- PPC_INST_ADD
	- PPC_INST_DIVD

Remove them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc-opcode.h | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 9ca8996ee1cd..b9d6f95b66e9 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -285,11 +285,6 @@
 #define PPC_INST_TRECHKPT		0x7c0007dd
 #define PPC_INST_TRECLAIM		0x7c00075d
 #define PPC_INST_TSR			0x7c0005dd
-#define PPC_INST_LD			0xe8000000
-#define PPC_INST_STD			0xf8000000
-#define PPC_INST_ADDIS			0x3c000000
-#define PPC_INST_ADD			0x7c000214
-#define PPC_INST_DIVD			0x7c0003d2
 #define PPC_INST_BRANCH_COND		0x40800000
 
 /* Prefixes */
@@ -462,10 +457,10 @@
 	(0x100000c7 | ___PPC_RT(vrt) | ___PPC_RA(vra) | ___PPC_RB(vrb) | __PPC_RC21)
 #define PPC_RAW_VCMPEQUB_RC(vrt, vra, vrb) \
 	(0x10000006 | ___PPC_RT(vrt) | ___PPC_RA(vra) | ___PPC_RB(vrb) | __PPC_RC21)
-#define PPC_RAW_LD(r, base, i)		(PPC_INST_LD | ___PPC_RT(r) | ___PPC_RA(base) | IMM_DS(i))
+#define PPC_RAW_LD(r, base, i)		(0xe8000000 | ___PPC_RT(r) | ___PPC_RA(base) | IMM_DS(i))
 #define PPC_RAW_LWZ(r, base, i)		(0x80000000 | ___PPC_RT(r) | ___PPC_RA(base) | IMM_L(i))
 #define PPC_RAW_LWZX(t, a, b)		(0x7c00002e | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b))
-#define PPC_RAW_STD(r, base, i)		(PPC_INST_STD | ___PPC_RS(r) | ___PPC_RA(base) | IMM_DS(i))
+#define PPC_RAW_STD(r, base, i)		(0xf8000000 | ___PPC_RS(r) | ___PPC_RA(base) | IMM_DS(i))
 #define PPC_RAW_STDCX(s, a, b)		(0x7c0001ad | ___PPC_RS(s) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_LFSX(t, a, b)		(0x7c00042e | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_STFSX(s, a, b)		(0x7c00052e | ___PPC_RS(s) | ___PPC_RA(a) | ___PPC_RB(b))
@@ -476,8 +471,8 @@
 #define PPC_RAW_ADDE(t, a, b)		(0x7c000114 | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_ADDZE(t, a)		(0x7c000194 | ___PPC_RT(t) | ___PPC_RA(a))
 #define PPC_RAW_ADDME(t, a)		(0x7c0001d4 | ___PPC_RT(t) | ___PPC_RA(a))
-#define PPC_RAW_ADD(t, a, b)		(PPC_INST_ADD | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b))
-#define PPC_RAW_ADD_DOT(t, a, b)	(PPC_INST_ADD | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b) | 0x1)
+#define PPC_RAW_ADD(t, a, b)		(0x7c000214 | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b))
+#define PPC_RAW_ADD_DOT(t, a, b)	(0x7c000214 | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b) | 0x1)
 #define PPC_RAW_ADDC(t, a, b)		(0x7c000014 | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_ADDC_DOT(t, a, b)	(0x7c000014 | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b) | 0x1)
 #define PPC_RAW_NOP()			PPC_RAW_ORI(0, 0, 0)
-- 
2.35.1

