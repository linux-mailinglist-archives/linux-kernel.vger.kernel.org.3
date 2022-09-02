Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87465AB857
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiIBSfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiIBSe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:34:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16DB110DB3;
        Fri,  2 Sep 2022 11:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662143210; x=1693679210;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ND91XIHDSWohHAk+2uk3acPnsWKSM2E/c7zJlBjDfOg=;
  b=Himl8uAZbL8kfBeYj44kKiPe+zyLn+nD/f41rnQB/UBSbEFMYLRbktKX
   QbNSi1eYIjYeNNNfpdXHaI+cS5icBTrcUYcl2Xp9bqOg2b+32n2esqkhl
   lMWyubj8Tp7rB6BAOPGz8TyVfiUL99gLsuo5orGQOPLgvkhsNz3SYNcnU
   1nXjqDlARhQu6AZ8ZgGRJSh7NK77Kr2C00/UyTrZZro7FdooEXZ+BPT4Z
   GGZchP4sicuzw00TsIR/v2HIa9IJly/ruS/WzM+2g8PQ1IkKpV0oJebsw
   5Rr0o2mZezXVTu8yUWfr35I0hyZyi9Ckg5XyupkoXX4cfokJ9qm3Tq0tK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="296832735"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="296832735"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="615791667"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Sep 2022 11:26:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 79D6A8BE; Fri,  2 Sep 2022 21:27:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 17/17] pinctrl: cy8c95x0: Correct comment style
Date:   Fri,  2 Sep 2022 21:26:50 +0300
Message-Id: <20220902182650.83098-17-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a few comments the style is not aligned with the rest.
Correct them.

While at it, drop unneeded blank lines and deduplicate 'Author'.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 40 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 57302cb0186f..fc2c54164669 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -3,8 +3,8 @@
  * CY8C95X0 20/40/60 pin I2C GPIO port expander with interrupt support
  *
  * Copyright (C) 2022 9elements GmbH
- * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
- * Author: Naresh Solanki <Naresh.Solanki@9elements.com>
+ * Authors: Patrick Rudolph <patrick.rudolph@9elements.com>
+ *	    Naresh Solanki <Naresh.Solanki@9elements.com>
  */
 
 #include <linux/acpi.h>
@@ -37,7 +37,7 @@
 
 /* Port Select configures the port */
 #define CY8C95X0_PORTSEL	0x18
-/* port settings, write PORTSEL first */
+/* Port settings, write PORTSEL first */
 #define CY8C95X0_INTMASK	0x19
 #define CY8C95X0_PWMSEL		0x1A
 #define CY8C95X0_INVERT		0x1B
@@ -72,7 +72,6 @@ static const struct of_device_id cy8c95x0_dt_ids[] = {
 	{ .compatible = "cypress,cy8c9560", .data = OF_CY8C95X(60), },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(of, cy8c95x0_dt_ids);
 
 static const struct acpi_gpio_params cy8c95x0_irq_gpios = { 0, 0, true };
@@ -418,7 +417,7 @@ static int cy8c95x0_write_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
 			continue;
 
 		switch (reg) {
-		/* muxed registers */
+		/* Muxed registers */
 		case CY8C95X0_INTMASK:
 		case CY8C95X0_PWMSEL:
 		case CY8C95X0_INVERT:
@@ -435,7 +434,7 @@ static int cy8c95x0_write_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
 				goto out;
 			off = reg;
 			break;
-		/* direct access registers */
+		/* Direct access registers */
 		case CY8C95X0_INPUT:
 		case CY8C95X0_OUTPUT:
 		case CY8C95X0_INTSTATUS:
@@ -489,7 +488,7 @@ static int cy8c95x0_read_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
 			continue;
 
 		switch (reg) {
-		/* muxed registers */
+		/* Muxed registers */
 		case CY8C95X0_INTMASK:
 		case CY8C95X0_PWMSEL:
 		case CY8C95X0_INVERT:
@@ -506,7 +505,7 @@ static int cy8c95x0_read_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
 				goto out;
 			off = reg;
 			break;
-		/* direct access registers */
+		/* Direct access registers */
 		case CY8C95X0_INPUT:
 		case CY8C95X0_OUTPUT:
 		case CY8C95X0_INTSTATUS:
@@ -581,18 +580,18 @@ static int cy8c95x0_gpio_direction_output(struct gpio_chip *gc,
 	u8 bit = cypress_get_pin_mask(chip, off);
 	int ret;
 
-	/* set output level */
+	/* Set output level */
 	ret = regmap_write_bits(chip->regmap, outreg, bit, val ? bit : 0);
 	if (ret)
 		return ret;
 
 	mutex_lock(&chip->i2c_lock);
-	/* select port */
+	/* Select port... */
 	ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
 	if (ret)
 		goto out;
 
-	/* then direction */
+	/* ...then direction */
 	ret = regmap_write_bits(chip->regmap, CY8C95X0_DIRECTION, bit, 0);
 
 out:
@@ -613,7 +612,7 @@ static int cy8c95x0_gpio_get_value(struct gpio_chip *gc, unsigned int off)
 	if (ret < 0) {
 		/*
 		 * NOTE:
-		 * diagnostic already emitted; that's all we should
+		 * Diagnostic already emitted; that's all we should
 		 * do unless gpio_*_value_cansleep() calls become different
 		 * from their nonsleeping siblings (and report faults).
 		 */
@@ -676,7 +675,7 @@ static int cy8c95x0_gpio_get_pincfg(struct cy8c95x0_pinctrl *chip,
 
 	mutex_lock(&chip->i2c_lock);
 
-	/* select port */
+	/* Select port */
 	ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
 	if (ret < 0)
 		goto out;
@@ -731,7 +730,8 @@ static int cy8c95x0_gpio_get_pincfg(struct cy8c95x0_pinctrl *chip,
 		ret = -ENOTSUPP;
 		goto out;
 	}
-	/* Writing 1 to one of the drive mode registers will automatically
+	/*
+	 * Writing 1 to one of the drive mode registers will automatically
 	 * clear conflicting set bits in the other drive mode registers.
 	 */
 	ret = regmap_read(chip->regmap, reg, &reg_val);
@@ -757,7 +757,7 @@ static int cy8c95x0_gpio_set_pincfg(struct cy8c95x0_pinctrl *chip,
 
 	mutex_lock(&chip->i2c_lock);
 
-	/* select port */
+	/* Select port */
 	ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
 	if (ret < 0)
 		goto out;
@@ -794,7 +794,8 @@ static int cy8c95x0_gpio_set_pincfg(struct cy8c95x0_pinctrl *chip,
 		ret = -ENOTSUPP;
 		goto out;
 	}
-	/* Writing 1 to one of the drive mode registers will automatically
+	/*
+	 * Writing 1 to one of the drive mode registers will automatically
 	 * clear conflicting set bits in the other drive mode registers.
 	 */
 	ret = regmap_write_bits(chip->regmap, reg, bit, bit);
@@ -1119,7 +1120,7 @@ static int cy8c95x0_pinmux_cfg(struct cy8c95x0_pinctrl *chip,
 	u8 bit = cypress_get_pin_mask(chip, off);
 	int ret;
 
-	/* select port */
+	/* Select port */
 	ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
 	if (ret < 0)
 		return ret;
@@ -1236,11 +1237,12 @@ static int cy8c95x0_setup_pinctrl(struct cy8c95x0_pinctrl *chip)
 	pd->pins = cy8c9560_pins;
 	pd->npins = chip->tpin;
 	pd->owner = THIS_MODULE;
-	chip->pctldev = devm_pinctrl_register(chip->dev, pd, chip);
 
+	chip->pctldev = devm_pinctrl_register(chip->dev, pd, chip);
 	if (IS_ERR(chip->pctldev))
 		return dev_err_probe(chip->dev, PTR_ERR(chip->pctldev),
 			"can't register controller\n");
+
 	return 0;
 }
 
@@ -1293,7 +1295,6 @@ static int cy8c95x0_probe(struct i2c_client *client)
 	chip->driver_data = (unsigned long)device_get_match_data(&client->dev);
 	if (!chip->driver_data)
 		chip->driver_data = i2c_match_id(cy8c95x0_id, client)->driver_data;
-
 	if (!chip->driver_data)
 		return -ENODEV;
 
@@ -1395,7 +1396,6 @@ static struct i2c_driver cy8c95x0_driver = {
 	.id_table	= cy8c95x0_id,
 	.detect		= cy8c95x0_detect,
 };
-
 module_i2c_driver(cy8c95x0_driver);
 
 MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
-- 
2.35.1

