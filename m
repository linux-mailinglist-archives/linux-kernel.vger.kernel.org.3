Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECF147152C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 19:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhLKSAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 13:00:14 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:55824 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhLKSAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 13:00:12 -0500
Received: from [77.244.183.192] (port=64660 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mw6fK-0009HU-8q; Sat, 11 Dec 2021 19:00:10 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v5 1/9] rtc: max77686: convert comments to kernel-doc format
Date:   Sat, 11 Dec 2021 18:59:43 +0100
Message-Id: <20211211175951.30763-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211211175951.30763-1-luca@lucaceresoli.net>
References: <20211211175951.30763-1-luca@lucaceresoli.net>
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

