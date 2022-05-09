Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E379851F417
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbiEIFr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbiEIFq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:46:56 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A9B15E746
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 22:43:04 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KxVKj3Thqz9sWD;
        Mon,  9 May 2022 07:36:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Or9R2v2D7Nu5; Mon,  9 May 2022 07:36:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KxVKH4PyTz9sTC;
        Mon,  9 May 2022 07:36:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8464A8B773;
        Mon,  9 May 2022 07:36:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Q0HI4tzoWP0t; Mon,  9 May 2022 07:36:35 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5BD448B76C;
        Mon,  9 May 2022 07:36:35 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2495aWD01591303
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 9 May 2022 07:36:32 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2495aV651591302;
        Mon, 9 May 2022 07:36:31 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 24/25] powerpc/inst: Remove PPC_INST_BL
Date:   Mon,  9 May 2022 07:36:22 +0200
Message-Id: <d9eacb758e7ae7cf224211ebe3f6f7d409a333be.1652074503.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1652074503.git.christophe.leroy@csgroup.eu>
References: <cover.1652074503.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1652074582; l=1300; s=20211009; h=from:subject:message-id; bh=sW/JSfIHiKBxCIZ62GcYgvl+OLyOrCgP+Naw3li71dY=; b=rGCdd50F7rnSj/5HOtCZkuVJfJRHBEIjWs/M2+DOTF7Irsf8CDWdYFx9mhpvY3R1CHqbYdGM8TRY +Rlgwu1AC1XdpwnXjqGwwZLXn9UhIM9PUzF/JJOgCvrxV+S04oEG
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

Convert last users of PPC_INST_BL to PPC_RAW_BL()

And remove PPC_INST_BL.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc-opcode.h | 1 -
 arch/powerpc/net/bpf_jit.h            | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 1871a86c5436..9ca8996ee1cd 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -290,7 +290,6 @@
 #define PPC_INST_ADDIS			0x3c000000
 #define PPC_INST_ADD			0x7c000214
 #define PPC_INST_DIVD			0x7c0003d2
-#define PPC_INST_BL			0x48000001
 #define PPC_INST_BRANCH_COND		0x40800000
 
 /* Prefixes */
diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 80d973da9093..a4f7880f959d 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -35,7 +35,7 @@
 	} while (0)
 
 /* bl (unconditional 'branch' with link) */
-#define PPC_BL(dest)	EMIT(PPC_INST_BL | (((dest) - (unsigned long)(image + ctx->idx)) & 0x03fffffc))
+#define PPC_BL(dest)	EMIT(PPC_RAW_BL((dest) - (unsigned long)(image + ctx->idx)))
 
 /* "cond" here covers BO:BI fields. */
 #define PPC_BCC_SHORT(cond, dest)					      \
-- 
2.35.1

