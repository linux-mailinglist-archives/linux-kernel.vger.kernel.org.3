Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6844DD80D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiCRKjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiCRKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:06 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37E82DA687;
        Fri, 18 Mar 2022 03:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N/9zY6kwV17gsyVNd3FFvTsp125B/Zcm/47dITBG9R0=;
  b=vRnlJoKTsI0fv0/a8YiYZwsryOr+uxlcT64hXLZwM2Fhlv6ngntqhWsN
   03lRZzXsPoeLqb6+xDux3ZT6TtakGSu3obZ7whwEn8olR3avKjzMD3mnw
   aQajvrLsC5b9PXKHk4/2TXXUVDAD/f/cd33NSgxwSigZww6vSd/PR8xdV
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935644"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:37 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Russell King <linux@armlinux.org.uk>
Cc:     kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/arm: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:07 +0100
Message-Id: <20220318103729.157574-12-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/arm/common/scoop.c           |    2 +-
 arch/arm/kernel/setup.c           |    2 +-
 arch/arm/kernel/suspend.c         |    2 +-
 arch/arm/kernel/sys_oabi-compat.c |    2 +-
 arch/arm/kernel/unwind.c          |    2 +-
 arch/arm/kernel/vdso.c            |    2 +-
 arch/arm/mm/cache-l2x0.c          |    4 ++--
 arch/arm/mm/fault.c               |    2 +-
 arch/arm/probes/decode.c          |    2 +-
 arch/arm/probes/kprobes/opt-arm.c |    4 ++--
 10 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index e74c5bfdc6d3..f6684947f0ec 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -23,7 +23,7 @@
    is used which is setup by the platform code.
 
    This file is never modular so this symbol is always
-   accessile to the board support files.
+   accessible to the board support files.
 */
 struct scoop_pcmcia_config *platform_scoop_config;
 EXPORT_SYMBOL(platform_scoop_config);
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 039feb7cd590..2ab767e49332 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -861,7 +861,7 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
 
 		/*
 		 * In memblock, end points to the first byte after the
-		 * range while in resourses, end points to the last byte in
+		 * range while in resources, end points to the last byte in
 		 * the range.
 		 */
 		res_end = end - 1;
diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 43f0a3ebf390..d3426266a9cd 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -27,7 +27,7 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 		return -EINVAL;
 
 	/*
-	 * Function graph tracer state gets incosistent when the kernel
+	 * Function graph tracer state gets inconsistent when the kernel
 	 * calls functions that never return (aka suspend finishers) hence
 	 * disable graph tracing during their execution.
 	 */
diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index 68112c172025..e39389ca0ad2 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -474,7 +474,7 @@ asmlinkage long sys_oabi_sendmsg(int fd, struct user_msghdr __user *msg, unsigne
 		 * we should do for what is actually a transitional
 		 * compatibility layer.  This already has known flaws with
 		 * a few ioctls that we don't intend to fix.  Therefore
-		 * consider this blatent hack as another one... and take care
+		 * consider this blatant hack as another one... and take care
 		 * to run for cover.  In most cases it will "just work fine".
 		 * If it doesn't, well, tough.
 		 */
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 04ccff9d9793..857a94195d96 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -120,7 +120,7 @@ static const struct unwind_idx *search_index(unsigned long addr,
 		/* positive offsets: [origin; stop) */
 		start = origin;
 
-	/* prel31 for address relavive to start */
+	/* prel31 for address relative to start */
 	addr_prel31 = (addr - (unsigned long)start) & 0x7fffffff;
 
 	while (start < stop - 1) {
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 3408269d19c7..890eec79d02f 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -68,7 +68,7 @@ struct elfinfo {
 };
 
 /* Cached result of boot-time check for whether the arch timer exists,
- * and if so, whether the virtual counter is useable.
+ * and if so, whether the virtual counter is usable.
  */
 bool cntvct_ok __ro_after_init;
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 43d91bfd2360..4143102af42c 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -932,7 +932,7 @@ static u32 cache_id_part_number_from_dt;
 /**
  * l2x0_cache_size_of_parse() - read cache size parameters from DT
  * @np: the device tree node for the l2 cache
- * @aux_val: pointer to machine-supplied auxilary register value, to
+ * @aux_val: pointer to machine-supplied auxiliary register value, to
  * be augmented by the call (bits to be set to 1)
  * @aux_mask: pointer to machine-supplied auxilary register mask, to
  * be augmented by the call (bits to be set to 0)
@@ -1380,7 +1380,7 @@ static void aurora_pa_range(unsigned long start, unsigned long end,
 	unsigned long flags;
 
 	/*
-	 * round start and end adresses up to cache line size
+	 * round start and end addresses up to cache line size
 	 */
 	start &= ~(CACHE_LINE_SIZE - 1);
 	end = ALIGN(end, CACHE_LINE_SIZE);
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index a062e07516dd..1cf525391d2d 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -454,7 +454,7 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
 	 * On ARM one Linux PGD entry contains two hardware entries (see page
 	 * tables layout in pgtable.h). We normally guarantee that we always
 	 * fill both L1 entries. But create_mapping() doesn't follow the rule.
-	 * It can create inidividual L1 entries, so here we have to call
+	 * It can create individual L1 entries, so here we have to call
 	 * pmd_none() check for the entry really corresponded to address, not
 	 * for the first of pair.
 	 */
diff --git a/arch/arm/probes/decode.c b/arch/arm/probes/decode.c
index c84053a81358..8281c409e07c 100644
--- a/arch/arm/probes/decode.c
+++ b/arch/arm/probes/decode.c
@@ -426,7 +426,7 @@ probes_decode_insn(probes_opcode_t insn, struct arch_probes_insn *asi,
 	 * stack_space is initialized to 0 here. Checker functions
 	 * should update is value if they find this is a stack store
 	 * instruction: positive value means bytes of stack usage,
-	 * negitive value means unable to determine stack usage
+	 * negative value means unable to determine stack usage
 	 * statically. For instruction doesn't store to stack, checker
 	 * do nothing with it.
 	 */
diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index dbef34ed933f..4a4350f6ef69 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -216,7 +216,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
 	 *   (0xff800000 << 2) = 0xfe000000 = -0x2000000
 	 *
 	 * We can simply check (rel & 0xfe000003):
-	 *  if rel is positive, (rel & 0xfe000000) shoule be 0
+	 *  if rel is positive, (rel & 0xfe000000) should be 0
 	 *  if rel is negitive, (rel & 0xfe000000) should be 0xfe000000
 	 *  the last '3' is used for alignment checking.
 	 */
@@ -309,7 +309,7 @@ void __kprobes arch_optimize_kprobes(struct list_head *oplist)
 
 		/*
 		 * Make it a conditional branch if replaced insn
-		 * is consitional
+		 * is conditional
 		 */
 		insn = (__mem_to_opcode_arm(
 			  op->optinsn.copied_insn[0]) & 0xf0000000) |

