Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E7151E4C5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445876AbiEGGvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445805AbiEGGvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:51:20 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5085C862
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 23:47:26 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KwHzQ1Sf8z9sVs;
        Sat,  7 May 2022 08:46:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 28xk8Fkog8Us; Sat,  7 May 2022 08:46:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KwHzF1kh7z9sW9;
        Sat,  7 May 2022 08:46:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2865F8B763;
        Sat,  7 May 2022 08:46:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id N_8jhIo7yLyx; Sat,  7 May 2022 08:46:49 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 14A868B799;
        Sat,  7 May 2022 08:46:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2476kfaT1320559
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 7 May 2022 08:46:41 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2476kfrU1320558;
        Sat, 7 May 2022 08:46:41 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 22/25] powerpc/inst: Remove PPC_INST_BRANCH
Date:   Sat,  7 May 2022 08:46:24 +0200
Message-Id: <e39dfa3ae4be810c6d7824059451490e0f1fb4b4.1651905939.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651905939.git.christophe.leroy@csgroup.eu>
References: <cover.1651905939.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1651905982; l=1674; s=20211009; h=from:subject:message-id; bh=GoqVFmJgvgqJKNrjF8mpSAEOdUFe9GmQ2Bf3fRLVT0E=; b=M8Rle/RdnAHVyxXaodFp9yAR+CrzuUeVmjYXe8NPiqngu4a4BTJRQzLUAwA47MrCmrvxE1YF1LxI 6CTZ8bcNADyhj85Th+oF4H9c+yLcv7QPi26lQ49fM13m4p2gLpaW
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
index 3e9aa96ae74b..1871a86c5436 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -290,7 +290,6 @@
 #define PPC_INST_ADDIS			0x3c000000
 #define PPC_INST_ADD			0x7c000214
 #define PPC_INST_DIVD			0x7c0003d2
-#define PPC_INST_BRANCH			0x48000000
 #define PPC_INST_BL			0x48000001
 #define PPC_INST_BRANCH_COND		0x40800000
 
@@ -575,7 +574,7 @@
 #define PPC_RAW_MTSPR(spr, d)		(0x7c0003a6 | ___PPC_RS(d) | __PPC_SPR(spr))
 #define PPC_RAW_EIEIO()			(0x7c0006ac)
 
-#define PPC_RAW_BRANCH(addr)		(PPC_INST_BRANCH | ((addr) & 0x03fffffc))
+#define PPC_RAW_BRANCH(offset)		(0x48000000 | PPC_LI(offset))
 #define PPC_RAW_BL(offset)		(0x48000001 | PPC_LI(offset))
 
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

