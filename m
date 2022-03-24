Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE4C4E6544
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351123AbiCXOe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350905AbiCXOd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:33:26 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A823DAC900
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:31:54 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KPSMK2d9lz9sTt;
        Thu, 24 Mar 2022 15:31:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gkadQe_OGiUn; Thu, 24 Mar 2022 15:31:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KPSLz0S8Gz9sV0;
        Thu, 24 Mar 2022 15:30:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE3088B763;
        Thu, 24 Mar 2022 15:30:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UUs8ZWDRuTvz; Thu, 24 Mar 2022 15:30:50 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.77])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F17998B7A0;
        Thu, 24 Mar 2022 15:30:49 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22OEUiXW1811756
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 24 Mar 2022 15:30:44 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22OEUixv1811753;
        Thu, 24 Mar 2022 15:30:44 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 19/22] powerpc/inst: Remove PPC_INST_BRANCH
Date:   Thu, 24 Mar 2022 15:30:09 +0100
Message-Id: <43a4ee9fd77f774fa1e9b72a2fc674fc8f084fed.1648131740.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648131740.git.christophe.leroy@csgroup.eu>
References: <cover.1648131740.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648132152; l=1716; s=20211009; h=from:subject:message-id; bh=reTiO1OPvuqXdGLn3x7Xk8PpudfBNZlji7IfAzSFmik=; b=YizvpT7xNAy/R0PmHc8ZrS4TX2jZyTgAdWk4r5Ql5brRoG3FESq4bjF0VxUxMpSc/NVDa27igWuW Mp5vGL6pBfJR9k5SgxBFC+q5CYtI2FQHCg3ddj8iz/jxKKhkvt+J
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

Convert last users of PPC_INST_BRANCH to PPC_RAW_BRANCH()

And remove PPC_INST_BRANCH.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc-opcode.h | 3 +--
 arch/powerpc/lib/feature-fixups.c     | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 281754aca0a3..ada8fe17b199 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -290,7 +290,6 @@
 #define PPC_INST_ADDIS			0x3c000000
 #define PPC_INST_ADD			0x7c000214
 #define PPC_INST_DIVD			0x7c0003d2
-#define PPC_INST_BRANCH			0x48000000
 #define PPC_INST_BL			0x48000001
 #define PPC_INST_BRANCH_COND		0x40800000
 
@@ -573,7 +572,7 @@
 #define PPC_RAW_MTSPR(spr, d)		(0x7c0003a6 | ___PPC_RS(d) | __PPC_SPR(spr))
 #define PPC_RAW_EIEIO()			(0x7c0006ac)
 
-#define PPC_RAW_BRANCH(addr)		(PPC_INST_BRANCH | ((addr) & 0x03fffffc))
+#define PPC_RAW_BRANCH(offset)		(0x48000000 | ((offset) & PPC_INST_OFFSET24_MASK))
 #define PPC_RAW_BL(offset)		(0x48000001 | ((offset) & PPC_INST_OFFSET24_MASK))
 
 /* Deal with instructions that older assemblers aren't aware of */
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 343a78826035..993d3f31832a 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -451,7 +451,7 @@ static int __do_rfi_flush_fixups(void *data)
 
 	if (types & L1D_FLUSH_FALLBACK)
 		/* b .+16 to fallback flush */
-		instrs[0] = PPC_INST_BRANCH | 16;
+		instrs[0] = PPC_RAW_BRANCH(16);
 
 	i = 0;
 	if (types & L1D_FLUSH_ORI) {
-- 
2.35.1

