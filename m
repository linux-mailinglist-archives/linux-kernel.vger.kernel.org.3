Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8E94D570B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245604AbiCKA7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 19:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242170AbiCKA7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:59:39 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E0AE98CB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646960316; x=1678496316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9siIY6FLOfYc5ocEKvjG/SmhAvdKrtM6lD3UINVbS4o=;
  b=L/2wjF/BVcJhdc1j76K2+HYNgL3x0S4U5JOh5AxeICY6V1ZUWjuOjfe/
   zwOSQlAp3me7JX6GLepFJxE6xuQtppIWoj1XQwaL7fEJW5RTOt/IsDgKg
   1Ig1v13RU7ZrSeEXCMCvdwnvFRUgWpnaBSzVWLqrmVrnFrGzfHIyvbzqT
   iNeJVkgQ/s5ebbKU6zdlPqXCZQnE9pHBHnefRW/I5zC2je8M0xBKQ944k
   gwQjxoshtUHFYJD0VZSVywV7YuYfyMRuirKZY5zavE5PmiBVSPEeXi8oO
   wPn3EMWK9XNnd6577IoipEjjqVXwXbNQ69PlEG6JPSKfI40uPkX3rN0rI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255405805"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="255405805"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 16:57:46 -0800
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="554989174"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 16:57:46 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] x86/pkeys: Remove __arch_set_user_pkey_access() declaration
Date:   Thu, 10 Mar 2022 16:57:39 -0800
Message-Id: <20220311005742.1060992-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311005742.1060992-1-ira.weiny@intel.com>
References: <20220311005742.1060992-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

