Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192D553B7BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiFBL0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbiFBL0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:26:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B3128B5FC;
        Thu,  2 Jun 2022 04:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654169173; x=1685705173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zoblnXwCznSwcPXqXhf62yaxkwT8jdjCflalvdxnlog=;
  b=acRrKZO6Xofq9nUKTwEmnSetViiI99i11lpeiQPQzBefXIFWe14h35Bn
   KDmewceWO950d0oW8YBYbbXY5fKrpPlXlLZsf54zcHCz3wvgIv/j6Dp5H
   eg3I1e6TbopI0D20mgSXPJMukimEmyvn/I/sUawp4bf9/LhGH6rH0vCbj
   kX1i0hnJ6dE86Dsbo78ZV3ez0ySkI5iaWXU5XgUDPVnNraetsP0JeVs9f
   QgfBOzF646Z5cs78xFhMHDx9cUWmfWymibvjA5H8p8qLaKHmpyeNb4B+7
   w4zHxzjx+IRHkfmWlwlhAVMj/UHcNLG23BbW4iXBNiiD0u8okjWcu7tsB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275925526"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="275925526"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 04:26:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="612780779"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 02 Jun 2022 04:26:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 96B8B5D3; Thu,  2 Jun 2022 14:26:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 3/3] gpio: crystalcove: Join function declarations and long lines
Date:   Thu,  2 Jun 2022 14:26:01 +0300
Message-Id: <20220602112601.12010-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220602112601.12010-1-andriy.shevchenko@linux.intel.com>
References: <20220602112601.12010-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no more hard limit of 80 characters for long lines, so
join a few of them for better readability.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/gpio/gpio-crystalcove.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcove.c
index 36870d14323f..1ee62cd58582 100644
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
@@ -304,8 +298,7 @@ static irqreturn_t crystalcove_gpio_irq_handler(int irq, void *data)
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

