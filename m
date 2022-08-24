Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B605459FB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiHXN0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbiHXN0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:26:40 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D54E6B141;
        Wed, 24 Aug 2022 06:26:36 -0700 (PDT)
X-QQ-mid: bizesmtp79t1661347592tlxbp765
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:26:31 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: CR3LFp2JE4kywlhnGfjfA+SBy4ZXJ4HC/jmihzv07LR96wX0Gull8ipU2HZ05
        zQ8KB4EMNzrJ8Vhy/13Q5psvNJBHL0hOi7nvGlu+ec99Y0o2PKCrC83iUK4yJPYJ67rEIxc
        OvAw5XPi68RfXoAGX4oC4KF/T/yUJZqSPmhQ7xrsvJIhUVCF2wDYH2Y4BW9d9mRK1ThopQY
        GQabxjIF1i1KxMZ4kSxhim/WWef13hbEHn1iCkd0L7JEKqgdZnABwFTqgn5BjgmNeauRc35
        tvLD6tH32W0I52DLcD8/CU2g1cCJ9/jLea5YJ+hohussHyIQjzpmzQF7TEVdPeCjnYCbLTc
        CrYKdHHShgJ8/gw2//3qDpF1f7W8BI1hIYIEITtqw6RUBy2rvGyP+ZKTq9q/kcV256DwGGf
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] pci/cx88: fix repeated words in comments
Date:   Wed, 24 Aug 2022 21:26:14 +0800
Message-Id: <20220824132614.60914-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/pci/cx88/cx88-dsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx88/cx88-dsp.c b/drivers/media/pci/cx88/cx88-dsp.c
index f1e1fc1cb4bd..e378f3b215c7 100644
--- a/drivers/media/pci/cx88/cx88-dsp.c
+++ b/drivers/media/pci/cx88/cx88-dsp.c
@@ -24,7 +24,7 @@
 
 /*
  * We calculate the baseband frequencies of the carrier and the pilot tones
- * based on the the sampling rate of the audio rds fifo.
+ * based on the sampling rate of the audio rds fifo.
  */
 
 #define FREQ_A2_CARRIER         baseband_freq(54687.5, 2689.36, 0.0)
-- 
2.36.1

