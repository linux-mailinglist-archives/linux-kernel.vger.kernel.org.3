Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F5B55E8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347258AbiF1OtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346126AbiF1OtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:49:20 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B33A2FFE1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:49:19 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LXSCx5Zh9z9tV3;
        Tue, 28 Jun 2022 16:49:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wHtOy6VykHm6; Tue, 28 Jun 2022 16:49:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LXSCx4mBkz9tTw;
        Tue, 28 Jun 2022 16:49:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 81D788B78B;
        Tue, 28 Jun 2022 16:49:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DuvdrfC0SIld; Tue, 28 Jun 2022 16:49:17 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.132])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D5AA8B787;
        Tue, 28 Jun 2022 16:49:17 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 25SEn7Nc2928195
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 16:49:07 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 25SEn7Pr2928194;
        Tue, 28 Jun 2022 16:49:07 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 3/6] powerpc/64e: Remove unused REGION related macros
Date:   Tue, 28 Jun 2022 16:48:56 +0200
Message-Id: <f0efde8cee0924c3991790042b176ac77ad35e1f.1656427701.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <8d6c5859a45935d6e1a336da4dc20be421e8cea7.1656427701.git.christophe.leroy@csgroup.eu>
References: <8d6c5859a45935d6e1a336da4dc20be421e8cea7.1656427701.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1656427736; l=1121; s=20211009; h=from:subject:message-id; bh=/6lgIkH0a+sUp+GzEVjVZdUOy9sJhPb83Ia6EKSIxX0=; b=DwRDBItJQIBz5QscbzVye4Pj29cLL+cBC0X5q6ss9OeH3RmxWP7gKkWWKI/kp+YLADuUsvQzq2wq 4eqEv0iGCLBJsGWfBU4osrcI8hc4nto/Xp2G12TD+eU/3auuSVBS
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

Those macros are not used anywhere. Remove them as they are soon
going to be wrong and are not worth modifying as they are not used.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/64/pgtable.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 57083f95e82b..db9770995f7c 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -57,18 +57,6 @@
 #define IOREMAP_END	(KERN_VIRT_START + KERN_VIRT_SIZE - FIXADDR_SIZE)
 #define FIXADDR_SIZE	SZ_32M
 
-
-/*
- * Region IDs
- */
-#define REGION_SHIFT		60UL
-#define REGION_MASK		(0xfUL << REGION_SHIFT)
-#define REGION_ID(ea)		(((unsigned long)(ea)) >> REGION_SHIFT)
-
-#define VMALLOC_REGION_ID	(REGION_ID(VMALLOC_START))
-#define KERNEL_REGION_ID	(REGION_ID(PAGE_OFFSET))
-#define USER_REGION_ID		(0UL)
-
 /*
  * Defines the address of the vmemap area, in its own region on
  * after the vmalloc space on Book3E
-- 
2.36.1

