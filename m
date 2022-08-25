Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39185A109D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241852AbiHYMee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbiHYMeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:34:31 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E35AED89;
        Thu, 25 Aug 2022 05:34:29 -0700 (PDT)
X-QQ-mid: bizesmtp68t1661430866ta51x04m
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 Aug 2022 20:34:24 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: r/cTxDoDoiH37fhH4E8Ls+G6Pfl4eerV3Sc/K80AH+f9IIoeCEvXrAGEFlfOn
        +0Jz4spDcFJLIbRHlBChya/h3w2OMuS9yRynX/bWdE+JQC5awFW1hG/yyKIcBHwwRauJq2A
        HYDvfXGEfrxC+RJCL3oAJ3oBSPF/jnNFquN3MUHEsIprJo9MwWdWjDExYJXp9L9foLkT21M
        9kzQl/p+uqd2IoxlYOp2AyFYKhCpdemf4O1xjlOLeFWkj531TBt+H/wSteCnWp/SLiaD4X7
        9tBV2SRFpYDcOtQUOqjurv7UOpI+hvE3pIRP2e/Nvm1RZJjwVA4KA801/rfW67qGPIOe0Mq
        oEP6OFbtnYDMiSyUjc8Y1/GE9BuI9sWPdcu3TEpZGT9dAYnM+5277uMGKj1lCMsjTlttqNK
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     tony@atomide.com
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drivers/bus: fix repeated words in comments
Date:   Thu, 25 Aug 2022 20:34:18 +0800
Message-Id: <20220825123418.37676-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *      [43.155.67.158 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
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

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/bus/ti-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 51d772bb8046..2386e8013e18 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -915,7 +915,7 @@ static int sysc_check_registers(struct sysc *ddata)
  * within the interconnect target module range. For example, SGX has
  * them at offset 0x1fc00 in the 32MB module address space. And cpsw
  * has them at offset 0x1200 in the CPSW_WR child. Usually the
- * the interconnect target module registers are at the beginning of
+ * interconnect target module registers are at the beginning of
  * the module range though.
  */
 static int sysc_ioremap(struct sysc *ddata)
-- 
2.36.1

