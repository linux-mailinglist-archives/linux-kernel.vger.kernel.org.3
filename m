Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78D74BFA4C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiBVOGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbiBVOG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:06:26 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8ED15F630
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:05:42 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K31Cm50BMz9sSK;
        Tue, 22 Feb 2022 15:05:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pQe4Nwa6JW_l; Tue, 22 Feb 2022 15:05:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K31Cm4HVCz9sSG;
        Tue, 22 Feb 2022 15:05:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 83C588B778;
        Tue, 22 Feb 2022 15:05:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dfKKNeyMRAAb; Tue, 22 Feb 2022 15:05:40 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.78])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 56E648B764;
        Tue, 22 Feb 2022 15:05:40 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21ME5WUk1085144
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 15:05:32 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21ME5U491085143;
        Tue, 22 Feb 2022 15:05:30 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Remove remaining stab codes
Date:   Tue, 22 Feb 2022 15:05:30 +0100
Message-Id: <d8b33342d7454f6ca4f368f5206896558dfa06f4.1645538722.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645538729; l=790; s=20211009; h=from:subject:message-id; bh=FwvgNvm0imPRq6IfGzlyBogWeJqgKYW43VV3hftz2h0=; b=MRPARWAomFIMqE/iqctBUKRDVCsWcseycsKuW6EO+O4/tAS2wW2wJsa2kZzHS46FtCGxRqeFFMzT u56doPUeASmdcSdtbQ1rRF8XUbDpgfuvBrmNqRWlUHQdd772i353
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

Following commit 12318163737c ("powerpc/32: Remove remaining .stabs
annotations"), stabs code are not used anymore.

Remove them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc_asm.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index d9c6f12e6d3e..ee52667d76e2 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -693,12 +693,6 @@ END_FTR_SECTION_NESTED(CPU_FTR_CELL_TB_BUG, CPU_FTR_CELL_TB_BUG, 96)
 #define	evr30	30
 #define	evr31	31
 
-/* some stab codes */
-#define N_FUN	36
-#define N_RSYM	64
-#define N_SLINE	68
-#define N_SO	100
-
 #define RFSCV	.long 0x4c0000a4
 
 /*
-- 
2.34.1

