Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AEF576E25
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiGPNQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGPNQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:16:50 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033952127E;
        Sat, 16 Jul 2022 06:16:45 -0700 (PDT)
X-QQ-mid: bizesmtp83t1657977400t6j6gmp0
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 21:16:36 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: St3bwald4orcfK6Mpy1y00FRLjmPNfEtNTvVBr+Un3ii5nx4QQal6R6m6Yzx9
        LrKmzvqrrAMXAvg5kB3tarj7/NAkZzUaBG3aYwXD94btwJfTP8iBraGRXJdxl+AW/ImxfB4
        sq4hHTyZYFOYHAihAXUeoLevKD6KoU51on26044zJ+ZtIVKx7FpIBAEZsqscBcHIMV1WSkM
        pVyZWBAJzdWRxuL3/SpIgXeE95oFeIiyWFwbVJ8x0mugg+G5SOrBqTebuOEojOEhW1rSIvU
        ZqbcddOBtZBAfOrne27DqyIExdnCxFI9uAZohKfeOpb4HUp1QdEW9BUZAmASNsy1LjY4U6v
        2wFNX0Q9rHH7DkXHtSrU4DSa5HtLUisURiKwqMBljPSDEq7txrb9JsJUUUBb1uzxJYN1+Qv
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     peter.chen@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/chipidea: fix repeated words in comments
Date:   Sat, 16 Jul 2022 21:16:30 +0800
Message-Id: <20220716131630.33151-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'power'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/chipidea/otg_fsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
index 6ed4b00dba96..61b157b9c662 100644
--- a/drivers/usb/chipidea/otg_fsm.c
+++ b/drivers/usb/chipidea/otg_fsm.c
@@ -459,7 +459,7 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
 	struct ci_hdrc	*ci = container_of(fsm, struct ci_hdrc, fsm);
 
 	if (on) {
-		/* Enable power power */
+		/* Enable power */
 		hw_write(ci, OP_PORTSC, PORTSC_W1C_BITS | PORTSC_PP,
 							PORTSC_PP);
 		if (ci->platdata->reg_vbus) {
-- 
2.36.1

