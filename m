Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82F05A0F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbiHYLrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241059AbiHYLrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:47:32 -0400
Received: from out20-146.mail.aliyun.com (out20-146.mail.aliyun.com [115.124.20.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E2A74E17
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:47:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3045855|-1;BR=01201311R131S89rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.025949-0.00105542-0.972996;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=fuyao@sjterm.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.P.m81RD_1661428046;
Received: from localhost(mailfrom:fuyao@sjterm.com fp:SMTPD_---.P.m81RD_1661428046)
          by smtp.aliyun-inc.com;
          Thu, 25 Aug 2022 19:47:26 +0800
Date:   Thu, 25 Aug 2022 19:47:26 +0800
From:   fuyao <fuyao1697@cyg.com>
To:     Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        maijianzhang <maijianzhang@allwinnertech.com>
Subject: [PATCH] iio: adc: sun4i-gpadc-iio: adaptation interrupt number
Message-ID: <YwdhTlk+7h+FMrwm@scg>
Mail-Followup-To: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        maijianzhang <maijianzhang@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: work_work_work
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__platform_get_irq_byname determinies whether the interrupt
number is 0 and returns EINVAL.

Signed-off-by: fuyao <fuyao1697@cyg.com>
---
 include/linux/mfd/sun4i-gpadc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
index ea0ccf33a459..021f820f9d52 100644
--- a/include/linux/mfd/sun4i-gpadc.h
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -81,8 +81,8 @@
 #define SUN4I_GPADC_TEMP_DATA				0x20
 #define SUN4I_GPADC_DATA				0x24
 
-#define SUN4I_GPADC_IRQ_FIFO_DATA			0
-#define SUN4I_GPADC_IRQ_TEMP_DATA			1
+#define SUN4I_GPADC_IRQ_FIFO_DATA			1
+#define SUN4I_GPADC_IRQ_TEMP_DATA			2
 
 /* 10s delay before suspending the IP */
 #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
-- 
2.32.0


-- 
Technology is exciting
