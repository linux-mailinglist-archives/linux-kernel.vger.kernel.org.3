Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEA24EE022
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiCaSIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiCaSIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:08:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA9DF7F70
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648750017; x=1680286017;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YEbwJP9GFUenAe+EQybNiKrHwY+6D3cWC/NUVWO2ZKI=;
  b=PZe0DhhCKvcPziBBUZ4y0SOduxn+bl6/IHy5wkitO8Tan35iMyn5egxY
   8vjyfhSYSm71xtzIj4NGRB3gaTRMNoUQvzrDTmO877+xiTlKtcUG8L7GY
   gEk7YAFQ4Py/VpXiem7yhIjczgqfITzsolipmtiqziLxTPOBT5May385W
   T0xkg+ilsFADshTgOtEpFL1PLwAC16+M+W5OkArP21OfYICZAuCMU06KB
   I5R0F8t5FcvThLTCrbkLyg57OvDst3xPgh/8Whm5C28psVqSfLaG7T2ix
   lhO1692ySWzvCeD2Ew/g+FF7GqAD2bUlIB6Q0e8jF1ZGvenZIDAzLEdT/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="242063459"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="242063459"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 11:06:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="695579999"
Received: from jccornej-mobl.amr.corp.intel.com (HELO localhost) ([10.213.179.11])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 11:06:56 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, Ira Weiny <ira.weiny@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] x86/pkeys: Remove __arch_set_user_pkey_access() declaration
Date:   Thu, 31 Mar 2022 11:06:55 -0700
Message-Id: <20220331180655.2946086-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

In the x86 code __arch_set_user_pkey_access() is not used and is not
defined.

Remove the dead declaration.

To: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
This is a resend of a patch[1] which was originally part of a larger clean up
series.  Dave asked that the type clean up be reworked but the first 2 patches
are separate from that work and should stand on their own.

Resending this patch for inclusion on it's own.

[1] https://lore.kernel.org/lkml/20220311005742.1060992-3-ira.weiny@intel.com/

Changes from V1:
	Make this part of a series of pkey clean ups
---
 arch/x86/include/asm/pkeys.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 9c530530b9a7..2e6c04d8a45b 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -41,9 +41,6 @@ static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 	return __arch_override_mprotect_pkey(vma, prot, pkey);
 }
 
-extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val);
-
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | VM_PKEY_BIT3)
 
 #define mm_pkey_allocation_map(mm)	(mm->context.pkey_allocation_map)
@@ -118,9 +115,6 @@ int mm_pkey_free(struct mm_struct *mm, int pkey)
 	return 0;
 }
 
-extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val);
-
 static inline int vma_pkey(struct vm_area_struct *vma)
 {
 	unsigned long vma_pkey_mask = VM_PKEY_BIT0 | VM_PKEY_BIT1 |
-- 
2.35.1

