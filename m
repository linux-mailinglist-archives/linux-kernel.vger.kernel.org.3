Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2836F58639C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbiHAEsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbiHAEsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:48:06 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC95613E34;
        Sun, 31 Jul 2022 21:48:04 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4C179320047A;
        Mon,  1 Aug 2022 00:48:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 01 Aug 2022 00:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1659329282; x=1659415682; bh=eJ
        aAVmwqR0NW9DeEP+qDxnDdsemHn3NpvuJmJ+NmkDg=; b=lF8AuzbMqAkvafYB2z
        1AXxhz26CkGKQCpQpktDp0/ML+e3pgaox0+3JimrGdRp8w0IlHTCUZGPt2XDkRno
        5A6BBV9JCQOxF4SOs6HfykVBpg39Rnfaz4uRRbVxMGlFmYIhAVstHb3TYP8ueA1D
        4S8XzndWSUTb+APZxfwoiGonRs7TKSShNXhZrO+P79ppa6jOagu9t0I1Qifr4VDa
        QNpyOiWyma5EsjVjEfpkifiDQG0I1SFGs8inpq+LFcBgxKy/e2UZheohmnVPGBES
        Edo9tx28P750egFExN9GThY8+eVSsjGwTxLKe4LrKacbss6nFJrSjEVEhP12Lwik
        gvvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659329282; x=1659415682; bh=eJaAVmwqR0NW9
        DeEP+qDxnDdsemHn3NpvuJmJ+NmkDg=; b=sDgFGvIWFcxGwhIjq12RGkyTJQSLv
        pKull0/TNG6eptg/ccakNdFwPQYH0GF7qs6btBguKnq90IEPO44nRmT2B46Kv0I/
        OKW6f/jKVfWC1DZ0Emn+qxNHZNRSF/IzAVLy7fsJXVpxwg3OzhP6WYdiAWTEvHs3
        cjeE/jiVImUA2P1UzMRkcQlG2gE08ieHGxYwaOgq56rwhkN/GA6+uJJcrEycwqj0
        sx6S5L8aZNEQIlYp+rLC6SYwf23HZV/vwEhKyubyIkyc7DE7B72sSjJczyQAOGhn
        djLpGesvLKo+OilLWelu+XGZbjqT+oRn2V1z45IY76fNvzDUIOrWnc5tA==
X-ME-Sender: <xms:AlvnYvyVkneLSQt-__YMEsdDsZp4F903dBLF1cV2lxiDwt_NfUyC7w>
    <xme:AlvnYnRgcLD5eHojJ_H1SaNZPwkr9usj4qoqt-tYnY5attp3bfS2uljNitDS_68nA
    KZgA2-B7SMx2kYySQ>
X-ME-Received: <xmr:AlvnYpWh0ZDRKGlpdr3pAyVsXyaPKMjnIk2SpVrKXPX8wt9V8x6ArWL1XIRkTJ30Y_wntgLPaIn_EAlS-Nnnl-q1Yo3-nadvvkEIOxvtTB2n5E-Ax0Fo4YwifhM1cNq6qEuQEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:AlvnYpgWrXC6BjbHYbIWWLRY1yyUAV2rNatSlBFbv2HtsnsYvh9Tkw>
    <xmx:AlvnYhDzYlwqxAJHEAlxOGb5i_envoECcy3uZ2yCFad_XymhwhiYVA>
    <xmx:AlvnYiJ6KLAk8ccsRINRMX89JOwPg_QrS7tr6ZE3lWtefXBoT3IpDQ>
    <xmx:AlvnYlsNFVDjzPP8kBNgwtYlmNWH9Mzg3h-oX0HH4V9wF5ZHuvErlQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Aug 2022 00:48:02 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 2/2] regulator: sun20i: Add support for Allwinner D1 LDOs
Date:   Sun, 31 Jul 2022 23:47:58 -0500
Message-Id: <20220801044758.12679-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801044758.12679-1-samuel@sholland.org>
References: <20220801044758.12679-1-samuel@sholland.org>
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

The analog LDOs are relatively boring, with a single linear range. The
one quirk is that their bandgap reference must be calibrated for them to
produce the correct voltage.

The system LDOs have the complication that their voltage step is not an
integer, so a custom .list_voltage is needed to get the rounding right.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/regulator/Kconfig            |   8 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/sun20i-regulator.c | 244 +++++++++++++++++++++++++++
 3 files changed, 253 insertions(+)
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
index 000000000000..c4d075440249
--- /dev/null
+++ b/drivers/regulator/sun20i-regulator.c
@@ -0,0 +1,244 @@
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
+		.n_voltages	= BIT(3),
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
+		.n_voltages	= BIT(3),
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
+		.n_voltages	= BIT(5),
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
+		.n_voltages	= BIT(6),
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
+	struct platform_device *syscon_pdev;
+	struct device_node *syscon_node;
+	struct regmap *regmap;
+
+	/*
+	 * First try the syscon interface. The system control device is not
+	 * compatible with "syscon", so fall back to getting the regmap from
+	 * its platform device. This is ugly, but required for devicetree
+	 * backward compatibility.
+	 */
+	regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
+	if (!IS_ERR(regmap))
+		return regmap;
+
+	syscon_node = of_parse_phandle(dev->of_node, "syscon", 0);
+	if (!syscon_node)
+		return ERR_PTR(-ENODEV);
+
+	syscon_pdev = of_find_device_by_node(syscon_node);
+	of_node_put(syscon_node);
+	if (!syscon_pdev)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	regmap = dev_get_regmap(&syscon_pdev->dev, NULL);
+	platform_device_put(syscon_pdev);
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

