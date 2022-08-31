Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FA15A76AF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiHaGdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHaGdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:33:01 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BB1ABF37;
        Tue, 30 Aug 2022 23:32:58 -0700 (PDT)
X-QQ-mid: bizesmtp91t1661927569tfodjnuc
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 14:32:48 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: cknW069rtVde5uU2OtD7FUIPxaDf2iueTD2InOxmpEWzMq000o8PggmNrIjQS
        2GyR126X9+HrOdyjLVizWnzbam9S8Uj1NVwk0rZ1JEhdL5ErCwCB0JbGTOIAcIE0QAhg1ZZ
        6FeAitY8kwBsKgl2GAPzENu/oqQNdK6zb+9i+8OH1Y8VFSYo/hA/w7WsvkO8PY+ra1f3dru
        35uk/CzlbIP2w5VOMMqCwTR2npvBv6OTokpBbUsN/nJ40MGgT+UMKpQNDKJHzilSCNlB/8X
        2AMc77QtYgSTTGkmj7BPdKHUaiGESMzvXa+zylgyOBCEC29yuSYmqpqg67e+i6JfewUODE9
        wbLo5TZFxfutIa0awpMNgIFgb0o42u9BivHIAWjRqnuwM2OzLayiXkjtH77bA==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] alpha: fix repeated words in comments
Date:   Wed, 31 Aug 2022 14:32:41 +0800
Message-Id: <20220831063241.14626-1-yuanjilin@cdjrlc.com>
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

Delete the redundant word 'and'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
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
2.36.1

