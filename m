Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73B059B4FC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiHUPSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiHUPSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:18:46 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA82C1262F;
        Sun, 21 Aug 2022 08:18:43 -0700 (PDT)
X-QQ-mid: bizesmtp86t1661095069tc954e3m
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:17:47 +0800 (CST)
X-QQ-SSF: 0100000000200020B000B00A0000000
X-QQ-FEAT: izenvNSMpb3gtRz8+W5DAvZl10fG1gGBitJeiiRFwcysCI39olkCmNxFNcFss
        zK21zWomF2tDfNNk/DyVCVLXGPtGqq9BSQxA6OrVAqaORlIxBHkr3K7nXHro4eNVT04OCcl
        OAuwH9aaBBuZeYeprEnVzNgnBZGFqGMtOfYnYiEDyJrziB7Dt/3JEiH2JDqV1EKXwuAswiG
        Aok4cfvJJcYJSKZSlH34vyXpMCQG9BOkgquCUuWI8rt+0jAIh6DBRNZIY7CBdYwUufLh0IB
        00HjO0qMugdR6dMmhdbUq8V5m+OubbrvTNrq/+jPtjWQi462LR9eyqet40W5o1mbygZy6Rg
        GyaI3KyKlJoIBj6kdCIR5FO8UrSBBuGbBSZ/hzyiG5bqvaCmBs=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     awalls@md.metrocast.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] pci/cx18: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:17:41 +0800
Message-Id: <20220821151741.59550-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.154.54.12 listed in wl.mailspike.net]
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'of'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/media/pci/cx18/cx18-firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-firmware.c b/drivers/media/pci/cx18/cx18-firmware.c
index fdac310d7477..1b038b2802bf 100644
--- a/drivers/media/pci/cx18/cx18-firmware.c
+++ b/drivers/media/pci/cx18/cx18-firmware.c
@@ -248,7 +248,7 @@ void cx18_init_power(struct cx18 *cx, int lowpwr)
 	 *
 	 * Many thanks to Jeff Campbell and Mike Bradley for their extensive
 	 * investigation, experimentation, testing, and suggested solutions of
-	 * of audio/video sync problems with SVideo and CVBS captures.
+	 * audio/video sync problems with SVideo and CVBS captures.
 	 */
 
 	/* the fast clock is at 200/245 MHz */
-- 
2.36.1

