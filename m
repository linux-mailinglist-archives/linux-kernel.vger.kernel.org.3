Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0114E6538
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351014AbiCXOd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351045AbiCXOdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:33:01 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A836EAC900
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:31:19 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KPSM62Rznz9sTl;
        Thu, 24 Mar 2022 15:30:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qAR13Swuuv32; Thu, 24 Mar 2022 15:30:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KPSLy5P8tz9sTm;
        Thu, 24 Mar 2022 15:30:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AECA58B763;
        Thu, 24 Mar 2022 15:30:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iwBCbJ26OgYm; Thu, 24 Mar 2022 15:30:50 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.77])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B34CA8B78D;
        Thu, 24 Mar 2022 15:30:49 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22OEUi5r1811764
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 24 Mar 2022 15:30:45 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22OEUixg1811763;
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
Subject: [PATCH v1 21/22] powerpc/inst: Remove PPC_INST_BL
Date:   Thu, 24 Mar 2022 15:30:11 +0100
Message-Id: <43f418a2d7377669f10738be374c3dd78f5d0351.1648131740.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648131740.git.christophe.leroy@csgroup.eu>
References: <cover.1648131740.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648132152; l=1328; s=20211009; h=from:subject:message-id; bh=d/0sxDLqKwCM/yFYRKIyBRndGeNibtd5T3dOKw3MQJc=; b=pyjWcSj8RzaW7zHcMj/KcQkTwTflEA/lc9eWqCI/EkBSbaY9M9sIUtfCB/hMaxx987RGOe7wok2G AR7kYOXiBjXQAP+/lWqsxERvSULzVE4hTSRq42R7y/v+cCLr383d
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
index ada8fe17b199..810a28af9dce 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -290,7 +290,6 @@
 #define PPC_INST_ADDIS			0x3c000000
 #define PPC_INST_ADD			0x7c000214
 #define PPC_INST_DIVD			0x7c0003d2
-#define PPC_INST_BL			0x48000001
 #define PPC_INST_BRANCH_COND		0x40800000
 
 #define PPC_INST_OFFSET24_MASK		0x03fffffc
diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 979701d360da..c63324ff9f04 100644
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

