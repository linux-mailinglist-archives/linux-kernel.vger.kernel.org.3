Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA1651EB2C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 05:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447133AbiEHDFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 23:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiEHDEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 23:04:50 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4889FDD;
        Sat,  7 May 2022 20:00:57 -0700 (PDT)
X-QQ-mid: bizesmtp80t1651978842tow4zz2r
Received: from localhost.localdomain ( [125.69.42.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 08 May 2022 11:00:40 +0800 (CST)
X-QQ-SSF: 01000000002000E0S000C00A0000000
X-QQ-FEAT: TskX/GkkryBRQ6VYCwZkqj8QEUmkLudebDByRVc4iXRXAJB7igKjSg8fjoeVr
        eqJMCkbksBzm7seRvBcDoW+Dsydn4YOPw24NtI7Jx8T5tytOklWIrzww3GeX1x3B6dXhXpC
        LqGTfmy96HQLU+tn0dM3rnk3vyLNJLvriZjJORcnd7LbC4Wd8RhwFlHNGAKC4sBbv3SQABG
        bePnTQIu5n/NJSr9d9wOohytchdo/sV3VqKQhn8mprTkpiZda5dhJD2S9p9QDbEuuFb/DOw
        U6Beqovmb/CcixrBisTPN+zQ2IrPMaOCBluhv6iKsh7K3lbSR0hwz0b0sdQQL1kxEvw3Dnn
        Kj10frxX0IrYIPaUP3SWfNGt40FGw==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     rth@twiddle.net
Cc:     ink@jurassic.park.msu.ru, mattst88@gmail.com,
        wangborong@cdjrlc.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: Fix comment typo
Date:   Sun,  8 May 2022 11:00:29 +0800
Message-Id: <20220508030029.123056-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove one of the repeated 'and' in comment line 150.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/alpha/kernel/irq_i8259.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/irq_i8259.c b/arch/alpha/kernel/irq_i8259.c
index 1dcf0d9038fd..db574dcd6675 100644
--- a/arch/alpha/kernel/irq_i8259.c
+++ b/arch/alpha/kernel/irq_i8259.c
@@ -147,7 +147,7 @@ isa_no_iack_sc_device_interrupt(unsigned long vector)
 	 */
 	/* 
 	 *  The first read of gives you *all* interrupting lines.
-	 *  Therefore, read the mask register and and out those lines
+	 *  Therefore, read the mask register and out those lines
 	 *  not enabled.  Note that some documentation has 21 and a1 
 	 *  write only.  This is not true.
 	 */
-- 
2.35.1

