Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B74A325A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 23:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353342AbiA2WYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 17:24:36 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35285 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353302AbiA2WYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 17:24:33 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A748C3200E82;
        Sat, 29 Jan 2022 17:24:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 29 Jan 2022 17:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=b43zxkhB6DuN1oYuOULPcOcgjSCCPI
        YADpOYiC2iT2Y=; b=VWC9nRD4wV/S3euErRmU8g9lC5fXEIW8LFTAqjDxQJM6w6
        GFZfM2byw4DMvPWNDmrk+GmgvZYRT9KKKskaF+G6/rg9kxTm6hucWOCMrqzr5cbL
        FoVY2IlHIhs9KMBYsrVy67ahXMC1plXRKDtELX4Cf9UQCT6m8WAAMmVJefaZiI88
        brPG9ZChcFGq0bSyUn3Rza8fBJtNBS7RIyoldfwgUkrkMv97anLU9L0FyoGbw9+q
        x3PDMmfBr3Mamta/xeX7EQZWrpXir3km4mB0vMqmjlA4UzESdl3NV8hLvQlkVrtA
        I1BBMF8in90qId0whq0O9hQhfqpamWcrlugRJSMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=b43zxk
        hB6DuN1oYuOULPcOcgjSCCPIYADpOYiC2iT2Y=; b=U/Xa6uoCUfZT+qHO9LOBjV
        gNpuYog8QdSxUug/pYWP0gvuJ12AOZCjKUHFTsEgQRTf6oL6Epin5b893tJp3IyK
        vz/XIyhE2kNseGonaGXtD6kuoLiC7Y8KFOxotZLUFLH9KCETNrCgzr1WsxY6/oZ7
        3Uu6O7LzYyw06j0n/erDBbTC0a/WRGt65HmUSUGy+OcKEs0pqEjmhEW+NKUk1TUn
        O7R4z06HwXJYfT7Xz0dL5ewqAOXTQk5BUbB+Di4JE5sHybTdDnMJ+OnCF1JSNB7/
        e6jY5VNIKIW9b7Qxyl9ktTWQ78ebDfW9Av2WI+S7ojwHFbSem3OdcHl15CMJ0CrQ
        ==
X-ME-Sender: <xms:n771YbTfQ5owYmx5N_fzQp6NKlJtPD6UJlafHppNOu7qLR2NIf0YAQ>
    <xme:n771YcwTyEMmwe1yo4u-vjFOS1M751Oz7Xwu-SSBONh1HzdI9_vGXiwWBDrJBAKIt
    v6vLsQG7aiyqEwAGQ>
X-ME-Received: <xmr:n771YQ0Oar3SzQy2yddvNsT_UEOpaynWvagMa62cNqwkR3MSbPtuLPmx_Z_X-snAVp6x75zFPxfhe65M1pTpJMir-dVGK9WlNVm7c6__IjNw-Y4YF2XpIfmgV_0Zna6I0Y0m5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeejgdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:n771YbAVp21PMFovkEAwSFd4mvu9HVtTdnxtLsZ84Ok84gWNdCNoYw>
    <xmx:n771YUggJKh4y2YjbYYEhSjXcolMcy03Nyg_JKTdAGmTr19tnGirFg>
    <xmx:n771YfoKqb9dmu0y8RQdE0f8APciF-743WrJbwj-r8kRUgJzp-RkgQ>
    <xmx:n771YeaXsfZPM1cPjoeMDAIDo2v6rocXHgLqqqhQrKQETvASY5z2zw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Jan 2022 17:24:31 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 3/3] power: supply: Add a driver for Injoinic power bank ICs
Date:   Sat, 29 Jan 2022 16:24:24 -0600
Message-Id: <20220129222424.45707-3-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220129222424.45707-1-samuel@sholland.org>
References: <20220129222424.45707-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver supports several chip variants which all share the same I2C
register interface. Since the chip will turn off and become inaccessible
under conditions outside of software control (e.g. upon button press or
input voltage removal), some special handling is needed to delay the
initialization of the IC until it is accessible.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 MAINTAINERS                         |   5 +
 drivers/power/supply/Kconfig        |   8 +
 drivers/power/supply/Makefile       |   1 +
 drivers/power/supply/ip5xxx_power.c | 563 ++++++++++++++++++++++++++++
 4 files changed, 577 insertions(+)
 create mode 100644 drivers/power/supply/ip5xxx_power.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..061e2de72de5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9464,6 +9464,11 @@ F:	include/linux/mfd/ingenic-tcu.h
 F:	sound/soc/codecs/jz47*
 F:	sound/soc/jz4740/
 
+INJOINIC IP5xxx POWER BANK IC DRIVER
+M:	Samuel Holland <samuel@sholland.org>
+S:	Maintained
+F:	drivers/power/supply/ip5xxx_power.c
+
 INOTIFY
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index b366e2fd8e97..539f66018ec4 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -51,6 +51,14 @@ config GENERIC_ADC_BATTERY
 	  Say Y here to enable support for the generic battery driver
 	  which uses IIO framework to read adc.
 
+config IP5XXX_POWER
+	tristate "Injoinic IP5xxx power bank IC driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y to include support for Injoinic IP5xxx power bank ICs,
+	  which include a battery charger and a boost converter.
+
 config MAX8925_POWER
 	tristate "MAX8925 battery charger support"
 	depends on MFD_MAX8925
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 2c1b264b2046..7a70c740324e 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_GENERIC_ADC_BATTERY)	+= generic-adc-battery.o
 obj-$(CONFIG_PDA_POWER)		+= pda_power.o
 obj-$(CONFIG_APM_POWER)		+= apm_power.o
 obj-$(CONFIG_AXP20X_POWER)	+= axp20x_usb_power.o
+obj-$(CONFIG_IP5XXX_POWER)	+= ip5xxx_power.o
 obj-$(CONFIG_MAX8925_POWER)	+= max8925_power.o
 obj-$(CONFIG_WM831X_BACKUP)	+= wm831x_backup.o
 obj-$(CONFIG_WM831X_POWER)	+= wm831x_power.o
diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
new file mode 100644
index 000000000000..00fae16f6297
--- /dev/null
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -0,0 +1,563 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+
+#define IP5XXX_SYS_CTL0			0x01
+#define IP5XXX_SYS_CTL0_WLED_DET_EN		BIT(4)
+#define IP5XXX_SYS_CTL0_WLED_EN			BIT(3)
+#define IP5XXX_SYS_CTL0_BOOST_EN		BIT(2)
+#define IP5XXX_SYS_CTL0_CHARGER_EN		BIT(1)
+#define IP5XXX_SYS_CTL1			0x02
+#define IP5XXX_SYS_CTL1_LIGHT_SHDN_EN		BIT(1)
+#define IP5XXX_SYS_CTL1_LOAD_PWRUP_EN		BIT(0)
+#define IP5XXX_SYS_CTL2			0x0c
+#define IP5XXX_SYS_CTL2_LIGHT_SHDN_TH		GENMASK(7, 3)
+#define IP5XXX_SYS_CTL3			0x03
+#define IP5XXX_SYS_CTL3_LONG_PRESS_TIME_SEL	GENMASK(7, 6)
+#define IP5XXX_SYS_CTL3_BTN_SHDN_EN		BIT(5)
+#define IP5XXX_SYS_CTL4			0x04
+#define IP5XXX_SYS_CTL4_SHDN_TIME_SEL		GENMASK(7, 6)
+#define IP5XXX_SYS_CTL4_VIN_PULLOUT_BOOST_EN	BIT(5)
+#define IP5XXX_SYS_CTL5			0x07
+#define IP5XXX_SYS_CTL5_NTC_DIS			BIT(6)
+#define IP5XXX_SYS_CTL5_WLED_MODE_SEL		BIT(1)
+#define IP5XXX_SYS_CTL5_BTN_SHDN_SEL		BIT(0)
+#define IP5XXX_CHG_CTL1			0x22
+#define IP5XXX_CHG_CTL1_BOOST_UVP_SEL		GENMASK(3, 2)
+#define IP5XXX_CHG_CTL2			0x24
+#define IP5XXX_CHG_CTL2_BAT_TYPE_SEL		GENMASK(6, 5)
+#define IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_2V	(0x0 << 5)
+#define IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_3V	(0x1 << 5)
+#define IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_35V	(0x2 << 5)
+#define IP5XXX_CHG_CTL2_CONST_VOLT_SEL		GENMASK(2, 1)
+#define IP5XXX_CHG_CTL4			0x26
+#define IP5XXX_CHG_CTL4_BAT_TYPE_SEL_EN		BIT(6)
+#define IP5XXX_CHG_CTL4A		0x25
+#define IP5XXX_CHG_CTL4A_CONST_CUR_SEL		GENMASK(4, 0)
+#define IP5XXX_MFP_CTL0			0x51
+#define IP5XXX_MFP_CTL1			0x52
+#define IP5XXX_GPIO_CTL2		0x53
+#define IP5XXX_GPIO_CTL2A		0x54
+#define IP5XXX_GPIO_CTL3		0x55
+#define IP5XXX_READ0			0x71
+#define IP5XXX_READ0_CHG_STAT			GENMASK(7, 5)
+#define IP5XXX_READ0_CHG_STAT_IDLE		(0x0 << 5)
+#define IP5XXX_READ0_CHG_STAT_TRICKLE		(0x1 << 5)
+#define IP5XXX_READ0_CHG_STAT_CONST_VOLT	(0x2 << 5)
+#define IP5XXX_READ0_CHG_STAT_CONST_CUR		(0x3 << 5)
+#define IP5XXX_READ0_CHG_STAT_CONST_VOLT_STOP	(0x4 << 5)
+#define IP5XXX_READ0_CHG_STAT_FULL		(0x5 << 5)
+#define IP5XXX_READ0_CHG_STAT_TIMEOUT		(0x6 << 5)
+#define IP5XXX_READ0_CHG_OP			BIT(4)
+#define IP5XXX_READ0_CHG_END			BIT(3)
+#define IP5XXX_READ0_CONST_VOLT_TIMEOUT		BIT(2)
+#define IP5XXX_READ0_CHG_TIMEOUT		BIT(1)
+#define IP5XXX_READ0_TRICKLE_TIMEOUT		BIT(0)
+#define IP5XXX_READ0_TIMEOUT			GENMASK(2, 0)
+#define IP5XXX_READ1			0x72
+#define IP5XXX_READ1_WLED_PRESENT		BIT(7)
+#define IP5XXX_READ1_LIGHT_LOAD			BIT(6)
+#define IP5XXX_READ1_VIN_OVERVOLT		BIT(5)
+#define IP5XXX_READ2			0x77
+#define IP5XXX_READ2_BTN_PRESS			BIT(3)
+#define IP5XXX_READ2_BTN_LONG_PRESS		BIT(1)
+#define IP5XXX_READ2_BTN_SHORT_PRESS		BIT(0)
+#define IP5XXX_BATVADC_DAT0		0xa2
+#define IP5XXX_BATVADC_DAT1		0xa3
+#define IP5XXX_BATIADC_DAT0		0xa4
+#define IP5XXX_BATIADC_DAT1		0xa5
+#define IP5XXX_BATOCV_DAT0		0xa8
+#define IP5XXX_BATOCV_DAT1		0xa9
+
+struct ip5xxx {
+	struct regmap *regmap;
+	bool initialized;
+};
+
+/*
+ * The IP5xxx charger only responds on I2C when it is "awake". The charger is
+ * generally only awake when VIN is powered or when its boost converter is
+ * enabled. Going into shutdown resets all register values. To handle this:
+ *  1) When any bus error occurs, assume the charger has gone into shutdown.
+ *  2) Attempt the initialization sequence on each subsequent register access
+ *     until it succeeds.
+ */
+static int ip5xxx_read(struct ip5xxx *ip5xxx, unsigned int reg,
+		       unsigned int *val)
+{
+	int ret;
+
+	ret = regmap_read(ip5xxx->regmap, reg, val);
+	if (ret)
+		ip5xxx->initialized = false;
+
+	return ret;
+}
+
+static int ip5xxx_update_bits(struct ip5xxx *ip5xxx, unsigned int reg,
+			      unsigned int mask, unsigned int val)
+{
+	int ret;
+
+	ret = regmap_update_bits(ip5xxx->regmap, reg, mask, val);
+	if (ret)
+		ip5xxx->initialized = false;
+
+	return ret;
+}
+
+static int ip5xxx_initialize(struct power_supply *psy)
+{
+	struct ip5xxx *ip5xxx = power_supply_get_drvdata(psy);
+	int ret;
+
+	if (ip5xxx->initialized)
+		return 0;
+
+	/*
+	 * Disable shutdown under light load.
+	 * Enable power on when under load.
+	 */
+	ret = ip5xxx_update_bits(ip5xxx, IP5XXX_SYS_CTL1,
+				 IP5XXX_SYS_CTL1_LIGHT_SHDN_EN |
+				 IP5XXX_SYS_CTL1_LOAD_PWRUP_EN,
+				 IP5XXX_SYS_CTL1_LOAD_PWRUP_EN);
+	if (ret)
+		return ret;
+
+	/*
+	 * Enable shutdown after a long button press (as configured below).
+	 */
+	ret = ip5xxx_update_bits(ip5xxx, IP5XXX_SYS_CTL3,
+				 IP5XXX_SYS_CTL3_BTN_SHDN_EN,
+				 IP5XXX_SYS_CTL3_BTN_SHDN_EN);
+	if (ret)
+		return ret;
+
+	/*
+	 * Power on automatically when VIN is removed.
+	 */
+	ret = ip5xxx_update_bits(ip5xxx, IP5XXX_SYS_CTL4,
+				 IP5XXX_SYS_CTL4_VIN_PULLOUT_BOOST_EN,
+				 IP5XXX_SYS_CTL4_VIN_PULLOUT_BOOST_EN);
+	if (ret)
+		return ret;
+
+	/*
+	 * Enable the NTC.
+	 * Configure the button for two presses => LED, long press => shutdown.
+	 */
+	ret = ip5xxx_update_bits(ip5xxx, IP5XXX_SYS_CTL5,
+				 IP5XXX_SYS_CTL5_NTC_DIS |
+				 IP5XXX_SYS_CTL5_WLED_MODE_SEL |
+				 IP5XXX_SYS_CTL5_BTN_SHDN_SEL,
+				 IP5XXX_SYS_CTL5_WLED_MODE_SEL |
+				 IP5XXX_SYS_CTL5_BTN_SHDN_SEL);
+	if (ret)
+		return ret;
+
+	ip5xxx->initialized = true;
+	dev_dbg(psy->dev.parent, "Initialized after power on\n");
+
+	return 0;
+}
+
+static const enum power_supply_property ip5xxx_charger_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_OCV,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+};
+
+static int ip5xxx_charger_get_status(struct ip5xxx *ip5xxx, int *val)
+{
+	unsigned int rval;
+	int ret;
+
+	ret = ip5xxx_read(ip5xxx, IP5XXX_READ0, &rval);
+	if (ret)
+		return ret;
+
+	switch (rval & IP5XXX_READ0_CHG_STAT) {
+	case IP5XXX_READ0_CHG_STAT_IDLE:
+		*val = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	case IP5XXX_READ0_CHG_STAT_TRICKLE:
+	case IP5XXX_READ0_CHG_STAT_CONST_CUR:
+	case IP5XXX_READ0_CHG_STAT_CONST_VOLT:
+		*val = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case IP5XXX_READ0_CHG_STAT_CONST_VOLT_STOP:
+	case IP5XXX_READ0_CHG_STAT_FULL:
+		*val = POWER_SUPPLY_STATUS_FULL;
+		break;
+	case IP5XXX_READ0_CHG_STAT_TIMEOUT:
+		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ip5xxx_charger_get_charge_type(struct ip5xxx *ip5xxx, int *val)
+{
+	unsigned int rval;
+	int ret;
+
+	ret = ip5xxx_read(ip5xxx, IP5XXX_READ0, &rval);
+	if (ret)
+		return ret;
+
+	switch (rval & IP5XXX_READ0_CHG_STAT) {
+	case IP5XXX_READ0_CHG_STAT_IDLE:
+	case IP5XXX_READ0_CHG_STAT_CONST_VOLT_STOP:
+	case IP5XXX_READ0_CHG_STAT_FULL:
+	case IP5XXX_READ0_CHG_STAT_TIMEOUT:
+		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		break;
+	case IP5XXX_READ0_CHG_STAT_TRICKLE:
+		*val = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+		break;
+	case IP5XXX_READ0_CHG_STAT_CONST_CUR:
+	case IP5XXX_READ0_CHG_STAT_CONST_VOLT:
+		*val = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ip5xxx_charger_get_health(struct ip5xxx *ip5xxx, int *val)
+{
+	unsigned int rval;
+	int ret;
+
+	ret = ip5xxx_read(ip5xxx, IP5XXX_READ0, &rval);
+	if (ret)
+		return ret;
+
+	if (rval & IP5XXX_READ0_TIMEOUT)
+		*val = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
+	else
+		*val = POWER_SUPPLY_HEALTH_GOOD;
+
+	return 0;
+}
+
+static int ip5xxx_charger_get_voltage_max(struct ip5xxx *ip5xxx, int *val)
+{
+	unsigned int rval;
+	int ret;
+
+	ret = ip5xxx_read(ip5xxx, IP5XXX_CHG_CTL2, &rval);
+	if (ret)
+		return ret;
+
+	/*
+	 * It is not clear what this will return if
+	 * IP5XXX_CHG_CTL4_BAT_TYPE_SEL_EN is not set...
+	 */
+	switch (rval & IP5XXX_CHG_CTL2_BAT_TYPE_SEL) {
+	case IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_2V:
+		*val = 4200000;
+		break;
+	case IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_3V:
+		*val = 4300000;
+		break;
+	case IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_35V:
+		*val = 4350000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ip5xxx_charger_read_adc(struct ip5xxx *ip5xxx,
+				   u8 lo_reg, u8 hi_reg, int *val)
+{
+	unsigned int hi, lo;
+	int ret;
+
+	ret = ip5xxx_read(ip5xxx, lo_reg, &lo);
+	if (ret)
+		return ret;
+
+	ret = ip5xxx_read(ip5xxx, hi_reg, &hi);
+	if (ret)
+		return ret;
+
+	*val = sign_extend32(hi << 8 | lo, 13);
+
+	return 0;
+}
+
+static int ip5xxx_charger_get_property(struct power_supply *psy,
+				       enum power_supply_property psp,
+				       union power_supply_propval *val)
+{
+	struct ip5xxx *ip5xxx = power_supply_get_drvdata(psy);
+	int raw, ret, vmax;
+	unsigned int rval;
+
+	ret = ip5xxx_initialize(psy);
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		return ip5xxx_charger_get_status(ip5xxx, &val->intval);
+
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		return ip5xxx_charger_get_charge_type(ip5xxx, &val->intval);
+
+	case POWER_SUPPLY_PROP_HEALTH:
+		return ip5xxx_charger_get_health(ip5xxx, &val->intval);
+
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = ip5xxx_read(ip5xxx, IP5XXX_SYS_CTL0, &rval);
+		if (ret)
+			return ret;
+
+		val->intval = !!(rval & IP5XXX_SYS_CTL0_BOOST_EN);
+		return 0;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		return ip5xxx_charger_get_voltage_max(ip5xxx, &val->intval);
+
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = ip5xxx_charger_read_adc(ip5xxx, IP5XXX_BATVADC_DAT0,
+					      IP5XXX_BATVADC_DAT1, &raw);
+
+		val->intval = 2600000 + DIV_ROUND_CLOSEST(raw * 26855, 100);
+		return 0;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		ret = ip5xxx_charger_read_adc(ip5xxx, IP5XXX_BATOCV_DAT0,
+					      IP5XXX_BATOCV_DAT1, &raw);
+
+		val->intval = 2600000 + DIV_ROUND_CLOSEST(raw * 26855, 100);
+		return 0;
+
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = ip5xxx_charger_read_adc(ip5xxx, IP5XXX_BATIADC_DAT0,
+					      IP5XXX_BATIADC_DAT1, &raw);
+
+		val->intval = DIV_ROUND_CLOSEST(raw * 745985, 1000);
+		return 0;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		ret = ip5xxx_read(ip5xxx, IP5XXX_CHG_CTL4A, &rval);
+		if (ret)
+			return ret;
+
+		rval &= IP5XXX_CHG_CTL4A_CONST_CUR_SEL;
+		val->intval = 100000 * rval;
+		return 0;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		val->intval = 100000 * 0x1f;
+		return 0;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret = ip5xxx_charger_get_voltage_max(ip5xxx, &vmax);
+		if (ret)
+			return ret;
+
+		ret = ip5xxx_read(ip5xxx, IP5XXX_CHG_CTL2, &rval);
+		if (ret)
+			return ret;
+
+		rval &= IP5XXX_CHG_CTL2_CONST_VOLT_SEL;
+		val->intval = vmax + 14000 * (rval >> 1);
+		return 0;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		ret = ip5xxx_charger_get_voltage_max(ip5xxx, &vmax);
+		if (ret)
+			return ret;
+
+		val->intval = vmax + 14000 * 3;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ip5xxx_charger_set_voltage_max(struct ip5xxx *ip5xxx, int val)
+{
+	unsigned int rval;
+	int ret;
+
+	switch (val) {
+	case 4200000:
+		rval = IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_2V;
+		break;
+	case 4300000:
+		rval = IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_3V;
+		break;
+	case 4350000:
+		rval = IP5XXX_CHG_CTL2_BAT_TYPE_SEL_4_35V;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = ip5xxx_update_bits(ip5xxx, IP5XXX_CHG_CTL2,
+				 IP5XXX_CHG_CTL2_BAT_TYPE_SEL, rval);
+	if (ret)
+		return ret;
+
+	ret = ip5xxx_update_bits(ip5xxx, IP5XXX_CHG_CTL4,
+				 IP5XXX_CHG_CTL4_BAT_TYPE_SEL_EN,
+				 IP5XXX_CHG_CTL4_BAT_TYPE_SEL_EN);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ip5xxx_charger_set_property(struct power_supply *psy,
+				       enum power_supply_property psp,
+				       const union power_supply_propval *val)
+{
+	struct ip5xxx *ip5xxx = power_supply_get_drvdata(psy);
+	unsigned int rval;
+	int ret, vmax;
+
+	ret = ip5xxx_initialize(psy);
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		switch (val->intval) {
+		case POWER_SUPPLY_STATUS_CHARGING:
+			rval = IP5XXX_SYS_CTL0_CHARGER_EN;
+			break;
+		case POWER_SUPPLY_STATUS_DISCHARGING:
+		case POWER_SUPPLY_STATUS_NOT_CHARGING:
+			rval = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+		return ip5xxx_update_bits(ip5xxx, IP5XXX_SYS_CTL0,
+					  IP5XXX_SYS_CTL0_CHARGER_EN, rval);
+
+	case POWER_SUPPLY_PROP_ONLINE:
+		rval = val->intval ? IP5XXX_SYS_CTL0_BOOST_EN : 0;
+		return ip5xxx_update_bits(ip5xxx, IP5XXX_SYS_CTL0,
+					  IP5XXX_SYS_CTL0_BOOST_EN, rval);
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		return ip5xxx_charger_set_voltage_max(ip5xxx, val->intval);
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		rval = val->intval / 100000;
+		return ip5xxx_update_bits(ip5xxx, IP5XXX_CHG_CTL4A,
+					  IP5XXX_CHG_CTL4A_CONST_CUR_SEL, rval);
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret = ip5xxx_charger_get_voltage_max(ip5xxx, &vmax);
+		if (ret)
+			return ret;
+
+		rval = ((val->intval - vmax) / 14000) << 1;
+		return ip5xxx_update_bits(ip5xxx, IP5XXX_CHG_CTL2,
+					  IP5XXX_CHG_CTL2_CONST_VOLT_SEL, rval);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ip5xxx_charger_property_is_writeable(struct power_supply *psy,
+						enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_STATUS ||
+	       psp == POWER_SUPPLY_PROP_ONLINE ||
+	       psp == POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN ||
+	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT ||
+	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE;
+}
+
+static const struct power_supply_desc ip5xxx_charger_desc = {
+	.name			= "ip5xxx-charger",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.properties		= ip5xxx_charger_properties,
+	.num_properties		= ARRAY_SIZE(ip5xxx_charger_properties),
+	.get_property		= ip5xxx_charger_get_property,
+	.set_property		= ip5xxx_charger_set_property,
+	.property_is_writeable	= ip5xxx_charger_property_is_writeable,
+};
+
+static const struct regmap_config ip5xxx_regmap_config = {
+	.reg_bits		= 8,
+	.val_bits		= 8,
+	.max_register		= IP5XXX_BATOCV_DAT1,
+};
+
+static int ip5xxx_power_probe(struct i2c_client *client)
+{
+	struct power_supply_config psy_cfg = {};
+	struct device *dev = &client->dev;
+	struct power_supply *psy;
+	struct ip5xxx *ip5xxx;
+
+	ip5xxx = devm_kzalloc(dev, sizeof(*ip5xxx), GFP_KERNEL);
+
+	ip5xxx->regmap = devm_regmap_init_i2c(client, &ip5xxx_regmap_config);
+	if (IS_ERR(ip5xxx->regmap))
+		return PTR_ERR(ip5xxx->regmap);
+
+	psy_cfg.of_node = dev->of_node;
+	psy_cfg.drv_data = ip5xxx;
+
+	psy = devm_power_supply_register(dev, &ip5xxx_charger_desc, &psy_cfg);
+	if (IS_ERR(psy))
+		return PTR_ERR(psy);
+
+	return 0;
+}
+
+static const struct of_device_id ip5xxx_power_of_match[] = {
+	{ .compatible = "injoinic,ip5108" },
+	{ .compatible = "injoinic,ip5109" },
+	{ .compatible = "injoinic,ip5207" },
+	{ .compatible = "injoinic,ip5209" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ip5xxx_power_of_match);
+
+static struct i2c_driver ip5xxx_power_driver = {
+	.probe_new	= ip5xxx_power_probe,
+	.driver		= {
+		.name		= "ip5xxx-power",
+		.of_match_table	= ip5xxx_power_of_match,
+	}
+};
+module_i2c_driver(ip5xxx_power_driver);
+
+MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
+MODULE_DESCRIPTION("Injoinic IP5xxx power bank IC driver");
+MODULE_LICENSE("GPL");
-- 
2.33.1

