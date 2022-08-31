Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983095A76CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiHaGlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiHaGlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:41:04 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F13082D25
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:41:01 -0700 (PDT)
X-QQ-mid: bizesmtp79t1661928053telgy312
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 14:40:52 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: r/cTxDoDoiE5Qh1eY9JrHUSI9jTfx0mx+gZWkIyhQ35VHB+uLHyc7oU5W3zJg
        VCWSnJF/L4X1PycFfAAQdVTEfus7L3N38jEYjwXBRXYMQAvbV+bJ5Ss7JMY72O9k/gDjLra
        mNqwkrOQbpXzGkVNkRv4frCV5qWTNlKfs05kxCXnv3tUDBwCYnXDTrGI06gUV0g+Z6F8NZH
        MHh3rQV8yX8Yj5/MBCV3nxo2Uz5gD+ie5cOLwZWaG3BQJf+9uXx/lxsALUEKXBxTZv/ogTI
        Ueawb8gpYX3PzPhcYgGxXrSdDpafidewrio9chJ9RmKEsoWuK6x6jN6FbzVeZm4Qab/RA1r
        PXwNz6CWjZNKpiETb+btLhpf1rwHVtyv4NB0NxZfpOMDGtjjXuWPKdgrYb/Si7lhOwFnRqK
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     chris@zankel.net, jcmvbkbc@gmail.com
Cc:     linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] xtensa: fix repeated words in comments
Date:   Wed, 31 Aug 2022 14:40:46 +0800
Message-Id: <20220831064046.20936-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.155.67.158 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'that'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/xtensa/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 0c25e035ff10..998299debbf5 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -322,7 +322,7 @@ static void do_illegal_instruction(struct pt_regs *regs)
 	 * When call0 application encounters an illegal instruction fast
 	 * exception handler will attempt to set PS.WOE and retry failing
 	 * instruction.
-	 * If we get here we know that that instruction is also illegal
+	 * If we get here we know that instruction is also illegal
 	 * with PS.WOE set, so it's not related to the windowed option
 	 * hence PS.WOE may be cleared.
 	 */
-- 
2.36.1

