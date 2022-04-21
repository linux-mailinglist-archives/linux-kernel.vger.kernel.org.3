Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A5F50A9F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392358AbiDUU2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392334AbiDUU2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:28:44 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDC94A93F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:25:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VAhmMxq_1650572745;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VAhmMxq_1650572745)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Apr 2022 04:25:47 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     vgupta@kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] clean up some inconsistent indenting
Date:   Fri, 22 Apr 2022 04:25:43 +0800
Message-Id: <20220421202543.129342-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:

./arch/arc/kernel/disasm.c:512:2-28: code aligned with following code on
line 517.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/arc/kernel/disasm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/kernel/disasm.c b/arch/arc/kernel/disasm.c
index 1e1db51b6941..412f2c794593 100644
--- a/arch/arc/kernel/disasm.c
+++ b/arch/arc/kernel/disasm.c
@@ -514,13 +514,13 @@ int __kprobes disasm_next_pc(unsigned long pc, struct pt_regs *regs,
 	/* For the instructions with delay slots, the fall through is the
 	 * instruction following the instruction in delay slot.
 	 */
-	 if (instr.delay_slot) {
+	if (instr.delay_slot) {
 		struct disasm_state instr_d;
 
 		disasm_instr(*next_pc, &instr_d, 0, regs, cregs);
 
 		*next_pc += instr_d.instr_len;
-	 }
+	}
 
 	 /* Zero Overhead Loop - end of the loop */
 	if (!(regs->status32 & STATUS32_L) && (*next_pc == regs->lp_end)
-- 
2.20.1.7.g153144c

