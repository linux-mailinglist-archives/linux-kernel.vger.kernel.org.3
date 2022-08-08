Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C8258CB49
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243711AbiHHP2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbiHHP2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:28:48 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F131403B;
        Mon,  8 Aug 2022 08:28:46 -0700 (PDT)
X-QQ-mid: bizesmtp64t1659972512tb86q6ms
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 Aug 2022 23:28:23 +0800 (CST)
X-QQ-SSF: 0100000000200050B000B00A0000000
X-QQ-FEAT: 4jmx9f9bCbtc81RdPFdR4lee0Ii+vpCrOxHv287zzW81YddGO3c+Kt8YeWi3z
        7L0QPvjrOD8jcSGm49w6N1elFoF0xBGQqo942YRkiCyscSMAMia60hNdPGOBaRDzbilGH1a
        Sy0xyQGekeQ1sdsTzvgl6GgI+ntI3caWDKv4GyMpEMh1h4wPjzpMOyDTUdBX4dUE6BlMBPV
        Jnt7EIQtm/VREvikCswBOr8ViVbkGTe5MGHYp+5C99083wpiLfEWTrozJkDQZno6+YM5MaW
        ed96VGjHuPoJxAbqjdDDltXWpxSzAGKERUm0pat9p7QB3sy0HmAbNX87HnJds3u8ZvDeiMB
        5AdxHx0ktpA5IX9jEdZNpcBV/Lshi/M9chEQPyNtuKHUoxOO9QQnTLxo0vptxLcT0hGStv1
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] rtc: m41t80: Fix typo in rtc-m41t80.c
Date:   Mon,  8 Aug 2022 11:28:22 -0400
Message-Id: <20220808152822.5012-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the rebundant word "we" in comments.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/rtc/rtc-m41t80.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index d868458cd40e..852650c8ad47 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -692,7 +692,7 @@ static void wdt_disable(void)
  *	@ppos: pointer to the position to write. No seeks allowed
  *
  *	A write to a watchdog device is defined as a keepalive signal. Any
- *	write of data will do, as we we don't define content meaning.
+ *	write of data will do, as we don't define content meaning.
  */
 static ssize_t wdt_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
-- 
2.35.1

