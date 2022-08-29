Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1665A4D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiH2NSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiH2NRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:17:09 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF3180527;
        Mon, 29 Aug 2022 06:16:36 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TD0STm026949;
        Mon, 29 Aug 2022 09:15:05 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j7g673cdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 09:15:05 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 27TDF4tk019098
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Aug 2022 09:15:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 29 Aug
 2022 09:15:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 29 Aug 2022 09:15:03 -0400
Received: from nsa.ad.analog.com ([10.44.3.68])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 27TDEeiM026449;
        Mon, 29 Aug 2022 09:14:54 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-input@vger.kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH v4 02/10] gpio: gpio-adp5588: drop the driver
Date:   Mon, 29 Aug 2022 15:15:45 +0200
Message-ID: <20220829131553.690063-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829131553.690063-1-nuno.sa@analog.com>
References: <20220829131553.690063-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Jm3sLpojwc_GA5OlinHx1MmkBzYM6SOd
X-Proofpoint-GUID: Jm3sLpojwc_GA5OlinHx1MmkBzYM6SOd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_07,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290061
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 70466baac3de
("input: keyboard: adp5588-keys: support gpi key events as 'gpio keys'"),
the irchip functionality is directly supported in the input driver as
the main goal of these pins is to be used as gpio keys. Hence, this
driver can be removed.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 MAINTAINERS                 |   1 -
 drivers/gpio/Kconfig        |  14 --
 drivers/gpio/Makefile       |   1 -
 drivers/gpio/gpio-adp5588.c | 446 ------------------------------------
 4 files changed, 462 deletions(-)
 delete mode 100644 drivers/gpio/gpio-adp5588.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 711bcd4f6269..8404c18e6bcf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -556,7 +556,6 @@ M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
 W:	http://wiki.analog.com/ADP5588
 W:	https://ez.analog.com/linux-software-drivers
-F:	drivers/gpio/gpio-adp5588.c
 F:	drivers/input/keyboard/adp5588-keys.c
 
 ADP8860 BACKLIGHT DRIVER (ADP8860/ADP8861/ADP8863)
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0642f579196f..3055ed2e115a 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -985,20 +985,6 @@ endmenu
 menu "I2C GPIO expanders"
 	depends on I2C
 
-config GPIO_ADP5588
-	tristate "ADP5588 I2C GPIO expander"
-	help
-	  This option enables support for 18 GPIOs found
-	  on Analog Devices ADP5588 GPIO Expanders.
-
-config GPIO_ADP5588_IRQ
-	bool "Interrupt controller support for ADP5588"
-	depends on GPIO_ADP5588=y
-	select GPIOLIB_IRQCHIP
-	help
-	  Say yes here to enable the adp5588 to be used as an interrupt
-	  controller. It requires the driver to be built in the kernel.
-
 config GPIO_ADNP
 	tristate "Avionic Design N-bit GPIO expander"
 	depends on OF_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index a0985d30f51b..5b890a695f82 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -25,7 +25,6 @@ obj-$(CONFIG_GPIO_74X164)		+= gpio-74x164.o
 obj-$(CONFIG_GPIO_74XX_MMIO)		+= gpio-74xx-mmio.o
 obj-$(CONFIG_GPIO_ADNP)			+= gpio-adnp.o
 obj-$(CONFIG_GPIO_ADP5520)		+= gpio-adp5520.o
-obj-$(CONFIG_GPIO_ADP5588)		+= gpio-adp5588.o
 obj-$(CONFIG_GPIO_AGGREGATOR)		+= gpio-aggregator.o
 obj-$(CONFIG_GPIO_ALTERA_A10SR)		+= gpio-altera-a10sr.o
 obj-$(CONFIG_GPIO_ALTERA)  		+= gpio-altera.o
diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
deleted file mode 100644
index 9b562dbbd733..000000000000
--- a/drivers/gpio/gpio-adp5588.c
+++ /dev/null
@@ -1,446 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * GPIO Chip driver for Analog Devices
- * ADP5588/ADP5587 I/O Expander and QWERTY Keypad Controller
- *
- * Copyright 2009-2010 Analog Devices Inc.
- */
-
-#include <linux/gpio/driver.h>
-#include <linux/i2c.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-
-#include <linux/platform_data/adp5588.h>
-
-/*
- * Early pre 4.0 Silicon required to delay readout by at least 25ms,
- * since the Event Counter Register updated 25ms after the interrupt
- * asserted.
- */
-#define WA_DELAYED_READOUT_REVID(rev)	((rev) < 4)
-
-struct adp5588_gpio {
-	struct i2c_client *client;
-	struct gpio_chip gpio_chip;
-	struct mutex lock;	/* protect cached dir, dat_out */
-	/* protect serialized access to the interrupt controller bus */
-	struct mutex irq_lock;
-	uint8_t dat_out[3];
-	uint8_t dir[3];
-	uint8_t int_lvl_low[3];
-	uint8_t int_lvl_high[3];
-	uint8_t int_en[3];
-	uint8_t irq_mask[3];
-	uint8_t int_input_en[3];
-};
-
-static int adp5588_gpio_read(struct i2c_client *client, u8 reg)
-{
-	int ret = i2c_smbus_read_byte_data(client, reg);
-
-	if (ret < 0)
-		dev_err(&client->dev, "Read Error\n");
-
-	return ret;
-}
-
-static int adp5588_gpio_write(struct i2c_client *client, u8 reg, u8 val)
-{
-	int ret = i2c_smbus_write_byte_data(client, reg, val);
-
-	if (ret < 0)
-		dev_err(&client->dev, "Write Error\n");
-
-	return ret;
-}
-
-static int adp5588_gpio_get_value(struct gpio_chip *chip, unsigned off)
-{
-	struct adp5588_gpio *dev = gpiochip_get_data(chip);
-	unsigned bank = ADP5588_BANK(off);
-	unsigned bit = ADP5588_BIT(off);
-	int val;
-
-	mutex_lock(&dev->lock);
-
-	if (dev->dir[bank] & bit)
-		val = dev->dat_out[bank];
-	else
-		val = adp5588_gpio_read(dev->client, GPIO_DAT_STAT1 + bank);
-
-	mutex_unlock(&dev->lock);
-
-	return !!(val & bit);
-}
-
-static void adp5588_gpio_set_value(struct gpio_chip *chip,
-				   unsigned off, int val)
-{
-	unsigned bank, bit;
-	struct adp5588_gpio *dev = gpiochip_get_data(chip);
-
-	bank = ADP5588_BANK(off);
-	bit = ADP5588_BIT(off);
-
-	mutex_lock(&dev->lock);
-	if (val)
-		dev->dat_out[bank] |= bit;
-	else
-		dev->dat_out[bank] &= ~bit;
-
-	adp5588_gpio_write(dev->client, GPIO_DAT_OUT1 + bank,
-			   dev->dat_out[bank]);
-	mutex_unlock(&dev->lock);
-}
-
-static int adp5588_gpio_direction_input(struct gpio_chip *chip, unsigned off)
-{
-	int ret;
-	unsigned bank;
-	struct adp5588_gpio *dev = gpiochip_get_data(chip);
-
-	bank = ADP5588_BANK(off);
-
-	mutex_lock(&dev->lock);
-	dev->dir[bank] &= ~ADP5588_BIT(off);
-	ret = adp5588_gpio_write(dev->client, GPIO_DIR1 + bank, dev->dir[bank]);
-	mutex_unlock(&dev->lock);
-
-	return ret;
-}
-
-static int adp5588_gpio_direction_output(struct gpio_chip *chip,
-					 unsigned off, int val)
-{
-	int ret;
-	unsigned bank, bit;
-	struct adp5588_gpio *dev = gpiochip_get_data(chip);
-
-	bank = ADP5588_BANK(off);
-	bit = ADP5588_BIT(off);
-
-	mutex_lock(&dev->lock);
-	dev->dir[bank] |= bit;
-
-	if (val)
-		dev->dat_out[bank] |= bit;
-	else
-		dev->dat_out[bank] &= ~bit;
-
-	ret = adp5588_gpio_write(dev->client, GPIO_DAT_OUT1 + bank,
-				 dev->dat_out[bank]);
-	ret |= adp5588_gpio_write(dev->client, GPIO_DIR1 + bank,
-				 dev->dir[bank]);
-	mutex_unlock(&dev->lock);
-
-	return ret;
-}
-
-#ifdef CONFIG_GPIO_ADP5588_IRQ
-
-static void adp5588_irq_bus_lock(struct irq_data *d)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct adp5588_gpio *dev = gpiochip_get_data(gc);
-
-	mutex_lock(&dev->irq_lock);
-}
-
- /*
-  * genirq core code can issue chip->mask/unmask from atomic context.
-  * This doesn't work for slow busses where an access needs to sleep.
-  * bus_sync_unlock() is therefore called outside the atomic context,
-  * syncs the current irq mask state with the slow external controller
-  * and unlocks the bus.
-  */
-
-static void adp5588_irq_bus_sync_unlock(struct irq_data *d)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct adp5588_gpio *dev = gpiochip_get_data(gc);
-	int i;
-
-	for (i = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++) {
-		if (dev->int_input_en[i]) {
-			mutex_lock(&dev->lock);
-			dev->dir[i] &= ~dev->int_input_en[i];
-			dev->int_input_en[i] = 0;
-			adp5588_gpio_write(dev->client, GPIO_DIR1 + i,
-					   dev->dir[i]);
-			mutex_unlock(&dev->lock);
-		}
-
-		if (dev->int_en[i] ^ dev->irq_mask[i]) {
-			dev->int_en[i] = dev->irq_mask[i];
-			adp5588_gpio_write(dev->client, GPI_EM1 + i,
-					   dev->int_en[i]);
-		}
-	}
-
-	mutex_unlock(&dev->irq_lock);
-}
-
-static void adp5588_irq_mask(struct irq_data *d)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct adp5588_gpio *dev = gpiochip_get_data(gc);
-
-	dev->irq_mask[ADP5588_BANK(d->hwirq)] &= ~ADP5588_BIT(d->hwirq);
-}
-
-static void adp5588_irq_unmask(struct irq_data *d)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct adp5588_gpio *dev = gpiochip_get_data(gc);
-
-	dev->irq_mask[ADP5588_BANK(d->hwirq)] |= ADP5588_BIT(d->hwirq);
-}
-
-static int adp5588_irq_set_type(struct irq_data *d, unsigned int type)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct adp5588_gpio *dev = gpiochip_get_data(gc);
-	uint16_t gpio = d->hwirq;
-	unsigned bank, bit;
-
-	bank = ADP5588_BANK(gpio);
-	bit = ADP5588_BIT(gpio);
-
-	dev->int_lvl_low[bank] &= ~bit;
-	dev->int_lvl_high[bank] &= ~bit;
-
-	if (type & IRQ_TYPE_EDGE_BOTH || type & IRQ_TYPE_LEVEL_HIGH)
-		dev->int_lvl_high[bank] |= bit;
-
-	if (type & IRQ_TYPE_EDGE_BOTH || type & IRQ_TYPE_LEVEL_LOW)
-		dev->int_lvl_low[bank] |= bit;
-
-	dev->int_input_en[bank] |= bit;
-
-	return 0;
-}
-
-static struct irq_chip adp5588_irq_chip = {
-	.name			= "adp5588",
-	.irq_mask		= adp5588_irq_mask,
-	.irq_unmask		= adp5588_irq_unmask,
-	.irq_bus_lock		= adp5588_irq_bus_lock,
-	.irq_bus_sync_unlock	= adp5588_irq_bus_sync_unlock,
-	.irq_set_type		= adp5588_irq_set_type,
-};
-
-static irqreturn_t adp5588_irq_handler(int irq, void *devid)
-{
-	struct adp5588_gpio *dev = devid;
-	int status = adp5588_gpio_read(dev->client, INT_STAT);
-
-	if (status & ADP5588_KE_INT) {
-		int ev_cnt = adp5588_gpio_read(dev->client, KEY_LCK_EC_STAT);
-
-		if (ev_cnt > 0) {
-			int i;
-
-			for (i = 0; i < (ev_cnt & ADP5588_KEC); i++) {
-				int key = adp5588_gpio_read(dev->client,
-							    Key_EVENTA + i);
-				/* GPIN events begin at 97,
-				 * bit 7 indicates logic level
-				 */
-				int gpio = (key & 0x7f) - 97;
-				int lvl = key & (1 << 7);
-				int bank = ADP5588_BANK(gpio);
-				int bit = ADP5588_BIT(gpio);
-
-				if ((lvl && dev->int_lvl_high[bank] & bit) ||
-				    (!lvl && dev->int_lvl_low[bank] & bit))
-					handle_nested_irq(irq_find_mapping(
-					      dev->gpio_chip.irq.domain, gpio));
-			}
-		}
-	}
-
-	adp5588_gpio_write(dev->client, INT_STAT, status); /* Status is W1C */
-
-	return IRQ_HANDLED;
-}
-
-
-static int adp5588_irq_init_hw(struct gpio_chip *gc)
-{
-	struct adp5588_gpio *dev = gpiochip_get_data(gc);
-	/* Enable IRQs after registering chip */
-	adp5588_gpio_write(dev->client, CFG,
-			   ADP5588_AUTO_INC | ADP5588_INT_CFG | ADP5588_KE_IEN);
-
-	return 0;
-}
-
-static int adp5588_irq_setup(struct adp5588_gpio *dev)
-{
-	struct i2c_client *client = dev->client;
-	int ret;
-	struct adp5588_gpio_platform_data *pdata =
-			dev_get_platdata(&client->dev);
-	struct gpio_irq_chip *girq;
-
-	adp5588_gpio_write(client, CFG, ADP5588_AUTO_INC);
-	adp5588_gpio_write(client, INT_STAT, -1); /* status is W1C */
-
-	mutex_init(&dev->irq_lock);
-
-	ret = devm_request_threaded_irq(&client->dev, client->irq,
-					NULL, adp5588_irq_handler, IRQF_ONESHOT
-					| IRQF_TRIGGER_FALLING | IRQF_SHARED,
-					dev_name(&client->dev), dev);
-	if (ret) {
-		dev_err(&client->dev, "failed to request irq %d\n",
-			client->irq);
-		return ret;
-	}
-
-	/* This will be registered in the call to devm_gpiochip_add_data() */
-	girq = &dev->gpio_chip.irq;
-	girq->chip = &adp5588_irq_chip;
-	/* This will let us handle the parent IRQ in the driver */
-	girq->parent_handler = NULL;
-	girq->num_parents = 0;
-	girq->parents = NULL;
-	girq->first = pdata ? pdata->irq_base : 0;
-	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_simple_irq;
-	girq->init_hw = adp5588_irq_init_hw;
-	girq->threaded = true;
-
-	return 0;
-}
-
-#else
-static int adp5588_irq_setup(struct adp5588_gpio *dev)
-{
-	struct i2c_client *client = dev->client;
-	dev_warn(&client->dev, "interrupt support not compiled in\n");
-
-	return 0;
-}
-
-#endif /* CONFIG_GPIO_ADP5588_IRQ */
-
-static int adp5588_gpio_probe(struct i2c_client *client)
-{
-	struct adp5588_gpio_platform_data *pdata =
-			dev_get_platdata(&client->dev);
-	struct adp5588_gpio *dev;
-	struct gpio_chip *gc;
-	int ret, i, revid;
-	unsigned int pullup_dis_mask = 0;
-
-	if (!i2c_check_functionality(client->adapter,
-					I2C_FUNC_SMBUS_BYTE_DATA)) {
-		dev_err(&client->dev, "SMBUS Byte Data not Supported\n");
-		return -EIO;
-	}
-
-	dev = devm_kzalloc(&client->dev, sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return -ENOMEM;
-
-	dev->client = client;
-
-	gc = &dev->gpio_chip;
-	gc->direction_input = adp5588_gpio_direction_input;
-	gc->direction_output = adp5588_gpio_direction_output;
-	gc->get = adp5588_gpio_get_value;
-	gc->set = adp5588_gpio_set_value;
-	gc->can_sleep = true;
-	gc->base = -1;
-	gc->parent = &client->dev;
-
-	if (pdata) {
-		gc->base = pdata->gpio_start;
-		gc->names = pdata->names;
-		pullup_dis_mask = pdata->pullup_dis_mask;
-	}
-
-	gc->ngpio = ADP5588_MAXGPIO;
-	gc->label = client->name;
-	gc->owner = THIS_MODULE;
-
-	mutex_init(&dev->lock);
-
-	ret = adp5588_gpio_read(dev->client, DEV_ID);
-	if (ret < 0)
-		return ret;
-
-	revid = ret & ADP5588_DEVICE_ID_MASK;
-
-	for (i = 0, ret = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++) {
-		dev->dat_out[i] = adp5588_gpio_read(client, GPIO_DAT_OUT1 + i);
-		dev->dir[i] = adp5588_gpio_read(client, GPIO_DIR1 + i);
-		ret |= adp5588_gpio_write(client, KP_GPIO1 + i, 0);
-		ret |= adp5588_gpio_write(client, GPIO_PULL1 + i,
-				(pullup_dis_mask >> (8 * i)) & 0xFF);
-		ret |= adp5588_gpio_write(client, GPIO_INT_EN1 + i, 0);
-		if (ret)
-			return ret;
-	}
-
-	if (client->irq) {
-		if (WA_DELAYED_READOUT_REVID(revid)) {
-			dev_warn(&client->dev, "GPIO int not supported\n");
-		} else {
-			ret = adp5588_irq_setup(dev);
-			if (ret)
-				return ret;
-		}
-	}
-
-	ret = devm_gpiochip_add_data(&client->dev, &dev->gpio_chip, dev);
-	if (ret)
-		return ret;
-
-	i2c_set_clientdata(client, dev);
-
-	return 0;
-}
-
-static void adp5588_gpio_remove(struct i2c_client *client)
-{
-	struct adp5588_gpio *dev = i2c_get_clientdata(client);
-
-	if (dev->client->irq)
-		free_irq(dev->client->irq, dev);
-}
-
-static const struct i2c_device_id adp5588_gpio_id[] = {
-	{ "adp5588-gpio" },
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, adp5588_gpio_id);
-
-static const struct of_device_id adp5588_gpio_of_id[] = {
-	{ .compatible = "adi,adp5588-gpio" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, adp5588_gpio_of_id);
-
-static struct i2c_driver adp5588_gpio_driver = {
-	.driver = {
-		.name = "adp5588-gpio",
-		.of_match_table = adp5588_gpio_of_id,
-	},
-	.probe_new = adp5588_gpio_probe,
-	.remove = adp5588_gpio_remove,
-	.id_table = adp5588_gpio_id,
-};
-
-module_i2c_driver(adp5588_gpio_driver);
-
-MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("GPIO ADP5588 Driver");
-MODULE_LICENSE("GPL");
-- 
2.37.2

