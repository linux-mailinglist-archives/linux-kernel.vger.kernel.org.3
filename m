Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC304EE01E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiCaSHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiCaSHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:07:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F80231AF7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648749958; x=1680285958;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xth3KXsNwWBTtSUKoBZ9z4UPFb5Rq2UtgMAzsLzZtQw=;
  b=DmY7Pe8HCVO8vK1efZn2FPEpm6RKuyu5bAGAjdqcyCzR/4dEqkevluyl
   P/+NzMmFFdISTsiJLzLcVMip0Ry7WKV51VrSGQAC9OU3iQWSSyALCmVhf
   5qaqyaDP1VJAHqo+BrFJIx6oZgEUB4v0v/rPvPnUphcJ+vShmDgIQkPMY
   X/EUGnm0peofPRvNEOpshRUQR5NQp00IUAr5B04CBSKA/lff04W9J8B9z
   JRarH3JN2pfGxdZQTgLTmFsnX8SnCxqS8KalfjuDYFCwAl+hAfjrK2yAs
   BcjOiAP8k8G2/xOgSySYIzRovK7ZihpxzWXyBLRyUJV6Kx+DXp1JJg+UR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259891743"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="259891743"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 11:05:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="720560502"
Received: from jccornej-mobl.amr.corp.intel.com (HELO localhost) ([10.213.179.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 11:05:56 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, Ira Weiny <ira.weiny@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] x86/pkeys: Clean up arch_set_user_pkey_access() declaration
Date:   Thu, 31 Mar 2022 11:05:54 -0700
Message-Id: <20220331180554.2945884-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

arch_set_user_pkey_access() was declared two times in the header.

Remove the 2nd declaration.

Suggested-by: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
This is a resend of a patch[1] which was originally part of a larger clean up
series.  Dave asked that the type clean up be reworked but the first 2 patches
are separate from that work and should stand on their own.

Resending this patch for inclusion on it's own.

[1] https://lore.kernel.org/lkml/20220311005742.1060992-2-ira.weiny@intel.com/
---
 arch/x86/include/asm/pkeys.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 1d5f14aff5f6..9c530530b9a7 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -118,8 +118,6 @@ int mm_pkey_free(struct mm_struct *mm, int pkey)
 	return 0;
 }
 
-extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val);
 extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
 
-- 
2.35.1

