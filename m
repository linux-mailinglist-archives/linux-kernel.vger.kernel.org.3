Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954425A5050
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiH2PjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiH2PjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:39:07 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A718E987;
        Mon, 29 Aug 2022 08:39:05 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TDCjKm025947;
        Mon, 29 Aug 2022 09:15:09 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j7g673ce6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 09:15:08 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 27TDF7wB019110
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Aug 2022 09:15:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 29 Aug
 2022 09:15:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 29 Aug 2022 09:15:06 -0400
Received: from nsa.ad.analog.com ([10.44.3.68])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 27TDEeiO026449;
        Mon, 29 Aug 2022 09:14:58 -0400
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
Subject: [PATCH v4 04/10] input: keyboard: adp5588-keys: add support for fw properties
Date:   Mon, 29 Aug 2022 15:15:47 +0200
Message-ID: <20220829131553.690063-5-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829131553.690063-1-nuno.sa@analog.com>
References: <20220829131553.690063-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: s_EaSeIIwOAFgDAaLFL4ESexj5zhq9ps
X-Proofpoint-GUID: s_EaSeIIwOAFgDAaLFL4ESexj5zhq9ps
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

Use firmware properties (eg: OF) to get the device specific
configuration. This change just replaces the platform data since there
was no platform using it and so, it makes no sense having both.

Special note to the PULL-UP disable setting that is now supported as
part of the gpio subsystem (using 'set_config()' callback).

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/input/keyboard/Kconfig        |   1 +
 drivers/input/keyboard/adp5588-keys.c | 394 +++++++++++++++++++-------
 include/linux/platform_data/adp5588.h | 169 -----------
 3 files changed, 288 insertions(+), 276 deletions(-)
 delete mode 100644 include/linux/platform_data/adp5588.h

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index ca5cd5e520a7..be4a6f8165cd 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -42,6 +42,7 @@ config KEYBOARD_ADP5588
 	depends on I2C
 	select GPIOLIB
 	select GPIOLIB_IRQCHIP
+	select INPUT_MATRIXKMAP
 	help
 	  Say Y here if you want to use a ADP5588/87 attached to your
 	  system I2C bus.
diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 2452ea4128b3..2b00bc0f174c 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -13,16 +13,149 @@
 #include <linux/gpio/driver.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
+#include <linux/input/matrix_keypad.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/ktime.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
 
-#include <linux/platform_data/adp5588.h>
+#define DEV_ID 0x00		/* Device ID */
+#define CFG 0x01		/* Configuration Register1 */
+#define INT_STAT 0x02		/* Interrupt Status Register */
+#define KEY_LCK_EC_STAT 0x03	/* Key Lock and Event Counter Register */
+#define Key_EVENTA 0x04		/* Key Event Register A */
+#define Key_EVENTB 0x05		/* Key Event Register B */
+#define Key_EVENTC 0x06		/* Key Event Register C */
+#define Key_EVENTD 0x07		/* Key Event Register D */
+#define Key_EVENTE 0x08		/* Key Event Register E */
+#define Key_EVENTF 0x09		/* Key Event Register F */
+#define Key_EVENTG 0x0A		/* Key Event Register G */
+#define Key_EVENTH 0x0B		/* Key Event Register H */
+#define Key_EVENTI 0x0C		/* Key Event Register I */
+#define Key_EVENTJ 0x0D		/* Key Event Register J */
+#define KP_LCK_TMR 0x0E		/* Keypad Lock1 to Lock2 Timer */
+#define UNLOCK1 0x0F		/* Unlock Key1 */
+#define UNLOCK2 0x10		/* Unlock Key2 */
+#define GPIO_INT_STAT1 0x11	/* GPIO Interrupt Status */
+#define GPIO_INT_STAT2 0x12	/* GPIO Interrupt Status */
+#define GPIO_INT_STAT3 0x13	/* GPIO Interrupt Status */
+#define GPIO_DAT_STAT1 0x14	/* GPIO Data Status, Read twice to clear */
+#define GPIO_DAT_STAT2 0x15	/* GPIO Data Status, Read twice to clear */
+#define GPIO_DAT_STAT3 0x16	/* GPIO Data Status, Read twice to clear */
+#define GPIO_DAT_OUT1 0x17	/* GPIO DATA OUT */
+#define GPIO_DAT_OUT2 0x18	/* GPIO DATA OUT */
+#define GPIO_DAT_OUT3 0x19	/* GPIO DATA OUT */
+#define GPIO_INT_EN1 0x1A	/* GPIO Interrupt Enable */
+#define GPIO_INT_EN2 0x1B	/* GPIO Interrupt Enable */
+#define GPIO_INT_EN3 0x1C	/* GPIO Interrupt Enable */
+#define KP_GPIO1 0x1D		/* Keypad or GPIO Selection */
+#define KP_GPIO2 0x1E		/* Keypad or GPIO Selection */
+#define KP_GPIO3 0x1F		/* Keypad or GPIO Selection */
+#define GPI_EM1 0x20		/* GPI Event Mode 1 */
+#define GPI_EM2 0x21		/* GPI Event Mode 2 */
+#define GPI_EM3 0x22		/* GPI Event Mode 3 */
+#define GPIO_DIR1 0x23		/* GPIO Data Direction */
+#define GPIO_DIR2 0x24		/* GPIO Data Direction */
+#define GPIO_DIR3 0x25		/* GPIO Data Direction */
+#define GPIO_INT_LVL1 0x26	/* GPIO Edge/Level Detect */
+#define GPIO_INT_LVL2 0x27	/* GPIO Edge/Level Detect */
+#define GPIO_INT_LVL3 0x28	/* GPIO Edge/Level Detect */
+#define Debounce_DIS1 0x29	/* Debounce Disable */
+#define Debounce_DIS2 0x2A	/* Debounce Disable */
+#define Debounce_DIS3 0x2B	/* Debounce Disable */
+#define GPIO_PULL1 0x2C		/* GPIO Pull Disable */
+#define GPIO_PULL2 0x2D		/* GPIO Pull Disable */
+#define GPIO_PULL3 0x2E		/* GPIO Pull Disable */
+#define CMP_CFG_STAT 0x30	/* Comparator Configuration and Status Register */
+#define CMP_CONFG_SENS1 0x31	/* Sensor1 Comparator Configuration Register */
+#define CMP_CONFG_SENS2 0x32	/* L2 Light Sensor Reference Level, Output Falling for Sensor 1 */
+#define CMP1_LVL2_TRIP 0x33	/* L2 Light Sensor Hysteresis (Active when Output Rising) for Sensor 1 */
+#define CMP1_LVL2_HYS 0x34	/* L3 Light Sensor Reference Level, Output Falling For Sensor 1 */
+#define CMP1_LVL3_TRIP 0x35	/* L3 Light Sensor Hysteresis (Active when Output Rising) For Sensor 1 */
+#define CMP1_LVL3_HYS 0x36	/* Sensor 2 Comparator Configuration Register */
+#define CMP2_LVL2_TRIP 0x37	/* L2 Light Sensor Reference Level, Output Falling for Sensor 2 */
+#define CMP2_LVL2_HYS 0x38	/* L2 Light Sensor Hysteresis (Active when Output Rising) for Sensor 2 */
+#define CMP2_LVL3_TRIP 0x39	/* L3 Light Sensor Reference Level, Output Falling For Sensor 2 */
+#define CMP2_LVL3_HYS 0x3A	/* L3 Light Sensor Hysteresis (Active when Output Rising) For Sensor 2 */
+#define CMP1_ADC_DAT_R1 0x3B	/* Comparator 1 ADC data Register1 */
+#define CMP1_ADC_DAT_R2 0x3C	/* Comparator 1 ADC data Register2 */
+#define CMP2_ADC_DAT_R1 0x3D	/* Comparator 2 ADC data Register1 */
+#define CMP2_ADC_DAT_R2 0x3E	/* Comparator 2 ADC data Register2 */
+
+#define ADP5588_DEVICE_ID_MASK	0xF
+
+ /* Configuration Register1 */
+#define ADP5588_AUTO_INC	(1 << 7)
+#define ADP5588_GPIEM_CFG	(1 << 6)
+#define ADP5588_OVR_FLOW_M	(1 << 5)
+#define ADP5588_INT_CFG		(1 << 4)
+#define ADP5588_OVR_FLOW_IEN	(1 << 3)
+#define ADP5588_K_LCK_IM	(1 << 2)
+#define ADP5588_GPI_IEN		(1 << 1)
+#define ADP5588_KE_IEN		(1 << 0)
+
+/* Interrupt Status Register */
+#define ADP5588_CMP2_INT	(1 << 5)
+#define ADP5588_CMP1_INT	(1 << 4)
+#define ADP5588_OVR_FLOW_INT	(1 << 3)
+#define ADP5588_K_LCK_INT	(1 << 2)
+#define ADP5588_GPI_INT		(1 << 1)
+#define ADP5588_KE_INT		(1 << 0)
+
+/* Key Lock and Event Counter Register */
+#define ADP5588_K_LCK_EN	(1 << 6)
+#define ADP5588_LCK21		0x30
+#define ADP5588_KEC		0xF
+
+#define ADP5588_MAXGPIO		18
+#define ADP5588_BANK(offs)	((offs) >> 3)
+#define ADP5588_BIT(offs)	(1u << ((offs) & 0x7))
+
+/* Put one of these structures in i2c_board_info platform_data */
+
+/*
+ * 128 so it fits matrix-keymap maximum number of keys when the full
+ * 10cols * 8rows are used.
+ */
+#define ADP5588_KEYMAPSIZE 128
+
+#define GPI_PIN_ROW0 97
+#define GPI_PIN_ROW1 98
+#define GPI_PIN_ROW2 99
+#define GPI_PIN_ROW3 100
+#define GPI_PIN_ROW4 101
+#define GPI_PIN_ROW5 102
+#define GPI_PIN_ROW6 103
+#define GPI_PIN_ROW7 104
+#define GPI_PIN_COL0 105
+#define GPI_PIN_COL1 106
+#define GPI_PIN_COL2 107
+#define GPI_PIN_COL3 108
+#define GPI_PIN_COL4 109
+#define GPI_PIN_COL5 110
+#define GPI_PIN_COL6 111
+#define GPI_PIN_COL7 112
+#define GPI_PIN_COL8 113
+#define GPI_PIN_COL9 114
+
+#define GPI_PIN_ROW_BASE GPI_PIN_ROW0
+#define GPI_PIN_ROW_END GPI_PIN_ROW7
+#define GPI_PIN_COL_BASE GPI_PIN_COL0
+#define GPI_PIN_COL_END GPI_PIN_COL9
+
+#define GPI_PIN_BASE GPI_PIN_ROW_BASE
+#define GPI_PIN_END GPI_PIN_COL_END
+
+#define ADP5588_ROWS_MAX (GPI_PIN_ROW7 - GPI_PIN_ROW0 + 1)
+#define ADP5588_COLS_MAX (GPI_PIN_COL9 - GPI_PIN_COL0 + 1)
+
+#define ADP5588_GPIMAPSIZE_MAX (GPI_PIN_END - GPI_PIN_BASE + 1)
 
 /* Key Event Register xy */
 #define KEY_EV_PRESSED		(1 << 7)
@@ -47,6 +180,11 @@ struct adp5588_kpad {
 	struct input_dev *input;
 	ktime_t irq_time;
 	unsigned long delay;
+	u32 row_shift;
+	u32 rows;
+	u32 cols;
+	u32 unlock_keys[2];
+	int nkeys_unlock;
 	unsigned short keycode[ADP5588_KEYMAPSIZE];
 	unsigned char gpiomap[ADP5588_MAXGPIO];
 	struct gpio_chip gc;
@@ -55,6 +193,7 @@ struct adp5588_kpad {
 	u8 dir[3];
 	u8 int_en[3];
 	u8 irq_mask[3];
+	u8 pull_dis[3];
 };
 
 static int adp5588_read(struct i2c_client *client, u8 reg)
@@ -111,6 +250,40 @@ static void adp5588_gpio_set_value(struct gpio_chip *chip,
 	mutex_unlock(&kpad->gpio_lock);
 }
 
+static int adp5588_gpio_set_config(struct gpio_chip *chip,  unsigned int off,
+				   unsigned long config)
+{
+	struct adp5588_kpad *kpad = gpiochip_get_data(chip);
+	unsigned int bank = ADP5588_BANK(kpad->gpiomap[off]);
+	unsigned int bit = ADP5588_BIT(kpad->gpiomap[off]), pull_disable;
+	int ret;
+
+	switch (pinconf_to_config_param(config)) {
+	case PIN_CONFIG_BIAS_PULL_UP:
+		pull_disable = 0;
+		break;
+	case PIN_CONFIG_BIAS_DISABLE:
+		pull_disable = 1;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	mutex_lock(&kpad->gpio_lock);
+
+	if (pull_disable)
+		kpad->pull_dis[bank] |= bit;
+	else
+		kpad->pull_dis[bank] &= bit;
+
+	ret = adp5588_write(kpad->client, GPIO_PULL1 + bank,
+			    kpad->pull_dis[bank]);
+
+	mutex_unlock(&kpad->gpio_lock);
+
+	return ret;
+}
+
 static int adp5588_gpio_direction_input(struct gpio_chip *chip, unsigned off)
 {
 	struct adp5588_kpad *kpad = gpiochip_get_data(chip);
@@ -159,8 +332,7 @@ static int adp5588_gpio_direction_output(struct gpio_chip *chip,
 	return ret;
 }
 
-static int adp5588_build_gpiomap(struct adp5588_kpad *kpad,
-				const struct adp5588_kpad_platform_data *pdata)
+static int adp5588_build_gpiomap(struct adp5588_kpad *kpad)
 {
 	bool pin_used[ADP5588_MAXGPIO];
 	int n_unused = 0;
@@ -168,10 +340,10 @@ static int adp5588_build_gpiomap(struct adp5588_kpad *kpad,
 
 	memset(pin_used, 0, sizeof(pin_used));
 
-	for (i = 0; i < pdata->rows; i++)
+	for (i = 0; i < kpad->rows; i++)
 		pin_used[i] = true;
 
-	for (i = 0; i < pdata->cols; i++)
+	for (i = 0; i < kpad->cols; i++)
 		pin_used[i + GPI_PIN_COL_BASE - GPI_PIN_BASE] = true;
 
 	for (i = 0; i < ADP5588_MAXGPIO; i++)
@@ -181,21 +353,6 @@ static int adp5588_build_gpiomap(struct adp5588_kpad *kpad,
 	return n_unused;
 }
 
-static void adp5588_gpio_do_teardown(void *_kpad)
-{
-	struct adp5588_kpad *kpad = _kpad;
-	struct device *dev = &kpad->client->dev;
-	const struct adp5588_kpad_platform_data *pdata = dev_get_platdata(dev);
-	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
-	int error;
-
-	error = gpio_data->teardown(kpad->client,
-				    kpad->gc.base, kpad->gc.ngpio,
-				    gpio_data->context);
-	if (error)
-		dev_warn(&kpad->client->dev, "teardown failed %d\n", error);
-}
-
 static void adp5588_irq_bus_lock(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
@@ -266,15 +423,10 @@ static const struct irq_chip adp5588_irq_chip = {
 static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 {
 	struct device *dev = &kpad->client->dev;
-	const struct adp5588_kpad_platform_data *pdata = dev_get_platdata(dev);
-	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
 	struct gpio_irq_chip *girq;
 	int i, error;
 
-	if (!gpio_data)
-		return 0;
-
-	kpad->gc.ngpio = adp5588_build_gpiomap(kpad, pdata);
+	kpad->gc.ngpio = adp5588_build_gpiomap(kpad);
 	if (kpad->gc.ngpio == 0) {
 		dev_info(dev, "No unused gpios left to export\n");
 		return 0;
@@ -285,12 +437,12 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 	kpad->gc.direction_output = adp5588_gpio_direction_output;
 	kpad->gc.get = adp5588_gpio_get_value;
 	kpad->gc.set = adp5588_gpio_set_value;
+	kpad->gc.set_config = adp5588_gpio_set_config;
 	kpad->gc.can_sleep = 1;
 
-	kpad->gc.base = gpio_data->gpio_start;
+	kpad->gc.base = -1;
 	kpad->gc.label = kpad->client->name;
 	kpad->gc.owner = THIS_MODULE;
-	kpad->gc.names = gpio_data->names;
 
 	girq = &kpad->gc.irq;
 	gpio_irq_chip_set_chip(girq, &adp5588_irq_chip);
@@ -309,21 +461,7 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 		kpad->dat_out[i] = adp5588_read(kpad->client,
 						GPIO_DAT_OUT1 + i);
 		kpad->dir[i] = adp5588_read(kpad->client, GPIO_DIR1 + i);
-	}
-
-	if (gpio_data->setup) {
-		error = gpio_data->setup(kpad->client,
-					 kpad->gc.base, kpad->gc.ngpio,
-					 gpio_data->context);
-		if (error)
-			dev_warn(dev, "setup failed: %d\n", error);
-	}
-
-	if (gpio_data->teardown) {
-		error = devm_add_action(dev, adp5588_gpio_do_teardown, kpad);
-		if (error)
-			dev_warn(dev, "failed to schedule teardown: %d\n",
-				 error);
+		kpad->pull_dis[i] = adp5588_read(kpad->client, GPIO_PULL1 + i);
 	}
 
 	return 0;
@@ -390,12 +528,21 @@ static void adp5588_report_events(struct adp5588_kpad *kpad, int ev_cnt)
 		int key_val = key & KEY_EV_MASK;
 		int key_press = key & KEY_EV_PRESSED;
 
-		if (key_val >= GPI_PIN_BASE && key_val <= GPI_PIN_END)
+		if (key_val >= GPI_PIN_BASE && key_val <= GPI_PIN_END) {
 			/* gpio line used as IRQ source */
 			adp5588_gpio_irq_handle(kpad, key_val, key_press);
-		else
+		} else {
+			int row = (key_val - 1) / ADP5588_COLS_MAX;
+			int col =  (key_val - 1) % ADP5588_COLS_MAX;
+			int code = MATRIX_SCAN_CODE(row, col, kpad->row_shift);
+
+			dev_dbg_ratelimited(&kpad->client->dev,
+					    "report key(%d) r(%d) c(%d) code(%d)\n",
+					    key_val, row, col, kpad->keycode[code]);
+
 			input_report_key(kpad->input,
-					 kpad->keycode[key_val - 1], key_press);
+					 kpad->keycode[code], key_press);
+		}
 	}
 }
 
@@ -447,34 +594,30 @@ static irqreturn_t adp5588_thread_irq(int irq, void *handle)
 	return IRQ_HANDLED;
 }
 
-static int adp5588_setup(struct i2c_client *client)
+static int adp5588_setup(struct adp5588_kpad *kpad)
 {
-	const struct adp5588_kpad_platform_data *pdata =
-			dev_get_platdata(&client->dev);
-	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
+	struct i2c_client *client = kpad->client;
 	int i, ret;
 
-	ret = adp5588_write(client, KP_GPIO1, KP_SEL(pdata->rows));
+	ret = adp5588_write(client, KP_GPIO1, KP_SEL(kpad->rows));
 	if (ret)
 		return ret;
 
-	ret = adp5588_write(client, KP_GPIO2, KP_SEL(pdata->cols) & 0xFF);
+	ret = adp5588_write(client, KP_GPIO2, KP_SEL(kpad->cols) & 0xFF);
 	if (ret)
 		return ret;
 
-	ret = adp5588_write(client, KP_GPIO3, KP_SEL(pdata->cols) >> 8);
+	ret = adp5588_write(client, KP_GPIO3, KP_SEL(kpad->cols) >> 8);
 	if (ret)
 		return ret;
 
-	if (pdata->en_keylock) {
-		ret = adp5588_write(client, UNLOCK1, pdata->unlock_key1);
-		if (ret)
-			return ret;
-
-		ret = adp5588_write(client, UNLOCK2, pdata->unlock_key2);
+	for (i = 0; i < kpad->nkeys_unlock; i++) {
+		ret = adp5588_write(client, UNLOCK1 + i, kpad->unlock_keys[i]);
 		if (ret)
 			return ret;
+	}
 
+	if (kpad->nkeys_unlock) {
 		ret = adp5588_write(client, KEY_LCK_EC_STAT, ADP5588_K_LCK_EN);
 		if (ret)
 			return ret;
@@ -486,17 +629,6 @@ static int adp5588_setup(struct i2c_client *client)
 			return ret;
 	}
 
-	if (gpio_data) {
-		for (i = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++) {
-			int pull_mask = gpio_data->pullup_dis_mask;
-
-			ret = adp5588_write(client, GPIO_PULL1 + i,
-				(pull_mask >> (8 * i)) & 0xFF);
-			if (ret)
-				return ret;
-		}
-	}
-
 	ret = adp5588_write(client, INT_STAT,
 				ADP5588_CMP2_INT | ADP5588_CMP1_INT |
 				ADP5588_OVR_FLOW_INT | ADP5588_K_LCK_INT |
@@ -509,15 +641,84 @@ static int adp5588_setup(struct i2c_client *client)
 					  ADP5588_KE_IEN);
 }
 
+static int adp5588_fw_parse(struct adp5588_kpad *kpad)
+{
+	struct i2c_client *client = kpad->client;
+	int ret, i;
+
+	ret = matrix_keypad_parse_properties(&client->dev, &kpad->rows,
+					     &kpad->cols);
+	if (ret)
+		return ret;
+
+	if (kpad->rows > ADP5588_ROWS_MAX || kpad->cols > ADP5588_COLS_MAX) {
+		dev_err(&client->dev, "Invalid nr of rows(%u) or cols(%u)\n",
+			kpad->rows, kpad->cols);
+		return -EINVAL;
+	}
+
+	ret = matrix_keypad_build_keymap(NULL, NULL, kpad->rows, kpad->cols,
+					 kpad->keycode, kpad->input);
+	if (ret)
+		return ret;
+
+	kpad->row_shift = get_count_order(kpad->cols);
+
+	if (device_property_read_bool(&client->dev, "autorepeat"))
+		__set_bit(EV_REP, kpad->input->evbit);
+
+	kpad->nkeys_unlock = device_property_count_u32(&client->dev,
+						       "adi,unlock-keys");
+	if (kpad->nkeys_unlock <= 0) {
+		/* so that we don't end up enabling key lock */
+		kpad->nkeys_unlock = 0;
+		return 0;
+	}
+
+	if (kpad->nkeys_unlock > ARRAY_SIZE(kpad->unlock_keys)) {
+		dev_err(&client->dev, "number of unlock keys(%d) > (%zu)\n",
+			kpad->nkeys_unlock, ARRAY_SIZE(kpad->unlock_keys));
+		return -EINVAL;
+	}
+
+	ret = device_property_read_u32_array(&client->dev, "adi,unlock-keys",
+					     kpad->unlock_keys,
+					     kpad->nkeys_unlock);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < kpad->nkeys_unlock; i++) {
+		/*
+		 * Even though it should be possible (as stated in the datasheet)
+		 * to use GPIs (which are part of the keys event) as unlock keys,
+		 * it was not working at all and was leading to overflow events
+		 * at some point. Hence, for now, let's just allow keys which are
+		 * part of keypad matrix to be used and if a reliable way of
+		 * using GPIs is found, this condition can be removed/lightened.
+		 */
+		if (kpad->unlock_keys[i] >= kpad->cols * kpad->rows) {
+			dev_err(&client->dev, "Invalid unlock key(%d)\n",
+				kpad->unlock_keys[i]);
+			return -EINVAL;
+		}
+
+		/*
+		 * Firmware properties keys start from 0 but on the device they
+		 * start from 1.
+		 */
+		kpad->unlock_keys[i] += 1;
+	}
+
+	return 0;
+}
+
 static int adp5588_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct adp5588_kpad *kpad;
-	const struct adp5588_kpad_platform_data *pdata =
-			dev_get_platdata(&client->dev);
 	struct input_dev *input;
 	unsigned int revid;
-	int ret, i;
+	int ret;
 	int error;
 
 	if (!i2c_check_functionality(client->adapter,
@@ -526,21 +727,6 @@ static int adp5588_probe(struct i2c_client *client,
 		return -EIO;
 	}
 
-	if (!pdata) {
-		dev_err(&client->dev, "no platform data?\n");
-		return -EINVAL;
-	}
-
-	if (!pdata->rows || !pdata->cols || !pdata->keymap) {
-		dev_err(&client->dev, "no rows, cols or keymap from pdata\n");
-		return -EINVAL;
-	}
-
-	if (pdata->keymapsize != ADP5588_KEYMAPSIZE) {
-		dev_err(&client->dev, "invalid keymapsize\n");
-		return -EINVAL;
-	}
-
 	if (!client->irq) {
 		dev_err(&client->dev, "no IRQ?\n");
 		return -EINVAL;
@@ -557,6 +743,10 @@ static int adp5588_probe(struct i2c_client *client,
 	kpad->client = client;
 	kpad->input = input;
 
+	error = adp5588_fw_parse(kpad);
+	if (error)
+		return error;
+
 	ret = adp5588_read(client, DEV_ID);
 	if (ret < 0)
 		return ret;
@@ -575,24 +765,6 @@ static int adp5588_probe(struct i2c_client *client,
 	input->id.product = 0x0001;
 	input->id.version = revid;
 
-	input->keycodesize = sizeof(kpad->keycode[0]);
-	input->keycodemax = pdata->keymapsize;
-	input->keycode = kpad->keycode;
-
-	memcpy(kpad->keycode, pdata->keymap,
-		pdata->keymapsize * input->keycodesize);
-
-	/* setup input device */
-	__set_bit(EV_KEY, input->evbit);
-
-	if (pdata->repeat)
-		__set_bit(EV_REP, input->evbit);
-
-	for (i = 0; i < input->keycodemax; i++)
-		if (kpad->keycode[i] <= KEY_MAX)
-			__set_bit(kpad->keycode[i], input->keybit);
-	__clear_bit(KEY_RESERVED, input->keybit);
-
 	error = input_register_device(input);
 	if (error) {
 		dev_err(&client->dev, "unable to register input device: %d\n",
@@ -600,7 +772,7 @@ static int adp5588_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = adp5588_setup(client);
+	error = adp5588_setup(kpad);
 	if (error)
 		return error;
 
@@ -656,9 +828,17 @@ static const struct i2c_device_id adp5588_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, adp5588_id);
 
+static const struct of_device_id adp5588_of_match[] = {
+	{ .compatible = "adi,adp5588" },
+	{ .compatible = "adi,adp5587" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, adp5588_of_match);
+
 static struct i2c_driver adp5588_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
+		.of_match_table = adp5588_of_match,
 		.pm   = &adp5588_dev_pm_ops,
 	},
 	.probe    = adp5588_probe,
diff --git a/include/linux/platform_data/adp5588.h b/include/linux/platform_data/adp5588.h
deleted file mode 100644
index 82170ec8c266..000000000000
--- a/include/linux/platform_data/adp5588.h
+++ /dev/null
@@ -1,169 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Analog Devices ADP5588 I/O Expander and QWERTY Keypad Controller
- *
- * Copyright 2009-2010 Analog Devices Inc.
- */
-
-#ifndef _ADP5588_H
-#define _ADP5588_H
-
-#define DEV_ID 0x00		/* Device ID */
-#define CFG 0x01		/* Configuration Register1 */
-#define INT_STAT 0x02		/* Interrupt Status Register */
-#define KEY_LCK_EC_STAT 0x03	/* Key Lock and Event Counter Register */
-#define Key_EVENTA 0x04		/* Key Event Register A */
-#define Key_EVENTB 0x05		/* Key Event Register B */
-#define Key_EVENTC 0x06		/* Key Event Register C */
-#define Key_EVENTD 0x07		/* Key Event Register D */
-#define Key_EVENTE 0x08		/* Key Event Register E */
-#define Key_EVENTF 0x09		/* Key Event Register F */
-#define Key_EVENTG 0x0A		/* Key Event Register G */
-#define Key_EVENTH 0x0B		/* Key Event Register H */
-#define Key_EVENTI 0x0C		/* Key Event Register I */
-#define Key_EVENTJ 0x0D		/* Key Event Register J */
-#define KP_LCK_TMR 0x0E		/* Keypad Lock1 to Lock2 Timer */
-#define UNLOCK1 0x0F		/* Unlock Key1 */
-#define UNLOCK2 0x10		/* Unlock Key2 */
-#define GPIO_INT_STAT1 0x11	/* GPIO Interrupt Status */
-#define GPIO_INT_STAT2 0x12	/* GPIO Interrupt Status */
-#define GPIO_INT_STAT3 0x13	/* GPIO Interrupt Status */
-#define GPIO_DAT_STAT1 0x14	/* GPIO Data Status, Read twice to clear */
-#define GPIO_DAT_STAT2 0x15	/* GPIO Data Status, Read twice to clear */
-#define GPIO_DAT_STAT3 0x16	/* GPIO Data Status, Read twice to clear */
-#define GPIO_DAT_OUT1 0x17	/* GPIO DATA OUT */
-#define GPIO_DAT_OUT2 0x18	/* GPIO DATA OUT */
-#define GPIO_DAT_OUT3 0x19	/* GPIO DATA OUT */
-#define GPIO_INT_EN1 0x1A	/* GPIO Interrupt Enable */
-#define GPIO_INT_EN2 0x1B	/* GPIO Interrupt Enable */
-#define GPIO_INT_EN3 0x1C	/* GPIO Interrupt Enable */
-#define KP_GPIO1 0x1D		/* Keypad or GPIO Selection */
-#define KP_GPIO2 0x1E		/* Keypad or GPIO Selection */
-#define KP_GPIO3 0x1F		/* Keypad or GPIO Selection */
-#define GPI_EM1 0x20		/* GPI Event Mode 1 */
-#define GPI_EM2 0x21		/* GPI Event Mode 2 */
-#define GPI_EM3 0x22		/* GPI Event Mode 3 */
-#define GPIO_DIR1 0x23		/* GPIO Data Direction */
-#define GPIO_DIR2 0x24		/* GPIO Data Direction */
-#define GPIO_DIR3 0x25		/* GPIO Data Direction */
-#define GPIO_INT_LVL1 0x26	/* GPIO Edge/Level Detect */
-#define GPIO_INT_LVL2 0x27	/* GPIO Edge/Level Detect */
-#define GPIO_INT_LVL3 0x28	/* GPIO Edge/Level Detect */
-#define Debounce_DIS1 0x29	/* Debounce Disable */
-#define Debounce_DIS2 0x2A	/* Debounce Disable */
-#define Debounce_DIS3 0x2B	/* Debounce Disable */
-#define GPIO_PULL1 0x2C		/* GPIO Pull Disable */
-#define GPIO_PULL2 0x2D		/* GPIO Pull Disable */
-#define GPIO_PULL3 0x2E		/* GPIO Pull Disable */
-#define CMP_CFG_STAT 0x30	/* Comparator Configuration and Status Register */
-#define CMP_CONFG_SENS1 0x31	/* Sensor1 Comparator Configuration Register */
-#define CMP_CONFG_SENS2 0x32	/* L2 Light Sensor Reference Level, Output Falling for Sensor 1 */
-#define CMP1_LVL2_TRIP 0x33	/* L2 Light Sensor Hysteresis (Active when Output Rising) for Sensor 1 */
-#define CMP1_LVL2_HYS 0x34	/* L3 Light Sensor Reference Level, Output Falling For Sensor 1 */
-#define CMP1_LVL3_TRIP 0x35	/* L3 Light Sensor Hysteresis (Active when Output Rising) For Sensor 1 */
-#define CMP1_LVL3_HYS 0x36	/* Sensor 2 Comparator Configuration Register */
-#define CMP2_LVL2_TRIP 0x37	/* L2 Light Sensor Reference Level, Output Falling for Sensor 2 */
-#define CMP2_LVL2_HYS 0x38	/* L2 Light Sensor Hysteresis (Active when Output Rising) for Sensor 2 */
-#define CMP2_LVL3_TRIP 0x39	/* L3 Light Sensor Reference Level, Output Falling For Sensor 2 */
-#define CMP2_LVL3_HYS 0x3A	/* L3 Light Sensor Hysteresis (Active when Output Rising) For Sensor 2 */
-#define CMP1_ADC_DAT_R1 0x3B	/* Comparator 1 ADC data Register1 */
-#define CMP1_ADC_DAT_R2 0x3C	/* Comparator 1 ADC data Register2 */
-#define CMP2_ADC_DAT_R1 0x3D	/* Comparator 2 ADC data Register1 */
-#define CMP2_ADC_DAT_R2 0x3E	/* Comparator 2 ADC data Register2 */
-
-#define ADP5588_DEVICE_ID_MASK	0xF
-
- /* Configuration Register1 */
-#define ADP5588_AUTO_INC	(1 << 7)
-#define ADP5588_GPIEM_CFG	(1 << 6)
-#define ADP5588_OVR_FLOW_M	(1 << 5)
-#define ADP5588_INT_CFG		(1 << 4)
-#define ADP5588_OVR_FLOW_IEN	(1 << 3)
-#define ADP5588_K_LCK_IM	(1 << 2)
-#define ADP5588_GPI_IEN		(1 << 1)
-#define ADP5588_KE_IEN		(1 << 0)
-
-/* Interrupt Status Register */
-#define ADP5588_CMP2_INT	(1 << 5)
-#define ADP5588_CMP1_INT	(1 << 4)
-#define ADP5588_OVR_FLOW_INT	(1 << 3)
-#define ADP5588_K_LCK_INT	(1 << 2)
-#define ADP5588_GPI_INT		(1 << 1)
-#define ADP5588_KE_INT		(1 << 0)
-
-/* Key Lock and Event Counter Register */
-#define ADP5588_K_LCK_EN	(1 << 6)
-#define ADP5588_LCK21		0x30
-#define ADP5588_KEC		0xF
-
-#define ADP5588_MAXGPIO		18
-#define ADP5588_BANK(offs)	((offs) >> 3)
-#define ADP5588_BIT(offs)	(1u << ((offs) & 0x7))
-
-/* Put one of these structures in i2c_board_info platform_data */
-
-#define ADP5588_KEYMAPSIZE	80
-
-#define GPI_PIN_ROW0 97
-#define GPI_PIN_ROW1 98
-#define GPI_PIN_ROW2 99
-#define GPI_PIN_ROW3 100
-#define GPI_PIN_ROW4 101
-#define GPI_PIN_ROW5 102
-#define GPI_PIN_ROW6 103
-#define GPI_PIN_ROW7 104
-#define GPI_PIN_COL0 105
-#define GPI_PIN_COL1 106
-#define GPI_PIN_COL2 107
-#define GPI_PIN_COL3 108
-#define GPI_PIN_COL4 109
-#define GPI_PIN_COL5 110
-#define GPI_PIN_COL6 111
-#define GPI_PIN_COL7 112
-#define GPI_PIN_COL8 113
-#define GPI_PIN_COL9 114
-
-#define GPI_PIN_ROW_BASE GPI_PIN_ROW0
-#define GPI_PIN_ROW_END GPI_PIN_ROW7
-#define GPI_PIN_COL_BASE GPI_PIN_COL0
-#define GPI_PIN_COL_END GPI_PIN_COL9
-
-#define GPI_PIN_BASE GPI_PIN_ROW_BASE
-#define GPI_PIN_END GPI_PIN_COL_END
-
-#define ADP5588_GPIMAPSIZE_MAX (GPI_PIN_END - GPI_PIN_BASE + 1)
-
-struct adp5588_gpi_map {
-	unsigned short pin;
-	unsigned short sw_evt;
-};
-
-struct adp5588_kpad_platform_data {
-	int rows;			/* Number of rows */
-	int cols;			/* Number of columns */
-	const unsigned short *keymap;	/* Pointer to keymap */
-	unsigned short keymapsize;	/* Keymap size */
-	unsigned repeat:1;		/* Enable key repeat */
-	unsigned en_keylock:1;		/* Enable Key Lock feature */
-	unsigned short unlock_key1;	/* Unlock Key 1 */
-	unsigned short unlock_key2;	/* Unlock Key 2 */
-	const struct adp5588_gpio_platform_data *gpio_data;
-};
-
-struct i2c_client; /* forward declaration */
-
-struct adp5588_gpio_platform_data {
-	int gpio_start;		/* GPIO Chip base # */
-	const char *const *names;
-	unsigned irq_base;	/* interrupt base # */
-	unsigned pullup_dis_mask; /* Pull-Up Disable Mask */
-	int	(*setup)(struct i2c_client *client,
-				unsigned gpio, unsigned ngpio,
-				void *context);
-	int	(*teardown)(struct i2c_client *client,
-				unsigned gpio, unsigned ngpio,
-				void *context);
-	void	*context;
-};
-
-#endif
-- 
2.37.2

