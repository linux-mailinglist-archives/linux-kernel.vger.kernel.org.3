Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBA75547D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244188AbiFVIzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiFVIyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:54:55 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232C933E3F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:54:49 -0700 (PDT)
X-QQ-mid: bizesmtp76t1655887989togn26qh
Received: from localhost.localdomain ( [125.70.163.206])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 16:52:59 +0800 (CST)
X-QQ-SSF: 0100000000200020B000B00A0000000
X-QQ-FEAT: ZHWZeLXy+8cAGDHlEZHd9IMqRPzENME2uMpfC0U9UD27/BXGabDDUSm1kFRkZ
        BTMVjHC3G8aB1ec3tX0NIJT0U0CKAYWw7ChyyO1R4N5xcGz2B6f+8CSiuI6Ln4f3ZOBEFz4
        7ZON7M0u2HY1wb8BXN0pykcAZpP0tV3ahlFkVDEc7vTiYSp1SIwKeeHMryTYRDktnvWjQgu
        ykOKQ9f1YVO2lIEnZ26C53HqY7hXJar5Ib7udZlnqRwz6lCztmncEr/BAAAHYcIAme7IUdF
        A684zM8Yn5E2LD7sh3ohdV7pKWJUKqAboqzCMugtQGXS2ttzcw4ZqppjftPxJaM2M5aVuzw
        JqjbdKOWWb3CRPgDO5WSsYiHYADAg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     linux@armlinux.org.uk, mark.rutland@arm.com, mcgrof@kernel.org,
        paulmck@kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] arm:mm:Fix typo in comment
Date:   Wed, 22 Jun 2022 16:52:52 +0800
Message-Id: <20220622085252.31387-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'ARM'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/arm/mm/alignment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 6f499559d193..adf1ebd911a6 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -597,7 +597,7 @@ do_alignment_ldmstm(unsigned long addr, u32 instr, struct pt_regs *regs)
  * to convert only Thumb ld/st instruction forms to equivalent ARM forms.
  *
  * NOTES:
- * 1. Comments below refer to ARM ARM DDI0100E Thumb Instruction sections.
+ * 1. Comments below refer to ARM DDI0100E Thumb Instruction sections.
  * 2. If for some reason we're passed an non-ld/st Thumb instruction to
  *    decode, we return 0xdeadc0de. This should never happen under normal
  *    circumstances but if it does, we've got other problems to deal with
-- 
2.36.1

