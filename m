Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB0858FC00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbiHKMPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbiHKMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:15:04 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D53694ED0;
        Thu, 11 Aug 2022 05:15:02 -0700 (PDT)
X-QQ-mid: bizesmtp64t1660220098tlclb2f9
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 20:14:57 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: TLc+rbMvNaFAW3t5HQDwHetVqsQVIr1uXqvNKsVtqe+uakhAwb7H9dwhz7c+R
        R4ifgLKwcxHrA96YXE9CVNdzOv3Y+bkp6/+vQWEt5cPJ3/hejTjP5C2bnmfBdwPJT4Kjc+A
        HLs90WEHFmvV74GR4RAyqpdGgOP+3oD3FtSw3siR1illyySxOUCefe+mr10G/lz65m6uwx7
        iZWGu8o5XO7blPXn3Xy+cXCSNnsvWIlAxcLSE1NiPvzg9BmU5LNaLW36mbx+fN2anRbVWrX
        NwqB1/dtjah2hmQzj0+nv8B0kG1xY96tfVEUDRwClgcbXTnd6nNnjNZBlp7D3Xk2qt1JUWx
        SHzylzlaCeFidDB9lE0mHsKqxyPf1J9D+Qv+O2PIdyGl+7Alt7D3Vfc6d6NmAf0FM2FfrT7
        sz7fihone9A=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] MIPS: Fix comment typo
Date:   Thu, 11 Aug 2022 20:14:50 +0800
Message-Id: <20220811121450.24057-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `it' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/mips/math-emu/cp1emu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 587cf1d115e8..265bc57819df 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1032,7 +1032,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 	 */
 	if (dec_insn.micro_mips_mode) {
 		/*
-		 * If next instruction is a 16-bit instruction, then it
+		 * If next instruction is a 16-bit instruction, then
 		 * it cannot be a FPU instruction. This could happen
 		 * since we can be called for non-FPU instructions.
 		 */
-- 
2.36.1

