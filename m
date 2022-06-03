Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B8553CCDC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbiFCQAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343681AbiFCQAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:00:08 -0400
Received: from hostingweb31-40.netsons.net (hostingweb31-40.netsons.net [89.40.174.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919BB2C11D;
        Fri,  3 Jun 2022 09:00:07 -0700 (PDT)
Received: from [77.244.183.192] (port=64530 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.95)
        (envelope-from <luca@lucaceresoli.net>)
        id 1nx9iW-0009cb-2q;
        Fri, 03 Jun 2022 18:00:04 +0200
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
Subject: [PATCH 6/6] watchdog: max77620: update Luca Ceresoli's e-mail address
Date:   Fri,  3 Jun 2022 17:57:27 +0200
Message-Id: <20220603155727.1232061-6-luca@lucaceresoli.net>
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
 drivers/watchdog/max77620_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
index b76ad6ba0915..33835c0b06de 100644
--- a/drivers/watchdog/max77620_wdt.c
+++ b/drivers/watchdog/max77620_wdt.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2022 Luca Ceresoli
  *
  * Author: Laxman Dewangan <ldewangan@nvidia.com>
- * Author: Luca Ceresoli <luca@lucaceresoli.net>
+ * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
  */
 
 #include <linux/err.h>
@@ -260,5 +260,5 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
 MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
-MODULE_AUTHOR("Luca Ceresoli <luca@lucaceresoli.net>");
+MODULE_AUTHOR("Luca Ceresoli <luca.ceresoli@bootlin.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

