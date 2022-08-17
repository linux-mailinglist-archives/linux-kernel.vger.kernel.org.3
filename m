Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2405A597724
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbiHQTzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbiHQTzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:55:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E93A2867;
        Wed, 17 Aug 2022 12:55:08 -0700 (PDT)
Received: from notapiano (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 43C6F66019FB;
        Wed, 17 Aug 2022 20:55:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660766106;
        bh=HyKYDfF8C/EjS61VvfNy5zCttuH25Xk3EwKzKCsv2mU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DAVuz1nTEiUf8s45bB89PTn3EzZBWzGhrbmAfbSXSDAWAyQwwxE+3lWCkUG1Baxck
         xS+pUdIZU/7Nr6uN9zdmHxVu0g5d4OOCN81VVaTr8ndDis7WGCwSedV2IOD/jR95bD
         8OBuhX1r8g6BI3bCF5HmdTuHn9IMSuq/uLxtQftGOIRdaNFNPmJRgPgPmzQgKnyscH
         xM+/NEi1ZWt01Gf/fWLg5vfGJmOlnRT3F4F9haSW/ol3Fds3YSakSeQvLc+34G5ykN
         hYm920WJjKTBQ2DggQ3XeIS93BcBYKltJ/b7ZV/r4DwjyIPU4s1VaCmpivQig7Tor2
         N0w999/ahh/yQ==
Date:   Wed, 17 Aug 2022 15:55:00 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Hui Liu <hui.liu@mediatek.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jianguo.zhang@mediatek.com, zhiyong.tao@mediatek.com,
        sean.wang@mediatek.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] pinctrl: mediatek: add mt8188 driver
Message-ID: <20220817195500.d6roam5gyghburjs@notapiano>
References: <20220801095215.10876-1-hui.liu@mediatek.com>
 <20220801095215.10876-3-hui.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220801095215.10876-3-hui.liu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hui,

On Mon, Aug 01, 2022 at 05:52:15PM +0800, Hui Liu wrote:
> From: "Hui.Liu" <hui.liu@mediatek.com>
> 
> Add pinctrl driver support for MediaTek SoC mt8188.
> 
> Signed-off-by: Hui.Liu <hui.liu@mediatek.com>
> ---
[..]
> --- /dev/null
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8188.c
[..]
> +static const struct mtk_pin_field_calc mt8188_pin_mode_range[] = {
> +	PIN_FIELD(0, 177, 0x0300, 0x10, 0, 4),
> +};

Missing blank line after declaration.

> +static const struct mtk_pin_field_calc mt8188_pin_dir_range[] = {
> +	PIN_FIELD(0, 177, 0x0000, 0x10, 0, 1),
> +};

Ditto.

> +static const struct mtk_pin_field_calc mt8188_pin_di_range[] = {
> +	PIN_FIELD(0, 177, 0x0200, 0x10, 0, 1),
> +};

Ditto.

> +static const struct mtk_pin_field_calc mt8188_pin_do_range[] = {
> +	PIN_FIELD(0, 177, 0x0100, 0x10, 0, 1),
> +};

Ditto.

> +static const struct mtk_pin_field_calc mt8188_pin_smt_range[] = {
[..]
> +static const struct mtk_pin_reg_calc mt8188_reg_cals[PINCTRL_PIN_REG_MAX] = {
> +	[PINCTRL_PIN_REG_MODE]	= MTK_RANGE(mt8188_pin_mode_range),
> +	[PINCTRL_PIN_REG_DIR]	= MTK_RANGE(mt8188_pin_dir_range),
> +	[PINCTRL_PIN_REG_DI]	= MTK_RANGE(mt8188_pin_di_range),
> +	[PINCTRL_PIN_REG_DO]	= MTK_RANGE(mt8188_pin_do_range),
> +	[PINCTRL_PIN_REG_SMT]	= MTK_RANGE(mt8188_pin_smt_range),
> +	[PINCTRL_PIN_REG_IES]	= MTK_RANGE(mt8188_pin_ies_range),
> +	[PINCTRL_PIN_REG_TDSEL]	= MTK_RANGE(mt8188_pin_tdsel_range),
> +	[PINCTRL_PIN_REG_RDSEL]	= MTK_RANGE(mt8188_pin_rdsel_range),
> +	[PINCTRL_PIN_REG_PUPD]	= MTK_RANGE(mt8188_pin_pupd_range),
> +	[PINCTRL_PIN_REG_R0]	= MTK_RANGE(mt8188_pin_r0_range),
> +	[PINCTRL_PIN_REG_R1]	= MTK_RANGE(mt8188_pin_r1_range),
> +	[PINCTRL_PIN_REG_PU]	= MTK_RANGE(mt8188_pin_pu_range),
> +	[PINCTRL_PIN_REG_PD]	= MTK_RANGE(mt8188_pin_pd_range),
> +	[PINCTRL_PIN_REG_DRV]	= MTK_RANGE(mt8188_pin_drv_range),
> +	[PINCTRL_PIN_REG_DRV_ADV]	= MTK_RANGE(mt8188_pin_drv_adv_range),
> +	[PINCTRL_PIN_REG_RSEL]	= MTK_RANGE(mt8188_pin_rsel_range),

Please use just space around the = instead of tabs. Like is done on mt8183,
mt8186, mt8192 and mt8195.

> +};
[..]
> +static const struct mtk_pin_soc mt8188_data = {
> +	.reg_cal	= mt8188_reg_cals,
> +	.pins	= mtk_pins_mt8188,
> +	.npins	= ARRAY_SIZE(mtk_pins_mt8188),
> +	.ngrps	= ARRAY_SIZE(mtk_pins_mt8188),
> +	.eint_hw	= &mt8188_eint_hw,
> +	.nfuncs	= 8,
> +	.gpio_m	= 0,
> +	.base_names	= mt8188_pinctrl_register_base_name,
> +	.nbase_names	= ARRAY_SIZE(mt8188_pinctrl_register_base_name),
> +	.bias_set_combo	= mtk_pinconf_bias_set_combo,
> +	.pull_type = mt8188_pull_type,
> +	.pin_rsel = mt8188_pin_rsel_val_range,
> +	.npin_rsel = ARRAY_SIZE(mt8188_pin_rsel_val_range),
> +	.bias_get_combo	= mtk_pinconf_bias_get_combo,

Keep this one together with bias_set_combo.

> +	.drive_set	= mtk_pinconf_drive_set_rev1,
> +	.drive_get	= mtk_pinconf_drive_get_rev1,
> +	.adv_drive_set	= mtk_pinconf_adv_drive_set_raw,
> +	.adv_drive_get	= mtk_pinconf_adv_drive_get_raw,

And also use spaces instead of tabs for all entries here.

With those changes,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
