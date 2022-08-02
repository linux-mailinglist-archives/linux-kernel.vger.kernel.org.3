Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDC45876BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 07:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiHBFci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 01:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbiHBFca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 01:32:30 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C59419B4;
        Mon,  1 Aug 2022 22:32:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D0FEC320029B;
        Tue,  2 Aug 2022 01:32:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 02 Aug 2022 01:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1659418347; x=1659504747; bh=R/
        +5h2/DAfq0YCIGUVxS5EwHlMEbm7OFJH1J6Sy47ck=; b=sspf3FLqhx1v+GhxFE
        twX3YF012CRJpjcX9YjZXud3u7bRq8x+B2WKBIJsrHCcB7dwtDmxLjuWFKrcGfff
        GNdJpt2y8RXLvbXGosDqxua1pggG543qaj/WE48u/fwenDpEKaVjeLJKtQY1zNAk
        EhHA/SRd0mXHmCVxpjPZtclvLW7eKBdzdPknj+fikGQTZ7mNAm6J6bODU5EKTv6M
        iXkEfEI4OsiwHF2WmFVdK7e6ytfQRnJEq+O4dv6v54ZGlOsbrljRKcEqayb57lUN
        fjL7hbh+XLQ/YsEXmXKcMFjpLHqEmzlX9UORnI4mm89YfgG15ZwJiEH84RWLJ2nk
        6sbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659418347; x=1659504747; bh=R/+5h2/DAfq0Y
        CIGUVxS5EwHlMEbm7OFJH1J6Sy47ck=; b=2MUbs1AmBJuyWTbT277VEKlR+Sfkl
        8vHD+tbQowt3KYTUz87uWbtHQB5bSbnT9U/G/yY+61dLwDGuGlnZiMJeNASBlv/u
        sJWJCFStJRi2EUDsSY2HmQ4VBOFBDPaW1/jrfBIYwnx9YSWnXcv/eMOVReUBRH+G
        lrcv3wtq0vWYbnc3FhR/QBLIFcA9JD6nUklCq+EJYUH0xxLQJnVmhK2ivJmQSxUZ
        zsvROlA2JvcIL+xLW9mr4r6q6FP/y2PrmWa/b12HezAt7dWWhAkAzROwXYb4MgZa
        xJKmW4Oda1Iac6onGp/ATYmaCa3tfOdrDWHrqXNJQCNC4xR8qQOiY8Tmw==
X-ME-Sender: <xms:67boYtS1so2OUNmSvPCbglbHmCakw4_ND-QQlzQ8yLFSRP4UsJQPoQ>
    <xme:67boYmz_2aPxtV6Nxz3eAL8Jpeq1fd5F5l7J605UpX1E3pokVVEOruj4sgeIdMR-q
    1eDAOnc_pjwCekAsw>
X-ME-Received: <xmr:67boYi0hPbYVI-pyH6BXyh1CoWAslfQtXm_iD-NCYvaltpy6QldIU__olnj32hWNpkwZoiFSJVGL0rQRsdyIXcnXzSNqC7a1ZTHavyXbxjl3BnXdv84gZ7cmTP2DXG03uXjaDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvgedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:67boYlD6NGRgm4KBCYLXDTNEhkSC-yOnw9ke1UzVKLw-d1U96t_L0w>
    <xmx:67boYmg4dqHjpeQuMwXEp07zKMXeoiQdNnrdrcQIlBXWwUJOjsH_xA>
    <xmx:67boYpoQyqbd4e8p4oCOEkNqOX91bkypo2o-sNmocjGELa5TYiTjvg>
    <xmx:67boYra0-wryNw1yVe0QM7vQBHIy1LUs4yhS-4YYa07Mg2QzE1y-6A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Aug 2022 01:32:26 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 4/4] regulator: sun20i: Add support for Allwinner D1 LDOs
Date:   Tue,  2 Aug 2022 00:32:13 -0500
Message-Id: <20220802053213.3645-5-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220802053213.3645-1-samuel@sholland.org>
References: <20220802053213.3645-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 contains two pairs of LDOs. Since they have similar bindings, and
they always exist together, put them in a single driver.

The analog LDOs are relatively boring, with a single linear range. Their
one quirk is that a bandgap reference must be calibrated for them to
produce the correct voltage.

The system LDOs have the complication that their voltage step is not an
integer, so a custom .list_voltage is needed to get the rounding right.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Use decimal numbers for .n_voltages instead of field widths
 - Get the regmap from the parent device instead of a property/phandle

 drivers/regulator/Kconfig            |   8 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/sun20i-regulator.c | 232 +++++++++++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 drivers/regulator/sun20i-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index cbe0f96ca342..20a22f900bb2 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1234,6 +1234,14 @@ config REGULATOR_STW481X_VMMC
 	  This driver supports the internal VMMC regulator in the STw481x
 	  PMIC chips.
 
+config REGULATOR_SUN20I
+	tristate "Allwinner D1 internal LDOs"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on MFD_SYSCON && NVMEM
+	default ARCH_SUNXI
+	help
+	  This driver supports the internal LDOs in the Allwinner D1 SoC.
+
 config REGULATOR_SY7636A
 	tristate "Silergy SY7636A voltage regulator"
 	help
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 8d3ee8b6d41d..cb3ac9290fc3 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -145,6 +145,7 @@ obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
 obj-$(CONFIG_REGULATOR_STM32_PWR) += stm32-pwr.o
 obj-$(CONFIG_REGULATOR_STPMIC1) += stpmic1_regulator.o
 obj-$(CONFIG_REGULATOR_STW481X_VMMC) += stw481x-vmmc.o
+obj-$(CONFIG_REGULATOR_SUN20I) += sun20i-regulator.o
 obj-$(CONFIG_REGULATOR_SY7636A) += sy7636a-regulator.o
 obj-$(CONFIG_REGULATOR_SY8106A) += sy8106a-regulator.o
 obj-$(CONFIG_REGULATOR_SY8824X) += sy8824x.o
diff --git a/drivers/regulator/sun20i-regulator.c b/drivers/regulator/sun20i-regulator.c
new file mode 100644
index 000000000000..789a68829630
--- /dev/null
+++ b/drivers/regulator/sun20i-regulator.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (c) 2021-2022 Samuel Holland <samuel@sholland.org>
+//
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+
+#define SUN20I_POWER_REG		0x348
+
+#define SUN20I_SYS_LDO_CTRL_REG		0x150
+
+struct sun20i_regulator_data {
+	int				(*init)(struct device *dev,
+						struct regmap *regmap);
+	const struct regulator_desc	*descs;
+	unsigned int			ndescs;
+};
+
+static int sun20i_d1_analog_ldos_init(struct device *dev, struct regmap *regmap)
+{
+	u8 bg_trim;
+	int ret;
+
+	ret = nvmem_cell_read_u8(dev, "bg_trim", &bg_trim);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get bg_trim value\n");
+
+	/* The default value corresponds to 900 mV. */
+	if (!bg_trim)
+		bg_trim = 0x19;
+
+	return regmap_update_bits(regmap, SUN20I_POWER_REG,
+				  GENMASK(7, 0), bg_trim);
+}
+
+static const struct regulator_ops sun20i_d1_analog_ldo_ops = {
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+};
+
+static const struct regulator_desc sun20i_d1_analog_ldo_descs[] = {
+	{
+		.name		= "aldo",
+		.supply_name	= "vdd33",
+		.of_match	= "aldo",
+		.ops		= &sun20i_d1_analog_ldo_ops,
+		.type		= REGULATOR_VOLTAGE,
+		.owner		= THIS_MODULE,
+		.n_voltages	= 8,
+		.min_uV		= 1650000,
+		.uV_step	= 50000,
+		.vsel_reg	= SUN20I_POWER_REG,
+		.vsel_mask	= GENMASK(14, 12),
+		.enable_reg	= SUN20I_POWER_REG,
+		.enable_mask	= BIT(31),
+	},
+	{
+		.name		= "hpldo",
+		.supply_name	= "hpldoin",
+		.of_match	= "hpldo",
+		.ops		= &sun20i_d1_analog_ldo_ops,
+		.type		= REGULATOR_VOLTAGE,
+		.owner		= THIS_MODULE,
+		.n_voltages	= 8,
+		.min_uV		= 1650000,
+		.uV_step	= 50000,
+		.vsel_reg	= SUN20I_POWER_REG,
+		.vsel_mask	= GENMASK(10, 8),
+		.enable_reg	= SUN20I_POWER_REG,
+		.enable_mask	= BIT(30),
+	},
+};
+
+static const struct sun20i_regulator_data sun20i_d1_analog_ldos = {
+	.init	= sun20i_d1_analog_ldos_init,
+	.descs	= sun20i_d1_analog_ldo_descs,
+	.ndescs	= ARRAY_SIZE(sun20i_d1_analog_ldo_descs),
+};
+
+/* regulator_list_voltage_linear() modified for the non-integral uV_step. */
+static int sun20i_d1_system_ldo_list_voltage(struct regulator_dev *rdev,
+					     unsigned int selector)
+{
+	const struct regulator_desc *desc = rdev->desc;
+	unsigned int uV;
+
+	if (selector >= desc->n_voltages)
+		return -EINVAL;
+
+	uV = desc->min_uV + (desc->uV_step * selector);
+
+	/* Produce correctly-rounded absolute voltages. */
+	return uV + ((selector + 1 + (desc->min_uV % 4)) / 3);
+}
+
+static const struct regulator_ops sun20i_d1_system_ldo_ops = {
+	.list_voltage		= sun20i_d1_system_ldo_list_voltage,
+	.map_voltage		= regulator_map_voltage_ascend,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+};
+
+static const struct regulator_desc sun20i_d1_system_ldo_descs[] = {
+	{
+		.name		= "ldoa",
+		.supply_name	= "ldo-in",
+		.of_match	= "ldoa",
+		.ops		= &sun20i_d1_system_ldo_ops,
+		.type		= REGULATOR_VOLTAGE,
+		.owner		= THIS_MODULE,
+		.n_voltages	= 32,
+		.min_uV		= 1600000,
+		.uV_step	= 13333, /* repeating */
+		.vsel_reg	= SUN20I_SYS_LDO_CTRL_REG,
+		.vsel_mask	= GENMASK(7, 0),
+	},
+	{
+		.name		= "ldob",
+		.supply_name	= "ldo-in",
+		.of_match	= "ldob",
+		.ops		= &sun20i_d1_system_ldo_ops,
+		.type		= REGULATOR_VOLTAGE,
+		.owner		= THIS_MODULE,
+		.n_voltages	= 64,
+		.min_uV		= 1166666,
+		.uV_step	= 13333, /* repeating */
+		.vsel_reg	= SUN20I_SYS_LDO_CTRL_REG,
+		.vsel_mask	= GENMASK(15, 8),
+	},
+};
+
+static const struct sun20i_regulator_data sun20i_d1_system_ldos = {
+	.descs	= sun20i_d1_system_ldo_descs,
+	.ndescs	= ARRAY_SIZE(sun20i_d1_system_ldo_descs),
+};
+
+static const struct of_device_id sun20i_regulator_of_match[] = {
+	{
+		.compatible = "allwinner,sun20i-d1-analog-ldos",
+		.data = &sun20i_d1_analog_ldos,
+	},
+	{
+		.compatible = "allwinner,sun20i-d1-system-ldos",
+		.data = &sun20i_d1_system_ldos,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sun20i_regulator_of_match);
+
+static struct regmap *sun20i_regulator_get_regmap(struct device *dev)
+{
+	struct regmap *regmap;
+
+	/*
+	 * First try the syscon interface. The system control device is not
+	 * compatible with "syscon", so fall back to getting the regmap from
+	 * its platform device. This is ugly, but required for devicetree
+	 * backward compatibility.
+	 */
+	regmap = syscon_node_to_regmap(dev->parent->of_node);
+	if (!IS_ERR(regmap))
+		return regmap;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return regmap;
+}
+
+static int sun20i_regulator_probe(struct platform_device *pdev)
+{
+	const struct sun20i_regulator_data *data;
+	struct device *dev = &pdev->dev;
+	struct regulator_config config;
+	struct regmap *regmap;
+	int ret;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	regmap = sun20i_regulator_get_regmap(dev);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to get regmap\n");
+
+	if (data->init) {
+		ret = data->init(dev, regmap);
+		if (ret)
+			return ret;
+	}
+
+	config = (struct regulator_config) {
+		.dev	= dev,
+		.regmap	= regmap,
+	};
+
+	for (unsigned int i = 0; i < data->ndescs; ++i) {
+		const struct regulator_desc *desc = &data->descs[i];
+		struct regulator_dev *rdev;
+
+		rdev = devm_regulator_register(dev, desc, &config);
+		if (IS_ERR(rdev))
+			return PTR_ERR(rdev);
+	}
+
+	return 0;
+}
+
+static struct platform_driver sun20i_regulator_driver = {
+	.probe	= sun20i_regulator_probe,
+	.driver	= {
+		.name		= "sun20i-regulator",
+		.of_match_table	= sun20i_regulator_of_match,
+	},
+};
+module_platform_driver(sun20i_regulator_driver);
+
+MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
+MODULE_DESCRIPTION("Allwinner D1 internal LDO driver");
+MODULE_LICENSE("GPL");
-- 
2.35.1

