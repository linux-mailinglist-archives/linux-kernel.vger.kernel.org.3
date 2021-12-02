Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3A946633A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357862AbhLBMN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:13:26 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:35609 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357718AbhLBMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:12:05 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A22E458030B;
        Thu,  2 Dec 2021 07:08:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Dec 2021 07:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Nn32EltN97YJ2
        S3XzbMtS7Wpo5H9KIt2l6pkIEsGN34=; b=CwCF4z8HN8wy+lDS/71D3gF60OXb5
        YBzE1TlyKdj42LSy5ifX+ktGpBWpTGioqvkhXqEmxtfUrKUVjtDKUrs55OfJtl/U
        wWErnTD4hPyfjHSSC9FF7Kw/k1XQf/MSGRvUMr4yk9il+Cxb5sQGx3cogsHvT8ou
        4lLdD1DHBWCHcdWQ0G7ldEdr9v8pJAJ8RVuo+dNu7vWATeOHfzs9EO/ggI/4nnaS
        vgDsA1J3z8KtcxnXWxf7xMfmsNMlOj0XAfMWqvT7NnGn1ZotIPhqKG5A5zYYOuWQ
        7Vmnw9590SGloyGlEdF+3gJF24fPPA7pq8CyraIUD0NO3gtyetHuEKnNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Nn32EltN97YJ2S3XzbMtS7Wpo5H9KIt2l6pkIEsGN34=; b=ODQOAU+F
        cAM1A5aYRG/zvHYOdEXAedHERmbHCmmiBAz195MLblSP3WAqOOPiR3RdydK9v5F1
        1A0m6nF1OqNobl0du7erPPsUS2dGYcR3XJSUc9izek2lWWG9XioZxw+rRRHeYYI+
        ScMK5219YTuhfgmRVpqlgMudX80vDHQhj/onhnbB1jqZdHwlWHPUm8Egr7slpBNh
        VPeTcRGzCBCDAH3m+CQ/N78wAteI/ZUdolDd4c1D9QDuaH7Ion94AoQzUxqPLnR0
        pxa+1vxTUhkU5eQlxoysVl8YPm0dlsiTnMGRXZuwQEA6BKlUPW5DR+EL5Jc8wDlH
        usI62koK68Luow==
X-ME-Sender: <xms:SreoYQB8kCfMVrtWbRfxeZf1ZUZRkTYcMbQj_Yzgjed0XpO254vzEQ>
    <xme:SreoYSjo4j9lz1bDaPrU4Iocao2Ip_S2EGS4uZ61OvzRclIDl7WB1q_k2HmVNiIen
    d3xVNeErymw3LHe8Ng>
X-ME-Received: <xmr:SreoYTkhcbwd8SQnGo2SXmNzhsR55mpiD9hZLA_60FrWQSmLHjtYJLURzBqct-Qnh71pXHA1I1r7MRvQDiA0wuwTAe0qy4k74XVlvSvwXddRPd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:SreoYWzHczPN29xmgfLgJEOhBpZehSiuX9fXdDeS6uUBUH1eBlZzHg>
    <xmx:SreoYVS1Sqn90P-edl6oEIcxDLuio4U6IDEtBmkAHBgZnCV0JK_Cbw>
    <xmx:SreoYRZJD7a6tMrqZU-ii8qqtvHWyRRURvU2HQcaeu4p6BVzs03XtQ>
    <xmx:SreoYWATmmJ07VMohGX4ucQgI8MQbIIyB06Q63mCOQQVZkSlk9OmAQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 07:08:36 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, robh+dt@kernel.org, lee.jones@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, amitk@kernel.org, shawnguo@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v16 5/8] hwmon: sy7636a: Add temperature driver for sy7636a
Date:   Thu,  2 Dec 2021 22:07:55 +1000
Message-Id: <20211202120758.41478-6-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202120758.41478-1-alistair@alistair23.me>
References: <20211202120758.41478-1-alistair@alistair23.me>
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
 Documentation/hwmon/sy7636a-hwmon.rst |  24 ++++++
 drivers/hwmon/Kconfig                 |   9 +++
 drivers/hwmon/Makefile                |   1 +
 drivers/hwmon/sy7636a-hwmon.c         | 107 ++++++++++++++++++++++++++
 5 files changed, 142 insertions(+)
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
index 000000000000..6b3e36d028dd
--- /dev/null
+++ b/Documentation/hwmon/sy7636a-hwmon.rst
@@ -0,0 +1,24 @@
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
index 000000000000..3cc3afcdfb2d
--- /dev/null
+++ b/drivers/hwmon/sy7636a-hwmon.c
@@ -0,0 +1,107 @@
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
+			 u32 attr, int channel, long *temp)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+	int ret, reg_val;
+
+	ret = regmap_read(regmap,
+			SY7636A_REG_TERMISTOR_READOUT, &reg_val);
+	if (ret)
+		return ret;
+
+	*temp = reg_val * 1000;
+
+	return 0;
+}
+
+static umode_t sy7636a_is_visible(const void *data,
+				   enum hwmon_sensor_types type,
+				   u32 attr, int channel)
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
+	if (IS_ERR(regulator)) {
+		return PTR_ERR(regulator);
+	}
+
+	err = regulator_enable(regulator);
+	if (err) {
+		return err;
+	}
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
+			"sy7636a_temperature", regmap, &sy7636a_chip_info, NULL);
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

