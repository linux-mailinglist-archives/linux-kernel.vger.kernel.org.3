Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8D45B24ED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiIHRlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiIHRj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:39:57 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4055D11A0E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:39:29 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MNmYx6NGvz9sks;
        Thu,  8 Sep 2022 19:38:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5wQZlthlj9g1; Thu,  8 Sep 2022 19:38:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MNmYj4ww8z9smR;
        Thu,  8 Sep 2022 19:38:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8117C8B790;
        Thu,  8 Sep 2022 19:38:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id g2OizmFAtnfx; Thu,  8 Sep 2022 19:38:17 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.247])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 32B218B794;
        Thu,  8 Sep 2022 19:38:17 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 288HcDab3449209
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 19:38:13 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 288HcDvX3449208;
        Thu, 8 Sep 2022 19:38:13 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 17/19] powerpc: Simplify redundant Kconfig tests
Date:   Thu,  8 Sep 2022 19:37:50 +0200
Message-Id: <a274e2da320ab42a445e4853cbe5b08d08c60d03.1662658653.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <4e7e6259e5af0e0e171f19ee1f85ab5b2553723f.1662658653.git.christophe.leroy@csgroup.eu>
References: <4e7e6259e5af0e0e171f19ee1f85ab5b2553723f.1662658653.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662658668; l=1787; s=20211009; h=from:subject:message-id; bh=usDIwDyET2HPqvzqheQPwxWf+mlVIrCjZAGd5cXNP78=; b=OSXLMbKQok7YSYk7Ejj5BpBYcP/eqrmk0zgIZvgGB773jWssJrva+lzE4C5YB8nLiUif31XsvRMC LfFl+qLbAONs3qlDjWa7kHF5zXUeddv7FwdmG6hyG4mR506V9ruQ
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

PPC_85xx implies PPC32 so no need to check PPC32 in addition.

PPC64 && !PPC_BOOK3E_64 means PPC_BOOK3S_64.

PPC_BOOK3E_64 implies PPC_E500.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig                   | 2 +-
 arch/powerpc/platforms/Kconfig.cputype | 2 +-
 arch/powerpc/xmon/xmon.c               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1e6346dcb1b4..da9bd5db1643 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -606,7 +606,7 @@ config RELOCATABLE
 
 config RANDOMIZE_BASE
 	bool "Randomize the address of the kernel image"
-	depends on (PPC_85xx && FLATMEM && PPC32)
+	depends on PPC_85xx && FLATMEM
 	depends on RELOCATABLE
 	help
 	  Randomizes the virtual address at which the kernel image is
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 6a216e88423b..51059af63856 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -314,7 +314,7 @@ config 4xx
 
 config BOOKE
 	bool
-	depends on PPC_E500 || 44x || PPC_BOOK3E_64
+	depends on PPC_E500 || 44x
 	default y
 
 config BOOKE_OR_40x
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e6d678d27b0f..f51c882bf902 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -288,7 +288,7 @@ Commands:\n\
   t	print backtrace\n\
   x	exit monitor and recover\n\
   X	exit monitor and don't recover\n"
-#if defined(CONFIG_PPC64) && !defined(CONFIG_PPC_BOOK3E_64)
+#if defined(CONFIG_PPC_BOOK3S_64)
 "  u	dump segment table or SLB\n"
 #elif defined(CONFIG_PPC_BOOK3S_32)
 "  u	dump segment registers\n"
-- 
2.37.1

