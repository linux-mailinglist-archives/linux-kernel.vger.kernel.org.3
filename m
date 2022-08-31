Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098215A7A41
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiHaJc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiHaJcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:32:52 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871F0CCE1F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:32:39 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MHf8w2g8Zz9shQ;
        Wed, 31 Aug 2022 11:32:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nP_dtVeJEFMh; Wed, 31 Aug 2022 11:32:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MHf8v6v20z9sVQ;
        Wed, 31 Aug 2022 11:32:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A7FEC8B77C;
        Wed, 31 Aug 2022 11:32:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TzbTF0k_eXSf; Wed, 31 Aug 2022 11:32:31 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8CC1F8B77A;
        Wed, 31 Aug 2022 11:32:31 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 27V9WLIV1567821
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 11:32:22 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 27V9WLbL1567819;
        Wed, 31 Aug 2022 11:32:21 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc/32: Drop a stale comment about reservation of gigantic pages
Date:   Wed, 31 Aug 2022 11:32:07 +0200
Message-Id: <959d77be630b9b46a7458f0fbd41dc3a94ec811a.1661938317.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661938326; l=901; s=20211009; h=from:subject:message-id; bh=tHSDT9CTA6GCiPkeZK97CXOxpSP62dUewYqVQMBtnQo=; b=j0bNmjByZf/JT3zBPgkHN/wxxsA3D6ZxA041/qnNSA3BwHKbH+LEzV2k2m2q9Ebi8ScL6Lk7R33q PwI9uimVDlQqMJfEbxFDy/g1NI/mjN0ArFzoH6fZni8YAnzhc6+x
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

A comment about the reservation of gigantic pages was left in MMU_init()
after commit 79cc38ded1e1 ("powerpc/mm/hugetlb: Add support for
reserving gigantic huge pages via kernel command line")

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/init_32.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 62d9af6606cd..50de41042c0a 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -82,10 +82,6 @@ void __init MMU_init(void)
 	if (ppc_md.progress)
 		ppc_md.progress("MMU:enter", 0x111);
 
-	/*
-	 * Reserve gigantic pages for hugetlb.  This MUST occur before
-	 * lowmem_end_addr is initialized below.
-	 */
 	if (memblock.memory.cnt > 1) {
 #ifndef CONFIG_WII
 		memblock_enforce_memory_limit(memblock.memory.regions[0].size);
-- 
2.37.1

