Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2D44EB48A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiC2URU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiC2URS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:17:18 -0400
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B936E6177;
        Tue, 29 Mar 2022 13:15:34 -0700 (PDT)
Received: from 1nZIFW-0009Pn-Ul by out3a.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nZIFZ-0009XP-UH; Tue, 29 Mar 2022 13:15:33 -0700
Received: by emcmailer; Tue, 29 Mar 2022 13:15:33 -0700
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3a.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nZIFW-0009Pn-Ul; Tue, 29 Mar 2022 13:15:30 -0700
Received: from tsdebian.Massive (unknown [75.164.75.221])
        by mail.embeddedts.com (Postfix) with ESMTPSA id C7A591A272;
        Tue, 29 Mar 2022 13:15:29 -0700 (MST)
From:   Kris Bahnsen <kris@embeddedTS.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Featherston <mark@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Subject: [PATCH] gpio: ts5500: Fix Links to Technologic Systems web resources
Date:   Tue, 29 Mar 2022 13:14:26 -0700
Message-Id: <20220329201426.16396-1-kris@embeddedTS.com>
X-Mailer: git-send-email 2.11.0
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (b)
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Message-Id:Date:To:From; bh=Ova3RVzwrcDYWmTjEHu+W4p1BfrGT55Uv819Sc7ao44=;b=Dg3KpvuHxiCftV98uwxHz3TaRQS+A+KMfmn21yaXs+Zd7Q3MNVewH9CoHD1MaSNbRjflD3+7FQ45Iv3WsIucBJxJ7QCxXvTHJt3BLP/m0nF2uFY8ym6vkJT6BQdtBlYNWIBnFylQBE5no8429CnCqX6X2Vw+2dnrcE0izMV2OnvkHnssQKim1TgMFwGWfshTqRHvW32IaezHl0IXlNJNNXprLcrGM2e7YqHI2AXRO9gzkbkS9tjVnFcGmifSlTwiWxGV2oQD6GYB0STj8gGrnruiCUwpGZ9HgSoZEVk8MartGI5MAYSCdlLwaflDB7n1RrZXrLFv7m5LugGA7WKngg==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Technologic Systems has rebranded as embeddedTS with the current
domain eventually going offline. Update web/doc URLs to correct
resource locations.

Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
---
 drivers/gpio/gpio-ts5500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-ts5500.c b/drivers/gpio/gpio-ts5500.c
index b159e92a3612..8e03614c7a24 100644
--- a/drivers/gpio/gpio-ts5500.c
+++ b/drivers/gpio/gpio-ts5500.c
@@ -11,11 +11,11 @@
  * Actually, the following platforms have DIO support:
  *
  * TS-5500:
- *   Documentation: http://wiki.embeddedarm.com/wiki/TS-5500
+ *   Documentation: https://docs.embeddedts.com/TS-5500
  *   Blocks: DIO1, DIO2 and LCD port.
  *
  * TS-5600:
- *   Documentation: http://wiki.embeddedarm.com/wiki/TS-5600
+ *   Documentation: https://docs.embeddedts.com/TS-5600
  *   Blocks: LCD port (identical to TS-5500 LCD).
  */
 
-- 
2.11.0

