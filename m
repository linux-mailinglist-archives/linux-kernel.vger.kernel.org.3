Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C81051EB1B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 04:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbiEHCzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 22:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiEHCzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 22:55:17 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231686563;
        Sat,  7 May 2022 19:51:24 -0700 (PDT)
X-QQ-mid: bizesmtp78t1651978241tgond22p
Received: from localhost.localdomain ( [125.69.42.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 08 May 2022 10:50:40 +0800 (CST)
X-QQ-SSF: 01000000002000E0S000C00A0000000
X-QQ-FEAT: im3L/SzDuHYyWldDO1MD7H/CQLw8bZbCJrMxX07vIPI5P8XmxqG3GJl030K4l
        kSOVkxQxmMNM4qsBGQoMGQCC4HSBcOZup/rMRGoSVlsbyIbVXpivouKya90YEuy8vUy/owa
        zx79y8eeIxI/1VWoCIw0E81ISMEq1BUvWPUp9IDH/0rBxmDgjBt09suKVvFsYcHBCaW1h3o
        c8yt8opibY770EVtxbMmedeFenEj0VWplptMwNrrn2YFNSco09BXW9XYqEIDs7y5Ndb0lru
        tIIMVNTUYcUurJ+xIdJXJWQs9mr/FvcjpZh0vxmdFCo7wDZke8TCgHNkzQOFqC+L74tn+o/
        67NTFpmz0YOnz4+ltk=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     davem@davemloft.net
Cc:     ebiederm@xmission.com, arnd@arndb.de, wangborong@cdjrlc.com,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc64: Fix typos in some commnets
Date:   Sun,  8 May 2022 10:50:37 +0800
Message-Id: <20220508025037.114952-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `new' and `Trap' in the comments in line 914 and 2601 are
repeated. Fix them in the comments.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/sparc/kernel/traps_64.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 5b4de4a89dec..8c641793b4ac 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -114,7 +114,7 @@ void bad_trap(struct pt_regs *regs, long lvl)
 void bad_trap_tl1(struct pt_regs *regs, long lvl)
 {
 	char buffer[36];
-	
+
 	if (notify_die(DIE_TRAP_TL1, "bad trap tl1", regs,
 		       0, lvl, SIGTRAP) == NOTIFY_STOP)
 		return;
@@ -911,7 +911,7 @@ void __init cheetah_ecache_flush_init(void)
 	memset(cheetah_error_log, 0, PAGE_SIZE << order);
 
 	/* Mark all AFSRs as invalid so that the trap handler will
-	 * log new new information there.
+	 * log new information there.
 	 */
 	for (i = 0; i < 2 * NR_CPUS; i++)
 		cheetah_error_log[i].afsr = CHAFSR_INVALID;
@@ -1762,7 +1762,7 @@ void cheetah_deferred_handler(struct pt_regs *regs, unsigned long afsr, unsigned
  * Bit1:	0=recoverable,1=unrecoverable
  *
  * The hardware has disabled both the I-cache and D-cache in
- * the %dcr register.  
+ * the %dcr register.
  */
 void cheetah_plus_parity_error(int type, struct pt_regs *regs)
 {
@@ -2433,10 +2433,10 @@ static void user_instruction_dump(unsigned int __user *pc)
 {
 	int i;
 	unsigned int buf[9];
-	
+
 	if ((((unsigned long) pc) & 3))
 		return;
-		
+
 	if (copy_from_user(buf, pc - 3, sizeof(buf)))
 		return;
 
@@ -2520,7 +2520,7 @@ void __noreturn die_if_kernel(char *str, struct pt_regs *regs)
 {
 	static int die_counter;
 	int count = 0;
-	
+
 	/* Amuse the user. */
 	printk(
 "              \\|/ ____ \\|/\n"
@@ -2598,7 +2598,7 @@ void do_illegal_instruction(struct pt_regs *regs)
 				/* On UltraSPARC T2 and later, FPU insns which
 				 * are not implemented in HW signal an illegal
 				 * instruction trap and do not set the FP Trap
-				 * Trap in the %fsr to unimplemented_FPop.
+				 * in the %fsr to unimplemented_FPop.
 				 */
 				if (do_mathemu(regs, f, true))
 					goto out;
-- 
2.35.1

