Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51FA497EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiAXMLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:11:04 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:33381 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239089AbiAXMKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:10:51 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7E41C5800C6;
        Mon, 24 Jan 2022 07:10:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Jan 2022 07:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=CIetouW3Bv/ITY
        QwDW70ifSsbnf+csJT+kKRfO1FjHg=; b=K4OvP8x6lYz3KZ4HKpNRLCzupVqB62
        oFoR5Uq9MEI1An+Pw+HEZJWeB0Dq4wRjytPCesv/fPsbf8vBSU2m0941wiEPhLbX
        3sXlhx1Ki6dB5K2dpzYykmV7IYMKnQYFl8pg4eucA3b0+BrOps8ZoitYSc7RBEMr
        l4oWrtu0dIQs7qBXqQvhoYiAaz9WJQZKDlv4Q3khbi/OVneFCsnXzanx2uXecbn+
        lo0g6n7xcIPOT3Ae2dyO49OEZ7s3MefkNMrByLXTKJktZv2dhqh/FzfBtTEgu+sX
        WmH4hgraMu89ozjqJGUYREOoM/VAt8bQusHvU3T31jRAStzKi0AVJK2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=CIetou
        W3Bv/ITYQwDW70ifSsbnf+csJT+kKRfO1FjHg=; b=IxBojMH28Gdt021hq9FJMP
        bCead0ALTM3Vib3cLGS7fvTutwjRDkl5ejMdMPtUPSA/mnGJ+tOr7gg0m4ke+nkI
        S3bPMydsrf/7TKcHxhj9nbWfENt5Kgixv0dcU7R0iT493n0qY0BVeSDbW1Iat1nY
        vrso02rmTEaRQGAnM6maSKNnLj7Mxxt+WYXkc7ePc6XkzFXi903nKVsAGduGFxeQ
        fBFbe40+apdoD4dUcL2XGy91HNadPBJp1GhAVVzu0hrS2uFq+n22dKMBISF12qF6
        oiQNtpUdCdIeuI88PhILY4HF0JxFoGBjQRq2lbgOi7LRVHIvxeYtw/Vm5uEYuYOQ
        ==
X-ME-Sender: <xms:SpfuYectEGnYlBHUAXUvvQh1r3kExITrgKupkEe85DcGAOM1uQwPQA>
    <xme:SpfuYYMxCzAXvn0-V-MUkPGDwzWYds7vCmSPsiLSHZXHztDGjhnajMn3rtjIgUw7C
    og8sSI-_dkXeQRAkCk>
X-ME-Received: <xmr:SpfuYfgeZLlPNLcQVd0Gp0Vfw5-mk1WjTZBODZ-dHntvlp50NLX4u0OqZLEJViEe9gsjBZO_apPH_197RrHir_OybQ4CCBtQW503maxYhLpu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdeigdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:SpfuYb9r98Rb47sGEcDVG04M1khLSCIGREwLavawrQ1xL-il77oijA>
    <xmx:SpfuYas-flo2UubT0uzTZtobHRI9jDi_TXNrUG8N8YuhLS432X8zjQ>
    <xmx:SpfuYSHtmISWailFwo8dTwyojoSjw5sIoSJHcUz_zEtzBKBVbus_3Q>
    <xmx:SpfuYSSctYFMcZ7VxEivSlzeEZdgMLGL-i4I0lB9w9Fh5P1VBypFxw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jan 2022 07:10:44 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     broonie@kernel.org, robh+dt@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, lee.jones@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, rui.zhang@intel.com,
        alistair23@gmail.com, amitk@kernel.org,
        linux-arm-kernel@lists.infradead.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, Alistair Francis <alistair@alistair23.me>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v18 5/8] hwmon: sy7636a: Add temperature driver for sy7636a
Date:   Mon, 24 Jan 2022 22:10:06 +1000
Message-Id: <20220124121009.108649-6-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220124121009.108649-1-alistair@alistair23.me>
References: <20220124121009.108649-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-function device to interface with the sy7636a
EPD PMIC chip from Silergy.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/index.rst         |   1 +
 Documentation/hwmon/sy7636a-hwmon.rst |  26 +++++++
 drivers/hwmon/Kconfig                 |   9 +++
 drivers/hwmon/Makefile                |   1 +
 drivers/hwmon/sy7636a-hwmon.c         | 106 ++++++++++++++++++++++++++
 5 files changed, 143 insertions(+)
 create mode 100644 Documentation/hwmon/sy7636a-hwmon.rst
 create mode 100644 drivers/hwmon/sy7636a-hwmon.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index df20022c741f..6e0906ef5d25 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -185,6 +185,7 @@ Hardware Monitoring Kernel Drivers
    smsc47m1
    sparx5-temp
    stpddc60
+   sy7636a-hwmon
    tc654
    tc74
    thmc50
diff --git a/Documentation/hwmon/sy7636a-hwmon.rst b/Documentation/hwmon/sy7636a-hwmon.rst
new file mode 100644
index 000000000000..5612079397d5
--- /dev/null
+++ b/Documentation/hwmon/sy7636a-hwmon.rst
@@ -0,0 +1,26 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver sy7636a-hwmon
+=========================
+
+Supported chips:
+
+ * Silergy SY7636A PMIC
+
+
+Description
+-----------
+
+This driver adds hardware temperature reading support for
+the Silergy SY7636A PMIC.
+
+The following sensors are supported
+
+  * Temperature
+      - SoC on-die temperature in milli-degree C
+
+sysfs-Interface
+---------------
+
+temp0_input
+	- SoC on-die temperature (milli-degree C)
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 8df25f1079ba..aa5785e657a4 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1672,6 +1672,15 @@ config SENSORS_SIS5595
 	  This driver can also be built as a module. If so, the module
 	  will be called sis5595.
 
+config SENSORS_SY7636A
+	tristate "Silergy SY7636A"
+	help
+	  If you say yes here you get support for the thermistor readout of
+	  the Silergy SY7636A PMIC.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called sy7636a-hwmon.
+
 config SENSORS_DME1737
 	tristate "SMSC DME1737, SCH311x and compatibles"
 	depends on I2C && !PPC
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 185f946d698b..fe54a3dfdb03 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -186,6 +186,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
 obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
 obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
+obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
 obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
 obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
 obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
new file mode 100644
index 000000000000..6dd9c2a0f0e0
--- /dev/null
+++ b/drivers/hwmon/sy7636a-hwmon.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Functions to access SY3686A power management chip temperature
+ *
+ * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
+ *
+ * Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
+ *          Alistair Francis <alistair@alistair23.me>
+ */
+
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/machine.h>
+
+#include <linux/mfd/sy7636a.h>
+
+static int sy7636a_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *temp)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+	int ret, reg_val;
+
+	ret = regmap_read(regmap,
+			  SY7636A_REG_TERMISTOR_READOUT, &reg_val);
+	if (ret)
+		return ret;
+
+	*temp = reg_val * 1000;
+
+	return 0;
+}
+
+static umode_t sy7636a_is_visible(const void *data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	if (type != hwmon_temp)
+		return 0;
+
+	if (attr != hwmon_temp_input)
+		return 0;
+
+	return 0444;
+}
+
+static const struct hwmon_ops sy7636a_hwmon_ops = {
+	.is_visible = sy7636a_is_visible,
+	.read = sy7636a_read,
+};
+
+static const struct hwmon_channel_info *sy7636a_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_chip_info sy7636a_chip_info = {
+	.ops = &sy7636a_hwmon_ops,
+	.info = sy7636a_info,
+};
+
+static int sy7636a_sensor_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	struct regulator *regulator;
+	struct device *hwmon_dev;
+	int err;
+
+	if (!regmap)
+		return -EPROBE_DEFER;
+
+	regulator = devm_regulator_get(&pdev->dev, "vcom");
+	if (IS_ERR(regulator))
+		return PTR_ERR(regulator);
+
+	err = regulator_enable(regulator);
+	if (err)
+		return err;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
+							 "sy7636a_temperature", regmap,
+							 &sy7636a_chip_info, NULL);
+
+	if (IS_ERR(hwmon_dev)) {
+		err = PTR_ERR(hwmon_dev);
+		dev_err(&pdev->dev, "Unable to register hwmon device, returned %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static struct platform_driver sy7636a_sensor_driver = {
+	.probe = sy7636a_sensor_probe,
+	.driver = {
+		.name = "sy7636a-temperature",
+	},
+};
+module_platform_driver(sy7636a_sensor_driver);
+
+MODULE_DESCRIPTION("SY7636A sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.31.1

