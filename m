Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7578554C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357849AbiFVOCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357735AbiFVOCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:02:45 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE63D36E0C;
        Wed, 22 Jun 2022 07:02:35 -0700 (PDT)
X-QQ-mid: bizesmtp76t1655906526tzcri551
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 22:02:02 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000B00A0000000
X-QQ-FEAT: c2aLWwQTF5igxUUED4g1cAq0SdDidm8CRr68pIbYernnYftDCXnJ007BfYZyW
        0KKhWHfNNmUSswnaNid2i+8vc3YeOzHoFjV7raXX18OoXiXCzrciyEPdKxBq4ujbvpfinBS
        ctTbacficMFTVvamufbt18iNFot5LUEjSd/9w/iJFqrXprYTtPE0SEptD9p5pcKRkCs7ZYc
        kdmA9TJaZAmd8DH+wEIBZ99YRg5w0XDYEzuugP/tkIl1UDVTWyIc/txfTmY+EOPS9zBp2qp
        JV4oZcaJlhkCP0fEXR/yCflovrYwIXbJ7lb3qhXMPP4+7ia55bEni1NMPggKG7YGDQi7JiN
        ZJYMZlAKi7sLs/NQ2wM18IwVwtsfo4d51OBskB/FFc4zdJRp0M=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] alpha: irq_i8259: drop unexpected word 'and' in the comments
Date:   Wed, 22 Jun 2022 22:02:01 +0800
Message-Id: <20220622140201.5458-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'and' in the comments that need to be dropped

file: arch/alpha/kernel/irq_i8259.c
line: 150

*  Therefore, read the mask register and and out those lines

changed to:

*  Therefore, read the mask register and and out those lines

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
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
2.17.1

