Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60B75549A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348472AbiFVJUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiFVJUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:20:48 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCB534658
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:20:43 -0700 (PDT)
X-QQ-mid: bizesmtp65t1655889601tfxsfpzc
Received: from localhost.localdomain ( [125.70.163.206])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 17:19:58 +0800 (CST)
X-QQ-SSF: 0100000000200030B000B00A0000000
X-QQ-FEAT: ZHWZeLXy+8ejSfIxg+wLadHO+sLx+2HiQEmbxvSxNoHw060Wpq2KupNp3Vwce
        QkZYNatNru2UvhgbC8r9EkfNL+OQqFAIfd7aP9k5nYsYeSt/6MUOSg88CAQ2U+gaf/WMAur
        S4kamC0K0JCOZVopYPQKPt3e5+HDxADQEBwEH+eZLVnOCKFH11fzFgoFQY14dg/lEaewQ/p
        1K2Sckt8dtUUXAkfLlRPWRE+fjuGVSA+xq7wQ1KrSEqIV99gqnwDZ6nyNdd8yS1S/gtL4th
        VzMlmLqcGGyBAOUHePGt0k1sikkStmqeab9ByPBB/1DAj4W07I7m4B88bchILX/5POXSOd9
        cm8nU+PvXGRtzLAUPNM74Laab5ttg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     maz@kernel.org, joey.gouly@arm.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] arm64:kernel:Fix typo in comment
Date:   Wed, 22 Jun 2022 17:19:51 +0800
Message-Id: <20220622091951.53449-1-yuanjilin@cdjrlc.com>
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
 arch/arm64/kernel/cpuinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 8eff0a34ffd4..bf61222c2c69 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -241,7 +241,7 @@ static struct kobj_type cpuregs_kobj_type = {
 };
 
 /*
- * The ARM ARM uses the phrase "32-bit register" to describe a register
+ * The ARM uses the phrase "32-bit register" to describe a register
  * whose upper 32 bits are RES0 (per C5.1.1, ARM DDI 0487A.i), however
  * no statement is made as to whether the upper 32 bits will or will not
  * be made use of in future, and between ARM DDI 0487A.c and ARM DDI
-- 
2.36.1

