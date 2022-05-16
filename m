Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6435280F7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbiEPJmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbiEPJmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:42:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787FD32051;
        Mon, 16 May 2022 02:42:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B89C91F427E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652694150;
        bh=ePZmgVs4ybnh8KRb65Q8v+CKf3f4EQCPnj11z5d93nI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQOpnPRNslnlmHn9l5dwp3EmcpubriNf5bmglU7dZG4kLolSuDSznL58Og3DF20CU
         aNM3k4YMyfcHIacKE56n6T3WLsNqsZ92SNn+EBEFJBZWAxJHK3hIliXi+6iOrufYZT
         n2HbYwsgHzkWG80EvIChaNdUkZ9KNOWwOwb4GS1ivUIq2tkQF4/ihYcllePBBS2UT4
         O2yML+y2v2j07405c3C1pxTTtPSDWN6L00eoFzpEjfoIMNJr7lsmjTr6kJ6KGqlbrP
         K0FOHdUsk7hf/x6vcVeyOcpL3U3vc43qHqY2voZyhjQdJgdaGPoToKeMNaEzn3ePCN
         wUs/9Nela7LDQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@mediatek.com
Cc:     pavel@ucw.cz, matthias.bgg@gmail.com, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 3/3] leds: leds-mt6323: Drop MT6323_ prefix from macros and defines
Date:   Mon, 16 May 2022 11:42:22 +0200
Message-Id: <20220516094222.30414-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516094222.30414-1-angelogioacchino.delregno@collabora.com>
References: <20220516094222.30414-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This renames all definitions and macros to drop the MT6323_ prefix,
since it is now possible to easily add support to more PMICs in
this driver.
While at it, also fix related formatting where possible.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/leds/leds-mt6323.c | 125 ++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 64 deletions(-)

diff --git a/drivers/leds/leds-mt6323.c b/drivers/leds/leds-mt6323.c
index fa9d251e9efa..26f06452a860 100644
--- a/drivers/leds/leds-mt6323.c
+++ b/drivers/leds/leds-mt6323.c
@@ -14,52 +14,49 @@
 #include <linux/regmap.h>
 
 /*
- * Register field for MT6323_TOP_CKPDN0 to enable
+ * Register field for TOP_CKPDN0 to enable
  * 32K clock common for LED device.
  */
-#define MT6323_RG_DRV_32K_CK_PDN	BIT(11)
-#define MT6323_RG_DRV_32K_CK_PDN_MASK	BIT(11)
+#define RG_DRV_32K_CK_PDN		BIT(11)
+#define RG_DRV_32K_CK_PDN_MASK		BIT(11)
 
 /*
- * Register field for MT6323_TOP_CKPDN2 to enable
+ * Register field for TOP_CKPDN2 to enable
  * individual clock for LED device.
  */
-#define MT6323_RG_ISINK_CK_PDN(i)	BIT(i)
-#define MT6323_RG_ISINK_CK_PDN_MASK(i)	BIT(i)
+#define RG_ISINK_CK_PDN(i)		BIT(i)
+#define RG_ISINK_CK_PDN_MASK(i)		BIT(i)
 
 /*
- * Register field for MT6323_TOP_CKCON1 to select
+ * Register field for TOP_CKCON1 to select
  * clock source.
  */
-#define MT6323_RG_ISINK_CK_SEL_MASK(i)	(BIT(10) << (i))
+#define RG_ISINK_CK_SEL_MASK(i)		(BIT(10) << (i))
 
 /*
- * Register for MT6323_ISINK_CON0 to setup the
+ * Register for ISINK_CON0 to setup the
  * duty cycle of the blink.
  */
-#define MT6323_ISINK_CON(r, i)		(r + 0x8 * (i))
-#define MT6323_ISINK_DIM_DUTY_MASK	(0x1f << 8)
-#define MT6323_ISINK_DIM_DUTY(i)	(((i) << 8) & \
-					MT6323_ISINK_DIM_DUTY_MASK)
+#define ISINK_CON(r, i)			(r + 0x8 * (i))
+#define ISINK_DIM_DUTY_MASK		(0x1f << 8)
+#define ISINK_DIM_DUTY(i)		(((i) << 8) & ISINK_DIM_DUTY_MASK)
 
 /* ISINK_CON1: Register to setup the period of the blink. */
-#define MT6323_ISINK_DIM_FSEL_MASK	(0xffff)
-#define MT6323_ISINK_DIM_FSEL(i)	((i) & MT6323_ISINK_DIM_FSEL_MASK)
+#define ISINK_DIM_FSEL_MASK		(0xffff)
+#define ISINK_DIM_FSEL(i)		((i) & ISINK_DIM_FSEL_MASK)
 
 /* ISINK_CON2: Register to control the brightness. */
-#define MT6323_ISINK_CH_STEP_SHIFT	12
-#define MT6323_ISINK_CH_STEP_MASK	(0x7 << 12)
-#define MT6323_ISINK_CH_STEP(i)		(((i) << 12) & \
-					MT6323_ISINK_CH_STEP_MASK)
-#define MT6323_ISINK_SFSTR0_TC_MASK	(0x3 << 1)
-#define MT6323_ISINK_SFSTR0_TC(i)	(((i) << 1) & \
-					MT6323_ISINK_SFSTR0_TC_MASK)
-#define MT6323_ISINK_SFSTR0_EN_MASK	BIT(0)
-#define MT6323_ISINK_SFSTR0_EN		BIT(0)
+#define ISINK_CH_STEP_SHIFT		12
+#define ISINK_CH_STEP_MASK		(0x7 << 12)
+#define ISINK_CH_STEP(i)		(((i) << 12) & ISINK_CH_STEP_MASK)
+#define ISINK_SFSTR0_TC_MASK		(0x3 << 1)
+#define ISINK_SFSTR0_TC(i)		(((i) << 1) & ISINK_SFSTR0_TC_MASK)
+#define ISINK_SFSTR0_EN_MASK		BIT(0)
+#define ISINK_SFSTR0_EN			BIT(0)
 
 /* Register to LED channel enablement. */
-#define MT6323_ISINK_CH_EN_MASK(i)	BIT(i)
-#define MT6323_ISINK_CH_EN(i)		BIT(i)
+#define ISINK_CH_EN_MASK(i)		BIT(i)
+#define ISINK_CH_EN(i)			BIT(i)
 
 #define MAX_SUPPORTED_LEDS		8
 
@@ -159,14 +156,14 @@ static int mt6323_led_hw_brightness(struct led_classdev *cdev,
 	 * Setup current output for the corresponding
 	 * brightness level.
 	 */
-	con2_mask |= MT6323_ISINK_CH_STEP_MASK |
-		     MT6323_ISINK_SFSTR0_TC_MASK |
-		     MT6323_ISINK_SFSTR0_EN_MASK;
-	con2_val |=  MT6323_ISINK_CH_STEP(brightness - 1) |
-		     MT6323_ISINK_SFSTR0_TC(2) |
-		     MT6323_ISINK_SFSTR0_EN;
-
-	ret = regmap_update_bits(regmap, MT6323_ISINK_CON(regs->isink_con[2], led->id),
+	con2_mask |= ISINK_CH_STEP_MASK |
+		     ISINK_SFSTR0_TC_MASK |
+		     ISINK_SFSTR0_EN_MASK;
+	con2_val |=  ISINK_CH_STEP(brightness - 1) |
+		     ISINK_SFSTR0_TC(2) |
+		     ISINK_SFSTR0_EN;
+
+	ret = regmap_update_bits(regmap, ISINK_CON(regs->isink_con[2], led->id),
 				 con2_mask, con2_val);
 	return ret;
 }
@@ -180,16 +177,16 @@ static int mt6323_led_hw_off(struct led_classdev *cdev)
 	unsigned int status;
 	int ret;
 
-	status = MT6323_ISINK_CH_EN(led->id);
+	status = ISINK_CH_EN(led->id);
 	ret = regmap_update_bits(regmap, regs->isink_en_ctrl,
-				 MT6323_ISINK_CH_EN_MASK(led->id), ~status);
+				 ISINK_CH_EN_MASK(led->id), ~status);
 	if (ret < 0)
 		return ret;
 
 	usleep_range(100, 300);
 	ret = regmap_update_bits(regmap, regs->top_ckpdn[2],
-				 MT6323_RG_ISINK_CK_PDN_MASK(led->id),
-				 MT6323_RG_ISINK_CK_PDN(led->id));
+				 RG_ISINK_CK_PDN_MASK(led->id),
+				 RG_ISINK_CK_PDN(led->id));
 	if (ret < 0)
 		return ret;
 
@@ -210,22 +207,22 @@ mt6323_get_led_hw_brightness(struct led_classdev *cdev)
 	if (ret < 0)
 		return ret;
 
-	if (status & MT6323_RG_ISINK_CK_PDN_MASK(led->id))
+	if (status & RG_ISINK_CK_PDN_MASK(led->id))
 		return 0;
 
 	ret = regmap_read(regmap, regs->isink_en_ctrl, &status);
 	if (ret < 0)
 		return ret;
 
-	if (!(status & MT6323_ISINK_CH_EN(led->id)))
+	if (!(status & ISINK_CH_EN(led->id)))
 		return 0;
 
-	ret = regmap_read(regmap, MT6323_ISINK_CON(regs->isink_con[2], led->id), &status);
+	ret = regmap_read(regmap, ISINK_CON(regs->isink_con[2], led->id), &status);
 	if (ret < 0)
 		return ret;
 
-	return  ((status & MT6323_ISINK_CH_STEP_MASK)
-		  >> MT6323_ISINK_CH_STEP_SHIFT) + 1;
+	return  ((status & ISINK_CH_STEP_MASK)
+		  >> ISINK_CH_STEP_SHIFT) + 1;
 }
 
 static int mt6323_led_hw_on(struct led_classdev *cdev,
@@ -244,13 +241,13 @@ static int mt6323_led_hw_on(struct led_classdev *cdev,
 	 * the default.
 	 */
 	ret = regmap_update_bits(regmap, regs->top_ckcon[1],
-				 MT6323_RG_ISINK_CK_SEL_MASK(led->id), 0);
+				 RG_ISINK_CK_SEL_MASK(led->id), 0);
 	if (ret < 0)
 		return ret;
 
-	status = MT6323_RG_ISINK_CK_PDN(led->id);
+	status = RG_ISINK_CK_PDN(led->id);
 	ret = regmap_update_bits(regmap, regs->top_ckpdn[2],
-				 MT6323_RG_ISINK_CK_PDN_MASK(led->id),
+				 RG_ISINK_CK_PDN_MASK(led->id),
 				 ~status);
 	if (ret < 0)
 		return ret;
@@ -258,8 +255,8 @@ static int mt6323_led_hw_on(struct led_classdev *cdev,
 	usleep_range(100, 300);
 
 	ret = regmap_update_bits(regmap, regs->isink_en_ctrl,
-				 MT6323_ISINK_CH_EN_MASK(led->id),
-				 MT6323_ISINK_CH_EN(led->id));
+				 ISINK_CH_EN_MASK(led->id),
+				 ISINK_CH_EN(led->id));
 	if (ret < 0)
 		return ret;
 
@@ -267,15 +264,15 @@ static int mt6323_led_hw_on(struct led_classdev *cdev,
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_update_bits(regmap, MT6323_ISINK_CON(regs->isink_con[0], led->id),
-				 MT6323_ISINK_DIM_DUTY_MASK,
-				 MT6323_ISINK_DIM_DUTY(31));
+	ret = regmap_update_bits(regmap, ISINK_CON(regs->isink_con[0], led->id),
+				 ISINK_DIM_DUTY_MASK,
+				 ISINK_DIM_DUTY(31));
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_update_bits(regmap, MT6323_ISINK_CON(regs->isink_con[1], led->id),
-				 MT6323_ISINK_DIM_FSEL_MASK,
-				 MT6323_ISINK_DIM_FSEL(1000));
+	ret = regmap_update_bits(regmap, ISINK_CON(regs->isink_con[1], led->id),
+				 ISINK_DIM_FSEL_MASK,
+				 ISINK_DIM_FSEL(1000));
 	if (ret < 0)
 		return ret;
 
@@ -337,15 +334,15 @@ static int mt6323_led_set_blink(struct led_classdev *cdev,
 		led->current_brightness = cdev->max_brightness;
 	}
 
-	ret = regmap_update_bits(regmap, MT6323_ISINK_CON(regs->isink_con[0], led->id),
-				 MT6323_ISINK_DIM_DUTY_MASK,
-				 MT6323_ISINK_DIM_DUTY(duty_hw - 1));
+	ret = regmap_update_bits(regmap, ISINK_CON(regs->isink_con[0], led->id),
+				 ISINK_DIM_DUTY_MASK,
+				 ISINK_DIM_DUTY(duty_hw - 1));
 	if (ret < 0)
 		goto out;
 
-	ret = regmap_update_bits(regmap, MT6323_ISINK_CON(regs->isink_con[1], led->id),
-				 MT6323_ISINK_DIM_FSEL_MASK,
-				 MT6323_ISINK_DIM_FSEL(period - 1));
+	ret = regmap_update_bits(regmap, ISINK_CON(regs->isink_con[1], led->id),
+				 ISINK_DIM_FSEL_MASK,
+				 ISINK_DIM_FSEL(period - 1));
 out:
 	mutex_unlock(&leds->lock);
 
@@ -439,9 +436,9 @@ static int mt6323_led_probe(struct platform_device *pdev)
 	leds->hw = hw;
 	mutex_init(&leds->lock);
 
-	status = MT6323_RG_DRV_32K_CK_PDN;
+	status = RG_DRV_32K_CK_PDN;
 	ret = regmap_update_bits(leds->hw->regmap, regs->top_ckpdn[0],
-				 MT6323_RG_DRV_32K_CK_PDN_MASK, ~status);
+				 RG_DRV_32K_CK_PDN_MASK, ~status);
 	if (ret < 0) {
 		dev_err(leds->dev,
 			"Failed to update TOP_CKPDN0 Register\n");
@@ -515,8 +512,8 @@ static int mt6323_led_remove(struct platform_device *pdev)
 		mt6323_led_hw_off(&leds->led[i]->cdev);
 
 	regmap_update_bits(leds->hw->regmap, regs->top_ckpdn[0],
-			   MT6323_RG_DRV_32K_CK_PDN_MASK,
-			   MT6323_RG_DRV_32K_CK_PDN);
+			   RG_DRV_32K_CK_PDN_MASK,
+			   RG_DRV_32K_CK_PDN);
 
 	mutex_destroy(&leds->lock);
 
-- 
2.35.1

