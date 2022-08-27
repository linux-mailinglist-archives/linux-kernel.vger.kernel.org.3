Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797A25A3878
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 17:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiH0Pq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 11:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiH0Pqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 11:46:52 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755E9696E0;
        Sat, 27 Aug 2022 08:46:50 -0700 (PDT)
X-QQ-mid: bizesmtp64t1661615206t8pbvhf7
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 27 Aug 2022 23:46:40 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: jR5f+TmrTCzU39Efr7rBJ/EQik9VezIQYgyEBSFPIvLMJPLPjK/wHm4eA6qjK
        IETtqWx3aQQ1UrpFGW1b+x0K6sNFo/x5+M5gPH1k/WYuVecWSfUQXqV48x7xPraZDtEAlm8
        31la2F4GrzwOrX9BWb4IYAIblsRvBBRlGasLei8PXJSgYLvuea9hGn+2jG0A3O9Vu1u5MLF
        lB6FJowtH6crwbmiqUb+VXiHHRQOAnR1XNR0jXj+6FxRfJle5EpySxIyOCC3zwAR1fg+oEp
        +xoMPUc621gyLiPcZsYeWpo/1tjMd+jyxl9AKRccA8iO0GDbZ/Y7ogs1u37HjODNIorhJ+S
        zc7cbnmVU2cCjxSh/RvQZ7llNuIEwq0QAOOtMagXXGoTmlzNz1LIq32QZ6hvEjWcjBNU26z
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     tsbogend@alpha.franken.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] MIPS: Fix comments typo
Date:   Sat, 27 Aug 2022 11:46:40 -0400
Message-Id: <20220827154640.9687-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [43.155.67.158 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word "as" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 arch/mips/cavium-octeon/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 00bf269763cf..9ad12fb6a9a6 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -527,7 +527,7 @@ void octeon_user_io_init(void)
 	/* Get the current settings for CP0_CVMMEMCTL_REG */
 	cvmmemctl.u64 = read_c0_cvmmemctl();
 	/* R/W If set, marked write-buffer entries time out the same
-	 * as as other entries; if clear, marked write-buffer entries
+	 * as other entries; if clear, marked write-buffer entries
 	 * use the maximum timeout. */
 	cvmmemctl.s.dismarkwblongto = 1;
 	/* R/W If set, a merged store does not clear the write-buffer
-- 
2.35.1

