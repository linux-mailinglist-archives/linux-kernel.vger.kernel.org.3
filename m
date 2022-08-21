Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF9D59B50D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiHUP2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHUP1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:27:54 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC9D237F0;
        Sun, 21 Aug 2022 08:27:52 -0700 (PDT)
X-QQ-mid: bizesmtp77t1661095668tbosf2un
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:27:47 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: izenvNSMpb2fBsYHDX/nyLZY5/oGgQE97zvEleRWpVgXIcxHUDUy/hmhtKpoO
        mgOW26MQmsJWX2Y7uxy0uE022/xQraigHScrR3GS5VxPZOsRxwKZ1U77SNntoWkOVWV+ugJ
        CRk+LIvxJY2lXc3sHHpDlr+1nJBoALndDRMnI1eRzyOFnlwCCp4cF5G4Xz7o66Znt6zVkZe
        0Hq9PL9nGiHwGjdAypKRlc6qqSqi7cUhW8A7txd5YQpHB08h9fSglyUdZPwuJFfBbyzvQtj
        sAzQ4XepZmf6jT/FGFQNmr5c/JUYTgH2PTvOP/Ow7SYzCjNk69qd09sI6fGMIwWccbUcbyl
        iMrY79z57wKGT90mZjqf4L/Sajy8phnWIjAvJR5XoHfrnP5esh1LwEO+FMmsg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/host: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:27:41 +0800
Message-Id: <20220821152741.65462-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.154.54.12 listed in wl.mailspike.net]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
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
 drivers/usb/host/ohci-sm501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-sm501.c b/drivers/usb/host/ohci-sm501.c
index b91d50da6127..83b1b47ceaf5 100644
--- a/drivers/usb/host/ohci-sm501.c
+++ b/drivers/usb/host/ohci-sm501.c
@@ -154,7 +154,7 @@ static int ohci_hcd_sm501_drv_probe(struct platform_device *pdev)
 	 * using kmalloc() - so the usb core needs to be told that it must copy
 	 * data into our local memory if the buffers happen to be placed in
 	 * regular memory. A non-null hcd->localmem_pool initialized by the
-	 * the call to usb_hcd_setup_local_mem() below does just that.
+	 * call to usb_hcd_setup_local_mem() below does just that.
 	 */
 
 	retval = usb_hcd_setup_local_mem(hcd, mem->start,
-- 
2.36.1

