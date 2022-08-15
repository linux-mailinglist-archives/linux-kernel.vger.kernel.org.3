Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D335928D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbiHOEew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbiHOEeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:34:46 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB6815710;
        Sun, 14 Aug 2022 21:34:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CFDA032007F1;
        Mon, 15 Aug 2022 00:34:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 00:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660538083; x=1660624483; bh=j0
        YGbL+16ryHG9GLVxnVYPWloLbOtkIl8/4JW1mVKes=; b=uzvtGcHJPf3NalAYL/
        UFFDU4uW4gapBp/ZbR7pNt02YvW6Xm3uAqIuF7iL+gGWBCMVsj7zfFBVvp0WshHL
        uCPZgqUdZPqL+CFcVE7EMiG9MqGPLTlefgmtlueEFwVyjJEs/V3lf1qx8DW5cQJm
        mG0+uANkxa4m1HuIAIHNjhNg9N/+6Ti6iT2M1vlNLDLXw/4uPppDK7+3tchoOOFA
        Uhq9ISgXsC1sa9heKWo+y6w/XLcvcJPDBRad6DjG1nK6FCaZpjDc60lq7goDRBrn
        oUP/HugGiie+6wMb0luwjy55GLFjlOb9NeykfGQbbY/EHRtz7RdpoYFqD8PyhhMq
        CxXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660538083; x=1660624483; bh=j0YGbL+16ryHG
        9GLVxnVYPWloLbOtkIl8/4JW1mVKes=; b=CAOciLFtU5rFtJ5d/Uz5SgoI/iePa
        zWZX3JXjuAo0hlkNXXH0Z76DFF8Y+ELVFD9vGlRDE90jMshZiQv05GnsNiMD8JqG
        0edRE1ATAaGZlxH9Ggl3iNB4i0uQclN7eGjt++sQaZhRI0HIIuuaY/uUqZqCR/pj
        LBGFEtiw4nOtiGBlqh/DheBSscC3zvW+BIWtlylr6xhDxgKH1QndeB940QXkm0v+
        lNKHFXYFdIGR3G5F0EDRi3ZkZDILR4ommJ8EkS6BzeImyR4Ln54jf6GNTmaN1jSm
        m9vaZyp7fJ1R2M4hJn1mQ5l1lZk7xe8yUl+x2iadBM0ASHS13nnzNEDHA==
X-ME-Sender: <xms:48z5YuofCHKo7u04MXBJHfRfjAfmogjbXTGJjIU8Tj6tc6uNTdi2MQ>
    <xme:48z5Ysruz3nlK_ZqXHll8VR0A_Hqo25CC55WxpMZb8ZcKK6HAj9OiAK8EMZd5STm5
    X0WwKS0kuy0kA3oDA>
X-ME-Received: <xmr:48z5YjOAqvOmWNp4AhODguGh4FPvCckidy1W15oFu8labX5tXY_s-r6SpEvlXUY6B-O-TSBkqEAFetGoZexhqP9ZZ2a_AEx_8PjrCzQ9OBx-dVhWCAdCld5sREAhsnDXYCeHEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:48z5Yt7TrZxu9SmljIzcjvOMtgiiL1exWZxynl8re5i7e7fWZKCOlA>
    <xmx:48z5Yt5tSPOfpl0LzXwM2D7_i_t9EWbSDop58B9aLkNNNN2vDQWwWA>
    <xmx:48z5YtjXGvZ6H3qgvcpOOhPvFZQH-E0zL_gsTxpFOOxsBYZ0By5Xgg>
    <xmx:48z5YqwzPu-qc6GHLhRkwedDlUDTZ2SVZBKSHjTJoj9iwToL9z4hEw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:34:42 -0400 (EDT)
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
Subject: [PATCH v3 2/4] regulator: sun20i: Add support for Allwinner D1 LDOs
Date:   Sun, 14 Aug 2022 23:34:33 -0500
Message-Id: <20220815043436.20170-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815043436.20170-1-samuel@sholland.org>
References: <20220815043436.20170-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes in v3:
 - Adjust control flow in sun20i_regulator_get_regmap() for clarity

Changes in v2:
 - Use decimal numbers for .n_voltages instead of field widths
 - Get the regmap from the parent device instead of a property/phandle

 drivers/regulator/Kconfig            |   8 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/sun20i-regulator.c | 232 +++++++++++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 drivers/regulator/sun20i-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 23e3e4a35cc9..0c5727173fa0 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1262,6 +1262,14 @@ config REGULATOR_STW481X_VMMC
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
index fa49bb6cc544..5dff112eb015 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -148,6 +148,7 @@ obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
 obj-$(CONFIG_REGULATOR_STM32_PWR) += stm32-pwr.o
 obj-$(CONFIG_REGULATOR_STPMIC1) += stpmic1_regulator.o
 obj-$(CONFIG_REGULATOR_STW481X_VMMC) += stw481x-vmmc.o
+obj-$(CONFIG_REGULATOR_SUN20I) += sun20i-regulator.o
 obj-$(CONFIG_REGULATOR_SY7636A) += sy7636a-regulator.o
 obj-$(CONFIG_REGULATOR_SY8106A) += sy8106a-regulator.o
 obj-$(CONFIG_REGULATOR_SY8824X) += sy8824x.o
diff --git a/drivers/regulator/sun20i-regulator.c b/drivers/regulator/sun20i-regulator.c
new file mode 100644
index 000000000000..46f3927d7d10
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
+	if (regmap)
+		return regmap;
+
+	return ERR_PTR(-EPROBE_DEFER);
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

