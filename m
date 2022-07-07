Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E19456A55D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiGGO1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbiGGO1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:27:42 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20C12A728
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:27:41 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LdzJk0fHVz9tGm;
        Thu,  7 Jul 2022 16:27:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k4DggKmM7fg1; Thu,  7 Jul 2022 16:27:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LdzJj2BKqz9tGf;
        Thu,  7 Jul 2022 16:27:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3BFD88B768;
        Thu,  7 Jul 2022 16:27:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id J6us5qpzTv23; Thu,  7 Jul 2022 16:27:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.174])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F1A168B79F;
        Thu,  7 Jul 2022 16:27:32 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 267ERNui537821
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 7 Jul 2022 16:27:23 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 267ERNUb537820;
        Thu, 7 Jul 2022 16:27:23 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/4] powerpc: Remove asm/prom.h from asm/mpc52xx.h and asm/pci.h
Date:   Thu,  7 Jul 2022 16:27:03 +0200
Message-Id: <22ac0b64b6c6ef6cc6a74739eb213a81372835ed.1657204012.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <d107b9ed8b4ba5d10d1df7ba6317c36d07f2317e.1657204012.git.christophe.leroy@csgroup.eu>
References: <d107b9ed8b4ba5d10d1df7ba6317c36d07f2317e.1657204012.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1657204023; l=1314; s=20211009; h=from:subject:message-id; bh=8JYg+XQwKydickUlUfEBn/l2xGaPEQciUidVj/hrP7c=; b=sPZnMiBBGVit9gZ3BOxLKjdfEGzBvXpeF+yrwLFMBDun6+EmcCL7rnbtKkJ4Z9pCBFNfuqYJ+ySV 6A7/HbrqA7QeSXzC1QXHes5Tkw1LwJscu5IlytN5NG6XWans4T1W
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

asm/pci.h and asm/mpc52xx.h don't need asm/prom.h

Declare struct device_node locally to avoid including of.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/mpc52xx.h | 3 ++-
 arch/powerpc/include/asm/pci.h     | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/mpc52xx.h
index ddd80aae1e32..5ea16a71c2f0 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -15,7 +15,6 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
-#include <asm/prom.h>
 #include <asm/mpc5xxx.h>
 #endif /* __ASSEMBLY__ */
 
@@ -268,6 +267,8 @@ struct mpc52xx_intr {
 
 #ifndef __ASSEMBLY__
 
+struct device_node;
+
 /* mpc52xx_common.c */
 extern void mpc5200_setup_xlb_arbiter(void);
 extern void mpc52xx_declare_of_platform_devices(void);
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 915d6ee4b40a..0f182074cdb7 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -14,7 +14,6 @@
 
 #include <asm/machdep.h>
 #include <asm/io.h>
-#include <asm/prom.h>
 #include <asm/pci-bridge.h>
 
 /* Return values for pci_controller_ops.probe_mode function */
-- 
2.36.1

