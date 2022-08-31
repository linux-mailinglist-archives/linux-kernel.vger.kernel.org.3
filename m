Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86B15A7DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiHaMtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiHaMtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:49:21 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107DDCD785;
        Wed, 31 Aug 2022 05:49:14 -0700 (PDT)
X-QQ-mid: bizesmtp85t1661950150te6hhi5j
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 20:49:09 +0800 (CST)
X-QQ-SSF: 01000000002000D0E000B00A0000000
X-QQ-FEAT: LG+NUo/f6sFaQzBj5GPBVcFaPl9v5yRwJEBXdptUJT8tiUNaoXgh+8pluGwI3
        BuslUXYTUZdwrvLe8vsBvtFiNM2nzhc/PEgLMnh9LWrDMFx7fqKLRElJO2CQfvS5wWJDs4B
        nftbUX1WXbbxj9C23TACrA/l+ivfWrUJmXpBE93PoG1zjtXUzGJLO70Tpx0IMc87UrhKabl
        tFXltXoZzHCW+RAMSv4WOX/qujNOhrKfoViTAsITl9r5y6+aZkcQudCzZg79FsuadE8HUnE
        +382FrsKHBMDcLxJoMRZm5iHlwaEFEO/RzdLUEe4o4L0h/LA0A78aays1z+/u7le0YwT4Ot
        7ABdZpcO/pLKojWNwzfe9V+5zuKNJNjR+WsbUOOTC2ihYD3piGFnx6sMeR32Lc5g9FyoUrs
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] MIPS: fix repeated words in comments
Date:   Wed, 31 Aug 2022 20:49:03 +0800
Message-Id: <20220831124903.11720-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [43.155.67.158 listed in zen.spamhaus.org]
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
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

Delete the redundant word 'it'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/mips/math-emu/cp1emu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 587cf1d115e8..924260f6e9d2 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1033,7 +1033,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 	if (dec_insn.micro_mips_mode) {
 		/*
 		 * If next instruction is a 16-bit instruction, then it
-		 * it cannot be a FPU instruction. This could happen
+		 * cannot be a FPU instruction. This could happen
 		 * since we can be called for non-FPU instructions.
 		 */
 		if ((pc_inc == 2) ||
-- 
2.36.1

