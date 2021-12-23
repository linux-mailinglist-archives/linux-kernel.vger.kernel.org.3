Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F5047E180
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347730AbhLWKeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhLWKeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:34:22 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F053AC061401;
        Thu, 23 Dec 2021 02:34:21 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id j6so19499160edw.12;
        Thu, 23 Dec 2021 02:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nEDdPxiWGHJHA/JwM55TTuzm/mi1Nl/8AAGZvXNWNn0=;
        b=Oulg5mbR+nUmLG7mXJbzK7HqYNZVWVREScTKG6j7YYH6kDQrkNjheZn2IYQ1dwZ+h3
         iMPru6A2aYReBk4XS/kHKCgeIqVNmuRSaYTh0fKbDkwdmAQp3kPCldRwHhNkiawi+0VH
         Oa8cOV3P7xDBCR/1KA1wGf3WsT4CHcpDjGpQ0PmyahfHFbVIUFIeJk9Pg+8ovrYqwDeR
         GojM+mxNIPW2Zw2B2Oysf3lbcWzH12+icsJ3VwfjFtDA28DTL1CMfmJO6N19D0yPkxgo
         mkIeJXliIEsiHDjjxXrxqH4DkYvKnDetwZw5lClTMAW3d1OQn2spjBlvRM95vdn69u7f
         gVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nEDdPxiWGHJHA/JwM55TTuzm/mi1Nl/8AAGZvXNWNn0=;
        b=rxQWyz2zNDBBYS+KfW+jlumgTQHv0IENf5JoN9XuGkhGkur21PyTV5ZxQdhLKjbk0e
         WogCuvGDA+tM858F5p+1uwMP8JUlEVD21pnnHUEtQ3Y+QJkhodahOtsUwzYXS1N6DmhB
         mxK9aZvuibGA6nxNopmlt+wgnCuECe4PON1B5Zo/GoBa18Y8TlC0NOZ3EQMJVNCnIac3
         gP40fKwRMCqsAO4YfjKJAan1au+GDsNv3oL2HON06Gkp/AEI/P4cqMJ3cDkApAPPazFf
         gnlnuT39R0l+YmOGvpWNza/0CT9HLlNPuQNx/A1Lrs4ihZIoYgvK9Gw9VrO5uE8uCUHQ
         V49Q==
X-Gm-Message-State: AOAM530rRQIaPWvoYji332EqwgUHgL6e4k/YDuGoLUpFd5PlOvM30eFl
        xdI6wnnmbefeUqA3oJ3HLko8Ry0t/wsVUg==
X-Google-Smtp-Source: ABdhPJzyEVSkBQXrkgelgAu5hd4p2ELOA9zWaAEWMmhCcReWt0SXbYNMrLqYdBWIEJdIzVPBQMLepQ==
X-Received: by 2002:a17:907:3d88:: with SMTP id he8mr1423537ejc.707.1640255660348;
        Thu, 23 Dec 2021 02:34:20 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bx6sm1854840edb.78.2021.12.23.02.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 02:34:20 -0800 (PST)
Subject: Re: [RFC PATCH v6 3/4] phy: rockchip: add naneng multi phy for rk3568
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, lee.jones@linaro.org,
        yifeng.zhao@rock-chips.com, kever.yang@rock-chips.com,
        cl@rock-chips.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211222213032.7678-1-jbx6244@gmail.com>
 <20211222213032.7678-4-jbx6244@gmail.com>
Message-ID: <983bfd82-87e6-b5ca-1620-917be6098625@gmail.com>
Date:   Thu, 23 Dec 2021 11:34:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211222213032.7678-4-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yifeng and others,

Some comments,have a look if it's useful.

If you like the multi phy approuch:

Could you carefully test with hardware and tell us
what part of the code works or not and what to improve.

Produce a version 7 based on the code ideas and the comments below.

Kind regards,

Johan Jonker


On 12/22/21 10:30 PM, Johan Jonker wrote:
> From: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> 
> This patch implements a multi phy driver for Rockchip SoCs
> with NaNeng IP block. This phy can be used as pcie-phy, usb3-phy,
> sata-phy or sgmii-phy.
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> TEST COMPILED ONLY!
> Driver not verified with hardware!
> 
> ---
> 
> Changes in v6:
> - restyle
> - rename defines
> - change from comb to multi phy
> - clean up includes
> - add parent node
> - change compatible strings
> - remove rockchip,sgmii-mac-sel support
> - remove rockchip,dis-u3otg0-port support
> - remove rockchip,dis-u3otg1-port support
> 
> Changes in v5:
> - add rockchip_combphy_updatel()
> - restyle
> 
> Changes in v4:
> - restyle
> - add devm_reset_control_array_get()
> - remove clk structure
> - change refclk DT parse
> - change dev_err message
> - add dot to phrase
> - add ext_refclk variable
> - add enable_ssc variable
> - rename rockchip_combphy_param_write
> - remove param_read
> - replace rockchip-naneng-combphy driver name
> 
> Changes in v3:
> - Using api devm_reset_control_get_optional_exclusive and dev_err_probe.
> - Remove apb_rst.
> - Redefine registers address.
> 
> Changes in v2:
> - Using api devm_platform_get_and_ioremap_resource.
> - Modify rockchip_combphy_set_Mode.
> - Add some PHY registers definition.
> ---
>  drivers/phy/rockchip/Kconfig                  |   8 +
>  drivers/phy/rockchip/Makefile                 |   1 +
>  .../rockchip/phy-rockchip-naneng-multiphy.c   | 661 ++++++++++++++++++
>  3 files changed, 670 insertions(+)
>  create mode 100644 drivers/phy/rockchip/phy-rockchip-naneng-multiphy.c
> 
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index e812adad7..a14e32b6f 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -66,6 +66,14 @@ config PHY_ROCKCHIP_INNO_DSIDPHY
>  	  Enable this to support the Rockchip MIPI/LVDS/TTL PHY with
>  	  Innosilicon IP block.
>  
> +config PHY_ROCKCHIP_NANENG_MULTI_PHY
> +	tristate "Rockchip NANENG MULTI PHY Driver"
> +	depends on ARCH_ROCKCHIP && OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the Rockchip PCIe/USB3.0/SATA/QSGMII
> +	  multi PHY with NaNeng IP block.
> +
>  config PHY_ROCKCHIP_PCIE
>  	tristate "Rockchip PCIe PHY Driver"
>  	depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
> diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
> index f0eec212b..d5570452f 100644
> --- a/drivers/phy/rockchip/Makefile
> +++ b/drivers/phy/rockchip/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY)	+= phy-rockchip-inno-csidphy.o
>  obj-$(CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY)	+= phy-rockchip-inno-dsidphy.o
>  obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI)	+= phy-rockchip-inno-hdmi.o
>  obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
> +obj-$(CONFIG_PHY_ROCKCHIP_NANENG_MULTI_PHY)	+= phy-rockchip-naneng-multiphy.o
>  obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
>  obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
>  obj-$(CONFIG_PHY_ROCKCHIP_USB)		+= phy-rockchip-usb.o
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-multiphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-multiphy.c
> new file mode 100644
> index 000000000..765ede440
> --- /dev/null
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-multiphy.c
> @@ -0,0 +1,661 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Rockchip PIPE USB3.0 PCIE SATA Multi Phy driver
> + *
> + * Copyright (C) 2021 Rockchip Electronics Co., Ltd.
> + */
> +
> +#include <dt-bindings/phy/phy.h>
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/units.h>
> +
> +#define BIT_WRITEABLE_SHIFT		16
> +#define REF_CLOCK_24MHz			(24 * HZ_PER_MHZ)
> +#define REF_CLOCK_25MHz			(25 * HZ_PER_MHZ)
> +#define REF_CLOCK_100MHz		(100 * HZ_PER_MHZ)
> +
> +/* RK3568 MULTI PHY REG */
> +#define RK3568_PHYREG6			0x14
> +#define PHYREG6_PLL_DIV_MASK		GENMASK(7, 6)
> +#define PHYREG6_PLL_DIV_SHIFT		6
> +#define PHYREG6_PLL_DIV_2		1
> +
> +#define RK3568_PHYREG7			0x18
> +#define PHYREG7_TX_RTERM_MASK		GENMASK(7, 4)
> +#define PHYREG7_TX_RTERM_SHIFT		4
> +#define PHYREG7_TX_RTERM_50OHM		8
> +#define PHYREG7_RX_RTERM_MASK		GENMASK(3, 0)
> +#define PHYREG7_RX_RTERM_SHIFT		0
> +#define PHYREG7_RX_RTERM_44OHM		15
> +
> +#define RK3568_PHYREG8			0x1C
> +#define PHYREG8_SSC_EN			BIT(4)
> +
> +#define RK3568_PHYREG11			0x28
> +#define PHYREG11_SU_TRIM_0_7		0xF0
> +
> +#define RK3568_PHYREG12			0x2C
> +#define PHYREG12_PLL_LPF_ADJ_VALUE	4
> +
> +#define RK3568_PHYREG13			0x30
> +#define PHYREG13_RESISTER_MASK		GENMASK(5, 4)
> +#define PHYREG13_RESISTER_SHIFT		0x4
> +#define PHYREG13_RESISTER_HIGH_Z	3
> +#define PHYREG13_CKRCV_AMP0		BIT(7)
> +
> +#define RK3568_PHYREG14			0x34
> +#define PHYREG14_CKRCV_AMP1		BIT(0)
> +
> +#define RK3568_PHYREG15			0x38
> +#define PHYREG15_CTLE_EN		BIT(0)
> +#define PHYREG15_SSC_CNT_MASK		GENMASK(7, 6)
> +#define PHYREG15_SSC_CNT_SHIFT		6
> +#define PHYREG15_SSC_CNT_VALUE		1
> +
> +#define RK3568_PHYREG16			0x3C
> +#define PHYREG16_SSC_CNT_VALUE		0x5f
> +
> +#define RK3568_PHYREG18			0x44
> +#define PHYREG18_PLL_LOOP		0x32
> +
> +#define RK3568_PHYREG32			0x7C
> +#define PHYREG32_SSC_MASK		GENMASK(7, 4)
> +#define PHYREG32_SSC_DIR_SHIFT		4
> +#define PHYREG32_SSC_UPWARD		0
> +#define PHYREG32_SSC_DOWNWARD		1
> +#define PHYREG32_SSC_OFFSET_SHIFT	6
> +#define PHYREG32_SSC_OFFSET_500PPM	1
> +
> +#define RK3568_PHYREG33			0x80
> +#define PHYREG33_PLL_KVCO_MASK		GENMASK(4, 2)
> +#define PHYREG33_PLL_KVCO_SHIFT		2
> +#define PHYREG33_PLL_KVCO_VALUE		2

/* RK3588 MULTI PHY REG */

Add more defines.

> +
> +struct rockchip_multiphy_priv;
> +
> +struct multiphy_reg {
> +	u16 offset;
> +	u16 bitend;
> +	u16 bitstart;
> +	u16 disable;
> +	u16 enable;
> +};
> +
> +struct rockchip_multiphy_grfcfg {
> +	struct multiphy_reg pcie_mode_set;
> +	struct multiphy_reg usb_mode_set;
> +	struct multiphy_reg sgmii_mode_set;
> +	struct multiphy_reg qsgmii_mode_set;
> +	struct multiphy_reg pipe_rxterm_set;
> +	struct multiphy_reg pipe_txelec_set;
> +	struct multiphy_reg pipe_txcomp_set;
> +	struct multiphy_reg pipe_clk_25m;
> +	struct multiphy_reg pipe_clk_100m;
> +	struct multiphy_reg pipe_phymode_sel;
> +	struct multiphy_reg pipe_rate_sel;
> +	struct multiphy_reg pipe_rxterm_sel;
> +	struct multiphy_reg pipe_txelec_sel;
> +	struct multiphy_reg pipe_txcomp_sel;
> +	struct multiphy_reg pipe_clk_ext;
> +	struct multiphy_reg pipe_sel_usb;
> +	struct multiphy_reg pipe_sel_qsgmii;
> +	struct multiphy_reg pipe_phy_status;
> +	struct multiphy_reg con0_for_pcie;
> +	struct multiphy_reg con1_for_pcie;
> +	struct multiphy_reg con2_for_pcie;
> +	struct multiphy_reg con3_for_pcie;
> +	struct multiphy_reg con0_for_sata;
> +	struct multiphy_reg con1_for_sata;
> +	struct multiphy_reg con2_for_sata;
> +	struct multiphy_reg con3_for_sata;
> +	struct multiphy_reg pipe_con0_for_sata;
> +	struct multiphy_reg pipe_sgmii_mac_sel;
> +	struct multiphy_reg pipe_xpcs_phy_ready;
> +	struct multiphy_reg u3otg0_port_en;
> +	struct multiphy_reg u3otg1_port_en;

.num_phy
.regs
.cap

Add more phy properties for checks and control.

> +};
> +
> +struct rockchip_multiphy_cfg {
> +	const struct rockchip_multiphy_grfcfg *grfcfg;
> +	int (*multiphy_cfg)(struct phy *phy);
> +};
> +
> +struct rockchip_multiphy_node_priv {
> +	int id;
> +	u8 mode;
> +	void __iomem *mmio;
> +	int num_clks;
> +	struct clk_bulk_data *clks;
> +	struct regmap *phy_grf;
> +	struct phy *phy;
> +	struct reset_control *phy_rst;
> +	struct clk *refclk;
> +	bool enable_ssc;
> +	bool ext_refclk;
> +};
> +
> +struct rockchip_multiphy_priv {
> +	struct device *dev;
> +	int num_phy;
> +	struct regmap *pipe_grf;
> +	const struct rockchip_multiphy_cfg *cfg;
> +	struct rockchip_multiphy_node_priv **node;
> +};
> +
> +static void rockchip_multiphy_updatel(struct phy *phy, int mask, int val, int reg)
> +{
> +	struct rockchip_multiphy_node_priv *node_priv = phy_get_drvdata(phy);
> +	unsigned int temp;
> +
> +	temp = readl(node_priv->mmio + reg);
> +	temp = (temp & ~(mask)) | val;
> +	writel(temp, node_priv->mmio + reg);
> +}
> +
> +static int rockchip_multiphy_param_write(struct regmap *base,
> +					 const struct multiphy_reg *reg, bool en)
> +{
> +	u32 val, mask, tmp;
> +
> +	tmp = en ? reg->enable : reg->disable;
> +	mask = GENMASK(reg->bitend, reg->bitstart);
> +	val = (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);
> +
> +	return regmap_write(base, reg->offset, val);
> +}
> +
> +static u32 rockchip_multiphy_is_ready(struct phy *phy)
> +{
> +	struct rockchip_multiphy_priv *priv = dev_get_drvdata(phy->dev.parent);
> +	struct rockchip_multiphy_node_priv *node_priv = phy_get_drvdata(phy);
> +	const struct rockchip_multiphy_grfcfg *cfg = priv->cfg->grfcfg;
> +	u32 mask, val;
> +
> +	mask = GENMASK(cfg->pipe_phy_status.bitend,
> +		       cfg->pipe_phy_status.bitstart);
> +
> +	regmap_read(node_priv->phy_grf, cfg->pipe_phy_status.offset, &val);
> +	val = (val & mask) >> cfg->pipe_phy_status.bitstart;
> +
> +	return val;
> +}
> +
> +static int rockchip_multiphy_set_mode(struct phy *phy)
> +{
> +	struct rockchip_multiphy_priv *priv = dev_get_drvdata(phy->dev.parent);
> +	struct rockchip_multiphy_node_priv *node_priv = phy_get_drvdata(phy);
> +	int ret = 0;
> +
> +	switch (node_priv->mode) {
> +	case PHY_TYPE_PCIE:
> +	case PHY_TYPE_USB3:
> +	case PHY_TYPE_SATA:
> +	case PHY_TYPE_SGMII:
> +	case PHY_TYPE_QSGMII:
> +		if (priv->cfg->multiphy_cfg)
> +			ret = priv->cfg->multiphy_cfg(phy);
> +		break;
> +	default:
> +		dev_err(priv->dev, "incompatible PHY type\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ret)
> +		dev_err(priv->dev, "failed to init phy for phy mode %x\n", node_priv->mode);
> +
> +	return ret;
> +}
> +
> +static int rockchip_multiphy_init(struct phy *phy)
> +{
> +	struct rockchip_multiphy_priv *priv = dev_get_drvdata(phy->dev.parent);
> +	struct rockchip_multiphy_node_priv *node_priv = phy_get_drvdata(phy);
> +	const struct rockchip_multiphy_grfcfg *cfg = priv->cfg->grfcfg;
> +	u32 val;
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(node_priv->num_clks, node_priv->clks);
> +	if (ret) {
> +		dev_err(priv->dev, "failed to enable clks\n");
> +		return ret;
> +	}
> +
> +	ret = rockchip_multiphy_set_mode(phy);
> +	if (ret)
> +		goto err_clk;
> +
> +	ret = reset_control_deassert(node_priv->phy_rst);
> +	if (ret)
> +		goto err_clk;
> +
> +	if (node_priv->mode == PHY_TYPE_USB3) {
> +		ret = readx_poll_timeout_atomic(rockchip_multiphy_is_ready,
> +						phy, val,
> +						val == cfg->pipe_phy_status.enable,
> +						10, 1000);
> +		if (ret)
> +			dev_warn(priv->dev, "wait phy status ready timeout\n");
> +	}
> +
> +	return 0;
> +
> +err_clk:
> +	clk_bulk_disable_unprepare(node_priv->num_clks, node_priv->clks);
> +
> +	return ret;
> +}
> +
> +static int rockchip_multiphy_exit(struct phy *phy)
> +{
> +	struct rockchip_multiphy_node_priv *node_priv = phy_get_drvdata(phy);
> +
> +	clk_bulk_disable_unprepare(node_priv->num_clks, node_priv->clks);
> +	reset_control_assert(node_priv->phy_rst);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops rochchip_multiphy_ops = {
> +	.init = rockchip_multiphy_init,
> +	.exit = rockchip_multiphy_exit,
> +	.owner = THIS_MODULE,
> +};
> +
> +static struct phy *rockchip_multiphy_xlate(struct device *dev, struct of_phandle_args *args)
> +{
> +	struct rockchip_multiphy_priv *priv = dev_get_drvdata(dev);
> +	struct rockchip_multiphy_node_priv *node_priv = NULL;
> +	struct device_node *phy_np = args->np;
> +	int index;
> +
[..]

> +
> +	for (index = 0; index < priv->num_phy; index++)
> +		if (phy_np == priv->node[index]->phy->dev.of_node) {
> +			node_priv = priv->node[index];
> +			break;
> +		}
> +
> +	if (!node_priv) {
> +		dev_err(dev, "failed to find appropriate phy\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (node_priv->mode != PHY_NONE && node_priv->mode != args->args[0])
> +		dev_warn(dev, "phy type select %d overwriting type %d\n",
> +			 args->args[0], node_priv->mode);
> +
> +	node_priv->mode = args->args[0];

if ((node_priv->mode == PHY_TYPE_SGMII && args->args_count != 2) ||
(node_priv->mode != PHY_TYPE_SGMII && args->args_count != 1) {
		dev_err(dev, "invalid number of arguments\n");
		return ERR_PTR(-EINVAL);
	}

Check number of argument based on capabillity.

===

	if (node_priv->mode != priv->cap[node_priv->id]) {
		dev_err(dev, "invalid mode\n");
		return ERR_PTR(-EINVAL);
	}

Check mode and id with phy node capabilities.

===
	if (node_priv->mode == PHY_TYPE_SGMII && args->args[1] == 0 ||
args->args[1] == 1)
		node_priv->sgmii-mac-sel = args->args[1];
	else {
		dev_err(dev, "invalid gmac id\n");
		return ERR_PTR(-EINVAL);
	}

Maybe obtain SGMII output from extra phy argument.
Fix YAML document as well!

> +
> +	return node_priv->phy;
> +}
> +
> +static int rockchip_multiphy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *child_np;
> +	struct phy_provider *phy_provider;
> +	struct resource res;
> +	struct rockchip_multiphy_priv *priv;
> +	int retval;
> +	int id;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->cfg = of_device_get_match_data(dev);
> +	if (!priv->cfg) {
> +		dev_err(dev, "no OF match data provided\n");
> +		return -EINVAL;
> +	}
> +

> +	priv->num_phy = of_get_child_count(np);

Check priv->num_phy with max SoC capabilities.

> +	priv->node = devm_kcalloc(dev, priv->num_phy, sizeof(*priv->node), GFP_KERNEL);
> +	if (!priv->node)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +	dev_set_drvdata(dev, priv);
> +
> +	priv->pipe_grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,pipe-grf");
> +	if (IS_ERR(priv->pipe_grf)) {
> +		dev_err(dev, "failed to find peri_ctrl pipe-grf regmap\n");
> +		return PTR_ERR(priv->pipe_grf);
> +	}
> +
> +	id = 0;
> +	for_each_child_of_node(np, child_np) {
> +		struct rockchip_multiphy_node_priv *node_priv;
> +		struct device *subdev;
> +		struct phy *phy;
> +		int i;
> +
> +		node_priv = devm_kzalloc(dev, sizeof(*node_priv), GFP_KERNEL);
> +		if (!node_priv) {
> +			retval = -ENOMEM;
> +			goto put_child;
> +		}
> +
> +		priv->node[id] = node_priv;
> +
> +		phy = devm_phy_create(dev, child_np, &rochchip_multiphy_ops);
> +		if (IS_ERR(phy)) {
> +			dev_err(dev, "failed to create phy\n");
> +			retval = PTR_ERR(phy);
> +			goto put_child;
> +		}
> +
> +		subdev = &phy->dev;
> +		retval = of_address_to_resource(child_np, 0, &res);
> +		if (retval) {
> +			dev_err(subdev, "failed to get address resource(id-%d)\n",
> +				id);
> +			goto put_child;
> +		}
> +
> +		node_priv->mmio = devm_ioremap_resource(subdev, &res);
> +		if (IS_ERR(node_priv->mmio)) {
> +			retval = PTR_ERR(node_priv->mmio);
> +			goto put_child;
> +		}
> +
> +		node_priv->phy = phy;

> +		node_priv->id = id;

For a mode check based on id and phy node capabilities the id has to be
based on reg address DT order.
Currently node_priv->id is based on node order.
Check reg address with a table and assign id from table index.

> +		node_priv->mode = PHY_NONE;
> +		id++;
> +
> +		phy_set_drvdata(phy, node_priv);
> +
> +		node_priv->num_clks = devm_clk_bulk_get_all(dev, &node_priv->clks);
> +		if (node_priv->num_clks < 1) {
> +			retval = -EINVAL;
> +			goto put_child;
> +		}
> +
> +		node_priv->refclk = NULL;
> +		for (i = 0; i < node_priv->num_clks; i++) {
> +			if (!strncmp(node_priv->clks[i].id, "ref", 3)) {
> +				node_priv->refclk = node_priv->clks[i].clk;
> +				break;
> +			}
> +		}
> +
> +		if (!node_priv->refclk) {
> +			dev_err(dev, "no refclk found\n");
> +			retval = -EINVAL;
> +			goto put_child;
> +		}
> +
> +		node_priv->phy_grf = syscon_regmap_lookup_by_phandle(dev->of_node,
> +								     "rockchip,pipe-phy-grf");
> +		if (IS_ERR(node_priv->phy_grf)) {
> +			retval = PTR_ERR(node_priv->phy_grf);
> +			dev_err(dev, "failed to find pipe-phy-grf regmap\n");
> +			goto put_child;
> +		}
> +
> +		node_priv->enable_ssc = device_property_present(dev, "rockchip,enable-ssc");
> +
> +		node_priv->ext_refclk = device_property_present(dev, "rockchip,ext-refclk");
> +
> +		node_priv->phy_rst = devm_reset_control_array_get(dev, false, false);
> +		if (IS_ERR(node_priv->phy_rst)) {
> +			retval = PTR_ERR(node_priv->phy_rst);
> +			dev_err(dev, "failed to get phy reset\n");
> +			goto put_child;
> +		}
> +
> +		retval = reset_control_assert(node_priv->phy_rst);
> +		if (retval) {
> +			dev_err(dev, "failed to reset phy\n");
> +			goto put_child;
> +		}
> +	}
> +
> +	phy_provider = devm_of_phy_provider_register(dev, rockchip_multiphy_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +put_child:
> +	of_node_put(child_np);
> +	return retval;
> +}
> +
> +static int rk3568_multiphy_cfg(struct phy *phy)
> +{
> +	struct rockchip_multiphy_node_priv *node_priv = phy_get_drvdata(phy);
> +	struct rockchip_multiphy_priv *priv = dev_get_drvdata(phy->dev.parent);
> +	const struct rockchip_multiphy_grfcfg *cfg = priv->cfg->grfcfg;
> +	unsigned long rate;
> +	u32 val;
> +
> +	switch (node_priv->mode) {
> +	case PHY_TYPE_PCIE:
> +		/* Set SSC downward spread spectrum. */
> +		rockchip_multiphy_updatel(phy, PHYREG32_SSC_MASK,
> +					  PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
> +					  RK3568_PHYREG32);
> +
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->con0_for_pcie, true);
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->con1_for_pcie, true);
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->con2_for_pcie, true);
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->con3_for_pcie, true);
> +		break;
> +
> +	case PHY_TYPE_USB3:
> +		/* Set SSC downward spread spectrum. */
> +		rockchip_multiphy_updatel(phy, PHYREG32_SSC_MASK,
> +					  PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
> +					  RK3568_PHYREG32);
> +
> +		/* Enable adaptive CTLE for USB3.0 Rx. */
> +		val = readl(node_priv->mmio + RK3568_PHYREG15);
> +		val |= PHYREG15_CTLE_EN;
> +		writel(val, node_priv->mmio + RK3568_PHYREG15);
> +
> +		/* Set PLL KVCO fine tuning signals. */
> +		rockchip_multiphy_updatel(phy, PHYREG33_PLL_KVCO_MASK,
> +					  PHYREG33_PLL_KVCO_VALUE << PHYREG33_PLL_KVCO_SHIFT,
> +					  RK3568_PHYREG33);
> +
> +		/* Enable controlling random jitter. */
> +		writel(PHYREG12_PLL_LPF_ADJ_VALUE, node_priv->mmio + RK3568_PHYREG12);
> +
> +		/* Set PLL input clock divider 1/2. */
> +		rockchip_multiphy_updatel(phy, PHYREG6_PLL_DIV_MASK,
> +					  PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT,
> +					  RK3568_PHYREG6);
> +
> +		writel(PHYREG18_PLL_LOOP, node_priv->mmio + RK3568_PHYREG18);
> +		writel(PHYREG11_SU_TRIM_0_7, node_priv->mmio + RK3568_PHYREG11);
> +
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->pipe_sel_usb, true);
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->pipe_txcomp_sel, false);
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->pipe_txelec_sel, false);
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->usb_mode_set, true);
> +		break;
> +
> +	case PHY_TYPE_SATA:
> +		/* Enable adaptive CTLE for SATA Rx. */
> +		val = readl(node_priv->mmio + RK3568_PHYREG15);
> +		val |= PHYREG15_CTLE_EN;
> +		writel(val, node_priv->mmio + RK3568_PHYREG15);
> +		/*
> +		 * Set tx_rterm=50ohm and rx_rterm=44ohm for SATA.
> +		 * 0: 60ohm, 8: 50ohm 15: 44ohm (by step abort 1ohm)
> +		 */
> +		val = PHYREG7_TX_RTERM_50OHM << PHYREG7_TX_RTERM_SHIFT;
> +		val |= PHYREG7_RX_RTERM_44OHM << PHYREG7_RX_RTERM_SHIFT;
> +		writel(val, node_priv->mmio + RK3568_PHYREG7);
> +
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->con0_for_sata, true);
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->con1_for_sata, true);
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->con2_for_sata, true);
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->con3_for_sata, true);
> +		rockchip_multiphy_param_write(priv->pipe_grf, &cfg->pipe_con0_for_sata, true);
> +		break;
> +
> +	case PHY_TYPE_SGMII:
> +		rockchip_multiphy_param_write(priv->pipe_grf, &cfg->pipe_xpcs_phy_ready, true);
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->pipe_phymode_sel, true);
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->pipe_sel_qsgmii, true);
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->sgmii_mode_set, true);
> +		break;
> +
> +	case PHY_TYPE_QSGMII:
> +		rockchip_multiphy_param_write(priv->pipe_grf, &cfg->pipe_xpcs_phy_ready, true);
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->pipe_phymode_sel, true);
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->pipe_rate_sel, true);
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->pipe_sel_qsgmii, true);
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->qsgmii_mode_set, true);
> +		break;
> +
> +	default:
> +		dev_err(priv->dev, "incompatible PHY type\n");
> +		return -EINVAL;
> +	}
> +
> +	rate = clk_get_rate(node_priv->refclk);
> +
> +	switch (rate) {
> +	case REF_CLOCK_24MHz:
> +		if (node_priv->mode == PHY_TYPE_USB3 || node_priv->mode == PHY_TYPE_SATA) {
> +			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz. */
> +			val = PHYREG15_SSC_CNT_VALUE << PHYREG15_SSC_CNT_SHIFT;
> +			rockchip_multiphy_updatel(phy, PHYREG15_SSC_CNT_MASK,
> +						  val, RK3568_PHYREG15);
> +
> +			writel(PHYREG16_SSC_CNT_VALUE, node_priv->mmio + RK3568_PHYREG16);
> +		}
> +		break;
> +
> +	case REF_CLOCK_25MHz:
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->pipe_clk_25m, true);
> +		break;
> +
> +	case REF_CLOCK_100MHz:
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->pipe_clk_100m, true);
> +		if (node_priv->mode == PHY_TYPE_PCIE) {
> +			/* PLL KVCO  fine tuning. */
> +			val = PHYREG33_PLL_KVCO_VALUE << PHYREG33_PLL_KVCO_SHIFT;
> +			rockchip_multiphy_updatel(phy, PHYREG33_PLL_KVCO_MASK,
> +						  val, RK3568_PHYREG33);
> +
> +			/* Enable controlling random jitter. */
> +			writel(PHYREG12_PLL_LPF_ADJ_VALUE, node_priv->mmio + RK3568_PHYREG12);
> +
> +			val = PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT;
> +			rockchip_multiphy_updatel(phy, PHYREG6_PLL_DIV_MASK,
> +						  val, RK3568_PHYREG6);
> +
> +			writel(PHYREG18_PLL_LOOP, node_priv->mmio + RK3568_PHYREG18);
> +			writel(PHYREG11_SU_TRIM_0_7, node_priv->mmio + RK3568_PHYREG11);
> +		} else if (node_priv->mode == PHY_TYPE_SATA) {
> +			/* downward spread spectrum +500ppm */
> +			val = PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT;
> +			val |= PHYREG32_SSC_OFFSET_500PPM << PHYREG32_SSC_OFFSET_SHIFT;
> +			rockchip_multiphy_updatel(phy, PHYREG32_SSC_MASK,
> +						  val, RK3568_PHYREG32);
> +			writel(val, node_priv->mmio + RK3568_PHYREG32);
> +		}
> +		break;
> +
> +	default:
> +		dev_err(priv->dev, "unsupported rate: %lu\n", rate);
> +		return -EINVAL;
> +	}

	condition1 = (SoC rk3568) && (id == 0)
	val = condition1 && (mode != USB3)? false : true;
	if (condition1)
		rockchip_combphy_param_write(priv->pipe_grf,
&phy_cfg->grfcfg->u3otg0_port_en, val);


	condition2 = (SoC rk3566 or rk3568) && (id == 1)
	val = condition2 && (mode != USB3)? false : true;
	if (condition2)
		rockchip_combphy_param_write(priv->pipe_grf,
&phy_cfg->grfcfg->u3otg1_port_en, val);

========================

	condition3 = (SoC rk3568) && (id == 1 || id == 2) && (mode == SGMII)
	val = condition3 && (node_priv->sgmii-mac-sel)? true : false;
	if (condition3)
		rockchip_combphy_param_write(priv->pipe_grf,
&phy_cfg->grfcfg->pipe_sgmii_mac_sel, val);

TODO:
Allow more phy data with:

YAML node:

     "#phy-cells":
        enum: [1, 2]

DT node:

	gmac0: ethernet@fe2a0000 {
		phys = <&combphy1 PHY_TYPE_SGMII 0>;
		phy-names = "sgmii-phy";

or

		phys = <&combphy2 PHY_TYPE_SGMII 0>;
		phy-names = "sgmii-phy";
	}

	gmac1: ethernet@fe010000 {
		phys = <&combphy1 PHY_TYPE_SGMII 1>;
		phy-names = "sgmii-phy";

or

		phys = <&combphy2 PHY_TYPE_SGMII 1>;
		phy-names = "sgmii-phy";
	}

Could someone test this idea?

> +
> +	if (node_priv->ext_refclk) {
> +		rockchip_multiphy_param_write(node_priv->phy_grf, &cfg->pipe_clk_ext, true);
> +		if (node_priv->mode == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
> +			val = PHYREG13_RESISTER_HIGH_Z << PHYREG13_RESISTER_SHIFT;
> +			val |= PHYREG13_CKRCV_AMP0;
> +			rockchip_multiphy_updatel(phy, PHYREG13_RESISTER_MASK,
> +						  val, RK3568_PHYREG13);
> +
> +			val = readl(node_priv->mmio + RK3568_PHYREG14);
> +			val |= PHYREG14_CKRCV_AMP1;
> +			writel(val, node_priv->mmio + RK3568_PHYREG14);
> +		}
> +	}
> +
> +	if (node_priv->enable_ssc) {
> +		val = readl(node_priv->mmio + RK3568_PHYREG8);
> +		val |= PHYREG8_SSC_EN;
> +		writel(val, node_priv->mmio + RK3568_PHYREG8);
> +	}
> +
> +	return 0;
> +}
> +
static const struct rockchip_multiphy_grfcfg rk3566_multiphy_grfcfgs = {
[..]

Add maximum number of phy nodes for check with priv->num_phy.
 .num_phy = 2,

Add reg addresses to detect phy id.
.regs =
0xfe830000,
0xfe840000,

Add table with SoC capabilities based on phy id.
 PCie USB3 SATA SGMII
0: 0   x    x     0
1: x   x    x     0

Don't confuse phy id with node label numbers!

};

> +static const struct rockchip_multiphy_grfcfg rk3568_multiphy_grfcfgs = {
> +	/* pipe-phy-grf */
> +	.pcie_mode_set		= { 0x0000, 5, 0, 0x00, 0x11 },
> +	.usb_mode_set		= { 0x0000, 5, 0, 0x00, 0x04 },
> +	.sgmii_mode_set		= { 0x0000, 5, 0, 0x00, 0x01 },
> +	.qsgmii_mode_set	= { 0x0000, 5, 0, 0x00, 0x21 },
> +	.pipe_rxterm_set	= { 0x0000, 12, 12, 0x00, 0x01 },
> +	.pipe_txelec_set	= { 0x0004, 1, 1, 0x00, 0x01 },
> +	.pipe_txcomp_set	= { 0x0004, 4, 4, 0x00, 0x01 },
> +	.pipe_clk_25m		= { 0x0004, 14, 13, 0x00, 0x01 },
> +	.pipe_clk_100m		= { 0x0004, 14, 13, 0x00, 0x02 },
> +	.pipe_phymode_sel	= { 0x0008, 1, 1, 0x00, 0x01 },
> +	.pipe_rate_sel		= { 0x0008, 2, 2, 0x00, 0x01 },
> +	.pipe_rxterm_sel	= { 0x0008, 8, 8, 0x00, 0x01 },
> +	.pipe_txelec_sel	= { 0x0008, 12, 12, 0x00, 0x01 },
> +	.pipe_txcomp_sel	= { 0x0008, 15, 15, 0x00, 0x01 },
> +	.pipe_clk_ext		= { 0x000c, 9, 8, 0x02, 0x01 },
> +	.pipe_sel_usb		= { 0x000c, 14, 13, 0x00, 0x01 },
> +	.pipe_sel_qsgmii	= { 0x000c, 15, 13, 0x00, 0x07 },
> +	.pipe_phy_status	= { 0x0034, 6, 6, 0x01, 0x00 },
> +	.con0_for_pcie		= { 0x0000, 15, 0, 0x00, 0x1000 },
> +	.con1_for_pcie		= { 0x0004, 15, 0, 0x00, 0x0000 },
> +	.con2_for_pcie		= { 0x0008, 15, 0, 0x00, 0x0101 },
> +	.con3_for_pcie		= { 0x000c, 15, 0, 0x00, 0x0200 },
> +	.con0_for_sata		= { 0x0000, 15, 0, 0x00, 0x0119 },
> +	.con1_for_sata		= { 0x0004, 15, 0, 0x00, 0x0040 },
> +	.con2_for_sata		= { 0x0008, 15, 0, 0x00, 0x80c3 },
> +	.con3_for_sata		= { 0x000c, 15, 0, 0x00, 0x4407 },
> +	/* pipe-grf */
> +	.pipe_con0_for_sata	= { 0x0000, 15, 0, 0x00, 0x2220 },
> +	.pipe_sgmii_mac_sel	= { 0x0040, 1, 1, 0x00, 0x01 },
> +	.pipe_xpcs_phy_ready	= { 0x0040, 2, 2, 0x00, 0x01 },
> +	.u3otg0_port_en		= { 0x0104, 15, 0, 0x0181, 0x1100 },
> +	.u3otg1_port_en		= { 0x0144, 15, 0, 0x0181, 0x1100 },

Add maximum number of phy nodes for check with priv->num_phy.
 .num_phy = 3,

Add reg addresses to detect phy id.
.regs =
0xfe820000,
0xfe830000,
0xfe840000,


Add table with SoC capabilities based on phy id.
 PCie USB3 SATA SGMII
0: 0   x    x     0
1: 0   x    x     x
2: x   x    x     x

> +};

static const struct rockchip_multiphy_grfcfg rk3588_multiphy_grfcfgs = {
[..]
};

static const struct rockchip_multiphy_cfg rk3566_multiphy_cfgs = {
	.grfcfg		= &rk3566_multiphy_grfcfgs,
	.multiphy_cfg	= rk3568_multiphy_cfg,
};

> +
> +static const struct rockchip_multiphy_cfg rk3568_multiphy_cfgs = {
> +	.grfcfg		= &rk3568_multiphy_grfcfgs,
> +	.multiphy_cfg	= rk3568_multiphy_cfg,
> +};


static const struct rockchip_multiphy_cfg rk3588_multiphy_cfgs = {
	.grfcfg		= &rk3588_multiphy_grfcfgs,
	.multiphy_cfg	= rk3588_multiphy_cfg,
};

> +
> +static const struct of_device_id rockchip_multiphy_of_match[] = {
> +	{ .compatible = "rockchip,rk3566-naneng-multiphy",

> +	  .data = &rk3568_multiphy_cfgs, },

	  .data = &rk3566_multiphy_cfgs, },

> +	{ .compatible = "rockchip,rk3568-naneng-multiphy",
> +	  .data = &rk3568_multiphy_cfgs, },

	{ .compatible = "rockchip,rk3588-naneng-multiphy",
	  .data = &rk3588_multiphy_cfgs, },

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, rockchip_multiphy_of_match);
> +
> +static struct platform_driver rockchip_multiphy_driver = {
> +	.probe	= rockchip_multiphy_probe,
> +	.driver = {
> +		.name = "rockchip-naneng-multiphy",
> +		.of_match_table = rockchip_multiphy_of_match,
> +	},
> +};
> +module_platform_driver(rockchip_multiphy_driver);
> +
> +MODULE_DESCRIPTION("Rockchip NANENG MULTIPHY driver");
> +MODULE_LICENSE("GPL v2");
> 
