Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DA04D3EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbiCJBRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbiCJBRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:17:43 -0500
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D180F12222F;
        Wed,  9 Mar 2022 17:16:43 -0800 (PST)
Received: from 1nS7Pz-0006Tu-VQ by out3d.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nS7Q0-0006WB-VR; Wed, 09 Mar 2022 17:16:40 -0800
Received: by emcmailer; Wed, 09 Mar 2022 17:16:40 -0800
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3d.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nS7Pz-0006Tu-VQ; Wed, 09 Mar 2022 17:16:39 -0800
Received: from tsdebian.Massive (unknown [75.164.75.221])
        by mail.embeddedts.com (Postfix) with ESMTPSA id F01CF1AB0;
        Wed,  9 Mar 2022 18:16:38 -0700 (MST)
From:   Kris Bahnsen <kris@embeddedTS.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Featherston <mark@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Subject: [PATCH v3 2/2] gpio: ts4900: Use SPDX header
Date:   Wed,  9 Mar 2022 17:16:17 -0800
Message-Id: <20220310011617.29660-3-kris@embeddedTS.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220310011617.29660-1-kris@embeddedTS.com>
References: <20220310011617.29660-1-kris@embeddedTS.com>
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
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=References:In-Reply-To:Message-Id:Date:To:From; bh=cwEQ9Gjrxcgi44g6+bljgIEY7KxoaRU7Il3yzgGCDr4=;b=do+ABU/mk6GhupMnR2sA29Jdtivs2YpMbyNjIqWEw4sF9TCDYDjACsTbRgoVuEuGFfJIKdeX1z+rk9q3iRfNFVnm3s1meBXRvLVj/70dfRuE4KacwDh1hflLMXPC0M6ulZB7Q/IPlPC4iJyx/qH3qU3YF1/wF9EQvC7ZQ7LvM7xl4II/F43NdBh6acYIepBzl/03ijoiNZN/9b2LmdnKqrJJJiSHXvN2nm2UBfA+SCU5RusmFz7HBrRGjIgyvJn8fvUo6kUx1j9M82Z5l6HloJNfUQyQAiJ1jFzBPo+/sLKTbx7kKAkPMKTqsAl+/DX3lnXQ3MFI8RP4N4PQv8+1xw==;
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

Remove boilerplate, use the SPDX license identifier.

Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
---
 drivers/gpio/gpio-ts4900.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-ts4900.c b/drivers/gpio/gpio-ts4900.c
index d918d2df4de2..69854fd2382a 100644
--- a/drivers/gpio/gpio-ts4900.c
+++ b/drivers/gpio/gpio-ts4900.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Digital I/O driver for Technologic Systems I2C FPGA Core
  *
  * Copyright (C) 2015, 2018 Technologic Systems
  * Copyright (C) 2016 Savoir-Faire Linux
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether expressed or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License version 2 for more details.
  */
 
 #include <linux/gpio/driver.h>
-- 
2.11.0

