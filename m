Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44F259B517
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiHUPbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiHUPbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:31:07 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B5B186F2;
        Sun, 21 Aug 2022 08:31:04 -0700 (PDT)
X-QQ-mid: bizesmtp83t1661095857t3b4wa63
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:30:55 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: TlxLMsIUBW7wsY5bwhkKYiopo8iGFeUtlU6RqOYncZU7dyn26P6MRE0lOAi2r
        KVsFPVCidLgeHActBpLjDcIpUD6B83q2d0APzeswOX+gTz+tpa0J1nnHDOqdiztjLKSBwzF
        3+lBDtLZTU+y6llWjwICDJIIZTn2P/JSZtbcHsFeK7KHtwkYCVfX5QWCGDTgrXP6O+yY/8O
        NfHF0V5f12E44w/dtT7DqPdXv5pmbtmIXdV7uVBB56v3SFFnXBVF/TWkWvSfYFZloipOYjs
        bvF6u77gPBoXgL+MABOQxn28nszkgrB4vY+rkg+EIWmGBjuFC0RtIKL2TRroW6CGMa1IqG5
        BuUjhADZh8g9Ki8W8pDwkijl4ba64QoWOOFFD7TdMFr9hD9EoPiC9Q5l+zV1MHw4RMwYGPP
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/musb: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:30:49 +0800
Message-Id: <20220821153049.3565-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.154.54.12 listed in wl.mailspike.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'from'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/musb/musb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index f7b1d5993f8c..6ee7d47141c1 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -960,7 +960,7 @@ static void musb_handle_intr_disconnect(struct musb *musb, u8 devctl)
 	case OTG_STATE_B_HOST:
 		/* REVISIT this behaves for "real disconnect"
 		 * cases; make sure the other transitions from
-		 * from B_HOST act right too.  The B_HOST code
+		 * B_HOST act right too.  The B_HOST code
 		 * in hnp_stop() is currently not used...
 		 */
 		musb_root_disconnect(musb);
-- 
2.36.1

