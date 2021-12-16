Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5866E4771B9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhLPM0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:26:15 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:44989 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236801AbhLPM0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:26:08 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7C80F5805EC;
        Thu, 16 Dec 2021 07:26:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 16 Dec 2021 07:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=byYZ5MvJCFlLl
        K5cmfT2zkFtFxLckB6GsY07XdYC0qc=; b=bcUfPCDJWmohMNXD/nXMn2nGoUlpf
        WOviKH6uq7bWX3tvwDfchxAh1my7b/yr4aynxwmsrPPT+E3Xa5PTko4bBRaGiIvU
        I4EaL6O1K7iqNOTJB10nR6aJrd+BqLPThxoimaP7eiVPaADsaFAqHDq0B93h+EVn
        m4bU4nsFrn/SVDmmxpJ2timIV9vjnn5KcK+l5F32Wlq2gycWU1gl3gt5xedYBkxn
        3HyIqLsX/ASCF6W1MXaKFTz0cvNFybWjertNb6ImWX9nEHUi3bIBMVuFeEuLBbCb
        PQ3k193iwJiiR8NuAMXjqkU/MZEslTi+WKO6aqJ5HzkZ0ZrJbcM5Z3quA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=byYZ5MvJCFlLlK5cmfT2zkFtFxLckB6GsY07XdYC0qc=; b=VII134dx
        SCnrJ1Y7alvtp8EmqSLLkJOdPKs+KyKFa7LO2hZEROpLvamW/ZHJpqpelxJ7VwKB
        Y59jPejlU3ufNYb/GHnXZgl5Lzu+2l9WlqdbUjEoyHMwC9iiTw826/JrXtRVG+3R
        h36vrpuV+0nUGGFVfC5E53FLiDkMIeXopvumJWgyXLwfogQKHKQ4ehAqFVvtnPkn
        d93sd5sFg1T2qXNB+sLuzesYWLp7GSsNDkgpSXvko7AnJu0fj2MX7fgCUXOa7MYm
        cAAJ/SJMsQoLDhltR1JTE+yaz/j0T7je9gPEVP/yfA1WrGDqr86+v957JN49ilFz
        KY2kN6lT+l7/wQ==
X-ME-Sender: <xms:XzC7YRQc1_s5Z2O60vanm9pOP4TbLtNuuUScYi9szpSWSR1kPJYkNA>
    <xme:XzC7YawINwBDwDntZ2XLnh0RnOGldMOWPgJCuUMUjncyiWB2YuZKhkTNcFn4npf6L
    Ae-ievAEgAS2wOT6ao>
X-ME-Received: <xmr:XzC7YW2RKad5nlp65FVuXifoQSewDTo6x8pfakDBR8e9DupfMlm_yo7NDcjWofPju7TiW8WBL5UNsqgWWJ_vPosJgKxLzznMoxjwA0CHytNk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeggdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:XzC7YZBFumBKVbibqILu8xd72zbsrx1CFqiDspG4-KpcrmI2gYvxmA>
    <xmx:XzC7YajC0sZ1B1OHH-4np2_r-5JUh7kLOLYXbDBFOZmExzzCRnY-3w>
    <xmx:XzC7YdptZqbCBJYSE35sCGrzVNieCz5fyk2zS7XFDjJiuK6fu4wf3A>
    <xmx:XzC7YRTrWiO8z_eELktqpzoCjjlwFoRSzcTiDCnnCESaXYNitibURw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Dec 2021 07:26:01 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, lgirdwood@gmail.com, robh+dt@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        andreas@kemnade.info, linux-hwmon@vger.kernel.org,
        alistair23@gmail.com, amitk@kernel.org, shawnguo@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v17 5/8] hwmon: sy7636a: Add temperature driver for sy7636a
Date:   Thu, 16 Dec 2021 22:25:22 +1000
Message-Id: <20211216122525.136139-6-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216122525.136139-1-alistair@alistair23.me>
References: <20211216122525.136139-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-function device to interface with the sy7636a
EPD PMIC chip from Silergy.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
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
index 7046bf1870d9..a887308850cd 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -180,6 +180,7 @@ Hardware Monitoring Kernel Drivers
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
index 64bd3dfba2c4..3139a286c35a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1662,6 +1662,15 @@ config SENSORS_SIS5595
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
index baee6a8d4dd1..8f8da52098d1 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -182,6 +182,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
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

