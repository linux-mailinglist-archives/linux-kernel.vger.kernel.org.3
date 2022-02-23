Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAC64C1A64
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243664AbiBWR7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243650AbiBWR7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:59:51 -0500
Received: from hostingweb31-40.netsons.net (hostingweb31-40.netsons.net [89.40.174.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E044D3E0C6;
        Wed, 23 Feb 2022 09:59:22 -0800 (PST)
Received: from [77.244.183.192] (port=62116 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1nMvv6-00039p-Uf; Wed, 23 Feb 2022 18:59:21 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v6 1/8] rtc: max77686: convert comments to kernel-doc format
Date:   Wed, 23 Feb 2022 18:59:01 +0100
Message-Id: <20220223175908.191618-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223175908.191618-1-luca@lucaceresoli.net>
References: <20220223175908.191618-1-luca@lucaceresoli.net>
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

Convert the comments documenting this struct to kernel-doc format for
standardization and readability.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

---
Changes in v6: none

Changes in v5: none

Changes in v4: none

Changes in v3: none

Changes in v2: none
---
 drivers/rtc/rtc-max77686.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index eae7cb9faf1e..bac52cdea97d 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -61,24 +61,27 @@ enum {
 	RTC_NR_TIME
 };
 
+/**
+ * struct max77686_rtc_driver_data - model-specific configuration
+ * @delay: Minimum usecs needed for a RTC update
+ * @mask: Mask used to read RTC registers value
+ * @map: Registers offset to I2C addresses map
+ * @alarm_enable_reg: Has a separate alarm enable register?
+ * @rtc_i2c_addr: I2C address for RTC block
+ * @rtc_irq_from_platform: RTC interrupt via platform resource
+ * @alarm_pending_status_reg: Pending alarm status register
+ * @rtc_irq_chip: RTC IRQ CHIP for regmap
+ * @regmap_config: regmap configuration for the chip
+ */
 struct max77686_rtc_driver_data {
-	/* Minimum usecs needed for a RTC update */
 	unsigned long		delay;
-	/* Mask used to read RTC registers value */
 	u8			mask;
-	/* Registers offset to I2C addresses map */
 	const unsigned int	*map;
-	/* Has a separate alarm enable register? */
 	bool			alarm_enable_reg;
-	/* I2C address for RTC block */
 	int			rtc_i2c_addr;
-	/* RTC interrupt via platform resource */
 	bool			rtc_irq_from_platform;
-	/* Pending alarm status register */
 	int			alarm_pending_status_reg;
-	/* RTC IRQ CHIP for regmap */
 	const struct regmap_irq_chip *rtc_irq_chip;
-	/* regmap configuration for the chip */
 	const struct regmap_config *regmap_config;
 };
 
-- 
2.25.1

