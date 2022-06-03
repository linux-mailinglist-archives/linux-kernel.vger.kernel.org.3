Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF8153CCD8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbiFCP7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiFCP7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:59:50 -0400
Received: from hostingweb31-40.netsons.net (hostingweb31-40.netsons.net [89.40.174.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83332C107;
        Fri,  3 Jun 2022 08:59:48 -0700 (PDT)
Received: from [77.244.183.192] (port=64530 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.95)
        (envelope-from <luca@lucaceresoli.net>)
        id 1nx9iD-0009cb-MM;
        Fri, 03 Jun 2022 17:59:45 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-media@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 4/6] mfd: max77714: update Luca Ceresoli's e-mail address
Date:   Fri,  3 Jun 2022 17:57:25 +0200
Message-Id: <20220603155727.1232061-4-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603155727.1232061-1-luca@lucaceresoli.net>
References: <20220603155727.1232061-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Bootlin address is preferred from now on.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/mfd/max77714.c       | 4 ++--
 include/linux/mfd/max77714.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/max77714.c b/drivers/mfd/max77714.c
index d1e4247800d2..143a432ea343 100644
--- a/drivers/mfd/max77714.c
+++ b/drivers/mfd/max77714.c
@@ -3,7 +3,7 @@
  * Maxim MAX77714 Core Driver
  *
  * Copyright (C) 2022 Luca Ceresoli
- * Author: Luca Ceresoli <luca@lucaceresoli.net>
+ * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
  */
 
 #include <linux/i2c.h>
@@ -148,5 +148,5 @@ static struct i2c_driver max77714_driver = {
 module_i2c_driver(max77714_driver);
 
 MODULE_DESCRIPTION("Maxim MAX77714 MFD core driver");
-MODULE_AUTHOR("Luca Ceresoli <luca@lucaceresoli.net>");
+MODULE_AUTHOR("Luca Ceresoli <luca.ceresoli@bootlin.com>");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/max77714.h b/include/linux/mfd/max77714.h
index a970dc455426..7947e0d697a5 100644
--- a/include/linux/mfd/max77714.h
+++ b/include/linux/mfd/max77714.h
@@ -3,7 +3,7 @@
  * Maxim MAX77714 Register and data structures definition.
  *
  * Copyright (C) 2022 Luca Ceresoli
- * Author: Luca Ceresoli <luca@lucaceresoli.net>
+ * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
  */
 
 #ifndef __LINUX_MFD_MAX77714_H_
-- 
2.25.1

