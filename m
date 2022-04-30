Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC5E516001
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244695AbiD3TPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 15:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244424AbiD3TO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 15:14:59 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B844E38A;
        Sat, 30 Apr 2022 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IlwtJiGEzRBQNkXB4OYUXQhdmFsNAW7ggPHGnYRYMHQ=;
  b=eTRqWaybQCkDBQ4k7O03aG2w1jVL+sqyc88IA8KkGo65A9hpT59X1S13
   gYhLceNMvnNGnmgLw5uktM4CmW3DbBozI3/Je27DpfjD4IMO04MeGunZa
   YACpRm7rkaFEPiVnvhJFqBLTADNmqpcAElqZwOztYw+eRPfPNS0HtDLh6
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,188,1647298800"; 
   d="scan'208";a="34084616"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 21:11:32 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     kernel-janitors@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: fix typos in comments
Date:   Sat, 30 Apr 2022 21:11:17 +0200
Message-Id: <20220430191122.8667-3-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/riscv/kernel/module-sections.c |    2 +-
 arch/riscv/mm/context.c             |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/module-sections.c b/arch/riscv/kernel/module-sections.c
index e264e59e596e..00e0700601b3 100644
--- a/arch/riscv/kernel/module-sections.c
+++ b/arch/riscv/kernel/module-sections.c
@@ -119,7 +119,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		return -ENOEXEC;
 	}
 
-	/* Calculate the maxinum number of entries */
+	/* Calculate the maximum number of entries */
 	for (i = 0; i < ehdr->e_shnum; i++) {
 		Elf_Rela *relas = (void *)ehdr + sechdrs[i].sh_offset;
 		int num_rela = sechdrs[i].sh_size / sizeof(Elf_Rela);
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 7acbfbd14557..bc676b7a62e9 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -159,7 +159,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 	 *
 	 * - We get a zero back from the cmpxchg and end up waiting on the
 	 *   lock. Taking the lock synchronises with the rollover and so
-	 *   we are forced to see the updated verion.
+	 *   we are forced to see the updated version.
 	 *
 	 * - We get a valid context back from the cmpxchg then we continue
 	 *   using old ASID because __flush_context() would have marked ASID
@@ -228,7 +228,7 @@ static int __init asids_init(void)
 	/*
 	 * In the process of determining number of ASID bits (above)
 	 * we polluted the TLB of current HART so let's do TLB flushed
-	 * to remove unwanted TLB enteries.
+	 * to remove unwanted TLB entries.
 	 */
 	local_flush_tlb_all();
 

