Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C2350C85D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 10:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbiDWI5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 04:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiDWI5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 04:57:10 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A63F203F7C;
        Sat, 23 Apr 2022 01:54:14 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q14so12206835ljc.12;
        Sat, 23 Apr 2022 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KZJ4HXnnIxTILvPz6/GIc8z3KbhjSst2R2LjpPG4E2o=;
        b=P7IyKXk5NP7XMI0yDGvcibFg3bRkeidDhHJxpQyc6Qii1AznT5nUCZhsxcUDzZUwq7
         yUNqk6qJVcUFVHWuNXS//qeR5GxXcMIccOKH0fW3NqiI3TTx5ocwTxhW4m9pxEo8INMz
         3xrQ67RL1RH+f8ikQNj0hB570qIK+aRPOOm6K7OfMIxq9VoVTRmPw6hSi3/ckMO3J9a3
         9F5rPMzSu7quCeKSSwtwp2bXwd6ICd9YKwHiLjwigYbOBqsSnxQKZ1JHqhkOA/Brqde+
         uqiXRCyFS2EFFDwFVl/ByDZ7LcT7DACYXrLni3ctKmktdzcSf7tttcACRIb8Bes0ldny
         AbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZJ4HXnnIxTILvPz6/GIc8z3KbhjSst2R2LjpPG4E2o=;
        b=EEgqIP2QGYBDazwXiUMk2lcUmVfIv/Lf22Y1RbZ/cN88+YoBg5KKMLwh5YN5RWdhxU
         G3SCgBqg5dVHyte8JXywEQs3Djqi+XF1iSNoIoV3nhyCXFfz49oKf0lBtbnwfM7wyT3b
         6VaMvqLJ/QIvpdDw1l0Tkbs7rMP7KmjhkBrzVsWRc7HbMNQPtlaxrcQ+F80ie1uIUMFZ
         t7cIuCeNjCH0wObfGxor7HeKkCccRlvHpqSRNmnNYu/yP+1GINl1vE9Gw91UF9UVXDiR
         HCWMv/K/8tJ7tUTfNZ+vg5p/BD0Nj1MIycV3hrmMMttpa3OVVy2gw5IMgx5Qfcb93GwE
         /I7g==
X-Gm-Message-State: AOAM531uDstB+88tz2knPOL90rc+T8scQx4B3RyWHoONRAsi0bvRoivU
        GuKbEx7B+SSfAoQeV2tD4hyk1wgOo38=
X-Google-Smtp-Source: ABdhPJzXwSEBT5cmAWstKOUWegjsaqN0jqe3LHTb9gOGGGKquET+O6BmqVBE2bjB5MIM1x13tOYIyQ==
X-Received: by 2002:a2e:864d:0:b0:24d:bb90:153 with SMTP id i13-20020a2e864d000000b0024dbb900153mr5009063ljj.61.1650704052367;
        Sat, 23 Apr 2022 01:54:12 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id p25-20020a2e9a99000000b0024dc3ccff47sm493677lji.32.2022.04.23.01.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 01:54:12 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v5 5/5] regulator: sm5703-regulator: Add regulators support for SM5703 MFD
Date:   Sat, 23 Apr 2022 11:53:18 +0300
Message-Id: <20220423085319.483524-6-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220423085319.483524-1-markuss.broks@gmail.com>
References: <20220423085319.483524-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulators block of SM5703 controls several voltage regulators which
are used to power various components. There are 3 LDO outputs ranging
from 1.5 to 3.3V, a buck regulator ranging from 1V to 3V, two fixed
voltage LDO regulators for powering the USB devices and one high-power
fixed voltage LDO line (actually two lines) meant to power high-power
USB devices.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/regulator/Kconfig            |   7 ++
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/sm5703-regulator.c | 167 +++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 drivers/regulator/sm5703-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index a7effc57bbdb..cbe0f96ca342 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1167,6 +1167,13 @@ config REGULATOR_SLG51000
 	  The SLG51000 is seven compact and customizable low dropout
 	  regulators.
 
+config REGULATOR_SM5703
+	tristate "Silicon Mitus SM5703 regulators"
+	depends on MFD_SM5703
+	help
+	  This driver provides support for voltage regulators of SM5703
+	  multi-function device.
+
 config REGULATOR_STM32_BOOSTER
 	tristate "STMicroelectronics STM32 BOOSTER"
 	depends on ARCH_STM32 || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 69b5a196acd2..8d3ee8b6d41d 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -139,6 +139,7 @@ obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
 obj-$(CONFIG_REGULATOR_SC2731) += sc2731-regulator.o
 obj-$(CONFIG_REGULATOR_SKY81452) += sky81452-regulator.o
 obj-$(CONFIG_REGULATOR_SLG51000) += slg51000-regulator.o
+obj-$(CONFIG_REGULATOR_SM5703) += sm5703-regulator.o
 obj-$(CONFIG_REGULATOR_STM32_BOOSTER) += stm32-booster.o
 obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
 obj-$(CONFIG_REGULATOR_STM32_PWR) += stm32-pwr.o
diff --git a/drivers/regulator/sm5703-regulator.c b/drivers/regulator/sm5703-regulator.c
new file mode 100644
index 000000000000..05ad28fc4da8
--- /dev/null
+++ b/drivers/regulator/sm5703-regulator.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/mfd/sm5703.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+enum sm5703_regulators {
+	SM5703_BUCK,
+	SM5703_LDO1,
+	SM5703_LDO2,
+	SM5703_LDO3,
+	SM5703_USBLDO1,
+	SM5703_USBLDO2,
+	SM5703_VBUS,
+	SM5703_MAX_REGULATORS,
+};
+
+static const int sm5703_ldo_voltagemap[] = {
+	1500000, 1800000, 2600000, 2800000, 3000000, 3300000,
+};
+
+static const int sm5703_buck_voltagemap[] = {
+	1000000, 1000000, 1000000, 1000000,
+	1000000, 1000000, 1000000, 1000000,
+	1000000, 1000000, 1000000, 1100000,
+	1200000, 1300000, 1400000, 1500000,
+	1600000, 1700000, 1800000, 1900000,
+	2000000, 2100000, 2200000, 2300000,
+	2400000, 2500000, 2600000, 2700000,
+	2800000, 2900000, 3000000, 3000000,
+};
+
+#define SM5703USBLDO(_name, _id)					\
+	[SM5703_USBLDO ## _id] = {					\
+		.name = _name,						\
+		.of_match = _name,					\
+		.regulators_node = "regulators",			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = SM5703_USBLDO ## _id,				\
+		.ops = &sm5703_regulator_ops_fixed,			\
+		.fixed_uV = SM5703_USBLDO_MICROVOLT,			\
+		.enable_reg = SM5703_REG_USBLDO12,			\
+		.enable_mask = SM5703_REG_EN_USBLDO ##_id,		\
+		.owner			= THIS_MODULE,			\
+	}
+
+#define SM5703VBUS(_name)						\
+	[SM5703_VBUS] = {						\
+		.name = _name,						\
+		.of_match = _name,					\
+		.regulators_node = "regulators",			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = SM5703_VBUS,					\
+		.ops = &sm5703_regulator_ops_fixed,			\
+		.fixed_uV = SM5703_VBUS_MICROVOLT,			\
+		.enable_reg = SM5703_REG_CNTL,				\
+		.enable_mask = SM5703_OPERATION_MODE_MASK,		\
+		.enable_val = SM5703_OPERATION_MODE_USB_OTG_MODE,	\
+		.disable_val = SM5703_OPERATION_MODE_CHARGING_ON,	\
+		.owner			= THIS_MODULE,			\
+	}
+
+#define SM5703BUCK(_name)						\
+	[SM5703_BUCK] = {						\
+		.name = _name,						\
+		.of_match = _name,					\
+		.regulators_node = "regulators",			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = SM5703_BUCK,					\
+		.ops = &sm5703_regulator_ops,				\
+		.n_voltages = ARRAY_SIZE(sm5703_buck_voltagemap),	\
+		.volt_table = sm5703_buck_voltagemap,			\
+		.vsel_reg = SM5703_REG_BUCK,				\
+		.vsel_mask = SM5703_BUCK_VOLT_MASK,			\
+		.enable_reg = SM5703_REG_BUCK,				\
+		.enable_mask = SM5703_REG_EN_BUCK,			\
+		.owner			= THIS_MODULE,			\
+	}
+
+#define SM5703LDO(_name, _id)						\
+	[SM5703_LDO ## _id] = {						\
+		.name = _name,						\
+		.of_match = _name,					\
+		.regulators_node = "regulators",			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = SM5703_LDO ## _id,				\
+		.ops = &sm5703_regulator_ops,				\
+		.n_voltages = ARRAY_SIZE(sm5703_ldo_voltagemap),	\
+		.volt_table = sm5703_ldo_voltagemap,			\
+		.vsel_reg = SM5703_REG_LDO ##_id,			\
+		.vsel_mask = SM5703_LDO_VOLT_MASK,			\
+		.enable_reg = SM5703_REG_LDO ##_id,			\
+		.enable_mask = SM5703_LDO_EN,				\
+		.owner			= THIS_MODULE,			\
+	}
+
+static const struct regulator_ops sm5703_regulator_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.list_voltage		= regulator_list_voltage_table,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+};
+
+static const struct regulator_ops sm5703_regulator_ops_fixed = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+};
+
+static struct regulator_desc sm5703_regulators_desc[SM5703_MAX_REGULATORS] = {
+	SM5703BUCK("buck"),
+	SM5703LDO("ldo1", 1),
+	SM5703LDO("ldo2", 2),
+	SM5703LDO("ldo3", 3),
+	SM5703USBLDO("usbldo1", 1),
+	SM5703USBLDO("usbldo2", 2),
+	SM5703VBUS("vbus"),
+};
+
+static int sm5703_regulator_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regulator_config config = { NULL, };
+	struct regulator_dev *rdev;
+	struct sm5703_dev *sm5703 = dev_get_drvdata(pdev->dev.parent);
+	int i;
+
+	config.dev = dev->parent;
+	config.regmap = sm5703->regmap;
+
+	for (i = 0; i < SM5703_MAX_REGULATORS; i++) {
+		rdev = devm_regulator_register(dev,
+					       &sm5703_regulators_desc[i],
+					       &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(dev, PTR_ERR(rdev),
+					     "Failed to register a regulator\n");
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id sm5703_regulator_id[] = {
+	{ "sm5703-regulator", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, sm5703_regulator_id);
+
+static struct platform_driver sm5703_regulator_driver = {
+	.driver = {
+		.name = "sm5703-regulator",
+	},
+	.probe	= sm5703_regulator_probe,
+	.id_table	= sm5703_regulator_id,
+};
+
+module_platform_driver(sm5703_regulator_driver);
+
+MODULE_DESCRIPTION("Silicon Mitus SM5703 LDO/Buck/USB regulator driver");
+MODULE_AUTHOR("Markuss Broks <markuss.broks@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.35.1

