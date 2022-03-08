Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35584D2147
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245086AbiCHTVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiCHTVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:21:39 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC1E522C9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:20:42 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KClXj1DXwz9sSc;
        Tue,  8 Mar 2022 20:20:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CCMx9MW4Oc7a; Tue,  8 Mar 2022 20:20:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KClXh5yv9z9sSW;
        Tue,  8 Mar 2022 20:20:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B0C608B787;
        Tue,  8 Mar 2022 20:20:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id A5vKgD-So7go; Tue,  8 Mar 2022 20:20:36 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.9])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 382348B780;
        Tue,  8 Mar 2022 20:20:36 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 228JKTBQ3553849
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 8 Mar 2022 20:20:29 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 228JKTDR3553848;
        Tue, 8 Mar 2022 20:20:29 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 3/6] powerpc: Include asm/reg.h in asm/svm.h
Date:   Tue,  8 Mar 2022 20:20:22 +0100
Message-Id: <482c82c8a29d5fb3ea279b34f107e0e775001344.1646767214.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3c88286b55413730d7784133993a46ef4a3607ce.1646767214.git.christophe.leroy@csgroup.eu>
References: <3c88286b55413730d7784133993a46ef4a3607ce.1646767214.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1646767223; l=606; s=20211009; h=from:subject:message-id; bh=anc1lMgqg6w9mMWvGbSgsrpDPLJ4FM21VRuna603bRQ=; b=jxuzxf0Mjm/oxp4QDSR7PuVt+/f6gZ3grWU8yEqaEBb7TfRftcSuJ8uoFFfjTuTbv9n0TKhYn0h7 3BcPKjEFAsr/naobOwPsX2hQof03Yb+d38VnnYKIl94uWT9vFBVZ
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

is_secure_guest() uses mfmsr().

Don't rely on users to include asm/reg.h, include
it in asm/svm.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/svm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/svm.h b/arch/powerpc/include/asm/svm.h
index 7546402d796a..da864623cc00 100644
--- a/arch/powerpc/include/asm/svm.h
+++ b/arch/powerpc/include/asm/svm.h
@@ -10,6 +10,8 @@
 
 #ifdef CONFIG_PPC_SVM
 
+#include <asm/reg.h>
+
 static inline bool is_secure_guest(void)
 {
 	return mfmsr() & MSR_S;
-- 
2.34.1

