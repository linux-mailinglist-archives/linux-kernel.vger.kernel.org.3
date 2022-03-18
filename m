Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA644DD823
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbiCRKi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiCRKi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:38:56 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8C72D6CB0;
        Fri, 18 Mar 2022 03:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sf+rc0zCqZilSU/qrDJuTcyDi78AjAWSo6ACkbY6BZo=;
  b=G2sp7wMcbS8S0AGy725LnJd9FgJ775FVsMriKe7eVeBOc1+8puvLfbEw
   63XGDfsCdsNXtMzIKlQAreoQptycDOY9LoPjgonE2PqSksyGe+1zTz7/1
   tYHziJYPDYWrLeYz6kybBd3WD0ifyePoNw92wh787xCDtO0cQmeHLD5am
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935627"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:35 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     linux-ia64@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: fix typos in comments
Date:   Fri, 18 Mar 2022 11:36:56 +0100
Message-Id: <20220318103729.157574-1-Julia.Lawall@inria.fr>
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
 arch/ia64/kernel/palinfo.c |    2 +-
 arch/ia64/kernel/traps.c   |    2 +-
 arch/ia64/mm/init.c        |    2 +-
 arch/ia64/mm/tlb.c         |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/kernel/palinfo.c b/arch/ia64/kernel/palinfo.c
index 64189f04c1a4..b9ae093bfe37 100644
--- a/arch/ia64/kernel/palinfo.c
+++ b/arch/ia64/kernel/palinfo.c
@@ -120,7 +120,7 @@ static const char *mem_attrib[]={
  * Input:
  *	- a pointer to a buffer to hold the string
  *	- a 64-bit vector
- * Ouput:
+ * Output:
  *	- a pointer to the end of the buffer
  *
  */
diff --git a/arch/ia64/kernel/traps.c b/arch/ia64/kernel/traps.c
index 753642366e12..53735b1d1be3 100644
--- a/arch/ia64/kernel/traps.c
+++ b/arch/ia64/kernel/traps.c
@@ -309,7 +309,7 @@ handle_fpu_swa (int fp_fault, struct pt_regs *regs, unsigned long isr)
 			/*
 			 * Lower 4 bits are used as a count. Upper bits are a sequence
 			 * number that is updated when count is reset. The cmpxchg will
-			 * fail is seqno has changed. This minimizes mutiple cpus
+			 * fail is seqno has changed. This minimizes multiple cpus
 			 * resetting the count.
 			 */
 			if (current_jiffies > last.time)
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 5d165607bf35..7ae1244ed8ec 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -451,7 +451,7 @@ mem_init (void)
 	memblock_free_all();
 
 	/*
-	 * For fsyscall entrpoints with no light-weight handler, use the ordinary
+	 * For fsyscall entrypoints with no light-weight handler, use the ordinary
 	 * (heavy-weight) handler, but mark it by setting bit 0, so the fsyscall entry
 	 * code can tell them apart.
 	 */
diff --git a/arch/ia64/mm/tlb.c b/arch/ia64/mm/tlb.c
index 135b5135cace..ca060e7a2a46 100644
--- a/arch/ia64/mm/tlb.c
+++ b/arch/ia64/mm/tlb.c
@@ -174,7 +174,7 @@ __setup("nptcg=", set_nptcg);
  * override table (in which case we should ignore the value from
  * PAL_VM_SUMMARY).
  *
- * Kernel parameter "nptcg=" overrides maximum number of simultanesous ptc.g
+ * Kernel parameter "nptcg=" overrides maximum number of simultaneous ptc.g
  * purges defined in either PAL_VM_SUMMARY or PAL override table. In this case,
  * we should ignore the value from either PAL_VM_SUMMARY or PAL override table.
  *
@@ -516,7 +516,7 @@ int ia64_itr_entry(u64 target_mask, u64 va, u64 pte, u64 log_size)
 	if (i >= per_cpu(ia64_tr_num, cpu))
 		return -EBUSY;
 
-	/*Record tr info for mca hander use!*/
+	/*Record tr info for mca handler use!*/
 	if (i > per_cpu(ia64_tr_used, cpu))
 		per_cpu(ia64_tr_used, cpu) = i;
 

