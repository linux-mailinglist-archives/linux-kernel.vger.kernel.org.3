Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5292654AE62
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbiFNKc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiFNKcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:32:54 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A349644A03
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:32:52 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LMlBW0plsz9tNv;
        Tue, 14 Jun 2022 12:32:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bsPYr4BZZ_EQ; Tue, 14 Jun 2022 12:32:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LMlBV6z28z9tNR;
        Tue, 14 Jun 2022 12:32:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DDDC58B770;
        Tue, 14 Jun 2022 12:32:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id G1sUIy5BS-zF; Tue, 14 Jun 2022 12:32:50 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.246])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8A4BF8B766;
        Tue, 14 Jun 2022 12:32:50 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 25EAWak1197833
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 12:32:36 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 25EAWaAj197832;
        Tue, 14 Jun 2022 12:32:36 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/32: Remove 'noltlbs' kernel parameter
Date:   Tue, 14 Jun 2022 12:32:24 +0200
Message-Id: <80ca17bd39cf608a8ebd0764d7064a498e131199.1655202721.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <6977314c823cfb728bc0273cea634b41807bfb64.1655202721.git.christophe.leroy@csgroup.eu>
References: <6977314c823cfb728bc0273cea634b41807bfb64.1655202721.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1655202743; l=2844; s=20211009; h=from:subject:message-id; bh=u+4yVZb+JJMZPzJhIbjgsKi87+KwAbZl8WpLuODPTOc=; b=tyhdkrAGBH0G0DidFGlGWZJpj8ovM2duJZrpz2TLihISXfWm+4+GVk+XnDi8Thm2rmH3xh3soOs3 OmX7/W39CsDc53Mb7GWT60V5ZEKuGNzicyjDZGfVyxsTANuH9Rlo
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

Mapping without large TLBs has no added value on the 8xx.

Mapping without large TLBs is still necessary on 40x when
selecting CONFIG_KFENCE or CONFIG_DEBUG_PAGEALLOC or
CONFIG_STRICT_KERNEL_RWX, but this is done automatically
and doesn't require user selection.

Remove 'noltlbs' kernel parameter, the user has no reason
to use it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ---
 arch/powerpc/mm/init_32.c                       | 3 ---
 arch/powerpc/mm/nohash/8xx.c                    | 9 ---------
 3 files changed, 15 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 96de3f1ece00..2322e429150d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3661,9 +3661,6 @@
 
 	nolapic_timer	[X86-32,APIC] Do not use the local APIC timer.
 
-	noltlbs		[PPC] Do not use large page/tlb entries for kernel
-			lowmem mapping on PPC40x and PPC8xx
-
 	nomca		[IA-64] Disable machine check abort handling
 
 	nomce		[X86-32] Disable Machine Check Exception
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 321794747ea1..6f2e6210c273 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -79,9 +79,6 @@ unsigned long __max_low_memory = MAX_LOW_MEM;
  */
 static void __init MMU_setup(void)
 {
-	if (strstr(boot_command_line, "noltlbs")) {
-		__map_without_ltlbs = 1;
-	}
 	if (IS_ENABLED(CONFIG_PPC_8xx))
 		return;
 
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 27f9186ae374..6b668ccef836 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -14,8 +14,6 @@
 
 #define IMMR_SIZE (FIX_IMMR_SIZE << PAGE_SHIFT)
 
-extern int __map_without_ltlbs;
-
 static unsigned long block_mapped_ram;
 
 /*
@@ -28,8 +26,6 @@ phys_addr_t v_block_mapped(unsigned long va)
 
 	if (va >= VIRT_IMMR_BASE && va < VIRT_IMMR_BASE + IMMR_SIZE)
 		return p + va - VIRT_IMMR_BASE;
-	if (__map_without_ltlbs)
-		return 0;
 	if (va >= PAGE_OFFSET && va < PAGE_OFFSET + block_mapped_ram)
 		return __pa(va);
 	return 0;
@@ -45,8 +41,6 @@ unsigned long p_block_mapped(phys_addr_t pa)
 
 	if (pa >= p && pa < p + IMMR_SIZE)
 		return VIRT_IMMR_BASE + pa - p;
-	if (__map_without_ltlbs)
-		return 0;
 	if (pa < block_mapped_ram)
 		return (unsigned long)__va(pa);
 	return 0;
@@ -153,9 +147,6 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 
 	mmu_mapin_immr();
 
-	if (__map_without_ltlbs)
-		return 0;
-
 	mmu_mapin_ram_chunk(0, boundary, PAGE_KERNEL_TEXT, true);
 	if (debug_pagealloc_enabled_or_kfence()) {
 		top = boundary;
-- 
2.36.1

