Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997F153A9A7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355041AbiFAPH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354984AbiFAPFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:05:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372026D1B6;
        Wed,  1 Jun 2022 08:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654095898; x=1685631898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T6XEJZohHf7H/NKgnDJ4SbAbnK0kXUfU/PCHbeir4ak=;
  b=RERM6KCYKGBNMJOOkImg+kg3F74jL27ZwfVuYIZuQohrirH9c+AQXHnS
   ngjvxalKTy9a2W9MWheyIPXH4rUyqzCxGa/NXiQIcmhmhILmPyPbYv6w9
   52hgUvUqhPNZM4SE2laXliZFIKcNfbTjFp49ZEcdvYEMUgFjMlFnPxiAC
   +OjSwmD/DSJNskaRgb9+JXZTREE9+Qx3ViHFzA+WchYqCJqtJnmC5/Vfy
   +wvge3JtlcyXnZ/nNibNgwsGsurKZtvnTmLRl7g9CxPMHsFzM+mkIaJn6
   mTzj3xSM5GV5kT0VBRToPB121kUiM0a1Z1BERblSRpfb10leOOotfe8kA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="263255304"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="263255304"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 08:04:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="680138631"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2022 08:04:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0670A9A9; Wed,  1 Jun 2022 18:04:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 3/3] gpio: crystalcove: Join function declarations and long lines
Date:   Wed,  1 Jun 2022 18:04:46 +0300
Message-Id: <20220601150446.25866-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220601150446.25866-1-andriy.shevchenko@linux.intel.com>
References: <20220601150446.25866-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no more hard limit of 80 characters for long lines, so
join a few of them for better readability.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-crystalcove.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcove.c
index d4d01e734e22..e21badc10ab4 100644
--- a/drivers/gpio/gpio-crystalcove.c
+++ b/drivers/gpio/gpio-crystalcove.c
@@ -111,8 +111,7 @@ static inline int to_reg(int gpio, enum ctrl_register reg_type)
 	return reg + gpio % 8;
 }
 
-static void crystalcove_update_irq_mask(struct crystalcove_gpio *cg,
-					int gpio)
+static void crystalcove_update_irq_mask(struct crystalcove_gpio *cg, int gpio)
 {
 	u8 mirqs0 = gpio < 8 ? MGPIO0IRQS0 : MGPIO1IRQS0;
 	int mask = BIT(gpio % 8);
@@ -141,8 +140,7 @@ static int crystalcove_gpio_dir_in(struct gpio_chip *chip, unsigned int gpio)
 	return regmap_write(cg->regmap, reg, CTLO_INPUT_SET);
 }
 
-static int crystalcove_gpio_dir_out(struct gpio_chip *chip, unsigned int gpio,
-				    int value)
+static int crystalcove_gpio_dir_out(struct gpio_chip *chip, unsigned int gpio, int value)
 {
 	struct crystalcove_gpio *cg = gpiochip_get_data(chip);
 	int reg = to_reg(gpio, CTRL_OUT);
@@ -169,8 +167,7 @@ static int crystalcove_gpio_get(struct gpio_chip *chip, unsigned int gpio)
 	return val & 0x1;
 }
 
-static void crystalcove_gpio_set(struct gpio_chip *chip,
-				 unsigned int gpio, int value)
+static void crystalcove_gpio_set(struct gpio_chip *chip, unsigned int gpio, int value)
 {
 	struct crystalcove_gpio *cg = gpiochip_get_data(chip);
 	int reg = to_reg(gpio, CTRL_OUT);
@@ -186,8 +183,7 @@ static void crystalcove_gpio_set(struct gpio_chip *chip,
 
 static int crystalcove_irq_type(struct irq_data *data, unsigned int type)
 {
-	struct crystalcove_gpio *cg =
-		gpiochip_get_data(irq_data_get_irq_chip_data(data));
+	struct crystalcove_gpio *cg = gpiochip_get_data(irq_data_get_irq_chip_data(data));
 	irq_hw_number_t hwirq = irqd_to_hwirq(data);
 
 	if (hwirq >= CRYSTALCOVE_GPIO_NUM)
@@ -217,16 +213,14 @@ static int crystalcove_irq_type(struct irq_data *data, unsigned int type)
 
 static void crystalcove_bus_lock(struct irq_data *data)
 {
-	struct crystalcove_gpio *cg =
-		gpiochip_get_data(irq_data_get_irq_chip_data(data));
+	struct crystalcove_gpio *cg = gpiochip_get_data(irq_data_get_irq_chip_data(data));
 
 	mutex_lock(&cg->buslock);
 }
 
 static void crystalcove_bus_sync_unlock(struct irq_data *data)
 {
-	struct crystalcove_gpio *cg =
-		gpiochip_get_data(irq_data_get_irq_chip_data(data));
+	struct crystalcove_gpio *cg = gpiochip_get_data(irq_data_get_irq_chip_data(data));
 	irq_hw_number_t hwirq = irqd_to_hwirq(data);
 
 	if (cg->update & UPDATE_IRQ_TYPE)
@@ -302,8 +296,7 @@ static irqreturn_t crystalcove_gpio_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void crystalcove_gpio_dbg_show(struct seq_file *s,
-				      struct gpio_chip *chip)
+static void crystalcove_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 {
 	struct crystalcove_gpio *cg = gpiochip_get_data(chip);
 	int gpio, offset;
-- 
2.35.1

